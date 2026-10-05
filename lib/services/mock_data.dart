import '../models/researcher_member.dart';
import '../models/establishment.dart';
import '../models/enterprise_data.dart';

class InitialData {
  static List<ResearcherMember> getInitialResearchers() {
    return [
      ResearcherMember(
        id: 'member_1',
        name: 'Prof. Maria Elena Santos, Ph.D.',
        role: 'Lead Project Researcher',
        imageUrl: 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=400&q=80',
        bio: 'Economic Development & Microenterprise Research Specialist',
      ),
      ResearcherMember(
        id: 'member_2',
        name: 'Mark Lester Dimaculangan, MSc',
        role: 'Field Research Director & Data Analyst',
        imageUrl: 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=400&q=80',
        bio: 'Geospatial Mapping & Business Demographics Lead',
      ),
      ResearcherMember(
        id: 'member_3',
        name: 'Camille Joy Bautista',
        role: 'Field Enumerator & Survey Coordinator',
        imageUrl: 'https://images.unsplash.com/photo-1580489944761-15a19d654956?w=400&q=80',
        bio: 'Community Liaison & Micro-business Profiler',
      ),
      ResearcherMember(
        id: 'member_4',
        name: 'Christian Dave Morales',
        role: 'Enterprise Systems & Research Associate',
        imageUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400&q=80',
        bio: 'Statistical Data Modeler & Digital Profiling',
      ),
    ];
  }

  static List<Establishment> getInitialEstablishments() {
    return [
      Establishment(
        id: 'est_1',
        idNo: 'BC-2024-001',
        name: 'Casile Green Highlands Coffee & Agri-Farm',
        businessType: 'Agri-Business & Farming',
        natureOfOwnership: 'Sole Proprietorship',
        businessRegistrations: [
          'Barangay Business Clearance',
          'Mayor\'s Permit',
          'DTI Registration',
          'BIR Certificate (Form 2303)'
        ],
        numEmployees: 6,
        yearsOfOperation: 7.5,
        estimatedCapitalization: 350000.0,
        estimatedAnnualSales: 680000.0,
        receivedLguAssistance: true,
        lguAssistanceDetails: 'Agri-livelihood training & Seedling seedling assistance from Cabuyao City Agriculture Office',
        address: 'Purok 1, Brgy. Casile, Cabuyao City',
        contactNumber: '0917-882-1402',
      ),
      Establishment(
        id: 'est_2',
        idNo: 'BC-2024-002',
        name: 'Aling Nena Variety & Sari-Sari Store',
        businessType: 'Sari-Sari Store',
        natureOfOwnership: 'Sole Proprietorship',
        businessRegistrations: [
          'Barangay Business Clearance',
          'DTI Registration'
        ],
        numEmployees: 2,
        yearsOfOperation: 11.0,
        estimatedCapitalization: 45000.0,
        estimatedAnnualSales: 180000.0,
        receivedLguAssistance: false,
        lguAssistanceDetails: '',
        address: 'Purok 2 Main Road, Brgy. Casile, Cabuyao City',
        contactNumber: '0928-112-9843',
      ),
      Establishment(
        id: 'est_3',
        idNo: 'BC-2024-003',
        name: 'Kanto Casile Eatery & Bulalohan',
        businessType: 'Food & Beverage / Restaurant',
        natureOfOwnership: 'Sole Proprietorship',
        businessRegistrations: [
          'Barangay Business Clearance',
          'Mayor\'s Permit',
          'Sanitary Permit',
          'BIR Certificate (Form 2303)'
        ],
        numEmployees: 4,
        yearsOfOperation: 4.2,
        estimatedCapitalization: 120000.0,
        estimatedAnnualSales: 420000.0,
        receivedLguAssistance: true,
        lguAssistanceDetails: 'Food Safety & Handling Seminar by Cabuyao City Health & LEDIPO',
        address: 'Purok 3 Junction, Brgy. Casile, Cabuyao City',
        contactNumber: '0939-555-6671',
      ),
      Establishment(
        id: 'est_4',
        idNo: 'BC-2024-004',
        name: 'Upland Riders Motor Parts & Service Shop',
        businessType: 'Automotive & Motorcycle Repair',
        natureOfOwnership: 'Sole Proprietorship',
        businessRegistrations: [
          'Barangay Business Clearance',
          'DTI Registration'
        ],
        numEmployees: 3,
        yearsOfOperation: 3.0,
        estimatedCapitalization: 95000.0,
        estimatedAnnualSales: 290000.0,
        receivedLguAssistance: false,
        lguAssistanceDetails: '',
        address: 'Purok 2, Brgy. Casile, Cabuyao City',
        contactNumber: '0919-444-2210',
      ),
      Establishment(
        id: 'est_5',
        idNo: 'BC-2024-005',
        name: 'Casile Multi-Purpose Farmers Cooperative Store',
        businessType: 'Cooperative / Agri-Trading',
        natureOfOwnership: 'Cooperative',
        businessRegistrations: [
          'CDA (Cooperative Development Authority)',
          'Mayor\'s Permit',
          'BIR Certificate (Form 2303)',
          'Barangay Business Clearance'
        ],
        numEmployees: 8,
        yearsOfOperation: 9.0,
        estimatedCapitalization: 750000.0,
        estimatedAnnualSales: 1450000.0,
        receivedLguAssistance: true,
        lguAssistanceDetails: 'LGU Financial grant for tractor equipment access & cooperative development seminar',
        address: 'Purok 1 Center, Brgy. Casile, Cabuyao City',
        contactNumber: '0918-990-3341',
      ),
      Establishment(
        id: 'est_6',
        idNo: 'BC-2024-006',
        name: 'Mang Kanor Fresh Pineapple & Fruit Stand',
        businessType: 'Agri-Product Retail',
        natureOfOwnership: 'Sole Proprietorship',
        businessRegistrations: [
          'Barangay Business Clearance'
        ],
        numEmployees: 1,
        yearsOfOperation: 5.5,
        estimatedCapitalization: 18000.0,
        estimatedAnnualSales: 96000.0,
        receivedLguAssistance: false,
        lguAssistanceDetails: '',
        address: 'Highway Ridge, Brgy. Casile, Cabuyao City',
        contactNumber: '0927-332-9011',
      ),
      Establishment(
        id: 'est_7',
        idNo: 'BC-2024-007',
        name: 'Heights Bakery & Delicacies',
        businessType: 'Bakery & Food Processing',
        natureOfOwnership: 'Partnership',
        businessRegistrations: [
          'Barangay Business Clearance',
          'DTI Registration',
          'Mayor\'s Permit',
          'Sanitary Permit'
        ],
        numEmployees: 4,
        yearsOfOperation: 2.8,
        estimatedCapitalization: 160000.0,
        estimatedAnnualSales: 380000.0,
        receivedLguAssistance: true,
        lguAssistanceDetails: 'DTI-LGU Negosyo Center Product Packaging & Labeling Assistance',
        address: 'Purok 4, Brgy. Casile, Cabuyao City',
        contactNumber: '0915-776-4321',
      ),
      Establishment(
        id: 'est_8',
        idNo: 'BC-2024-008',
        name: 'Casile Water Refilling Station',
        businessType: 'Water Refilling / Utility',
        natureOfOwnership: 'Sole Proprietorship',
        businessRegistrations: [
          'Barangay Business Clearance',
          'Mayor\'s Permit',
          'DTI Registration',
          'Sanitary & Water Quality Clearance'
        ],
        numEmployees: 3,
        yearsOfOperation: 6.0,
        estimatedCapitalization: 220000.0,
        estimatedAnnualSales: 410000.0,
        receivedLguAssistance: false,
        lguAssistanceDetails: '',
        address: 'Purok 3, Brgy. Casile, Cabuyao City',
        contactNumber: '0920-887-5544',
      ),
      Establishment(
        id: 'est_9',
        idNo: 'BC-2024-009',
        name: 'Maricel Beauty Salon & Barber Care',
        businessType: 'Personal Care & Services',
        natureOfOwnership: 'Sole Proprietorship',
        businessRegistrations: [
          'Barangay Business Clearance',
          'DTI Registration'
        ],
        numEmployees: 2,
        yearsOfOperation: 3.5,
        estimatedCapitalization: 35000.0,
        estimatedAnnualSales: 130000.0,
        receivedLguAssistance: false,
        lguAssistanceDetails: '',
        address: 'Purok 2, Brgy. Casile, Cabuyao City',
        contactNumber: '0935-123-8899',
      ),
      Establishment(
        id: 'est_10',
        idNo: 'BC-2024-010',
        name: 'Casile Construction Supplies & Hardware',
        businessType: 'Wholesale & Hardware Retail',
        natureOfOwnership: 'Partnership',
        businessRegistrations: [
          'Barangay Business Clearance',
          'Mayor\'s Permit',
          'DTI Registration',
          'BIR Certificate (Form 2303)'
        ],
        numEmployees: 5,
        yearsOfOperation: 8.0,
        estimatedCapitalization: 520000.0,
        estimatedAnnualSales: 1100000.0,
        receivedLguAssistance: true,
        lguAssistanceDetails: 'City Business Facilitation & Tax Incentive Orientation',
        address: 'Purok 1 Access Road, Brgy. Casile, Cabuyao City',
        contactNumber: '0917-331-4477',
      ),
    ];
  }

  static EnterpriseDashboardSummary getInitialDashboardSummary() {
    return EnterpriseDashboardSummary(
      totalEnterprises: 148,
      registeredBusinesses: 94,
      receivedLguAssistance: 41,
      mainBusinessType: 'Sari-Sari Stores & Micro-Retail (42%)',
      businessTypes: {
        'Sari-Sari & Neighborhood Stores': 62,
        'Agri-Business & Farming': 31,
        'Food & Eatery / Carinderia': 24,
        'Services (Repairs, Salon, Laundry)': 14,
        'Wholesale / Construction Supplies': 9,
        'Food Processing & Bakeries': 8,
      },
      natureOfOwnership: {
        'Sole Proprietorship': 128,
        'Partnership': 11,
        'Cooperative': 6,
        'Corporation': 3,
      },
      employeeDistribution: {
        '1 - 2 Workers (Family-operated)': 96,
        '3 - 5 Workers': 37,
        '6 - 9 Workers': 11,
        '10+ Workers': 4,
      },
      yearsOfOperation: {
        'Less than 1 Year': 18,
        '1 to 3 Years': 44,
        '4 to 6 Years': 46,
        '7 to 10 Years': 26,
        'More than 10 Years': 14,
      },
      capitalizationDistribution: {
        'Below ₱20,000': 52,
        '₱20,000 - ₱50,000': 41,
        '₱50,001 - ₱150,000': 29,
        '₱150,001 - ₱500,000': 18,
        'Above ₱500,000': 8,
      },
      annualSalesDistribution: {
        'Below ₱50,000': 34,
        '₱50,000 - ₱150,000': 53,
        '₱150,001 - ₱500,000': 38,
        '₱500,001 - ₱1,000,000': 16,
        'Above ₱1,000,000': 7,
      },
      businessRegistrations: {
        'Barangay Business Clearance': 112,
        'DTI Business Name': 94,
        'Mayor\'s / Business Permit': 58,
        'BIR Official Registration': 46,
        'Sanitary Permit': 39,
        'Cooperative (CDA) / SEC': 9,
      },
    );
  }

  static BusinessSupportData getInitialSupportData() {
    return BusinessSupportData(
      overallNeeds: [
        SupportNeedItem(
          title: 'Access to Low-Interest Capital & Financing',
          count: 118,
          percentage: 79.7,
          description: 'Working capital to replenish inventory, acquire farming equipment, and weather seasonal demand fluctuations.',
        ),
        SupportNeedItem(
          title: 'Marketing & Digital Promotion Exposure',
          count: 96,
          percentage: 64.9,
          description: 'Expanding customer reach beyond the local sitio through social media marketing, local tourism tie-ups, and Cabuyao city exhibits.',
        ),
        SupportNeedItem(
          title: 'Business Management & Bookkeeping Training',
          count: 88,
          percentage: 59.5,
          description: 'Need for fundamental accounting, inventory recording, cash flow budgeting, and financial separation of household and business funds.',
        ),
        SupportNeedItem(
          title: 'Product Packaging, Labeling & FDA/Sanitary Compliance',
          count: 67,
          percentage: 45.3,
          description: 'Assistance in elevating local coffee, honey, pineapple delicacies, and baked items to meet commercial retail packaging standards.',
        ),
        SupportNeedItem(
          title: 'Local Government Business Permitting Streamlining',
          count: 54,
          percentage: 36.5,
          description: 'Simplified, decentralized or barangay-level one-stop-shop processing for renewal and official registration.',
        ),
      ],
      accessToFinancing: [
        SupportNeedItem(
          title: 'Microfinance Loans with Flexible Terms',
          count: 104,
          percentage: 70.3,
          description: 'Low-interest credit lines without requiring real estate collateral or steep monthly amortization.',
        ),
        SupportNeedItem(
          title: 'LGU / Government Livelihood Seed Grants',
          count: 82,
          percentage: 55.4,
          description: 'Direct starter equipment or capital grants for qualified microenterprises and agricultural producers.',
        ),
        SupportNeedItem(
          title: 'Credit Guarantee & Formal Banking Onboarding',
          count: 69,
          percentage: 46.6,
          description: 'Assistance in building bankable financial statements and connecting with LandBank, DBP, and DTI SB Corp.',
        ),
        SupportNeedItem(
          title: 'Emergency Relief & Weather Resiliency Fund',
          count: 51,
          percentage: 34.5,
          description: 'Protection from typhoon damage and agricultural harvest disruptions in the upland terrain.',
        ),
      ],
      marketingAndDigitalPromotion: [
        SupportNeedItem(
          title: 'Social Media & Facebook Business Page Training',
          count: 92,
          percentage: 62.2,
          description: 'Step-by-step guidance on creating professional content, accepting GCash/Maya, and communicating with customers online.',
        ),
        SupportNeedItem(
          title: 'Inclusion in Cabuyao Agri-Tourism & City Trade Fairs',
          count: 78,
          percentage: 52.7,
          description: 'Free or subsidized exhibition booths during City Fiesta, Paskuhan, and Laguna provincial trade fairs.',
        ),
        SupportNeedItem(
          title: 'Branding, Logo Design & Signage Assistance',
          count: 71,
          percentage: 48.0,
          description: 'Assistance in establishing clear roadside signages, brand identity, and attractive store displays along the ridge route.',
        ),
        SupportNeedItem(
          title: 'E-Commerce & Food Delivery Logistics Linkage',
          count: 49,
          percentage: 33.1,
          description: 'Integration with courier and delivery platforms to cater to consumers from Cabuyao lowland and Canlubang.',
        ),
      ],
      businessManagementAndTraining: [
        SupportNeedItem(
          title: 'Basic Cash Flow & Bookkeeping Workshop',
          count: 95,
          percentage: 64.2,
          description: 'Hands-on training using simple ledgers or mobile apps to track daily sales, expenses, and gross margins.',
        ),
        SupportNeedItem(
          title: 'Pricing, Costing & Margin Computation',
          count: 84,
          percentage: 56.8,
          description: 'Determining exact ingredient and operational costs to prevent operating at hidden losses.',
        ),
        SupportNeedItem(
          title: 'Inventory Control & Waste Minimization',
          count: 73,
          percentage: 49.3,
          description: 'Managing perishable agricultural produce, shelf life of retail items, and fast-moving stock replenishment.',
        ),
        SupportNeedItem(
          title: 'Customer Service & Client Relationship Building',
          count: 61,
          percentage: 41.2,
          description: 'Techniques for building customer loyalty and handling repeat tourists and local residents.',
        ),
      ],
    );
  }

  static BusinessChallengesData getInitialChallengesData() {
    return BusinessChallengesData(
      financingChallenges: [
        SupportNeedItem(
          title: 'High Interest Rates from Informal Lenders (5-6 Scheme)',
          count: 98,
          percentage: 66.2,
          description: 'Over-reliance on informal daily/monthly money lenders due to lack of immediate access to formal bank credit.',
        ),
        SupportNeedItem(
          title: 'Stringent Documentary Requirements by Formal Financial Institutions',
          count: 89,
          percentage: 60.1,
          description: 'Requirements for audited ITRs, financial statements, and business permits that microenterprises cannot produce.',
        ),
        SupportNeedItem(
          title: 'Lack of Real Estate or Physical Collateral',
          count: 84,
          percentage: 56.8,
          description: 'Most owners do not have titled land or mortgagable assets to secure commercial bank loans.',
        ),
        SupportNeedItem(
          title: 'Absence of Formal Credit History / Bank Accounts',
          count: 65,
          percentage: 43.9,
          description: 'Operating on unbanked pure-cash transactions prevents scoring in credit bureau databases.',
        ),
        SupportNeedItem(
          title: 'Complicated and Lengthy Loan Approval Timelines',
          count: 57,
          percentage: 38.5,
          description: 'Emergency inventory or farm input funds are needed immediately, whereas bank loans take weeks or months.',
        ),
      ],
      otherChallenges: [
        SupportNeedItem(
          title: 'Rising Wholesale Prices and Inflation on Goods',
          count: 103,
          percentage: 69.6,
          description: 'Steep increases in supplier prices squeeze margins, as upland residents resist price hikes.',
        ),
        SupportNeedItem(
          title: 'High Transportation and Logistics Costs to Upland Casile',
          count: 86,
          percentage: 58.1,
          description: 'Steep terrain and distance from city proper make restocking freight costlier than lowland barangays.',
        ),
        SupportNeedItem(
          title: 'Fierce Neighborhood Competition among Similar Micro-Stores',
          count: 76,
          percentage: 51.4,
          description: 'High concentration of sari-sari stores in the same puroks with identical inventories.',
        ),
        SupportNeedItem(
          title: 'Weather Vulnerability & Seasonal Fluctuations in Farming',
          count: 68,
          percentage: 45.9,
          description: 'Heavy rains or prolonged dry spells directly impact harvest yields and local consumer purchasing power.',
        ),
      ],
    );
  }
}
