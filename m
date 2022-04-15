Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F096502ADC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 15:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353596AbiDONWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 09:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241910AbiDONWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 09:22:03 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2047B13F2C;
        Fri, 15 Apr 2022 06:19:34 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23FDJMFj087908;
        Fri, 15 Apr 2022 08:19:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650028762;
        bh=o0uc7gs6VS4waSoLVDupuVU4vfBt5ZmnYZx8J6ojtC4=;
        h=From:To:CC:Subject:Date;
        b=iIj5Kh7wDlip2U5wUPISW4+kysh44xHUbWeVPx1owNyzCbHj6P9jbnp+P+xwbk0XN
         mA5XKhohGwPGUxZux68L0UHVEqiKg7dEfXpcBKu3IKZ4EVH/WWF3HjWx+ytHjym5t+
         T/KLluNkDoesiIB9RqTXv/SSdav6ALdYRTqP3aE0=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23FDJMAu011876
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Apr 2022 08:19:22 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 15
 Apr 2022 08:19:22 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 15 Apr 2022 08:19:22 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23FDJIk8104572;
        Fri, 15 Apr 2022 08:19:19 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 0/2] arm64: ti: k3-am62: Introduce DT nodes for basic peripherals
Date:   Fri, 15 Apr 2022 18:49:15 +0530
Message-ID: <20220415131917.431137-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.35.3
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

Add nodes for McSPI, OSPI, MMC, DMA and CPSW eth switch

Bootlog:https://gist.github.com/r-vignesh/b2fb23da7c589394f56ce08fd00a155b

Vignesh Raghavendra (2):
  arm64: dts: ti: k3-am62: Add more peripheral nodes
  arm64: dts: ti: k3-am625-sk: Enable on board peripherals

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 266 ++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi  |  20 ++
 arch/arm64/boot/dts/ti/k3-am625-sk.dts   | 271 +++++++++++++++++++++++
 3 files changed, 557 insertions(+)

-- 
2.35.3

