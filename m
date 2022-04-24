Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBB550CF5A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 06:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238152AbiDXEbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 00:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235553AbiDXEba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 00:31:30 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296DCDF3;
        Sat, 23 Apr 2022 21:28:28 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23O4SA88107176;
        Sat, 23 Apr 2022 23:28:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650774490;
        bh=D04NFhv22/v6yRIdE4I2Z3P2Ja3MaXCtiEB3NsN9G+s=;
        h=From:To:CC:Subject:Date;
        b=LaBlHkLO/OjORYKbUZ1+puw/+BYFt/6h5YpIvUCBBBy9OuT4JGB5Qzd3GujAtUw/C
         FlnCP1I6lj7MBgzkrq1LwiJO0f+2pvFaUikVpk14rzfZQFrjV2UomnvwhnNhFY9Mez
         TwROFTbPvXSIMDuDaU1CHHOwpacr/xHUUWjlyKlA=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23O4SAB9002674
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 23 Apr 2022 23:28:10 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sat, 23
 Apr 2022 23:28:10 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sat, 23 Apr 2022 23:28:10 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23O4S5Cj018740;
        Sat, 23 Apr 2022 23:28:06 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v3 0/2] arm64: ti: k3-am62: Introduce DT nodes for basic peripherals
Date:   Sun, 24 Apr 2022 09:57:55 +0530
Message-ID: <20220424042757.309986-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for McSPI, OSPI, MMC, DMA and CPSW ethernet switch

v3:
Fix regulator node names as suggested by Krzysztof

v2:
Add aliases for ethernet
Collect Reviewed-by

v2: lore.kernel.org/r/20220422065002.387753-1-vigneshr@ti.com
v1: lore.kernel.org/r/20220415131917.431137-1-vigneshr@ti.com

Vignesh Raghavendra (2):
  arm64: dts: ti: k3-am62: Add more peripheral nodes
  arm64: dts: ti: k3-am625-sk: Enable on board peripherals

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 266 ++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi  |  20 ++
 arch/arm64/boot/dts/ti/k3-am625-sk.dts   | 273 +++++++++++++++++++++++
 3 files changed, 559 insertions(+)

-- 
2.36.0

