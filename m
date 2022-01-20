Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB3849531F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 18:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377326AbiATRYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 12:24:08 -0500
Received: from mail-oo1-f49.google.com ([209.85.161.49]:38640 "EHLO
        mail-oo1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377331AbiATRYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:24:05 -0500
Received: by mail-oo1-f49.google.com with SMTP id w15-20020a4a9d0f000000b002c5cfa80e84so2514483ooj.5;
        Thu, 20 Jan 2022 09:24:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4wFfi5dvrPs9K8Et4jwF3OW5L3T+FBbrajKxVkpiUl8=;
        b=jPjpU0eqgM7cXv+FlyEzfgnHohuapiPEDBZPmivNavIM4vmxoqj+rUfpLMKD6PJr8p
         LQrpRFvwLeQJITb+CJfldM9IJNaxkf+gaBtzHcILtiSYQnAg+WEjTmS74nDis4ToGWP1
         +TQ0n3nBkdgoXlwD1VoOROkpvBwpRPKpLY84IuxuRQFFtk3hSrvX7+QiKoc9rCxJ9519
         K2OZ+lv6pLvYT6hV97Kd7JwtITK+tFvFEr9DoHPqIEX93Vek32K60QWSEaUeqLZIi1ZA
         b1v4Z7mkJdiwxyC8441R52eGHBd5kvuRbQUeu7la8jIMdXtawpVVOmnS+RlKme08aK3n
         xt9A==
X-Gm-Message-State: AOAM531LUYz2untJeghftAUMQW7FmqYG+rhLyphfObNFOnmY6eDmiMhP
        X0q7Cxdq9q/LnK6ofzNq/g==
X-Google-Smtp-Source: ABdhPJzf1lBCbgaoczLjcM9UyXs2KwEWIOqixZJnvtKEA1iGAADtZoPsfk9lORL/5udRSkr2LcFxAw==
X-Received: by 2002:a4a:b4cb:: with SMTP id g11mr26820796ooo.46.1642699445132;
        Thu, 20 Jan 2022 09:24:05 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id x22sm1406405ooo.29.2022.01.20.09.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 09:24:04 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: imx7ulp: Fix 'assigned-clocks-parents' typo
Date:   Thu, 20 Jan 2022 11:23:55 -0600
Message-Id: <20220120172355.1629650-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The correct property name is 'assigned-clock-parents', not
'assigned-clocks-parents'. Though if the platform works with the typo, one
has to wonder if the property is even needed.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/boot/dts/imx7ulp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7ulp.dtsi b/arch/arm/boot/dts/imx7ulp.dtsi
index b7ea37ad4e55..bcec98b96411 100644
--- a/arch/arm/boot/dts/imx7ulp.dtsi
+++ b/arch/arm/boot/dts/imx7ulp.dtsi
@@ -259,7 +259,7 @@ wdog1: watchdog@403d0000 {
 			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&pcc2 IMX7ULP_CLK_WDG1>;
 			assigned-clocks = <&pcc2 IMX7ULP_CLK_WDG1>;
-			assigned-clocks-parents = <&scg1 IMX7ULP_CLK_FIRC_BUS_CLK>;
+			assigned-clock-parents = <&scg1 IMX7ULP_CLK_FIRC_BUS_CLK>;
 			timeout-sec = <40>;
 		};
 
-- 
2.32.0

