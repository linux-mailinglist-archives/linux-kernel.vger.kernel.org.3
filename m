Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F584771A1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236278AbhLPMZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:25:37 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:47563 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234240AbhLPMZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:25:37 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 078255804DC;
        Thu, 16 Dec 2021 07:25:36 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 16 Dec 2021 07:25:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:content-type:mime-version
        :content-transfer-encoding; s=fm2; bh=TSgqps1iDUhbFhbJp7MGOAGo8m
        qIrmX1W/B+0CydO9Y=; b=0RyepsFVU2bY6Baev95I7Tvrq9ixoPqI/XERGWtUYq
        TfZII+f+2JoFTvR4pIwYM9ilB3cGjdWGv2Bv9Eg20R78+hi3aVG36BU1Q3MvQJEj
        9ayYdDbz/kniS6QjCFcPXSGp+ompTOf3KKaUpmQ8C4QPXoFn+uTLILmObS4tjA+T
        XFnRNCLxlZRhGc1Dp58hZMCDxhyQ4HYzTHdXxKy48cI6u/LOdbLQDl2IOCNBV88f
        3tCY971ic908P4ZZpMrV8g5X6U4gZQnctDu5QWU4JmB2Hhq33QSODNIAIU99Nzw8
        UxqeohKk6eCmTMwCNFJMBicKA4tLpeFe7ODG3PNd44Zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=TSgqps
        1iDUhbFhbJp7MGOAGo8mqIrmX1W/B+0CydO9Y=; b=T3WhLBxTOlHr1HPbwCy8dc
        SoYs5DWUoZtX5CcC4eZQkfIcVuRW0zMdDkbavVTI2WZFRMDwj1ivGIjOnrgQ6709
        6DeNTxPbwYNOky8QSH47OS2CaMmiYAn+CBnBX8jyBTVC7HzETljapGee40uiui9y
        Kic6b7OarK3wlHMFKi7ZExgryc+pF5gWpRCqbzF4/g4Jo81SW7VWjkZh2b4es8lq
        uDD5zVC6hjrz8bFfzxojGJ0bPpgDGc42bujvdnVeu2cHD4lPAGq94TcVzpqzp0K7
        f1p20DIBGf8kv6lyVcHEHZTnzeEztdw4gLxBVAdazq4L83SrhR1J28nsiXfjqDqA
        ==
X-ME-Sender: <xms:PzC7YcdGBg8qO-508admVP7vai__h-1IwJW7GqQcsfjSWTphvSDYVg>
    <xme:PzC7YeMIrSJTkd3c7IfpNMvchhEfjH6ya-Yz_CQn9Bv2GawVX-sv2mMSmTw4TK2PX
    -ifKm3qz1ErfwkG-To>
X-ME-Received: <xmr:PzC7YdgSTTzaCeomh0BhZ4zjC1zDpeJGtIDOJLzz1b07aJZBJ7BKWiMzm-74ihKbMi82-CFBwPyrmg9-vw09hx4GYgu67eZHaXYAZbPeTEGj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrleeggdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffotggggfesthhqredtre
    dtjeenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhr
    segrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeehteefgfejueejtd
    egvdfggefhiefgheffvdffudevveetjeduhfdukeduteevjeenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsth
    grihhrvdefrdhmvg
X-ME-Proxy: <xmx:PzC7YR-Cwt_ZpA2kSuvQHCRhBPYDqkqx0x_TD558lbdyA3JzPU72OQ>
    <xmx:PzC7YYsFkRl5QQ-iIWGoa-PFgnkopaMTmTWmQwEnvnWZISxrlarh0A>
    <xmx:PzC7YYHaxFSGt__pn4YOzA2JU19Om7Nl6EuICb2UzSBlktUU5KekOw>
    <xmx:PzC7YZ-XE996ln-ZB-ZZStuN6qAX0zJHNpHrZ12bepmVV1aSKaFo2w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Dec 2021 07:25:29 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     kernel@pengutronix.de, lgirdwood@gmail.com, robh+dt@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org
Cc:     linux-imx@nxp.com, devicetree@vger.kernel.org,
        s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        andreas@kemnade.info, linux-hwmon@vger.kernel.org,
        alistair23@gmail.com, amitk@kernel.org, shawnguo@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v17 0/8] Add support for the silergy,sy7636a
Date:   Thu, 16 Dec 2021 22:25:17 +1000
Message-Id: <20211216122525.136139-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
