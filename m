Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E225A6738
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 17:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiH3PWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 11:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiH3PV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 11:21:56 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB40B7EFE;
        Tue, 30 Aug 2022 08:21:54 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27UFLcs1054555;
        Tue, 30 Aug 2022 10:21:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1661872898;
        bh=g7Q8aqW9afFjMHMjY1T11nciRO0hWKdM3FcRNCvcGVU=;
        h=From:To:CC:Subject:Date;
        b=stCDzRhfc0FthWphQNmVyLYnFUKNBAGLxAXmBxxXEBdFQ/YYOHg2udPy2A0grBh13
         aTSVOWKvoNldZ/F5kx1hXhENPXXmxojIc/gjlwOfRll7MgB2i/jA0AS+VwW7O7AJn6
         u5iPLk92CHZF/u6MT1ndg40QQ+rSfAeodh8rX9EY=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27UFLcn2017997
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Aug 2022 10:21:38 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 30
 Aug 2022 10:21:37 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 30 Aug 2022 10:21:37 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27UFLb8a022740;
        Tue, 30 Aug 2022 10:21:37 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/4] arm64: dts: ti: *: Define aliases in board file
Date:   Tue, 30 Aug 2022 10:21:28 -0500
Message-ID: <20220830152132.23916-1-nm@ti.com>
X-Mailer: git-send-email 2.31.1
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

This series moves the aliases definitions in various TI SoC dts files
from SoC level to the board level.

Verification done:
a) build dtbs without the patches, regenerate dts using dtc -s -I dtb
b) build dtbs with the patches, regenerate the dts using dtc -s -I dtb
c) compare the regenerated dts file between a and b and ensure 0 delta

Nishanth Menon (4):
  arm64: dts: ti: am65*: Define aliases in board files
  arm64: dts: ti: j721e*: Define aliases in board files
  arm64: dts: ti: j7200*: Define aliases in board files
  arm64: dts: ti: am64*: Define aliases in board files

 arch/arm64/boot/dts/ti/k3-am64.dtsi           | 16 ----------------
 arch/arm64/boot/dts/ti/k3-am642-evm.dts       | 16 ++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am642-sk.dts        | 16 ++++++++++++++++
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 12 ++++++++++++
 arch/arm64/boot/dts/ti/k3-am65.dtsi           | 17 -----------------
 .../arm64/boot/dts/ti/k3-am654-base-board.dts | 17 +++++++++++++++++
 .../dts/ti/k3-j7200-common-proc-board.dts     | 17 +++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j7200.dtsi          | 17 -----------------
 .../dts/ti/k3-j721e-common-proc-board.dts     | 19 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts        | 19 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e.dtsi          | 19 -------------------
 11 files changed, 116 insertions(+), 69 deletions(-)

-- 
2.31.1

