Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACF14C4D36
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 19:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbiBYSFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 13:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbiBYSFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 13:05:13 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9526B1E6E91;
        Fri, 25 Feb 2022 10:04:22 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id y189so7429840ybe.4;
        Fri, 25 Feb 2022 10:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KojlstE2lgoa7NRwY6/3wf4IDjFuyhSCMnLIbiB/VXw=;
        b=YsJOaByGxkVsWmlo3S060z6DNQE5Lpo0T52+WHe1QFVq1Np/PzH3I0i2xuV7aTMy/u
         Q1kmPlvlBiL69lnqJu3XUV9IHW/Y6GcTXKhgAM1qqT6wqsIj5rTBMmRmp21nuQFG5MpD
         iNDjQwEKh+b1yixh5b2jucpDw07D4LnYEuF4EtPK1iwjS7YEAgim+pnTWQT4rzvu5NL8
         bCGymTsqjS6dXsUCatOsKzhYDnZN9c/0eSSoQEMulK5c5H8EhwhsC1SKteesQcz9uWMN
         vazLu5uvqbP7OcmwtOu9xS+UARj3g9EIIvGU+mCXuoaLWkhMFQXOoBhGr1GnHmDWLZHl
         qXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KojlstE2lgoa7NRwY6/3wf4IDjFuyhSCMnLIbiB/VXw=;
        b=kQLUpWTLKrkj92oFTMuFEFdeISYTIlNu1Vl+XDDEPMoKHj6iJoRxeVig54iq9qM9Um
         5TxXq6CiFtL8mtPYs4B271rDpQj48wDVBIKxx5MsevNrmIiigVAwbKQfB77LfF7pPehK
         cdUDcPvCO83EG4SDyifZ8cBV9k/aI/LfVpLdXrPU7TYz7n9vjo12yfAZ7daclHSAh9d9
         DnpjD5pGqy/t5WTf10sIcsr68NbnDO1mRl2NSCo/Wb2JDSTQZCwQrDbIL1oPNhb1bGi9
         nfwD9j8yTs21gyemfRM/qZ6TfKOD9x1+sArdQJwjNTjjN8T2gpHfjtw5nOxD1Cu1XU5C
         qKMg==
X-Gm-Message-State: AOAM532kpGQmDYS8sGmBN4PX7m4FGBygpNbfHwLWI5f2k0wS4ynz9IHd
        MWj/HL4C3MofEHKwBdw0+9ApRfH7LzTqkF14Pck=
X-Google-Smtp-Source: ABdhPJyqs/M2Em3/HU+NEY5CE3n65PJxyF06pbxASaTFZx+ohua2HRsbXo6S+rdEcQ6h3e4hUCuCMghFj0B5Kj/71MA=
X-Received: by 2002:a25:5d0:0:b0:61d:932b:6fc0 with SMTP id
 199-20020a2505d0000000b0061d932b6fc0mr8506142ybf.585.1645812261673; Fri, 25
 Feb 2022 10:04:21 -0800 (PST)
MIME-Version: 1.0
References: <20220225145432.422130-1-pgwipeout@gmail.com> <20220225145432.422130-3-pgwipeout@gmail.com>
 <5cca79dc-619c-a162-e850-b3efd4dc746d@gmail.com>
In-Reply-To: <5cca79dc-619c-a162-e850-b3efd4dc746d@gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Fri, 25 Feb 2022 13:04:10 -0500
Message-ID: <CAMdYzYo81L5YnLr=whBbqde--e_DSuSwSPaXuDwtzeXN7pLMwQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/8] dt-bindings: usb: dwc3: add description for rk3568
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-usb@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Riesch <michael.riesch@wolfvision.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 11:07 AM Johan Jonker <jbx6244@gmail.com> wrote:
>
> Hi Peter,
>
> Lots of USB series all of a sudden.
> Combine possible?
>
> On 2/25/22 15:54, Peter Geis wrote:
> > The rk3568 dwc3 controllers are backwards compatible with the rk3399.
> > Add the device tree description for it.
> >
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
> > index 04077f2d7faf..e3044e81cc72 100644
> > --- a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
> > +++ b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
> > @@ -30,6 +30,7 @@ select:
> >          enum:
> >            - rockchip,rk3328-dwc3
> >            - rockchip,rk3399-dwc3
> > +          - rockchip,rk3568-dwc3
> >    required:
> >      - compatible
> >
> > @@ -39,6 +40,7 @@ properties:
> >        - enum:
> >            - rockchip,rk3328-dwc3
> >            - rockchip,rk3399-dwc3
> > +          - rockchip,rk3568-dwc3
> >        - const: snps,dwc3
> >
> >    reg:
> > @@ -75,7 +77,10 @@ properties:
> >      maxItems: 1
> >
> he
> >    reset-names:
> > -    const: usb3-otg
> > +    items:
> > +      - enum:
> > +          - usb3-otg
> > +          - usb3-host
>
> The use of reset-names is "sort of" only related to the rk3399 legacy
> node. Still using this sub node DT to not to break older existing boot
> loaders.
>
> https://github.com/torvalds/linux/search?q=usb3-otg
>
> It's only mentioned as comment in dwc3-of-simple.c but not used:
>
>         simple->resets = of_reset_control_array_get(np, false, true,
>                                                     true);
> core.c uses something similar.
>
>         dwc->reset = devm_reset_control_array_get_optional_shared(dev);
>         if (IS_ERR(dwc->reset))
>                 return PTR_ERR(dwc->reset);
>
>
> Up to the maintainers, but I wouldn't add another variant/name for the
> same thing as it also optional(= not required) and no longer needed.

I left these named separately since they are different reset signals,
but if it isn't an issue I don't mind having them both be usb3-otg.

>
> Johan
>
> ===
>
> Maybe drop PCLK_PIPE as well to reduce notifications.

I'll be conducting testing to determine if we need PCLK_PIPE here, and
as long as it isn't working simply because it's enabled by someone
else I'll drop it.
Ideally, it would be nice to have a proper clock map for these chips,
but currently that's not in the TRM.

>
> See example:
> https://lore.kernel.org/linux-rockchip/20220225131602.2283499-4-michael.riesch@wolfvision.net/T/#u
>
> >
> >  unevaluatedProperties: false
> >

Thanks for the review!
