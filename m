Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D823C5A296D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 16:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbiHZO2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 10:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiHZO2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 10:28:44 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73AF1C10E;
        Fri, 26 Aug 2022 07:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661524123; x=1693060123;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yyk3C0tplTqm10LTuEAScqxik33o055KXg/FXYvR5QI=;
  b=bi+S+PjOweB/JWFAFTYW3SnXJnbYnpy2s+0Qx4Fg8+pNQ2DnP7I38JXZ
   e0e0wQfRUSpkXXFgfeiI9uUhpsy8Hj9KWSD0LglVrCxrgS3YVmnBOZZ4d
   NNBP6ARwc0hNShcAyM2pW/c2KkZtqLGMBF32ky1ceQ5sj2E1X5JYHb1sJ
   3BekY8gjZ8MByFCp/xWBYUo1JFo/3IJmAdUmf/1tGVJtVnDyodkINGd7S
   jyAGuhWG/k96BHI/70QmVL0i58I66Esr9CGH1JjTIDq2Nb5WLp0NjxxNf
   Mif0FvvXKMHahK3Cyg8Bzc6Fug+44HPBJZe3pomLI6zJbCPxtnbK1nF5F
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="171133563"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Aug 2022 07:28:42 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 26 Aug 2022 07:28:41 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Fri, 26 Aug 2022 07:28:38 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Shravan Chippa <shravan.chippa@microchip.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cyril Jean <Cyril.Jean@microchip.com>,
        Lewis Hanly <lewis.hanly@microchip.com>,
        Vattipalli Praveen <praveen.kumar@microchip.com>,
        Wolfgang Grandegger <wg@aries-embedded.de>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/9] New PolarFire SoC devkit devicetrees & 22.09 reference design updates
Date:   Fri, 26 Aug 2022 15:27:58 +0100
Message-ID: <20220826142806.3658434-1-conor.dooley@microchip.com>
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

Hey all,

Some 6.1 targeted changes here.
Firstly, two new dev kits (one first-party & one from Aries Embedded).
They've been sitting in our vendor tree, so are being sent where they
belong.

Secondly, another release of our reference design for the Icicle kit
is due in September. Usually these do not really change much for the
devicetree, but this time around a pair of changes impact the memory
map.

The first of these is adding dma-ranges to the pcie controller. The
controller had some issues to begin with & with the current reference
design (v2022.05) would not work with mainline Linux nor has it since
reference design v2021.08. A combination of the property, a change
to the FPGA design & a small fix to the driver will get it working
with mainline again. The other non-backwards compatible change to the
reference design is moves of the peripherals instantiated in the
fabric. Currently they are fairly spread out & a common complaint has
been that this leaves little room in the fic3 section of the memory map
for custom peripherals without removing the existing ones.

This series depends on [0] so as not to add dtbs_check warnings. The
fabric clock support is added by [1].

Thanks,
Conor.

0 - https://lore.kernel.org/linux-gpio/20220825143522.3102546-1-conor.dooley@microchip.com/
1 - https://lore.kernel.org/linux-clk/20220824093342.187844-1-conor.dooley@microchip.com/

Conor Dooley (7):
  dt-bindings: riscv: microchip: document icicle reference design
  dt-bindings: riscv: microchip: document the aries m100pfsevp
  riscv: dts: microchip: add pci dma ranges for the icicle kit
  riscv: dts: microchip: move the mpfs' pci node to -fabric.dtsi
  riscv: dts: microchip: icicle: update pci address properties
  riscv: dts: microchip: icicle: re-jig fabric peripheral addresses
  riscv: dts: microchip: add a devicetree for aries' m100pfsevp

Shravan Chippa (1):
  dt-bindings: riscv: microchip: document the sev kit

Vattipalli Praveen (1):
  riscv: dts: microchip: add sevkit device tree

 .../devicetree/bindings/riscv/microchip.yaml  |  21 ++-
 arch/riscv/boot/dts/microchip/Makefile        |   3 +
 .../dts/microchip/mpfs-icicle-kit-fabric.dtsi |  42 ++++-
 .../boot/dts/microchip/mpfs-icicle-kit.dts    |   3 +-
 .../dts/microchip/mpfs-m100pfs-fabric.dtsi    |  45 +++++
 .../dts/microchip/mpfs-m100pfsevp-emmc.dts    |  37 +++++
 .../dts/microchip/mpfs-m100pfsevp-sdcard.dts  |  37 +++++
 .../boot/dts/microchip/mpfs-m100pfsevp.dtsi   | 155 ++++++++++++++++++
 .../dts/microchip/mpfs-polarberry-fabric.dtsi |  29 ++++
 .../dts/microchip/mpfs-sev-kit-fabric.dtsi    |  45 +++++
 .../riscv/boot/dts/microchip/mpfs-sev-kit.dts | 145 ++++++++++++++++
 arch/riscv/boot/dts/microchip/mpfs.dtsi       |  29 ----
 12 files changed, 550 insertions(+), 41 deletions(-)
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-m100pfs-fabric.dtsi
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-m100pfsevp-emmc.dts
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-m100pfsevp-sdcard.dts
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-m100pfsevp.dtsi
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-sev-kit-fabric.dtsi
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-sev-kit.dts

-- 
2.36.1

