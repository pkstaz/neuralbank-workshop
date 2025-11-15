import { Customer, LoanApplication, LoanDecision } from "@/types/customer";

export const calculateLoanDecision = (
  customer: Customer,
  application: LoanApplication
): LoanDecision => {
  // Rule 0: High Risk Level - immediate rejection
  if (customer.nivelRiesgo.toLowerCase() === "alto") {
    return {
      approved: false,
      reason: `Your Risk Level is High. Loans cannot be approved for high-risk customers regardless of other conditions.`,
    };
  }

  const monthlyInstallment = application.loanAmount / application.installments;
  const debtToIncomeRatio = monthlyInstallment / application.monthlyIncome;

  // Rule 1: Capacity (DTI must be < 0.50)
  const rule1_approved = debtToIncomeRatio < 0.50;

  // Rule 2: Willingness (Credit Score must be > 500)
  const rule2_approved = customer.scoreCrediticio > 500;

  // If either rule fails, reject
  if (!rule1_approved) {
    return {
      approved: false,
      reason: `Your estimated Debt-to-Income ratio (${(debtToIncomeRatio * 100).toFixed(1)}%) is 50% or higher.`,
    };
  }

  if (!rule2_approved) {
    return {
      approved: false,
      reason: `Your Credit Score (${customer.scoreCrediticio}) is 500 or below.`,
    };
  }

  // Both rules passed - check risk level
  if (customer.nivelRiesgo.toLowerCase() === "bajo") {
    return {
      approved: true,
      requiresAction: true,
      reason: "Loan Pre-Approved. As a 'low risk' client, please contact a sales representative at your nearest branch to finalize your application and discuss special conditions.",
    };
  }

  return {
    approved: true,
    reason: "Congratulations! Your loan has been approved.",
  };
};
