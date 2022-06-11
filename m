Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D54B5472E7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 10:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiFKI1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 04:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbiFKI1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 04:27:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE5B15A0D;
        Sat, 11 Jun 2022 01:27:13 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25B2rwxT017956;
        Sat, 11 Jun 2022 08:25:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=2YKrmBgH9+ZAgOd4P2FzfQU9I4tK/mwmsjEtCBeCelo=;
 b=eDf5i09uYb0Ek941JF9h/c+llLAoDdcbNwqCUuIc2Ts4AXzS/p72KPlaf6nUazb4wwtC
 uEq160zPVn2dDdHwa0iRjwKdWBrueSi+vp01N6HQxwAT+gOpGe2GEY84eJpBvTsOAoWF
 z6eZsG1/L5PCkD1yYK4A5HGJ1MIGIX1VWY4ItMcmZjP92o3p7vboxgDQ/VyB1cO0EqL+
 nsBcbTDBQUUja4wLXuVk1pttFLg/9BE91kzs59PpFALicruwhnHBvB3rutwTQ3/7DuKF
 jn+P49biMXsq6IiLUPRNo+prRVLUC76BG9jk3tzmLQcQEfkGm2ZoaiDvxA6PBep9masB DA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjns07dr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Jun 2022 08:25:41 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25B8A980031031;
        Sat, 11 Jun 2022 08:25:41 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gmhg6hug0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Jun 2022 08:25:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxOxzJuWCOl7hJnUuwrYZWlXbNmE52emV2YXsLytemczs2CKTrZd9bgndpArxbhaohtCqi/gZ+2jkYD5vpUDbZRFQK4FK/UQrd14iRYP71hPVmPJNL1FX/ujvIqjFz7IC0U6BCGoTBjckm2gJe+ZLTrHPeanF2qbTWj3QkRnvWELsUAWJ29L1qAj1pSgg7s5sKLzHRZbPeetc8fRXvxeyBDQTijvi+Cf93d+G9CVK6vXQKzv4Tf8/W6BBFP8vnvBYYd+MpVralWx0JSutQYOqi+lY6rfjckSrZoVgGKpPchjebRB0BzBzYPcJGuRsWA2JqPKSdcCglHV09lWAikGlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2YKrmBgH9+ZAgOd4P2FzfQU9I4tK/mwmsjEtCBeCelo=;
 b=nbWaz16Qeyv0IMB5+ruhbWmaQrQNyCfdIvKV1GpMVuRdVGnzEebwQkXeDaUS9Pcni7/e5kdaaaE88W+s7WQDKvuAC4ESkmFsu8VoDVNX628SgA9Errt89zWSoI0wyo/WSQdyQTyDUc+wvLJsD20R1jXLoBrtgx9zeP9avHUY24yZ/dBdUkwTrD//h7JlMAynpStA6qpma+l9zRbN4QvzVKhPoek08nlOx0DlQEEj2drHMErWAIzl6LdNAlnVKU3m1u/+jQKbnHpDq5MEf3Ae6Ut9+reU4iNiewR4WsrSp38hLIEBTXjqG+s2f95bPbZgx6bpnbE2PBF0UoMVvoROFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YKrmBgH9+ZAgOd4P2FzfQU9I4tK/mwmsjEtCBeCelo=;
 b=lxBQtgK+e/5JZR2LxxvWp6hMwwQU6bT+GLt5a//7ldcWWQYKPsOXlmb1My0eB9wawE0tdQFO1jC7f6cxlw1GVE++wcBFZBNA5Ld6Z9KkwZrdPK8srPBVbKoUFHBqCKi+Z8pOWha2d7UP7B9qUvK5J4n+uDHVkaed7f0WaGW+g84=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by BL0PR10MB2945.namprd10.prod.outlook.com (2603:10b6:208:33::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Sat, 11 Jun
 2022 08:25:39 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::60b7:5604:cc5d:54bd]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::60b7:5604:cc5d:54bd%5]) with mapi id 15.20.5332.015; Sat, 11 Jun 2022
 08:25:39 +0000
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     iommu@lists.linux-foundation.org, linux-doc@vger.kernel.org,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, joe.jin@oracle.com,
        hch@infradead.org, m.szyprowski@samsung.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        corbet@lwn.net
Subject: [PATCH v1 4/4] swiotlb: panic if nslabs is too small
Date:   Sat, 11 Jun 2022 01:25:14 -0700
Message-Id: <20220611082514.37112-5-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220611082514.37112-1-dongli.zhang@oracle.com>
References: <20220611082514.37112-1-dongli.zhang@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::29) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 185145fa-c430-475d-7f3d-08da4b83f746
X-MS-TrafficTypeDiagnostic: BL0PR10MB2945:EE_
X-Microsoft-Antispam-PRVS: <BL0PR10MB2945F88F1C7A4D441D1E2F54F0A99@BL0PR10MB2945.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LyLGVR4ujXuiEMum1Tn2I8RypoRnCqBqSK2MC9+hSNwIqrfbhxULMj8nsC5WpuS/Y2y0lD5Xmm6/2ALphr4QGIunku/E2U87fXYrzykGM4mu+I7uJCMSLESljnr6q4f2HhB9c15mrb1Rwt2KCZa/TCZHzuMMU4lb0nl4U9X1t7wdsUVVkrDSAsIXCGKE1M+J+AIso5IuoU7ID1/DVBRL2dt3DjCtuE8+L6FDYHA570kQ+KYv8Osr3BJaZXvXUsOwwjol/QkcseXuUTn0b9vANJUIec8OQmSWzh7kv5MpRPhSql/S98vLQQKQ6HDylwKrzczncnKR4oNIAm+k5bkSSfbeoFNJRyLR+p+zBzV1yjdbISL5fAyc+jFGVCA27XSAJR4QbU76ExcA6Nu6Ogs/DQUUs5FXKnwcRJfUlI8pAkde3LS/U6n3RdECvhdn7Dj4lBxuCckjWHpOvFPZtRixCFMV0n8UPydq1UnCYHSBNO9jOY/NCUFwtRBjeG71mzNzDiguV8dQ+SApRY160REvHE2HagaJ++Ow/jPfqhJXhCpDW03/5dsO8pOCgqZtdgtHg/o/I+TV7qLYIfbBqDcNavrQg/+7pRz/nA0MV/3CnmY52Bcnc1hHJv87yoXRjo7XufUzoC+FQcRo+AIdFFRbZw16aUUQOGdUfauQOhbmFg03Ozj4/vjoWyTzWY8xW1xjElTpk87qHKi0bIVPe9XyZVXlRrhklmWVqKr7/c2ook8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(66476007)(26005)(66556008)(8676002)(4326008)(1076003)(66946007)(186003)(36756003)(316002)(2616005)(6506007)(6666004)(44832011)(7416002)(38100700002)(2906002)(6512007)(86362001)(83380400001)(508600001)(6486002)(5660300002)(8936002)(160913001)(15963001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vplc4T2Axtn6mYTFp7YasV4eXI3/CNm6yEBbl4E19qRsE4hCU2aif16A6GU/?=
 =?us-ascii?Q?AjAKriisQNkdnZavm0Sa0g6mHkCCbGDDqiv7QjE/wYyAS/ffXDSe1g2KOdl8?=
 =?us-ascii?Q?SSZw5++VRlo9tK4mtfR15TwlwMvy5oCEx2GAk0Z0fSw3KCZ/TkUcqf+0+awq?=
 =?us-ascii?Q?Fx/9KlxYehWG35aHyviinbKjlfRIy8cm6tR4+GahchZYuMXdTUyNLbD3hOYB?=
 =?us-ascii?Q?hOiBffEFDUTWdD8hGLMikewBAXFGvllaKqoqgwJ6eO1z4lpC9SR5beZi9BVX?=
 =?us-ascii?Q?9vcqr2RRjuE/3TmINEWbA+G00/IFaqomDvl8YbWVW2Dc3/FdMZNJnLADS/a3?=
 =?us-ascii?Q?Uu+j6iV4pkgVWHS/G7+RVudOcU/etfFv9PAySEOTWUnc7yCLv8B/5Nt/FT6L?=
 =?us-ascii?Q?8ITol80Xt1bHnuQzTJTAFRq6NwWvS+eEOkueEAy4aI1eoLvOpP8lLp8zYhZM?=
 =?us-ascii?Q?K07NMpovHa6I85M/j7Gslcl9sTjLa65qKjhfAdIbMETONk2ltMv6zDaqs9q+?=
 =?us-ascii?Q?+zsSWH1EKUFBJbo2urzOKwu6UtXg+ngc9ipANsx/RLs+5F4o9lz+Odh0kFsp?=
 =?us-ascii?Q?Ot+OuAgC7m65Mmdr12RziZT2y9tGj0MFFKgIYk7xxc+gZZR+w7aAaHmipDkE?=
 =?us-ascii?Q?v2cBytK7zPFtOhIvrRzAUkqTeSMjPb2Gdx2eI2CG8gqjGhYJBBpg9HuHuCuu?=
 =?us-ascii?Q?VrgSeJRwu7ocFK3iCP5eYQjyTC4yRi6Wi7vCbeFPfFDmcHveHpuB13Ftdyy/?=
 =?us-ascii?Q?h21V1ck1gJdOXUZ1AwqMxU53/P4DiKx8VcSfu9q6ogGcI2mhioIRfYrSkjMU?=
 =?us-ascii?Q?Q2sdDC5PPGF8qnx4tBdNSuN1fGz8iX8xSMMS4HYx9Qbob3gbWtZ8tu2/tJKd?=
 =?us-ascii?Q?g6z7Py/cbznhT9i8qnpgyVwTz5mbVDAI01GFRYnivafTG1g7DIW0ANoeqzcx?=
 =?us-ascii?Q?RwwThrLlnv41Fb+r1qXPmubX9MnX11hWppI3sRX0PmiWz1fKkS9f0Xk2VDKm?=
 =?us-ascii?Q?9bf1TKcR0uBiLqP22yeK423r1PjRmiZZOASavav61dhcBSi0iIIotIptguW4?=
 =?us-ascii?Q?A5tcrrVOU9op8dtsy60rfAND7B3wNNoW1xB5za8+OhfCckOHEASFUCTbSJoX?=
 =?us-ascii?Q?iyIzwuP+Ms1TdfXjVhEWA+oue/CqZGJ5VTPX6OjtDFu+UtGXFD0EJuWWGjuT?=
 =?us-ascii?Q?AvtyF1VXF5swZL4+TupZbkE8oojyJvoYXyWXvYM5hqUz2e1z+zJUpQrZTZcA?=
 =?us-ascii?Q?Z3P6iKU2TZ17xRwDYPklW89emaYG173xVcN46IOvgFTUxfW6tkZBfqDwmT8O?=
 =?us-ascii?Q?TZ/cV1ysiPDF70Cc+mABKpRwi2l8rWFDOoo+O68krQx9bv+19qEsLeMakmde?=
 =?us-ascii?Q?RBQTtW2CBCmkzeo2AU9oYKkeijzWwoCsQIB0ThRljSEjI3XLCypdGnPGnpOG?=
 =?us-ascii?Q?yrqHRRZjnONgLN223uVMNIQj28tyceKhAcZn7rAGb87+WJt+CJs9TJ2QSuCa?=
 =?us-ascii?Q?YB//x5+dfE4nB8DgfctJEJ9yQC2E+YEucZy+yn6ixrsljVx/l+2A/lVnNG4l?=
 =?us-ascii?Q?It0ILfHEV7gStQrVD+fitDaCSPnX7wfgwEwjVpW0nCXN7nbF1xFA9b62Jg2u?=
 =?us-ascii?Q?XeCD0nCjDoJD2MuxSozpZVLggRevsildUD0aMpwVl2vPzkV8P6uZhbiQm1ls?=
 =?us-ascii?Q?0eG8CfHHp97rCOxnt6rI4HCihsPw9KdNgskZk2ABpD68rScaY6oAsbiK+UOp?=
 =?us-ascii?Q?Kwt9325vLCYdrgZbqNnSxZrGC+oUUfk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 185145fa-c430-475d-7f3d-08da4b83f746
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2022 08:25:38.9300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iomXJeXny6bCxoavptsJvJJTVLrOOS0ngp3P+gE1GkUYWQL/DHyxGRSm8Wi+vOOB9A2JY/lJi8/axXCjggkpzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2945
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-11_03:2022-06-09,2022-06-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 malwarescore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206110032
X-Proofpoint-GUID: eUpcJ-iOAbARGOOjd4axl89SnuOWizF9
X-Proofpoint-ORIG-GUID: eUpcJ-iOAbARGOOjd4axl89SnuOWizF9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Panic on purpose if nslabs is too small, in order to sync with the remap
retry logic.

In addition, print the number of bytes for tlb alloc failure.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 kernel/dma/swiotlb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index fd21f4162f4b..1758b724c7a8 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -242,6 +242,9 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 	if (swiotlb_force_disable)
 		return;
 
+	if (nslabs < IO_TLB_MIN_SLABS)
+		panic("%s: nslabs = %lu too small\n", __func__, nslabs);
+
 	/*
 	 * By default allocate the bounce buffer memory from low memory, but
 	 * allow to pick a location everywhere for hypervisors with guest
@@ -254,7 +257,8 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 	else
 		tlb = memblock_alloc_low(bytes, PAGE_SIZE);
 	if (!tlb) {
-		pr_warn("%s: failed to allocate tlb structure\n", __func__);
+		pr_warn("%s: Failed to allocate %zu bytes tlb structure\n",
+			__func__, bytes);
 		return;
 	}
 
-- 
2.17.1

