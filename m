Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC3158F84B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 09:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbiHKH0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 03:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbiHKH0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 03:26:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E2878BFC
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 00:26:31 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27B70UNO003239;
        Thu, 11 Aug 2022 07:26:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=veyhhhSDU3ycywKUlAMF6vUD7N6NwCH6ybieZSHT1TE=;
 b=T4c8Fae9NZZ0gJVpgags1Xv0YmJ+isAXPtEFQL3Dg2gxxDNQLPRIq0+r04GqNzabkL+l
 MCZg7LLRHiEnBSu5To1LKJRmrb3HqDo9/dxo0o3+MmzPSn3AcehxbcA0Sn5yE9ZWy2Ds
 7GVYyzCu1Wq6Wbc3CewlRLzkL/JkiXvv0eOzZspx+IHQKvU/IpJmdd0cNcPgoXtqxMYz
 H1baBCtPb6BNZdSvRw0OOWHepxb80cPvvTdHaidhCWqQ4co+EQMS3mlmGpQ5CurIXOfl
 y4QIVbV6MsbeCkRnM7syqEMXAlwtSxnIIdK9UbAxKICdfH2/WY7P1Sl2bAC5LjeuGrIS dQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwqdv0sf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Aug 2022 07:26:08 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27B5eREt005040;
        Thu, 11 Aug 2022 07:26:07 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3huwqjcn25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Aug 2022 07:26:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3RXxPKTin63/0U3nyYymphnjIj/TwUIFRSwxZJiZKzOu12mN8W//4R1JYtwKLT6HJ7D4qLhExGLdRCu3nqkVMyY3qbxN/QDUqxwxgbwQhpKq59Jva0o6cZ6no2ZhdOCtfgS0b5GOeW91JQ48tuVTrYbD21MTntD5RfGmVVfPEhiuC4Vs6kGJHkK3glQa6l9jbwfVtQLxRGnqiKFxCESOdkxeBLFqN+7zZX1a3clO6ramUTlZt5FpM7n2wYAjNKfLUhnM8ba/FV70l0vMLxK4Y25Lwdrj3wHWEXSXFN9QBmefud/hrRZea46UlBhqMxn/XW7UJMeeglBYQ5k/nGufw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=veyhhhSDU3ycywKUlAMF6vUD7N6NwCH6ybieZSHT1TE=;
 b=Ex4zesJmydms/ftdTifZKhZUmY5lMPsuKuU7Jk1kAFs/tFq0ZRaf6yy/NwzXRJgqfpKNo9ayMKpDYQSo7+MKMPDgKlFtztD/xMqKy+RX0ElegNgDJfZnna4INLAzYWlEBgxmIh35nklmvqWHhI4FCOWOcFk8oWPSoga0frWArjU9h6yM7aiZwBupJnwfFDWI/2mntg7az8sI+3bVhlMMMgQmgHlltVD+3aObQNH0qEBTvlSUgV7+fhES5NR0w72ynauzmfMZZXx+H6TKKLGiBpr4NpnaOGefadhVmk8zkQaeZAwpZeM4UtS4eI/Qz8GT3PKeD3RGA1gi2ggDR7jeNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=veyhhhSDU3ycywKUlAMF6vUD7N6NwCH6ybieZSHT1TE=;
 b=gvN9TaZ6bK/392dbQjPjbs4qbV0R0yfQiko5DF5hkpolxfC/rXJhJEOQf9lO/okmDmu9ohhYoqJ0tMbBrzwaaA5MdZXG42sAFghRDv0XR0xwQ4FYMtswEn3N1wUS0IusMG5ektN9n13QDwXyj0qLymp+xE1fhEySIWFghhdKfxI=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by DM6PR10MB3209.namprd10.prod.outlook.com (2603:10b6:5:1a2::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 11 Aug
 2022 07:26:05 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::c504:bfd6:7940:544f]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::c504:bfd6:7940:544f%5]) with mapi id 15.20.5525.011; Thu, 11 Aug 2022
 07:26:05 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     glider@google.com, elver@google.com, dvyukov@google.com,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org
Subject: [RFC PATCH] Introduce sysfs interface to disable kfence for selected slabs.
Date:   Thu, 11 Aug 2022 17:25:51 +1000
Message-Id: <20220811072551.2506005-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYAPR01CA0016.ausprd01.prod.outlook.com (2603:10c6:1::28)
 To CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b00545f-8b8f-4ae0-d2d1-08da7b6ac058
X-MS-TrafficTypeDiagnostic: DM6PR10MB3209:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +l3GgizNre0QNRs4tC2XBVYsEmI1Q/fj3w48qbPSmO31Q5nXiL6dgfuTOp8DMPzaC71CfHFsACEs1OR5TmVRQ++Tpxq7q7jPM5pN4CWJZbwctMGhk2jXPEhBkRqf3XwWh4pZ/xhgpq2MZZ5QpP1sz4FoghSgnoZ6bPgdIO2ptTbRMQ3U9Q7lrnPVuB2R6fISPGzsZM/ZY++mEP2oruHvdaynkEJb6f/YZSaxCjTDwbJiSoBHkGuVIcxwVr/MtwA0/gVR3OqWgAPc5h0E7whEvUqIqKy5BhSdXgqyFtwYJN9odq2f+wP+1lKT2N7OIcXZuR44RLOgq9wYsz0QL+2YhZKzOopzuO/B/Qs/AdswnGyssSYPPGXEh0I4em5nV+Llw9R0QxsSIY/ptxH9dS9YnH9oc9yEqxTfICheUteBhAfYFhadsaOWknPLUSuWcfIR6FAb8V6QkGpdRwGqIllXR0s2BkT7nqpzIx/SkcrhOTf5F0+lhCJ+/WmjDdSJ9QECDZTsUzu/eHEnb2Lx2bqEWhv0c3d5Faat+J5TvSa3rIqDA7mcgugVGWcO8j1o8ZDju30aG1AJs4ELoiAvvApDYBP+vTy5CRSEOQNNZFsPQR4FNQNMu20dbotJzA5b9gpG1Kw9rTD43Du9OXs+L8/wBwqKmu8ZEXEni95iVmT3A6834W2In9LymSkGHa2ro/yMii5OVtMTMO1hLiQstHPRsLXUS188EB6uXltvMIM9nnqV5MQiPWfR8nsqtZs9udxez+el5aTkD7fbeLGVezif41CDdEScXUDvl8QnzsmVSeRHFJMO609H1hszfTv7g7sE84r1Gsc62arOnYTH01NSsDQPcYcoTnThYjgz9tyN/r8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(136003)(39860400002)(396003)(366004)(921005)(316002)(36756003)(478600001)(6486002)(38100700002)(26005)(6666004)(52116002)(83380400001)(4326008)(966005)(8676002)(66946007)(66556008)(66476007)(38350700002)(41300700001)(6506007)(2906002)(86362001)(6512007)(2616005)(8936002)(7416002)(186003)(5660300002)(1076003)(103116003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zuNYnJyDiVgbLQkVTNEwAAONCc+6s68Hq3ewHqKP4+0oJtU9GoQLqW8a4pO9?=
 =?us-ascii?Q?py/ATOgZIAaRTle6d05pxEP4UU5Top6DSXH4VmJsZjjJubq80Ys3ctVf4inU?=
 =?us-ascii?Q?eqNLB4Z+STjgDQl3lyYErVM0HAPAwq+8IOaKcsxkJVOMNS6tI7PmIOzcBJRr?=
 =?us-ascii?Q?6UOxtHuuE4kvY1Dp7OpZ1sFdema8/ZVmOkrKRzGFxzKJoiY313kJmslH44QX?=
 =?us-ascii?Q?DpHlyVMATpCLgx4ZSBmtpMh4VKUDku5Yi+Whj+Gyo9aAo0SwJTq83LQIh2x5?=
 =?us-ascii?Q?e4OyOAuevcmXflyX4W59qE6SF2TuOj+LT0ztcBbAQ6riMZolsDswojULekl9?=
 =?us-ascii?Q?VhBSC0FJu093un6xuDtjsdJO9TEBMeHgUYZco57Rh00i7vLNSZc7GXrRg6Zt?=
 =?us-ascii?Q?RUwTHZMAro1SiGQpL71ExFV+Xk/AETSTIeA7of5m5trrLzSIUzj0Ag7qDtqj?=
 =?us-ascii?Q?1xiVc+qNwO1UgDAePzJdW0viBMeGfpG0gcaAoj1AaXHId1SsX8bLJAPJdDqT?=
 =?us-ascii?Q?9VNW+aIzGkeDWR3BQuwvgODvFZOV32OW3SCYpx4Wu5obe4MfLQkK3G7woYGO?=
 =?us-ascii?Q?NvmMtwkbSokheBrYytQ3+HJvej9a0qzlqHOahp65kYTl6XNJ2iadgJEJ9Tec?=
 =?us-ascii?Q?CVK1OCUWVbhbz2UfpvnB5zmmK44pFadYcyi41pksycifJbD78Si9G/cgLyCM?=
 =?us-ascii?Q?uTAeVpsKIik+Z5ZPX8RoDaynkKpgiTCS4N+N+VqSBBt1lIAj8QpFCSQpUbTz?=
 =?us-ascii?Q?xgy7UKVAe37HDCljzSyiWkyP0HtuUILfpaIZfaH6zEW1jyfgXH58C6NF3UkR?=
 =?us-ascii?Q?khYC3l83ye+pouYeekLUjjcCJDOonURahy0c6Be/7iBu5vrsiWP3ISYl/iKd?=
 =?us-ascii?Q?DybHgao36LtIUWamXlTPBLlN+bC30gVL/BgNCP6r7WDdIsjIGywxD92fYoNU?=
 =?us-ascii?Q?IDN+I+lHDJXDEf08rWEPvXcDWEV+gV+pRXJmEuPWgPAxSRoIPeeHbL5Q4bhG?=
 =?us-ascii?Q?ntNIH66RHunZPWZ3lLvXgPwrx/QDjruEC1i4dyqCS8kG5IDj/n8ItfzxwIq/?=
 =?us-ascii?Q?niO3ZonNMq8HK2MR02KmzXpNTWZQfkRzG/8NfrxYV1GfiLXhgwLaTuB00Ouw?=
 =?us-ascii?Q?tmbJsThMMOWKraGAJdKc7qKoYvH37ww86RRI9aeQ1iiUZOwV6AgICmeEaHXe?=
 =?us-ascii?Q?F1LYU/RYABtrN2oVe+Bqyao6BJXJDyvFQXZAy1oPYcrcTLMsJmnZJybTR59y?=
 =?us-ascii?Q?a/TC9nCx7CNNiL75qEjoQZ20u3RJOeICpv0vd4+E4qFO2A7aUmExzCRiYgD3?=
 =?us-ascii?Q?4PEHzmiqWqQ1m1nLIrRo3qiEAXybOLtCOr34E5BRIH3WSGTpy0p4Rj/NiRvg?=
 =?us-ascii?Q?lJcOFPGbmpAJV67wLNOrsQOXCufzJUTLrJmjM5f5Oi5J/49zXyIEVsUuJ/1u?=
 =?us-ascii?Q?k+LytNkrfSgZnvvk+K2LxuJFTR5bQHzIwB7gxzQyt0/dwYjcyAd24STAQEAk?=
 =?us-ascii?Q?ZezKD4iH5soNpWLpDIW6o6Nck/cwDDSpGPHdlUocbNUSpt6veB4HEbZuUpnf?=
 =?us-ascii?Q?/c8MlDzUXQYFNQ+ucxuyRayRj0kRXSnyolBMZLpOm5KT1rlbeJQum8NpPywB?=
 =?us-ascii?Q?VA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b00545f-8b8f-4ae0-d2d1-08da7b6ac058
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 07:26:05.1548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N46hpew1o/ccJAGFgBRce25Tr94UlzvqGR5OxjH74HW7ZYd97Vlgt8SWz983lSqMDuO8gorlfCgsFL26zCohbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3209
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-11_03,2022-08-10_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208110019
X-Proofpoint-GUID: YTQ-qtCnZh4F1Kyl1gK4VoxWi9grwK_Z
X-Proofpoint-ORIG-GUID: YTQ-qtCnZh4F1Kyl1gK4VoxWi9grwK_Z
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

This RFC patch is implementing the sysfs work mentioned in [1]. Since the
approach taken in [1] was not proper, I am sending this RFC patch as a 
separate change. 

[1]: https://lore.kernel.org/lkml/20220727234241.1423357-1-imran.f.khan@oracle.com/

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

