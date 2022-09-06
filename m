Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1A95AE7FE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 14:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239974AbiIFMWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 08:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240091AbiIFMV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 08:21:28 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22747DF70;
        Tue,  6 Sep 2022 05:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662466689; x=1694002689;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9o+uaFTKPFTMVpXL13wKHYNkptAH38MQewyTU/ti7Mk=;
  b=hds4P4DMjcDpYvK9mOY6nO4lIlnzpJDnFO41x+7EQw0SXVbiHwEMd/mS
   TXPB8NeESQ0om8c9mBABaPlHRzmnIiTxLXIkbXmNRQGBIYZ9DImmibyUi
   mv7x7+5oYncaSVJtMS1xPUkZFaO8l95wrVoknXqEwhlTDWe2sFSSSAfDi
   4e3N4pumwG32U7p+KNuCZvXlH/0Jby0XOe/XY/1DNdt9lnUxhLZgWRIzP
   ygSvp5EFQewPk7Aqtpwzbn/uPS39oD3+yxhqBorstXwOHYP7mKFMZBEA8
   aeNEgMqDVp5x0PHn0J8jxTKsvduXCJIKKizmBpqKBqiQgZNXZXbQYxcrH
   g==;
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="179327795"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Sep 2022 05:16:08 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 6 Sep 2022 05:16:03 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Tue, 6 Sep 2022 05:16:01 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        "Daire McNamara" <daire.mcnamara@microchip.com>
CC:     <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/3] Add a devicetree for the Aldec PolarFire SoC TySoM
Date:   Tue, 6 Sep 2022 13:15:23 +0100
Message-ID: <20220906121525.3212705-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey All,

On top of my other series adding the m100pfsevp and sevkit [0], here's
yet another development kit.. This time from Aldec.

The board has 32 GB of DDR but the DT I have access to only has a small
bit of that mapped.. until I know exactly what the mapping is, I will
not be applying this.

Thanks,
Conor.

0 - https://lore.kernel.org/all/20220901133403.3392291-1-conor.dooley@microchip.com/

Conor Dooley (3):
  dt-bindings: vendor-prefixes: Add entry for Aldec
  dt-bindings: riscv: microchip: document the Aldec TySoM
  riscv: dts: microchip: add a devicetree for the Aldec TySoM

 .../devicetree/bindings/riscv/microchip.yaml  |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/riscv/boot/dts/microchip/Makefile        |   1 +
 .../dts/microchip/mpfs-tysom-m-fabric.dtsi    |  47 +++++
 .../riscv/boot/dts/microchip/mpfs-tysom-m.dts | 168 ++++++++++++++++++
 5 files changed, 219 insertions(+)
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-tysom-m-fabric.dtsi
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-tysom-m.dts

-- 
2.36.1

