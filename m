Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBD25709ED
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 20:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiGKSaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 14:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGKSaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 14:30:06 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668074B0DE;
        Mon, 11 Jul 2022 11:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657564201; x=1689100201;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OFO7jHLbQ9m7KwxEYyqk1uyQ5ZITDYztcNklMs1vRcY=;
  b=oK3PgUWy6mZXM08FH6divRNMdoJwlLjjh05t90mCAN2vrUeDMJtDE8NW
   E435o3N9utIMcxtftbrZ63HgKLFlQBaN3B9epK+NmEvcOG3VGAHVfrrbJ
   ze6sXML8KvHpjal/Qtu1bpAFLBV1SU/ffsl7gafDK4DNRhVcv1BqLK23l
   Wwual5l2lo9HqTvRz+Rpq2dDFvyFMQeUEOvBQAriECtPhZa2/T8No+VYV
   NMmefCPCPYHvV9KDsj1vkVTkCfUA0oTd9+TcMgllgN1DjDZcGliUX9OMS
   Y1X3DUScS8uY2HzcnYEwuPepadNO5CitESSjgJ7SezylMYa9pCNR2E8Jk
   w==;
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="103970015"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jul 2022 11:30:00 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 11 Jul 2022 11:30:00 -0700
Received: from ryan-Precision-5560.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 11 Jul 2022 11:30:00 -0700
From:   <Ryan.Wanner@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Ryan Wanner" <Ryan.Wanner@microchip.com>
Subject: [PATCH v2 0/2] dt-bindings: sound: Convert to json-schema
Date:   Mon, 11 Jul 2022 11:30:08 -0700
Message-ID: <20220711183010.39123-1-Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
- Fix titles in yaml file
- Removed trivial descriptions
- Correct formatting errors 

Ryan Wanner (2):
  dt-bindings: sound: atmel,classd: Convert to json-schema
  dt-binding: sound: atmel,pdmic: Convert to json-schema

 .../bindings/sound/atmel,sama5d2-classd.yaml  | 104 ++++++++++++++++++
 .../bindings/sound/atmel,sama5d2-pdmic.yaml   |  98 +++++++++++++++++
 .../bindings/sound/atmel-classd.txt           |  55 ---------
 .../devicetree/bindings/sound/atmel-pdmic.txt |  55 ---------
 4 files changed, 202 insertions(+), 110 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/atmel,sama5d2-classd.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/atmel,sama5d2-pdmic.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/atmel-classd.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/atmel-pdmic.txt

-- 
2.34.1

