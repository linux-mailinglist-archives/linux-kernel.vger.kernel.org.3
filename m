Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415545A202E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 07:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243589AbiHZFKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 01:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiHZFJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 01:09:51 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F67960CE;
        Thu, 25 Aug 2022 22:09:49 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 208683200A8A;
        Fri, 26 Aug 2022 01:09:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 26 Aug 2022 01:09:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1661490584; x=1661576984; bh=NEvgS4Y1TGOoJYMfZcyVI7VSq
        u0kF4KmZH4aP8oll78=; b=f8802ZT0NXEE+nsRnbik4K9cWZcHki4hnSdjJZfGn
        PBgM6nwfWv691zRaAK77mn+43zu0xFXjMGA0i3QLNI3hpTnweYHI0Kw4LmqWLZfC
        QUgZBj80ayu+BYuBKHbbz1em3Yj+qNSeTIb8XcLfQ0qcoUGAn3timDgkhC6OpMXI
        OYBSh47xGcrHvLt06VsQILSSNKkRNuqMlB2/iRZdPmka+6LYrqlx3u1bFJE1nNFZ
        +bxcvtcXdl2sBqgR/LU0d5RAiBSquFv4mUhWh34CETvoJRNPNCqSw23rOj4DM70h
        iU4Zro3OgouG3TE6fLRRwmBsixTWucDiE9o6YYzVhbZLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1661490584; x=1661576984; bh=NEvgS4Y1TGOoJYMfZcyVI7VSqu0kF4KmZH4
        aP8oll78=; b=YNSmRSML2ldp/e9zXzgdBhzVPrRhlFXUacx2mCIlkJAreIK24FV
        hS9ey9XNCPCMjJC5aYYH8DvK66X2S7p8g2iID9nS0fJ6ChkEIylObpCwlYSiWgsd
        TKtD4D3M0K2enCV19wFxQHgghdj7PAOi3VP55RfZfBTCRzIQXCfI6c0sjbuTNa0X
        BvJuPQOxtk8s11tYWyQCs/Bwkd7EtNBloFPatWNNLlMx27pi70TB8sZ3K74fDy0D
        rEGoQ7MmM5MOnebfjSSGjYFmPRTOetk8S+HTTtggi+OUQtgq1spszhCnGz8pOX/O
        1a1LcAj4f3nXBlH4R0Jv52wp3S7UqhemBsw==
X-ME-Sender: <xms:mFUIY8MBMQnlzLkG6OGsoaFw6qLEeQjNBa6mjRpimGauLfmPn_hF3w>
    <xme:mFUIYy8OLfPPugBExTwKIuB30LAkBZGMfJ5r7zOZTHLFqjHrbI5l29R0ywSsjiDCi
    Lp3OFSf020YfI49BQ>
X-ME-Received: <xmr:mFUIYzScodFYc7oMlO-7JoltIBvDkLmNZDeZBE-3O91LmxLDFUuK43hW35flrPHpNDIwsFVFwkLryOefjmibzGemc7KW9bTV8E1Ei95YRiFAaXoFykHok1YwEpS-W_z8m7Ev1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejgedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeehffethedtteffgfefteetjedvfeelueevudffgfeutdejvdehledv
    vdffhfevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
    rdhorhhg
X-ME-Proxy: <xmx:mFUIY0um-dA0-TUql_kJQgsSGpbfeo_bURQjsilFxtJ6gEt1c8voyw>
    <xmx:mFUIY0f0GtmvgtYxBLAxh6kjP-2RZA4fH_RZMcz-SRfqjMButhNp8A>
    <xmx:mFUIY41oTOzbWnPgFdIe_Yt_p6OvPe7HYVMyelx76C1zaGJYdGl11Q>
    <xmx:mFUIY1UmUzaDG3fFjkAm4cvTI90F4Qdt5xPqeHdmMpp5v5ba7RNlew>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Aug 2022 01:09:43 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Pavel Machek <pavel@ucw.cz>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-leds@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v5 0/6] leds: Allwinner A100 LED controller support
Date:   Fri, 26 Aug 2022 00:09:36 -0500
Message-Id: <20220826050942.20067-1-samuel@sholland.org>
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

This series adds bindings and a driver for the RGB LED controller found
in some Allwinner SoCs, starting with A100. The hardware in the R329 and
D1 SoCs appears to be identical.

Patch 3 is included because the LED controller binding requires the DMA
properties. That patch was sent previously[1], but never got merged.

Patches 5-6 depend on the D1 devicetree series[2], but the rest of this
series can be merged without them.

This driver was tested on the D1 Nezha board.

[1]: https://lore.kernel.org/linux-arm-kernel/20201110040553.1381-7-frank@allwinnertech.com/
[2]: https://lore.kernel.org/linux-riscv/20220815050815.22340-1-samuel@sholland.org/

Changes in v5:
 - A100 contains the original implementation, so use that as the base
   compatible string, and rename the binding to match
 - Add "unevaluatedProperties: false" to the child multi-led binding
 - Rename the driver R329 -> A100, since that is the actual original
   implementation

Changes in v4:
 - Use "default" instead of "maxItems" for timing properties
 - Depend on LEDS_CLASS_MULTICOLOR

Changes in v3:
 - Removed quotes from enumeration values
 - Added vendor prefix to timing/format properties
 - Renamed "format" property to "pixel-format" for clarity
 - Dropped "vled-supply" as it is unrelated to the controller hardware
 - Added vendor prefix to timing/format properties
 - Renamed "format" property to "pixel-format" for clarity
 - Dropped "vled-supply" as it is unrelated to the controller hardware
 - Changed "writesl" to "iowrite32_rep" so the driver builds on hppa

Changes in v2:
 - Fixed typo leading to duplicate t1h-ns property
 - Removed "items" layer in definition of dmas/dma-names
 - Replaced uint32 type reference with maxItems in timing properties
 - Renamed from sunxi-ledc to sun50i-r329-ledc
 - Added missing "static" to functions/globals as reported by 0day bot

Samuel Holland (5):
  dt-bindings: leds: Add Allwinner A100 LED controller
  leds: sun50i-a100: New driver for the A100 LED controller
  arm64: dts: allwinner: a100: Add LED controller node
  riscv: dts: allwinner: d1: Add LED controller node
  riscv: dts: allwinner: d1: Add RGB LEDs to boards

Yangtao Li (1):
  arm64: dts: allwinner: a100: Add device node for DMA controller

 .../leds/allwinner,sun50i-a100-ledc.yaml      | 139 +++++
 .../arm64/boot/dts/allwinner/sun50i-a100.dtsi |  26 +
 .../allwinner/sun20i-d1-lichee-rv-dock.dts    |  12 +
 .../boot/dts/allwinner/sun20i-d1-nezha.dts    |  13 +
 arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi  |  21 +
 drivers/leds/Kconfig                          |   9 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-sun50i-a100.c               | 554 ++++++++++++++++++
 8 files changed, 775 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/allwinner,sun50i-a100-ledc.yaml
 create mode 100644 drivers/leds/leds-sun50i-a100.c

-- 
2.35.1

