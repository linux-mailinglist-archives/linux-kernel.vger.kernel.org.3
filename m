Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7A35928E7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 07:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiHOFIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 01:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiHOFIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 01:08:20 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061AC13FB4;
        Sun, 14 Aug 2022 22:08:20 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 76CB63200065;
        Mon, 15 Aug 2022 01:08:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 15 Aug 2022 01:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1660540097; x=1660626497; bh=GURiT1H4R1aPZcWdp4xxRYHra
        9cy+uB2goooIPTc6Jg=; b=wvN7K0TQOpJiWH8IL+S7vO3APopXJvKAK+cDnKbnH
        VclnqPhUyq0wtqcUUhEUq7AUXu9edpXtRgAJ6+KDKVaZ4wpHtdeGVZv3XuCNA8RT
        gAM8dTiAWdcIZdMi258iKMKBgX1VsHtvimZmcCJQ+cjXgpgbcGJoLmWCnmpfEezZ
        HeJu0Cxj5Fq2VbIEW7Hk3DRwq7YQA5wX+GEH7oMFLzHGQPHLSYAmpl7TnK1MVKk8
        Y3hzwnmV5jBOAQT97CGSBtIm8NmU/7icO1DWM5qmvms9EFIHD1tymJV5deKucmqU
        6OzdgmV0jvIjuCVaUR5sVoP6MHHwNFXV6+hEd9KqzUbVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1660540097; x=1660626497; bh=GURiT1H4R1aPZcWdp4xxRYHra9cy+uB2goo
        oIPTc6Jg=; b=0RJ4xJ+cEhCcoP5inwm5Ypq25K7YFtl2LQoPmHW/XG9Ez2J2QoJ
        j6I/A5gfQ1hIogj4Av6dVP/9Qo/g2w0mYHbBQlkxeLiIettlE2BzGY4+oqhZwcjY
        VPvFBBwXRqBCstSSmU2HhIOegWxzqTbapzxspqM8G8wZiJwVee4mm6xQfGGL2G1J
        A6tl4dmLc0aC3qTPI+1LX1fLWw5zh1awp+T+PGGjWVKlidKgLBddBkzgNB0DszRJ
        Qbcet+E9IL+YngK3s0gghicDbgnrGcBbNQy3AGPcJVyjEFKyhi6MLdJDK4u7cQl0
        IwNa9Yr7C25N5cOm8RlO2n4aMPYthWNQlNA==
X-ME-Sender: <xms:wdT5YuikaCUvUSPQoVurY7tVRd7qTM8Jw6lhxKPlZZRFdDQw_YQKkw>
    <xme:wdT5YvDCjG95Vmz0OhqatLnkDxxIIORuu-iuGQeJXI4b2ZcFdrMbraLvBVgU_SK-o
    jIzRRMas8cb1D9swA>
X-ME-Received: <xmr:wdT5YmH4ssKJL0lCic0qjGq26EA6v2WbGjfhM6fSM1Xjs5lM3jlunZF_A2MqiAP6Bv6Yz3ld3lcu6XSbNhd7Rd-snfBDH1QfhRSGpdUJk0dYiV0HE24X4sQoczVn-yHfVhkEaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeehffethedtteffgfefteetjedvfeelueevudffgfeutdejvdehledv
    vdffhfevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
    rdhorhhg
X-ME-Proxy: <xmx:wdT5YnRTqg3_tDfS1yJF9u5Bl5z3o3ixHO9sD9WZtHEk2-R0H5TIBw>
    <xmx:wdT5YryEs5s6KOAcxRp-d3ttUflU6h5Evkigh6rj939Aa7MDXiPeHA>
    <xmx:wdT5Yl4I53rJW1wQIW3ce3HAkLDvKF4U-3s52HT3Ny9aI9ZkJ-rkLA>
    <xmx:wdT5Ygq-NCUHbp-d6fO3CAw4gppml22q02vDy-JmYoZea-nC5ahvMA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 01:08:16 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 00/12] riscv: Allwinner D1 platform support
Date:   Mon, 15 Aug 2022 00:08:03 -0500
Message-Id: <20220815050815.22340-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the Kconfig/defconfig plumbing and devicetrees for a
range of Allwinner D1-based boards. Many features are already enabled,
including USB, Ethernet, and WiFi.

The SoC devicetree uses bindings from the following series which have
not yet been merged:
- SRAM controller:
  https://lore.kernel.org/lkml/20220815041248.53268-1-samuel@sholland.org/
- NVMEM cell bits property change:
  https://lore.kernel.org/lkml/20220814173656.11856-1-samuel@sholland.org/
- In-package LDO regulators:
  https://lore.kernel.org/lkml/20220815043436.20170-1-samuel@sholland.org/

All three of these are required to set the correct I/O domain voltages
in the pin controller, which I would consider important to have in the
initial version of the devicetree.

The SoC devicetree does contain one small hack to avoid a dependency on
the audio codec binding, since that is not ready yet: the codec node
uses a bare "simple-mfd", "syscon" compatible.


Samuel Holland (12):
  MAINTAINERS: Match the sun20i family of Allwinner SoCs
  dt-bindings: riscv: Add T-HEAD C906 and C910 compatibles
  dt-bindings: vendor-prefixes: Add Allwinner D1 board vendors
  dt-bindings: riscv: Add Allwinner D1 board compatibles
  riscv: Add the Allwinner SoC family Kconfig option
  riscv: dts: allwinner: Add the D1 SoC base devicetree
  riscv: dts: allwinner: Add Allwinner D1 Nezha devicetree
  riscv: dts: allwinner: Add Sipeed Lichee RV devicetrees
  riscv: dts: allwinner: Add MangoPi MQ Pro devicetree
  riscv: dts: allwinner: Add Dongshan Nezha STU devicetree
  riscv: dts: allwinner: Add ClockworkPi and DevTerm devicetrees
  riscv: defconfig: Enable the Allwinner D1 platform and drivers

 .../devicetree/bindings/riscv/cpus.yaml       |   2 +
 .../devicetree/bindings/riscv/sunxi.yaml      |  64 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   4 +
 MAINTAINERS                                   |   2 +-
 arch/riscv/Kconfig.socs                       |   9 +
 arch/riscv/boot/dts/Makefile                  |   1 +
 arch/riscv/boot/dts/allwinner/Makefile        |  10 +
 .../allwinner/sun20i-d1-clockworkpi-v3.14.dts | 242 +++++
 .../sun20i-d1-common-regulators.dtsi          |  51 +
 .../dts/allwinner/sun20i-d1-devterm-v3.14.dts |  37 +
 .../sun20i-d1-dongshan-nezha-stu.dts          | 114 +++
 .../sun20i-d1-lichee-rv-86-panel-480p.dts     |  29 +
 .../sun20i-d1-lichee-rv-86-panel-720p.dts     |  10 +
 .../sun20i-d1-lichee-rv-86-panel.dtsi         |  92 ++
 .../allwinner/sun20i-d1-lichee-rv-dock.dts    |  74 ++
 .../dts/allwinner/sun20i-d1-lichee-rv.dts     |  84 ++
 .../allwinner/sun20i-d1-mangopi-mq-pro.dts    | 128 +++
 .../boot/dts/allwinner/sun20i-d1-nezha.dts    | 171 ++++
 arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi  | 900 ++++++++++++++++++
 arch/riscv/configs/defconfig                  |  23 +-
 20 files changed, 2045 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/riscv/sunxi.yaml
 create mode 100644 arch/riscv/boot/dts/allwinner/Makefile
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-clockworkpi-v3.14.dts
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-common-regulators.dtsi
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-devterm-v3.14.dts
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-dongshan-nezha-stu.dts
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel-480p.dts
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel-720p.dts
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel.dtsi
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-dock.dts
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv.dts
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-mangopi-mq-pro.dts
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi

-- 
2.35.1

