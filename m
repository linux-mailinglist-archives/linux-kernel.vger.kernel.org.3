Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E165919A6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 11:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238972AbiHMJhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 05:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238925AbiHMJhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 05:37:00 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8697C41D02;
        Sat, 13 Aug 2022 02:36:59 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 9F2693200904;
        Sat, 13 Aug 2022 05:36:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 13 Aug 2022 05:36:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660383418; x=1660469818; bh=5s
        JrxwyxQvWKQb1bzW9egtWpG8+alHMEb9LZTo1uBPM=; b=lXvEN5Y/8LS7q/FLxs
        5RNfGI5/dmIWehRPMH9uU17gibgK2ZFsQB6DYMHNBNjIyzQPniY/noYgBgjsMkJW
        pA8VMDgYp4igaA8PQy2EzwSiJql682Iq1W1e1Bl2bTeWLzqYMX4NNZ6tQXhsS2h6
        Uvv52ABEowvZldqGS5wE1TMkK8ZTWgQRVlWUR4DzXx34YNPxIEK2YZOVAFO9vzaE
        R6QGJ40amdcjveJ/PhxndgZJspWDDw4k/Wd3HwPsK7GLqSi0fORLhPsta62gxu8Z
        jS9/0XwTigFAl27MOAv6YMSOghcQjkG7aahRqI6pu4SzJn6owe4clGjBzwrWW7+2
        77iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660383418; x=1660469818; bh=5sJrxwyxQvWKQ
        b1bzW9egtWpG8+alHMEb9LZTo1uBPM=; b=Co0hk6ZWO47495/f1cRQrytV2lKbM
        Xi4SrCbNFPP/uqVyDXq2Yf3BaI9LwVyB79QVkmZ5Q+6t8V8CXH8Wc0mfc8uTBnhe
        ipOVSYAnVn5MmonUDguGoJsrFlNh7OG4T6kbce77yvUkYJPgrx/EL8ga1GdLiziO
        HCibZFwS3tzyZ80Kd0YBXYQUWFP9EvYCUHQi5inWD+L28r0JKsicUNJQLn03UWHC
        UV9J4hLsdZ6q+YnehutqxDVRNKenqZsTD6zUNDRSyaqA6odOlRw5LFMozxshNkBs
        UTY/yfLXFCtP/Tv44Hx4hW456GwoF/HayIxpsftHRObFr4B/6kSlh6WCA==
X-ME-Sender: <xms:uXD3YgF2vBO4rehG9gh3UKAD8eXd_HPDD_fGB0CzD1hMh1nN-8REeg>
    <xme:uXD3YpVAJajmtKFyFdh2pj_igJrB1AFW-6IW1fLYZbrNL9-gZhS7hPMnAQNI3GJWI
    tPG46J--YWzcsoJmO4>
X-ME-Received: <xmr:uXD3YqK1nsYpcIKbMuZyZobZxyerloUnfEqRzZB-xvoEeZcqWo1UaK2ZkkUl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegkedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:unD3YiFO_lrzydvfYDnlyHESEYXD1lJ0tukik7ANoVmBaf_6ohrkKg>
    <xmx:unD3YmWuKBmf8tTZ31FQ-8YJLba-ov7cXCKkZJuwKZfqp_6niN6o-w>
    <xmx:unD3YlObAx8k5hY7Gr1-M5bczkswFNdGm1N6aHLCyiGkMCvRG-ueiQ>
    <xmx:unD3YjhD8y6rIaL1wW3AwMZYQYwlMPnFh2mcta38e0zJ8EDGJxYPyg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Aug 2022 05:36:55 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 1/2] asus-wmi: Modify behaviour of Fn+F5 fan key
Date:   Sat, 13 Aug 2022 21:36:41 +1200
Message-Id: <20220813093642.7440-2-luke@ljones.dev>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220813093642.7440-1-luke@ljones.dev>
References: <20220813093642.7440-1-luke@ljones.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some more recent TUF laptops have both fan_boost and thermal_throttle.
The key code for Fn+F5 is also different and unmapped.

This patch adjusts the asus_wmi_handle_event_code() match to match
for both 0x99 and 0xAE, and run both mode switch functions for
fan_boost and/or thermal_throttle if either are available.

It is required that both are tried, as in some instances the ACPI
set-method for one may not have any code body within it even though
it was returned as supported by the get method.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-nb-wmi.c |  1 +
 drivers/platform/x86/asus-wmi.c    | 11 +++++------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index d4cc6afc1861..c0a0d3f1db3e 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -584,6 +584,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
 	{ KE_KEY, 0xA5, { KEY_SWITCHVIDEOMODE } }, /* SDSP LCD + TV + HDMI */
 	{ KE_KEY, 0xA6, { KEY_SWITCHVIDEOMODE } }, /* SDSP CRT + TV + HDMI */
 	{ KE_KEY, 0xA7, { KEY_SWITCHVIDEOMODE } }, /* SDSP LCD + CRT + TV + HDMI */
+	{ KE_KEY, 0xAE, { KEY_FN_F5 } }, /* Fn+F5 fan mode on 2020+ */
 	{ KE_KEY, 0xB5, { KEY_CALC } },
 	{ KE_KEY, 0xC4, { KEY_KBDILLUMUP } },
 	{ KE_KEY, 0xC5, { KEY_KBDILLUMDOWN } },
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index c62977cd07bf..04699dd72f1b 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3104,14 +3104,13 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
 		break;
 	}
 
-	if (asus->fan_boost_mode_available && code == NOTIFY_KBD_FBM) {
-		fan_boost_mode_switch_next(asus);
+	if (code == NOTIFY_KBD_FBM || code == NOTIFY_KBD_TTP) {
+		if (asus->fan_boost_mode_available)
+			fan_boost_mode_switch_next(asus);
+		if (asus->throttle_thermal_policy_available)
+			throttle_thermal_policy_switch_next(asus);
 		return;
-	}
 
-	if (asus->throttle_thermal_policy_available && code == NOTIFY_KBD_TTP) {
-		throttle_thermal_policy_switch_next(asus);
-		return;
 	}
 
 	if (is_display_toggle(code) && asus->driver->quirks->no_display_toggle)
-- 
2.37.1

