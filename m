Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B9A58F9A5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 11:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbiHKJAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 05:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234839AbiHKJAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 05:00:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DE019D
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 02:00:15 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27B8k3if031585;
        Thu, 11 Aug 2022 08:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=qAM0pn4UF0rTJdPp3mQT8Fre9fDAqiSMo99z3uMd/ao=;
 b=A9sIssYtWYpABlvSwvbO+cqzG4VXH/7CDdmnlB3phVAKSjiS0Q/Tuz+dX0J5nsPuZhIp
 1WhCc2g2+KyUXR23RNsRZK1twI2Hv+6q/y837XL4P1Dq4OF4/t7caJcWGuLGgbY1aCVy
 OE+re8obMGrEVBeIDvsc1W6263DxeqvLTpntVmjjtNqr5GF7swR4r8SWdlJx4ew5Nc/m
 sxnZyywIWfDdS0rwWGWRbIT+Y0PTUwxBKMT3Jc4zU6wOwyxcttk7A71gvxoj4C5r4Cxh
 EQDaXHjISmXurjhx049hzvaQ5LC3xF1DIXPEdY56eOQMD4P3S1OtpLJ3h0tIv42cDczR fw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwqdv7g5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Aug 2022 08:59:56 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27B5ZHbM040694;
        Thu, 11 Aug 2022 08:59:55 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2046.outbound.protection.outlook.com [104.47.51.46])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3huwqgnyea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Aug 2022 08:59:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WdPXrLvjJ8mHf2B2wqtewTYPfHxKx2Rz3EBoArPiMpjlCwqAd2Y/M0Z+s8fyN/MQUfa6cIge0W0fLiuM9WCbjviZo+BZuQMNjDfgFs9PWHU7WXrWlBzNiCCenJCJGaVENmga1e2IUhuzsFLQykcDqcI/vqadY98tKpxptcqHXOT5FXTf9kvOWeZjcDeMij+L9E8zjsSVNlb/lbWNLZxHnsjVkGOrsJzrDHuFyhiHfWiYUzjlnpw9nuaJx+jf1j5tASrBfZsQPo1spWtFWessXsfWZ4m9VnZWLMBBhORTwaER/8m5NaHj5O0ep40rVVW5BD1VoXtjhFiwrPM3oggyzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qAM0pn4UF0rTJdPp3mQT8Fre9fDAqiSMo99z3uMd/ao=;
 b=GOeIIPWF3oy5C6i6xIGzIKef1xwVJ/43lnhFpkALELi1y8BY0+9oIPEglQmdWZaUgRcICkeNjEKX27fy8Abj2I3Gw+s9Ii6e/eTdFxy+WXc3vx5zL1m4/mfFANkXUFNe6zDYbMWB/AwyockSS/LjxR6GgzbUUQmMi0o9LBNSuOOINVdtMjMmAwQjyMd4wekCMsic94zp+PUwhw8D8Gm5JSRWWIiCvhcQ+g4s03ydKHXgnD7SP/qmVs85Ihb8cNxOLs+1HPd/uB17OXqZcbCookp/UkirCTSfDMX5hONTZTyw6ihl2myK78DeivKF3vQETuHxccvf62I9NXM5LSU2UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAM0pn4UF0rTJdPp3mQT8Fre9fDAqiSMo99z3uMd/ao=;
 b=LME0GOPdmnkwzirZ2oKQ+fs84PrfCPWopE2LtX11YN6IHGy12GEzI3AJIKkjvaOJ6TYNTb7fvCpqfeo+yEAFJbwbbxLJohW+hjHcFESHxA5AFRs7Dh5vFpwkztLzyC560eyZh/NbaUkm+3of6BchqGv1Fl2xJ0+YFq4w2NhwEfI=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by BYAPR10MB2744.namprd10.prod.outlook.com (2603:10b6:a02:ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 11 Aug
 2022 08:59:53 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::c504:bfd6:7940:544f]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::c504:bfd6:7940:544f%5]) with mapi id 15.20.5525.011; Thu, 11 Aug 2022
 08:59:52 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     glider@google.com, elver@google.com, dvyukov@google.com,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org
Subject: [PATCH v2] Introduce sysfs interface to disable kfence for selected slabs.
Date:   Thu, 11 Aug 2022 18:59:38 +1000
Message-Id: <20220811085938.2506536-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYYP282CA0018.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:b4::28) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d27ce05-7068-404d-187a-08da7b77daa0
X-MS-TrafficTypeDiagnostic: BYAPR10MB2744:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cpkK/Gc3vzbFQYx0CoQKzzlnfoofAD6xKkTAtL7LIj2lRu1880VdhwS2BNFxqExa6tONingnBg5sTxocyjBxaUX8L550StLFMnlcBd2OcfLz4ZdkJLfE4qQulomdoJ+7WPIzkEq0v2dCGjO6svP2Mk9J88BY0QfVc+rOayULpo27nc93aK8csh4Bfi/gcaXVExrKgBmXEv5WkcwWkT+XNAnPvB0GmPlCjYpSNN9MD3UDYlMdoAh4/RNsNJUJZPAuWV8Kfe1hP5vkD0nnzedLTIwYRIopGodrMCJN2Si7fPWxz5TvBOOncyBt5hGqD5QcfGwsdw+WBR+4SEuvjMGRMW3T1XqBgu1jvg7Vvqi/Lo/wDgN9jo8ufaKP+XYbrFQPF1Xd+YniIhoVdaDge4gEYWATD7ia3OTGMr5AfK2PNqjjOG6u5nu5ONem3JdCQLrg2O8NRwqAZRFPmk8bUVj/nZHVjTRaPbcG03AlMgUMT9xP85jcbm5sj4jDffe96MR3p34yV/WJ2j/96ggIwnF43mAL49bqkbBM4PKnl+kR5BzdP8LJkqZ8MinUrqMwvuCSTcproE4Qcnb2FpEtUwm305Ek1m070v3iptJazvh/5drl4IpZ8lHC03zXh5pImytktWdBTUqT7pjsTS6RV8NFCwYrIk9/Ht8xT4aAx8iRzGCcgF8Zu+f21Whpy/e+wVAAuE8gtXspLzaeUDZsf/cHk8sKe266gMnqOrKL2UO5Z9V7Nlhmtwh0v2Z7ARr9yir0li4UuC4dw51InYUsOF0xrTzUp3TOmlwjCEzGzLihqnQlthhbgnCQSAhfsf80SY98
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(39860400002)(366004)(396003)(346002)(66476007)(8676002)(5660300002)(66946007)(1076003)(66556008)(36756003)(4326008)(478600001)(7416002)(186003)(2616005)(8936002)(103116003)(52116002)(38100700002)(86362001)(6486002)(26005)(316002)(6666004)(41300700001)(921005)(38350700002)(6512007)(83380400001)(2906002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9GqUdBWyOAN5hMc1++zQvan46+BQq49DgtPH+Pj3WjmkGHVFvsTIWhoKy3eG?=
 =?us-ascii?Q?C0ycTxmIYvTAnqW140WqdjD4uhpsEI0XpZ/aFsZASx+YbuPcVI6i2Mvl3VSp?=
 =?us-ascii?Q?bT0vDdMA/7QQZSzH7NIoUOvCEl2GtM9flZkjyy0S0VF5sUcr8DhSL0sukop5?=
 =?us-ascii?Q?aijfMYqtkXGHepmeAiTvKtIOhD+2sfDc2gRuzbB5Ph2NUH1V+rxCNcPvI9l7?=
 =?us-ascii?Q?eYL0RAnvNyD3yzEDlnr/7+LwryZyizeEURtMsQm3X59N8O+OLaTYDzVVHfja?=
 =?us-ascii?Q?Z7AblR7Uw+Pc4+2o/ufrDhGDksBfvZzaYjyTg0nC8Drclb+plLCJUQWy2Lrd?=
 =?us-ascii?Q?0Z0RUFO2hFQZdRC1Lio+CS2U0BMV71TWv0tW6LCE4iGhfnTJ6+YSGKQoi4y2?=
 =?us-ascii?Q?8C8Hrjoch6kYiIq5O3ky9irsg86ZYsh/eW9Zhn6qMVIvQJsOl7x6iJzgckkI?=
 =?us-ascii?Q?j5BP1jjg1wkZKF94wwE1UYAWlyvE6cqKcKQHgxZCRqGUFs0cPPY4Se7z5ta0?=
 =?us-ascii?Q?grxn1rtG+jIVkJh9KwmFGEUxgI8vgSBsmkAD5Y5vKqd8lEA3wslzB2FNvVzj?=
 =?us-ascii?Q?OCZURI4sF1+TN6DyXdPiih8ok7/DonpAvXb/p9m63Gxqdtz2YBcuq5gDxYvw?=
 =?us-ascii?Q?kmhBntwCD/F5d8Og/u8BrydO3o0wFjqrxbXI476N4bDPAUHoMmjDXcz9gFMZ?=
 =?us-ascii?Q?1euPl4S8gpbtqzozqWES/Q0sSa22mn41/cX7KbBeuHnARFxQJo59Oi4sNvkx?=
 =?us-ascii?Q?pY0up/Wj/TkiwlueS9nLcVf1XVp0CJi6aLnog3GbmPoP1WGtXnMsrAIKmfmI?=
 =?us-ascii?Q?azQvmNKeESMJuYwIene4Pe6XNdCrayolgIq63MqdGXLGY8XqivXvYqjcbB/G?=
 =?us-ascii?Q?xoct7T4aAZ0YWFE7uS+KmxKZ/jww0SvPNdd6uKx8unmrloBbskYL7OiwmIYu?=
 =?us-ascii?Q?h1urJyYq9bi3UVJDXSmvgstIsEnjcO25sfBHsHyXFegMt+De251ven0MPo5U?=
 =?us-ascii?Q?vx+bKaRY/CTYveUNdujahy28y3VOiGn9aHpgJ+yejkGUch4AlPo1fMcINynY?=
 =?us-ascii?Q?Iztzw5BGGqb0Xq/sN0P/wtMqLzoswyg+3e5yO1LbJYjcBcT1Vj/IbEWvnUHb?=
 =?us-ascii?Q?rsOdrwNOe5tkX2f0AIVvRr9rJCJjlq3F1KBbAxEly/SK9F5eeP4fqkNmMdjc?=
 =?us-ascii?Q?5LImzFto0xVHmPKPUdXur6wW5Uiv1Pe87qpT0oZw6mw+utNQGRW3/DypL8T+?=
 =?us-ascii?Q?c7FAYDNweLX6jYteBcudkvTbd+rYFmiMngvtg3hGAt4CriO2DH4SM5GG+kL8?=
 =?us-ascii?Q?6FA4I+3QYpyW43rakcHQgHD/kgQ7cx41BulboZML2OtDVD6PCNBD/bYvc+ml?=
 =?us-ascii?Q?o0GLwoxP5baO1skDQphYsbYbT+4K2DlVA1X8eut3gprxQ/j/GQXAUMPyvsZ2?=
 =?us-ascii?Q?u91RLkPKhUUdFWBL18YcN0ODWzZnKgVk0iPTm8KkbU1q5KeqbFZCi6UvXPq4?=
 =?us-ascii?Q?gGm/nIqxike6rG8X3jnwYg3kFNMtnlQOI/AFfUFLM8GdZovOiTOejyY9D/MI?=
 =?us-ascii?Q?YeGVMyiCuieDdbT7iKdZQ0it1fq0YCd69WYMowUe+VoGIbr8tAOmqPJpQSwG?=
 =?us-ascii?Q?Gw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d27ce05-7068-404d-187a-08da7b77daa0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 08:59:52.8720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hxyXyzPho+HDe8qFggmu1tFnvdULqc0G3McV/X3CwSO2xmHBuRpeUbWR3HgJVoojzODbr1LBlQNUA6Yei4aZvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2744
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-11_04,2022-08-10_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208110025
X-Proofpoint-GUID: I5rzd45phqQAHhlue27uqgBrxxq93oWo
X-Proofpoint-ORIG-GUID: I5rzd45phqQAHhlue27uqgBrxxq93oWo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default kfence allocation can happen for any slab object, whose size
is up to PAGE_SIZE, as long as that allocation is the first allocation
after expiration of kfence sample interval. But in certain debugging
scenarios we may be interested in debugging corruptions involving
some specific slub objects like dentry or ext4_* etc. In such cases
limiting kfence for allocations involving only specific slub objects
will increase the probablity of catching the issue since kfence pool
will not be consumed by other slab objects.

This patch introduces a sysfs interface '/sys/kernel/slab/<name>/skip_kfence'
to disable kfence for specific slabs. Having the interface work in this
way does not impact current/default behavior of kfence and allows us to
use kfence for specific slabs (when needed) as well. The decision to
skip/use kfence is taken depending on whether kmem_cache.flags has
(newly introduced) SLAB_SKIP_KFENCE flag set or not.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---

Changes since v1:
 - Remove RFC tag

 include/linux/slab.h |  6 ++++++
 mm/kfence/core.c     |  7 +++++++
 mm/slub.c            | 27 +++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 0fefdf528e0d..947d912fd08c 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -119,6 +119,12 @@
  */
 #define SLAB_NO_USER_FLAGS	((slab_flags_t __force)0x10000000U)
 
+#ifdef CONFIG_KFENCE
+#define SLAB_SKIP_KFENCE            ((slab_flags_t __force)0x20000000U)
+#else
+#define SLAB_SKIP_KFENCE            0
+#endif
+
 /* The following flags affect the page allocator grouping pages by mobility */
 /* Objects are reclaimable */
 #define SLAB_RECLAIM_ACCOUNT	((slab_flags_t __force)0x00020000U)
diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index c252081b11df..8c08ae2101d7 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -1003,6 +1003,13 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
 		return NULL;
 	}
 
+	/*
+	 * Skip allocations for this slab, if KFENCE has been disabled for
+	 * this slab.
+	 */
+	if (s->flags & SLAB_SKIP_KFENCE)
+		return NULL;
+
 	if (atomic_inc_return(&kfence_allocation_gate) > 1)
 		return NULL;
 #ifdef CONFIG_KFENCE_STATIC_KEYS
diff --git a/mm/slub.c b/mm/slub.c
index 862dbd9af4f5..ee8b48327536 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5745,6 +5745,30 @@ STAT_ATTR(CPU_PARTIAL_NODE, cpu_partial_node);
 STAT_ATTR(CPU_PARTIAL_DRAIN, cpu_partial_drain);
 #endif	/* CONFIG_SLUB_STATS */
 
+#ifdef CONFIG_KFENCE
+static ssize_t skip_kfence_show(struct kmem_cache *s, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_SKIP_KFENCE));
+}
+
+static ssize_t skip_kfence_store(struct kmem_cache *s,
+			const char *buf, size_t length)
+{
+	int ret = length;
+
+	if (buf[0] == '0')
+		s->flags &= ~SLAB_SKIP_KFENCE;
+	else if (buf[0] == '1')
+		s->flags |= SLAB_SKIP_KFENCE;
+	else
+		ret = -EINVAL;
+
+	return ret;
+}
+SLAB_ATTR(skip_kfence);
+
+#endif
+
 static struct attribute *slab_attrs[] = {
 	&slab_size_attr.attr,
 	&object_size_attr.attr,
@@ -5812,6 +5836,9 @@ static struct attribute *slab_attrs[] = {
 	&failslab_attr.attr,
 #endif
 	&usersize_attr.attr,
+#ifdef CONFIG_KFENCE
+	&skip_kfence_attr.attr,
+#endif
 
 	NULL
 };

base-commit: 40d43a7507e1547dd45cb02af2e40d897c591870
-- 
2.30.2

