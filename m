Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADC848AE9B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 14:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240661AbiAKNk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 08:40:56 -0500
Received: from comms.puri.sm ([159.203.221.185]:42602 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239487AbiAKNkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 08:40:55 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 09809DFBD8;
        Tue, 11 Jan 2022 05:40:25 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id i79aX3YNLV4t; Tue, 11 Jan 2022 05:40:24 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org,
        robh@kernel.org, sakari.ailus@linux.intel.com, geert@linux-m68k.org
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v2 2/2] dt-bindings: media: hynix,hi846: add link-frequencies description
Date:   Tue, 11 Jan 2022 14:39:37 +0100
Message-Id: <20220111133937.1099917-2-martin.kepplinger@puri.sm>
In-Reply-To: <20220111133937.1099917-1-martin.kepplinger@puri.sm>
References: <20220111133937.1099917-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

link-frequencies is required but only mentioned in the example. Add
it to the description.

Fixes: f3ce7200ca18 ("media: dt-bindings: media: document SK Hynix Hi-846 MIPI CSI-2 8M pixel sensor")
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml b/Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml
index 5d0fc18a2ea2..1e2df8cf2937 100644
--- a/Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml
@@ -69,8 +69,11 @@ properties:
                   - const: 1
                   - const: 2
 
+          link-frequencies: true
+
         required:
           - data-lanes
+          - link-frequencies
 
 required:
   - compatible
-- 
2.30.2

