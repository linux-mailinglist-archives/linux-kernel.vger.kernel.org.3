Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB19538AEC
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 07:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243999AbiEaFgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 01:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236819AbiEaFga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 01:36:30 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084586FA10;
        Mon, 30 May 2022 22:36:28 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 962FC3200939;
        Tue, 31 May 2022 01:36:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 31 May 2022 01:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1653975385; x=1654061785; bh=u09AbJGPuNIVZN1PiNPkATqKx
        XmT/KZro1kYxtMw6gY=; b=q9vDoi2og7ljp0M8+O5Po1S9SnfhRHnYSDBeVBdhe
        LiEiPZit8i4vntrJ9yArjKFkoN/NxYBhtFdGRR8TqjGKdAvlDh596ETnXT+EIcuN
        Y+dXFVUSY9YPSoEBBBVFhcv5Jbh2M1jfzuncEm91tAeIgqf4tXCuCBn5kkTS6BBb
        4GbSH0ZVttf5zTEIpMXNhgb3C4YepDTATTH7hdU0kwkusEaXwYuOeSNolopORQv4
        K6vVU99xKnKMUixjMkSy4FUO4lWYSXOCNQYzAi4UtIDbd1Pfc9+EkK3CU6oK+SHw
        /6GuY5ULEfIr6W2mo8BiSXh9TAji9iNMCvbB6gtGNJhYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1653975385; x=1654061785; bh=u09AbJGPuNIVZN1PiNPkATqKxXmT/KZro1k
        YxtMw6gY=; b=hulM2hFfRoNf3nUR0tIs9NgzCZX/TIkZwkzfkezaiNuxVERnvN0
        sRTH4oUGLUYiLULF8LmyUY1CGdzk+0SdjNIl129jv8fFvT5d7zEhRRP834TUvt3O
        O1JIqAolnp3ovwIvXFwcd4Zraf1JXmnsShdfSNWUdNqKLMSi180SbjLAeolxEhWL
        QnzcezCz9Cn/Iu4MCmIFYG9DF0UmgnHi/9hDxPXPHo0Mz6TseOSFvc6sOS7PnLFr
        8iLrTZOXG7K8Uf9P+EIGF9IFVqZrJImGwWJyuOjJ1TSHDkQIAlkkFBNExh9iDlKQ
        k6CCXUBG4VQ/XhdpCb2iOi/WH6QW5JTnWEg==
X-ME-Sender: <xms:WKmVYoCPwtiFtnTvRLjME7WAoBiXTMetEwdWF4aSQxnqloifyVdXww>
    <xme:WKmVYqg1uqn9dh5tMBKN7qh_N6gFf2wvRpSpHQCR1Nzo4m1JiwcbzKm0FAKOP_vhK
    9VASvgSCQzcntJ3Vg>
X-ME-Received: <xmr:WKmVYrkgvq6vC4QofJ7FYqKd6wwJfUx5L6JP3v3HoGR2lOcLkQDaWE38rxJC8uxPSp0K5JNJfSL1ViwxXYDUqerwcRmKesXCARvNGtrfzWBmrWKReVdODzXNXVBJ_PwzDd849g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrkeejgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeekveelhfejueelleetvdejvdeffeetgeelheeujeffhefgffefkeehhffh
    keekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:WKmVYuyQyRULO7QtDtdsvDKcOPHLvS8IbZ7wzFcWoseBkgnH-mgqfw>
    <xmx:WKmVYtSA2txUCOFMAvd8tbuUwDc7EiyJo0769Pf6gzkxCrbqqQ-Z_g>
    <xmx:WKmVYpbuHXWrNSlwlkiOD0XIehVQZjudaiMaGCQaHIYtNYTvfGPPfg>
    <xmx:WamVYsKMjMjqpZ7cGX8UucHvZks69ochiqc4wN2BljUwAcP9-GNq5Q>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 May 2022 01:36:24 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH 0/3] pinctrl: sunxi: Remove non-existent reset line references
Date:   Tue, 31 May 2022 00:36:20 -0500
Message-Id: <20220531053623.43851-1-samuel@sholland.org>
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

I assume these properties came from a lack of documentation, and the
very reasonable assumption that where there's a clock gate bit in the
CCU, there's a reset bit. But the pin controllers are special and don't
have a module reset line. The only way to reset the pin controller is to
reset the whole VDD_SYS power domain.

This series is preparation for converting the PRCM MFD and legacy clock
drivers to a CCU clock/reset driver like all of the other Allwinner
SoCs. I don't plan to add reset lines that don't actually exist to the
new CCU driver. So we might as well get rid of the references now.
Technically this breaks devicetree compatibility, since the old drivers
expect the reset. But the CCU conversion will be a compatibility break
anyway, so it's a bit of a moot point.


Samuel Holland (3):
  pinctrl: sunxi: Remove reset controller consumers
  ARM: dts: sunxi: Drop resets from r_pio nodes
  dt-bindings: pinctrl: sunxi: Disallow the resets property

 .../pinctrl/allwinner,sun4i-a10-pinctrl.yaml  |  3 ---
 arch/arm/boot/dts/sun6i-a31.dtsi              |  1 -
 arch/arm/boot/dts/sun8i-a23-a33.dtsi          |  1 -
 arch/arm/boot/dts/sun9i-a80.dtsi              |  1 -
 drivers/pinctrl/sunxi/Kconfig                 |  3 ---
 drivers/pinctrl/sunxi/pinctrl-sun50i-a64-r.c  |  1 -
 drivers/pinctrl/sunxi/pinctrl-sun50i-h6-r.c   |  1 -
 drivers/pinctrl/sunxi/pinctrl-sun50i-h616-r.c |  1 -
 drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c   | 22 +---------------
 drivers/pinctrl/sunxi/pinctrl-sun8i-a23-r.c   | 25 +------------------
 drivers/pinctrl/sunxi/pinctrl-sun8i-a83t-r.c  |  1 -
 drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c   |  1 -
 12 files changed, 2 insertions(+), 59 deletions(-)

-- 
2.35.1

