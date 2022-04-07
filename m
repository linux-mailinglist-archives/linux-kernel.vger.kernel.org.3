Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1B64F792F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbiDGINU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243281AbiDGINB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:13:01 -0400
Received: from smtpproxy21.qq.com (smtpbg704.qq.com [203.205.195.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A170315A21E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 01:10:15 -0700 (PDT)
X-QQ-mid: bizesmtp90t1649319008tjbj1c6q
Received: from wuhui-virtual-machine.localdoma ( [202.96.137.248])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 07 Apr 2022 16:10:01 +0800 (CST)
X-QQ-SSF: 01400000002000D0O000B00A0000000
X-QQ-FEAT: Y/4E1fKPEOpIgEa3h6QMqPnhlMf2QLngwWYZP79NL9y5k2e1N8mnEzmLfdIyn
        fYjvnGD3YmowlRKXSJ6yCsYcO3docVgQZkIubJig+7+GZCR39o2Ca4D8yJt/QDRxbCgr7uk
        RMLNPZGWqyUR+PzqtniOmz+7NxsOuAi+vcFTKj+d1lkstsRtdYydRhG38t2rL3zdwjHVBkX
        IpzC6fml5CNCDoa+OVLiHpToiHVFeYnyICJXcBu6BTY2iRc9y3Y2FRGeKx7WSw5L7X7Bukv
        vBJc4M9R5pT/rGmSXnXDVU7NwHRJY7WNd7wtCPle4UTfCFlePVU9CFcLTuc94zUGgoHW1hn
        4rzRnFlbxadZ6TcJ3/BNNKHh2kdMA==
X-QQ-GoodBg: 2
From:   Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
To:     akpm@linux-foundation.org
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, vbabka@suse.cz, roman.gushchin@linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
Subject: [PATCH] mm/slab.c: fix comments
Date:   Thu,  7 Apr 2022 16:09:58 +0800
Message-Id: <20220407080958.3667-1-caoyixuan2019@email.szu.edu.cn>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:email.szu.edu.cn:qybgforeign:qybgforeign3
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While reading the source code,
I noticed some language errors in the comments, so I fixed them.

Signed-off-by: Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
---
 mm/slab.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 90b16c7ae01a..e882657c1494 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -781,7 +781,7 @@ static inline int cache_free_alien(struct kmem_cache *cachep, void *objp)
 	int slab_node = slab_nid(virt_to_slab(objp));
 	int node = numa_mem_id();
 	/*
-	 * Make sure we are not freeing a object from another node to the array
+	 * Make sure we are not freeing an object from another node to the array
 	 * cache on this cpu.
 	 */
 	if (likely(node == slab_node))
@@ -832,7 +832,7 @@ static int init_cache_node(struct kmem_cache *cachep, int node, gfp_t gfp)
 
 	/*
 	 * The kmem_cache_nodes don't come and go as CPUs
-	 * come and go.  slab_mutex is sufficient
+	 * come and go.  slab_mutex provides sufficient
 	 * protection here.
 	 */
 	cachep->node[node] = n;
@@ -845,7 +845,7 @@ static int init_cache_node(struct kmem_cache *cachep, int node, gfp_t gfp)
  * Allocates and initializes node for a node on each slab cache, used for
  * either memory or cpu hotplug.  If memory is being hot-added, the kmem_cache_node
  * will be allocated off-node since memory is not yet online for the new node.
- * When hotplugging memory or a cpu, existing node are not replaced if
+ * When hotplugging memory or a cpu, existing nodes are not replaced if
  * already in use.
  *
  * Must hold slab_mutex.
@@ -1046,7 +1046,7 @@ int slab_prepare_cpu(unsigned int cpu)
  * offline.
  *
  * Even if all the cpus of a node are down, we don't free the
- * kmem_cache_node of any cache. This to avoid a race between cpu_down, and
+ * kmem_cache_node of any cache. This is to avoid a race between cpu_down, and
  * a kmalloc allocation from another cpu for memory from the node of
  * the cpu going down.  The kmem_cache_node structure is usually allocated from
  * kmem_cache_create() and gets destroyed at kmem_cache_destroy().
@@ -1890,7 +1890,7 @@ static bool set_on_slab_cache(struct kmem_cache *cachep,
  * @flags: SLAB flags
  *
  * Returns a ptr to the cache on success, NULL on failure.
- * Cannot be called within a int, but can be interrupted.
+ * Cannot be called within an int, but can be interrupted.
  * The @ctor is run when new pages are allocated by the cache.
  *
  * The flags are
@@ -3138,7 +3138,7 @@ static void *fallback_alloc(struct kmem_cache *cache, gfp_t flags)
 }
 
 /*
- * A interface to enable slab creation on nodeid
+ * An interface to enable slab creation on nodeid
  */
 static void *____cache_alloc_node(struct kmem_cache *cachep, gfp_t flags,
 				int nodeid)
-- 
2.17.1



