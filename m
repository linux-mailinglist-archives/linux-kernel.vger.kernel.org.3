Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA3A595523
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbiHPIZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbiHPIXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:23:30 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DABB140EB5;
        Mon, 15 Aug 2022 22:59:04 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27G5wsMh061765;
        Tue, 16 Aug 2022 00:58:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1660629534;
        bh=Qshoc3TozitcOBveB/ojj1zsYjU6ve0AOwT34babB/g=;
        h=From:To:CC:Subject:Date;
        b=XlbXD0tuVUoDOsMEGZbcgdl7+50QbsLgG7Bug8eJFP/Dilu/v+94LL4e3hrduYeDY
         1f1rvuMNhFKarl/LZy9JUEjpiLkLjyIPHmKSgZ7jj0RprqdDnSlXLo/BYpYQGMcrE2
         vmKEzzL2xOAvIFsNAE6dZig6NSN7osUxogAX6Oy4=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27G5wsu3014212
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Aug 2022 00:58:54 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 16
 Aug 2022 00:58:52 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 16 Aug 2022 00:58:52 -0500
Received: from uda0492258.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27G5wm3c109354;
        Tue, 16 Aug 2022 00:58:49 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <robh+dt@kernel.org>, <lee.jones@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <kishon@ti.com>,
        <vkoul@kernel.org>, <dan.carpenter@oracle.com>,
        <grygorii.strashko@ti.com>, <rogerq@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <s-vadapalli@ti.com>
Subject: [PATCH v2 0/2] Add support for QSGMII mode
Date:   Tue, 16 Aug 2022 11:28:46 +0530
Message-ID: <20220816055848.111482-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for J7200 CPSW5G.

Add support for QSGMII mode in phy-gmii-sel driver for CPSW5G in J7200.

Change log:

v1->v2:
1. Rename ti,enet-ctrl-qsgmii as ti,qsgmii-main-ports.
2. Change ti,qsgmii-main-ports property from bitmask to integer.
3.Update commit message with property name as ti,qsgmii-main-ports.

v1: https://lore.kernel.org/r/20220531111221.22963-1-s-vadapalli@ti.com/

Siddharth Vadapalli (2):
  dt-bindings: phy: ti: phy-gmii-sel: Add bindings for J7200
  phy: ti: gmii-sel: Add support for CPSW5G GMII SEL in J7200

 .../mfd/ti,j721e-system-controller.yaml       |  5 +++
 .../bindings/phy/ti,phy-gmii-sel.yaml         | 27 ++++++++++++-
 drivers/phy/ti/phy-gmii-sel.c                 | 40 +++++++++++++++++--
 3 files changed, 68 insertions(+), 4 deletions(-)

--
2.25.1

