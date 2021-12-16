Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34C0477EA8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236820AbhLPVVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhLPVVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:21:31 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4D7C061574;
        Thu, 16 Dec 2021 13:21:31 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id z29so352605edl.7;
        Thu, 16 Dec 2021 13:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y4P5wy6iix7HfpBAPgE+l0TDwUWAk0zjGM03BbiTQsw=;
        b=P8Z7C13ZdPu+qAQpnBOAeCbP5gMwD7ydNMb9fH1tHtsh2kJc7ibH4bhB9n6SSttNEt
         vEEmkYmz1t6Wm9/57Wpyql1gY0lukX/tq7xgtngawV31lXiyIPiGdLlXzIBBpOnQ/pNU
         l8TY+90t1LjC9Ts43pf+0L3t6Cq68GW0mMKuPmHBlsyYPUEBjqZHsJ8O0Uy21wTlkTut
         DkYw3nq5oS+YsuqCdF7sZUGi6ZaY6WUqsUowfAES53fFq8ONWXmRQXBRmsakgmTB4xiK
         lcxLsvwMVZyq/6SKHFurTYHOEqmmqbVonYppG/FJLvW5oRfRzsPSbaJYXXnR9qD6yz3J
         794g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y4P5wy6iix7HfpBAPgE+l0TDwUWAk0zjGM03BbiTQsw=;
        b=eUhqwu1rTl4PJyJzE4EtPzn0XjC9MEvxJDbPGsxklM0fPTCaZdHBtUOHFGbHrHvV/F
         R0B74hI71eoWXQgYNWWoBRjaBHEidb2uxw40y7HCCynpx6AZh5p7Vav5JAviemta9poM
         3ToIuk1oYK0qf3MoauXlAkn5lMgAWjs6pNAnl3lsZg33BfNFKFvJK4g+cmN3mysw6+aM
         ycwU+Sa1CrciOs4hTpCJWORuPrju2b9VSiUwX2yj0D1G9yUGL1G7O5J5AdTs1YbY7JM7
         qyvN8D+Q0H40qGF3Iym2b2C8kIwc7NUuD+d+zKXwvKShBOpwm5Oksd1qSQaU47YMi0YG
         4B8w==
X-Gm-Message-State: AOAM530ZzSWUxP2ixQrv6fOaZkx9lOkIC0LykjR8Qla1RnVNv1MypA2T
        dOuhoWiwC+DyKMo8bvXULFfT/IvPxKqh8DSmZB8=
X-Google-Smtp-Source: ABdhPJwsfak5UbIcc8yFH8Rwdwqg3PnBpr0/RxL71FTeqrqpj/OhkfEuzEX2FvqtqvCKNpPM2N8yXgEq/ke4MwvehrM=
X-Received: by 2002:a17:906:6dce:: with SMTP id j14mr9377078ejt.305.1639689689489;
 Thu, 16 Dec 2021 13:21:29 -0800 (PST)
MIME-Version: 1.0
References: <20211216111256.2362683-1-aford173@gmail.com> <20211216111256.2362683-9-aford173@gmail.com>
 <YbuqpayfYVPp1dTe@robh.at.kernel.org>
In-Reply-To: <YbuqpayfYVPp1dTe@robh.at.kernel.org>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 16 Dec 2021 15:21:18 -0600
Message-ID: <CAHCN7xLGeu4=CwqCv8BBowuQQ5t9iFDQV0adPNmy9dufW8soAg@mail.gmail.com>
Subject: Re: [PATCH V2 08/10] dt-bindings: media: nxp,imx8mq-vpu: Add support
 for G1 and G2 on imx8mm
To:     Rob Herring <robh@kernel.org>
Cc:     linux-media <linux-media@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        "open list:HANTRO VPU CODEC DRIVER" 
        <linux-rockchip@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 3:07 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Dec 16, 2021 at 05:12:53AM -0600, Adam Ford wrote:
> > The i.MX8M mini appears to have a similar G1 and G2 decoder but the
> > post-procesing isn't present, so different compatible flags are requred.
>
> post-processing
>
> > Since all the other parameters are the same with imx8mq, just add
> > the new compatible flags to nxp,imx8mq-vpu.yaml.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > diff --git a/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml b/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
> > index c1e157251de7..b1f24c48c73b 100644
> > --- a/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
> > +++ b/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
> > @@ -5,7 +5,7 @@
> >  $id: "http://devicetree.org/schemas/media/nxp,imx8mq-vpu.yaml#"
> >  $schema: "http://devicetree.org/meta-schemas/core.yaml#"
> >
> > -title: Hantro G1/G2 VPU codecs implemented on i.MX8MQ SoCs
> > +title: Hantro G1/G2 VPU codecs implemented on i.MX8MQ/i.MX8MM SoCs
>
> Just 'i.MX8' so we don't have to change this everytime?

Are you OK with i.MX8M?  8MQ, 8MM, and 8MP all appear to have G1 and
G2 decoders.  The i.MX8 is different.
>
> >
> >  maintainers:
> >    - Philipp Zabel <p.zabel@pengutronix.de>
> > @@ -20,6 +20,8 @@ properties:
> >          deprecated: true
> >        - const: nxp,imx8mq-vpu-g1
> >        - const: nxp,imx8mq-vpu-g2
> > +      - const: nxp,imx8mm-vpu-g1
> > +      - const: nxp,imx8mm-vpu-g2
>
> Not compatible with the imx8mq variants?

No, the structures associated with these compatible flags telling the
driver what features are available have options for the post-processor
in the 8MQ which are not present in the 8MM.

>
> >
> >    reg:
> >      maxItems: 1
> > @@ -66,3 +68,27 @@ examples:
> >                  clocks = <&clk IMX8MQ_CLK_VPU_G2_ROOT>;
> >                  power-domains = <&vpu_blk_ctrl IMX8MQ_VPUBLK_PD_G2>;
> >          };
> > +  - |
> > +        #include <dt-bindings/clock/imx8mm-clock.h>
> > +        #include <dt-bindings/power/imx8mm-power.h>
> > +        #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +        vpu_g1: video-codec@38300000 {
> > +                compatible = "nxp,imx8mm-vpu-g1";
> > +                reg = <0x38300000 0x10000>;
> > +                interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> > +                clocks = <&clk IMX8MM_CLK_VPU_G1_ROOT>;
> > +                power-domains = <&vpu_blk_ctrl IMX8MM_VPUBLK_PD_G1>;
> > +        };
> > +  - |
> > +        #include <dt-bindings/clock/imx8mm-clock.h>
> > +        #include <dt-bindings/power/imx8mm-power.h>
> > +        #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +        vpu_g2: video-codec@38300000 {
> > +                compatible = "nxp,imx8mm-vpu-g2";
> > +                reg = <0x38310000 0x10000>;
> > +                interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> > +                clocks = <&clk IMX8MM_CLK_VPU_G2_ROOT>;
> > +                power-domains = <&vpu_blk_ctrl IMX8MM_VPUBLK_PD_G2>;
> > +        };
>
> No point in more examples just for a different compatible.

No problem.
>
> > --
> > 2.32.0
> >
> >
