Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7484EBDD2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244915AbiC3Jn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244898AbiC3JnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:43:22 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1C2265E96;
        Wed, 30 Mar 2022 02:41:37 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 90D1E5C0159;
        Wed, 30 Mar 2022 05:41:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 30 Mar 2022 05:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=Xqma4VmLIJGXDmH+JdobTx8XzROZ0i
        KirVagnNvxFNw=; b=VFbhlHH/uZRBf5//YkaJku0wlUezn1Ke0ulrK4wGmdoGly
        cKFbGsrn4/2XhKNXrMel0bzysPc3Q5jlRaDd8hmxfiwX2g48xDB2VoAAU5AHqgap
        mwJDnUeinUtwi37KBHpStSy3eflu43zIsxNt9KJi2gZvdpVoPwisKG9kUhLWFAgg
        eSbOJNBOqJg3SLTBWDTC5fhsQVqGwu6t+EZG8mzh9fKTem7rQcD28/N3RPUgLS87
        kpBYKSyXjVmOn8Mx842NO5QRU9Xmmz+vMU2Ah2uTJ3tVeH7N4MB3S8asBbTfiSLj
        gXT2kcmGomQsU51SlIkO9PLh0/V95MnJalBrlvhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Xqma4V
        mLIJGXDmH+JdobTx8XzROZ0iKirVagnNvxFNw=; b=NCqSl7dP1dOGefZpoQFvtH
        +8KiLcD1sqlo/zwdR+XSpz54UZQoJlYyiuG1z5tRapegdvjiiBUbDrMsJWpdvQsh
        LvgQSj5wKEINfI2eBx3Aw1U4gfe2+TaD7QanCz0jb1UhcebdakKpSYnIeg7S6LkS
        orb3c1F4TSQ4J5H8fF9MkgJPvSEFzTR82tdIZFZqKx3NYo44yCeHNevZQNDVVTGB
        9McaW1Y4RMYv0vrzczxafJ9VrEtjfxvmvw/BMH2y8aYTVjjAtFI5L21YF0WF0naa
        CG8CYrc738FeEIE/+RC5hK5T/mzhVPH1AzWnBoa60l4Q6cvr8qMuVB7IaZPB4ntQ
        ==
X-ME-Sender: <xms:0CVEYl1yAFG77CgWTBR846OJnQoI3jfqaGwLc7CUn3Ma120BsU1DRQ>
    <xme:0CVEYsFboj_h3E44SAmjYUUf_8yfPnWMYSrUEGU7IFpR0BYfZjq3YTHEsGZJA5K22
    5pxsZwv9-NSbnmD53c>
X-ME-Received: <xmr:0CVEYl7P3OEN_cW3BjVPjepaoiFNVxXm7fSw4z4wN7wSD3DBm3-JMhQe9eklhhuZdm6_oVlk9WQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeivddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgtggfgsehtqhertd
    ertdejnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepheetfefgjeeuje
    dtgedvgfeghfeigfehffdvffduveevteejudfhudekudetveejnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:0CVEYi0r3oDUs1S_1-Gdv_W5rcxZjlMB4XPCn5nuum_kFNKU2ZnZvg>
    <xmx:0CVEYoGUIokerDL639d4RmHrnClZEi5cRLZuUvk-WfXWzxEuBtHysQ>
    <xmx:0CVEYj-997oq45ngahrRIu8VXtm6tXm0g3iKDW3jk4sEcnR6HCXbTw>
    <xmx:0CVEYm-thA6MB0xnu8MgUy-DnhhoG3CGKLxo420J6pIrO23E5W3LrQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Mar 2022 05:41:29 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lgirdwood@gmail.com, robh+dt@kernel.org, kernel@pengutronix.de,
        lee.jones@linaro.org, broonie@kernel.org
Cc:     linux-hwmon@vger.kernel.org, geert@linux-m68k.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        alistair23@gmail.com, s.hauer@pengutronix.de, andreas@kemnade.info,
        linux@roeck-us.net, rui.zhang@intel.com,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        amitk@kernel.org, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v20 0/4] Add support for the silergy,sy7636a
Date:   Wed, 30 Mar 2022 19:41:22 +1000
Message-Id: <20220330094126.30252-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.35.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
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

v20:=0D
 - Rebase on master=0D
 - Remove merged patches=0D
 - Fixup Kconfig selection based on previous discussions=0D
v19:=0D
 - Rebase on linux-next=0D
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
Alistair Francis (4):=0D
  mfd: silergy,sy7636a: Add config option=0D
  ARM: imx_v6_v7_defconfig: Enable silergy,sy7636a=0D
  ARM: dts: imx7d-remarkable2: Enable silergy,sy7636a=0D
  ARM: dts: imx7d-remarkable2: Enable lcdif=0D
=0D
 arch/arm/boot/dts/imx7d-remarkable2.dts | 136 ++++++++++++++++++++++++=0D
 arch/arm/configs/imx_v6_v7_defconfig    |   3 +=0D
 drivers/hwmon/Kconfig                   |   1 +=0D
 drivers/mfd/Kconfig                     |  12 ++-=0D
 drivers/regulator/Kconfig               |   1 +=0D
 5 files changed, 152 insertions(+), 1 deletion(-)=0D
=0D
-- =0D
2.35.1=0D
=0D
