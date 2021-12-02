Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614C646637F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 13:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357898AbhLBMYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 07:24:08 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:59649 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357932AbhLBMXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:23:51 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3E10558030B;
        Thu,  2 Dec 2021 07:20:28 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 02 Dec 2021 07:20:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=fm2; bh=nFpd1cboO2xZsxTL6uy9AKL5Uy
        6bj9BzOleJyoKqzCo=; b=x0Bb2FkWXHXVxFIephoeZcZ0kVvUq9EKv8PsZzqTKg
        37e9wYLc58oVY2mtNO/5JeVDzVvUatA+WLvBjJz2ZBskee+3fUNVl9bGAngspM1j
        e2CBN3RQQ7cFMU6dRtA0YDboW7lB2DPYWIjzWRI1upIHvBBA25Y68xQ4cJl0rsE5
        ALR0U9NVmx1q/ivoJwJI5rFWExFr7R0Q6ztEye3zKDKEXXibaQFH/UAqLpYJQ/p5
        kxLYh1NUXqit2LJQYIqmSMs4TARPnWjd6rv7PwOmWrPQR5lhlN5ASHFkt9i9TmBk
        rnFLNddLKbe/k+iS5wx8vMg96n5tj7kIAoujsNyGSlqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=nFpd1c
        boO2xZsxTL6uy9AKL5Uy6bj9BzOleJyoKqzCo=; b=Mk0lZ9Gd2+G4bm/d+6ZNsX
        uOySrk82VpgDxnrvN/XaTsLIKEWUkg6fSuaaLHmUP0UDzAGGZ6lIetrKjPRtLyPt
        xVW5MCB6W4BOLCYnYzQiJT6BG79wJberk1B34swKjN44ythE+ZXM3EzhZcP/Hdk4
        FwHPp9fiARCiHvQKecej96kJBqnJLBKcUvh0lH89OZwPkrNg1mzW8jUlEUI3dHqI
        B4OH+BDu+udBg8nJBm2Yjt4OsATm+682Aq8PDaiU4T1a19eeXgpRdTeP82+VhCZR
        XqIg07tg5wkIufUMZ5hYja81yYsa31+hVRp4GdqSY4hR8ztkM1TW9uBm/Gcg571w
        ==
X-ME-Sender: <xms:C7qoYSQ-HrvAr01oVa1MI7_RMWiOF_WDZVEXuV9Jsc9Kxvdae_Vd2w>
    <xme:C7qoYXzp2qAON01MUKDTY-A49jrA1GsNc7XFblC7Eq5XYobUYs9RZrXiol6UpTrqF
    v_wMEqZ-fv9GKeJXj0>
X-ME-Received: <xmr:C7qoYf0pq-ge-2T5ToqTAzc2DcVw849DUYdHA4qsYfCP6Vz0AJZsOuq6eZpVFUl_f7iMPi3ZcNlQAgrV-opeKMbJS8jLIQu0oVeecUACZiyDCkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieehgdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffogggtgfesthhqredtre
    dtjeenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhr
    segrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeffledvgeevfeevfe
    dvvdffieetfefgjeevgeeitefhkeeghfelueekhfejheffgfenucffohhmrghinheplhif
    nhdrnhgvthdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:C7qoYeCauTjP4KKLk-dHgq4TbcAJDGxZdBuXFKJxRf0cxnWO1CxSYw>
    <xmx:C7qoYbj17yrDk5tXvTc1R5CKwiAbnfgZD_pLNFOm4_5zMYfAfLj6jg>
    <xmx:C7qoYaqLdXUycdK5WB6b03iYUQ0m90lMSCsErG67W58VEbBgNKLVYw>
    <xmx:DLqoYaMz6yTuTXnilluy4VHZusqIxJOCNDIRWFImKNqJoGB-rQ0CdQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Dec 2021 07:20:23 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, andreas@kemnade.info, alistair23@gmail.com,
        dmitry.torokhov@gmail.com, linus.walleij@linaro.org,
        rydberg@bitmath.org, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v3 0/4] Add support for the Cypress cyttsp5
Date:   Thu,  2 Dec 2021 22:20:17 +1000
Message-Id: <20211202122021.43124-1-alistair@alistair23.me>
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
Alistair Francis (2):=0D
  ARM: imx_v6_v7_defconfig: Enable the cyttsp5 touchscreen=0D
  ARM: dts: imx7d: remarkable2: Enable the cyttsp5=0D
=0D
Myl=C3=A8ne Josserand (2):=0D
  Input: Add driver for Cypress Generation 5 touchscreen=0D
  Documentation: DT: bindings: input: Add documentation for cyttsp5=0D
=0D
 .../input/touchscreen/cypress,tt21000.yaml    |   92 ++=0D
 arch/arm/boot/dts/imx7d-remarkable2.dts       |   89 ++=0D
 arch/arm/configs/imx_v6_v7_defconfig          |    1 +=0D
 drivers/input/touchscreen/Kconfig             |   14 +=0D
 drivers/input/touchscreen/Makefile            |    1 +=0D
 drivers/input/touchscreen/cyttsp5.c           | 1002 +++++++++++++++++=0D
 6 files changed, 1199 insertions(+)=0D
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cyp=
ress,tt21000.yaml=0D
 create mode 100644 drivers/input/touchscreen/cyttsp5.c=0D
=0D
-- =0D
2.31.1=0D
=0D
