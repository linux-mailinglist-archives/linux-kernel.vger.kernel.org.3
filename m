Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCD94FAB92
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 04:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243531AbiDJCky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 22:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243419AbiDJCkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 22:40:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D443673CA
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 19:38:05 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 239Dvx65028018;
        Sun, 10 Apr 2022 02:37:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=Gfxrg0N7X+2jUeRRxfKklMIvmi4/26qPXTKfyUbtT18=;
 b=bhBSy0dh5OuGyicEPTIHRxbRSRpQGGddwxL4TL2qylO8h1a4Ay1dHxJGxlgw3HuT72Nk
 6IcrR0uBiraPCkYOc4hFvuPHJM6KQifJfa/NywUb+7QSpBC3P1WPvEQjeRtEsH5I6nS2
 CExnIh7KCf70nmhoLnOkGZ3NZ3doe86J1F2kcDZVI6RkOJmWTbuh+pnxlSKFN1l4ddyr
 6zL36qGXTgY7jCsEjtSmZQPUlUBveDQL2pdd3wFpOZNdx5gfIn62vvWFeDjOja1bcisA
 aK8GO9MxMDxe/JiJfuVCmCG12Ai5ETCLGvGsTQfYjlO7bpOcHgHoDzsUts4BMiCKK1ck OQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb219rymu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Apr 2022 02:37:55 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23A2Vt8r034106;
        Sun, 10 Apr 2022 02:37:54 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k13bhw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Apr 2022 02:37:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADs5QKVKqVshHBhigr/4H/Je1mkxDU73xnVVL0OpsKQPIFsASZZXaKHUvvwPs0f7+lDGUi3nQM9+aRvNk2myBmKF+FFLcJZOiZ+KqXovxzfcM9LFN90kPdxlSQh20GfKMEyK65pGLHg9AZtm1+9Q5Aiz63dh/DJrT0yYQ52TGYaMCbLwstjre3w7uvVujl0WayUvmq4RU4xLtan+LBfJ19etUVKSwDKpFH0nGqDtPNMVQZ1NbjWfjQspr9vLHUGE2APMfGg0rL3onCkvLHMgOh7zMOkxXhoPgaXyhqwZdUw5hhb+nm6xtqmiZDJYu9dBbp9hbmgDcz+L3I7x0PMkDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gfxrg0N7X+2jUeRRxfKklMIvmi4/26qPXTKfyUbtT18=;
 b=Oc6MzopVltkiZvI6r9Y//KUjFoKq6CSqFNjicjrglq6VuGz8oSQgNIJWjK9o2lZHDr4Bnwqp41CvQ8PhhxZnQdtInZ93bd3TF38M4wGid/tNtJIIKCx4wWQimmuNVQ+9r47N38B39yK6kTdOoYti2vBEoO0H8roOV2lY/K87yOiw4eaSrhmp0atxwUMFB/i0GMoHEe+ahF8YEKewpj6P6NEU+eo4VcCGIVgRmvoH27eGOttF2RAZhM40QkbZfbB3CobcmuyUcb8YAcj8qzcVsM8HeqgdOQfZ5OvDDP5kM6v/bWv1zT/Z4O2VyNZi4d7qB8Vs01n0c5uCK79qBewg4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gfxrg0N7X+2jUeRRxfKklMIvmi4/26qPXTKfyUbtT18=;
 b=ejpP6C8hANNMtwk7SAJ7/qhbyfzkqXzIxqzIY1+O4AXo1QuQundwsYjB0ZE4wlR2t0LHeIot2F9fh1d+9z4ItNtSmUofwyXR3qLV1uerhW8mzYcE+zadmT/Bx4ozNMC6WjBg1gModG0jdKbVifz2b+LHv7MfEt0vKUF5OiixgOg=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by CY4PR10MB1238.namprd10.prod.outlook.com (2603:10b6:910:7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.28; Sun, 10 Apr
 2022 02:37:52 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa%9]) with mapi id 15.20.5144.028; Sun, 10 Apr 2022
 02:37:52 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        ebiederm@xmission.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v8 10/10] kernfs: Add a document to describe hashed locks used in kernfs.
Date:   Sun, 10 Apr 2022 12:37:19 +1000
Message-Id: <20220410023719.1752460-11-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220410023719.1752460-1-imran.f.khan@oracle.com>
References: <20220410023719.1752460-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0054.ausprd01.prod.outlook.com
 (2603:10c6:10:2::18) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e7e2195-7fc4-4841-4432-08da1a9b1c42
X-MS-TrafficTypeDiagnostic: CY4PR10MB1238:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1238BD7A9989688D16306CAFB0EB9@CY4PR10MB1238.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KCUSQjfjzBzaha12oQzt4M3uQL6uPOS/vpzTx1jz+RgK7XP2IdpqnaUPYPnABSq1RulnJfL6ATxXNnl7Q+fQRGHrHtpBqDsMk04vh3WCPupWHLrZs+Gcj8P0d7TsPfyaoFoTISdRD+sDRl9iPF8Ueij98vd8kkD38sPq7vVkBxi7AhOX0L6HZoDNyDpPpxtTlw2acGP1nr1UxzzXk02gSwXwq7IDzzwZ5/PSvTsojWGkxuZXUoQkVR8XRpeTw5fshXJTAnk7AmBHi7FBhrZyrArlb2RwMSMWA25sUYCO3615HZ4FjSf+pLvMuqk2znjB4Xjb+kCPjYQBoHi6k/W2j22lWvZwvtNCZCJpS5QAT0ubICJuED1IZc/HRKdGn/l39iWGd253SULEdhh9lGd8VzUU730rW2jTdCS6bG45bQnhVcXkc2FRYLNzWa4DM3oOPY8VTQ3S2e4j8dIJGwfmY5X5PHrMLg9pzzrfdc69Wm+xSn8HvUaGt+naX45trv62b5AK74zbB/qeYiljF0VUB4ZdaudYsO8jFrUb2lGwbd4eD3vzXawZOI3Aviia/rrlgcMtuAQvPEyfI7H/mM/RrEF2xZb0iZjCuAntYKQmm8ZJ5s9ykUoZDdyL60N7uWjkFO5o+bly4NOqHOtyw12ZPmFfhoM1Xe0fh3hKagNbXU+v/MJc1kl/in0qPYQeiKp0fyr2AqiKlXY4DKqIu6lQWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(26005)(186003)(66946007)(66556008)(66476007)(8676002)(4326008)(83380400001)(36756003)(316002)(6486002)(103116003)(508600001)(8936002)(2616005)(6666004)(5660300002)(38100700002)(38350700002)(86362001)(2906002)(6512007)(6506007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YZD04+x+Xm3m+8VGahhLv6P61AlS88cCGYjWDiQCd5CoInjhdJ4372GwNF/N?=
 =?us-ascii?Q?PTa+yJ3h/8hrdaEQct67riRoAhgsU9qVD2v5IH73w3YzsmIGJPdxvXA4Hd16?=
 =?us-ascii?Q?pf1vTx+wyfLmWkBN8IFy2eti2KBpQxM+7d3X/Uy7rrYr+LBSPj9f6K4kGocN?=
 =?us-ascii?Q?LOdnPupOndjkEvz3K2RFSWP7MEAb6VW8649hevptb2JyZ5CmTwwKJ0JabkA8?=
 =?us-ascii?Q?L0ipU5s/6Xxo3uied2zCFNxJ5Hy6c0vyAW2Nk78sZt+Ngq6ZF7sY2GucjPQ/?=
 =?us-ascii?Q?RFui4Ec3xiPFwYVu5h299gWXh4XNqEzdOurzBCEnJBg5kenf3i0sQjh66jL0?=
 =?us-ascii?Q?ALYObpK9JeMmpWHMwt8xA5Nks2VzBna+dR9lPJ1B/zgzPNBkjSdaSU9QrYfD?=
 =?us-ascii?Q?IgDAm3woMJW9duIT8ilmbtEFRX+knbFcJQ5MuhIds7O3lO40fUvpceYOao7A?=
 =?us-ascii?Q?/McYeNQW+UdeYM7Nu4iz8k22cHyRJQsi2tpg2PIEInDy2299GFktPD0Ej6/d?=
 =?us-ascii?Q?+3SupozWCJSSreeswhjG8v+CdW9D7PYbSR8Iqw4/1ss0c/nneRe30/0blD3C?=
 =?us-ascii?Q?5yCa5iPQ+QsUiTNS910Ca0FhsokDhzKBQFUGlsTy7wGwvTDkhVkUuUWJixlJ?=
 =?us-ascii?Q?LLb89ZP1r0DjibJ89L0SUDUzVHyR0Neemm3R4rC+oPHAWFsKsEkmipgFwtqL?=
 =?us-ascii?Q?JuoU+5lZMr8RQBsrDH2K6OnT5zllSpsoIDE0lrrRo/G83yXQY9j4B6uBUUei?=
 =?us-ascii?Q?GhNHSTFFgdNK6YRoo2n5yrn5hEejSXrILCqba+Y+hNe+CTdxWhPxlDS8+pZS?=
 =?us-ascii?Q?7FJTAJJsn4ULSv3h5v5GQDYljo87xppX+d2q8xGb2OPaO36HHues//h0ShUX?=
 =?us-ascii?Q?6B8B077QppVJe7zmsmjYRr72aYpLPyRhiAaYjK91zVlxJzyURRVEvZ5/3/Ei?=
 =?us-ascii?Q?rJydhgDud5w27rc0gDB6W8A6LRgsS20PbN64WdrYD045Yg3RspkNo8dPqJSU?=
 =?us-ascii?Q?eMMYD2BL/o++g5Y9pDwYYLs3wrJTOlWGnhJ3cu53iIj1DtAvS7YqOMf8uaxV?=
 =?us-ascii?Q?wh8LSBlrT6oWnzu1PnSwzfA+30NCgfWslBvK3jfk2Fal1MTlkSiBsb1Q9Fmk?=
 =?us-ascii?Q?dvpKoQ6NVfELA/SHOS3SB7dYloGvO0EwF5SZMmpPnTjZXxT47dgEVPRbowEC?=
 =?us-ascii?Q?1UvTOEinLpnuvk2/chTc0yk6EdfxpcxptoAzDSlKp/oXDrQvPEH4vS0hspCL?=
 =?us-ascii?Q?AHJo8vECZwyuSqlSuP0C+TWxAGok1BwvtK0u3bXg+rKR7lZgFiuKdpujOpIx?=
 =?us-ascii?Q?mAF23M9JK9d8HGOmu2GzQErpTaF1NETkIdHbmH9VsEdronUzbMQZCV15Ofj1?=
 =?us-ascii?Q?kG6PiXgwMqWU3j2C+cMu7BwnekVT+ipAUkjVyv21l5BZi5EnoTp7ijkWuH3q?=
 =?us-ascii?Q?BFuVscQom+2b0BLgGMf3KqufEaWMeImbG68MJRExnJ8S7LlGR72SpPYBZoUU?=
 =?us-ascii?Q?/j/z8EQaiHGX0kHLb7KOXpz89AVgNzvpBGn0ozaOhVQNZYFzXYGI8Ygu5oj3?=
 =?us-ascii?Q?d9R0AmW+Y3zQxCOlZTWNWlZLp2Hqd6a6mHszgdUQnVosTkXIqKR3bwIXfgxo?=
 =?us-ascii?Q?uRPDJaSK5QmHjIAF3E1HiOVkD7Iv+psiwcAyih6t4YQJEjY8GK6yk3vkCX3K?=
 =?us-ascii?Q?CyGVa+wcCYoeH4ixAig++qs5DzohjqNTstOh02cBzHhbehKi1jSYNBSqFjED?=
 =?us-ascii?Q?a0R8Nhvh+GOO8VFnWBOtRO7mWfMZTzI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e7e2195-7fc4-4841-4432-08da1a9b1c42
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2022 02:37:52.5372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m7hyaKBs9eaKSiTPE93OZhS2DZRQY1R1RSEyRBiqXo/pSWqU9kVS8dJOG6EOFJwEB4FS8GSs4DxxqX1bEGywCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1238
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-09_25:2022-04-08,2022-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204100014
X-Proofpoint-GUID: ixcy4LGxI4QGT3EtmVwzPmRwvvhLqa1p
X-Proofpoint-ORIG-GUID: ixcy4LGxI4QGT3EtmVwzPmRwvvhLqa1p
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This document describes usage and proof of various hashed locks
introduced in this patch set

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 .../filesystems/kernfs-hashed-locks.rst       | 214 ++++++++++++++++++
 1 file changed, 214 insertions(+)
 create mode 100644 Documentation/filesystems/kernfs-hashed-locks.rst

diff --git a/Documentation/filesystems/kernfs-hashed-locks.rst b/Documentation/filesystems/kernfs-hashed-locks.rst
new file mode 100644
index 000000000000..8c3542e38e04
--- /dev/null
+++ b/Documentation/filesystems/kernfs-hashed-locks.rst
@@ -0,0 +1,214 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+===================
+kernfs hashed locks
+===================
+
+kernfs uses following hashed locks
+
+1. Hashed mutexes
+2. Hashed rwsem
+
+In certain cases hashed rwsem needs to work in conjunction with a per-fs mutex
+(Described further below).So this document describes this mutex as well.
+
+A kernfs_global_locks object (defined below) provides hashed mutexes,
+hashed spinlocks and hashed rwsems.
+
+	struct kernfs_global_locks {
+		struct kernfs_open_file_mutex open_file_mutex[NR_KERNFS_LOCKS];
+		struct rw_semaphore kernfs_rwsem[NR_KERNFS_LOCKS];
+	};
+
+The hashed mutexes is encapsulated in kernfs_open_file_mutex as shown below:
+
+struct kernfs_open_file_mutex {
+	struct mutex lock;
+} ____cacheline_aligned_in_smp;
+
+For all hashed locks address of a kernfs_node object acts as hashing key.
+
+For the remainder of this document a node means a kernfs_node object. The
+node can refer to a file, directory or symlink of a kernfs based file system.
+Also a node's mutex or rwsem refers to hashed mutex, or hashed rwsem
+corresponding to the node.
+It does not mean any locking construct embedded in the kernfs_node itself.
+
+What is protected by hashed locks
+=================================
+
+(1) There's one kernfs_open_file for each open file and all kernfs_open_file
+    instances corresponding to a kernfs_node are maintained in a list.
+    hashed mutexes or kernfs_global_locks.open_file_mutex[index].lock protects
+    this list.
+
+(2) Hashed rwsems or kernfs_global_locks.kernfs_rwsem[index] protects node's
+    state and synchronizes operations that change state of a node or depend on
+    the state of a node.
+
+(3) per-fs mutex (mentioned earlier) provides synchronization between lookup
+    and remove operations.
+    While looking for a node we will not have address of corresponding node
+    so we can't acquire node's rwsem right from the beginning.
+    On the other hand a parallel remove operation for the same node can acquire
+    corresponding rwsem and go ahead with node removal. So it may happen that
+    search operation for the node finds and returns it but before it can be
+    pinned or used, the remove operation, that was going on in parallel, removes
+    the node and hence makes its any future use wrong.
+    per-fs mutex ensures that for competing search and remove operations only
+    one proceeds at a time and since object returned by search is pinned before
+    releasing the per-fs mutex, it will be available for subsequent usage.
+
+
+Lock usage and proof
+=======================
+
+(1) Hashed mutexes
+
+    Since hashed mutexes protect the list of kernfs_open_file instances
+    corresponding to a kernfs_node, ->open and ->release backends of
+    file_operations need to acquire hashed mutex corresponding to kernfs_node.
+    Also when a kernfs_node is removed, all of its kernfs_open_file instances
+    are drained after deactivating the node. This drain operation acquires
+    hashed mutex to traverse list of kernfs_open_file instances.
+    So addition (via ->open), deletion (via ->release) and traversal
+    (during kernfs_drain) of kernfs_open_file list occurs in a synchronous
+    manner.
+
+(2) Hashed rwsems
+
+	3.1. A node's rwsem protects its state and needs to be acquired to:
+		3.1.a. Remove the node
+		3.1.b. Move the node
+		3.1.c. Travers or modify a node's children RB tree (for
+		       directories), i.e to add/remove files/subdirectories
+		       within/from a directory.
+		3.1.d. Modify or access node's inode attributes
+
+	3.2. Hashed rwsems are used in following operations:
+
+		3.2.a. Addition of a new node
+
+		While adding a new kernfs_node under a kernfs directory
+		kernfs_add_one acquires directory node's rwsem for
+		writing. Clause 3.1.a ensures that directory exists
+		throughout the operation. Clause 3.1.c ensures proper
+		updation of children rb tree (i.e ->dir.children).
+		Clause 3.1.d ensures correct modification of inode
+		attribute to reflect timestamp of this operation.
+		If the directory gets removed while waiting for semaphore,
+		the subsequent checks in kernfs_add_one will fail resulting
+		in early bail out from kernfs_add_one.
+
+		3.2.b. Removal of a node
+
+		Removal of a node involves recursive removal of all of its
+		descendants as well. per-fs mutex (i.e kernfs_rm_mutex) avoids
+		concurrent node removals even if the nodes are different.
+
+		At first node's rwsem is acquired. Clause 3.1.c avoids parallel
+		modification of descendant tree and while holding this rwsem
+		each of the descendants are deactivated.
+
+		Once a descendant has been deactivated and drained, its parent's
+		rwsem is taken. Clause 3.1.c ensures proper unlinking of this
+		descendant from its siblings. Clause 3.1.d ensures that parent's
+		inode attributes are correctly updated to record time stamp of
+		removal.
+
+		3.2.c. Movement of a node
+
+		Moving or renaming a node (kernfs_rename_ns) acquires rwsem for
+		node and its old and new parents. Clauses 3.1.b and 3.1.c avoid
+		concurrent move operations for the same node.
+		Also if old parent of a node changes while waiting for rwsem,
+		the acquisition of rwsem for 3 involved nodes is attempted
+		again. It is always ensured that as far as old parent is
+		concerned, rwsem corresponding to current parent is acquired.
+
+		3.2.d. Reading a directory
+
+		For diectory reading kernfs_fop_readdir acquires directory
+		node's rwsem for reading. Clause 3.1.c ensures a consistent view
+		of children RB tree.
+		As far as directroy being read is concerned, if it gets removed
+		while waiting for semaphore, the for loop that iterates through
+		children will be ineffective. So for this operation acquiring
+		directory node's rwsem for reading is enough.
+
+		3.2.e. Dentry revalidation
+
+		A dentry revalidation (kernfs_dop_revalidate) can happen for a
+		negative or for a normal dentry.
+		For negative dentries we just need to check parent change, so in
+		this case acquiring parent kernfs_node's rwsem for reading is
+		enough.
+		For a normal dentry acquiring node's rwsem for reading is enough
+		(Clause 3.1.a and 3.1.b).
+		If node gets removed while waiting for the lock subsequent checks
+		in kernfs_dop_revalidate will fail and kernfs_dop_revalidate will
+		exit early.
+
+		3.2.f. kernfs_node lookup
+
+		While searching for a node under a given parent
+		(kernfs_find_and_get_ns, kernfs_walk_and_get_ns) rwsem of parent
+		node is acquired for reading. Clause 3.1.c ensures a consistent
+		view of parent's children RB tree. To avoid parallel removal of
+		found node before it gets pinned, these operation make use of
+		per-fs mutex (kernfs_rm_mutex) as explained earlier.
+		This per-fs mutex is also taken during kernfs_node removal
+		(__kernfs_remove).
+
+		If the node being searched gets removed while waiting for the
+		mutex or rwsem, the subsequent kernfs_find_ns or kernfs_walk_ns
+		will fail.
+
+		3.2.g. kenfs_node's inode lookup
+
+		Looking up for inode instances via kernfs_iop_lookup involves
+		node lookup. So locks acquired are same as ones required in 3.2.f.
+		Also once node lookup is complete parent's rwsem is released and
+		rwsem of found node is acquired to get corresponding inode.
+		Since we are operating under per-fs kernfs_rm_mutex the found node
+		will not disappear in the middle.
+
+		3.2.h. Updating or reading inode attribute
+
+		Interfaces that change inode attributes(i.e kernfs_setattr and
+		kernfs_iop_setattr) acquire node's rwsem for writing.
+		If the kernfs_node gets removed while waiting for the semaphore
+		the subsequent __kernfs_setattr will fail.
+		From 3.2.a and 3.2.b we know that updates due to addition or
+		removal of nodes will not happen in parallel.
+		So just locking the kernfs_node in these cases is enough to
+		guarantee correct modification of inode attributes.
+		Similarly the interfaces that read inode attributes
+		(i.e kernfs_iop_getattr, kernfs_iop_permission) just need to
+		acquire involved node's rwsem for reading.
+
+		3.2.i. kernfs file event generation
+
+		kernfs_notify pins involved node before scheduling
+		kernfs_notify_work and kernfs_notify_workfn acquires node's
+		rwsem. Clauses in 3.1 ensure a consistent view of node state
+		throughout execution of work handler.
+
+		3.2.j. mount
+
+		kernfs_fill_super, invoked during mount operation, acquires root
+		node's rwsem. During mount process there can't be other execution
+		contexts trying to move or delete the node so just locking the
+		involved node(i.e the root node) is enough.
+
+		3.2.k. while activating a node
+
+		For a node that started as deactivated, kernfs_activate
+		activates the node. In this case acquiring node's rwsem is
+		enough. Since the node is not active yet any parallel removal
+		that wins the race for rwsem will skip this node and its
+		descendents. Also user space can't see a deactivated node so we
+		don't have any parallel access emanating from their as well.
+
+	3.3  For operations that involve locking multiple nodes at the same time
+	     locks are acquired in order of their addresses.
-- 
2.30.2

