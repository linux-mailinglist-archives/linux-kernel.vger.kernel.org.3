Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2B75741B5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 05:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbiGNDCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 23:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiGNDCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 23:02:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BDE222BC;
        Wed, 13 Jul 2022 20:02:40 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26E06S6t009860;
        Thu, 14 Jul 2022 03:02:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=68tXiYE8S3pKhN/ou7qtIq/zx1Evj29cUpTPe/q3Ti0=;
 b=PThq6kqu1oJC7k9MmEodihK6tfkIku0jtaVyjCwlLNTmZoqtY8/8VPSgzMu5gH2V57qO
 CaJO/4+irUuFGMd/Gnwqa0WIkqerqCnMmj1iR+UKOqLlI1I9NYc+GagMljUfgHlY4lIO
 zwHP48zEzVkJ2yD1RVye82e3m06+7LwTD9+SOLRx2X828Hw0s6ZnO21z+X63JoVyOhCo
 JMXDhn0NItogaLVNf1FBFKQrTutz44rtAC9/CkbB/9GthpxYR1ayRJe8yCAG4AOTTJuK
 ovWECtqQFh+eYl8fsW5gN3iUTVt3MLwZ9fL+7wf/GbwAPIytSbnFAdrX0WpHnyodo4nP xg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71r1bfes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 03:02:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26E31d7P006408;
        Thu, 14 Jul 2022 03:02:24 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h7045g6ej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 03:02:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Owa614mDLWdqIuYSg3Fw56yrqdzCKahwSVFVIyzUkf2GihYZfxTO6NyHGdnBfOn+MASRMSUpX2DPYSxpR2nfiG/IMisElZ85Tm0e9LGAmd46E0Htq25uebVnsa7iwpyk8Sm4fhATvN12UJmTQfbqQQJfF+wJGoF4V9vhFheLniZaimAeYHm1MNcVWQ4y4p+NRASUXgATADpEMVyDEbWRQCmc2iLdOQ8nb1VFQr3EUhIkJ89CEIUXRaDxVyjmp65u8hni1EjzUutvk6iwGEHHoDh0kVk2MHEwG5pgw6uNi5yvZaLp99laIQrNuclJG47ib6gSjHSzQDW95LhtyuoeEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68tXiYE8S3pKhN/ou7qtIq/zx1Evj29cUpTPe/q3Ti0=;
 b=AHPnjE752pE2Vw9yU6b/TbJpJjZSl2C97vNxq3dzNukcRJWKwv02xjHq4LP1UGFat4v/YyMntAv/W43Hqx5RCW2QXvCN0Tv+Yy3d4COtUszD0y4NHRrW5erZaMwZMYaDo/wSgTWKcEftWVDNA/h4SqkPs5q4DozE157dnTxQKTvB+/no/9t1TB+wJjkN22MGLs669v5/+/iK5J2+4H+QyPXGuZDrGPRD+WXdUkxHj62OchMjQl19zuNZgcn04B9oxSOCzovqeQpkzoa74XRlCT2Z9s/kwq3myuAQVCpd6C6qojjVuyAL1KN7OVAekmmbkT5zTYSLOJE2ZQRz3d+pXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68tXiYE8S3pKhN/ou7qtIq/zx1Evj29cUpTPe/q3Ti0=;
 b=IbvocWtRBty+NT8nm6ODtq2zvG4cuQv1dyPWzm/GS4xZ4+UgCHJn/HoBNJWR4qg89GNCF5z4yK2kRo1kpfkwun07ne4H9Fa76z5IC7moDmKO5gRTHuW++hA8jvj6b+c5zWhNu/ziliirMVja26Df8bzyz3y6pwjA9k9q8y//73g=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BN0PR10MB4949.namprd10.prod.outlook.com (2603:10b6:408:12b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Thu, 14 Jul
 2022 03:02:22 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45%6]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 03:02:22 +0000
To:     Keoseong Park <keosung.park@samsung.com>
Cc:     ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        Daejun Park <daejun7.park@samsung.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: ufs: core: Remove UIC_HIBERN8_ENTER_RETRIES
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1cze8xuq5.fsf@ca-mkp.ca.oracle.com>
References: <CGME20220708052006epcms2p2d1129dbf95fd77f46906200ccb0a9ccd@epcms2p2>
        <20220708052006epcms2p2d1129dbf95fd77f46906200ccb0a9ccd@epcms2p2>
Date:   Wed, 13 Jul 2022 23:02:18 -0400
In-Reply-To: <20220708052006epcms2p2d1129dbf95fd77f46906200ccb0a9ccd@epcms2p2>
        (Keoseong Park's message of "Fri, 08 Jul 2022 14:20:06 +0900")
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0040.namprd04.prod.outlook.com
 (2603:10b6:806:120::15) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73110100-56e4-4eeb-fdf5-08da65454582
X-MS-TrafficTypeDiagnostic: BN0PR10MB4949:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QDkwsCkhCAJaPyYr3hVYw7sfNr+gygVYVc0AwI2Q9rCY19AzCJXR/PvUUVfJJVvzM0LFv82LTfu/Sj/XyPa7YSloSTbuTqctKqBcwv6gBSGjPaGpxZMbuklkAR/wUO5nMQZN6NvCDkamZtUQHT2uk6ZJoRcsdzfijHWqrndg9v89sh/thFbxDW5fcC/ahXxi+gOmloddbrRXg9vhIMg8RrkTiwI6R4UjxA/DoHL+RNHt9wbUHz0UwZkDN6WkqcEqrtApLtrXMvEoQAils9USRRNdPrMYTFoksyjqQswgmZI95h7L5elfVgs9kVKr2w3naD+OcJE9UWI+Sgon/pCKo4rgM/+aePw7pOEA6g+gDkKfAxgLb5E97xhnxQu0fJ3t19/pGEJ5wVpOFiZJQ9YDto8oeMaptv3SzLe1dc6V36EodAoE3FYV0nsDvZmfXwbktqVz3t4FNz09HK3ciC7viX4SMd96DuuPBo+QtDReq9R0A5l7aWWrEl+rH8Ex5NGFKC7pBLb7W0zkbvL87WreqJBFss6orghgHqgwsPwbERgvFn6t90i9sBIY8z/hccLvwMns6PtycQBot3EawCvd9Q/lZz+FJB0Sh8IDr2bGefSUs+JRzZK1WZVB4NckCTGlqU++WPFcNMOKqqkhS382U6l17MCmqMXxQYFMb7IVhiW1fNgazhNslX1F1xwU1xWjxi8q3up6gM9RhRDNqJwVLjA74MwIB6x0F/GphZ+96/+iW6PcSGlQqpDq8haOxACwNskF/zYWh0VLHlSlkMEXP9JiglUn5MCy5/c2i+60vnYXRn3mPkXPlSmRfDvi8Fok
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(396003)(376002)(346002)(136003)(38350700002)(316002)(8936002)(7416002)(5660300002)(38100700002)(4326008)(2906002)(186003)(66556008)(6666004)(66476007)(36916002)(6512007)(54906003)(558084003)(6916009)(52116002)(6506007)(66946007)(26005)(86362001)(41300700001)(478600001)(8676002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kCvXl9G+V/oCU9eeJQsQUifwdK0fpcTrVzitssg0SVThyMuBWGdDpvxfDCyh?=
 =?us-ascii?Q?Gn+aaix85Fsg5KAfyLiDzMoLjW1n9Sh92MPUPJTFwNdJp2T+0uSLhc4dqJGl?=
 =?us-ascii?Q?vr8v4qHQFbmAEDTLCE4/mfKDjsKRX1dYwKR8ZrcKofkeGjGG/jKzI9FEOvRm?=
 =?us-ascii?Q?/GhKotObt5L2vzGwz3RSDfrWkzYFK6msKu85upXpFZ1osRyXB/5L6xJ2ryIz?=
 =?us-ascii?Q?cPQ2hbSerJ0+otrAwdsHgsdnnv5wLeF2GpWiHmserbmqHMm36NVBwVRyjMGD?=
 =?us-ascii?Q?Y3iuydSjNLxERXSAXk25/1Y0DoqmQOfpCVxsp9fngI5ZS+mlL8/75i3tGlLK?=
 =?us-ascii?Q?oaYDEGM1Hhd8fR2gVz37KMEMYktbKrf9ix2LgeCQIKnWxQDL2Aty5VzhM329?=
 =?us-ascii?Q?QABusB3uHPHBLBb7/PvrCUR7kZzaXn2UcjpTMkU+phf6fvhkTbEqDOkrQpB9?=
 =?us-ascii?Q?Q7furKgLbz+vIgBcNkbjTlbzgHiCqyHLIxgk65z04B5M5LlS0/X7Lk5FvEcx?=
 =?us-ascii?Q?rqDK0WfGU5a3l+XOkjYWQ7JZxjiS7fIyf/M5a5zOi3cOsgn3NuG//qvmViGH?=
 =?us-ascii?Q?JI6h9Dcm3nt3BsblwZGlFLvr+Sty8LdMKP2lcrkgCU1hy25G/6mnXUjuDM+D?=
 =?us-ascii?Q?22aVyCK49tH7k0k01VuCRwV/FPboG7EbC7I2PFrieZwV3m8yzasivqlcz5j3?=
 =?us-ascii?Q?ItIkEWy53q5BMPw5HPmaw3D4bloHCkcXonw4n8xocMfG8pldN6qsUVuJBtcz?=
 =?us-ascii?Q?GipYf++t3k6k9LJ0avRm4prLlooq6BqNx4ywp/oc7F9+cyUzn0Zh7cwo3yb4?=
 =?us-ascii?Q?xF3LeaBQwTsHjGO9KaETDK9O+krVQDOOUDMlj8Fnv3LSJNNpJzq6DUWGg8Q6?=
 =?us-ascii?Q?oNPCj1dMp08gMvfoXTW+ITHeWzOu6t04beue6IqY6WqIXJ/Jg8WRBR1c13+t?=
 =?us-ascii?Q?wz8p3nynrpl9BEN+a++doUqVL3uMAcfLNyJlK0BliP5v7Za2W7mVoeNkmrxS?=
 =?us-ascii?Q?gaK6A1BKUx2Mv8asAUj1BpKq/LficjCdf63zVncQJ2Zu4D8n/ayF0L1bqRo2?=
 =?us-ascii?Q?Megx5+CDjvIMQzixnTJoBEjuYRHsa+dm3lKyFu1JS2ar2uqX5dQs+dRXq7r6?=
 =?us-ascii?Q?z+Jw391d8+l7XTWZJrju0AQHgIbhyUxMjQc/+LjeLKkHo/h5nBW1SqRqblUT?=
 =?us-ascii?Q?IFU6B+uuhuNcKxL6dasdqazTvSXwo1IzrChHADOVGnhO7+JmVDRcMk+LGCwb?=
 =?us-ascii?Q?BTMk5ru7j53xOOmEyFiqUACni3H1f9qXGW6w0OqN40v1702CI5DCpr8Vym7W?=
 =?us-ascii?Q?h3dQ8vAton9kpfsMsx2UT2TYfN64jsAeRVTW91QeUO/nMbBJZ07O6AtnKZCO?=
 =?us-ascii?Q?12NaIGLMHWYrMyELVhjFPZ3xxGrrAPwD5PdGdJcdyX0M7CED0RDXe04sGTXC?=
 =?us-ascii?Q?rYU4KmNpBHY7g3aZyIDGHSxr2QIiV0DwqmqHgfWke0QL+FEuXl4UdCxK+Kjr?=
 =?us-ascii?Q?joYpFvw4RS04CX0m2zAWuV6N2LKHCYWXhjDpaAaIR5d70igV2YmZVfCWoU8z?=
 =?us-ascii?Q?7A7elU1TKieiOqwK2kaWN+jrxILyZXkLd6BK6bZuITSKG7u5E4V1zMBBzvCy?=
 =?us-ascii?Q?Qg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73110100-56e4-4eeb-fdf5-08da65454582
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 03:02:22.1408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3slQaIaHwz37eufvO6AKKTb64fWMLp1hIbVfv2+JOvvJc1WXJB9fWujOn57x/6p4iCo+nf9XRzF9VoDFuzEbyvBippwf4Pe9OLN1VDSyTaU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4949
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-14_02:2022-07-13,2022-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=741 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207140012
X-Proofpoint-ORIG-GUID: wcaGMQryguaL8mD5JKMCilIJk9xiPPVd
X-Proofpoint-GUID: wcaGMQryguaL8mD5JKMCilIJk9xiPPVd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Keoseong,

> Commit 4db7a2360597 ("scsi: ufs: Fix concurrency of error handler and
> other error recovery paths") removed all callers of
> UIC_HIBERN8_ENTER_RETRIES. Hence also remove the macro itself.

Applied to 5.20/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
