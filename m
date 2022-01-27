Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5950449E5A9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 16:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242891AbiA0PRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 10:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242858AbiA0PRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 10:17:02 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5315C06173B;
        Thu, 27 Jan 2022 07:17:02 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id s61-20020a17090a69c300b001b4d0427ea2so7818299pjj.4;
        Thu, 27 Jan 2022 07:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=DPzP+F3Ei0x6K0HK9/HyrN2suQMOr5qmyB16ZKcnGJw=;
        b=fmjLdtf/+P26UY4yzEmlpn7olHNsBFrCHB9X8qka63dJtOJ/Ve6YeM+hUr53I0P/SQ
         CE7lbik0l4XUoT14EeOfmBmiPn0bWNjp9davLvvKELCywj1tKHdFpyxjU4mWVIFQwbHT
         Sum6Kl1B8jaXl3DTSqe5MJjo7Y5+A9jgpx0JLw+HQUrZ8Z8YDYlVJGZvilDSK7tnAQxB
         XYaX5cCGOAidym6Hfge+yEgow3SQNXK47T0p4S58NEjzdfg1RrIjRRDQHjORpAaoLoY8
         nq3I1RAg0E6pFO2eOG6XF1Hcn6HMsglkYRDf3HRqarZ+SeWnikYw4Nc10KzueJXiyyy+
         Sosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=DPzP+F3Ei0x6K0HK9/HyrN2suQMOr5qmyB16ZKcnGJw=;
        b=x0ckhkfTxPaQ5O6Xfo6K0l1g21QxWZbbYDYCbZWZdcdUf5Dy9kDZbaRNZIkiJffrLB
         WYFQHUHoI74hgtg7VupgWJj2u233j4+ioJobk0tPUL40JBX0Uv8FGYgpK0CIOB2YLItz
         TXSnf+Ruf7qqe9keL+8s7mK9fd7Z7kvHjPepGWfmcZ1l9nVw9PUJ/r13FCjmtIxkClYz
         zcK2Bnve6NvqpeP8OzOWjul9ODymZiY5jOgEIMMxYo5tMX1Ix08fQFBgaGqAM2aP61VV
         L7mEd4I87Cd5hka+Iu9WHO3RDyThCbTBdJ5m6ykx5WMp/dSaZTA10LjSq4R7ilQ6gV1n
         Bkjg==
X-Gm-Message-State: AOAM533jsZ2aaaoXcyoDXBrzrJYriMirFxoyP/6ALZuiAdld+I6AFcPq
        wf/wt7pUeMXTlgWyAy3P8Ac=
X-Google-Smtp-Source: ABdhPJx1Ly4sUBm1O5CZTucJua0zcVrn2ueUTb48E5G7QMQpB69ZYZpE8rfzj+fDnDK+m15GR2m+xg==
X-Received: by 2002:a17:90a:31c5:: with SMTP id j5mr4691533pjf.200.1643296621943;
        Thu, 27 Jan 2022 07:17:01 -0800 (PST)
Received: from paju ([116.124.119.85])
        by smtp.gmail.com with ESMTPSA id v13sm5883597pfi.201.2022.01.27.07.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 07:17:01 -0800 (PST)
Date:   Fri, 28 Jan 2022 00:16:56 +0900
From:   Dongjin Kim <tobetter@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: meson-sm1-bananapi-m5: fix wrong GPIO domain for
 GPIOE_2
Message-ID: <20220127151656.GA2419733@paju>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIOE_2 is in AO domain and "<&gpio GPIOE_2 ...>" changes the state of
TF_PWR_EN of 'FC8731' on BPI-M5

Fixes: 976e920183e4 ("arm64: dts: meson-sm1: add Banana PI BPI-M5 board dts")

Signed-off-by: Dongjin Kim <tobetter@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
 
-- 
2.25.1

