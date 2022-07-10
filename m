Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF7D56CEC7
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 13:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiGJLrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 07:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGJLrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 07:47:49 -0400
X-Greylist: delayed 571 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 10 Jul 2022 04:47:48 PDT
Received: from mail.olddoctor.net (unknown [43.154.27.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B9B101DC;
        Sun, 10 Jul 2022 04:47:48 -0700 (PDT)
Received: from localhost (unknown [39.187.221.229])
        by mail.olddoctor.net (Postfix) with ESMTPA id 2743BA671B;
        Sun, 10 Jul 2022 19:38:15 +0800 (CST)
From:   Misaka19465 <misaka19465@olddoctor.net>
To:     corentin.chary@gmail.com, hdegoede@redhat.com, markgross@kernel.org
Cc:     acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Misaka19465 <misaka19465@olddoctor.net>
Subject: [PATCH v2 1/1] platform/x86: asus-wmi: Add key mappings
Date:   Sun, 10 Jul 2022 19:37:27 +0800
Message-Id: <20220710113727.281634-1-misaka19465@olddoctor.net>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,RCVD_IN_PBL,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On laptops like ASUS TUF Gaming A15, which have hotkeys to start Armoury
Crate or AURA Sync, these hotkeys are unavailable. This patch add
mappings for them.

Signed-off-by: Misaka19465 <misaka19465@olddoctor.net>
---
 drivers/platform/x86/asus-nb-wmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index 57a07db65..478dd300b 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -522,6 +522,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
 	{ KE_KEY, 0x31, { KEY_VOLUMEDOWN } },
 	{ KE_KEY, 0x32, { KEY_MUTE } },
 	{ KE_KEY, 0x35, { KEY_SCREENLOCK } },
+	{ KE_KEY, 0x38, { KEY_PROG3 } }, /* Armoury Crate */
 	{ KE_KEY, 0x40, { KEY_PREVIOUSSONG } },
 	{ KE_KEY, 0x41, { KEY_NEXTSONG } },
 	{ KE_KEY, 0x43, { KEY_STOPCD } }, /* Stop/Eject */
@@ -574,6 +575,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
 	{ KE_KEY, 0xA5, { KEY_SWITCHVIDEOMODE } }, /* SDSP LCD + TV + HDMI */
 	{ KE_KEY, 0xA6, { KEY_SWITCHVIDEOMODE } }, /* SDSP CRT + TV + HDMI */
 	{ KE_KEY, 0xA7, { KEY_SWITCHVIDEOMODE } }, /* SDSP LCD + CRT + TV + HDMI */
+	{ KE_KEY, 0xB3, { KEY_PROG4 } }, /* AURA */
 	{ KE_KEY, 0xB5, { KEY_CALC } },
 	{ KE_KEY, 0xC4, { KEY_KBDILLUMUP } },
 	{ KE_KEY, 0xC5, { KEY_KBDILLUMDOWN } },
-- 
2.37.0

