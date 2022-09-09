Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705F85B2D1C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 05:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiIIDzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 23:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiIIDyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 23:54:50 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E09B1EEF7
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 20:54:47 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MP28Z6xqSz14QYY;
        Fri,  9 Sep 2022 11:50:54 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 11:54:45 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <perex@perex.cz>, <tiwai@suse.com>, <johan@kernel.org>,
        <stefanha@gmail.com>, <dhowells@redhat.com>,
        <cuigaosheng1@huawei.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] ALSA: memalloc: remove snd_dma_sg_ops declaration
Date:   Fri, 9 Sep 2022 11:54:43 +0800
Message-ID: <20220909035443.1065737-3-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220909035443.1065737-1-cuigaosheng1@huawei.com>
References: <20220909035443.1065737-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snd_dma_sg_ops has been removed since
commit 2c95b92ecd92 ("ALSA: memalloc: Unify x86 SG-buffer handling
(take#3)"), so remove it.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 sound/core/memalloc_local.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/core/memalloc_local.h b/sound/core/memalloc_local.h
index a6f3a87194da..8b19f3a68a4b 100644
--- a/sound/core/memalloc_local.h
+++ b/sound/core/memalloc_local.h
@@ -13,8 +13,4 @@ struct snd_malloc_ops {
 	void (*sync)(struct snd_dma_buffer *dmab, enum snd_dma_sync_mode mode);
 };
 
-#ifdef CONFIG_SND_DMA_SGBUF
-extern const struct snd_malloc_ops snd_dma_sg_ops;
-#endif
-
 #endif /* __MEMALLOC_LOCAL_H */
-- 
2.25.1

