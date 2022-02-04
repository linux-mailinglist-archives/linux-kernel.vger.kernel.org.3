Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1AA44A919E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 01:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356234AbiBDA2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 19:28:10 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:42515 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351466AbiBDA2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 19:28:09 -0500
Received: by mail-oi1-f178.google.com with SMTP id v67so6647247oie.9;
        Thu, 03 Feb 2022 16:28:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8HtB4xB7o6hXbgLfwRbUeCoDsxhbCbtJSWGozDMovVk=;
        b=sZspG7xn+/kOHcJyGjcj6OfrRNYMLTynL8SE4TS1veq6g4+Uagfe/gwCGifoj28RMD
         IjRGQSDsTmN5JIh/pu2OqKauvIcBCXbzMPqsLMY5Nd1vjkWfEqAWsTDJ/0+SWjl2auBS
         YJFeJQEINEQ/OiWz8zwnOUjyj/KFLVv+KHiuRjLDh4vjxcfby9Heu3/3N5VLVbX/c9Fo
         RiK8dmvAg79aXN71KkyvSxZ2x5R/BiRIq5BDgdUknuvGiBjIUUgnP+O+4twuIQajbPvI
         1e09+9MEGrNlrCcIGc49Dq3N0jlGzsDOTOVcjR+2/NkplRLiZ723DqlH94G28u27+Kpt
         e4aQ==
X-Gm-Message-State: AOAM531lehPeYMUitIosskHf5y+hrEbrE8c49LBRtUhI8nUPdt4fsBCV
        w5ZRZsnpSYCLPzNO4DzPvg==
X-Google-Smtp-Source: ABdhPJw2Dg0v+X6ZepvOu6aani78Em/DxuFa5e5HsctFjHeKIC9FX4la9ddS6qjjU38YaYQT3enVVw==
X-Received: by 2002:a05:6808:20a2:: with SMTP id s34mr113274oiw.295.1643934489148;
        Thu, 03 Feb 2022 16:28:09 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id v10sm178184oto.53.2022.02.03.16.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 16:28:08 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: sun8i-h3: Drop args in 'thermal-sensors'
Date:   Thu,  3 Feb 2022 18:28:01 -0600
Message-Id: <20220204002802.1214602-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "allwinner,sun8i-h3-ths" thermal sensor has 0 argument cells, but
the consumer has an argument cell. It is ignored by the code, but the
error was found with some upcoming schema validation changes. The schema
and code both agree that 0 cells is correct.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 845f25235407..eac2349a2380 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -245,7 +245,7 @@ thermal-zones {
 		cpu_thermal: cpu-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
-			thermal-sensors = <&ths 0>;
+			thermal-sensors = <&ths>;
 
 			trips {
 				cpu_hot_trip: cpu-hot {
-- 
2.32.0

