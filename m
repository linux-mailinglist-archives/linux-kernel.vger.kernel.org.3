Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF48D47D40A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 15:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343636AbhLVO70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 09:59:26 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:46439 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241422AbhLVO7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 09:59:21 -0500
X-IronPort-AV: E=Sophos;i="5.88,226,1635174000"; 
   d="scan'208";a="104370103"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 22 Dec 2021 23:59:20 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3BC834004BC3;
        Wed, 22 Dec 2021 23:59:18 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Add description for power-source property
Date:   Wed, 22 Dec 2021 14:59:01 +0000
Message-Id: <20211222145901.23661-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description for "power-source" property mentioning the values in enum
are in millivolts.

Suggested-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
index b749c82edebd..2d59c341c28c 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
@@ -76,6 +76,7 @@ additionalProperties:
         output-impedance-ohms:
           enum: [ 33, 50, 66, 100 ]
         power-source:
+          description: IO voltage in millivolts.
           enum: [ 1800, 2500, 3300 ]
         slew-rate: true
         gpio-hog: true
-- 
2.17.1

