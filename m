Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FF757869F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 17:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbiGRPpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 11:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbiGRPpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 11:45:06 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272161A3A9;
        Mon, 18 Jul 2022 08:45:05 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y4so15876908edc.4;
        Mon, 18 Jul 2022 08:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hLolbVXBEUER0UakSDpQJXv5E0rqxUG3yIyeZ9W9r5Q=;
        b=plCZGiMFOXCv6zf7OYDwt4JY6+RNFu4f0tICXtFHy4L6RWr1qZHBvsnnlKQYgQODET
         ITEZ59epuI4nQ3y+bLOIayxgNtwQl2iAdqukBlIyo2yHmz13QZW3NO7SxPgLo5x4AxsI
         BTIGnIv5f21FLrndblO5jJ+AItTpVe92SV6L+hdppWLgnE8lzMaMyczp58RPkUl1zvkw
         Z4H46610GhT7rdJLtNgV7lvqqsk9YzuQ3+Uhkgsglo/ABIvX/pcRmbCPQzVC3RsF04mY
         zdxlyB3dJwyWjeJH+dLJixWMq8USQ4PTiUB5r3qnerepJR077FYCJfcAUo8G8nQqRqN/
         ARvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hLolbVXBEUER0UakSDpQJXv5E0rqxUG3yIyeZ9W9r5Q=;
        b=Bt9hAYuyO15sa7xRBW/C9mNwlLNv0YqwaC8X5JmKSXahr7qCucT5bMtDSvw/V1KfO9
         hGUOp4TFVFJIpn205CzKY8sPkBCKBJPxx4szQP9rwlCCpHcR66nz3AzWHkSSWY6nBfFW
         2deu47tQduocxuCqP2+kzvkC0lcqfJzjDZFL9jzGBWc+ezradrQ+rn8l2lV2rSgEexKw
         zt49pmjGdasga+LbZpvZwEDXBE4k1oJEQoR4Bh2jlBlqcWLyMljzRYG1VBBMiWHItqIQ
         G0UKRnI6YWkGDyzuUsree2oixv5TRlP6/btpN7kx4uj84MaHC0g92IRGQLmB6cjz1r/x
         NrOw==
X-Gm-Message-State: AJIora+VbAlj+KffZAHZvIP+DMaNfYB9aZEAZT69r30YAZEHQXj9bd5x
        8PMNNN9dPftHyW+muXFGiT6cwT1S5LAEm6K935I=
X-Google-Smtp-Source: AGRyM1uKQNz+QND4OlGOIOojWTSJ/tbLxHrzijN9pwb5R19BT6Ju6GofoqpiNqfrXAwx/La0OGgbP/8aS6KNFi4gWOU=
X-Received: by 2002:a50:fa91:0:b0:43a:4f13:4767 with SMTP id
 w17-20020a50fa91000000b0043a4f134767mr38536703edr.10.1658159103494; Mon, 18
 Jul 2022 08:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220717181000.1186373-1-aford173@gmail.com> <20220717181000.1186373-5-aford173@gmail.com>
 <20220718053721.GB7333@pengutronix.de>
In-Reply-To: <20220718053721.GB7333@pengutronix.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 18 Jul 2022 10:44:52 -0500
Message-ID: <CAHCN7xLggy0YpimzMSxCSdfo5oEN9H55_+BZ6YXQREBYA+dgUA@mail.gmail.com>
Subject: Re: [PATCH 4/6] arm64: dts: imx8mm-beacon: Enable Digitial Microphone
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     arm-soc <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 12:37 AM Sascha Hauer <s.hauer@pengutronix.de> wrote:
>
> Hi Adam,
>
> On Sun, Jul 17, 2022 at 01:09:58PM -0500, Adam Ford wrote:
> > There is a PDM microphone port on the baseboard which is connected to the
> > micfil controller.  Create a new sound card to support this interface.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
> > index 03266bd90a06..16444954f873 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
> > @@ -98,7 +98,7 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
> >               enable-active-high;
> >       };
> >
> > -     sound {
> > +     sound-codec {
> >               compatible = "fsl,imx-audio-wm8962";
> >               model = "wm8962-audio";
> >               audio-cpu = <&sai3>;
> > @@ -111,6 +111,18 @@ sound {
> >                       "AMIC", "MICBIAS",
> >                       "IN3R", "AMIC";
> >       };
> > +
> > +     sound-micfil {
> > +             compatible = "fsl,imx-audio-card";
> > +             model = "imx-audio-micfil";
> > +             pri-dai-link {
> > +                     link-name = "micfil hifi";
> > +                     format = "i2s";
> > +                     cpu {
> > +                             sound-dai = <&micfil>;
> > +                     };
> > +             };
> > +     };
>
> Note the micfil works well with the simple-audio-card driver which might
> be an alternative here.

I'll respin it with that and try it.  If it works we should be able to
drop the last patch enabling the imx-audio-card module.

adam
>
> Sascha
>
> --
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
