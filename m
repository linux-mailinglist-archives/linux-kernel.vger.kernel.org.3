Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D5B5A7136
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 00:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiH3W6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 18:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiH3W6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 18:58:36 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D237D7BB
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 15:58:34 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id x23so12511090pll.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 15:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=k6LA1rNyhTjjcasNmZFLeY+W8E8y8NGMThT486iHSoY=;
        b=Ep24sHO070cnIFiiLG6kNJPWDqR2eSE+4qF+qy1Dpph5f6mj79zWGMf3QxdFk/MnWf
         S5NN4Jf7V/9x14Ed4VoZUnHArb2dtaW8KqL3LDsl17cTZoAmeNNJHhe90BGX5qkR34Gd
         UEfG8SF4TaeCxXk2M0BoSMAIfW2qddG9ZcM7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=k6LA1rNyhTjjcasNmZFLeY+W8E8y8NGMThT486iHSoY=;
        b=JlDuU9TtD5Prfb7UhmmoeyJi2xyFtur4v3WOHrJn9+6QlTD/BEvLM0njZn4IHqqBTx
         tqSPJJr+BR3KEPFskuZUkmjxQjhPwm9Bddsi2Bp+E/DXK4p62M4ZoHvVZYsLDVD0uKEN
         bH4/UFGm6nxTvijDnsrh0Gq01YPdHgynDAKHpj2R3qk4iCLjMrYPT/yQoTZaWcsVwvWs
         aLoYO3LkU4ziz6D6jCdzNYSxLqSPCiLNvZMR1qbgj+EdpE2sLJm9XTjbg4G7WP1chGFf
         Oerf8baX2LHv1KQE8u770ud3uKPmrTOI8boK/zjzDCLHMmVBcRza0zEZgAZ9ztG6IAZk
         rDOg==
X-Gm-Message-State: ACgBeo1Y6MBLpBYl/dlWH9n3JAALqfIObmMapTWeXFKJCUzJK/et+LhL
        A5eHG6/tD30wHYEX3zykF1Ngbw==
X-Google-Smtp-Source: AA6agR6soIRzWhUs7dOLjwua1oVBUDAFDTUzVhZQra4bxTiH3oROVieLZEHDWGIr1KvJ5tedIvAXHw==
X-Received: by 2002:a17:90a:f2cb:b0:1fd:90a0:56e3 with SMTP id gt11-20020a17090af2cb00b001fd90a056e3mr269959pjb.113.1661900314469;
        Tue, 30 Aug 2022 15:58:34 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:5f34:2f6:2856:188e])
        by smtp.gmail.com with ESMTPSA id bf3-20020a170902b90300b001743be790b4sm10083539plb.215.2022.08.30.15.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 15:58:34 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        chrome-platform@lists.linux.dev, Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [PATCH 1/4] platform/chrome: cros_typec_switch: Add missing newline on printk
Date:   Tue, 30 Aug 2022 15:58:28 -0700
Message-Id: <20220830225831.2362403-2-swboyd@chromium.org>
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

We need a newline here to ensure the next printk starts fresh.

Cc: Prashant Malani <pmalani@chromium.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>
Fixes: affc804c44c8 ("platform/chrome: cros_typec_switch: Add switch driver")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/platform/chrome/cros_typec_switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_typec_switch.c b/drivers/platform/chrome/cros_typec_switch.c
index f85687adb594..383daf2c66b7 100644
--- a/drivers/platform/chrome/cros_typec_switch.c
+++ b/drivers/platform/chrome/cros_typec_switch.c
@@ -244,7 +244,7 @@ static int cros_typec_register_switches(struct cros_typec_switch_data *sdata)
 		}
 
 		if (index < 0 || index >= EC_USB_PD_MAX_PORTS) {
-			dev_err(fwnode->dev, "Invalid port index number: %llu", index);
+			dev_err(fwnode->dev, "Invalid port index number: %llu\n", index);
 			ret = -EINVAL;
 			goto err_switch;
 		}
-- 
https://chromeos.dev

