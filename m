Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC22504611
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 04:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbiDQCTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 22:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbiDQCTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 22:19:13 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53296366B2;
        Sat, 16 Apr 2022 19:16:37 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id CF4265C014B;
        Sat, 16 Apr 2022 22:16:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 16 Apr 2022 22:16:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1650161794; x=1650248194; bh=3z4qb2iXssMBNtBzDcGwmK34u
        kQSa5UnNA+TI9n5rS0=; b=knrTPnOVjGKheDjCzbeKJ4cfgzRqB0/4DA2sVJjLs
        qDEWxVCmIYMD6EZLhIbU3KPnyiZEVhZ2O1DDQ4OMas//sqWI1iuZoO7c3PFLwemA
        nyg+8sDXBwXxuNCICBnKYeev2pQlO/0qfPV70j+kYvJ2pc8Pfn8omC7iUFgSVi7+
        DVr+TCwGETtgPld2sxCpweU9P3tmvJfntai5fYUrhEH1KXZuWg9NzmiXPCCE+gS3
        ZZdQK0w4OTYjom5BDHZ1nNR/ycromZb+QLJa8s+MT/b6K0fqvDb9sasfTnvrFg77
        oY8YXdpql9H3DSLrglDdQYVNixOiumeVEtqn1AV+2GhoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1650161794; x=1650248194; bh=3
        z4qb2iXssMBNtBzDcGwmK34ukQSa5UnNA+TI9n5rS0=; b=wO1+Rb4DqoHqdrsej
        ES/99VIT3uNO2Ou6Wygat4enYC2wbZaal2ro3nh6BnehCrFDrkKfsVksfVMBlRsF
        ALaiUbZ3o41WBa6Gg41rbvnlQC4kSQ5V8OJwfB6eB1HVYpW1e8zdc9LrfJRaJ4d/
        pmXp7BARSEHMfHkyTybl9n7UzDDLAxOi+RFv0ddOl9g9dCnjaF475e5ViXkPOetH
        3c5mq4VTKZGVN0GYStJ8VYGuiGDvSzKSjjth+Lta/rO3y8/ozQu6cOmomATM8VjI
        4Qaa1RA8jLSVO/SXGFt0PX6K9MqA5QVqvQeaF3OQlv4IxWFgzQrUTIep25JFxWoX
        v+zCg==
X-ME-Sender: <xms:gnhbYjq97wied_xrULWaSQfM1VqD3XlprOBK69iET1jls22yUBgBDA>
    <xme:gnhbYtrJgzeiT_t57B_jK2nYvLuQCwG3q15BNvY3CmYOpDpLYDsRpWPtXQcp2A7y3
    PdWYEUPlwit_lWzCQ>
X-ME-Received: <xmr:gnhbYgMmzyIAYDsb9DkJvPkLDCkkFBciODthdXOnYv-37LDFbeRESsBUcNw2vVyFYGPOFnFnaa77e2A9ruC9bK-NoBKsoHc-dLkmxyIweDfdfV1cycx7b7_IQAi1jk_j70Oydw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudelkedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeefieelgfelfffgfeeihedvvddtveelteefleelgeeuhffhueevhefftdej
    ffeukeenucffohhmrghinhepmhgvghhouhhsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdr
    ohhrgh
X-ME-Proxy: <xmx:gnhbYm5NAdiGqN1ogn2G8iWOljBMFENMxDHFmczm3j25oEuYcoYLUA>
    <xmx:gnhbYi6QyiV6H55FEc1WL_ocJjdjH6Lbjf6Wt_8LnTW4Fy42w3cyNg>
    <xmx:gnhbYuhTF2TdYM7iJXet_-kAA5w0W20oD_VvajZAXnAiGHW7-KrzkQ>
    <xmx:gnhbYvvkDk5NsEDtE3rNXI7jYCyZQSdyJofy73BykKCbwJ2TbNxghQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 16 Apr 2022 22:16:33 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Ondrej Jirman <x@xff.cz>,
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 0/4] Pine64 PinePhone keyboard support
Date:   Sat, 16 Apr 2022 21:16:28 -0500
Message-Id: <20220417021633.56127-1-samuel@sholland.org>
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

