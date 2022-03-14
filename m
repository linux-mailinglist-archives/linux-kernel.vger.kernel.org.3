Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358C94D7E44
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237901AbiCNJKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237857AbiCNJKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:10:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF21F42A3D;
        Mon, 14 Mar 2022 02:09:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FF9BB80D5A;
        Mon, 14 Mar 2022 09:09:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA817C340F5;
        Mon, 14 Mar 2022 09:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647248952;
        bh=spwdTO7RC4wZ9ulgHe1HjaFtsCLNUN5rQMMjLkFKp3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tPvi7DK05b65cUjbw8qAi8O3SOrVVMsisuxwx07XEi4VcYvj87u7k2wg7j6R8RGus
         k3IMvEpLFNGXOGjTV3sf4Ewpzq0JS+0dl43sev9nS6wkgAz3CN+mlCz5xGFTUtEujJ
         BATndB1xs+JoM0y/+ReH6q3DUygsG2Qz3KXjsQjcmBzOilfc6eiQp/Lowxcy97iMr5
         YRu5qXljtiEPxlDf3WjDXEh67drpmboys0vNQ6J2KJwxwt7zPk2pfREpV3LAvjGumm
         jw8nfwsLQc++0p+ke6eX9BSia5Tv6sGVRyNfBobtwHzMVsW3Uz6/lv0M9nFzUhSn6Y
         qcrf47ttBjCDA==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, tzungbi@kernel.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] platform/chrome: cros_kbd_led_backlight: sort headers alphabetically
Date:   Mon, 14 Mar 2022 17:08:31 +0800
Message-Id: <20220314090835.3822093-2-tzungbi@kernel.org>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
In-Reply-To: <20220314090835.3822093-1-tzungbi@kernel.org>
References: <20220314090835.3822093-1-tzungbi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
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
2.35.1.723.g4982287a31-goog

