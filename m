Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F1F57F398
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 09:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237249AbiGXHIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 03:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiGXHIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 03:08:01 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6861570B
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 00:07:55 -0700 (PDT)
X-QQ-mid: bizesmtp84t1658646464tvo35g03
Received: from localhost.localdomain ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 24 Jul 2022 15:07:42 +0800 (CST)
X-QQ-SSF: 01000000002000007000B00A0000000
X-QQ-FEAT: Y5/s5IBMBZKyIROfgtPjanP2EtS6sNh99EoxSLr08yk8ftkXPyGnSwaAMtyi8
        /qAoEtHxB3DhA6Nt8kou+UVeYRNMvVxU4Yu3FCxk5eqng7nt+gktyOLtozYIlxepklUBZVO
        GKSge38owMgussSFcxdJHPoFCvvZ3dySUBfj5+siHZAT9fhGuMUOl8pXV3WPSArx3SvQYi+
        UD9deJWmPUQwUgxIUfx3MTLbRKgKLa64U085pUhAZjW1Ve3TQtXRRo4P3YD1hAM+D+XD591
        PvC+IaXq5QJn0QzJj65WCIx9r0CM6qm0PGEmO9gDCcUiJChmclBYXOOHkIhdXZJKA2uaKZ1
        xIcx8SSXEhWWO4uaqOT16ByFQ25KxUKdrASIsGriSby3ibQcjg=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] pci/emu10k1: fix repeated words in comments
Date:   Sun, 24 Jul 2022 15:07:36 +0800
Message-Id: <20220724070736.8624-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'in'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 sound/pci/emu10k1/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/emu10k1/memory.c b/sound/pci/emu10k1/memory.c
index 9d26535f3fa3..edb3f1763719 100644
--- a/sound/pci/emu10k1/memory.c
+++ b/sound/pci/emu10k1/memory.c
@@ -324,7 +324,7 @@ snd_emu10k1_alloc_pages(struct snd_emu10k1 *emu, struct snd_pcm_substream *subst
 		return NULL;
 	}
 	/* fill buffer addresses but pointers are not stored so that
-	 * snd_free_pci_page() is not called in in synth_free()
+	 * snd_free_pci_page() is not called in synth_free()
 	 */
 	idx = 0;
 	for (page = blk->first_page; page <= blk->last_page; page++, idx++) {
-- 
2.36.1

