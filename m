Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE82495F9D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 14:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380645AbiAUNRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 08:17:00 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:4335 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350614AbiAUNQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 08:16:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1642771018; x=1674307018;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y5Bo8zO0XRgXx3SUIMfyqyqo4U4fHoA3DKGKQqVbUqQ=;
  b=b7066gB4ljiVaeWTc09vFXCiEdCOcmuc5e9szsCxikwt38ystEdwlSgk
   GsA9Lt9OmdvuJDiucmUnPx5x7A9JMhroSSh5LxKw+i/I+PoGdjMcNodZ7
   MGhUF1jqOTDlhymN4jvlECer+7FTzyOVrln2QowVV6PxQaE7kC8j/Jfn4
   pXzarx/burT/OXb6zvPhhsYLqo/PaVtJBHfNPTpZUrC3kFOlPs614rSxm
   EHq2qmzg2JpLUBx0GajazVhB7SW8FHY9vYWYk0hsKouWHU1tjYGdcw8Nm
   qNLW3MJ7hZA8nLeWmpMEdcX4zhCV2nR41r8aQNShw5sgXlAFNAT9AKpHR
   w==;
IronPort-SDR: f1J8MfPvBIaEZbjnKBCPN/HxsBnski6s2hHkXkQSaWq6r4GOQNdfRudwn9xsXCwRduu6dKJ4ad
 lYnsJQPhjXGMEsmbnmcFnpfow+/JpRBNhHeqE/edfMBsv9LwL3ROO718TrClNK6/3dRS9gBnuA
 aU9zr+XMojRmos0VBfTlVXEUK2pp6J+WnpWpZ3t3L6CyYxZZpc+eLkoxXFtiRKaDqgl4hfZkhY
 aArPQkhUa7WyPO1F/783UB4RPKKpBl6bHdmtFJI5I5c4XGDjTTkfOQE9ZH6rGcDAjZS4+L2T3h
 6FxLyhLncT7tvWpylYY+Iepq
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="143468728"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jan 2022 06:16:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 21 Jan 2022 06:16:57 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 21 Jan 2022 06:16:39 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <robh+dt@kernel.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <jacopo+renesas@jmondi.org>, <hverkuil-cisco@xs4all.nl>
CC:     <nicolas.ferre@microchip.com>, <sakari.ailus@iki.fi>,
        <laurent.pinchart@ideasonboard.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v4 08/11] dt-bindings: media: microchip,xisc: add bus-width of 14
Date:   Fri, 21 Jan 2022 15:14:13 +0200
Message-ID: <20220121131416.603972-9-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220121131416.603972-1-eugen.hristev@microchip.com>
References: <20220121131416.603972-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Microchip XISC supports a bus width of 14 bits.
Add it to the supported bus widths.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 Documentation/devicetree/bindings/media/microchip,xisc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/microchip,xisc.yaml b/Documentation/devicetree/bindings/media/microchip,xisc.yaml
index 086e1430af4f..3be8f64c3e21 100644
--- a/Documentation/devicetree/bindings/media/microchip,xisc.yaml
+++ b/Documentation/devicetree/bindings/media/microchip,xisc.yaml
@@ -67,7 +67,7 @@ properties:
           remote-endpoint: true
 
           bus-width:
-            enum: [8, 9, 10, 11, 12]
+            enum: [8, 9, 10, 11, 12, 14]
             default: 12
 
           hsync-active:
-- 
2.25.1

