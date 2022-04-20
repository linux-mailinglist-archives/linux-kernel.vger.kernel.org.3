Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326F85087EE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 14:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378439AbiDTMTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 08:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242236AbiDTMTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 08:19:13 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B048425284
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 05:16:26 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 23321FF805;
        Wed, 20 Apr 2022 12:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650456985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z6u55jL+XmZA+fHd05psyLDQ16L/uB8ALDHyFrbmkic=;
        b=aJkjaeqJFBhCS2FkHRCKWdLWfLlpTA4DxfP+ZF47mKkengFjj4PyzO/qrovv6sFgfsbDDJ
        ynMAI2a5RdfIQv8i8MNgAxwcbSrtg5V0WW6X8E0txevji75qDUZug8PAcwTCcGM/xIBg5L
        KsneZafPiuvbM1yGwWuEsECzQNCg9jrjJlq8SunHQIgTfaq6x+VsyaziI+wEV2jH+CVMDu
        Ya8Wel/qLkxBmnLtyMaxQ62hSKk5vz9v3y+zrAPZpnV+iYyOFMsNPYNyXXHV5qjH3YJiR5
        M/dmHwPBlQm7ANzENtulJFZ405nEg/VGVqUF7kQ5NAP5YZjsO39tL6uBJVdWVQ==
Date:   Wed, 20 Apr 2022 14:16:20 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Liang Yang <liang.yang@amlogic.com>
Cc:     <linux-mtd@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] dt-bindings: nand: meson: refine Amlogic NAND
 controller driver
Message-ID: <20220420141620.4fd68eef@xps13>
In-Reply-To: <b880c64c-7651-c445-4e5e-74cb7a1e76ee@amlogic.com>
References: <20220402074921.13316-1-liang.yang@amlogic.com>
        <20220402074921.13316-3-liang.yang@amlogic.com>
        <20220420094107.4799f15a@xps13>
        <b880c64c-7651-c445-4e5e-74cb7a1e76ee@amlogic.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liang,

> >> +maintainers:
> >> +  - liang.yang@amlogic.com
> >> +
> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - "amlogic,meson-gxl-nfc"
> >> +      - "amlogic,meson-axg-nfc"
> >> +
> >> +  reg:
> >> +    maxItems: 2
> >> +
> >> +  '#address-cells':
> >> +    const: 1 =20
> >=20
> > Not sure this property is needed. =20
> this is for the subnode, such as nand@0.

Yes but if you refer to nand-controller.yaml you no longer need these.

> >  =20
> >> +
> >> +  '#size-cells':
> >> +    const: 0 =20
> >=20
> > Ditto. Plus, this one looks wrong anyway. =20
> this is for the subnode, such as nand@0. do you mean s/''/""/?

Sorry, this is not "wrong anyway", my fault. But still, you don't need
this property for the same reason as above.

> >  =20
> >> +
> >> +  reg-names:
> >> +    items:
> >> +      - const: nfc
> >> +      - const: emmc =20
> >=20
> > Why do you need the emmc register map? Do you really need to perform a
> > register access there? =20
> yes, we have to access the emmc register map. because the NFC clock comes=
 from SDEMMC_CLOCK register.

But if it's a clock you should get the clock and call
clk_prepare_enable(), you don't need to poke directly in the registers.
Do you?

> >> +examples:
> >> +  - |
> >> +    #include <dt-bindings/clock/axg-clkc.h>
> >> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> >> +    apb {
> >> +      #address-cells =3D <2>;
> >> +      #size-cells =3D <2>; =20
> >=20
> > Not sure you need this upper node in the example. =20
> use the upper node to indicate the "#address-cells" and "#size-cells". if=
 i do not do that, dt_binding_check will report:
>   ".....reg:0: [0, 30720, 0, 256] is too long" and
>   ".....reg:1: [0, 28672, 0, 2048] is too long".

ok, maybe, I'll let bindings maintainer review that.

> >  =20
> >> +      nand-controller@7800 {
> >> +        #address-cells =3D <1>;
> >> +        #size-cells =3D <0>;
> >> +        compatible =3D "amlogic,meson-axg-nfc";
> >> +        reg =3D <0x0 0x7800 0x0 0x100>,
> >> +              <0x0 0x7000 0x0 0x800>;
> >> +        reg-names =3D "nfc", "emmc";
> >> +
> >> +        interrupts =3D <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>;
> >> +        clocks =3D <&clkc CLKID_SD_EMMC_C>,
> >> +                 <&clkc CLKID_FCLK_DIV2>;
> >> +        clock-names =3D "core", "device";
> >> +
> >> +      };
> >> +    };
> >> +... =20


Thanks,
Miqu=C3=A8l
