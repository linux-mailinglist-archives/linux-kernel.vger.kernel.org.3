Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBD856FFB9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiGKLLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiGKLK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:10:58 -0400
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916D1936B6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 03:18:02 -0700 (PDT)
X-QQ-mid: bizesmtp84t1657534671tjvi0gr2
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 11 Jul 2022 18:17:45 +0800 (CST)
X-QQ-SSF: 01400000002000G0T000B00A0000000
X-QQ-FEAT: DoD8xN2rKozpUoCo03BPpM4/2WoWjL6JHpDuORV4rxEjn87CIA++YiOSKp7cc
        8BeJeI+Y1uI/awUrWsEX+zCaJk/CPkeHtZJDghdfdRSIqjMyZ+Kr2WaIleI8Vj7X2kCRswo
        wm6aPCACE8dbi+TvXndVRwqv9uo+yjqmFD8XbknuMK/5FAjGyg+8IcKlqmQxyivAcHD8GvM
        KQ2+A6/0pRZlHdXGisNp2bgLhI/1GTho75Vy6lNTdLTVPxaEUmzDqetsBIkgGMW6av3dn9H
        g+bHhaRO5HtDoqULjMm4MiOhc4rCdlFhs2lWpP2pRl7Jq4w0oZjZtm9UOdXGDGGunT9tilX
        NzbroDWf2zU25Muz8yPUNVPsLApejolJdwhWKmiIVj8RBKVAIUav+BAQm5M8GPhSFVK0qaA
        Xcxzq2ma3z0dHUlHtcH7HTll5lvFLeeQ
X-QQ-GoodBg: 2
From:   Meng Tang <tangmeng@uniontech.com>
To:     perex@perex.cz, tiwai@suse.com, bo.liu@senarytech.com,
        huangwenhuia@uniontech.com, tangmeng@uniontech.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ALSA: hda/conexant: Apply quirk for another HP ProDesk 600 G3 model
Date:   Mon, 11 Jul 2022 18:17:44 +0800
Message-Id: <20220711101744.25189-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign9
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is another HP ProDesk 600 G3 model with the PCI SSID 103c:82b4
that requires the quirk HP_MIC_NO_PRESENCE. Add the corresponding
entry to the quirk table.

Signed-off-by: Meng Tang <tangmeng@uniontech.com>
---
 sound/pci/hda/patch_conexant.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 3e541a4c0423..83ae21a01bbf 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -944,6 +944,7 @@ static const struct snd_pci_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK(0x103c, 0x828c, "HP EliteBook 840 G4", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x8299, "HP 800 G3 SFF", CXT_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x829a, "HP 800 G3 DM", CXT_FIXUP_HP_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x103c, 0x82b4, "HP ProDesk 600 G3", CXT_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x836e, "HP ProBook 455 G5", CXT_FIXUP_MUTE_LED_GPIO),
 	SND_PCI_QUIRK(0x103c, 0x837f, "HP ProBook 470 G5", CXT_FIXUP_MUTE_LED_GPIO),
 	SND_PCI_QUIRK(0x103c, 0x83b2, "HP EliteBook 840 G5", CXT_FIXUP_HP_DOCK),
-- 
2.20.1



