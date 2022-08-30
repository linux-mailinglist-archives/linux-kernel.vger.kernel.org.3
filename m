Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65F15A7139
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 00:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbiH3W6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 18:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbiH3W6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 18:58:38 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BAA82F8E
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 15:58:37 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id y1so10650359plb.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 15:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=9i6pUjJNJbv0URDTN17d2CcuUvvkFRJoPPsB0ChrC84=;
        b=K2J5xRAk/tKVnjvdGCtwzZC/znuGdEUztUB2UHn4wXft/46xq8gyf0Ddl57gL2NETG
         M0vOBzYECWvKK4hidx1uBJNXH2NsR9pGU3zcm1+sXOa9rrbJrvaKTah1s9gjtU1As/XQ
         +GhjBJOLmxYXJbLlpGP3ExvkBiOw6dPva01r4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=9i6pUjJNJbv0URDTN17d2CcuUvvkFRJoPPsB0ChrC84=;
        b=XUHt/w+2jZj6J+XIsfjcyjYDihAZAWi8w20OaH7WEHD71Wax6GqwIFUgZFFxTvzPi5
         3sPs7/zLI0JFO1CtUmynOdscrDNNDnBy51h1VjuMQopi3Q0WAfegUGWPr3e99au5+/Ps
         BlNPIsDUmeAJKWVxgRa7GDXDNusLKi36bSU7pw+vEAEIae4x8wbFTONI1t+gZ3tGT0es
         poWPXzA+geeI9OcwtqaKh6cvmrQ6qAnddqE30bcKjJCoTN16fL9jtbNtQl6hLQrUSQs5
         urRk8vxr9BvgTqt1JqKBtSfuPqoDssGBrxO2r5UuMhIwzDMTxAJ0y+X/vaqrEeo5Zzpg
         hozg==
X-Gm-Message-State: ACgBeo0nxGCAC/KtLVp8TX1Da/XYEc6XRIU1br+gu92RBWfTSgr2CUZG
        mgURD6LCSIBVeEcwf+GYLtlsSw==
X-Google-Smtp-Source: AA6agR6wm6nWs+6nAf9TZDvola8E8ygfG4X7jJS1hsOIaTMHd8b0kiBAbmAJLdFsGBuzT3sT26/VrA==
X-Received: by 2002:a17:90b:4d8f:b0:1fc:314a:17e7 with SMTP id oj15-20020a17090b4d8f00b001fc314a17e7mr284377pjb.194.1661900317130;
        Tue, 30 Aug 2022 15:58:37 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:5f34:2f6:2856:188e])
        by smtp.gmail.com with ESMTPSA id bf3-20020a170902b90300b001743be790b4sm10083539plb.215.2022.08.30.15.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 15:58:36 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        chrome-platform@lists.linux.dev, Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [PATCH 4/4] platform/chrome: cros_typec_switch: Inline DRV_NAME
Date:   Tue, 30 Aug 2022 15:58:31 -0700
Message-Id: <20220830225831.2362403-5-swboyd@chromium.org>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
In-Reply-To: <20220830225831.2362403-1-swboyd@chromium.org>
References: <20220830225831.2362403-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This macro is only used one place, let's inline it instead to save a
line or two.

Cc: Prashant Malani <pmalani@chromium.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/platform/chrome/cros_typec_switch.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_typec_switch.c b/drivers/platform/chrome/cros_typec_switch.c
index 09ad0d268f4b..a26219e97c93 100644
--- a/drivers/platform/chrome/cros_typec_switch.c
+++ b/drivers/platform/chrome/cros_typec_switch.c
@@ -18,8 +18,6 @@
 #include <linux/usb/typec_mux.h>
 #include <linux/usb/typec_retimer.h>
 
-#define DRV_NAME "cros-typec-switch"
-
 /* Handles and other relevant data required for each port's switches. */
 struct cros_typec_port {
 	int port_num;
@@ -309,7 +307,7 @@ MODULE_DEVICE_TABLE(acpi, cros_typec_switch_acpi_id);
 
 static struct platform_driver cros_typec_switch_driver = {
 	.driver	= {
-		.name = DRV_NAME,
+		.name = "cros-typec-switch",
 		.acpi_match_table = ACPI_PTR(cros_typec_switch_acpi_id),
 	},
 	.probe = cros_typec_switch_probe,
-- 
https://chromeos.dev

