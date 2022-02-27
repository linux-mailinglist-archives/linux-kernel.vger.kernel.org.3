Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B214C5B20
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 13:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiB0Mlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 07:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiB0Mlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 07:41:36 -0500
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8224F6D1BF;
        Sun, 27 Feb 2022 04:40:58 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id ADC0758021F;
        Sun, 27 Feb 2022 07:33:25 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 27 Feb 2022 07:33:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm3; bh=/kCjBnTIBOFAiyVIH+6Uk+1WkWlvNy
        6m+zGJBls4XE8=; b=Cq00KLQCk8QZ8IxE3iWtXMZUAIJTRHqyxQuE/fYv/GYmJm
        WskZ+L0xANMxSMmlrrnpKPlw2xYmlGKrql6EZr6Yz9eqXmBwzF5SFEOMZyf+lzQT
        RT2WRYIcYMdiZY45diuV4+Rt9Y+ATg4oHla+tFjZhJ1C1aMQQR1n4ClCnUt1TtED
        f7ukk58oz8X+2qKXwom4JA9mdv2mTsQ0Blv7m94k8qgluYliGWv7iObv2MVawzIu
        Bg67ugj7nuFPuxLj5JyGC7guJaM/vgI5DrSbIaq3Y3SK8xQdG4+UF5YJ6sjtXNis
        KQiUxdFocFpCXGzts8Aa1BC74BJC63z2kuSj2mBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=/kCjBn
        TIBOFAiyVIH+6Uk+1WkWlvNy6m+zGJBls4XE8=; b=mfDtmLnLOo2ISlqi4qxL/s
        MCvs8B+2PbD3FBhSzD+ftJvC6pN3fsOZRSrL5yumhpMrZj0MRFpvTzR2xkEqxffs
        0/WkIv/KnZoBz4W0qcLYHiy13b45DthLcHza/C56aHQ43IF2qS0d/P2OZrKBYFjH
        mwzw+S5N6yAht/05ZBmyYZAsSLurbJnkOoxXRbUp5DXzRkjgaDzApJNp/xf1Gesg
        /oS9HM8vKH0sFDuQZxzxHqHKtFC/1yQfsS+0oIVYrF7ogX5wFPT4JJ+BAqwEx6oM
        4g2BvdxMbAGcu68MN0w8HVcKZ7YqDfpr7nFTCXSyUf63smtYd0K0/JZMozu/dSbA
        ==
X-ME-Sender: <xms:lW8bYip4kDpaaaibHQat4iFD3q49XhLwjSX5CVzJRDJPw6KAw5BPvw>
    <xme:lW8bYgoCJzZQlXDyD7eUI4EWYteL68jIdPxBZYzdRy2CL0ql5vzC1L7G36EifC_8Y
    N6EYYUoRX6nqo7j-wk>
X-ME-Received: <xmr:lW8bYnMyCZ98I35V542yb4KrDLYLPJrQp30EILz3b0BAgSwR_atUpfG-REsmI34AXfLPl4Ofup8_Rw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrleekgdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffogggtgfesthhqredtre
    dtjeenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhr
    segrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeffledvgeevfeevfe
    dvvdffieetfefgjeevgeeitefhkeeghfelueekhfejheffgfenucffohhmrghinheplhif
    nhdrnhgvthdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:lW8bYh45JXu0wzQ1GWUF2-no0yYMRNQV_hUZYzN5sW1b0qd3SnuGcA>
    <xmx:lW8bYh4KFsg5tMSnMK52oVQ6Gr9yzDLatq97q2PLHkuIuitXHoG7Ig>
    <xmx:lW8bYhjfB9e6EokV-x8nuk_GFb6QvBBnVaDfWxC0BiBbXgvQooTp8Q>
    <xmx:lW8bYmHdks0Na9_joj3hCN9H7Q84zdu0Zpr536f0OVHNLDinZ_UGFA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Feb 2022 07:33:20 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org
Cc:     robh+dt@kernel.org, linus.walleij@linaro.org, rydberg@bitmath.org,
        dmitry.torokhov@gmail.com, andreas@kemnade.info,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v6 0/4] Add support for the Cypress cyttsp5
Date:   Sun, 27 Feb 2022 22:33:14 +1000
Message-Id: <20220227123318.313009-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
v6:=0D
 - Use reg for the button properties=0D
v5:=0D
 - Address review comments from v4=0D
=0D
Alistair Francis (4):=0D
  Input: Add driver for Cypress Generation 5 touchscreen=0D
  dt-bindings: input: Add Cypress TT2100 touchscreen controller=0D
  ARM: imx_v6_v7_defconfig: Enable the cyttsp5 touchscreen=0D
  ARM: dts: imx7d-remarkable2: Enable the cyttsp5=0D
=0D
 .../input/touchscreen/cypress,tt21000.yaml    |  98 ++=0D
 arch/arm/boot/dts/imx7d-remarkable2.dts       |  97 ++=0D
 arch/arm/configs/imx_v6_v7_defconfig          |   1 +=0D
 drivers/input/touchscreen/Kconfig             |  16 +=0D
 drivers/input/touchscreen/Makefile            |   1 +=0D
 drivers/input/touchscreen/cyttsp5.c           | 902 ++++++++++++++++++=0D
 6 files changed, 1115 insertions(+)=0D
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cyp=
ress,tt21000.yaml=0D
 create mode 100644 drivers/input/touchscreen/cyttsp5.c=0D
=0D
-- =0D
2.34.1=0D
=0D
