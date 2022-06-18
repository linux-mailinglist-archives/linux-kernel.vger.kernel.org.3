Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C0D55063D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 19:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236423AbiFRRGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 13:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236755AbiFRRFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 13:05:52 -0400
X-Greylist: delayed 475 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 18 Jun 2022 10:05:50 PDT
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698C912D3E;
        Sat, 18 Jun 2022 10:05:50 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 5635A2B04FD2;
        Sat, 18 Jun 2022 12:57:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 18 Jun 2022 12:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1655571470; x=1655578670; bh=cvEieaf7Gq9QmyebRGX2GIRjl
        EvOg4D81jsok9/7HPE=; b=Mh1l4/NK7BX5XIAKTgqdJVANXXHR6SyC6ZlP/UhDz
        aFr3md6b37WNKAFDLKCnmlikLkqfmTVueEJocB5LqsYLX++fX/NHs+EULJ3CRUm0
        xp904h5nSJqXtcn0a73KGcIAlmNgYH1o+VoeuxRTmB8oxjnC19/XmTDpnUV0gDpf
        XQYoWssyqpVRPKq7vLKrzmFT53iVYzQjo3Re/3y0FfMDOqn9QkOApvj2MfJ4dVb4
        90KyjbNAFQCr3VxnjROMnQEUevcujNCTulCCDd+GDkrq5nJ8vNeKub3GWNHdAybx
        rraGrO8dCqQz2/sM5OLLcqBrYQrpX9KVRDRir5a99UnTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1655571470; x=1655578670; bh=cvEieaf7Gq9QmyebRGX2GIRjlEvOg4D81js
        ok9/7HPE=; b=Py1g5YtIkfjwlDhcmmh1Sm5HXgtZ79vRaL1DXa4yVfht0v/+q0o
        jY/C5TxyQy3czRQghGcsiKOJksyPLxtp5RJ69OntqUarlQ4kZF0P0teLicFCpS3j
        /sCCkZufUIZLZF1APP2hWeNgsJuQZhKFwCSvxRFYGmeugAvH6DiVbWF9J7LCnTC4
        f9hw/QptH40f2cg1tyW7Wt71ZeqA9UQYPtfcOZ7gKdeO/gef0wBOKH63kD4PD7R0
        offRmO6PIkKiqGqpL96TMBna1mPeuy2vZkCojvrwTiSR7T23soC6z9TbCyPm1Zzy
        bN6pdzyuk+Pe2V2onMa8ZymB9q1qE5F9/rg==
X-ME-Sender: <xms:DQSuYr0wjc9Ay-LFfRLI5gpuX_IcjNyJep9l4waXbuJyU2Psrs6A0Q>
    <xme:DQSuYqGqGVUrGOfQ_rIWWtKt_Z8pBJB0awaaMSUboXpKK01FuBRZW-cq5efFRl4UE
    7JpQwzWVTflRGMwcQ>
X-ME-Received: <xmr:DQSuYr6kBi2wrLpTA4RJeIcL0Nu_xJRPqPQviHkMyZhSA_AWWBFPd62c0SLvjy3J0-iE05vzJUhYbiWxniPWghDTz5eKOds2KJnfdCx-T_9YUpAA4Xlk9zyAc16LHmtjUtPxVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddvjedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeevudeigeekledvgfevlefgueelkeduieelveejfffhjefggeelfefh
    teejgfegvdenucffohhmrghinhepmhgvghhouhhsrdgtohhmnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:DQSuYg1F4gvWB7rYdPVEAnw9Ph8oxtlkcIRl2xR-S-5R-TAHGJsseQ>
    <xmx:DQSuYuHYoIPpmLlS0kulI8jWxC3uMmz4JtDKIVPDAorIQ6CU3yEoSA>
    <xmx:DQSuYh8aqRwPULljo9XUul_eQ25NEpGwqpLnd94eNeRIAtjLWZpUvg>
    <xmx:DgSuYuLYiNlYu-Yby_2fOLqZeYeAgHthOGPCdjhu-rwfyr-uows0myvPDl4>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Jun 2022 12:57:48 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Ondrej Jirman <x@xff.cz>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Colin Ian King <colin.king@intel.com>,
        David Gow <davidgow@google.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        "fengping.yu" <fengping.yu@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH v4 0/4] Pine64 PinePhone keyboard support
Date:   Sat, 18 Jun 2022 11:57:43 -0500
Message-Id: <20220618165747.55709-1-samuel@sholland.org>
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

This series adds support for the official keyboard case for the Pine64
PinePhone and PinePhone Pro. This accessory contains a keyboard MCU and
an IP5209 power bank IC. The keyboard MCU firmware[0] is free software.
It exposes the keyboard scan matrix over I2C, and also provides commands
for SMBus access to the IP5209. In order to keep the IP5209 driver
(CONFIG_IP5XXX_POWER) generic, this is modeled as a child I2C bus.

[0]: https://megous.com/git/pinephone-keyboard/about/

Changes in v4:
 - Rebase to resolve MAINTAINERS merge conflict
 - Add missing newlines in error messages

Changes in v3:
 - Replace unevaluatedProperties with additionalProperties
 - Rename i2c-bus to i2c
 - Rename i2c-bus to i2c

Changes in v2:
 - Drop keymap DT properties
 - Add vbat-supply property
 - Fix missing key release events when FN state changes
 - Add VBAT consumer to ensure enough power is available for the MCU
 - Use a single fixed-size, fixed-contents keymap for both layers

Samuel Holland (4):
  dt-bindings: input: Add the PinePhone keyboard binding
  Input: pinephone-keyboard - Add PinePhone keyboard driver
  Input: pinephone-keyboard - Support the proxied I2C bus
  [DO NOT MERGE] arm64: dts: allwinner: pinephone: Add keyboard

 .../input/pine64,pinephone-keyboard.yaml      |  66 +++
 MAINTAINERS                                   |   6 +
 .../dts/allwinner/sun50i-a64-pinephone.dtsi   |  18 +
 drivers/input/keyboard/Kconfig                |  10 +
 drivers/input/keyboard/Makefile               |   1 +
 drivers/input/keyboard/pinephone-keyboard.c   | 438 ++++++++++++++++++
 6 files changed, 539 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/pine64,pinephone-keyboard.yaml
 create mode 100644 drivers/input/keyboard/pinephone-keyboard.c

-- 
2.35.1

