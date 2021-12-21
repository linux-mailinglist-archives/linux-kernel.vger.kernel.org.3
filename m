Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856BD47B8C8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 04:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbhLUDAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 22:00:25 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:31496 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhLUDAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 22:00:24 -0500
Received: from droid04.amlogic.com (10.18.11.246) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2176.14; Tue, 21 Dec 2021
 11:00:16 +0800
From:   Xianwei Zhao <xianwei.zhao@amlogic.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Vyacheslav Bocharov <adeep@lexina.in>,
        <kelvin.zhang@amlogic.com>, Xianwei Zhao <xianwei.zhao@amlogic.com>
Subject: [PATCH V3] dt-bindings: arm: amlogic: add S4 based AQ222 bindings
Date:   Tue, 21 Dec 2021 11:00:14 +0800
Message-ID: <20211221030014.434-1-xianwei.zhao@amlogic.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.18.11.246]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the new Amlogic S4 SoC family,
and add binds the compatible for the Amlogic S4 Based AQ222 board.

S4 is an application processor designed for hybrid OTT/IP Set To
Box(STB) and high-end media box applications, with quad core Cortex-A35.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
V2 -> V3 : upate author name
V1 -> V2 : modfiy soc name S805X2
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 36081734f720..31df120d73b0 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -183,6 +183,12 @@ properties:
               - amlogic,ad401
           - const: amlogic,a1
 
+      - description: Boards with the Amlogic Meson S4 S805X2 SoC
+        items:
+          - enum:
+              - amlogic,aq222
+          - const: amlogic,s4
+
 additionalProperties: true
 
 ...

base-commit: a3ebdcc8fb3d94de390e58ad3da6161826a58a87
-- 
2.30.2

