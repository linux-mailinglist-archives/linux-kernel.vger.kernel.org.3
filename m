Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1888C576549
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 18:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbiGOQ3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 12:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiGOQ3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 12:29:20 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F4B101D1;
        Fri, 15 Jul 2022 09:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657902557; x=1689438557;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XLDoisr6NFA1lVrLrqatV82skwaxioW4MC9gQRXY5I8=;
  b=LnJOOiZ3Sw/yoQ1KSy7h3/ARC7Zfmu3rrwVSMyFPLPXaFi30hVEK0yEH
   D6EdgQZGrCFylMzz2NXqv79Gqb9FTzuo9cD+IDNTONj1oNSOEJRENluae
   O5HMekGcEn6kGBu2+AK/C+C+mwjgzK5A35iajYnd5gtebWd6mPUFUYGTJ
   4yJ/JnXnklQbnmEm1Fg7L7ZueW97xQnI0puMFpk36IQXRVMp/Jr5de1yd
   nPW0ORAfi+Hk4oRJCRASDALyFZAiqfyIRKtS0Z3+pW68SC5SnNSyXwFbC
   9nSoq/ABnnBN4N50KTDhqRZpQZRlA6yOOkP7Dm2d/d4CRaGOvi540UjXk
   g==;
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="172317074"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jul 2022 09:29:15 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 15 Jul 2022 09:29:13 -0700
Received: from ryan-Precision-5560.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 15 Jul 2022 09:29:13 -0700
From:   <Ryan.Wanner@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Ryan Wanner" <Ryan.Wanner@microchip.com>
Subject: [PATCH v3 0/2] ASoC: dt-bindings: atmel-classd: Convert to
Date:   Fri, 15 Jul 2022 09:29:20 -0700
Message-ID: <20220715162922.660859-1-Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Wanner <Ryan.Wanner@microchip.com>

This patch series converts atmel-classd and atmel-pdmic device tree
bindings to json-schema.

v1 -> v2:
- Fix commit formatting.
- Fix titles in yaml file.
- Removed trivial descriptions.
- Correct formatting errors.

v2 -> v3:
- Fix subsystem prefix.
- Fix word wrap formatting.
- Removed assigned-clocks parameter.
- Correct descriptions in inconsistent locations.
- Remove duplicated description.
- Correct formatting for dts example.

Ryan Wanner (2):
  ASoC: dt-bindings: atmel-classd: Convert to json-schema
  ASoC: dt-bindings: atmel-classd: PDMIC convert to json-schema

 .../bindings/sound/atmel,sama5d2-classd.yaml  | 100 ++++++++++++++++++
 .../bindings/sound/atmel,sama5d2-pdmic.yaml   |  98 +++++++++++++++++
 .../bindings/sound/atmel-classd.txt           |  55 ----------
 .../devicetree/bindings/sound/atmel-pdmic.txt |  55 ----------
 4 files changed, 198 insertions(+), 110 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/atmel,sama5d2-classd.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/atmel,sama5d2-pdmic.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/atmel-classd.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/atmel-pdmic.txt

-- 
2.34.1

