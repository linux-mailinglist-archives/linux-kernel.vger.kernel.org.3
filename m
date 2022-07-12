Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FFB572725
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 22:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbiGLUYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 16:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiGLUYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 16:24:06 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A6A65D74
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 13:24:05 -0700 (PDT)
Date:   Tue, 12 Jul 2022 20:23:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=protonmail3; t=1657657442; x=1657916642;
        bh=rebvC5es0dSrm6Px2PO3TCsJXa/dbGawM5FE6gHVAPU=;
        h=Date:To:From:Reply-To:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=nNg5GukHWooN9FXaY1rFhYWswobUla04P59ptfNxKKKyKx9qjeSmS14hW69jf2PtC
         oNi6FLpOUCXn0KUDVFKxl+kmUqMYtZ4fdj5uyDig7HUmFGefPqaC6NyrKFHdflbeqh
         nCKJtBgZ4XKxc62MgLbcPTGxsE+izVkcK7+80BhgiBhDX/+5OccGU56MEe+xA1355g
         7n0RWasja1mVTnVszqEPIyCSxUpF3cnyY3GELfqZmL5GRs/6Cjk/lNpWErme1PXX/s
         /njHrxmuPCHdS1SeswoKHh9GZ+/G03sJTUooY6h2RIfA9KXbxA6lYOQLz9RKWNkfV8
         arUGg5rOP5laA==
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?utf-8?Q?Tam=C3=A1s_Sz=C5=B1cs?= <tszucs@protonmail.ch>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   =?utf-8?Q?Tam=C3=A1s_Sz=C5=B1cs?= <tszucs@protonmail.ch>
Reply-To: =?utf-8?Q?Tam=C3=A1s_Sz=C5=B1cs?= <tszucs@protonmail.ch>
Subject: [PATCH 2/2] arm64: dts: imx8qm-mek: add usdhc pinctrl states to enable higher data rates
Message-ID: <20220712202211.8592-2-tszucs@protonmail.ch>
In-Reply-To: <20220712202211.8592-1-tszucs@protonmail.ch>
References: <20220712202211.8592-1-tszucs@protonmail.ch>
Feedback-ID: 53029:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl states 'state_100mhz' and 'state_200mhz' to usdhc1 and usdhc2 t=
o
enable higher data rates for eMMC and SD.

Signed-off-by: Tam=C3=A1s Sz=C5=B1cs <tszucs@protonmail.ch>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot=
/dts/freescale/imx8qm-mek.dts
index 19b60efe3639..5d4683173c30 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -68,8 +68,10 @@ ethphy1: ethernet-phy@1 {
 };

 &usdhc1 {
-=09pinctrl-names =3D "default";
+=09pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
 =09pinctrl-0 =3D <&pinctrl_usdhc1>;
+=09pinctrl-1 =3D <&pinctrl_usdhc1>;
+=09pinctrl-2 =3D <&pinctrl_usdhc1>;
 =09bus-width =3D <8>;
 =09no-sd;
 =09no-sdio;
@@ -78,8 +80,10 @@ &usdhc1 {
 };

 &usdhc2 {
-=09pinctrl-names =3D "default";
+=09pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
 =09pinctrl-0 =3D <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+=09pinctrl-1 =3D <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+=09pinctrl-2 =3D <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
 =09bus-width =3D <4>;
 =09vmmc-supply =3D <&reg_usdhc2_vmmc>;
 =09cd-gpios =3D <&lsio_gpio5 22 GPIO_ACTIVE_LOW>;
--
2.30.2


