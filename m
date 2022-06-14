Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553A054A57E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 04:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354746AbiFNCTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 22:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354655AbiFNCO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 22:14:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CBD3CA56;
        Mon, 13 Jun 2022 19:08:56 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25E0cW6n004207;
        Tue, 14 Jun 2022 02:08:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=OByn3aQU+cQZ5l/z4vu98WK5mlONlsi20gUyvnYrcJk=;
 b=PvRQLB4ZwZlZDqiKZ/jXAInfX0wJFR4nbnIyF1Qsd1vRPqF1TNLEGHjs1mL0ri/EQhiD
 XHvuQw19fEIlfZGrkH1Gpj3kgFPhJB0dGmhMupdsThihGc+Uu1nyc1QCucDgXnBvWB42
 eUiraWV4C1gCGrXtW3KGJt+Cqlh78g5mJDh7km8ynn0y3GLGwB809jl23cmeTEosiW7T
 5CfwQInt6Y6ZDl9ZiC3CY0v/WRTLJDfNe7CfnzWIrE1NSiSyJxLeqSPjwlypHLeu7UX9
 U15NOjt9/tDoADfWCXowcq6aBFJR37G1rH92NYmc3PcTxG3jVrXCOAMm/6PWtkHM4znu Xg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhu2mmtd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 02:08:35 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25E21wv2007186;
        Tue, 14 Jun 2022 02:08:35 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gph6kg2qp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 02:08:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezyGsYz33UlviJcNZfW+wxDTpjzV7y3e/DlRnYiNkNLfME4lu2/cOn+V9xwf9keVzk6KHU22K6IX8VsX9siLzNuz+VVNhMxMq8BfM+kboF0rq2OZ39H+0XRJbUDr8+12BFCjDHgfhLhboIUm2D3U7L4Jn8fuaSoUKZbwdVZrYvdgaj/HuA9gO8LGTSfthfHl99SWJ4wkNv+4niQjC1EgMsnbBI6sb1vhDFt9B7Y303zuS9b5ifqRpcKDYFjTZHBUzQl2jeolf9opK/OcGsQjlHLIo3wygpxJuTHM5KouRX05qrR+X6cxann9T3zAX1cPcYLcmEQHXf+2aj/8sIGYSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OByn3aQU+cQZ5l/z4vu98WK5mlONlsi20gUyvnYrcJk=;
 b=L6zgpETsuVkGj39D5cFb/x3pbIACejvZO3XC/TO5B0N/Lp1ka9zdArhcVSGSjblwlFvZHK9W9sS7GqTyYdjuAqUAeqii8qREWaS3zuXS1gqUtLNHquTQDMLDp5er+fNhgTExze0tdvYS5oPWYsk+tK2U74WrfecLhDbfKK4SfZPNjajWTtQtQ8245kldJvebXDPGCNc87f+1hgl5qnlK8uvuSg1z0arHI/hlLHSJ8WIKtCWbIL3lYruUg5trUeS4qVRMjKuOm5d2K/v5Ng6y/AgdA5FNPYfgvYvyhiy7Kolq9avrbHXqPchJVMFTeLFbRQsKmXSTXKRqOPkc3owlyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OByn3aQU+cQZ5l/z4vu98WK5mlONlsi20gUyvnYrcJk=;
 b=GHj8q49uwch47GNxZo7IMTjdHJCIOoTsXmiSgktqMThjks02PQPjtAG+ggBGKFqchq4Atex0LQFXO7v+yCAA13no/ydt3Qqu/utKvkI22pAa1esC3BQWWP6xAHSDPpukReEjGjyC3EiQxwnzjykr/1SsIY7BADs1h0ejKYZtT3U=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM5PR1001MB2251.namprd10.prod.outlook.com (2603:10b6:4:2e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17; Tue, 14 Jun
 2022 02:08:33 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45%5]) with mapi id 15.20.5332.020; Tue, 14 Jun 2022
 02:08:33 +0000
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     <james.smart@broadcom.com>, <dick.kennedy@broadcom.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND --next] scsi: lpfc: Use memset_startat() helper
 in lpfc_nvmet_xmt_fcp_op_cmp
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1zgigro87.fsf@ca-mkp.ca.oracle.com>
References: <20220613021851.59699-1-xiujianfeng@huawei.com>
Date:   Mon, 13 Jun 2022 22:08:30 -0400
In-Reply-To: <20220613021851.59699-1-xiujianfeng@huawei.com> (Xiu Jianfeng's
        message of "Mon, 13 Jun 2022 10:18:51 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::11) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 090cd4b4-ca44-4c71-faf7-08da4daac879
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2251:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1001MB22518547E7093D143995EC148EAA9@DM5PR1001MB2251.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VHvMCHCKhgtIUE2B1arOZZRE4854+KY59bxO4Eq560fj10Q7V6TfhRfZVHFVEArVI/Ae0aBY81w/+A/U62JvUTnpCUGIYeH3nRbSzZCmrvTD25htydMQvcdgzvam3uRO2my/FCJfOzjZaRwvHHcdXeQ3ijnPHszMG+6++kg8HpnUhFGJ1uXItqzPTA9qv3ZYcJ0OIUXEdJAl7N7XkXqzLfO3v7lcNLIFp5bqbqJeW3f5zKHmEc4t0s5eYMrx6wVPi6PNmAiDkYF5KWbyQXH8uL71HfagUn/9NSB6DuGugqrwpwnE+ohy9LfH54U9ucqVVJn/QmhV4fFLbAOXmddpWDR27/zpY3cQfnHYX+SH7sLkk79aAQZRCvM+z/LEFqbJVD5M7bqM12OQ3xOa+n6PBFSjjhCEbb5JLSW+v+3imYkM39XeHLid5r2oPjEjqpFIQYuFiufmEFmVmXqIPq3tUS84p8siqB7B2pyTu2nLQeWfmqVzgeV1CS+9AVQnt+P8rjKyNdDboXPVrpTc2O8T/KxJOs7ZMhugi8bZxJ579KVIeutld7qazBHAlIb84FfEPf6qEokkv7otmQWBzkUDjcqMJL9vPI+I3ydFxqqBrnJt3kWo7rvgcIX8EgGb+SeL37hy1DJpHRFrlbb+o6s4lGCyH0A5U1jRq91D6MGGCYz5j80ykdbn9LJAzuXz5WQR1uZAYjqX2ZzYvWp2iwTupw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(508600001)(5660300002)(4326008)(316002)(8936002)(6486002)(52116002)(66476007)(2906002)(6512007)(8676002)(86362001)(26005)(6506007)(186003)(36916002)(558084003)(38100700002)(54906003)(38350700002)(66556008)(66946007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ojMOL4zCVAz5nVWNTUQcOKwI2BQLoSP3qEJhQ5tGqdbR+5jbB8ERBU5C1Ht4?=
 =?us-ascii?Q?gYNc1OFVgP2+bXNr5CKrgk0piVZgWyPiSZiT3PJfNyraZkBqrmomyYFWUL8m?=
 =?us-ascii?Q?TJ35TNmzsYGUsrp8oPeS1rGY5bRjOfI6wIyvS2Bs5TFznw4so06o1ZqJ4H+q?=
 =?us-ascii?Q?8r3kE4C9bvaoNe8Sl1/rrn7bOlSXItZ/+dIomAXaASzIwxq+NhreYdgYGqL6?=
 =?us-ascii?Q?9P25ylpEDZPV3gjT3aa1HpQDwgPdtTyDD6CUZNVyNdGTU+LNvgLpIrDs4QZX?=
 =?us-ascii?Q?iUiTpkhMby7d/Ek/j3QaFBrY48yxFnQ5v4VOthoXW/XocHDqPBbDlWUxcruh?=
 =?us-ascii?Q?3sNFsUFUiur6fbiU8+bzqJU5bKcBQOwN8zfTmYfEmDV1CyTnB9my/8b1oAwm?=
 =?us-ascii?Q?DtimrpuAWnk1bmDV0BYOBE0+y4VyPXMdWqbrJKOGUgcO205UVDf0k4cb9o2U?=
 =?us-ascii?Q?zFh8JgH0Mppw/XGP4U5enppyUt2d+BtVyObzTyZZm9GuAs79+RAxR1EGFGru?=
 =?us-ascii?Q?vyuoaZDRBob5DwOZomfHOIuPAm10CMF+bwbkO5za+lFBDqQgtD5yS/R2mrgg?=
 =?us-ascii?Q?MUjZqD4ObH5uJ+9kqJJwH9Vbc+8CcUQ0CMpA1TO9lmRj5s3D3ifaHoiCpL/V?=
 =?us-ascii?Q?Si191KCXuDJXiz2f9183d6IFVHdYDTaxo9H4TpPwoye9+hpyEIuBTBA3coB6?=
 =?us-ascii?Q?Qi1Ddql7LNIQPcaZst7/lJHDDOY9Fr3zfaIeh5607bSSGL6tCqAv5BI/yOGc?=
 =?us-ascii?Q?UW2ZTpdr0190/THI8xKltt8jEhHWAt8/pFVZfceqjkqZZFYkw7hIfEceXxHF?=
 =?us-ascii?Q?3s5QaK5x/PXzfsb1CDqTXr8VR8Lmb9iXhNkp+mmKXxwTlJmD9StWTmRSccsH?=
 =?us-ascii?Q?HdfyjPxBE8zyL1JWLabUFol5KjnjkEo+LU9gJcY1WNQ+DC/fEEVgC1VYFhmB?=
 =?us-ascii?Q?nphTuHBwBmwsZ9xempcTT5difaWsLCZaDaYQ1QdVgKjucAPv5iI5DZ3Vc0Ta?=
 =?us-ascii?Q?VO+6ey6RNt3xPEf1oe5sAzMIoqegPSxmZyxMMc0f7op7HMQFEz0lXZK88nBd?=
 =?us-ascii?Q?c524dhF+c3mJ2z+uKDiZqXig/lIsNguAcdZ+tLAXmVesCDdfV7a6A/T2TGKw?=
 =?us-ascii?Q?IkaasE63bBUnzjoeh38LsKqk/9cr3dwKqw6u8thgBuvfbH7U2VctCeNc1oVV?=
 =?us-ascii?Q?Gnr2ubbMMz2EfjVJXyxpQ7lV5T6mwqvpD+XPB2E+7sa9ENimglmDT/bWEb2d?=
 =?us-ascii?Q?hmJUgv4/8iYzEvFKLMOBJaEjDPgbqiijIT85IpUCAOClJDhHEeRUpk85USb0?=
 =?us-ascii?Q?+WZCczy/2TBMsvbGwFnnzpOVRLGl8K3yJ76fdREAaRoruDSMABqbZsATn1Zq?=
 =?us-ascii?Q?neNOB0XUl25990b+I5W7NdWFEVW8/8oSfzHHmrHAbywU5enw62Kec4iBL0d9?=
 =?us-ascii?Q?Q/yX/BD3IlS0GPaWTBgREptykvBBjXJJMG22gd8rhEwifH1Uw7r2uwRrARDN?=
 =?us-ascii?Q?lCHtKFe3wBaCylR5xZ4LbLmozITC6w/jB7jqX37PW5Z5QdLn4KfiEMy0nOif?=
 =?us-ascii?Q?e7VUVgvBgwCuOhql3MfDiQfylGX7mbexeJdLj5J+jYy9o4dPnIlt1wx832YQ?=
 =?us-ascii?Q?7soJDZRZl95ygxSgW8yB8IVoN2/vRapo/GZlmhw5iC2SMVXLmGJPPZONN4vI?=
 =?us-ascii?Q?VrfoZ5GvGUxqEU7V6rZ9CQueZaSM56dR5DRERmgkTKPmfKgze4QvbFCYUjXG?=
 =?us-ascii?Q?wnXktOPRO41/7YvPdXq934cY0L3x3Ig=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 090cd4b4-ca44-4c71-faf7-08da4daac879
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 02:08:33.1281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ohY5YllSVb7t461FioYUsEQ1ubzj9Vnoyff+hu8bnfnekP3Ec95Se2cl2y0Heszs8hSK4AqXjKlQE1I0WINLhfe+sY64MPnTduZegCNamww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2251
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-14_01:2022-06-13,2022-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=580
 malwarescore=0 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206140007
X-Proofpoint-GUID: Vw5pceEWMx-q_tD28mJbg27M6vlB6iHb
X-Proofpoint-ORIG-GUID: Vw5pceEWMx-q_tD28mJbg27M6vlB6iHb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Xiu,

> Use memset_startat() helper to simplify the code, no functional change
> in this patch.

Applied to 5.20/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
