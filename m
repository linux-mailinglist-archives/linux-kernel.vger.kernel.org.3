Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05B2550E06
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238606AbiFTArj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238252AbiFTArW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:47:22 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EAA101EA;
        Sun, 19 Jun 2022 17:45:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EB8F4CE0F77;
        Mon, 20 Jun 2022 00:45:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EDD4C385A9;
        Mon, 20 Jun 2022 00:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655685930;
        bh=stXGpXrhG+pcsvrn9jWc5b3YRIiB1eD8e+G9Psfu5uE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Pmm/Mn4/NiOrzcuBUBrJ72ub/Ds+jDz4eZr100wX6UHVCybiODGDiwOm6muJadb37
         VWIp5TpH6LY5AXIU7LDidGD+J5YkLssdZF8PHfnx8KD/lYYAaZ+l/3ussQCaqIVgkQ
         fU59r8ua2WnqM02ZKumaFB2JbZG22jjWrl4tf0x0KggAIGpd56KrVJMUdXYIDhbqN5
         aKAIT42ZygJP8JOS5kRnyMxkNKQTur1OgRlgN5qTFlRxCwWhwXOoYW5UDsspAfcj9e
         aAVCaryAahbTeL0JuSbn9+/BZ/4Tc+3rpushFGh3JYa/MIvS9fILvq85t+uICLMRhc
         IS/pfOoUNtp/g==
Received: by mail-oi1-f176.google.com with SMTP id i25so11913536oii.7;
        Sun, 19 Jun 2022 17:45:30 -0700 (PDT)
X-Gm-Message-State: AJIora8LbLnmUOIrFNDG58P3UvkyQAfnyrV2cD8Y3DMWoYir/XH5SC5i
        SEw3UoVXb0sslR8aX+R1HBse+DRjIRt+v2nkbM8=
X-Google-Smtp-Source: AGRyM1sDy2BQMNR0JcbVKAovuXwDPbzX0sESO/cY+JWKd/6Y+ZG2lz+AsRKz+ffd0rgupJ+Ogra6T28eAowmIlnRpac=
X-Received: by 2002:a05:6808:3021:b0:2f7:4c5b:2783 with SMTP id
 ay33-20020a056808302100b002f74c5b2783mr10187952oib.53.1655685929270; Sun, 19
 Jun 2022 17:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <1655288134-14083-1-git-send-email-shengjiu.wang@nxp.com>
 <1655288134-14083-2-git-send-email-shengjiu.wang@nxp.com> <20220620004116.GP254723@dragon>
In-Reply-To: <20220620004116.GP254723@dragon>
From:   Shawn Guo <shawnguo@kernel.org>
Date:   Mon, 20 Jun 2022 08:45:18 +0800
X-Gmail-Original-Message-ID: <CAJBJ56Lop+_NxOWeQB7y6ODJe=-hV3pC1+M6JPr=9-kXSpGR+Q@mail.gmail.com>
Message-ID: <CAJBJ56Lop+_NxOWeQB7y6ODJe=-hV3pC1+M6JPr=9-kXSpGR+Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: imx8mm-evk: add bt-sco sound card support
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, shengjiu.wang@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 8:41 AM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Wed, Jun 15, 2022 at 06:15:32PM +0800, Shengjiu Wang wrote:
> > Add bt-sco sound card, which supports wb profile as default
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 43 +++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> > index c42b966f7a64..d99b562bb00e 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> > @@ -75,6 +75,11 @@
> >               linux,autosuspend-period = <125>;
> >       };
> >
> > +     bt_sco_codec: bt_sco_codec {
>
> Generic node name, maybe 'audio-codec'?

I see.  There is already an 'audio-codec' node for wm8524.  Maybe
'audio-codec-bt-sco'?  In any case, hyphen is more recommended than
underscore in node names.

Shawn

> > +             #sound-dai-cells = <1>;
> > +             compatible = "linux,bt-sco";
> > +     };
> > +
> >       wm8524: audio-codec {
> >               #sound-dai-cells = <0>;
> >               compatible = "wlf,wm8524";
> > @@ -107,6 +112,25 @@
> >                       clocks = <&clk IMX8MM_CLK_SAI3_ROOT>;
> >               };
> >       };
> > +
> > +     sound-bt-sco {
> > +             compatible = "simple-audio-card";
> > +             simple-audio-card,name = "bt-sco-audio";
> > +             simple-audio-card,format = "dsp_a";
> > +             simple-audio-card,bitclock-inversion;
> > +             simple-audio-card,frame-master = <&btcpu>;
> > +             simple-audio-card,bitclock-master = <&btcpu>;
> > +
> > +             btcpu: simple-audio-card,cpu {
> > +                     sound-dai = <&sai2>;
> > +                     dai-tdm-slot-num = <2>;
> > +                     dai-tdm-slot-width = <16>;
> > +             };
> > +
> > +             simple-audio-card,codec {
> > +                     sound-dai = <&bt_sco_codec 1>;
> > +             };
> > +     };
> >  };
> >
> >  &A53_0 {
> > @@ -346,6 +370,16 @@
> >       status = "okay";
> >  };
> >
> > +&sai2 {
> > +     #sound-dai-cells = <0>;
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&pinctrl_sai2>;
> > +     assigned-clocks = <&clk IMX8MM_CLK_SAI2>;
> > +     assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
> > +     assigned-clock-rates = <24576000>;
> > +     status = "okay";
> > +};
> > +
> >  &sai3 {
> >       pinctrl-names = "default";
> >       pinctrl-0 = <&pinctrl_sai3>;
> > @@ -494,6 +528,15 @@
> >               >;
> >       };
> >
> > +     pinctrl_sai2: sai2grp {
> > +             fsl,pins = <
> > +                     MX8MM_IOMUXC_SAI2_TXC_SAI2_TX_BCLK      0xd6
> > +                     MX8MM_IOMUXC_SAI2_TXFS_SAI2_TX_SYNC     0xd6
> > +                     MX8MM_IOMUXC_SAI2_TXD0_SAI2_TX_DATA0    0xd6
> > +                     MX8MM_IOMUXC_SAI2_RXD0_SAI2_RX_DATA0    0xd6
> > +             >;
> > +     };
> > +
> >       pinctrl_sai3: sai3grp {
> >               fsl,pins = <
> >                       MX8MM_IOMUXC_SAI3_TXFS_SAI3_TX_SYNC     0xd6
> > --
> > 2.17.1
> >
