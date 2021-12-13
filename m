Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8227A4730FC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 16:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240120AbhLMP5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 10:57:54 -0500
Received: from pmta31.teksavvy.com ([76.10.157.38]:26254 "EHLO
        pmta31.teksavvy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234603AbhLMP5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 10:57:52 -0500
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Dec 2021 10:57:52 EST
IronPort-SDR: //Q99cuBkl4O2aGK59yq8XsjPqqMbuiTyWf20w/119Ts44Zd8EwbWGMieZmtKr3EsMA+1aiLDr
 lxZqnoeFiegA==
IronPort-Data: =?us-ascii?q?A9a23=3Avr3N4qoBQ1pR7RUH0IYJzmhfNmheBmLtZBIvg?=
 =?us-ascii?q?KrLsJaIsI4StFCztgarIBmOO/reNzPwf4t/Od608kxQ75PXz9dlTQJprCxkQ?=
 =?us-ascii?q?yMX85acVYWSI27OZC7DdceroGCLTyk9hngsFC29J5Pljk/F3oPJ8D8shclke?=
 =?us-ascii?q?pKmULSdY3ooHlc+IMscoUsLd9AR09YAbeeRXlvlVePa+6UzCXf9s9JGGjt8B?=
 =?us-ascii?q?5Gr8nuDiM/PVAYw5TTSUxzrUGj2zBH5BLpHTU24wuCRroN8RoZWTM6bpF21E?=
 =?us-ascii?q?/+wE77A17qYfrjHnk0iGtY+PCCkkHNaQJqIhR9B4Cc11KgmL/cVYk5LzTKTk?=
 =?us-ascii?q?Lidyv0X6drqEF1vZPSR3r1BAnG0EAknVUFC0JXdKHS7vN3V9EbBb2fE0fhkF?=
 =?us-ascii?q?khwNoodkgpyKTgRqKJJcWlSN3hvgMrzmtpXUNJEmsU8JcjDJ54EtzdswFnxF?=
 =?us-ascii?q?fs8TIDrW6jQ6M8e1yVYrtxPAv/fT9EEcjcpZxPFCzVEPU0dBY4WmPiuwH/yb?=
 =?us-ascii?q?1Vwql+PqK8mpXPB0SR62b7qNtvec9jMTsJQ9m6Yu2OA4G3/DTkRPdqYzzuO+?=
 =?us-ascii?q?3bqjejK9QvkQ486CKCo+/Jti1qW3nEPBQcNE1C8pJGRiUe/X9tZJGQO9yMqs?=
 =?us-ascii?q?aUxskesS7HVVBS9iHiJuVsOVt1WVeE3gCmWw6/VywKeAW4JCDBAAPQrsM4/S?=
 =?us-ascii?q?TE010OOt9zsDD1r9raSTBq1/7OPpHa+NDYYKUcLYTQNCBMf5Nvuq511iQjAJ?=
 =?us-ascii?q?v5nEaionpj5HjrY3T+Htm49iq8VgMpN0L+0lXjDgjSxtt3KQxQz6wH/QG2o9?=
 =?us-ascii?q?EV6aZSjaoju7kLUhd5qNo+VSlSQ+kMPnNSCxPIDB4uE0ieKRY0w8BuBjxqeG?=
 =?us-ascii?q?GeAxAQ2Rdx7rmnooiLyO4tZ6jVzYltkMd0NZyH4JkTUvGtsCFZoFCPCRcdKj?=
 =?us-ascii?q?0iZUKzGFZTdKOk=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Aj/jgFKCyaUX8lrXlHem155DYdb4zR+YMi2?=
 =?us-ascii?q?TDGXoddfUzSL36qynAppsmPHPP4wr5O0tBpTn/Ase9qBrnnPZICOIqUYtKMj?=
 =?us-ascii?q?ONhILRFuBf0bc=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FoBADSardh/5XX1BhagRKBUIMPbGy?=
 =?us-ascii?q?NS4hLAZwOgXwLAQEBAQEBAQEBCUEEAQGFAAQCgyYmNgcOAQIEAQEBEgEBAQU?=
 =?us-ascii?q?BAQEBAQYEAgKBGIV1hwQBIAMjKSZvE4JxgxiyVoEBiBaBY4E6iSyFPYFVRIE?=
 =?us-ascii?q?VgnpuikIEkneBDpgUAYxCnTQzB4NDgTsLnUgaM6dQliymSYFoAoIMMxojgzl?=
 =?us-ascii?q?RGQ+OLBaOTCYwOAIGCwEBAwmQcAEB?=
X-IPAS-Result: =?us-ascii?q?A2FoBADSardh/5XX1BhagRKBUIMPbGyNS4hLAZwOgXwLA?=
 =?us-ascii?q?QEBAQEBAQEBCUEEAQGFAAQCgyYmNgcOAQIEAQEBEgEBAQUBAQEBAQYEAgKBG?=
 =?us-ascii?q?IV1hwQBIAMjKSZvE4JxgxiyVoEBiBaBY4E6iSyFPYFVRIEVgnpuikIEkneBD?=
 =?us-ascii?q?pgUAYxCnTQzB4NDgTsLnUgaM6dQliymSYFoAoIMMxojgzlRGQ+OLBaOTCYwO?=
 =?us-ascii?q?AIGCwEBAwmQcAEB?=
X-IronPort-AV: E=Sophos;i="5.88,202,1635220800"; 
   d="scan'208";a="175691171"
Received: from 24-212-215-149.cable.teksavvy.com (HELO BradsZBook.confuseacat.org) ([24.212.215.149])
  by smtp13.teksavvy.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Dec 2021 10:50:42 -0500
From:   Bradley Scott <Bradley.Scott@zebra.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jeremy Szu <jeremy.szu@canonical.com>,
        Hui Wang <hui.wang@canonical.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Kailang Yang <kailang@realtek.com>,
        Cameron Berkenpas <cam@neo-zeon.de>,
        Sami Loone <sami@loone.fi>, Elia Devito <eliadevito@gmail.com>,
        alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bradley Scott <Bradley.Scott@zebra.com>
Subject: [PATCH v2] ALSA: hda/realtek: Amp init fixup for HP ZBook 15 G6
Date:   Mon, 13 Dec 2021 10:49:39 -0500
Message-Id: <20211213154938.503201-1-Bradley.Scott@zebra.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HP ZBook 15 G6 (SSID 103c:860f) needs the same speaker amplifier
initialization as used on several other HP laptops using ALC285.

Signed-off-by: Bradley Scott <Bradley.Scott@zebra.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3599f4c85ebf..d162662fe684 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8660,6 +8660,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x84da, "HP OMEN dc0019-ur", ALC295_FIXUP_HP_OMEN),
 	SND_PCI_QUIRK(0x103c, 0x84e7, "HP Pavilion 15", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x103c, 0x8519, "HP Spectre x360 15-df0xxx", ALC285_FIXUP_HP_SPECTRE_X360),
+	SND_PCI_QUIRK(0x103c, 0x860f, "HP ZBook 15 G6", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x861f, "HP Elite Dragonfly G1", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x869d, "HP", ALC236_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x86c7, "HP Envy AiO 32", ALC274_FIXUP_HP_ENVY_GPIO),
-- 
2.25.1

