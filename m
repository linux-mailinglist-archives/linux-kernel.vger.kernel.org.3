Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2FC153C3FF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 07:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240023AbiFCFLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 01:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbiFCFLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 01:11:04 -0400
X-Greylist: delayed 83 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Jun 2022 22:11:03 PDT
Received: from jax4mhob04.registeredsite.com (jax4mhob04.myregisteredsite.com [64.69.218.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9063204F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 22:11:03 -0700 (PDT)
Received: from mailpod.hostingplatform.com ([10.30.71.206])
        by jax4mhob04.registeredsite.com (8.14.4/8.14.4) with ESMTP id 2535B10v026203
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Fri, 3 Jun 2022 01:11:01 -0400
Received: (qmail 31756 invoked by uid 0); 3 Jun 2022 05:11:00 -0000
X-TCPREMOTEIP: 204.168.181.193
X-Authenticated-UID: mike@milosoftware.com
Received: from unknown (HELO phenom.domain?not?set.invalid) (mike@milosoftware.com@204.168.181.193)
  by 0 with ESMTPA; 3 Jun 2022 05:11:00 -0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     devicetree@vger.kernel.org, linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        geert+renesas@glider.be, martink@posteo.de, hechtb@gmail.com,
        Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH v2 2/2] dt-bindings: Input: st1232 - Support power supply regulators
Date:   Fri,  3 Jun 2022 07:10:58 +0200
Message-Id: <20220603051058.6075-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_FAIL,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the VDD and IOVDD power supply inputs. This allows the
chip to share its supplies with other components (e.g. panel) and manage
them.

This provides the devicetree bindings.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
v2: Split devicetree and code parts

 .../bindings/input/touchscreen/sitronix,st1232.yaml         | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml b/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
index 1d8ca19fd37a..240be8d49232 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
@@ -28,6 +28,12 @@ properties:
     description: A phandle to the reset GPIO
     maxItems: 1
 
+  vdd-supply:
+    description: Power supply regulator for the chip
+
+  vddio-supply:
+    description: Power supply regulator for the I2C bus
+
 required:
   - compatible
   - reg
-- 
2.17.1

