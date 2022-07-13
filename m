Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B637A572B79
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 04:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbiGMCwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 22:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiGMCwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 22:52:46 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF89D31D1;
        Tue, 12 Jul 2022 19:52:38 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 71E945C0051;
        Tue, 12 Jul 2022 22:52:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 12 Jul 2022 22:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1657680756; x=1657767156; bh=LZJK/dcxtbGpNFfRmqzuMotXu
        yK73IQLM1tbkYhb0Z0=; b=ogOpoho0bZhFI3vl/qb7l3r8aR0gVws3pei5wJvE/
        izMYNcT7oTK3+o/hQqcgoCfV5iwM3y1KMSCo1Iu4Nn4YATPMsp5gLIbFoqvQdJkb
        HArecbgO+Ozqv1PiAaoOPjBObENFOiDqbXAdutN322XdpPAf43KwbJNbLRxKLHOH
        An469/x1xmQd2fjWmzCs/4HsKPiKnkVy4ZGvo1gj/lZxBKLtvCGYDcSpunOfheV0
        /FQt1+oaW5L3HMIMt5N1jXFme7tnk7z/ttvv49I2yol5Y4Rwri6PRqEP5lj+NnmD
        DqFreuWBNm7MfPqnHwAqSLX3IVseJmhISaFybCzgAsPzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1657680756; x=1657767156; bh=LZJK/dcxtbGpNFfRmqzuMotXuyK73IQLM1t
        bkYhb0Z0=; b=vfofMhc2knqiEwCpHManqRmcVoRqMf6w9H+p/QuPCrBdEtx7cKM
        0lRCWwapS4rzIEt+IX1OFQX8PoW8trYbAzjFJAmEuBnZdfci+nsZL7fmbnNU7WG3
        mrERxZIOhrfJxLknfsHSd9mOSOh8PvrEfW9YoD+mvEfA2LAqiwFIs2ZStltuR6ao
        i762gu6FdDmzq7UBv/wnD69K4piGh/U2jrMWHyxuWmndPjl6vEcQkzhhjqOUPsvM
        zy1NKCFqZhYvcZFQwMlRwxmFtEKeqPUXljmXP2tzBsgOIq87rEDKnaHM+7Bu1Nlo
        oXBivARaDuXcuLEIqF8JjJjhIqQj1lyPJ8g==
X-ME-Sender: <xms:czPOYka7o2niLhWtYu6SAi0ABE5SNQQ3HrhiMztwxuLEPSPiVen_jw>
    <xme:czPOYva8dbXTyEosvtbW9aiCjvvDAWNICO3RYEiN4OS-gdI8JnrLzKzip9XMAY0dC
    Hn7ipHP2_Me0rOexw>
X-ME-Received: <xmr:czPOYu_QDokyqNG_yhLYghHCIbUPlKjJhA8VL2iiCtN8fA3VDG_hsMWXtlDqKLHMseBvHBBoy79UPKdN-v9IZuD31lvZJu7Y4lnoKkkdW9MvKQMsxXtAzNnqCRHS6NC28fWPwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudejiedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeevlefhjeeuleeltedvjedvfeefteegleehueejffehgffffeekhefh
    hfekkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:czPOYuobPc6vhuTUJTHcP4CTwM4dGzvx8OuH00yazV8WET1QrpRvvA>
    <xmx:czPOYvriFJuFKiFP2qP46505sxU-TfQgLIV1yp9eS5DmdiwtqkdG-A>
    <xmx:czPOYsTcL1dzIP6M6oLH9UxDy5eHVUpcA5PtEIMIfgioEmso0NYEzw>
    <xmx:dDPOYoSoRkrktCoFnVoU6aTOL8Le1zRmzWzr6YhL2GJ0IvYx5SWaGw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Jul 2022 22:52:34 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH v2 0/6] pinctrl: sunxi: Allwinner D1 support
Date:   Tue, 12 Jul 2022 21:52:27 -0500
Message-Id: <20220713025233.27248-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the interest of keeping the series ready for v5.20, I decided to drop
the D1s bits so we can decide how to handle the compatibles next cycle.

This series adds pinctrl support for the Allwinner D1 SoC. First,
it updates the I/O bias code to support the new mode found on the D1
(as well as some existing SoCs). Then it refactors the driver to support
the new register layout found on the D1. Finally, it adds the new
driver.

The code size impact of the dynamic register layout ends up being just
over 100 bytes:

   text    data     bss     dec     hex filename
  11293     564       0   11857    2e51 pinctrl-sunxi.o (patch 3)
  11405     564       0   11969    2ec1 pinctrl-sunxi.o (patch 6)

This series was tested on A64, H6, and D1.

Changes in v2:
 - Drop D1s compatible for now, due to ongoing discussion
 - Fix PE3 function "csi0" -> "ncsi0"
 - Fix comments for JTAG DI/DO pins
 - Include channel numbers in PWM functions
 - Drop the separate D1s variant, since D1s is a non-conflicting subset
 - Enable the driver for MACH_SUN8I to cover T113 (same die, but ARMv7)

Samuel Holland (6):
  dt-bindings: pinctrl: Add compatible for Allwinner D1
  pinctrl: sunxi: Add I/O bias setting for H6 R-PIO
  pinctrl: sunxi: Support the 2.5V I/O bias mode
  pinctrl: sunxi: Refactor register/offset calculation
  pinctrl: sunxi: Make some layout parameters dynamic
  pinctrl: sunxi: Add driver for Allwinner D1

 .../pinctrl/allwinner,sun4i-a10-pinctrl.yaml  |  13 +
 drivers/pinctrl/sunxi/Kconfig                 |   5 +
 drivers/pinctrl/sunxi/Makefile                |   1 +
 drivers/pinctrl/sunxi/pinctrl-sun20i-d1.c     | 840 ++++++++++++++++++
 drivers/pinctrl/sunxi/pinctrl-sun50i-a100-r.c |   1 +
 drivers/pinctrl/sunxi/pinctrl-sun50i-a100.c   |   2 +-
 drivers/pinctrl/sunxi/pinctrl-sun50i-h6-r.c   |   1 +
 drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c   |   2 +-
 drivers/pinctrl/sunxi/pinctrl-sunxi.c         | 156 +++-
 drivers/pinctrl/sunxi/pinctrl-sunxi.h         | 109 +--
 10 files changed, 999 insertions(+), 131 deletions(-)
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun20i-d1.c

-- 
2.35.1

