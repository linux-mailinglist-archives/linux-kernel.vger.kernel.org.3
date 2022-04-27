Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BEA51127F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348738AbiD0HdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347803AbiD0HdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:33:18 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8ADB9D;
        Wed, 27 Apr 2022 00:30:07 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23R7U1cn068554;
        Wed, 27 Apr 2022 02:30:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651044602;
        bh=ctZqnjEy8og+g/nXn0w0KwwMwf0cr4JceTFbwxw6c7A=;
        h=From:To:CC:Subject:Date;
        b=A0QLR30fkDxk/zCRzpBi17qYOOGd6CLTjh4odxHGh6XndHRX9GkN9JhtHGb/tbUiL
         aiePqR7jjlPaFf/m8W1U3xhHzZDw+znjNYj1+Mn9c0V3R2/J18UkyAhKFeCm6SEsNx
         Dw5/HtvABJRpUbzwGVPDXk/kV5uMGwZU/huBi2KY=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23R7U1tY104844
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Apr 2022 02:30:01 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 27
 Apr 2022 02:30:01 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 27 Apr 2022 02:30:01 -0500
Received: from ula0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23R7TujI090553;
        Wed, 27 Apr 2022 02:29:57 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v4 0/2] arm64: ti: k3-am62: Introduce DT nodes for basic peripherals
Date:   Wed, 27 Apr 2022 12:59:52 +0530
Message-ID: <20220427072954.8821-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for McSPI, OSPI, MMC, DMA and CPSW ethernet switch

v4:
Fix CPSW CPTS clock ID to right ref clk

v3:
Fix regulator node names as suggested by Krzysztof

v2:
Add aliases for ethernet
Collect Reviewed-by

v3: lore.kernel.org/r/20220424042757.309986-1-vigneshr@ti.com
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

