Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D670C57D831
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 03:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbiGVB5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 21:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiGVB5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 21:57:24 -0400
Received: from m12-14.163.com (m12-14.163.com [220.181.12.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A159972ED;
        Thu, 21 Jul 2022 18:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=3Ol0r
        ff/GUMKl7XwibwqqtI8YmVtFsmdMG5owhIgdzM=; b=Okw94CJLf5GQoLb75cQEg
        o4Mp/ZxlEvsZomC7uUU0he3PqYAtlMr9bhu1ozM/L1DyPKW1HAqVMXIkzTxbR+3h
        fHyAu/R3GVasXHOMK/kiOi8dXxy7ZPQONqWHk3eQuL4oG8bT+mB8n5mqFNVzZqLl
        W4QI8ExHVIOpH9KHgQrZGI=
Received: from localhost.localdomain (unknown [223.104.68.59])
        by smtp10 (Coremail) with SMTP id DsCowADHjqf2A9piq4GDOg--.8820S2;
        Fri, 22 Jul 2022 09:57:14 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] media: cx88: Fix typo 'the the' in comment
Date:   Fri, 22 Jul 2022 09:57:07 +0800
Message-Id: <20220722015707.63916-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowADHjqf2A9piq4GDOg--.8820S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWUWr15WFW8CrWDXFWrXwb_yoWxtrg_Wr
        1kuFWxXa1Y9F4UKr42vF1ru3y3t3ykur1xCr1fta43KFyYkF4UGa4DAF1UJFnxGrW3AF98
        Cry5X3W3CwnxWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRiAwIUUUUUU==
X-Originating-IP: [223.104.68.59]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbBAwZGZGB0Ln+iOQAAs5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'the the' with 'the' in the comment.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/media/pci/cx88/cx88-dsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/cx88/cx88-dsp.c b/drivers/media/pci/cx88/cx88-dsp.c
index f1e1fc1cb4bd..e378f3b215c7 100644
--- a/drivers/media/pci/cx88/cx88-dsp.c
+++ b/drivers/media/pci/cx88/cx88-dsp.c
@@ -24,7 +24,7 @@
 
 /*
  * We calculate the baseband frequencies of the carrier and the pilot tones
- * based on the the sampling rate of the audio rds fifo.
+ * based on the sampling rate of the audio rds fifo.
  */
 
 #define FREQ_A2_CARRIER         baseband_freq(54687.5, 2689.36, 0.0)
-- 
2.25.1

