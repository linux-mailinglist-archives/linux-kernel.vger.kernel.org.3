Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C7C587493
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 01:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbiHAXyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 19:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbiHAXx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 19:53:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BDF43E60;
        Mon,  1 Aug 2022 16:53:57 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271NocJp024259;
        Mon, 1 Aug 2022 23:53:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=LJegEcUKuK0PrhxA8ekgy8QXPRWNwMkaaG5NSEiY/8s=;
 b=ijEbY76Vz8x3RA/+S3JtpRfXcCqFhtu1UasBLckbuViUJobX0sRg5r5fYeJQFdZxb5ai
 4maicUxskKPQwByLG8JYwRHnzRd1bHy/nqLNTX2vsYSYwvAJ8V3zni1El+vvowqSi1NO
 Gw8edlEX6N9RR/y98StVS+Y2bPfY2AeENewvFiK6l8ubegLMbm9Frft0zEyqf0oZR1b7
 0mEDUNF+653+kjEWK/TOggMlHiJiAUIoFz9QCQfcOjedjb6o5M0bfRG7cvDDylMrqWRS
 6oZD2FLY+wPlwZIylo/cBuLBvQslS2sc4qby8XfMoYXAxQ5mfc5oTPhU6rSVtaH8Pza1 Pw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmu80w8mn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 23:53:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 271MOIVf014225;
        Mon, 1 Aug 2022 23:53:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu31t2yf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 23:53:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ReG5HiZqLmKp2I24sT3MBq7RvoAoaX40QBDEU3iwlvxnrwhW54UTR30vSPPtvWN5WITK6wAw76RV0nYuoUNqrvy9HWVKc08eP3rT0ju32AsOqOr5i3j736OqG63RePg9tifk05aajeBLma6XPzz9fb4rryHLNEMOah58crsddsWIMsA9V9F21cRFqgakYNQ1aEpQbs4pYEhh9gNlus0SK7HuCnxF1/VUrlvR9jkGdXw/KGu+WCoA0goy6Dvi3lavHdv2Qf3NMv/k4i9QJV2IWiUXFtHJDzAaaZeBComiLIm+Fanha94336FcI39I7nO3ac2Z5qAPG4DhvJOhN1vyBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJegEcUKuK0PrhxA8ekgy8QXPRWNwMkaaG5NSEiY/8s=;
 b=d2/BivabvUbEt18kii5CANuvcMOuDDLoe8um3/iAVM7Cb/upfuZkOQdoqQgHnKDMo0MVBUgJ8eou2JuyoRf1vNIPYpM4aLm873KXDOJPVPudF35bA6xWKg3syJMETSl3ao8FUX5uc7DglkYyJDnuPS3T1boAjylP5jqG1SzaWxh3/p1R4dyTVHDCtJrM2ixY/unrBmRN+00R2BsSEk4fIebOR9dszXWdLnRwHO5gz5x0qhKCMSZIaz8FQsvzoeYLjXeZqlasABOgumtGnOS4srt6VgeGb40awGHhZqVTxbNujNQ7sWKx4ZBD9KvmX4i65RHexAFonY+TAZGPwQ0dMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJegEcUKuK0PrhxA8ekgy8QXPRWNwMkaaG5NSEiY/8s=;
 b=ST0fWdkpYzipxxdU8JxhTfJNMrI+KoE8UF6xlyPmX/YJibrqoNZl0Zry7r/ZPU2SC+mCbHwpgU7donCFK/QufE3durm0d2fhFxRqLNYwpg4rtEJlYF++f9hfOYd9zlLshXW8lwSO90qwZqQXxQeG9FfTVhsnkunaSrDucnyg9BM=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CY4PR10MB1608.namprd10.prod.outlook.com (2603:10b6:910:9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Mon, 1 Aug
 2022 23:53:50 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45%5]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 23:53:50 +0000
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: megaraid_sas: remove redundant variable cmd_type
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1pmhj34hp.fsf@ca-mkp.ca.oracle.com>
References: <20220730124509.148457-1-colin.i.king@gmail.com>
Date:   Mon, 01 Aug 2022 19:53:46 -0400
In-Reply-To: <20220730124509.148457-1-colin.i.king@gmail.com> (Colin Ian
        King's message of "Sat, 30 Jul 2022 13:45:09 +0100")
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0313.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::18) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 704f00ea-3c15-4cb0-b649-08da74191511
X-MS-TrafficTypeDiagnostic: CY4PR10MB1608:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: knrAfg3PHQnmtrI3bWja71gVQuINaX8oZy2uFGmFATM3mGTfMtTNx/XyKHXoAROOIyWUU5xPi/GSdj3vhsucWtgwYU1ofeNMeODgUsVZErJyruaJnMVOn9D+uQjrnyAvVybC2OJzR/Ip4UviQBun8wL7sMA++M5B/S9QS9InOT34MKNciOvQCVOyHA+XB/Y67MfJXp/ns47ZKh/OxGRlQiY1s2yE8ke4L2RhbRaOuCmP4+fWTp/d3vG+5CdJYfJNvSnv6tnc7383WEWm9qTOx8rHL2KIzX586CXF2lJsoTM996lGRUHfC1L3BkQ2qEuSO/bgHc3+iEkOKpZRCsoA1Wb4Yvq0NOf4AoBz5I/kwTqHr18td3/YmPdsv/lp1JalbPrGxEq49kq2+oQqVjbmbAKgfQlyMHvxjQb/GYfhUccEdLyfA7eOonAvldYd1rkzWO4sF31Id42nXv6Hcm3Ec4wRirM/KAtD0zJFf8K+qu9pcHV0QLrOD6UWw2EGsEH1EblXdCIjbthmygazpmN2DvWFmoe+hFKLuPJd6VNYwz92QLpsb5V/4Uj4qvwnvSB8+eg10UJjrWXs8zUwGrFgIN+XfdP2J453jY6mviHk/w9Bye6bEnJ2DWo9hbub+XhHPXWX+RoavRcz97bDY/UyrSiUZf4OFOu7dMGX1hS5Ba2iClVMqMMTXqyjHACUPiwOA1/RblutvNJmttHTNTPcP+SYxuCRwYOCPhckn3z5YIGUalAVCHPpoOkBgrpOZmHDnnX6969RKRmj2dNps9+/2GebpW4j/QLGGjC9VE4oNH+e6unMQ5SXw0vG+2KMPhXM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(136003)(366004)(346002)(376002)(66476007)(478600001)(66946007)(26005)(66556008)(6512007)(6666004)(36916002)(8936002)(6506007)(52116002)(186003)(41300700001)(316002)(6916009)(6486002)(4326008)(8676002)(54906003)(38350700002)(38100700002)(558084003)(86362001)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iMZvhCaRLUhxaEdbu4WPNx/Hr/COsykM30NXuxr1831YOwVogFYv+0WLO5+v?=
 =?us-ascii?Q?jjMMkCkPVKLne9UHrNb6zzHU75WH+BoimF7ePraB4VbDZ/he1gvhC23suG7Z?=
 =?us-ascii?Q?I9FsIYAsfU3NmV7wOMG6KaXasRJd59sxcQuLwcJt9ioIPyfUYG9qR01TAA03?=
 =?us-ascii?Q?d9h5tqzNWIdj8Hw0ZvbagQwhLzPkOdeRtftI8/gui91uPfXIY+/ATR94R0jT?=
 =?us-ascii?Q?0Op4GEEwrpNJTX4ncpW+4SleSd4era1wG3+r6qSOk3irXVtweRbipraebcrN?=
 =?us-ascii?Q?hHdGhVdkYtI9xh3hbWzTpxfxUFC5m0EYsQuKIc/DVzYWOO6vAjbJdlUX8c5t?=
 =?us-ascii?Q?DP3+Pjh05qJVFo/BwWF+bcC1dnFTZQ69NvkorSCbUtmI7Y5M+8zmvdSq1H4j?=
 =?us-ascii?Q?mNjgnR6ePraSgkC7rxhLj4JV+8wu/TqNL6nJfI7ie6+Hg1L08yCx4qPAU5nO?=
 =?us-ascii?Q?bADRW1wQmDBdcoOEBp+MZ78tTTEUMnitDwKdAK48Lt2BYDux6LuaiooiXfKq?=
 =?us-ascii?Q?x2zVoDb4kCIm1TuVqEZMn41Kqv4enwQtUPAMI6pHSQPAmfsOKWmM+VS9ZMNk?=
 =?us-ascii?Q?50D65Fq9GGOo1vTAe6t9WRLUfBy7bn2EQ6/JBTwt0VOIQYugHQpSvjdE+adM?=
 =?us-ascii?Q?+vQ97+I2ryXz4bhdSvbPuxpvU3oxi8Y8a0ngE2WgD0a3TLCYOnPvoyqQ8sZ6?=
 =?us-ascii?Q?g5x0NFi+ReyxO40vb5Bsh/sQdfZ8uCc88OjTaWaiOkUL1g+RLdEljitJ20mb?=
 =?us-ascii?Q?U0pKGdz1u2F40OQR9e+x8TSBzCIaJAiptOIaQDecwkNcq+9iStkp9hSFPOAI?=
 =?us-ascii?Q?IC8I53rljnP3PhnILIbwtKZUO09JQ3THv8Oh0QtToAzecrnQDwA8Qh+pbx3X?=
 =?us-ascii?Q?sZogi00RBRfl2/OzzhnWagHWQhHQR5Pz5HevIs2vBbSqMwqeLPGstAm5K5Sn?=
 =?us-ascii?Q?VUnQFHoWLwghznJLVxWoZmI94t/e65hleW87xBZO2c5ImvfZGPOTM7zlmGGt?=
 =?us-ascii?Q?3yPx3BrDn7TEaXxQ8cpLR7WeO3SqWp1NY3rYP7W9gyFoIQ/2AfAsUoR+QDsG?=
 =?us-ascii?Q?wTx1ldmozDUgcCvaSW7f470M4ESy2R3WaWf6N4fAbAPtP1Ily2bBgLRFXlyS?=
 =?us-ascii?Q?Ru2uu2bhONdMo7y20klv+c3gnnNlO995rshoCcN1mJR51dFeuPO0VcwHECny?=
 =?us-ascii?Q?2xLUmRlmxqGq5ILi0iqvQZH02+uGmYiFvTHsYwu2O5vxGX2OWhBdzYRQk80I?=
 =?us-ascii?Q?iKyzPcUqG7MqckkeGfBE5nqXHfMMqQhBBD+xZQGC8qKYX4Llw7MY1y7IT2KL?=
 =?us-ascii?Q?YfvVaw/8pWdRa8UyPl2HC2HTOcbM0vdtMBjtj6fnUCobifPp5J0f/u1U7sjW?=
 =?us-ascii?Q?R9q7iwYSYefRcSblaZwUQHP49SICVyHvgT0SwjYw+8pARDSjK+B+1Wovr+CL?=
 =?us-ascii?Q?pG2oG9xYBNJ9gn8+87bkmVEb2olG2hpOmPDgbo8x1ltRN3Do+nR0yjAh7TVX?=
 =?us-ascii?Q?Y1CSDEtkKfx8+lUbP4x/aHSwgVuMkGBfWl7+Q2+L8WONOvDJRWcYHeaXL1Yg?=
 =?us-ascii?Q?GkkAPkgiAGCIUa+L8WWy5laEcKHISVLok+Zn6EU0Lg9J8br3DlTCs+YfQkcf?=
 =?us-ascii?Q?fw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 704f00ea-3c15-4cb0-b649-08da74191511
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 23:53:50.5332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UCbrKdaHL/SXO0yogbO38fBlcGjz6dnkkE6s7pb+hltmGXtqvm7LaDuqvkXw0ZbDrHwK6mYTihlxKVRSnaHZ7MPYbWu+XR2g+fe6ANzu0/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1608
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_12,2022-08-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=944 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208010119
X-Proofpoint-ORIG-GUID: _PGpOhlzM_1ENdduUNu772KshYUIq4V-
X-Proofpoint-GUID: _PGpOhlzM_1ENdduUNu772KshYUIq4V-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> The variable cmd_type is assigned a value but it is never read. The
> variable and the assignment are redundant and can be removed.

Applied to 5.20/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
