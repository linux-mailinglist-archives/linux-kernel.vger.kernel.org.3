Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159CC46488D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347591AbhLAHdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:33:52 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:24279 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347500AbhLAHd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:33:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1638343806; x=1669879806;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1EQFOYg+B1vlIp6YrErw/vXZFes/XLsFfDXVJmbSAwQ=;
  b=WqYEua/Kgqa9KkxZEON6+6pVvSkq+8LNE6Zm5h8RasSoNHEp+P6b32Pd
   m9KMYRCrZPb6WUqOARm67DTMpDI5T3+EY5CnXaJVxx4jWnTDfTY3tpQiC
   hzDkdS1vDX8NVSBFTrhSbYph60uaVlC9vrFvDVW9KyvkWVovbEs1+ir9x
   huqjQ9Iwx9TdNodeLQkV70zKmB5ElPuEEfpdq6Yq+FJZCsxvO/zl5S169
   Fs5cwJSSCSpX3fgVZFH9OCOWs6xc6CX6BLYm74hRTZpbCyJG/7SK/vs48
   q5RcF2Iyvfy7kCGkz3TZIAK4qhCAubQygWZZybeHKGQUY82/CPQR9DAI8
   w==;
X-IronPort-AV: E=Sophos;i="5.87,278,1631570400"; 
   d="scan'208";a="20773225"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 01 Dec 2021 08:30:03 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 01 Dec 2021 08:30:03 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 01 Dec 2021 08:30:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1638343803; x=1669879803;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1EQFOYg+B1vlIp6YrErw/vXZFes/XLsFfDXVJmbSAwQ=;
  b=HzMfmn/LGO5qUqTylcR+4C5pZjYPcTkoTyXyLEWWhqMXV4SjI9QsYfvF
   7FcN3ji1d2vP7SQvs/vRl8wj0ijsQYfPOBWRh9fxzPUzCZ+qZZ/GT+hIg
   tjOCPGONBQVusVHmXvg9BwJ246SdLPXT76CjUigbE2mhF2xE5i3QYQ0vL
   KCvuc6DbiMSI/Iejm7CQ3w7BWxz9KEwi+H8ZEj4zunWR3NEzAQbNw5uO1
   tpzSp8vmNCN7lvuo/be9rL9ljayDDsPOp7TvtYaANUfqN4RBOzCZovBjv
   AVV8DSELg/vPxDTTiDIgFFfqsmwhXXLnQCpWUhCPe517cPD0OWJrkmFLM
   A==;
X-IronPort-AV: E=Sophos;i="5.87,278,1631570400"; 
   d="scan'208";a="20773224"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 01 Dec 2021 08:30:03 +0100
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id DD92B280075;
        Wed,  1 Dec 2021 08:30:02 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/7] dt-bindings: arm: fsl: add TQMa8MxML boards
Date:   Wed,  1 Dec 2021 08:29:42 +0100
Message-Id: <20211201072949.53947-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201072949.53947-1-alexander.stein@ew.tq-group.com>
References: <20211201072949.53947-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TQMa8MxML is a SOM family using NXP i.MX8MM[Q,QL,DL,S,SL] CPU
MBa8Mx is an evaluation mainbord for this SOM

The SOM needs a mainboard, therefore we provide two compatibles here:

"tq,imx8mm-<SOM>" for the module and
"tq,imx8mm-<SOM>-<SBC>" for the module on that mainboard

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes in v3:
* None

 Documentation/devicetree/bindings/arm/fsl.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 0b595b26061f..abcf559e311e 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -754,6 +754,17 @@ properties:
           - const: variscite,var-som-mx8mm
           - const: fsl,imx8mm
 
+      - description:
+          TQMa8MxML is a series of SOM featuring NXP i.MX8MM system-on-chip
+          variants. It is designed to be soldered on different carrier boards.
+          All variants (TQMa8M[Q,D,S][L]ML) use the same device tree, hence only
+          one compatible is needed.
+        items:
+          - enum:
+              - tq,imx8mm-tqma8mqml-mba8mx # TQ-Systems GmbH i.MX8MM TQMa8MQML SOM on MBa8Mx
+          - const: tq,imx8mm-tqma8mqml     # TQ-Systems GmbH i.MX8MM TQMa8MQML SOM
+          - const: fsl,imx8mm
+
       - description: i.MX8MN based Boards
         items:
           - enum:
-- 
2.25.1

