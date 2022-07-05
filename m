Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BD5566E09
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 14:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239179AbiGEMaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 08:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236011AbiGEMP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 08:15:59 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173E41B7BA;
        Tue,  5 Jul 2022 05:11:55 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 265CBQ0b048797;
        Tue, 5 Jul 2022 07:11:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1657023086;
        bh=DdKYIDUtMAM+MphRAs2vZgvWfyg6OQsVaA35wJnU7CU=;
        h=From:To:CC:Subject:Date;
        b=XTlnfN4jbsti3M/WIragQoOnZnptrOtpqacEqE39LJQ7DH2J1hXoKD9MrsoloCDD9
         bT1U+KZ0v1/TrsiLj16fW8gLexRuzZBYuzHIgwRwjgZLWO8VIP6IHe4atMTM10i6nZ
         W37+ILCB7/1LKfNDWaahWzBpWtO/Tj/Ab9P2pZv0=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 265CBQZx017026
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Jul 2022 07:11:26 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 5
 Jul 2022 07:11:26 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 5 Jul 2022 07:11:26 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 265CBOqx023307;
        Tue, 5 Jul 2022 07:11:25 -0500
From:   Rahul T R <r-ravikumar@ti.com>
To:     <dri-devel@lists.freedesktop.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <andrzej.hajda@intel.com>, <narmstrong@baylibre.com>,
        <robert.foss@linaro.org>, <jonas@kwiboo.se>,
        <jernej.skrabec@gmail.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <p.zabel@pengutronix.de>, <tomi.valkeinen@ideasonboard.com>,
        <laurent.pinchart@ideasonboard.com>,
        <linux-kernel@vger.kernel.org>, <jpawar@cadence.com>,
        <sjakhade@cadence.com>, <mparab@cadence.com>, <a-bhatia1@ti.com>,
        <devicetree@vger.kernel.org>, <vigneshr@ti.com>,
        <lee.jones@linaro.org>, Rahul T R <r-ravikumar@ti.com>
Subject: [PATCH v4 0/5] Add support for CDNS DSI J721E wrapper
Date:   Tue, 5 Jul 2022 17:41:11 +0530
Message-ID: <20220705121116.24121-1-r-ravikumar@ti.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following series of patches adds supports for CDNS DSI
bridge on j721e.

v4:
 - split conversion txt to yaml
 - seperate commit for addinig new compatible
 - conditionally limit the items for reg property, based on the compatible

v3:
 - Convert cdns-dsi.txt binding to yaml
 - Move the bridge under display/bridge/cadence
 - Add new compatible to enable the wrapper module

v2:
 - Moved setting DPI0 to bridge_enable, since it
   should be done after pm_runtime_get

Rahul T R (5):
  dt-bindings: display: bridge: Convert cdns,dsi.txt to yaml
  dt-bindings: display: bridge: cdns,dsi: Add compatible for dsi on
    j721e
  drm/bridge: cdns-dsi: Move to drm/bridge/cadence
  drm/bridge: cdns-dsi: Create a header file
  drm/bridge: cdns-dsi: Add support for J721E wrapper

 .../bindings/display/bridge/cdns,dsi.txt      | 112 ----
 .../bindings/display/bridge/cdns,dsi.yaml     | 218 ++++++++
 drivers/gpu/drm/bridge/Kconfig                |  11 -
 drivers/gpu/drm/bridge/Makefile               |   1 -
 drivers/gpu/drm/bridge/cadence/Kconfig        |  21 +
 drivers/gpu/drm/bridge/cadence/Makefile       |   3 +
 .../{cdns-dsi.c => cadence/cdns-dsi-core.c}   | 483 ++----------------
 .../gpu/drm/bridge/cadence/cdns-dsi-core.h    | 471 +++++++++++++++++
 .../gpu/drm/bridge/cadence/cdns-dsi-j721e.c   |  51 ++
 .../gpu/drm/bridge/cadence/cdns-dsi-j721e.h   |  18 +
 10 files changed, 819 insertions(+), 570 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,dsi.txt
 create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,dsi.yaml
 rename drivers/gpu/drm/bridge/{cdns-dsi.c => cadence/cdns-dsi-core.c} (65%)
 create mode 100644 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.h
 create mode 100644 drivers/gpu/drm/bridge/cadence/cdns-dsi-j721e.c
 create mode 100644 drivers/gpu/drm/bridge/cadence/cdns-dsi-j721e.h

-- 
2.36.1

