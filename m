Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F4A466452
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 14:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358247AbhLBNOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 08:14:04 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59292 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358206AbhLBNNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 08:13:51 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B2DADRF011629;
        Thu, 2 Dec 2021 07:10:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638450613;
        bh=dn8l7Os6Ucq45HCQxIDhH9KClfTJiZ3Yf7GgLyFAQRo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=FpwsjjE6U9wTE2g4y/MnISur//9jPLi2xTM5dQ7pDgqHM7cGzWZYM12uoah+ack6T
         1w37dLeEsuRzUiM9hAC3564Xuc8F8lacvR6K4rqmzH0dkDPquzSQnw5f3lS1lpBREg
         8/jAQk0cXO4R51AoL6CdwQIoM1f9oZZvSGjwowOc=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B2DADDO119556
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 2 Dec 2021 07:10:13 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 2
 Dec 2021 07:10:12 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 2 Dec 2021 07:10:12 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B2DA4Kj031324;
        Thu, 2 Dec 2021 07:10:09 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Aswath Govindraju <a-govindraju@ti.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <linux-can@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: phy: ti,tcan104x-can: Document mux-states property
Date:   Thu, 2 Dec 2021 18:40:01 +0530
Message-ID: <20211202131002.12217-2-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211202131002.12217-1-a-govindraju@ti.com>
References: <20211202131002.12217-1-a-govindraju@ti.com>
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
 .../devicetree/bindings/phy/ti,tcan104x-can.yaml    | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
index 6107880e5246..5b2b08016635 100644
--- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
@@ -37,6 +37,18 @@ properties:
       max bit rate supported in bps
     minimum: 1
 
+  mux-states:
+    description:
+      mux controller node to route the signals from controller to
+      transceiver. Depending on the mux chip and the control lines
+      in it, the first and second parameters can be used for
+      representing control line and state. The number of arguments
+      is to be used based on '#mux-state-cells' property in the
+      mux-controller node. If '#mux-state-cells' is equal to
+      one then, then the argument to be used would be the state.
+      If it is set to two, then the first argument is the control
+      line and the second argument would be its corresponding state.
+
 required:
   - compatible
   - '#phy-cells'
@@ -53,4 +65,5 @@ examples:
       max-bitrate = <5000000>;
       standby-gpios = <&wakeup_gpio1 16 GPIO_ACTIVE_LOW>;
       enable-gpios = <&main_gpio1 67 GPIO_ACTIVE_HIGH>;
+      mux-states = <&mux0 1>;
     };
-- 
2.17.1

