Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4340757CE50
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbiGUO4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiGUO4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:56:40 -0400
X-Greylist: delayed 254 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 21 Jul 2022 07:56:38 PDT
Received: from mail.boiledscript.com (mail.boiledscript.com [144.168.59.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C38D49;
        Thu, 21 Jul 2022 07:56:38 -0700 (PDT)
Message-ID: <y761queplmt.wl-hako@ultrarare.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ultrarare.space;
        s=dkim; t=1658414932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=WTkPvBNLDrnyNYrtfpFg5lgdjoVZlrQg0/eORua9JR8=;
        b=xe23SRSbcTvq/CT0Q13ph/5wjy7GZxDRFRJQlS8k2kOzHn08N3gcCAI1Eq41MoSD4oral7
        aG7lIHRSEciqS6iOrHpxiSQO3zvgfSBtpLT2bnGgL7/J8EoMT+dqVbR0lM1376E8moVKir
        aFvmmGlOo4CC1aJpl8tm9LHXmulpXF3wBNQIbgnGxcidPaDGDU8yXtPOq8J16MNwd9/hs+
        P+djwN5HlTy38Ok5p9/dkTGCGcHsC2H6lhRmAPTUhy8P5oOBn/pLKfF7nrT4J/vuq176Jb
        A+Bum4G71veYBa6mzvvUeszmJTv37AqbSoCERPbYmS5ETWP8F9cuc0QkdYM5Ig==
From:   Hilton Chain <hako@ultrarare.space>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?ISO-8859-1?Q?Jos?= =?ISO-8859-1?Q?=E9_Exp=F3sito?= 
        <jose.exposito89@gmail.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] HID: apple: Add "GANSS" to the non-Apple list
Date:   Thu, 21 Jul 2022 22:34:23 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Bar: ++
Authentication-Results: mail.boiledscript.com;
        auth=pass smtp.mailfrom=hako@ultrarare.space
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While using the name "SONiX USB DEVICE" for wired mode, my GANSS keyboard
uses "GANSS" for bluetooth mode as well, so adding this to the list.

Signed-off-by: Hilton Chain <hako@ultrarare.space>
---
 drivers/hid/hid-apple.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 7fbde58e1219..6970797cdc56 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -320,7 +320,8 @@ static const struct apple_key_translation swapped_fn_leftctrl_keys[] = {
 static const struct apple_non_apple_keyboard non_apple_keyboards[] = {
 	{ "SONiX USB DEVICE" },
 	{ "Keychron" },
-	{ "AONE" }
+	{ "AONE" },
+	{ "GANSS" }
 };
 
 static bool apple_is_non_apple_keyboard(struct hid_device *hdev)

base-commit: a0a05054583fed17f522172e101594f1ff265463
-- 
2.37.1
