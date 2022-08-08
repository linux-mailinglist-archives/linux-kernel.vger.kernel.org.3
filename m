Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E0658CAB7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 16:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242964AbiHHOs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 10:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243415AbiHHOsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 10:48:52 -0400
Received: from bg5.exmail.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7816BC23
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 07:48:42 -0700 (PDT)
X-QQ-mid: bizesmtp63t1659970114tdwoi7g2
Received: from harry-jrlc.. ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 08 Aug 2022 22:48:04 +0800 (CST)
X-QQ-SSF: 0100000000200030C000B00A0000020
X-QQ-FEAT: CR3LFp2JE4ltZv2R7LLkJ0RCBF3k2eS49hhj81GJ3aeFP2oiDHYeTQax0nJbR
        l/c8n/UUiNM2/p+0T5WhUk8EClm4lGn9Pp0EMF5oU2y6vPTMm2Oz+VyX9GFR0tBiMUvmCid
        r41XdWcKSpdIPAEQ6IKjtaFedCnHd7Z6AY1yWWRQDvmQwo6Ws7CZbCdbrHsfoXSvmTkQhuj
        eC9KNjer4BY866CXScSBA6Nu4aEh8A6HFhNHu1R5rsdDfLQm+kUmMMcuYpFIFkLzAO4w2jp
        FULkVpal7wt9bhYs4DIswKtBSaZ1Tpkpp0PSGxB3uOGUCKx28eWbX9aUyDaVU5YsY4zjZm1
        bcRP3xE3BuGWccxUQK1CtP08pnp7q0bIaUMzR0RF4MDE19Cy1M=
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] tools/virtio: Parameter type completion
Date:   Mon,  8 Aug 2022 22:48:02 +0800
Message-Id: <20220808144802.58745-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'unsigned int' is better than 'unsigned'.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 tools/virtio/linux/kernel.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
index 0b493542e61a..94144979fbba 100644
--- a/tools/virtio/linux/kernel.h
+++ b/tools/virtio/linux/kernel.h
@@ -58,7 +58,7 @@ static inline void *kmalloc(size_t s, gfp_t gfp)
 		return __kmalloc_fake;
 	return malloc(s);
 }
-static inline void *kmalloc_array(unsigned n, size_t s, gfp_t gfp)
+static inline void *kmalloc_array(unsigned int n, size_t s, gfp_t gfp)
 {
 	return kmalloc(n * s, gfp);
 }
-- 
2.30.2

