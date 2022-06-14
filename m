Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078BC54A3C3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 03:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239729AbiFNBqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 21:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237175AbiFNBq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 21:46:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9D82A736
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 18:46:22 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25E0sSE9004107;
        Tue, 14 Jun 2022 01:46:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=KBkbm0x7ur10Bxu0RvV6G3Gkal7aGAhApFXAMvrIm0Q=;
 b=IxU42weD4+TmZbsMFnZY5aEHm4VLPxvPSALYVvz1xt/jCzuuMMg7s+kQiEDUybNQ94W1
 iTY8NiiKh9WLxdkdHpVF8G0MmuA+pJvPq3W3OpK1OXWK6doX8AH7YBYZF3RS6jR1NKkW
 Yon36IwvSBYRTsElxpO9QFkB8prcar+YDkR4EqL15AjOOB+OzDVzYuHuk5Oj9mw3APEn
 +TU+I+HZtpiZWNTH2Iocs+/QhPlgDLtOKQzvLQoNxRglW41T2Lj3NkknU5a6Cwe2wRgw
 kcl+dlcsV5pWUSGLX4+4YXjmtXnPqshb/CClRRtQ3Wa7r9uSwK0IQqI4lgJ8CMJx7Top uw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhu2mm12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 01:46:13 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25E1aASe036041;
        Tue, 14 Jun 2022 01:46:12 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpgfeggp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 01:46:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CoS41vocGu3X5ajUyUP9fVs8ZRjgiNDDYLFWALbF7D5HYseDpoG5Rj6BxzPGJ5pW/X7iOY763h7u88eC0g0z5XH0+X+SiGjHAYGHq3yO/s32bs4HccgU+3lQTywheKGfR+xJdvN+a/dYeDJozZoYGqbdnb1bdAmXl2iEt0QMCd48EVsTiTDxabkTssomfq7eEzcoggXlkvVR6z/dc+4UMZFEy6DQnfrmy7LfWsDzWTEq6y4yU3pn82qq+L76sEEYYfe5UQYvGSLh2EGsHB1bFZAf2i9mrEKlKLrZnZDpJfhisdXDHxu86Bs1T0pPjwnhALK231mowP8B3f51ZD1rQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBkbm0x7ur10Bxu0RvV6G3Gkal7aGAhApFXAMvrIm0Q=;
 b=oAwyS+9L4iZxRnWZAiYHka57LHHFwgugpO41kLMTsnQav2g9xLBuDVAiuwYL9pPgrmcI3TX/vSoUrVK4IbWZ4ZnwRlbqe1EqDyfp62wjufAqXSoIjDC7Zq9X5ErL7PomCIkMz0rAHuyy7mMgohnJCNg2ZKaYEWwVwHWMkbbdEKligrKTfnLAiMN8q38qPG8+GeLjMzN0lwf5e3q4UWkZcy91tgfDFO45VD0WbK8/e+4NrhOx9L9ehcN/n3izRcKm8Rclr6Gn7gAvaMPn0hdmCucevKyZk0DzUqF0L9R6QaWr3krqfIUETmbby04C+HpxybBWRbcBwXmR8k/0HxjanA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBkbm0x7ur10Bxu0RvV6G3Gkal7aGAhApFXAMvrIm0Q=;
 b=xnsnXJPpc0geb983xvP03vkR1gk3zhgaG3fnjvg2Cuhimn678Dfwv0+0yj3Qz7x1bv+CqC6wtQs6pJ4jc5auVcurHb5mbI2bEZXtF/qd88be9fSlC4zvD2PuEOSLVuR7Sw6TS2mIgJDC85IaPWMapaIuQ5ofEp2b9zQC55emJ/U=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MN2PR10MB3550.namprd10.prod.outlook.com (2603:10b6:208:113::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Tue, 14 Jun
 2022 01:45:24 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45%5]) with mapi id 15.20.5332.020; Tue, 14 Jun 2022
 01:45:24 +0000
To:     "Alim Akhtar" <alim.akhtar@samsung.com>
Cc:     "'kernel test robot'" <lkp@intel.com>, <llvm@lists.linux.dev>,
        <kbuild-all@lists.01.org>, <linux-kernel@vger.kernel.org>,
        "'Martin K. Petersen'" <martin.petersen@oracle.com>,
        "'Chanho Park'" <chanho61.park@samsung.com>,
        "'Bharat Uppal'" <bharat.uppal@samsung.com>
Subject: Re: [mkp-scsi:for-next 31/41]
 drivers/phy/samsung/phy-fsd-ufs.c:50:3: error: field designator 'cfgs'
 does not refer to any field in type 'const struct
 samsung_ufs_phy_drvdata'; did you mean 'cfg'?
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1mtegt3ym.fsf@ca-mkp.ca.oracle.com>
References: <CGME20220611233355epcas5p1970bae9647eae17e20d330775b584695@epcas5p1.samsung.com>
        <202206120755.03gKC0ne-lkp@intel.com>
        <000001d87e12$c6962770$53c27650$@samsung.com>
Date:   Mon, 13 Jun 2022 21:45:22 -0400
In-Reply-To: <000001d87e12$c6962770$53c27650$@samsung.com> (Alim Akhtar's
        message of "Sun, 12 Jun 2022 09:43:29 +0530")
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0168.namprd13.prod.outlook.com
 (2603:10b6:806:28::23) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c51a80e-f904-4a9e-d982-08da4da78cd4
X-MS-TrafficTypeDiagnostic: MN2PR10MB3550:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB3550FB5945961520C1B9C4778EAA9@MN2PR10MB3550.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mlZrq8126n5mWPBweatZfCuhEqPD92qpp+Xa1mu25PzW0SJ1p297ZZItxtTaCAWiVTxmtc1dQEfIUKclRmS1mZCtaah5NtlcmskRq0lwFzAJeI6xUCoJ0piebCNc1y+dO97Y4Y4LC8vdQg/zOzLl+uZJbgXM89PH0Ob5QTUlM8EUiUUThnX5RamGezk0s8mfEiYO2OCqc+ZWK9x4e6aBztBUJTzsMIM8LZILn9pwExv81B470DME603LVsUURBJtmCIViy+UuzmkEoSQjQpSGHnBd8Nlp5omTH129FQIfVeHYE4nuIQKPF3zu7dCSvCk1Ct4XBGr2n27mdkEzKm1b6oC14qC75+nwHR3qyRNbWu5dJTySvn/OWNpSVm+YslPEpOYsTLTsigSHb8yBz93cI/tR7DAfQwXAy0fbzc6khHWZrLuI6gpjQjLRcydgU4zRxRiIDvgDdPwahMZ4RykKTQ+40krgk7Q+445y4VMyzgBNkI10i46hGSrWMTfGAYyqbVu05GFDgGRlYxLUBYpAoAPfqi0VJQ/A5XF6YwQWsMIPWYWPGAAcaZ6bsm7yBccBwn2IAlM4jtxmv7UgkoCGWw8C3lJniX8rNpC44peYSYgwqyc0lWPqIF/T8Az5BaiWX+oFxvMOhx5QfHjJSHs15+hQucZDuf3xMFETRF6g0k/TrK7D9KTHqLOT1XzDjHygXYd8xj7xo4HhepzkSoDDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(4326008)(8676002)(66946007)(66476007)(66556008)(86362001)(54906003)(508600001)(5660300002)(8936002)(6486002)(6916009)(4744005)(6512007)(36916002)(52116002)(2906002)(6506007)(26005)(186003)(83380400001)(38350700002)(316002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?udfEQ3WO1HS7YwU1xWeaBizvZ0xv7l2IJ4qWcCP/L29hHbKctSHNoqzhAiv5?=
 =?us-ascii?Q?Th2B0mQFth3BYJXXw8V/SillLENWar9YE0m7EAyNmcJWgNsvMeRgnn7B8ko7?=
 =?us-ascii?Q?7lBbMcW3vBTKgPj+xlCXTGgDORCQWQoUxbXkyf2i9KouAeD29G7FVtsjq+GY?=
 =?us-ascii?Q?YbTczwFxtlTDa060nl5rnGj38FDKG2Ma4jOgoMHrWnYq41nWoG2IKKoZWkRY?=
 =?us-ascii?Q?mINING4cX66IPnY1cOeK1zgnR29d0lZ1ZrR4d2fq5ZX6FcZwKcQkOdPQbS0+?=
 =?us-ascii?Q?eWGCcNYqT8uEBSdFa3EytP+Rn805Gox0qTeoSJ4OIJ7MF/pa1PNx/J5p+BsZ?=
 =?us-ascii?Q?V42meF9hHowVCRrUqSks7Y8nsRL+ab1uz4FEsWFxEU/XCa8MfmUMTtv1ArD9?=
 =?us-ascii?Q?rUB+Z96OwGCTYne/6KYgrdALr4FXIIPVt0cGsM5a7fHUXri0f1YEgjMbDQ0a?=
 =?us-ascii?Q?/+SCeOGOn+t/SNQfsah+CwFq1ar4pswyujTGNtNLZRM9jyc91pO9aMF413y1?=
 =?us-ascii?Q?oQ/iFzF82eL6jPtFz9NWpsnLi4j68J1Xn3eCIjb09/5LXZJtbAOgFgus+SEo?=
 =?us-ascii?Q?soXFcXLLF9G3kM6HdgPS0uLVibQOsec7pA6dM+kgTTCeG9TA4LLb3Rb/+1LF?=
 =?us-ascii?Q?/wZ4J06cMgvhvI6h3UN24+rytsqAg7fBIZKVnxY3TYc0WYY7Zjbm4xQMy/wM?=
 =?us-ascii?Q?0lkToN72VxwXtlD0p7pMd9N1LFNrW30utLMdLas+8UDReKU/BmIZgW87cq0I?=
 =?us-ascii?Q?h2FdUgb3KpqLFjMfcE8rzoFMR4Q8GAWKeLiVJ0SmeiZhHIW3/gtSW7Sir6zl?=
 =?us-ascii?Q?RwC+PAKtzMc0LJ46fA3+14TwO4qzpX0BilSpJQ40s2KEnJuhM9C6R7rnJk4t?=
 =?us-ascii?Q?GYQiJ2PA/Kc5D/470XXGbUhMlnhL6Z0pJIaRlElT1CRvjHdJGufU7GEp1YRw?=
 =?us-ascii?Q?83pMognB42AGX5imWV/hq73D4QzkziCbarhnyl4WoJNO++HL4g7hcssRMUnL?=
 =?us-ascii?Q?Uq29liKFSrESgRwAuAApkJIO/x3oIQYHY8UYWwJdUO3A/E6glQMfWgjti+Vi?=
 =?us-ascii?Q?QmWMfw1eLWybhSULQNS6lOtNhHEk1k4PbiWZywWKRufc35tLGHZoVlaiMbMb?=
 =?us-ascii?Q?FXvta1yY4w3o8jzkeqg3ivPOLOqTUCP6VoYodCWePpPHmHEovREpiKmjp59L?=
 =?us-ascii?Q?jpOp1mGIWc+z3NhxQ8dGvAKm07kHxtP7ZDPyFKmFeMAdul74VDo2bKAXNvPE?=
 =?us-ascii?Q?KQ+yVUVmGt/9+4Je8AX/sNRQAXGtScxs5SkHpVMS7aou2eaR3MRfJOoJ4pVL?=
 =?us-ascii?Q?HVk+2aGKY4Sf2VRoOdjb/uO5OO/ELuA9nm4Sb8oZVZ3os+p2aVYN4khR+/gJ?=
 =?us-ascii?Q?oKM8gb9oJV2w1LDnnNdF8mqUvzdvCbQILKQDYmzWPXBWchB4iYrVoJXBDiAp?=
 =?us-ascii?Q?HHC6iae+pRWY8FKA47l7wjo4AYTXSiH/TkTyZ4DsWh9XMr9SjCvrsUDkXXHF?=
 =?us-ascii?Q?B/smKq+kI0Y2pYWDS3mT68OJ2HHqOVGw3PfLs77wfRHQEIvBz4mT8GqPLEvd?=
 =?us-ascii?Q?/ZA6q7bMdZGZSfEursyTOJmbh9AnCQznwmPjhjU7W10trDv8sRNh7QvGjgLp?=
 =?us-ascii?Q?R3kizfXqhXXXlNm7b6mrv3L0aHuKiRsb1oVS6m+gPopD8+tqGzW2YPCF3/MN?=
 =?us-ascii?Q?ZecB2lUEF1ZQSAPgXgVtGNE3F6NX9WY+0kfRjeOzT44xxddJsnSJvUiU3b10?=
 =?us-ascii?Q?hmGR4vc+QTJKzqx5EVmKptw5EriQbIU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c51a80e-f904-4a9e-d982-08da4da78cd4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 01:45:24.6482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A/2W/yZyQUd8XBehE3VJWmNUORwNcNqHMqWwndWanZoa6JMspJ2goAeDxyUJ30TS1DiArl9Qal8Ne4I6s+Er+WfLvdLfMPpfeSvGJ31acwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3550
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-14_01:2022-06-13,2022-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=623 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206140005
X-Proofpoint-GUID: dea8LnvNWXr98Gfc5K7vvs3pONhrtGR1
X-Proofpoint-ORIG-GUID: dea8LnvNWXr98Gfc5K7vvs3pONhrtGR1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Alim,

> I was expecting phy driver changes will go via phy tree, where [1] is
> available.
>
> @Martin, can you please take a look?
>
> You can just take the ufs changes (along with its device tree) and
> drop the phy change or take the [1] above.

Doesn't matter to me, happy to drop the series again. I just queued it
up to see if there would be any warnings.

-- 
Martin K. Petersen	Oracle Linux Engineering
