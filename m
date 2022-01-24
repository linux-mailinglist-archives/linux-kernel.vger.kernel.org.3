Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 947C4497E93
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238346AbiAXMKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:10:32 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:42947 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238323AbiAXMKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:10:18 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1381C580355;
        Mon, 24 Jan 2022 07:10:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 24 Jan 2022 07:10:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm3; bh=yDDZWE4He/pimUZxCO0Sh7kk8bh3iF
        5Bhx4IEsrP9p4=; b=fwxpbuyxqtScSM0n3F92+6NeWxGDQr6YYMqtldw5D3Pl0w
        89qffJRwxvyMzBg5ke6MK2hVAJyyyHr5DQUUx/IStis4XFk0gkikurX8OrV+KFWc
        r5o5MhfdXpHhteXf/bMyUv0WNGroUvmWsDBg8qv3VKHYl3OS8dHHLh4lj0a+88HO
        yvaca0Kz+bUpH+jg+beKOqefBph5neGOV/KltgW9EWZXBUmt1TocsGD7yKI2cJWq
        EUcpTLi5YRz7DqXr2cnIfXDJKARbXhyU1VK+f7BIDOHJBFEgd2GQP5+oO1Ovubar
        RGdwGG0wRX0zOphBC71wlFqPJ6F6KBcW5A45BB/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=yDDZWE
        4He/pimUZxCO0Sh7kk8bh3iF5Bhx4IEsrP9p4=; b=kjxqvDeGS98uzkQCCZmu+w
        c5TqmMYwe+zhOzzq8xu0nmTLtWGkOZmhGa/jXdZNwZAxVKsNlctq8plk53yyc+PL
        ANwMxsTGFU90E2ay0N1kc8aCuZ/6ONtI0DNDuhWrtAatFWVwwz2gp+5snRvOKxaB
        BNBofqBbFUos089YpZYfN7cu1+oWwlUScCyCOHY/Ar3QECXYNhPIii3P4Y28KlY0
        g3QPkJzJ6vJBRSJPONIpJ5HpQff7ySUT35MyClg1o9JhovOj+4dR2PBUmqGEvNTJ
        iHXPBHKGxZXVIXHksJwyjvOZ8B+Kc9V0fQjkELCryMV2PDdhbFzPFH83Zo0561bg
        ==
X-ME-Sender: <xms:KZfuYTktgWwmvWVS94IjUqVu0EVkhIROgzFcASUjADkunOrLjnwfYA>
    <xme:KZfuYW2TI6jUvYrIDj9a4BK6acgwpUHVUVFgBZ9szuCMAsqhHEZ-mzLzLjmTQsoV0
    rOLK1_Vp9s1vp2lW7I>
X-ME-Received: <xmr:KZfuYZoLdvNi-PPRbv-V-4rYYqL-0jisX-SQZDoTH2q7BNMda-F_wMKsmU_dCOKAc1PujXPVosSKTTYNg7G2uj3OG4NvsG6mG530KOJr5XfC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrvdeigdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffotggggfesthhqredtre
    dtjeenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhr
    segrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeehteefgfejueejtd
    egvdfggefhiefgheffvdffudevveetjeduhfdukeduteevjeenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsth
    grihhrvdefrdhmvg
X-ME-Proxy: <xmx:KZfuYbm4ijr_kGUpK3hJo7S7eACDvVOYpnO9RIk4VX-tjvMJiHWBzw>
    <xmx:KZfuYR2h1oPS1S3IQwoEfUcl6DJwE1odkMxhI1419aGLIFtIjnv-7A>
    <xmx:KZfuYatDxSRrkE2MmZA-o4gMHB0ylT8LEIsnkEx8Q7Z5PgOV2gvw4A>
    <xmx:KpfuYSHrj8adsEToquzJvAdzuYD1geMjg3C3aCa6Xq-aRmgTlAwNYA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Jan 2022 07:10:12 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     broonie@kernel.org, robh+dt@kernel.org, kernel@pengutronix.de,
        lgirdwood@gmail.com, lee.jones@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-imx@nxp.com, rui.zhang@intel.com,
        alistair23@gmail.com, amitk@kernel.org,
        linux-arm-kernel@lists.infradead.org, andreas@kemnade.info,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v18 0/8] Add support for the silergy,sy7636a
Date:   Mon, 24 Jan 2022 22:10:01 +1000
Message-Id: <20220124121009.108649-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v18:=0D
 - Rebase=0D
v17:=0D
 - Rebase and fix build issues=0D
v16:=0D
 - Improve vdd regulator comments=0D
v15:=0D
 - Address comments on the patches=0D
v14:=0D
 - Merge the thermal driver and hwmon=0D
v13:=0D
 - Address comments on thermal driver=0D
 - Rebase on master (without other patches)=0D
v12:=0D
 - Rebase=0D
v11:=0D
 - Address comments on hwmon=0D
 - Improve "mfd: simple-mfd-i2c: Add a Kconfig name" commit message=0D
v10:=0D
 - Use dev_get_regmap() instead of dev_get_drvdata()=0D
v9:=0D
 - Convert to use the simple-mfd-i2c instead=0D
=0D
Alistair Francis (8):=0D
  dt-bindings: mfd: Initial commit of silergy,sy7636a.yaml=0D
  mfd: simple-mfd-i2c: Add a Kconfig name=0D
  mfd: simple-mfd-i2c: Enable support for the silergy,sy7636a=0D
  regulator: sy7636a: Remove requirement on sy7636a mfd=0D
  hwmon: sy7636a: Add temperature driver for sy7636a=0D
  ARM: imx_v6_v7_defconfig: Enable silergy,sy7636a=0D
  ARM: dts: imx7d-remarkable2: Enable silergy,sy7636a=0D
  ARM: dts: imx7d-remarkable2: Enable lcdif=0D
=0D
 .../bindings/mfd/silergy,sy7636a.yaml         |  82 +++++++++++=0D
 Documentation/hwmon/index.rst                 |   1 +=0D
 Documentation/hwmon/sy7636a-hwmon.rst         |  26 ++++=0D
 arch/arm/boot/dts/imx7d-remarkable2.dts       | 136 ++++++++++++++++++=0D
 arch/arm/configs/imx_v6_v7_defconfig          |   3 +=0D
 drivers/hwmon/Kconfig                         |   9 ++=0D
 drivers/hwmon/Makefile                        |   1 +=0D
 drivers/hwmon/sy7636a-hwmon.c                 | 106 ++++++++++++++=0D
 drivers/mfd/Kconfig                           |   2 +-=0D
 drivers/mfd/simple-mfd-i2c.c                  |  11 ++=0D
 drivers/regulator/Kconfig                     |   1 -=0D
 drivers/regulator/sy7636a-regulator.c         |   7 +-=0D
 include/linux/mfd/sy7636a.h                   |  34 +++++=0D
 13 files changed, 415 insertions(+), 4 deletions(-)=0D
 create mode 100644 Documentation/devicetree/bindings/mfd/silergy,sy7636a.y=
aml=0D
 create mode 100644 Documentation/hwmon/sy7636a-hwmon.rst=0D
 create mode 100644 drivers/hwmon/sy7636a-hwmon.c=0D
 create mode 100644 include/linux/mfd/sy7636a.h=0D
=0D
-- =0D
2.31.1=0D
=0D
