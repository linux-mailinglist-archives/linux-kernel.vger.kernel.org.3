Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8794898BA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 13:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245576AbiAJMij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 07:38:39 -0500
Received: from comms.puri.sm ([159.203.221.185]:56898 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245525AbiAJMii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 07:38:38 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 067A4DF9CF;
        Mon, 10 Jan 2022 04:38:38 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IvInQhuLqy45; Mon, 10 Jan 2022 04:38:37 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     mchehab@kernel.org, robh@kernel.org,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        geert@linux-m68k.org
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v1 1/2] dt-binding: media: hynix,hi846: use $defs/port-base port description
Date:   Mon, 10 Jan 2022 13:38:03 +0100
Message-Id: <20220110123804.377944-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is supposed to fix "make dt_binding_check":

    Documentation/devicetree/bindings/media/i2c/hynix,hi846.example.dt.yaml:
camera@20: port:endpoint: Unevaluated properties are not allowed
('link-frequencies', 'data-lanes' were unexpected)
    From schema: Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml

Fixes: f3ce7200ca18 ("media: dt-bindings: media: document SK Hynix Hi-846 MIPI CSI-2 8M pixel sensor")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---

Link:
https://lore.kernel.org/linux-media/CAL_JsqKzaZC0A4OwnMyAuEWm2pCcHyQxHyrBVtkiPNUeMDd+oA@mail.gmail.com/



 Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml b/Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml
index 85a8877c2f38..e61255cf3fb9 100644
--- a/Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml
@@ -49,7 +49,7 @@ properties:
     description: Definition of the regulator used for the VDDD power supply.
 
   port:
-    $ref: /schemas/graph.yaml#/properties/port
+    $ref: /schemas/graph.yaml#/$defs/port-base
 
     properties:
       endpoint:
-- 
2.30.2

