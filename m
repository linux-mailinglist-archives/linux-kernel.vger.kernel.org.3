Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE2455AE24
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 04:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbiFZCLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 22:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbiFZCLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 22:11:53 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E529913E85;
        Sat, 25 Jun 2022 19:11:52 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 49A0B32000D9;
        Sat, 25 Jun 2022 22:11:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 25 Jun 2022 22:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1656209510; x=1656295910; bh=OfLz51eTek1s6L0r4HLI8XBL1
        7NaYVkguVMcN4kMcsY=; b=an8/1OvBznkGHwaVf1scWXRfYTuyBfgn9Jz8RaHCZ
        RCYnrIeDw5cFH9DLZN//uMVkyjPF5SC+0WlocvKHpADlmEUEYfhgkugqgKyTsmOM
        XhsfZCE68njzzSYbkL3MrLDktIKcsEJWsEhevlTdtmN0GiHrkxgpapFohPNpJVi1
        OrV4uS/PJ8Dc+5N/vebHMVxqHMcflYuFGYbiEZSop0t+Bvg/6egj+vF2RjWEziK+
        AH+hnZ+pfqQRFzghYFCXpeBKMbARdcA6ckhTcpUj2hZJPq30hN8+XLdH0W6KWBZ9
        5yOu+KZM5KY+SNRvOt4jU0OKwcXuK4TzVxbpc0bZJTxmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1656209510; x=1656295910; bh=OfLz51eTek1s6L0r4HLI8XBL17NaYVkguVM
        cN4kMcsY=; b=rjNFR2TZ7Jiv4bl0bwJQSJJh4YY3gFSewRhrjZUEoTYIVdoOgbG
        iUUkL9+87xpvXZhHX7afjAl0j7BQ/JUyXdmWfiwyc3fP6AcWzZXQgLS1ykK4rpY0
        DZMuJgBGHlfrvmwHJ94qBxgVYJvu9RN5muvSCi3OPyIHXew4CDxluGrps3e89twE
        +uGGP4Cdmnm4n5EzyB1eOUG7Nvj8O9LSxm5pVw6PF8C7jV7rOFo9zp40r6Pek2uj
        +ynHhvtm1PcHZxGamywZN9MEKGVrNgB5P5UdD/XJ0sz89nQYVFYalHsCPopRw4Jp
        yFbR2vJeOQvurnLvZaOJ6yFnx9+0ABQ8ing==
X-ME-Sender: <xms:ZcC3YuNcSfN95GPzVh2iPUvgWF72Y7xFyIKN3irmapd-JEKpbo8-vA>
    <xme:ZcC3Ys-a6kIFJxjXEUGgHSRoVf9xKSdKCxjXYxDsjv2ViWBW9OstqESLXkVpCoMDW
    suFB_eyJlNkUKCtug>
X-ME-Received: <xmr:ZcC3YlQ8LnVqF2PFRFMsSA5-Xevb_ZikbV3aWyEKkEQ_d5a2RU1gsb81v2aXGqYz9pI5GCLZofbpWzCMVPLoXHUMdGT0yuehhLsF3NyZHr477Nufl8vhuY0JrRW3gAcCJ8uZUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudegvddgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeevlefhjeeuleeltedvjedvfeefteegleehueejffehgffffeekhefh
    hfekkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:ZcC3YuuTNimGPhK4gCTgHbDPzVTABx1YdBjlZ9oF9KdunZ372nIKfA>
    <xmx:ZcC3YmfhCfjFans4H_yP2niug-C-HsLqzIcIbIO6PWH5Rsw4fAjrYQ>
    <xmx:ZcC3Yi0fkhpw8oPhhcyJOH5k6kBYccFv9Cs3TSLbc1nwCuD_DFOv1g>
    <xmx:ZsC3Yi1XUiJmAT6GAEr0C3AF5eaL3UyxOxUOW4Z5RejYPGBreGRMJQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Jun 2022 22:11:49 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>, Ondrej Jirman <x@xff.cz>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH 0/6] pinctrl: sunxi: Allwinner D1/D1s support
Date:   Sat, 25 Jun 2022 21:11:41 -0500
Message-Id: <20220626021148.56740-1-samuel@sholland.org>
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

This series adds pinctrl support for the Allwinner D1/D1s SoCs. First,
it updates the I/O bias code to support the new mode found on the D1/D1s
(as well as some existing SoCs). Then it refactors the driver to support
the new register layout found on the D1/D1s. Finally, it adds the new
driver.

The code size impact of the dynamic register layout ends up being just
over 100 bytes:

   text    data     bss     dec     hex filename
  11293     564       0   11857    2e51 pinctrl-sunxi.o (patch 3)
  11405     564       0   11969    2ec1 pinctrl-sunxi.o (patch 6)

This series was tested on A64, H6, and D1.


Samuel Holland (6):
  dt-bindings: pinctrl: Add compatibles for Allwinner D1/D1s
  pinctrl: sunxi: Add I/O bias setting for H6 R-PIO
  pinctrl: sunxi: Support the 2.5V I/O bias mode
  pinctrl: sunxi: Refactor register/offset calculation
  pinctrl: sunxi: Make some layout parameters dynamic
  pinctrl: sunxi: Add driver for Allwinner D1/D1s

 .../pinctrl/allwinner,sun4i-a10-pinctrl.yaml  |  15 +
 drivers/pinctrl/sunxi/Kconfig                 |   5 +
 drivers/pinctrl/sunxi/Makefile                |   1 +
 drivers/pinctrl/sunxi/pinctrl-sun20i-d1.c     | 860 ++++++++++++++++++
 drivers/pinctrl/sunxi/pinctrl-sun50i-a100-r.c |   1 +
 drivers/pinctrl/sunxi/pinctrl-sun50i-a100.c   |   2 +-
 drivers/pinctrl/sunxi/pinctrl-sun50i-h6-r.c   |   1 +
 drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c   |   2 +-
 drivers/pinctrl/sunxi/pinctrl-sunxi.c         | 156 +++-
 drivers/pinctrl/sunxi/pinctrl-sunxi.h         | 110 +--
 10 files changed, 1022 insertions(+), 131 deletions(-)
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun20i-d1.c

-- 
2.35.1

