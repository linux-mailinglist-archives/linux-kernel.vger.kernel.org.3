Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE5B4E51BA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 13:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244030AbiCWMCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 08:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235981AbiCWMB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 08:01:59 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8473075E48;
        Wed, 23 Mar 2022 05:00:30 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id E5A8C3200B25;
        Wed, 23 Mar 2022 08:00:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 23 Mar 2022 08:00:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=oPrRJr0au2XwO23A1HrZcbzNNDvN2/
        /w4Jho90lrt5k=; b=gKV2vvBbKK2CDXVZClM9sEyBTqMot0mnlvSvBmw/wtu+Jm
        GyATvZxRh04VKTVFjCyjKKwVnJfFttbn5avccW3clmlQBV5/UmeFmQobMIdpTziz
        m2ISablfOvsZ40L7YtNAhagIQnoBMv+RZ2vvuhNE6CS9uRHjtH1TnlyoF9tYmf1Z
        6ULpkPqo2QBvReSS908fs+AJqaeZJhsJdXrSeYMzUESLaimRleWHXJ0eAfuo4sjg
        rbiMLsbCXv+Vh3g8sJLTAw7TN2JdULdyHsxVxuQP8d+lBrA1pwQGWx7NjOvBykuz
        nbMYgLPmN3NvnYJEu84rypmWgPm+9/XBMtL1YXoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=oPrRJr
        0au2XwO23A1HrZcbzNNDvN2//w4Jho90lrt5k=; b=ZiWrVgPtA+2AZnoGCotgt9
        dUBM/fojGl5Iiv2uXDdPVXKd2UG1+BPVzF4mLG9e9DHIovMD6ovMZwJWyC2sf50t
        dvvbDsd/aPbPi76xQPExXNVxhHGtBWbJ6LtRFwdbYNfdkLv/d33QrZbJ8HMCjw/V
        rAMNQn+5IsXn/qNV/xSmjkYwLJ3OnZSktwSufhZutLf5DEtaMVtF2xNLr69pCFuk
        mGzxr7N7VCd9BXICnWKliEmAOXh4NbEyuNokw5oj5SGY+FHZdlDvL7pJhzLG20fY
        QpMIylKPGw0RIguRGQ4vCRZnr+4wfBr3paqfW8C1eNAac6WWvYDYtE7V8kEXXuwA
        ==
X-ME-Sender: <xms:2ws7YkpBZvlGzjWQeqlqMhl2VfNUiuz6ZIo_SmGNd_Y3oiDQC0Cfgg>
    <xme:2ws7YqpkYLNHqchKFB3e7OcJW_LNUNewLQFkcV2OvVrcD_vRtqN6sV3iiU6Bqz56b
    4BTvQ5sVnQqPa32Pco>
X-ME-Received: <xmr:2ws7YpPwkyq5WkPPJgPVx9GcecWg3ijjgxkibMaJe5mbUJ8D0gqv1p_wG-nfeH1bZ-dbytwGXsc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegjedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofggtgfgsehtqhertd
    ertdejnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepffelvdegveefve
    efvddvffeiteefgfejveegieethfekgefhleeukefhjeehfffgnecuffhomhgrihhnpehl
    fihnrdhnvghtpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhm
    vg
X-ME-Proxy: <xmx:2ws7Yr7siJF3ggT0w78a9p7tk3YRBRPcECqzCShJBtsBs2WZVOLRVw>
    <xmx:2ws7Yj5FazshV9-OGe0DhI5kKiICUtNpQ9CuNy9CfVbqChrJQxM7wQ>
    <xmx:2ws7YrjL8MaX1F-fYaEMx2bt1KHqxGSm5CFf1qvVe-YalV6gCwmakQ>
    <xmx:3As7YgG5yqjQ9-rTis_gwFqvb5GjuX5PceI1ywDoCxdvT_z9OZ-04g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Mar 2022 08:00:23 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     alistair23@gmail.com, rydberg@bitmath.org,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        dmitry.torokhov@gmail.com, andreas@kemnade.info,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v7 0/4] Add support for the Cypress cyttsp5
Date:   Wed, 23 Mar 2022 22:00:17 +1000
Message-Id: <20220323120021.361137-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
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
v7:=0D
 - Fix device tree warnings=0D
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
 .../input/touchscreen/cypress,tt21000.yaml    | 101 ++=0D
 arch/arm/boot/dts/imx7d-remarkable2.dts       | 100 ++=0D
 arch/arm/configs/imx_v6_v7_defconfig          |   1 +=0D
 drivers/input/touchscreen/Kconfig             |  16 +=0D
 drivers/input/touchscreen/Makefile            |   1 +=0D
 drivers/input/touchscreen/cyttsp5.c           | 902 ++++++++++++++++++=0D
 6 files changed, 1121 insertions(+)=0D
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cyp=
ress,tt21000.yaml=0D
 create mode 100644 drivers/input/touchscreen/cyttsp5.c=0D
=0D
-- =0D
2.35.1=0D
=0D
