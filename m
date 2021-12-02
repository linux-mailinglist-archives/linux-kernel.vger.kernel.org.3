Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7AA4662E4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357481AbhLBMAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 07:00:02 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:44259 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346631AbhLBL7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:59:53 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id A5AF8580270;
        Thu,  2 Dec 2021 06:56:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 02 Dec 2021 06:56:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:content-type:mime-version
        :content-transfer-encoding; s=fm2; bh=b0tdTiDj0xDYlY8hlxr76FNmq2
        CIwDq3lkmM++qy+nA=; b=o4S+0op+dRVl4TvJOWGiPxvmODK1+oZS08mQpTsc6m
        TICFX5gJ1a1Rfnyev5TvsTeKw7FB8tjyFU3Iy0ghQXZQMDQJo7Qfw8VrdN/HtreU
        JWtbGEWVkZrYOmBUm+d3r/XrGettUELK/d45JW5Uvk60TF5IOf6nKpadMQQM35hl
        VnPhWZHBgg26eqNXblcWYp9iukTYzdkz8Tl1L1L5AAzFtIIVfVJd7XEjewU6KTUp
        EU91SXjo8A599vNGvsl8fMduwTXPpPmhlP+lRlpZiaXbr7bJuCIihMR+e+vEMSn3
        q+02RE8YxseLZ9mAyXkRer4wsETjUfZ4gIJK7OZTN99A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=b0tdTi
        Dj0xDYlY8hlxr76FNmq2CIwDq3lkmM++qy+nA=; b=WPcjOj2Z9ix0z/wRlJU7uF
        r43V91Ui959nb/AMWiwuW7PAdc8MEuqGvGI5h7vveiJBo1ATE3VL2kDO4CnpL/rn
        7gAvVcHQJsXaDhOYl3mognwezqLpRYv36cQLED4mCf+sy6FFixjC8D45yHmhkXzz
        AyBKe1AY9SXXMpxACRBdzv4F8gPFuiTfbZH75DUbcN/hBYle6+QiTDqqwRsPyLjN
        qLz2pAyqLWk3GsGbBvFQJXa3R/Sw7i+oDqm437xX0s6skr/fVHyUeE181cAK5TBL
        41bLPfKDt3cXIBnGodx5hZhmGDY8h5D8xZdm2P05jLfXW1MHsZoQn1xax7CD0y5Q
        ==
X-ME-Sender: <xms:brSoYRdDg5boS_wHBseUkUa-dE7ANADqMknG2_5qrk6_dT5htuiNrA>
    <xme:brSoYfNWVBcdcunS2XomTdkSF22pD60A9uwc2Zq_H6mSakFNJ1qBeThf5CDW965YQ
    7UeZF6mvwj2aejwPDk>
X-ME-Received: <xmr:brSoYaiva44lRIPD7RDBMuhlQVdMci8JKt20ePc6xYAnFrmZQKi38BJiKgF0fqmmCJTKt34NzJ5L5h72zTdNAdQTaX-vwiM9b_6pcvUBZ4e0uJE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieehgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffotggggfesthhqredtre
    dtjeenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhr
    segrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeehteefgfejueejtd
    egvdfggefhiefgheffvdffudevveetjeduhfdukeduteevjeenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsth
    grihhrvdefrdhmvg
X-ME-Proxy: <xmx:brSoYa8mbkc_tdJDB2PiZzuYA7tckv2Yn0shSsLxaV1naRjYaghxFQ>
    <xmx:brSoYdt2PwiuHQH-SBNGLiPYAx35r_AMtBmn0SUaYlPIglF13jJGVA>
    <xmx:brSoYZH5mIR5pH1pP1fsaRUZX11P2Y59pUOauBYR4UYSOE2A3V1ePw>
    <xmx:brSoYdHuhBkjmQHA1wczK5oBv0RO3ej5xkdz7x8ClRG-_bV629qeBA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Dec 2021 06:56:24 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     benjamin.tissoires@redhat.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, dmitry.torokhov@gmail.com
Cc:     Ping.Cheng@wacom.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, alistair23@gmail.com,
        tatsunosuke.tobita@wacom.com, linux-input@vger.kernel.org,
        Jason.Gerecke@wacom.com, linux-kernel@vger.kernel.org,
        jikos@kernel.org, martin.chen@wacom.com,
        devicetree@vger.kernel.org,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v15 0/3] Add Wacom I2C support to rM2
Date:   Thu,  2 Dec 2021 21:56:19 +1000
Message-Id: <20211202115622.40153-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Wacom I2C support for the reMarkable 2 eInk tablet using the=0D
generic I2C HID framework.=0D
=0D
Alistair Francis (3):=0D
  HID: quirks: Allow inverting the absolute X/Y values=0D
  HID: i2c-hid-of: Expose the touchscreen-inverted properties=0D
  ARM: dts: imx7d: remarkable2: add wacom digitizer device=0D
=0D
 .../bindings/input/hid-over-i2c.txt           |  2 +=0D
 arch/arm/boot/dts/imx7d-remarkable2.dts       | 59 +++++++++++++++++++=0D
 drivers/hid/hid-input.c                       |  6 ++=0D
 drivers/hid/i2c-hid/i2c-hid-acpi.c            |  2 +-=0D
 drivers/hid/i2c-hid/i2c-hid-core.c            |  4 +-=0D
 drivers/hid/i2c-hid/i2c-hid-of-goodix.c       |  2 +-=0D
 drivers/hid/i2c-hid/i2c-hid-of.c              | 11 +++-=0D
 drivers/hid/i2c-hid/i2c-hid.h                 |  2 +-=0D
 include/linux/hid.h                           |  2 +=0D
 9 files changed, 85 insertions(+), 5 deletions(-)=0D
=0D
-- =0D
2.31.1=0D
=0D
