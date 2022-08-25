Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507AF5A1BDA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 00:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiHYWBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 18:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244152AbiHYWBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 18:01:48 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6240F985AA
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:01:47 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id C42825C0056;
        Thu, 25 Aug 2022 18:01:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 25 Aug 2022 18:01:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1661464906; x=1661551306; bh=vx
        IQYb7384ikUOFL0YYanSZM4BK3Ykys553Rk0TizvY=; b=cM9dfZEj0l2R40gIJx
        046+jU5S1BdBAc/m3p88ls88V1AI+CEgv6RjA0qTMsqRx2t88fQmm0MGE+wIRmkO
        BuhkqEdw4vjj+4YNfaKpCBAL4/pC8pb7Ax9GMjqlrCyr5eibp/cyF1tgea/QlOqq
        BU+qTMHTEZ/tpObSdlVtRGpXl3MzLW30/G4OnU+ug7EXC5/pum698QdIxcdkPwUy
        HkntoOqsVl6NViNV6VPLY6rZIm7FjYeR1P0aEK1m3aXUQwUKG/+mf6bsfBapQM1S
        XbSMEpPHVR/cM2Mw3DQYmyjIeM53fgwHMbP02KVheQdlK2W+/xSMYfTq38Or8x8E
        0KMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1661464906; x=1661551306; bh=vxIQYb7384ikU
        OFL0YYanSZM4BK3Ykys553Rk0TizvY=; b=bhHbC78oXHH+PMzfOi+fCKxUuR1CR
        KpSjFgc0k5EUfAsmmZX+PE7DWw02WumP//HhoJWGXFsaubARF0vP78khxHOXhn+Z
        a10FVCdivual/4OjN+wqZx7YdaxzXyDhPTH/PHPgEZIvrO1u/KFa5vnmGTP8YwrK
        Ale4mvrVCPUNXAJUCLjJfsp3yCwl4MJHqz9t/k6Kh+WZ8wTV5OMJ8WMuR5+6wXQZ
        B6zlJUI8e0YY4EOXlzP+LGzx9rVVpDVBplsfzITuiFfPzg0fAjcxAYptIib4PVlc
        gIbPOHibYJ2H/Aj0eXMMpMMFPN182k//VwAIFaAODy2yjaM4NRPtKA7Qg==
X-ME-Sender: <xms:SvEHY1bcLwhXvldm_OG-pIXr3WHS2GukpDuE4G7qHEYtuGSpnSs64w>
    <xme:SvEHY8YwlHeQ4Qoh04FAaIneySYXZUSfDN3NamDEGtQS3QEAujqPICPsNvz1qDdc8
    AmkaVyZCVomGIjHJbs>
X-ME-Received: <xmr:SvEHY38A068HozK_2Mg3LYMf-soVdD_0LI6gzbAjS7lLGb_9BnB2JJfqFZ7Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejgedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:SvEHYzq8QEv89mbD1VSORBK1VxcK1YKTGIbBFu0xuAuzkKrWwdcJlQ>
    <xmx:SvEHYwoFaEFcYYghYHCC3aFIu0TO1_mfNehRhlbNwxv0oTxu7ujGjg>
    <xmx:SvEHY5S97x-Hy-4lYjdt2r5xflFrC6UvEdbYFOQip1MugZCmzEhApg>
    <xmx:SvEHY7XBsjwOVqO-Hc_oF5xK7oSAlP1wbCRCMn5xQIDSMwzA0IpvXw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Aug 2022 18:01:43 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     tiwai@suse.com
Cc:     kai.heng.feng@canonical.com, andy.chi@canonical.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 2/2] sound: realtek: Add pincfg for ASUS G513
Date:   Fri, 26 Aug 2022 10:01:30 +1200
Message-Id: <20220825220130.331371-2-luke@ljones.dev>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220825220130.331371-1-luke@ljones.dev>
References: <20220825220130.331371-1-luke@ljones.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes up the pincfg for ASUS ROG Strix G513

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 sound/pci/hda/patch_realtek.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e9cad49ee2a5..abf3fb50692a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7023,6 +7023,7 @@ enum {
 	ALC294_FIXUP_ASUS_GX502_PINS,
 	ALC294_FIXUP_ASUS_GX502_VERBS,
 	ALC285_FIXUP_ASUS_G533Z_PINS,
+	ALC294_FIXUP_ASUS_G513_PINS,
 	ALC294_FIXUP_ASUS_GU502_HP,
 	ALC294_FIXUP_ASUS_GU502_PINS,
 	ALC294_FIXUP_ASUS_GU502_VERBS,
@@ -8308,6 +8309,16 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC294_FIXUP_ASUS_HEADSET_MIC
 	},
+	[ALC294_FIXUP_ASUS_G513_PINS] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x19, 0x03a11050 }, /* front HP mic */
+			{ 0x1a, 0x03a11c30 }, /* rear external mic */
+			{ 0x21, 0x03211420 }, /* front HP out */
+			{ }
+		},
+		.chained = false
+	},
 	[ALC294_FIXUP_ASUS_GX502_PINS] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -9307,6 +9318,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1662, "ASUS GV301QH", ALC294_FIXUP_ASUS_DUAL_SPK),
 	SND_PCI_QUIRK(0x1043, 0x1881, "ASUS Zephyrus S/M", ALC294_FIXUP_ASUS_GX502_PINS),
 	SND_PCI_QUIRK(0x1043, 0x1c92, "ASUS ROG Strix G15", ALC285_FIXUP_ASUS_G533Z_PINS),
+	SND_PCI_QUIRK(0x1043, 0x1e5e, "ASUS ROG Strix G513", ALC294_FIXUP_ASUS_G513_PINS),
 	SND_PCI_QUIRK(0x1043, 0x18b1, "Asus MJ401TA", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x18f1, "Asus FX505DT", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x194e, "ASUS UX563FD", ALC294_FIXUP_ASUS_HPE),
-- 
2.37.2

