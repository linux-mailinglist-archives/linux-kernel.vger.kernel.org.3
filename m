Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6435247FAE4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 09:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhL0IG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 03:06:59 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:59793 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbhL0IG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 03:06:57 -0500
Received: from droid09-sz.software.amlogic (10.28.8.19) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.2176.2; Mon, 27 Dec 2021
 16:06:53 +0800
From:   Qianggui Song <qianggui.song@amlogic.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>
CC:     Qianggui Song <qianggui.song@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: pinctrl: meson: Add compatible for S4
Date:   Mon, 27 Dec 2021 16:06:48 +0800
Message-ID: <20211227080649.32275-2-qianggui.song@amlogic.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211227080649.32275-1-qianggui.song@amlogic.com>
References: <20211227080649.32275-1-qianggui.song@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.8.19]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new compatible for Amlogic's Meson-S4 pin controller

Signed-off-by: Qianggui Song <qianggui.song@amlogic.com>
---
 Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
index 0aff1f28495c..8146193bd8ac 100644
--- a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
@@ -16,6 +16,7 @@ Required properties for the root node:
 		      "amlogic,meson-g12a-periphs-pinctrl"
 		      "amlogic,meson-g12a-aobus-pinctrl"
 		      "amlogic,meson-a1-periphs-pinctrl"
+		      "amlogic,meson-s4-periphs-pinctrl"
  - reg: address and size of registers controlling irq functionality
 
 === GPIO sub-nodes ===
-- 
2.34.1

