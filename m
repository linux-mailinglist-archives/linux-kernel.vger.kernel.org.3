Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE801522954
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 04:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238623AbiEKCDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 22:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236853AbiEKCDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 22:03:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6294ECE8;
        Tue, 10 May 2022 19:03:06 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24ALbi36007656;
        Wed, 11 May 2022 02:02:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=aEpDIle2K22qOk8MY17vrH8pJx0lXmq9PZQEC95qko0=;
 b=PZYz2JG27PrOIOAPCm0LYfBvMtng0dWnuaox4bo42WWxD9MEIEhelZ5RWITF5JqduwHG
 VEhdPN9h3hBsYokGNdnqgAHvIPnqYyrMKR98xEDC7k923Ohn3B9glQXmQwwj4wtpgywN
 D8xzRroV0H0MMUE9YSxcWxmtys3eXyP8/TdYlXEuxpcE4oG3N4tU70MlKrdVHqU0D2OR
 zI0yLdx3NU4Pn1d1p7JbAsCGgwpOvzFx27alnQxpZhcF33pu7Hw5WYF1AdHZPqnP+mHm
 2Ni5z7sktJ720cyWyuBsurnMTthB/swK2v86ktEBkkgiVIWTgBAQgzIhJjarAkbQGq/x 1g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwgn9r26w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 02:02:29 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24B1tTBF023338;
        Wed, 11 May 2022 02:02:28 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf73168k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 02:02:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuMWSII9BJ4L3xsDp6KMjHxZe1jkvtetBl+8kNWEbchc0guFdF/19ewvWJJcRJ0RX3OHQJDGA76SiIBLknD3OJvZN808ekgaJ1VdhntmME8VAj52yAiD4sPQAKdMWQFRPKOP+AjS20YcLj0Due/KU/5vzDSV5EuvmKiOoAepmCRhAIjfHnbzp06Jg2+unZO17eMaVpryytqStOYOH8ivWAdHqJ5mDcqyfyujDcJFBETdWSZZzXLHsC0CPcb3xpV5dDNzLU/gxROTkK46P6bqtwEG6v4LOfhyF4Qu9RYGmuDOKqKu/zSizdLSAgm6P7KFtd4Ad6fL3dbd3XDIPfGlFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aEpDIle2K22qOk8MY17vrH8pJx0lXmq9PZQEC95qko0=;
 b=Qk1FkLARKYZk96q3t2aJxp4r/dda4vcy9LDl0Ta9+V2g2UXWQi0Sj4+/4/EAxRDMp+oxAbwuLmPXI9Tx+mtPt2/ddPA6TZmjpQkEPQr7FZHwgdNklK0mwvn8RXGFEuYpvl3teq5T2GJp4HbYSymKx2qBCklC9gM9ufgFFT6CpF231KanTltgB5m+uua0eE1J8HNRO5mB9QhxzDxfWK6VtXiw4VUnNviSqKsJ27nnlD6wZBrL9WX3fFHZk81TzQtvK+fgpHvMWGByVXY7CpxaEOz2Hzo8LmcgTVDYHipMAW6OHaciAiu7YVTUM4sz6RFqZEGM5pyq8eKjeL60EIv9cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEpDIle2K22qOk8MY17vrH8pJx0lXmq9PZQEC95qko0=;
 b=NJMHNRY94nzU4UePnNUECKytBwCae7Ms3dPSIyaJatuMgZaa+2QFxH/p4tRo+NQIlCliL1zXiJ1oRZ2lKaeCWWEhPouDVhFq+mP/j2haIdMcDQOdy+2OFdzpdUqQzLFdo1IZ4Mwlr+yYO5z7egerknUQ93okWD32BSgl+3DSddI=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MN2PR10MB3407.namprd10.prod.outlook.com (2603:10b6:208:123::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 11 May
 2022 02:02:26 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192%9]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 02:02:25 +0000
To:     Bean Huo <huobean@gmail.com>
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        cang@codeaurora.org, daejun7.park@samsung.com,
        peter.wang@mediatek.com, powen.kao@mediatek.com,
        keosung.park@samsung.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] Several changes for UFSHPB
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq15ymczv1d.fsf@ca-mkp.ca.oracle.com>
References: <20220505134707.35929-1-huobean@gmail.com>
Date:   Tue, 10 May 2022 22:02:23 -0400
In-Reply-To: <20220505134707.35929-1-huobean@gmail.com> (Bean Huo's message of
        "Thu, 5 May 2022 15:47:01 +0200")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0046.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::23) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9b27af0-0347-43dc-df12-08da32f24b7b
X-MS-TrafficTypeDiagnostic: MN2PR10MB3407:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB34077B9E2FC31780FAE52CEB8EC89@MN2PR10MB3407.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VRJOQ5AFDrZLhToG/caHZzwBJqRBXsXlWFTQwwH4hI0uEpq0JyXQnB6AeYyIvbep6YHicuBbPzU148dym68IGlsJTm0WgI27AONCtVdfZl5HQw394KLHsI3tXrbhy/qXrQhs/jiLIzpPP3Pylwntoa+rJNsxAuXKglwdw/dTJQG6iKFqYL/zad7yaCHr839PbRNcTI5WB6ba2wJCKk0i1fHZi5k2bdXe4iWAaOqKra2XNlTjholC9ldQhe1uv1CRz1fdVNcghtmZ+Z0h3JYGpgtFYBItVzTxhKHxCvTTaQZ3YSE0CH9oc2FW4OvQ6dLxagnFCKXYkjKZdhnyFbph1fjg4pIe8r57O2rfNYR7/33xdP0r8tfj5FrqDBHlAKZcPYBa41rXB6FDV6RkQu5J76nB2RoHBWswBT7qGtH9LjnK6s174etrGEvfdjHpCdaOXRALB21Qk648XECpMLXCk6kA2Lbi8+Ovl/9XaaczOVJMnj2nYOB81AkqKVDk9fURL/en/fdT6vTfuXK7H8wwpau3t4M2Oic11k7GJGiA9pohmFaNKhpAyS0IoBx6CBb06dT02ayz3CzVemF0g4A2zOyMMZzgzC4jUftLrQrGS6IIBrWnHzkCuDfvzson+S5jhu4pA0J6Ms8kKnBCIVVHGYWHDHAWT0vLLkHs6qhFtsuehRmcL4gH2DBih6AGG00xJ9fz4C0YoQnwr1ydNVZQCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(508600001)(8936002)(8676002)(52116002)(66556008)(2906002)(66946007)(66476007)(6916009)(36916002)(4326008)(558084003)(6506007)(86362001)(316002)(5660300002)(7416002)(6486002)(38350700002)(38100700002)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?36XB5eo+nAdLP8orhAxAZArOIxZrffXyaSA8Lc8lXL6LNDmrVQ3Yv37x/4+l?=
 =?us-ascii?Q?X9MD+YpV4cGA1KKBhSZ1AyeNKIgYWgbY7tEAvf9PBipN4BE+KRhQJm+u1Iv6?=
 =?us-ascii?Q?Jbp0fwJ7wdcWQuDRZ664pDzW7JiuZ9SyYEfx2fUx8T/MbTsHYM+du3FzzBM6?=
 =?us-ascii?Q?Z2srxdKAMbBfObaqPtLERk/YFGy07Rtg62E1rm8qVk9XRXO4n8237HehJ1Z5?=
 =?us-ascii?Q?AMpoBl+5sc/8Z/M1/T7uLs+iqbWXqqhJoOxMWPF19xVes8j4/tQFypu0qJPE?=
 =?us-ascii?Q?ezybtkDgnqxrZ5cCtKnFoCOMf/vlOyS3el0RMfFE2GTv51n8hkTpF63+FybS?=
 =?us-ascii?Q?WjGM4S14GVwMwgcS5jtmMgptIh4SL8FRKaSiZtwka1gmo85uKtuZsyRmz8s/?=
 =?us-ascii?Q?DIdc+v9htx6lwEc/ApxBvbJc5EPGaYiWpcVTmdu4JudVYvcIEdyDoOZ+AG66?=
 =?us-ascii?Q?cmcVQPMAb13sYKGkGaqASCZ8s9N5w2B+zd4rCMJnGCrqJ/YxGz+LluvPinqj?=
 =?us-ascii?Q?YH1oUf6LoUiT5rUIpxzxEpVBQfnsXLDXeU19HarOP44rVYOt+RNombE/diU7?=
 =?us-ascii?Q?rZ5fn60y5Og9u4WCUaULwEIp0EwXxzFJP4Q7JB4Ak3swUwV7FGg1Lde3v0qz?=
 =?us-ascii?Q?8jNPR0UqPfeM9bN+vidRiCFEmuA7bUXGMFwPz3KqLQpsDhHwnRUinzUV3onb?=
 =?us-ascii?Q?vGnG7V6Y0OZdNEv/5xJxfadC/nXpGn5h/LBfP+0KAZTYLbk/ePEfTue0c5eJ?=
 =?us-ascii?Q?Kg4oiGi6tFybbtY6EPGCEG3oLylhqwgLOijGLFEm95b4dqgazUC47Vja1q44?=
 =?us-ascii?Q?9zJoB+aPC8vOSqGll0WbZ5sx2THdLIg5XQU+WZm0fibDNgEQ186vykVyypO0?=
 =?us-ascii?Q?xndOcC21SOEnsC+3mASYmkOfyOzwDaEulsBZ4yRA544lT1BYnH9uHYmIq5MY?=
 =?us-ascii?Q?ABu7bzygaDTN3BM0s2vD6/thA6s/vBz9EM7RsoQGDbPrdvMwotfGFa+4bm4b?=
 =?us-ascii?Q?0KFqUMeM7o5PLk4xVSbgY1+JVi7yUEPhxqqyw4abAK6l6bR2NQz/jw54bkfc?=
 =?us-ascii?Q?KX9AD9KSgejKfUQYjzkvoD43yfcROlceRXWP1J3JvwRTWJ10H58CMSjmlmA+?=
 =?us-ascii?Q?nhQS+Xrvjf5TlnNT8LAOtoy7bGXctVKBuvd/ae2uffm7tIPCKX2dOwcPHI3Y?=
 =?us-ascii?Q?aZIXQQIppeOGDrKMh1vAEXfZY3l6rRWIVe6M7g5cS8PyH8m3/dUhIWtcf4MP?=
 =?us-ascii?Q?opa/+YSp2i8hKN0iphESQvJowDuKgRyrwaZwcCrJ0akoOOgQGt7A6QWRwC3v?=
 =?us-ascii?Q?1UsMDY8j76yT7AFp29QuqrG2Qxko+n5B5aPqa8LBIKhhs7T20FS6//YJ/jFm?=
 =?us-ascii?Q?RLgvEnGTP4c8FVCUzoF/p5QhXrW5YwTYcgKDY3UeVMhsqfvwmgScFYEop4qo?=
 =?us-ascii?Q?qfvtvA9lVPVPHsCnRVrg9I/9/pRU0zCsgezkqHrQyqKTzUKv0NaOqvlcR/9I?=
 =?us-ascii?Q?vQOuBLWsWSldnMhKiuaacJwdxtd+vojaOqOR+C5IFPiauhX9yDrZ1QJclcP7?=
 =?us-ascii?Q?ffRWeY4ueCJfQsxGYMWGoKvRfeHEyplvkZPnpW9hH02FA+TlX61m0KhdjSXF?=
 =?us-ascii?Q?ap8MJrLkdoctaykVvCNYEz6C/Hg9vbEK5oOUpUnkbs5b/Fy0jD1JaLrRgHRb?=
 =?us-ascii?Q?VdwXFdAgEztydTxZeXVywpTHT9CdIr6+yzufvyjz1bb4D3d0Tr51HwbLQorb?=
 =?us-ascii?Q?68om5AO1RWBKtntit6Mhja8rkrVGhNE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b27af0-0347-43dc-df12-08da32f24b7b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 02:02:25.7480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r59rf9aC8mAVDnEPpoPdxddXuii64aYLMxh5X2S8Ct92Y5+qP7F03+7H0pXBHSyPH3EiXJ5HbTaYL5yi2N51tPXcOp7+nKeOCx0mS6h4ksY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3407
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-10_07:2022-05-09,2022-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=647
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110007
X-Proofpoint-GUID: _90Q164aF8RzsQB5I06mRBrRHIqywhCb
X-Proofpoint-ORIG-GUID: _90Q164aF8RzsQB5I06mRBrRHIqywhCb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Bean,

> Here are some changes to the UFS HPB driver.

Applied to 5.19/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
