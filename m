Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861B35AF207
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239092AbiIFRKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239442AbiIFRIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:08:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F78C112E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 09:55:56 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286GOD73004232;
        Tue, 6 Sep 2022 16:55:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=c+0EVrzC6eJUNgr02xoi5K17R/S39pBDi0+vU7J0Rmk=;
 b=TGEI5kIAYrozvSp9IMdKSWlWUmrbI+3C9OHtM4YNLNmqrtrdaDxQ17oFBHiL5NSZ2li/
 Y6UUJofFzPnsvFn63CU2TI3b3d+2R7TmtdAKtWx74AmY7dTjNdDmBe4P6BVxFM+0z/ux
 rH4XOCBXHMCdcY9EQZ1ZsDGPWMPLKLT/zoMovbw94niBYPlguJOj1AEIzhlK4bhgaaMw
 +Hc5QsxbzgzlNNDtzwD7exF7mlOAqyGm3mBqriLWZM4RnoC4S6/pqqgk+3q2nosu6asg
 NHtfvxtdqRZo1oqmgDiAtuqQ7mq5cU/aV9Qon4i/qQVwVfpk5T0/z/HVvB+UcksKDSuc 2w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwh1eg4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 16:55:33 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286FASQV030608;
        Tue, 6 Sep 2022 16:55:32 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc35tys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 16:55:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfCSXQHGYF0/0VLMXAqX7UYIN9LTOcFAaB5WtgzhC6br7dJJLC6DU7ODx7l/fWPhxDPewrQNqko+hPRIBhlipg+s5sRqSyLWuXmIG8nJEDq3Q2mWiPoFW/6AwVesoEkZ/OT2naRI1s77i/Y8OeKlE8KxAneajQS3QMtyLQmh7bj+YDyIMdIIvUpgVYKlZMWwyGyWx76twoQxjxCRGcBwEBzQuj38faTh7SdhyMC5dMqodw89NkAlRRDN0evsepJwpxObaFDtZ6Hiozn/mFQLd/pD5Hq7kaXXmxRLVIJNsZBaX2f1Q0G5AE5+AnW3/tXl78e1F33zx6qHJ1RK9HU1Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+0EVrzC6eJUNgr02xoi5K17R/S39pBDi0+vU7J0Rmk=;
 b=PgwOMKOt2oCAUZDJeldZAlXtxmp27SmjaLIQgplQu+A+J4HAgwWv+N0XcaJq4kxU2XVJooMgTQxPOZ4QLNbytbujYcnseSuLPvwbdatVfU7X70zkAvaZdZ28GO6RUI+CbUY70BKxba5rOzS/CkJY4Nrax87ZZ8A3tujXOdzatNKKx7Hs7Gs9IKXBYWH+E3y5rWe+YQbblVn/w9Zdfy82yDbvx8ExRjeTYNocjQAedXeZclH6vPYkzRfH1Xbzg49aj4SfF02QjubzIpEhrknkRhjBu/YsftiMBbnRdMY1kPnKA6s9LekpdI9p4P3nq/FoaHIk6XuakVu406bAyGtFQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+0EVrzC6eJUNgr02xoi5K17R/S39pBDi0+vU7J0Rmk=;
 b=E/Cr/MUrBc344wGI0NbTZqKc7sx7xGS3yszxAJvHcNVU1ZXQJsxDQuKpzJI4a8+izqyFCUkTajC89IEHWGVp8LX59OXAqMZ/VlH3kXsbKQGYtmC4xIwqQ9Mm5hCU5x9FniTI6HW+hdi7X3tpqheevwNrU4l0lNl49bsgKOYkxHE=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by BN0PR10MB5078.namprd10.prod.outlook.com (2603:10b6:408:129::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 6 Sep
 2022 16:55:29 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::ec55:981e:3693:b37]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::ec55:981e:3693:b37%4]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 16:55:27 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, vbabka@suse.cz,
        william.kucharski@oracle.com, dhowells@redhat.com,
        peterx@redhat.com, arnd@arndb.de, ccross@google.com,
        hughd@google.com, ebiederm@xmission.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 1/6] mm/hugetlb: add folio support to hugetlb specific flag macros
Date:   Tue,  6 Sep 2022 09:54:40 -0700
Message-Id: <20220906165445.146913-2-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220906165445.146913-1-sidhartha.kumar@oracle.com>
References: <20220906165445.146913-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::14) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a705d750-2c29-4db5-d154-08da9028990d
X-MS-TrafficTypeDiagnostic: BN0PR10MB5078:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +WgnRjzDUEzbGUlj7+tjsULH/ZSKshWp+H9rZ2gjnvb0NvfzfBV9vCOYFtL4Axl1kN1gaAM6k2qePDMppT3wRaQqAfJVovKMvrf00MZI9g7O0vp/BjlsRFotCPZbo2sbuNcEJidKS9VwwHrffLeGMvcGOrEmhG7Hkf6Enrj+/Q/gITRNhS1GYKzqw8um5zPR6PFQFtrcZet9F2Bf/k9WRv2LP8ZsC/rvrnM0bQ1C7tqzS3jtmPnqtBOiksHZawUwiGQi819ExgOkaw6aeu3AH95+0nIZon6qkmfQTDjZC/qFVypo6f71Sp8P95W0PV00wmEVbAIy4L9wpHHvWW/CDEN+C/86sR9kqpjyd2f+S6z/UhliXVHvNjBr2SoXoz3JqZPz1g4+SECY2WLLH1iM74RmsO8cJULOh0+7Z5w0OQMvUImhQBatm4cza9i+NBAlIS5rmfilprWyZhr7MhOCqSjm59nCECD+gF9kykRTaO5NAmFeI3Ir9/US+ysGlsoTki/0rCOuM8TXqlLscywM1mOE7vvzTrvH7oN+emyM+hLtAnmSkgiG9ZjphcCX6GhwtZCur72criYbrYwb2ZXTIdSn48jjsgRlvmde7448+tekIr0v4752IJ5jdx6P9xx7Zn3XpoGJ1YH8vomabuS1jhbMG//JhgZwLHrOXYddkiX+Oe4lT9ojT//VmWedt1LObmBO/1XbTi15iYawTaVoGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(136003)(39860400002)(366004)(396003)(186003)(1076003)(7416002)(8936002)(83380400001)(2616005)(44832011)(5660300002)(2906002)(26005)(41300700001)(6666004)(107886003)(6512007)(36756003)(6506007)(86362001)(6486002)(478600001)(38100700002)(4326008)(8676002)(66476007)(66556008)(66946007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pswgapoqSfs726po1pca2heOGkXln4KCgQCiKFpUKOPncbsJl3GJBgEHaBCK?=
 =?us-ascii?Q?quyrTJThuoc+7OJehUfR7lqSxIkLDkiElqngC2Vd6pmDLgekAaA37w2Wm3eU?=
 =?us-ascii?Q?8oENKiIrbrj9bjIpH38ymdBgCx6tgl4gMrecJGizfaaJ/aGpnowCuQsVBfXL?=
 =?us-ascii?Q?9GtSkVjRMMDcvuRZymaJdALF/J+D3Twp+SJYtCp5hpDklwfBt8NZVS/lEa8u?=
 =?us-ascii?Q?DNVOEZOz+wu27n63n2CBzai6aglrTk7JJ5sydvYmYIAoDs9O/jb7VKwoCZqK?=
 =?us-ascii?Q?/afv0jHZL1hv4QaMKBUt/QtJmiMZ1ymAKlQWSDCklPwftmeZg0Chmucms8ka?=
 =?us-ascii?Q?b8JJ2OKjbZ+8MTP5Dr/LKcLVjHaPnT/zsdXDwGJa7GZZ33DG6QYnI5JZcff/?=
 =?us-ascii?Q?dRa3wvg/N6Hi3E2bpyylubTWlAw01v9U7Ta7LcpVmVa8vHmWWK4cPOjgT7EN?=
 =?us-ascii?Q?HE0n+uEbMe7MTXwpPAv1QRtRmsUgenkHG8gXHwxKOe0EcBvKRFUVnmIIDncl?=
 =?us-ascii?Q?bT3VTvw/HGTMWQNH6qe98BSpOgkmF7KHMRpm6aoR910BL5F6ZXgv1P+ibKxf?=
 =?us-ascii?Q?41a9o0htyk7fbBKZ0TgwtODdP6IpAqk1JeYNxjeCcjESffAS1h+9WJXJxypi?=
 =?us-ascii?Q?GVu7KfU/5Brzj1ZcyVjRPdByMY8aV/Z9RrHJOjEAgWCmssUW0qwMwIHut+lQ?=
 =?us-ascii?Q?a3+f3lTky9aLupmcAB5pK7QPOYVVEhOZUBI3d0e+RNeEdBFrqla7fX4CPqJI?=
 =?us-ascii?Q?K4fsl6G8+YUmtTq4MTDb616D4ws94egfZjGk26IJNPSlWLSwcIUKFYe/of1g?=
 =?us-ascii?Q?DAf/MNFwzD1Af/S5EwlH5qflrvGCoZ/HBLDzHqQ6Iz1wCT1E/UITFlLLxLVd?=
 =?us-ascii?Q?jg3wzSu2R+8TZt9zhP0ush3gDvt0vpJDH1ys18AQNA1VS5uNQ/ANIWi8bHBe?=
 =?us-ascii?Q?WJk6m+5Ypz15WfCf23UV182v38+be2oQHlKnYpY5Vq8ftVR0g+TwJS1xdlHy?=
 =?us-ascii?Q?5CepoEv7pMSowWucdOMYaIJ26e3PirHNpbtRu1t6n5KUSGojQt8T7+9o3js6?=
 =?us-ascii?Q?ntltJmT5N+5kKk736O9bI7QOurGxR1E39iT3+Nf9ZGIIv6bH3XegGmhEl91w?=
 =?us-ascii?Q?hUhiausvBd/p04CWsdQHBtWaqLzT3l10ql0vxCwpPl0sNeCPn6ofeL6fZuBx?=
 =?us-ascii?Q?PSPKENlcqJRnWGme9VPGyJMeOlKKPEqxi0LMqJSyvVBTa4Z1wHqm+ofugiV7?=
 =?us-ascii?Q?aL2bqCe/wosuiWHZmIPCskJICJ73ntTSoDFVCg+03CmAxzpl7sFPUjCRGvvH?=
 =?us-ascii?Q?GiSkTSXIEmmbzxLEVPz9HHpZm1E7s1lPLtv7FmHkDQgudKGZj4zDgZkPfj95?=
 =?us-ascii?Q?UwPm9txuGnH1qeGTWZjmf5FTGpusMrVG6U3i+APRC8BMaznJfnuuC8lPYv9C?=
 =?us-ascii?Q?02A7cOkK4aQOuZTCc+qn4Afj0O2D8ygxpMgYjek/sfhYMqtoseqPaKlxV9Fa?=
 =?us-ascii?Q?I4RiuUfEAofWoewKDDezCbdisppuNHM3PD74p+wGKZnVkOHJdWmjOK12ORPT?=
 =?us-ascii?Q?/2U/4FSnz5OiYUsKW5eWqdQiOS0f55J1sV8HdGiXOFA09yAiZAfnUtONA0G9?=
 =?us-ascii?Q?8Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a705d750-2c29-4db5-d154-08da9028990d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 16:55:26.9601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5m7RWlhho7rF2AI39jxovT9Gw+aD8d+nWprUZ/gB2fnjxcLVYhu01aaxzoBpoO5oRNUWBIu9BAtcB1j2fm3K8MEfPbanTpO3kjyf6k+P8PE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5078
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060078
X-Proofpoint-GUID: cuSC_V24d3X8uGAArx6_vdOtg7-nOBVM
X-Proofpoint-ORIG-GUID: cuSC_V24d3X8uGAArx6_vdOtg7-nOBVM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows the macros which test, set, and clear hugetlb specific page
flags to take a hugetlb folio as an input. The marcros are generated as
folio_{test, set, clear}_hugetlb_{restore_reserve, migratable,
temporary, freed, vmemmap_optimized, raw_hwp_unreliable}.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 include/linux/hugetlb.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 852f911d676e..0952ea50251d 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -615,26 +615,50 @@ enum hugetlb_page_flags {
  */
 #ifdef CONFIG_HUGETLB_PAGE
 #define TESTHPAGEFLAG(uname, flname)				\
+static __always_inline						\
+bool folio_test_hugetlb_##flname(struct folio *folio)		\
+	{	void *private = &folio->private;		\
+		return test_bit(HPG_##flname, private);		\
+	}							\
 static inline int HPage##uname(struct page *page)		\
 	{ return test_bit(HPG_##flname, &(page->private)); }
 
 #define SETHPAGEFLAG(uname, flname)				\
+static __always_inline						\
+void folio_set_hugetlb_##flname(struct folio *folio)		\
+	{	void *private = &folio->private;		\
+		set_bit(HPG_##flname, private);			\
+	}							\
 static inline void SetHPage##uname(struct page *page)		\
 	{ set_bit(HPG_##flname, &(page->private)); }
 
 #define CLEARHPAGEFLAG(uname, flname)				\
+static __always_inline						\
+void folio_clear_hugetlb_##flname(struct folio *folio)		\
+	{	void *private = &folio->private;		\
+		clear_bit(HPG_##flname, private);		\
+	}							\
 static inline void ClearHPage##uname(struct page *page)		\
 	{ clear_bit(HPG_##flname, &(page->private)); }
 #else
 #define TESTHPAGEFLAG(uname, flname)				\
+static inline bool						\
+folio_test_hugetlb_##flname(struct folio *folio)		\
+	{ return 0; }						\
 static inline int HPage##uname(struct page *page)		\
 	{ return 0; }
 
 #define SETHPAGEFLAG(uname, flname)				\
+static inline void						\
+folio_set_hugetlb_##flname(struct folio *folio) 		\
+	{ }							\
 static inline void SetHPage##uname(struct page *page)		\
 	{ }
 
 #define CLEARHPAGEFLAG(uname, flname)				\
+static inline void						\
+folio_clear_hugetlb_##flname(struct folio *folio)		\
+	{ }							\
 static inline void ClearHPage##uname(struct page *page)		\
 	{ }
 #endif
-- 
2.31.1

