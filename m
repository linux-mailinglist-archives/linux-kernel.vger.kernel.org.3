Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB8B57CE6E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 17:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiGUPBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 11:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbiGUPBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 11:01:39 -0400
Received: from mail.boiledscript.com (mail.boiledscript.com [144.168.59.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35767A50E;
        Thu, 21 Jul 2022 08:01:38 -0700 (PDT)
Message-ID: <y76wnc6o6w9.wl-hako@ultrarare.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ultrarare.space;
        s=dkim; t=1658415143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=WTkPvBNLDrnyNYrtfpFg5lgdjoVZlrQg0/eORua9JR8=;
        b=WVHazqJmhEgSRqQscIcJxdzVwXsMW0O2cxKQrItUOUPR/s2jiTDIwvXog5vP01q4eaTCSG
        C68A+k1iHSgySDlRN9/ZtSMnoL5ySSn82ETdP6NrnuiBd/Ny8AoUfzHuiRyThUjSUWeWEE
        jP8xWntNtcWQoNwU5mH7CNqK+Xto9LSKXvKcS3QIwyfQ+iQcaokdZm0+7t2rGD84a5fYPs
        FF+SOMjBsvXO9HEl1Wtq4JRTNJVE0k2zeIL9+hW+GXTijcipnUahpkjWcGAUQ93IoYeiCd
        pwsuQheaEyKo1WnLIxqyJ6Rx+fWOMfdoEdmffszdMtBRFg0h+7HVpUDltxJcfQ==
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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
