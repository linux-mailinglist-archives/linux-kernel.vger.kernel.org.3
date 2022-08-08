Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7F658C291
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 06:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbiHHEhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 00:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiHHEg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 00:36:57 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1570DFD9;
        Sun,  7 Aug 2022 21:36:55 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id BBA1F5C00EB;
        Mon,  8 Aug 2022 00:36:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 08 Aug 2022 00:36:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1659933412; x=1660019812; bh=la3gaXFDAV+XSZzwAEHuiTEeD
        ndCQTywd59d5crhzEM=; b=DRGRzZJ2yUWoVPShnK66HINQaNZ/3QnjBpgVLab5h
        Lx9tNSiHngpjhdaq28r2rVFqSrcTnbbL9x1huRBKilnjNaiBlJeEZ4S5LkDDLdxf
        e+RX5vnoXU9/pRLrIfQw66cEhSSVHBQkrKNs5hAPxcVEwPsIPraVuUkRR8SNTYZ/
        /+72/3/DPyHcr/DbRBJgyjl1TQ/wB7GHxrmgx8bcv2BoMSSLEy2gneF3N4poAjpK
        xfxr20haTsEFAA4Sa77ZJ9SmEJ/P1KMiuQUI/PMm8OvPlkpX3Lt4LPu5gUxQ0SgH
        cN4LgPVkCL0tht6hbRa/ukZMh54A5/oyZ09L91v/eVFNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1659933412; x=1660019812; bh=la3gaXFDAV+XSZzwAEHuiTEeDndCQTywd59
        d5crhzEM=; b=glYTRUN2jaz8Tm27ioDK+HI2y29v+uac4w3WxIAgu2KwWT3E0mN
        4TfzKpgv6SZGDMZAaJw2RqyfMMte16L9zbBo13PeOP8v5HFKR3x31C0Hzx69SruC
        J3s7ySr+/UZ6l+E1Nx1CqohJAQPiHTZmG8EO/KH1MpU3wIn/EHhGnPogmekhci5Z
        P4OeODBkcJTOuRMyThwk0zQ2LRvcnD5V9Pp0OpQ1+gxyZPvs0pgnokHPThCJ94Ch
        MmDh1BI1MSRwqVRbl0cjBFiVccjK3CYwxJIYILMjHnelrvVb6HYPuYTGeJf0l8kQ
        V/GF5ivptfGXwmwBBMvZgZamsVxP+tu3nsg==
X-ME-Sender: <xms:5JLwYtqpy6s0u8oEnFP8CDxPkPlowrsGcCrUKy_nP-6emnSBjPzsPQ>
    <xme:5JLwYvpJPwmvnr92G6kc_mHdLdV7aBCufGTIB0fxBsDs3vcvSJzjTCEsODyCQ2XX0
    1RtfG98SXQUmPrcoVs>
X-ME-Received: <xmr:5JLwYqNzQcL-kOWxyHrUGxdjRY4RJSGnoJop80pFif4GTwHoZlRDRTo1gcyz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefjedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfdujedthfduudekffefkeeiffdttd
    dvhfegudduueffuefhfefggeefteevvdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:5JLwYo4a6rxIjEcPziJ7LmedHI1-2mFu8hcPsSwJq7Tq1FqUclI3jw>
    <xmx:5JLwYs6mtJ6xQUNyOC45Gmmw7Zc9bSFptKRiM4yIW5faRIADtNDaTQ>
    <xmx:5JLwYgi2lssq4fGiXQh9Yy1Mvp5YU6d_854nIRWpUho5DDXhyshBfg>
    <xmx:5JLwYsF_dHOuB4mMglkfIcHLcqickYozt-hiRz5S8jkz3KT_PrT5XQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Aug 2022 00:36:50 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 1/2] asus-wmi: Modify behaviour of Fn+F5 fan key
Date:   Mon,  8 Aug 2022 16:36:42 +1200
Message-Id: <20220808043643.1571932-1-luke@ljones.dev>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index a81dc4b191b7..18eec80b7154 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -573,6 +573,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
 	{ KE_KEY, 0xA5, { KEY_SWITCHVIDEOMODE } }, /* SDSP LCD + TV + HDMI */
 	{ KE_KEY, 0xA6, { KEY_SWITCHVIDEOMODE } }, /* SDSP CRT + TV + HDMI */
 	{ KE_KEY, 0xA7, { KEY_SWITCHVIDEOMODE } }, /* SDSP LCD + CRT + TV + HDMI */
+	{ KE_KEY, 0xAE, { KEY_FN_F5 } }, /* Fn+F5 fan mode on 2020+ */
 	{ KE_KEY, 0xB5, { KEY_CALC } },
 	{ KE_KEY, 0xC4, { KEY_KBDILLUMUP } },
 	{ KE_KEY, 0xC5, { KEY_KBDILLUMDOWN } },
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 0e7fbed8a50d..ac06fec0565c 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3099,14 +3099,13 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
 		return;
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

