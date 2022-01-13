Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1866D48D5AE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiAMK17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiAMK14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:27:56 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1583BC061748
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 02:27:56 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id o6so21352624edc.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 02:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ew4uKUNam8kJO5439QWHJkc6LyiFyd+nrUpEzZPoFAU=;
        b=YMVg152aDvsUA5jMW9ANbVaRYdw9xsgt4shC2uDV2+B0kRcooMDvq+P4AmdjurudAv
         YBFZPL1XfVxd2THmP1uFUA0+wROIe+gq7gviKWRkKtcG13mAM3FBNvNnAF4xS74MWG96
         LLe338A4aFxeUPYY6isr+ggMZPYdAXFF1/GglXVFrBxr2I+I2MA5Q4lCigRUhkxUIqvQ
         8M083oLrQkI97tKDrK0xI0E/v8IIaMrCoiZP15jDBvZbOj5X6H7d1adG/KvNMwlBDBhw
         PL5IVR2xZs5t7eORUhnDYyT6cw2FjqG2amwUhuPYyErJRYgZNGL8mQ0K7Atn4i+MzO95
         Aafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ew4uKUNam8kJO5439QWHJkc6LyiFyd+nrUpEzZPoFAU=;
        b=JMH9g+NSHX7a1zQue8K39uHYBM/O/FQB2WrZFqWkUx0TpNMQLXcII6WG/QgdDPbC0p
         xKo4NqYefKsdaUmfBvoXSAbDSVE2+99kzzpISWyD+SxLMFi0A2+xtYMRrVKNgfq6w6gO
         ot60yplnl5voxIyB7DyHk+4KWB0+Sr2gnhnVM34SwgsTDL4W5rKope7m3+i2DEkTgqEE
         ehPM6biJSbctWO5dqCo6L96469Vl99xpHgLfvYAqtPcCLM5uFgA2qwO+edOv/AMBBsKf
         QPFm8rM/SBUoOrRl7dhnDqa8CRSHgEBvKXKxXvuOETPYZHT1u+vTXWIgkndZ1TPqHK0C
         dMjw==
X-Gm-Message-State: AOAM530vQgvoGgC6hh2p+Sp+dDQ2uOJzYg60zo0QB2Gz4EhAgXFh0xK6
        5D6wU92aHsudolrdnCqPLBf4Kg==
X-Google-Smtp-Source: ABdhPJyPWTZtV91PFW9Cdo+2mJExh4qrBWd9u1cf4eCMhGrOMHYRaDJhZ4hq9tQAqeerG5TmZKKfXA==
X-Received: by 2002:a05:6402:68b:: with SMTP id f11mr3590479edy.121.1642069674677;
        Thu, 13 Jan 2022 02:27:54 -0800 (PST)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id f13sm728072ejf.53.2022.01.13.02.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 02:27:54 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     robh+dt@kernel.org, narmstrong@baylibre.com, khilman@baylibre.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] arm64: dts: amlogic: meson-s4-aq222: fix waring for leading 0s
Date:   Thu, 13 Jan 2022 11:27:46 +0100
Message-Id: <20220113102746.598763-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building allmodconfig the following waring shows up:

arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts:21.18-24.4: Warning (unit_address_format): /memory@00000000: unit name should not have leading 0s

Fixing the waring by dropping all the '0' except one.

Fixes: 1c1475389af0 ("arm64: dts: add support for S4 based Amlogic AQ222")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts b/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts
index a942d7e06d6e..8ffbcb2b1ac5 100644
--- a/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts
@@ -18,7 +18,7 @@ aliases {
 		serial0 = &uart_B;
 	};
 
-	memory@00000000 {
+	memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x40000000>;
 	};
-- 
2.34.1

