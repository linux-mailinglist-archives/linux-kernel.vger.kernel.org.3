Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2245848EB65
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 15:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241450AbiANOPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 09:15:51 -0500
Received: from mout.perfora.net ([74.208.4.197]:59577 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241444AbiANOPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 09:15:50 -0500
Received: from localhost.localdomain ([81.221.144.115]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MA82J-1n1XkS28s5-00BN6P;
 Fri, 14 Jan 2022 15:15:33 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Rob Herring <robh@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Frank Rowand <frowand.list@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/11] dt-bindings: gpio: fix gpio-hog example
Date:   Fri, 14 Jan 2022 15:14:58 +0100
Message-Id: <20220114141507.395271-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220114141507.395271-1-marcel@ziswiler.com>
References: <20220114141507.395271-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xFK4LGuItNGSNTma0SMQ7RSr3e4uAb9RyHyRiJaV7Rm55JquVNP
 4H9TEkjq/YFvBUEIxp5kqPwnuY8/qU0WbXmx3+sUhycuV6X3m2Ic0C64aKxHnNAbaDSoXC6
 MS9QFMRnWtq6qJo6JjnVOsMug2bya63AyKq/QppzD8xoixp24CiqpTGgh1ab6q4RzTmRMwp
 lLHSaS3JDfd0AwV2g1/2Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4ekKvrQAY8Y=:aDvkCu0gy8aAhHqnEsoYgN
 qUum0Q4W9Q8mgfL/EzUZljc3z715TVPC3aP5c2nC5AbAM8VNnklGvDSsqmVkvjAU/GJk+Qbhc
 DmydSLuuhcThG4w8/tOSQsT/3x4SPFVyNlVpRcTQRnl70a9Mq8CfznXAbv8qreRTRLcSPb68T
 k/rpqfp/60mXFQA6ZElppgLuiR6qMNL9Iuf6/CfFhf+H3vDkY0Hsniwlvg5bDubywynsbcKzY
 6EDJ5eVbuFSWOG+9vwP6GaPcMRFV9uk3Ojx2QR3d0aDCfXFNzLUQCCvMs4sIKRPXE6KDbL2rl
 BIbwCJ60WMef0/uvRGmgrd4/+042dirkBfq1nqeHWekJwo99hnYom69mMfTDIUAUDfuRMIMXS
 2Ih4/dlq/CZ7DyEjAfJFTJN3vTgs5QEcC/LcaTyojJ/99sTPEAQi7at46etuAphjFCw7c6H6g
 PjeHwC4Rwghd/xR/68NH92Is7mTQWNX7eTtxtLGISeyKuoRUX9tf+244ea4uwDM3aajnJdGbC
 PO5PZ/I2IaYwR1C/Ab3H/BdhTP5xKzAg2JLXrkiDP0DU5zx/Nr20N6szMBcCsNdowt7AjfM0B
 kIX7ELuywRdmta2kR4Fmz1grm9EJ4G6CEge4nxON+h0iH5WdkUGECkVsGPPmmcQNnYeccuyr6
 n14OCB99focr6zD/zpDi9kTWeINN0nS5Zl6zYKWPOpfoXrJBCq97z0xgwUCt4koa1wcA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Even if this is no yaml yet at least fix the example to be compliant to
later schema as e.g. found in gpio-pca95xx.yaml, fairchild,74hc595.yaml
and gpio/fsl-imx-gpio.yaml.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Acked-by: Rob Herring <robh@kernel.org>

---

Changes in v2:
- Added Rob's ack.

 Documentation/devicetree/bindings/gpio/gpio.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio.txt b/Documentation/devicetree/bindings/gpio/gpio.txt
index a8895d339bfe..5663e71b751f 100644
--- a/Documentation/devicetree/bindings/gpio/gpio.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio.txt
@@ -213,7 +213,7 @@ Example of two SOC GPIO banks defined as gpio-controller nodes:
 		gpio-controller;
 		#gpio-cells = <2>;
 
-		line_b {
+		line_b-hog {
 			gpio-hog;
 			gpios = <6 0>;
 			output-low;
-- 
2.33.1

