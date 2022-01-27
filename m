Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D9E49E251
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 13:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbiA0MZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 07:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiA0MZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:25:50 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D199CC061714;
        Thu, 27 Jan 2022 04:25:50 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id 128so2457276pfe.12;
        Thu, 27 Jan 2022 04:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=O1I23lbQxRbS0gOwtFANQA3pcrPYjeU63cIBD11oRIk=;
        b=i5ImrwVteI+wtF1s3wLY+xLdAxQ38qOy7dC1ucPNotdJHpWcWmIJKhvKzQSnZuTR1/
         Dw1zZ8usOXrsrNA+CDbLVUpXvLGRmn5l5vb+tQljSE6n6m4I7cTXUTwyaO6ruPkCvxY2
         EAJFGB25BSI70xceO2/nP6jcRZvF9HzI1dmaS1LtMT++n+B9S2f5A4lBwJ3hmW2gbvwL
         ch+xJ1011efQFjEqkmVY401bN+u9K6q8RZFFlmRf5fu05++zkKB21X72AkVRJnQMxtQr
         X2oIfzDlYH/81wRYAzfgI9bSichNt89UlSRfhvQ1x+AyZh5Kxc2YfmRliZ8N30oe1fKD
         d6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=O1I23lbQxRbS0gOwtFANQA3pcrPYjeU63cIBD11oRIk=;
        b=7jzt1cFst5EyziJRfnZj9l7YVQc4QUBMrMs/WG/nWQ09nWPnndMGMiHOoXFmBUzoSx
         tmsyASMTEOiOuqDvXGiaiBTSZaEoUC5YuYAk1XO1dGzlR9GSwNutWsP6NKaHvTKGHP3d
         1gzvCKU+Z9+P/wzwEVa9G6tsgDvYI6JjrQK9SRqUPI8QnVVFQ48YbY0XbtNEDyT87X/E
         uFIPlSjdRFyqZ9yAEXVfJN3CMNJSI+DCHBWl9Sm1dr+CpbfOYkaOSa6CDt3pGeoQb6bV
         FzU9TCfsiuXl/Y57lzV0Kuo2DPB+03GzgnANzLvFUaoU7SzsPvr/RYCPq/pBpgPrU7BV
         uOCw==
X-Gm-Message-State: AOAM533E7jxzIXhqB90UF4TP7skK7reI4/R74FWrbSrSkdN6uhy3PvN7
        LLfrjzQO1crGesMrbVMFz+w2/67r5QE=
X-Google-Smtp-Source: ABdhPJzljtiZkNavuj8PTXtMzuBTWC8mRa/5vu2o9iXZNTBRbSiKzqtfcQ5nn54sDBZ07MZBgxSIcg==
X-Received: by 2002:aa7:8582:: with SMTP id w2mr3185167pfn.3.1643286350264;
        Thu, 27 Jan 2022 04:25:50 -0800 (PST)
Received: from anyang ([106.250.177.234])
        by smtp.gmail.com with ESMTPSA id y41sm5843977pfa.213.2022.01.27.04.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 04:25:49 -0800 (PST)
Date:   Thu, 27 Jan 2022 21:25:46 +0900
From:   Dongjin Kim <tobetter@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: meson-sm1: fix wrong GPIO domain for GPIOE_2
Message-ID: <YfKPSvnFKOaLr74+@anyang>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIOE_2 is in AO domain and "<&gpio GPIOE_2 ...>" changes the state of
GPIOZ_14 connected to INTR of 'RTL8211F' on ODROID-HC and TF_PWR_EN of
'FC8731' on BPI-M5

Fixes: 1f80a5cf74a6 ("arm64: dts: meson-sm1-odroid: add missing enable gpio and supply for tf_io regulator")
Fixes: 976e920183e4 ("arm64: dts: meson-sm1: add Banana PI BPI-M5 board dts")

Signed-off-by: Dongjin Kim <tobetter@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts | 2 +-
 arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
index 212c6aa5a3b8..5751c48620ed 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
@@ -123,7 +123,7 @@ vddio_c: regulator-vddio_c {
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <3300000>;
 
-		enable-gpio = <&gpio GPIOE_2 GPIO_ACTIVE_HIGH>;
+		enable-gpio = <&gpio_ao GPIOE_2 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 		regulator-always-on;
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
index bf29afac645f..d4349b355e4a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
@@ -52,7 +52,7 @@ tf_io: gpio-regulator-tf_io {
 		regulator-max-microvolt = <3300000>;
 		vin-supply = <&vcc_5v>;
 
-		enable-gpio = <&gpio GPIOE_2 GPIO_ACTIVE_HIGH>;
+		enable-gpio = <&gpio_ao GPIOE_2 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 		regulator-always-on;
 
-- 
2.32.0

