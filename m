Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281ED5A608B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiH3KUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiH3KTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:19:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD367666;
        Tue, 30 Aug 2022 03:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661854713; x=1693390713;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=G5DqqeYFftRy6E94k8NanMKhorLf/PE/ar2pCiXSZaQ=;
  b=A/ZXeFch+I3k9GdVuwmqtqmLrnLYL+xqNLJ6EZNOxgDpH9yCuQF0Wkkz
   5rKuDWhfn+43SUv+PZSxFhxGp4Uel5ovEBVXB55PwNaR/3aomPadNABKx
   XYRgfojET7xExStGVQEniIsa+y/29OjJ7EqvpVWd+pGfA2TaRM+V5Ah28
   FHc5URSc89Zua9InimU51DPD0ctcnEKOWWhKvz83JZv7GK8aBPWs/hL8S
   R+U8yF+4sa2AMqay2FVZ9LCzaHbDcxZXlbxegZRwY7ZUJrQ8fj6t2AIoU
   qyuV+lNbb9TsGw+XCZKgjf6BkCLC8sD1/Qf89k2cMJ7DOTwHFunzPDPaQ
   A==;
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="174786750"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Aug 2022 03:18:30 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 30 Aug 2022 03:18:27 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Tue, 30 Aug 2022 03:18:24 -0700
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
        Hugh Breslin <hugh.breslin@microchip.com>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/9] New PolarFire SoC devkit devicetrees & 22.09 reference design updates
Date:   Tue, 30 Aug 2022 11:17:55 +0100
Message-ID: <20220830101803.1456180-1-conor.dooley@microchip.com>
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

Changes since v1:
- made the polarberry part of an enum in patch 1

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

