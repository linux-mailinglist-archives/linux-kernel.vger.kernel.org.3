Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00E64768FF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 05:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbhLPEKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 23:10:36 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45016 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbhLPEKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 23:10:35 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BG4AOlL097987;
        Wed, 15 Dec 2021 22:10:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1639627824;
        bh=y++VsA+9A8bXEp/r65lqltyup+1E6rXbXO+u5m0KoDg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=oxaKTGfXf3EFoQgDkFCrOozfxcdd95mjIJvURCazwcbt4oRnqaCiRv1b5/KFCgPNB
         jiDBPixwRTvrwK7g/3N9193CV091VyTHVd8c2jMjkJ7FFeC2KIp9ti+kln3rABfDrz
         I2zPRzaFr7fUyeoUEBpxB2rLwxbPV7V3Y/luzHo8=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BG4AOJO121576
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Dec 2021 22:10:24 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 15
 Dec 2021 22:10:24 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 15 Dec 2021 22:10:24 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BG4AEOK093350;
        Wed, 15 Dec 2021 22:10:20 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Aswath Govindraju <a-govindraju@ti.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <linux-can@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: phy: ti,tcan104x-can: Document mux-states property
Date:   Thu, 16 Dec 2021 09:40:11 +0530
Message-ID: <20211216041012.16892-2-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211216041012.16892-1-a-govindraju@ti.com>
References: <20211216041012.16892-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some boards, for routing CAN signals from controller to transceivers,
muxes might need to be set. This can be implemented using mux-states
property. Therefore, document the same in the respective bindings.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
index 6107880e5246..02b76f15e717 100644
--- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
@@ -37,6 +37,12 @@ properties:
       max bit rate supported in bps
     minimum: 1
 
+  mux-states:
+    description:
+      mux controller node to route the signals from controller to
+      transceiver.
+    maxItems: 1
+
 required:
   - compatible
   - '#phy-cells'
@@ -53,4 +59,5 @@ examples:
       max-bitrate = <5000000>;
       standby-gpios = <&wakeup_gpio1 16 GPIO_ACTIVE_LOW>;
       enable-gpios = <&main_gpio1 67 GPIO_ACTIVE_HIGH>;
+      mux-states = <&mux0 1>;
     };
-- 
2.17.1

