Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C258C53F077
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbiFFUrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbiFFUos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:44:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92F8101928
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:39:28 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 256KTBDS014043;
        Mon, 6 Jun 2022 20:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=jRb62iV3P9PpV4yoLcVaxwYDz8c9aQiErYxdrxBDqWw=;
 b=cmeIra3qJnDkYOKdJ7TGByZa7V3UXvPd6hAGrajBW13N20VpS+XcLjdBSarDvX0mnfce
 AFMb/0r1KGRPIS/Sqv61xR4zvuwh/OiXNoupWxbZBBIPJymYfQqvK/qJnL6EY3XnSD6X
 9bly7fITASTdGcjROo18dYKCBR/fpDrNPinEF8255FFxeOijCp4YaCkePpEYLw/dEiXy
 jG/GD3X3VdHXkepC4SPbNASy8CMih5hNb71US0ppZ4Mqx6QRQdldq7M76wqQs4GX4X11
 zBZIKyl453NCP7hKhv4z4GelqP/RRETZAiJdQZdqIbl+gJ9T4pqgwi1edEhmGDcoKamX TA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ghqad85sg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 20:39:04 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 256KGY1M035885;
        Mon, 6 Jun 2022 20:39:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gfwu1vf4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 20:39:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SaDxmUbpv+lwsHSquagznA/Gwz2BYzQy/jg5e5yn98bskrYPbu0eT9eJiZOA+r3LyLDyV0hgkFUTF3lUttPW/na7SdPlbQP3PeKy/clF5KphOu0BtqUjROUzbVbmob9tQ42HwjCxDz9TaWywvhkcPuzdo72RN97CmZG/K3by02GtIdPuKVgLkvjzOD2uZlssWrBTbTUBGrboh+U/aeNEJ8O+hmtb87MP8Gzi2s5Qy5xktL5Ft3Ua8lt+2zf+azt9j6hFeALWjnRIYh3sb0CVl29zPL0Swb25aMM0oON6pk8wyv5xvz/DiSu6DOto8HW+/C22XWRaf7P77kUTH27/vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRb62iV3P9PpV4yoLcVaxwYDz8c9aQiErYxdrxBDqWw=;
 b=W3v/M5Gfi9wOUb+EkdXZ4LQ5c0LAd67YNGx8tPJUyF0GNscJJ2wvQwslbAZ/tq5uI9GK2V5A9GK8ReDZtUvUqO5pcJF3JFY9ViDnvhBXYXgxkT5QjKI3EHOeUhcH2W3SkVJlpGR46i1BH6cpcfmM/pmCa0x4e9RBuzVfBMaPdlDk/elpfzaOm4lU1Iy9iMFGNMqFs+BDSkmUkIHbHPngmXu7c56ZK0ILQBrPOkff9iDXM/X/45EY3elnaRBCFc2ZTy/oSU+s6JoClv/5BziIDy5m1CsQs17exRAmIE6HVkCdhlsYRDpExHXJBuIGyZ5SA3LHV8RQEbupYPSneKHmuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRb62iV3P9PpV4yoLcVaxwYDz8c9aQiErYxdrxBDqWw=;
 b=tfZjyoQJG1FZ+C8k9aZZdHpC36iU1klae3k46+qIUGHwcgTQx+QlZAi0QnzGXn2DdomAMV9+HPSLAiDbStd7m4hjiEo2rFAFq2JkJQ/3vvWK5Wqvjjtn4qxtH610VYch+FuNjWkKTDvIfKXUl3P3cDKuwUtVhcxkn6uzS6/9Iys=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 SN6PR10MB2734.namprd10.prod.outlook.com (2603:10b6:805:41::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.12; Mon, 6 Jun 2022 20:39:01 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08%5]) with mapi id 15.20.5314.018; Mon, 6 Jun 2022
 20:39:01 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, mingo@kernel.org, luto@kernel.org,
        tglx@linutronix.de, bp@alien8.de, peterz@infradead.org,
        ak@linux.intel.com, arnd@arndb.de, jgg@nvidia.com,
        jon.grimm@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, joao.m.martins@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v3 19/21] gup: hint non-caching if clearing large regions
Date:   Mon,  6 Jun 2022 20:37:23 +0000
Message-Id: <20220606203725.1313715-15-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
References: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0141.namprd11.prod.outlook.com
 (2603:10b6:806:131::26) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47c397d6-003f-4246-10b9-08da47fc96b3
X-MS-TrafficTypeDiagnostic: SN6PR10MB2734:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB273402C59034F89A371F3852CEA29@SN6PR10MB2734.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZbnFCVErSmkrda3KOVHivYwVP4LXwtfdWBVwonaYdfzeonRH8spl9w6rTVWNHml4Pnwvmir+Sa8pPj0N67lB9QBWCcnYbpqEqSkQsoQtWWG10TUUgik79UAuK3G+Pd6wpRh2yvGHJUTyApn02o9/qVpSl83Lp7lwhWUQwS4sm1jhDgy6xUDc/i6M5sOEjfHDViEfRTWm25IK8ba37epENRhp7PVjwKBJwFsm9G/SHT5OeDvfXGxrpVHHKDyvcsOUOnne7xFgLyiFKXEKw5Q5dBFAV25Ukupg/b65ydgysPvugl7dBhnyfIK4vfGetexJCKpMB0L/E6nPALMNmdjKBNnRYqPtZL1QhUEraPJdkoyEA98LP+rXirqbuBu3jn1nQ4jvW+CsRrHQq4Zv1uIhYUTiy+Gg5HjG69sEqqmAGtA2EO73acJ81n+hTwO38ddLM+ozEBme0rWoOfdx2YuLo4difXkInQRMBlRDRvbaGpO/bgARs6QRcv+JedsT7/1riPbFPGc7+cRMww+kMWJCb5eTbxj0f6HCWkGoC8361fTdRDjZeqXfjSu6TStXS6bedhAYc24v4xP6pbXU+M8bGOeZS0eAQi1U34x3PwpCTTfstG2JNwx3HUKsYZxCtNVhb3hSF078JdwDeiItNd3k88kKWiqO60Vb0udNMQlM1hH8uuaxxtoVJz7SaBDUbewv+pJmT4uwqiRp69S46BYnCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(83380400001)(52116002)(4326008)(2906002)(6506007)(1076003)(8676002)(186003)(508600001)(38100700002)(38350700002)(86362001)(30864003)(6486002)(2616005)(103116003)(6666004)(66556008)(36756003)(107886003)(7416002)(6512007)(26005)(316002)(5660300002)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xZXRejXXLeMvuyacK+1Cpo/3oyyPji1q8Gcg3M6/u/fqKewCOsEbNPRFH76Y?=
 =?us-ascii?Q?oxRLFQBYc0bF0KV8HmHT/SJM+zNYhBDaf3uQWOHYuzEluR5VLgwqpjbLXnBi?=
 =?us-ascii?Q?gXVrl7sSKdHxbjWybf9Df4yH4+7NHQsO2pmI/XUkG91iBFqhCj4P3/UkFmIP?=
 =?us-ascii?Q?jIlxUhho9RkaM3hWjxL9UQlnNj1O0L3j/0sufnjrpJ6KK0LDExg1n/vWcumI?=
 =?us-ascii?Q?b4cimNY0GDilHUfHfk7daMgpg93LurPfJlsm0ydTWL7PBAtoRdCs/QWeDACf?=
 =?us-ascii?Q?W5Kc536HyWRmIqtZSuug3G8TroAEnPaNdrztxOwmIw18krUGNBKhfdefZ4oJ?=
 =?us-ascii?Q?0BENdBxHM+lYew/iq4iFfbRaq4it8SjODk5PJr4/yfB+H4AikZ2eovg9OpTw?=
 =?us-ascii?Q?P+YeizuFc8AaNNJ8yrKXHgyoY7ulktZbxLIs6SPsHMurDjVX2sz4McV5guhQ?=
 =?us-ascii?Q?78eSRc7dqFd6TCXsMY+A/hvjInqiAeWu6c5Qd9JLEqgDn8XMi9wrSXXKslKj?=
 =?us-ascii?Q?+43oVPeslb/gU/Kuc6WSQRoeCskLv5MTOPo91SsC0BSFRwp9pzB2ll+wUPOq?=
 =?us-ascii?Q?YdDiYwPYo28g1+a2Y3SF40jcGwUWQ9HHu1r9xzmcaeJpkGbwNJV2rQwdKJfs?=
 =?us-ascii?Q?3k3oRg0t2yjhMWAUjNO3vBNSwtjaub+TRmqppQsPYTWwafLJtj4PqqijOyWw?=
 =?us-ascii?Q?0XJTebk8lrK8eA81uMHQYpqQgn55zuX94MAtcGIzO76jqWMJTVta9LiXwOLJ?=
 =?us-ascii?Q?at7SEBdqO7FEQ52nI84jQcSrIw54S2iQ8hs2mBU1DQN9JM8j70/aHpfzQMEF?=
 =?us-ascii?Q?C2ZSMiQttzWfzdJ8piVfLmgGqrNGdmKYlSzrwkLxoaZKlD6sJngkVw8g13eg?=
 =?us-ascii?Q?/QhRELQl5cqYQfTxWRgZk2SLPf0WmoTG+Y9Xc/MCJPV7ZNiG9drCHTZ9ue8z?=
 =?us-ascii?Q?gkvb5zcbOzaOUZbhOl/i3TMc5NWt171sTAuN1pe8FNCy4aRclFFE0EZb+ZKk?=
 =?us-ascii?Q?s+dQBi+QLe2BqtaIPOqGBTlrqBsHO+51qJFmqgnipnzmjzqyTpSzXSDF7IS4?=
 =?us-ascii?Q?3nmzEJrQwtlO0e2ZbcxgAhpRqtv5S8N4vpsAKvzZFescBvpg3ZzQZgPOt5e3?=
 =?us-ascii?Q?CPNIcckgzlvvZFfsx/QOwU3Jc0CZPnQQl/xs7BlS4A3XmM293gIoHt7rCKRB?=
 =?us-ascii?Q?dYCNUBwlYH+DXb4H1xplQS5PXUtziXsHcUU7s+WS2JftjEQ/Ax6/vIQd5ouf?=
 =?us-ascii?Q?NYos4y80yH3u6KhNX0ey3p4Y3cNuzhnVrGUgwc2rm4I6WODKZ9jxv/hFHj5Y?=
 =?us-ascii?Q?XlmtzhH1Glp/OaAl7rqvRnU31XM38UWEIFf50aa8JY4pVlgBmtETsb5a1q6J?=
 =?us-ascii?Q?FDtbJoS3YK8ehnibNA3EINnPxwN0ogxbXj74QvjoAhXkToedPhtg2avI+BdJ?=
 =?us-ascii?Q?mlh6PpeBhFCuXo3v0g+l3K2gyozp5nEix7Dtx/vAVmEuJp5Mswi7inKp4yve?=
 =?us-ascii?Q?vKrFSxKwE2JetyQVoDhl33jT5yqaI9WZeH25gQ2iyvJj4/WHTXbtud5xYGMy?=
 =?us-ascii?Q?6uwieTzr7DBFzMCStIVBQyp3eAxfgCVH5oWErrmYMpmLeTEuznKCQHlmRr12?=
 =?us-ascii?Q?/FrZQIOw47lSnPwNwikHcSBKdgkxG4rqh5OYKQjpsIUwVYadbkjJIIiqQe6U?=
 =?us-ascii?Q?YvzIku9miPTjP3fWx62F4BIUpBPXrgoX4Xj+EKOiXUFJEjX+1s6c3bG+Yyn4?=
 =?us-ascii?Q?uwTNHsSXSqAiZ7/PAywsfxDucKaRJGw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c397d6-003f-4246-10b9-08da47fc96b3
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 20:39:01.3400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FyCUgTHmE+x4212QRpM9WnBcVSsdMZACkyS3au+l+52TB4PKjst49HIxDsu3H1WRy/bbwPKn4igZTSQlq3NNlBjhJOoLESf6iXDCVO60X04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2734
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-06_06:2022-06-02,2022-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206060081
X-Proofpoint-ORIG-GUID: jJd2z4J5k21SRI9vZmNXTzw5_sKjqLAy
X-Proofpoint-GUID: jJd2z4J5k21SRI9vZmNXTzw5_sKjqLAy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When clearing a large region, or when the user explicitly hints
via FOLL_HINT_BULK that a call to get_user_pages() is part of a larger
region being gup'd, take the non-caching path.

One notable limitation is that this is only done when the underlying
pages are huge or gigantic, even if a large region composed of PAGE_SIZE
pages is being cleared. This is because non-caching stores are generally
weakly ordered and need some kind of store fence -- at PTE write
granularity -- to avoid data leakage. This is expensive enough to
negate any performance advantage.

Performance
==

System:    Oracle X9-2c (2 nodes * 32 cores * 2 threads)
Processor: Intel Xeon(R) Platinum 8358 CPU @ 2.60GHz (Icelakex, 6:106:6)
Memory:    1024 GB evenly split between nodes
LLC-size:  48MB for each node (32-cores * 2-threads)
no_turbo: 1, Microcode: 0xd0002c1, scaling-governor: performance

System:    Oracle E4-2c (2 nodes * 8 CCXes * 8 cores * 2 threads)
Processor: AMD EPYC 7J13 64-Core Processor (Milan, 25:1:1)
Memory:    512 GB evenly split between nodes
LLC-size:  32MB for each CCX (8-cores * 2-threads)
boost: 1, Microcode: 0xa00115d, scaling-governor: performance

Two workloads: qemu VM creation where that is the exclusive load
and, to probe the cache interference with unrelated processes aspect
of these changes, a kbuild with a background page clearing workload.

Workload: create a 192GB qemu-VM (backed by preallocated 2MB
pages on the local node)
==

Icelakex
--
                          Time (s)        Delta (%)
 clear_pages_erms()    16.49 ( +- 0.06s )            # 12.50 bytes/ns
 clear_pages_movnt()    9.42 ( +- 0.20s )  -42.87%   # 21.88 bytes/ns

It is easy enough to see where the improvement is coming from -- given
the non-caching stores, the CPU does not need to do any RFOs ending up
with way fewer L1-dcache-load-misses:

-      407,619,058      L1-dcache-loads           #   24.746 M/sec                    ( +-  0.17% )  (69.20%)
-    3,245,399,461      L1-dcache-load-misses     #  801.49% of all L1-dcache accesses  ( +-  0.01% )  (69.22%)
+      393,160,148      L1-dcache-loads           #   41.786 M/sec                    ( +-  0.80% )  (69.22%)
+        5,790,543      L1-dcache-load-misses     #    1.50% of all L1-dcache accesses  ( +-  1.55% )  (69.26%)

(Fuller perf stat output, at [1], [2].)

Milan
--
                          Time (s)          Delta
 clear_pages_erms()    11.83 ( +- 0.08s )            # 17.42 bytes/ns
 clear_pages_clzero()   4.91 ( +- 0.27s )  -58.49%   # 41.98 bytes/ns

Milan does significantly fewer RFO, as well.

-    6,882,968,897      L1-dcache-loads           #  582.960 M/sec                    ( +-  0.03% )  (33.38%)
-    3,267,546,914      L1-dcache-load-misses     #   47.45% of all L1-dcache accesses  ( +-  0.02% )  (33.37%)
+      418,489,450      L1-dcache-loads           #   85.611 M/sec                    ( +-  1.19% )  (33.46%)
+        5,406,557      L1-dcache-load-misses     #    1.35% of all L1-dcache accesses  ( +-  1.07% )  (33.45%)

(Fuller perf stat output, at [3], [4].)

Workload: Kbuild with background clear_huge_page()
==

Probe the cache-pollution aspect of this commit with a kbuild
(make -j 32 bzImage) alongside a background process doing
clear_huge_page() via mmap(length=64GB, flags=MAP_POPULATE|MAP_HUGE_2MB)
in a loop.

The expectation -- assuming kbuild performance is partly cache
limited -- is that the clear_huge_page() -> clear_pages_erms()
background load would show a greater slowdown than,
clear_huge_page() -> clear_pages_movnt(). The kbuild itself does not
use THP or similar, so any performance changes are due to the
background load.

Icelakex
--

 # kbuild: 16 cores, 32 threads
 # clear_huge_page() load: single thread bound to the same CPUset
 # taskset -c 16-31,80-95 perf stat -r 5 -ddd	\
	make -C .. -j 32 O=b2 clean bzImage

-  8,226,884,900,694      instructions              #    1.09  insn per cycle           ( +-  0.02% )  (47.27%)
+  8,223,413,950,371      instructions              #    1.12  insn per cycle           ( +-  0.03% )  (47.31%)

- 20,016,410,480,886      slots                     #    6.565 G/sec                    ( +-  0.01% )  (69.84%)
-  1,310,070,777,023      topdown-be-bound          #      6.1% backend bound           ( +-  0.28% )  (69.84%)
+ 19,328,950,611,944      slots                     #    6.494 G/sec                    ( +-  0.02% )  (69.87%)
+  1,043,408,291,623      topdown-be-bound          #      5.0% backend bound           ( +-  0.33% )  (69.87%)

-     10,747,834,729      LLC-loads                 #    3.525 M/sec                    ( +-  0.05% )  (69.68%)
-      4,841,355,743      LLC-load-misses           #   45.02% of all LL-cache accesses  ( +-  0.06% )  (69.70%)
+     10,466,865,056      LLC-loads                 #    3.517 M/sec                    ( +-  0.08% )  (69.68%)
+      4,206,944,783      LLC-load-misses           #   40.21% of all LL-cache accesses  ( +-  0.06% )  (69.71%)

The LLC-load-misses show a significant improvement (-13.11%) which is
borne out in the (-20.35%) reduction in topdown-be-bound and a (2.7%)
improvement in IPC.

- 7,521,157,276,899      cycles                    #    2.467 GHz                      ( +-  0.02% )  (39.65%)
+ 7,348,971,235,549      cycles                    #    2.469 GHz                      ( +-  0.04% )  (39.68%)

The ends up with an overall improvement in cycles of (-2.28%).

(Fuller perf stat output, at [5], [6].)

Milan
--

 # kbuild: 2 CCxes, 16 cores, 32 threads
 # clear_huge_page() load: single thread bound to the same CPUset
 # taskset -c 16-31,144-159 perf stat -r 5 -ddd	\
	make -C .. -j 32 O=b2 clean bzImage

-   302,739,130,717      stalled-cycles-backend    #    3.82% backend cycles idle      ( +-  0.10% )  (41.11%)
+   287,703,667,307      stalled-cycles-backend    #    3.74% backend cycles idle      ( +-  0.04% )  (41.11%)

- 8,981,403,534,446      instructions              #    1.13  insn per cycle
+ 8,969,062,192,998      instructions              #    1.16  insn per cycle

Milan sees a (-4.96%) improvement in stalled-cycles-backend and
a (-2.65%) improvement in IPC.

- 7,930,842,057,103      cycles                    #    2.338 GHz                      ( +-  0.04% )  (41.09%)
+ 7,705,812,395,365      cycles                    #    2.339 GHz                      ( +-  0.01% )  (41.11%)

The ends up with an overall improvement in cycles of (-2.83%).

(Fuller perf stat output, at [7], [8].)

[1] Icelakex, clear_pages_erms()
 # perf stat -r 5 --all-kernel -ddd ./qemu.sh

 Performance counter stats for './qemu.sh' (5 runs):

         16,329.41 msec task-clock                #    0.990 CPUs utilized            ( +-  0.42% )
               143      context-switches          #    8.681 /sec                     ( +-  0.93% )
                 1      cpu-migrations            #    0.061 /sec                     ( +- 63.25% )
               118      page-faults               #    7.164 /sec                     ( +-  0.27% )
    41,735,523,673      cycles                    #    2.534 GHz                      ( +-  0.42% )  (38.46%)
     1,454,116,543      instructions              #    0.03  insn per cycle           ( +-  0.49% )  (46.16%)
       266,749,920      branches                  #   16.194 M/sec                    ( +-  0.41% )  (53.86%)
           928,726      branch-misses             #    0.35% of all branches          ( +-  0.38% )  (61.54%)
   208,805,754,709      slots                     #   12.676 G/sec                    ( +-  0.41% )  (69.23%)
     5,355,889,366      topdown-retiring          #      2.5% retiring                ( +-  0.50% )  (69.23%)
    12,720,749,784      topdown-bad-spec          #      6.1% bad speculation         ( +-  1.38% )  (69.23%)
       998,710,552      topdown-fe-bound          #      0.5% frontend bound          ( +-  0.85% )  (69.23%)
   192,653,197,875      topdown-be-bound          #     90.9% backend bound           ( +-  0.38% )  (69.23%)
       407,619,058      L1-dcache-loads           #   24.746 M/sec                    ( +-  0.17% )  (69.20%)
     3,245,399,461      L1-dcache-load-misses     #  801.49% of all L1-dcache accesses  ( +-  0.01% )  (69.22%)
        10,805,747      LLC-loads                 #  656.009 K/sec                    ( +-  0.37% )  (69.25%)
           804,475      LLC-load-misses           #    7.44% of all LL-cache accesses  ( +-  2.73% )  (69.26%)
   <not supported>      L1-icache-loads
        18,134,527      L1-icache-load-misses                                         ( +-  1.24% )  (30.80%)
       435,474,462      dTLB-loads                #   26.437 M/sec                    ( +-  0.28% )  (30.80%)
            41,187      dTLB-load-misses          #    0.01% of all dTLB cache accesses  ( +-  4.06% )  (30.79%)
   <not supported>      iTLB-loads
           440,135      iTLB-load-misses                                              ( +-  1.07% )  (30.78%)
   <not supported>      L1-dcache-prefetches
   <not supported>      L1-dcache-prefetch-misses

           16.4906 +- 0.0676 seconds time elapsed  ( +-  0.41% )

[2] Icelakex, clear_pages_movnt()
 # perf stat -r 5 --all-kernel -ddd ./qemu.sh

 Performance counter stats for './qemu.sh' (5 runs):

          9,896.77 msec task-clock                #    1.050 CPUs utilized            ( +-  2.08% )
               135      context-switches          #   14.348 /sec                     ( +-  0.74% )
                 0      cpu-migrations            #    0.000 /sec
               116      page-faults               #   12.329 /sec                     ( +-  0.50% )
    25,239,642,558      cycles                    #    2.683 GHz                      ( +-  2.11% )  (38.43%)
    36,791,658,500      instructions              #    1.54  insn per cycle           ( +-  0.06% )  (46.12%)
     3,475,279,229      branches                  #  369.361 M/sec                    ( +-  0.09% )  (53.82%)
         1,987,098      branch-misses             #    0.06% of all branches          ( +-  0.71% )  (61.51%)
   126,256,220,768      slots                     #   13.419 G/sec                    ( +-  2.10% )  (69.21%)
    57,705,186,453      topdown-retiring          #     47.8% retiring                ( +-  0.28% )  (69.21%)
     5,934,729,245      topdown-bad-spec          #      4.3% bad speculation         ( +-  5.91% )  (69.21%)
     4,089,990,217      topdown-fe-bound          #      3.1% frontend bound          ( +-  2.11% )  (69.21%)
    60,298,426,167      topdown-be-bound          #     44.8% backend bound           ( +-  4.21% )  (69.21%)
       393,160,148      L1-dcache-loads           #   41.786 M/sec                    ( +-  0.80% )  (69.22%)
         5,790,543      L1-dcache-load-misses     #    1.50% of all L1-dcache accesses  ( +-  1.55% )  (69.26%)
         1,069,049      LLC-loads                 #  113.621 K/sec                    ( +-  1.25% )  (69.27%)
           728,260      LLC-load-misses           #   70.65% of all LL-cache accesses  ( +-  2.63% )  (69.30%)
   <not supported>      L1-icache-loads
        14,620,549      L1-icache-load-misses                                         ( +-  1.27% )  (30.80%)
       404,962,421      dTLB-loads                #   43.040 M/sec                    ( +-  1.13% )  (30.80%)
            31,916      dTLB-load-misses          #    0.01% of all dTLB cache accesses  ( +-  4.61% )  (30.77%)
   <not supported>      iTLB-loads
           396,984      iTLB-load-misses                                              ( +-  2.23% )  (30.74%)
   <not supported>      L1-dcache-prefetches
   <not supported>      L1-dcache-prefetch-misses

             9.428 +- 0.206 seconds time elapsed  ( +-  2.18% )

[3] Milan, clear_pages_erms()
 # perf stat -r 5 --all-kernel -ddd ./qemu.sh

 Performance counter stats for './qemu.sh' (5 runs):

         11,676.79 msec task-clock                #    0.987 CPUs utilized            ( +-  0.68% )
                96      context-switches          #    8.131 /sec                     ( +-  0.78% )
                 2      cpu-migrations            #    0.169 /sec                     ( +- 18.71% )
               106      page-faults               #    8.978 /sec                     ( +-  0.23% )
    28,161,726,414      cycles                    #    2.385 GHz                      ( +-  0.69% )  (33.33%)
       141,032,827      stalled-cycles-frontend   #    0.50% frontend cycles idle     ( +- 52.44% )  (33.35%)
       796,792,139      stalled-cycles-backend    #    2.80% backend cycles idle      ( +- 23.73% )  (33.35%)
     1,140,172,646      instructions              #    0.04  insn per cycle
                                                  #    0.50  stalled cycles per insn  ( +-  0.89% )  (33.35%)
       219,864,061      branches                  #   18.622 M/sec                    ( +-  1.06% )  (33.36%)
         1,407,446      branch-misses             #    0.63% of all branches          ( +- 10.66% )  (33.40%)
     6,882,968,897      L1-dcache-loads           #  582.960 M/sec                    ( +-  0.03% )  (33.38%)
     3,267,546,914      L1-dcache-load-misses     #   47.45% of all L1-dcache accesses  ( +-  0.02% )  (33.37%)
   <not supported>      LLC-loads
   <not supported>      LLC-load-misses
       146,901,513      L1-icache-loads           #   12.442 M/sec                    ( +-  0.78% )  (33.36%)
         1,462,155      L1-icache-load-misses     #    0.99% of all L1-icache accesses  ( +-  0.83% )  (33.34%)
         2,055,805      dTLB-loads                #  174.118 K/sec                    ( +- 22.56% )  (33.33%)
           136,260      dTLB-load-misses          #    4.69% of all dTLB cache accesses  ( +- 23.13% )  (33.35%)
               941      iTLB-loads                #   79.699 /sec                     ( +-  5.54% )  (33.35%)
           115,444      iTLB-load-misses          # 14051.12% of all iTLB cache accesses  ( +- 21.17% )  (33.34%)
        95,438,373      L1-dcache-prefetches      #    8.083 M/sec                    ( +- 19.99% )  (33.34%)
   <not supported>      L1-dcache-prefetch-misses

           11.8296 +- 0.0805 seconds time elapsed  ( +-  0.68% )

[4] Milan, clear_pages_clzero()
 # perf stat -r 5 --all-kernel -ddd ./qemu.sh

 Performance counter stats for './qemu.sh' (5 runs):

          4,599.00 msec task-clock                #    0.937 CPUs utilized            ( +-  5.93% )
                91      context-switches          #   18.616 /sec                     ( +-  0.92% )
                 0      cpu-migrations            #    0.000 /sec
               107      page-faults               #   21.889 /sec                     ( +-  0.19% )
    10,975,453,059      cycles                    #    2.245 GHz                      ( +-  6.02% )  (33.28%)
        14,193,355      stalled-cycles-frontend   #    0.12% frontend cycles idle     ( +-  1.90% )  (33.35%)
        38,969,144      stalled-cycles-backend    #    0.33% backend cycles idle      ( +- 23.92% )  (33.34%)
    13,951,880,530      instructions              #    1.20  insn per cycle
                                                  #    0.00  stalled cycles per insn  ( +-  0.11% )  (33.33%)
     3,426,708,418      branches                  #  701.003 M/sec                    ( +-  0.06% )  (33.36%)
         2,350,619      branch-misses             #    0.07% of all branches          ( +-  0.61% )  (33.45%)
       418,489,450      L1-dcache-loads           #   85.611 M/sec                    ( +-  1.19% )  (33.46%)
         5,406,557      L1-dcache-load-misses     #    1.35% of all L1-dcache accesses  ( +-  1.07% )  (33.45%)
   <not supported>      LLC-loads
   <not supported>      LLC-load-misses
        90,088,059      L1-icache-loads           #   18.429 M/sec                    ( +-  0.36% )  (33.44%)
         1,081,035      L1-icache-load-misses     #    1.20% of all L1-icache accesses  ( +-  3.67% )  (33.42%)
         4,017,464      dTLB-loads                #  821.854 K/sec                    ( +-  1.02% )  (33.40%)
           204,096      dTLB-load-misses          #    5.22% of all dTLB cache accesses  ( +-  9.77% )  (33.36%)
               770      iTLB-loads                #  157.519 /sec                     ( +-  5.12% )  (33.36%)
           209,834      iTLB-load-misses          # 29479.35% of all iTLB cache accesses  ( +-  0.17% )  (33.34%)
         1,596,265      L1-dcache-prefetches      #  326.548 K/sec                    ( +-  1.55% )  (33.31%)
   <not supported>      L1-dcache-prefetch-misses

             4.908 +- 0.272 seconds time elapsed  ( +-  5.54% )

[5] Icelakex, kbuild + bg:clear_pages_erms() load.
 # taskset -c 16-31,80-95 perf stat -r 5 -ddd	\
	make -C .. -j 32 O=b2 clean bzImage

 Performance counter stats for 'make -C .. -j 32 O=b2 clean bzImage' (5 runs):

      3,047,329.07 msec task-clock                #   19.520 CPUs utilized            ( +-  0.02% )
         1,675,061      context-switches          #  549.415 /sec                     ( +-  0.43% )
            89,232      cpu-migrations            #   29.268 /sec                     ( +-  2.34% )
        85,752,972      page-faults               #   28.127 K/sec                    ( +-  0.00% )
 7,521,157,276,899      cycles                    #    2.467 GHz                      ( +-  0.02% )  (39.65%)
 8,226,884,900,694      instructions              #    1.09  insn per cycle           ( +-  0.02% )  (47.27%)
 1,744,557,848,503      branches                  #  572.209 M/sec                    ( +-  0.02% )  (54.83%)
    36,252,079,075      branch-misses             #    2.08% of all branches          ( +-  0.02% )  (62.35%)
20,016,410,480,886      slots                     #    6.565 G/sec                    ( +-  0.01% )  (69.84%)
 6,518,990,385,998      topdown-retiring          #     30.5% retiring                ( +-  0.02% )  (69.84%)
 7,821,817,193,732      topdown-bad-spec          #     36.7% bad speculation         ( +-  0.29% )  (69.84%)
 5,714,082,318,274      topdown-fe-bound          #     26.7% frontend bound          ( +-  0.10% )  (69.84%)
 1,310,070,777,023      topdown-be-bound          #      6.1% backend bound           ( +-  0.28% )  (69.84%)
 2,270,017,283,501      L1-dcache-loads           #  744.558 M/sec                    ( +-  0.02% )  (69.60%)
   103,295,556,544      L1-dcache-load-misses     #    4.55% of all L1-dcache accesses  ( +-  0.02% )  (69.64%)
    10,747,834,729      LLC-loads                 #    3.525 M/sec                    ( +-  0.05% )  (69.68%)
     4,841,355,743      LLC-load-misses           #   45.02% of all LL-cache accesses  ( +-  0.06% )  (69.70%)
   <not supported>      L1-icache-loads
   180,672,238,145      L1-icache-load-misses                                         ( +-  0.03% )  (31.18%)
 2,216,149,664,522      dTLB-loads                #  726.890 M/sec                    ( +-  0.03% )  (31.83%)
     2,000,781,326      dTLB-load-misses          #    0.09% of all dTLB cache accesses  ( +-  0.08% )  (31.79%)
   <not supported>      iTLB-loads
     1,938,124,234      iTLB-load-misses                                              ( +-  0.04% )  (31.76%)
   <not supported>      L1-dcache-prefetches
   <not supported>      L1-dcache-prefetch-misses

          156.1136 +- 0.0785 seconds time elapsed  ( +-  0.05% )

[6] Icelakex, kbuild + bg:clear_pages_movnt() load.
 # taskset -c 16-31,80-95 perf stat -r 5 -ddd	\
	make -C .. -j 32 O=b2 clean bzImage

 Performance counter stats for 'make -C .. -j 32 O=b2 clean bzImage' (5 runs):

      2,978,535.47 msec task-clock                #   19.471 CPUs utilized            ( +-  0.05% )
         1,637,295      context-switches          #  550.105 /sec                     ( +-  0.89% )
            91,635      cpu-migrations            #   30.788 /sec                     ( +-  1.88% )
        85,754,138      page-faults               #   28.812 K/sec                    ( +-  0.00% )
 7,348,971,235,549      cycles                    #    2.469 GHz                      ( +-  0.04% )  (39.68%)
 8,223,413,950,371      instructions              #    1.12  insn per cycle           ( +-  0.03% )  (47.31%)
 1,743,914,970,674      branches                  #  585.928 M/sec                    ( +-  0.01% )  (54.87%)
    36,188,623,655      branch-misses             #    2.07% of all branches          ( +-  0.05% )  (62.39%)
19,328,950,611,944      slots                     #    6.494 G/sec                    ( +-  0.02% )  (69.87%)
 6,508,801,041,075      topdown-retiring          #     31.7% retiring                ( +-  0.35% )  (69.87%)
 7,581,383,615,462      topdown-bad-spec          #     36.4% bad speculation         ( +-  0.43% )  (69.87%)
 5,521,686,808,149      topdown-fe-bound          #     26.8% frontend bound          ( +-  0.14% )  (69.87%)
 1,043,408,291,623      topdown-be-bound          #      5.0% backend bound           ( +-  0.33% )  (69.87%)
 2,269,475,492,575      L1-dcache-loads           #  762.507 M/sec                    ( +-  0.03% )  (69.63%)
   101,544,979,642      L1-dcache-load-misses     #    4.47% of all L1-dcache accesses  ( +-  0.05% )  (69.66%)
    10,466,865,056      LLC-loads                 #    3.517 M/sec                    ( +-  0.08% )  (69.68%)
     4,206,944,783      LLC-load-misses           #   40.21% of all LL-cache accesses  ( +-  0.06% )  (69.71%)
   <not supported>      L1-icache-loads
   180,267,126,923      L1-icache-load-misses                                         ( +-  0.07% )  (31.17%)
 2,216,010,317,050      dTLB-loads                #  744.544 M/sec                    ( +-  0.03% )  (31.82%)
     1,979,801,744      dTLB-load-misses          #    0.09% of all dTLB cache accesses  ( +-  0.10% )  (31.79%)
   <not supported>      iTLB-loads
     1,925,390,304      iTLB-load-misses                                              ( +-  0.08% )  (31.77%)
   <not supported>      L1-dcache-prefetches
   <not supported>      L1-dcache-prefetch-misses

           152.972 +- 0.309 seconds time elapsed  ( +-  0.20% )

[7] Milan, clear_pages_erms()
 # taskset -c 16-31,144-159 perf stat -r 5 -ddd  \
	make -C .. -j 32 O=b2 clean bzImage

 Performance counter stats for 'make -C .. -j 32 O=b2 clean bzImage' (5 runs):

      3,390,130.53 msec task-clock                #   18.241 CPUs utilized            ( +-  0.04% )
         1,720,283      context-switches          #  507.160 /sec                     ( +-  0.27% )
            96,694      cpu-migrations            #   28.507 /sec                     ( +-  1.41% )
        75,872,994      page-faults               #   22.368 K/sec                    ( +-  0.00% )
 7,930,842,057,103      cycles                    #    2.338 GHz                      ( +-  0.04% )  (41.09%)
    39,974,518,172      stalled-cycles-frontend   #    0.50% frontend cycles idle     ( +-  0.05% )  (41.10%)
   302,739,130,717      stalled-cycles-backend    #    3.82% backend cycles idle      ( +-  0.10% )  (41.11%)
 8,981,403,534,446      instructions              #    1.13  insn per cycle
                                                  #    0.03  stalled cycles per insn  ( +-  0.03% )  (41.10%)
 1,909,303,327,220      branches                  #  562.886 M/sec                    ( +-  0.02% )  (41.10%)
    50,324,935,298      branch-misses             #    2.64% of all branches          ( +-  0.02% )  (41.09%)
 3,563,297,595,796      L1-dcache-loads           #    1.051 G/sec                    ( +-  0.03% )  (41.08%)
   129,901,339,258      L1-dcache-load-misses     #    3.65% of all L1-dcache accesses  ( +-  0.10% )  (41.07%)
   <not supported>      LLC-loads
   <not supported>      LLC-load-misses
   809,770,606,566      L1-icache-loads           #  238.730 M/sec                    ( +-  0.03% )  (41.07%)
    12,403,758,671      L1-icache-load-misses     #    1.53% of all L1-icache accesses  ( +-  0.08% )  (41.07%)
    60,010,026,089      dTLB-loads                #   17.692 M/sec                    ( +-  0.04% )  (41.07%)
     3,254,066,681      dTLB-load-misses          #    5.42% of all dTLB cache accesses  ( +-  0.09% )  (41.07%)
     5,195,070,952      iTLB-loads                #    1.532 M/sec                    ( +-  0.03% )  (41.08%)
       489,196,395      iTLB-load-misses          #    9.42% of all iTLB cache accesses  ( +-  0.10% )  (41.09%)
    39,920,161,716      L1-dcache-prefetches      #   11.769 M/sec                    ( +-  0.03% )  (41.09%)
   <not supported>      L1-dcache-prefetch-misses

           185.852 +- 0.501 seconds time elapsed  ( +-  0.27% )

[8] Milan, clear_pages_clzero()
 # taskset -c 16-31,144-159 perf stat -r 5 -ddd  \
	make -C .. -j 32 O=b2 clean bzImage

 Performance counter stats for 'make -C .. -j 32 O=b2 clean bzImage' (5 runs):

      3,296,677.12 msec task-clock                #   18.051 CPUs utilized            ( +-  0.02% )
         1,713,645      context-switches          #  520.062 /sec                     ( +-  0.26% )
            91,883      cpu-migrations            #   27.885 /sec                     ( +-  0.83% )
        75,877,740      page-faults               #   23.028 K/sec                    ( +-  0.00% )
 7,705,812,395,365      cycles                    #    2.339 GHz                      ( +-  0.01% )  (41.11%)
    38,866,265,031      stalled-cycles-frontend   #    0.50% frontend cycles idle     ( +-  0.09% )  (41.10%)
   287,703,667,307      stalled-cycles-backend    #    3.74% backend cycles idle      ( +-  0.04% )  (41.11%)
 8,969,062,192,998      instructions              #    1.16  insn per cycle
                                                  #    0.03  stalled cycles per insn  ( +-  0.01% )  (41.11%)
 1,906,857,866,689      branches                  #  578.699 M/sec                    ( +-  0.01% )  (41.10%)
    50,155,411,444      branch-misses             #    2.63% of all branches          ( +-  0.03% )  (41.11%)
 3,552,652,190,906      L1-dcache-loads           #    1.078 G/sec                    ( +-  0.01% )  (41.13%)
   127,238,478,917      L1-dcache-load-misses     #    3.58% of all L1-dcache accesses  ( +-  0.04% )  (41.13%)
   <not supported>      LLC-loads
   <not supported>      LLC-load-misses
   808,024,730,682      L1-icache-loads           #  245.222 M/sec                    ( +-  0.03% )  (41.13%)
     7,773,178,107      L1-icache-load-misses     #    0.96% of all L1-icache accesses  ( +-  0.11% )  (41.13%)
    59,684,355,294      dTLB-loads                #   18.113 M/sec                    ( +-  0.04% )  (41.12%)
     3,247,521,154      dTLB-load-misses          #    5.44% of all dTLB cache accesses  ( +-  0.04% )  (41.12%)
     5,064,547,530      iTLB-loads                #    1.537 M/sec                    ( +-  0.09% )  (41.12%)
       462,977,175      iTLB-load-misses          #    9.13% of all iTLB cache accesses  ( +-  0.07% )  (41.12%)
    39,307,810,241      L1-dcache-prefetches      #   11.929 M/sec                    ( +-  0.06% )  (41.11%)
   <not supported>      L1-dcache-prefetch-misses

           182.630 +- 0.365 seconds time elapsed  ( +-  0.20% )

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---

Notes:
    Not sure if this wall of perf-stats (or indeed the whole kbuild test) is
    warranted here.
    
    To my eyes, there's no non-obvious information in the performance results
    (reducing cache usage should and does lead to other processes getting a small
    bump in performance), so is there any value in keeping this in the commit
    message?

 fs/hugetlbfs/inode.c |  7 ++++++-
 mm/gup.c             | 18 ++++++++++++++++++
 mm/huge_memory.c     |  2 +-
 mm/hugetlb.c         |  9 ++++++++-
 4 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 62408047e8d7..993bb7227a2f 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -650,6 +650,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 	loff_t hpage_size = huge_page_size(h);
 	unsigned long hpage_shift = huge_page_shift(h);
 	pgoff_t start, index, end;
+	bool hint_non_caching;
 	int error;
 	u32 hash;
 
@@ -667,6 +668,9 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 	start = offset >> hpage_shift;
 	end = (offset + len + hpage_size - 1) >> hpage_shift;
 
+	/* Don't pollute the cache if we are fallocte'ing a large region. */
+	hint_non_caching = clear_page_prefer_non_caching((end - start) << hpage_shift);
+
 	inode_lock(inode);
 
 	/* We need to check rlimit even when FALLOC_FL_KEEP_SIZE */
@@ -745,7 +749,8 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 			error = PTR_ERR(page);
 			goto out;
 		}
-		clear_huge_page(page, addr, pages_per_huge_page(h));
+		clear_huge_page(page, addr, pages_per_huge_page(h),
+				hint_non_caching);
 		__SetPageUptodate(page);
 		error = huge_add_to_page_cache(page, mapping, index);
 		if (unlikely(error)) {
diff --git a/mm/gup.c b/mm/gup.c
index 551264407624..bceb6ff64687 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -944,6 +944,13 @@ static int faultin_page(struct vm_area_struct *vma,
 		 */
 		fault_flags |= FAULT_FLAG_TRIED;
 	}
+	if (*flags & FOLL_HINT_BULK) {
+		/*
+		 * This page is part of a large region being faulted-in
+		 * so attempt to minimize cache-pollution.
+		 */
+		fault_flags |= FAULT_FLAG_NON_CACHING;
+	}
 	if (unshare) {
 		fault_flags |= FAULT_FLAG_UNSHARE;
 		/* FAULT_FLAG_WRITE and FAULT_FLAG_UNSHARE are incompatible */
@@ -1116,6 +1123,17 @@ static long __get_user_pages(struct mm_struct *mm,
 	if (!(gup_flags & FOLL_FORCE))
 		gup_flags |= FOLL_NUMA;
 
+	/*
+	 * Non-cached page clearing is generally faster when clearing regions
+	 * larger than O(LLC-size). So hint the non-caching path based on
+	 * clear_page_prefer_non_caching().
+	 *
+	 * Note, however this check is optimistic -- nr_pages is the upper
+	 * limit and we might be clearing less than that.
+	 */
+	if (clear_page_prefer_non_caching(nr_pages * PAGE_SIZE))
+		gup_flags |= FOLL_HINT_BULK;
+
 	do {
 		struct page *page;
 		unsigned int foll_flags = gup_flags;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 73654db77a1c..c7294cffc384 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -594,7 +594,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 	pgtable_t pgtable;
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
 	vm_fault_t ret = 0;
-	bool non_cached = false;
+	bool non_cached = vmf->flags & FAULT_FLAG_NON_CACHING;
 
 	VM_BUG_ON_PAGE(!PageCompound(page), page);
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0c4a31b5c1e9..d906c6558b15 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5481,7 +5481,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	spinlock_t *ptl;
 	unsigned long haddr = address & huge_page_mask(h);
 	bool new_page, new_pagecache_page = false;
-	bool non_cached = false;
+	bool non_cached = flags & FAULT_FLAG_NON_CACHING;
 
 	/*
 	 * Currently, we are forced to kill the process in the event the
@@ -6182,6 +6182,13 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 				 */
 				fault_flags |= FAULT_FLAG_TRIED;
 			}
+			if (flags & FOLL_HINT_BULK) {
+				/*
+				 * From the user hint, we might be faulting-in
+				 * a large region so minimize cache-pollution.
+				 */
+				fault_flags |= FAULT_FLAG_NON_CACHING;
+			}
 			ret = hugetlb_fault(mm, vma, vaddr, fault_flags);
 			if (ret & VM_FAULT_ERROR) {
 				err = vm_fault_to_errno(ret, flags);
-- 
2.31.1

