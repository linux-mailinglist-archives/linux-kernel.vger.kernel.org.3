Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591D74EE89F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 08:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbiDAGsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 02:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343596AbiDAGsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 02:48:03 -0400
Received: from smtpbg511.qq.com (smtpbg511.qq.com [203.205.250.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A091A9CA9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 23:46:07 -0700 (PDT)
X-QQ-mid: bizesmtp83t1648795561tjbq1hzl
Received: from localhost.localdomain ( [202.96.137.248])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 01 Apr 2022 14:45:45 +0800 (CST)
X-QQ-SSF: 01400000000000D0O000B00A0000000
X-QQ-GoodBg: 2
From:   Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, yejiajian2018@email.szu.edu.cn,
        zhangyinan2019@email.szu.edu.cn, zhaochongxi2019@email.szu.edu.cn,
        hanshenghong2019@email.szu.edu.cn, yuhongf@szu.edu.cn,
        linux-kernel@vger.kernel.org,
        Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
Subject: [PATCH] mm/vmalloc: fix a comment
Date:   Fri,  1 Apr 2022 14:45:43 +0800
Message-Id: <20220401064543.4447-1-caoyixuan2019@email.szu.edu.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:email.szu.edu.cn:qybgforeign:qybgforeign3
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sentence
"but the mempolcy want to alloc memory by interleaving"
should be rephrased with
"but the mempolicy wants to alloc memory by interleaving"
where "mempolicy" is a struct name.

This work is coauthored by
Yinan Zhang
Jiajian Ye
Shenghong Han
Chongxi Zhao
Yuhong Feng
Yongqiang Liu

Signed-off-by: Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
---
 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index e163372d3967..d0111d1e370d 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2903,7 +2903,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 			/* memory allocation should consider mempolicy, we can't
 			 * wrongly use nearest node when nid == NUMA_NO_NODE,
 			 * otherwise memory may be allocated in only one node,
-			 * but mempolcy want to alloc memory by interleaving.
+			 * but mempolicy wants to alloc memory by interleaving.
 			 */
 			if (IS_ENABLED(CONFIG_NUMA) && nid == NUMA_NO_NODE)
 				nr = alloc_pages_bulk_array_mempolicy(bulk_gfp,
-- 
2.31.1



