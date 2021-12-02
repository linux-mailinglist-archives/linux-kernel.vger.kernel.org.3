Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4414663DB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 13:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357990AbhLBMov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 07:44:51 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47188 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357546AbhLBMok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:44:40 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B2Cf268017880;
        Thu, 2 Dec 2021 06:41:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638448862;
        bh=GDG2n+d5av4/wgQR3d2CdIyMKZrAGgh2Pzft8g/+j6U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hNV3Ed4QbNdVbOjbBQiimVpomQpQj89OAkRmQZc30HIrouGIkfCAfHQmlXzNTy7Rh
         d0VM9A1Umel/Wd06yj+IZ/7EHhVwyxDkIDobQU6/7sC1MDB8hWvzigkX2RNlGR5NVi
         lEgk0ToRyX0cSIUdqHc3WnKv9ib65/xOKtud75CU=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B2Cf2Rs081178
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 2 Dec 2021 06:41:02 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 2
 Dec 2021 06:41:02 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 2 Dec 2021 06:41:01 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B2CesQD051666;
        Thu, 2 Dec 2021 06:40:58 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>
Subject: [PATCH v2 1/2] dt-bindings: mux: Document mux-states property
Date:   Thu, 2 Dec 2021 18:10:52 +0530
Message-ID: <20211202124053.2835-2-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211202124053.2835-1-a-govindraju@ti.com>
References: <20211202124053.2835-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases, it is required to provide the state to which the mux
controller has to be set to, from the consumer device tree node. Document
the property mux-states that can be used for adding this support.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---

Note:
- on running dt_binding_check with "DT_CHECKER_FLAGS=-m" the following
  error was seen,

 LINT    Documentation/devicetree/bindings
  CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.json
  DTC     Documentation/devicetree/bindings/mux/mux-controller.example.dt.yaml
  CHECK   Documentation/devicetree/bindings/mux/mux-controller.example.dt.yaml
/home/gsaswath/presil/ks3-linux-integrated/linux/Documentation/devicetree/bindings/
mux/mux-controller.example.dt.yaml: can-phy4: 'mux-states' does not match any of 
the regexes: 'pinctrl-[0-9]+'
	From schema: /home/gsaswath/presil/ks3-linux-integrated/linux/
Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml

"mux-states" is a new property that is being added and the patch adding this
property to TCAN104x can transceiver bindings will be sent as a follow up
of this series.

 .../devicetree/bindings/mux/gpio-mux.yaml     | 11 ++++++--
 .../devicetree/bindings/mux/mux-consumer.yaml | 21 +++++++++++++++
 .../bindings/mux/mux-controller.yaml          | 26 ++++++++++++++++++-
 3 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mux/gpio-mux.yaml b/Documentation/devicetree/bindings/mux/gpio-mux.yaml
index 0a7c8d64981a..ee4de9fbaf4d 100644
--- a/Documentation/devicetree/bindings/mux/gpio-mux.yaml
+++ b/Documentation/devicetree/bindings/mux/gpio-mux.yaml
@@ -26,7 +26,10 @@ properties:
       List of gpios used to control the multiplexer, least significant bit first.
 
   '#mux-control-cells':
-    const: 0
+    enum: [ 0, 1 ]
+
+  '#mux-state-cells':
+    enum: [ 1, 2 ]
 
   idle-state:
     default: -1
@@ -34,7 +37,11 @@ properties:
 required:
   - compatible
   - mux-gpios
-  - "#mux-control-cells"
+anyOf:
+  - required:
+      - "#mux-control-cells"
+  - required:
+      - "#mux-state-cells"
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/mux/mux-consumer.yaml b/Documentation/devicetree/bindings/mux/mux-consumer.yaml
index 7af93298ab5c..d3d854967359 100644
--- a/Documentation/devicetree/bindings/mux/mux-consumer.yaml
+++ b/Documentation/devicetree/bindings/mux/mux-consumer.yaml
@@ -25,6 +25,17 @@ description: |
   strings to label each of the mux controllers listed in the "mux-controls"
   property.
 
+  If it is required to provide the state that the mux controller needs to
+  be set to, the property "mux-states" must be used. An optional property
+  "mux-state-names" can be used to provide a list of strings, to label
+  each of the multiplixer states listed in the "mux-states" property.
+
+  Properties "mux-controls" and "mux-states" can be used depending on how
+  the consumers want to control the mux controller. If the consumer needs
+  needs to set multiple states in a mux controller, then property
+  "mux-controls" can be used. If the consumer needs to set the mux
+  controller to a given state then property "mux-states" can be used.
+
   mux-ctrl-specifier typically encodes the chip-relative mux controller number.
   If the mux controller chip only provides a single mux controller, the
   mux-ctrl-specifier can typically be left out.
@@ -35,12 +46,22 @@ properties:
   mux-controls:
     $ref: /schemas/types.yaml#/definitions/phandle-array
 
+  mux-states:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+
   mux-control-names:
     description:
       Devices that use more than a single mux controller can use the
       "mux-control-names" property to map the name of the requested mux
       controller to an index into the list given by the "mux-controls" property.
 
+  mux-state-names:
+    description:
+      Devices that use more than a single multiplexer state can use the
+      "mux-state-names" property to map the name of the requested mux
+      controller to an index into the list given by the "mux-states"
+      property.
+
 additionalProperties: true
 
 ...
diff --git a/Documentation/devicetree/bindings/mux/mux-controller.yaml b/Documentation/devicetree/bindings/mux/mux-controller.yaml
index 736a84c3b6a5..c855fbad3884 100644
--- a/Documentation/devicetree/bindings/mux/mux-controller.yaml
+++ b/Documentation/devicetree/bindings/mux/mux-controller.yaml
@@ -25,7 +25,9 @@ description: |
   --------------------
 
   Mux controller nodes must specify the number of cells used for the
-  specifier using the '#mux-control-cells' property.
+  specifier using the '#mux-control-cells' or '#mux-state-cells' property.
+  The value of '#mux-state-cells' will always be one greater than the value
+  of '#mux-control-cells'.
 
   Optionally, mux controller nodes can also specify the state the mux should
   have when it is idle. The idle-state property is used for this. If the
@@ -67,6 +69,8 @@ select:
           pattern: '^mux-controller'
     - required:
         - '#mux-control-cells'
+    - required:
+        - '#mux-state-cells'
 
 properties:
   $nodename:
@@ -75,6 +79,9 @@ properties:
   '#mux-control-cells':
     enum: [ 0, 1 ]
 
+  '#mux-state-cells':
+    enum: [ 1, 2 ]
+
   idle-state:
     $ref: /schemas/types.yaml#/definitions/int32
     minimum: -2
@@ -179,4 +186,21 @@ examples:
             };
         };
     };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    mux1: mux-controller {
+        compatible = "gpio-mux";
+        #mux-state-cells = <1>;
+        mux-gpios = <&exp_som 2 GPIO_ACTIVE_HIGH>;
+    };
+
+    transceiver4: can-phy4 {
+        compatible = "ti,tcan1042";
+        #phy-cells = <0>;
+        max-bitrate = <5000000>;
+        standby-gpios = <&exp_som 7 GPIO_ACTIVE_HIGH>;
+        mux-states = <&mux1 1>;
+    };
 ...
-- 
2.17.1

