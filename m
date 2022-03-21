Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB644E22A5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345366AbiCUI6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 04:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345493AbiCUI5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:57:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988FA57485;
        Mon, 21 Mar 2022 01:56:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 317BAB81151;
        Mon, 21 Mar 2022 08:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62FF8C340F3;
        Mon, 21 Mar 2022 08:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647852981;
        bh=M2Gy8FiVTRYpGNe6BMtTfeY32cNOQh7iPVRsDN8x8+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NNRcCs1SuofokOveoJ8pC12tqUZ3DbIUmh4vdoHVI3RDRv0EDrYdLdajojfhincll
         BXCW99MX9K2Lko2aZavQqbx3D0xcfvN917+gwLYTS52UYVOamkPJ/cR53UF2VFevLP
         /sLQO0ba1Y4C2zqTaUmCXwtGqghTD/twVisDVY8SPpSXFgW9ykaHHDHGyru54i83yy
         AlF066hfU4Z+K4ewcwKIzICt2hIbHlpHtmn7Xek6pUesbFaL/9kxq1qbWa4jVN1YCV
         vx1i/W6DxuCR5QX/0o9kswOcJwyZmxbSYJ0LeF4evUMxe3U4az/204M1EZoRV87Pca
         H3NlKWWOWw62A==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org, robh+dt@kernel.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3 1/5] platform/chrome: cros_kbd_led_backlight: sort headers alphabetically
Date:   Mon, 21 Mar 2022 16:55:43 +0800
Message-Id: <20220321085547.1162312-2-tzungbi@kernel.org>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
In-Reply-To: <20220321085547.1162312-1-tzungbi@kernel.org>
References: <20220321085547.1162312-1-tzungbi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be neat and reduce conflict possibility, sort the headers
alphabetically.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
Changes from v2:
- Add commit message.
- Add R-b tag.

Changes from v1:
- Update email address accordingly.

 drivers/platform/chrome/cros_kbd_led_backlight.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_kbd_led_backlight.c b/drivers/platform/chrome/cros_kbd_led_backlight.c
index aa409f0201fb..f9587a562bb7 100644
--- a/drivers/platform/chrome/cros_kbd_led_backlight.c
+++ b/drivers/platform/chrome/cros_kbd_led_backlight.c
@@ -4,12 +4,12 @@
 // Copyright (C) 2012 Google, Inc.
 
 #include <linux/acpi.h>
-#include <linux/leds.h>
 #include <linux/delay.h>
 #include <linux/err.h>
-#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/leds.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-- 
2.35.1.894.gb6a874cedc-goog

