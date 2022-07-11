Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788A156FF90
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 12:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiGKKz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 06:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiGKKzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 06:55:41 -0400
Received: from smtpproxy21.qq.com (smtpbg704.qq.com [203.205.195.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FBBFD50C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 03:00:54 -0700 (PDT)
X-QQ-mid: bizesmtp90t1657533647tvco1blo
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 11 Jul 2022 18:00:42 +0800 (CST)
X-QQ-SSF: 01400000002000G0T000B00A0000000
X-QQ-FEAT: swyrzWPvyR2Uu3lbSHNBUQj+FIenmLTanjTjxlOammbysUvhsUnCrkb+4NP8u
        z+Idjgqytr5udTEpd73w/5qL3vqPNdrhaSIFQ527IXit4QoOAzS9rFPpfCxQUVexUlkiQ72
        1j2A6+0ptmHTKcksbzNA94oykS2SzMpgblKPnkBibRSq5DLjvZL94xNPD68MdCPhPsbkuIn
        k/t/fMbaM2UWrIxizF49jFVrLuyg2+JDRgsnyvjXFtJW2w66YFnDJmjzobj8Ne47GVK7TLp
        fx1cQv6tGnTLJorj/C4392XfDXfeV+GQFu3/7CNZ4Yaf2dYIkOzurDYK0RH7KHe12QzDHSd
        neqMAr6+smpIIZKa08RZVNrdoQNjWhO806i0Z+oUjiWSUfrLN3C4mXe4PxequfNZnelAK7i
        1zB4p3vSZos=
X-QQ-GoodBg: 2
From:   Meng Tang <tangmeng@uniontech.com>
To:     perex@perex.cz, tiwai@suse.com, bo.liu@senarytech.com,
        huangwenhuia@uniontech.com, tangmeng@uniontech.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/conexant: Apply quirk for another HP ProDesk 600 G3 model
Date:   Mon, 11 Jul 2022 18:00:41 +0800
Message-Id: <20220711100041.22422-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is another HP ProDesk 600 G3 model with the PCI SSID 103c:82b4
that requires the same quirk for controlling the mute LED.  Add the
corresponding entry to the quirk table.

Signed-off-by: Meng Tang <tangmeng@uniontech.com>
---
 sound/pci/hda/patch_conexant.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 3e541a4c0423..e90da8020881 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -944,6 +944,7 @@ static const struct snd_pci_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK(0x103c, 0x828c, "HP EliteBook 840 G4", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x8299, "HP 800 G3 SFF", CXT_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x829a, "HP 800 G3 DM", CXT_FIXUP_HP_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x103c, 0x82b4, "HP ProDesk 600 G3", CXT_FIXUP_MUTE_LED_GPIO),
 	SND_PCI_QUIRK(0x103c, 0x836e, "HP ProBook 455 G5", CXT_FIXUP_MUTE_LED_GPIO),
 	SND_PCI_QUIRK(0x103c, 0x837f, "HP ProBook 470 G5", CXT_FIXUP_MUTE_LED_GPIO),
 	SND_PCI_QUIRK(0x103c, 0x83b2, "HP EliteBook 840 G5", CXT_FIXUP_HP_DOCK),
-- 
2.20.1



