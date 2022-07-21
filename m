Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CF757CE8B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 17:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbiGUPGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 11:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiGUPF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 11:05:59 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D9910542
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 08:05:52 -0700 (PDT)
X-QQ-mid: bizesmtp67t1658415941trffb0df
Received: from localhost.localdomain ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 21 Jul 2022 23:05:32 +0800 (CST)
X-QQ-SSF: 01000000002000409000B00A0000000
X-QQ-FEAT: dDyohfujUnkwCuUiL58tJnO6zzR4NDiMnbHCq0ugwSbBYiDCLMByWHQMOXbvB
        VM4J1r9cg9xK1XpFDCfUEK5UsLYf0qoo4eUMo9jJWsCNA91WvnFua729T+IRGkKo68D9DXY
        O/mXWGm4q1br78s+RAsBFoWEbC7pOdmDH8N/10PYdux6tpaIv+9WIyTvnzu8xXrJ7Vf7cbk
        QUNPdjkEnh5NZCgsI0XFy7TD8CdbdzRVF3DfIHEiyg18Eenzv+g6nJXr7toDp0dH3BkDIqQ
        xdTuGyfWJvefjZ2kcIgQqLyK34MuEX2kzWpzPuX1xmXPFF+3812o16hvcT+nX8xLHiKcADm
        MTFcCatSl2TcqZuB9+iCQGNCTfp4MX3obb/n9qxHlvDx35uzjYkiKoQZss+0S5zyiEinMBj
X-QQ-GoodBg: 0
From:   shaomin Deng <dengshaomin@cdjrlc.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] ALSA: emu10k1: Fix typo in comments
Date:   Thu, 21 Jul 2022 11:05:28 -0400
Message-Id: <20220721150528.22099-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the rebundant word "in" in comments.

Signed-off-by: shaomin Deng <dengshaomin@cdjrlc.com>
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
2.35.1

