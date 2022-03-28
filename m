Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5764E92B6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 12:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240346AbiC1Kt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 06:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236221AbiC1KtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 06:49:25 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382BE41315;
        Mon, 28 Mar 2022 03:47:44 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id p15so27747275ejc.7;
        Mon, 28 Mar 2022 03:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5MH++TcPuKhQzVkvXPAXpE2uJ7KTI2BReKPG/BP69Jc=;
        b=Ut8jMp9By1vnZGclTipmL/IpUc6eXLtRJsjiRQEg2X7rDFgJtwsqfDSoiCjdT4iq8q
         fo222b8zAHEaRvvvEU4Jo1TrX4zBQo7dV6vDfqPaff8EXeHBOUVZLA61XYxNjqfxIRPt
         JTkQl6OvVv9sb/nxNeV6chP5HXU2+4m8fCJx7iDiiYFGdQ+QfmRWvMDG8qknEqe2vxdP
         YTfl/NXZ2Y9Aiq2zeP6jN/w09SCmRODfl/B7NrrUsviGb6Tuw70tRDOQZ25NvuCbYM99
         NtsvY2KnBGXGdhGi1ZJbqv3dUe0XyBMK7V8umb6163ujfOWUWyqPwAWVGPps0x/2WJzF
         yj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5MH++TcPuKhQzVkvXPAXpE2uJ7KTI2BReKPG/BP69Jc=;
        b=K4yJhyLNaITG9EpLZMYiQ/W6t9JHwlp7L6ppPEGQVyvgvmAByBd5Dm92W8JdQaXbH+
         OAQK4/OnsfZEssC0NzTErHeRDghCSJ/gVu6WJsQJQqGH5OEBCB8CowO7VuqkIh9HdzkF
         F26k+RDNQuN1eujmtrpEbBv9T2o74vm+fjLxKc97lEJaX+eCQETiS525rCf4voB/I3zt
         sS7ECkjgjkixxh/kijnnGMJ7azaf7S7Wj2V9319Wkx0nRUOInuQJ1nRQo3cUMOx3yQec
         Qi1faJdomRRnvW8iXUFzVnBiZClPwtj+lSXvVCUUSetd+y9l7xANkuh900P5vYOSq16G
         3X9Q==
X-Gm-Message-State: AOAM530XlSG5xaQoVF3TpUWKhDSStVMGD1/y9Yl8QZBm9CPxiUhGBlbp
        p6g2nT5/1i4cbNF3PDv4F9q9zdaC40sWur85KT8=
X-Google-Smtp-Source: ABdhPJxg5fZXVMm1vCwl69+nB/6+LYAEtihlcCjnFTe7x9eRff6762Eb2TzI9/F/xVzn/m5PSCL/D++eiHpaH/STg6A=
X-Received: by 2002:a17:907:7ba3:b0:6df:b07c:ee35 with SMTP id
 ne35-20020a1709077ba300b006dfb07cee35mr26754289ejc.588.1648464462488; Mon, 28
 Mar 2022 03:47:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220327123835.28329-1-aford173@gmail.com> <20220327123835.28329-3-aford173@gmail.com>
 <c964bf2c-f7bf-451c-1691-02903f20c634@pengutronix.de>
In-Reply-To: <c964bf2c-f7bf-451c-1691-02903f20c634@pengutronix.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 28 Mar 2022 05:47:31 -0500
Message-ID: <CAHCN7xL05pBK0uK7zuE7Uq4P9Rzo6bHbJdbOt5XnQRB7Sh3msw@mail.gmail.com>
Subject: Re: [PATCH 3/5] arm64: dts: imx8mp: Enable HS400-ES
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 2:20 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> Hello Adam,
>
> On 27.03.22 14:38, Adam Ford wrote:
> > The SDHC controller in the imx8mp has the same controller
> > as the imx8mm which supports HS400-ES. Change the compatible
> > fallback to imx8mm to enable it.
>
> I believe that's a shortcoming of the Linux driver, which should explicitly list
> fsl,imx8mp-usdhc in its compatibles and enable HS400-ES for it.
>
> I find dropping compatibles problematic, because like Linux matching
> fsl,imx8mm-usdhc, but not fsl,imx8mp-usdhc, other software may match
> fsl,imx7d-usdhc, but not fsl,imx8[mp]-usdhc.
>
> I'd prefer that either the kernel driver gains extra compatibles or that
> the DTS lists extra compatibles and we refrain from dropping existing
> (correct) ones.
>

I would argue that imx7d is not correct since the IP blocks between
imx7d and imx8mm have different flags/quirks.  One of which includes
HS400-ES, but there are other differences as well.

> What do you think?

From my understanding of the fallback compatibility strings is to
avoid having to add more and more compatible strings to the drivers
when they do not serve a functional purpose. Based On a conversation
with Krzysztof [1], he suggested we update the YAML file based on the
fallback, but he wanted NXP to give their feedback as to what the
right fallback strings should be.  Haibo from NXP sent me a hierarchy
[1] which is what I used to update the YAML file.  Based on the YAML
file, the fallback in each DTSI file was updated to ensure the use of
the proper IP block.

adam

[1] - https://lore.kernel.org/linux-arm-kernel/CAHCN7xLWoUGi-jfxR2a0gvEFkPT3USUEb+8U3CCqCb5wWEJ8xw@mail.gmail.com/T/

>
> Cheers,
> Ahmad
>
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > index 794d75173cf5..d5ee1520f1fe 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > @@ -769,7 +769,7 @@ i2c6: i2c@30ae0000 {
> >                       };
> >
> >                       usdhc1: mmc@30b40000 {
> > -                             compatible = "fsl,imx8mp-usdhc", "fsl,imx7d-usdhc";
> > +                             compatible = "fsl,imx8mp-usdhc", "fsl,imx8mm-usdhc";
> >                               reg = <0x30b40000 0x10000>;
> >                               interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
> >                               clocks = <&clk IMX8MP_CLK_DUMMY>,
> > @@ -783,7 +783,7 @@ usdhc1: mmc@30b40000 {
> >                       };
> >
> >                       usdhc2: mmc@30b50000 {
> > -                             compatible = "fsl,imx8mp-usdhc", "fsl,imx7d-usdhc";
> > +                             compatible = "fsl,imx8mp-usdhc", "fsl,imx8mm-usdhc";
> >                               reg = <0x30b50000 0x10000>;
> >                               interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
> >                               clocks = <&clk IMX8MP_CLK_DUMMY>,
> > @@ -797,7 +797,7 @@ usdhc2: mmc@30b50000 {
> >                       };
> >
> >                       usdhc3: mmc@30b60000 {
> > -                             compatible = "fsl,imx8mp-usdhc", "fsl,imx7d-usdhc";
> > +                             compatible = "fsl,imx8mp-usdhc", "fsl,imx8mm-usdhc";
> >                               reg = <0x30b60000 0x10000>;
> >                               interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
> >                               clocks = <&clk IMX8MP_CLK_DUMMY>,
>
>
> --
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
