Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787C9488909
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 12:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbiAILxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 06:53:45 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:35305 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231228AbiAILxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 06:53:44 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 01C3258036F;
        Sun,  9 Jan 2022 06:53:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 09 Jan 2022 06:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=fm3; bh=V44g4KaOanUCYnEFrrXUjUu5uP
        rh4Es3XvFXpC0gceU=; b=nXbewoMimXzq2fUMipOYB/QKYHvOpgb/oYmAbfOhuS
        GYCumsTGHdvCf8DMRMPW6bINCaWqeToR7mobOJiyLzcNyN14K2+yHJl+lz4efJYl
        h+ASuPSAvEQZvFKBTTaZ4Qyxsu75dNU41N/iey6N2sS0/FEv3svfEIE2gRIp/RrM
        ZvSTVIK/uKuJzU9hX/6jG7OcpgCnxcivP/SQgj3fKJE7xDV2wS4O0X7Rc341GIR6
        RgUNk9vjdsxSekuiQ0uFNcWtYrql8iArPrwfuusvvKX4CWAaN66BakyMtYQBciAE
        HIEuJCY4KDSrUSBn0LedCRltgBaFi8WFLmK8miGFuDtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=V44g4K
        aOanUCYnEFrrXUjUu5uPrh4Es3XvFXpC0gceU=; b=TstFC+lm4vCyXXgZSkJo+T
        t2D63R/TrHDe5TJmtBT8o23n/RIPVbGwGuPa6XBw83VqSmrAVMRuN65+1uy7nafq
        IF/qNcZPaAuj4uuHHYfpbebrQ1eWWnT5a4+N3Y0RVKrb3oNquvE5XRtihe3bmQtH
        bR87XUAxIam34FEb0YVwKPTYw8fdKKxa+UryvC7DEKrvizFRFIg/RuoCAEIQkw8h
        IQ9Eub7vmH3PZy5MaAVqE+h+4w2TKpMl2ChC2ciKhzorbsGZPVzlV6nVKEsK2aZn
        FdfEVwub3650jnxMbi+1xDp6ib1K6os4OG2tK5EZCZ532cLliy3iL4HAgpQzfkTA
        ==
X-ME-Sender: <xms:x8zaYcCdx5UgTs6OFfyeeeoi5AkYRKhSHFKj2xlugvIYl5neblRoNw>
    <xme:x8zaYejGrlKy3VXkVsRn_X58ZvpsBHWsOK9FlA-zH0F8xYkZMUSm-ALRbjA0-PalB
    1csmEVubYewH5qHBls>
X-ME-Received: <xmr:x8zaYfl4X8AhluB83_XoED7pE-NdvV0KtdFt8_v3DhMUFtOamJ9CoK3Zq1B0QlYz2RLY3YWh40vtpoTZWZOxLDDoW7qkQEhQoNc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudegkedgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofggtgfgsehtqhertd
    ertdejnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepffelvdegveefve
    efvddvffeiteefgfejveegieethfekgefhleeukefhjeehfffgnecuffhomhgrihhnpehl
    fihnrdhnvghtpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhm
    vg
X-ME-Proxy: <xmx:x8zaYSykxWcJvhg0bfPfxvRNcj5X7dRx9kUN5zsgI46LBnleWba3iw>
    <xmx:x8zaYRQzen3_pFvcRTFuNHhLhvGT3Jm6g9vfjzwPJdTlVfOMOL7c0Q>
    <xmx:x8zaYdZTQia_uBZpJ1nC8ORL9-_XJtmmIP4NUyK6daEmYIxkL2kDDw>
    <xmx:x8zaYe8nfOVZVYHNLtVr8_nCrELJoGO-Dc37vywpotav8I60IcQv-A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Jan 2022 06:53:36 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     dmitry.torokhov@gmail.com, rydberg@bitmath.org,
        andreas@kemnade.info, linus.walleij@linaro.org,
        alistair23@gmail.com, robh+dt@kernel.org,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v5 0/4] Add support for the Cypress cyttsp5
Date:   Sun,  9 Jan 2022 21:53:27 +1000
Message-Id: <20220109115331.388633-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series builds on top of [1] and adds support for the cyttsp5=0D
touchscreen controller for the reMarkable 2.=0D
=0D
I first tried to add an I2C HID device. Although the cyttsp5 has some HID=0D
looking aspects it is not HID compatible. Just in trying to probe the devic=
e=0D
I found:=0D
 - The HID descriptor has extra padding=0D
 - The HID descriptor sets the high bytes of the descriptor length=0D
 - The HID descriptor has extra unrecognised tags=0D
 - The HID reset command doesn't appear to work=0D
=0D
I don't think there is a way to use the I2C HID framework with the cyttsp5.=
=0D
For anyone interested you can see the work here [2]. In that branch though =
I=0D
can only obtain a HID descriptor, nothing else works without more core=0D
changes.=0D
=0D
So instead I rebased the series from [1]. Converted to the new yaml DTS=0D
documentation, added regulator support and fixed a x/y miscalculation bug.=
=0D
=0D
1: https://lwn.net/ml/linux-kernel/20180703094309.18514-1-mylene.josserand@=
bootlin.com/=0D
2: https://github.com/alistair23/linux/commits/rM2-mainline-cyttsp5-hid=0D
=0D
v5:=0D
 - Address review comments from v4=0D
=0D
Alistair Francis (2):=0D
  ARM: imx_v6_v7_defconfig: Enable the cyttsp5 touchscreen=0D
  ARM: dts: imx7d-remarkable2: Enable the cyttsp5=0D
=0D
Myl=C3=A8ne Josserand (2):=0D
  Input: Add driver for Cypress Generation 5 touchscreen=0D
  dt-bindings: input: Add Cypress TT2100 touchscreen controller=0D
=0D
 .../input/touchscreen/cypress,tt21000.yaml    |  92 ++=0D
 arch/arm/boot/dts/imx7d-remarkable2.dts       |  89 ++=0D
 arch/arm/configs/imx_v6_v7_defconfig          |   1 +=0D
 drivers/input/touchscreen/Kconfig             |  16 +=0D
 drivers/input/touchscreen/Makefile            |   1 +=0D
 drivers/input/touchscreen/cyttsp5.c           | 902 ++++++++++++++++++=0D
 6 files changed, 1101 insertions(+)=0D
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cyp=
ress,tt21000.yaml=0D
 create mode 100644 drivers/input/touchscreen/cyttsp5.c=0D
=0D
-- =0D
2.31.1=0D
=0D
