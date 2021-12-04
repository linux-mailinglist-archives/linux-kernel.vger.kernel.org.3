Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA5246811C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 01:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383587AbhLDAWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 19:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383572AbhLDAWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 19:22:31 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A72C061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 16:18:55 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id j14so8506083uan.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 16:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nUnZRxTL6ognPaiE7BB97hG4ug8rkGAOljqHJFVZ5r4=;
        b=aQfwEJSLSdf67rkRPangsInyk0VPOSvzVsdYMS1VWq+PjubUwHEIw6nd8IFiYJg4Zp
         K3sxb+/aU9cS7nei/9iiWESXaKpF0U50RT36VnMmycHHhdwc2Yty9cFwbKE9CDuS2eaH
         We/6RIqJgf9BIjUrGYz3UvnYFuxokFY95KBcICPTw3EvUmje9CvgDGk1xiY3DbyTdBQW
         wiCU9yqXFO3a3poIA+tndxufY869OZl2qMrKq06nplWk3pLs3WKlLryyBFAl2n1ctI7G
         OLOWu6+XeLzDm8fsDsU4HCePkWReTxWUTw221/M0LqxELuhjPQPqpogVIIX8ds3rrrPr
         V4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nUnZRxTL6ognPaiE7BB97hG4ug8rkGAOljqHJFVZ5r4=;
        b=IQ5ZDX57dlTPgkAN8R8+reN6jWSfZmtcjIbquf4Uu9m3GmfhT65Jz6jtpb+ua8yh0w
         RKSaqFeTIg5fHYvZ2o7ZFe7opPjzN5MjiZnZmHneJYA2GB/d6fU4zy4STPmMJdW5ok66
         PNxOAZbEkRCz2hzNFhWb+m/AxByICtycJwYCNGMzsiIHEU8hECocKgNDu5fc7JMhV2ZH
         8SpRthwR3tEGYZLJkOcg1nWgERvarkEDjJsOBAeUWMhnZ6aE4Db98dZz83BVoEGwPkuj
         wJoOfA67HFjdkNkn2bEHO3radS228avmjRSjgD+JkhiVJUteOZ+cbHDvvz+NB9Fmor1i
         JokA==
X-Gm-Message-State: AOAM532y5KLE3pqlPvCJtYfFEIn58TrMT7n3BAwnlToMB16v4kOkhQkA
        UkJKxmEjz1nSEavEPzLhwNEGp0pnE8ekug0L1H229/LeX7ZVWcGx
X-Google-Smtp-Source: ABdhPJxv7l/eQFFci2XCPTiX4KBmCNHGcXRuO+2735BU5+2FzBKDMNBN2407vdfc2vhyk8/WVJO5qNG0YDPgo2FpdJM=
X-Received: by 2002:a05:6102:f10:: with SMTP id v16mr25678337vss.86.1638577134675;
 Fri, 03 Dec 2021 16:18:54 -0800 (PST)
MIME-Version: 1.0
References: <20211130111325.29328-1-semen.protsenko@linaro.org>
 <20211130111325.29328-2-semen.protsenko@linaro.org> <YaZ8BpUaaC+sJYqx@robh.at.kernel.org>
 <CAPLW+4kGGk+umKTVRPNM7R=GaUQa31Uid=K+9ofq8w2mqzGAEA@mail.gmail.com> <CAL_JsqLopqkOEWmnvMDWr2rBa5Dm3jf17soqVA=Jx5Hn9BDS_g@mail.gmail.com>
In-Reply-To: <CAL_JsqLopqkOEWmnvMDWr2rBa5Dm3jf17soqVA=Jx5Hn9BDS_g@mail.gmail.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Sat, 4 Dec 2021 02:18:42 +0200
Message-ID: <CAPLW+4=i0hncEjNAYTyGRxd7Y3peDEgMf-Kw8qGhMW-kpNVv2Q@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND 1/5] dt-bindings: soc: samsung: Add Exynos USI bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Dec 2021 at 22:40, Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Dec 3, 2021 at 1:36 PM Sam Protsenko <semen.protsenko@linaro.org> wrote:
> >
> > On Tue, 30 Nov 2021 at 21:31, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Tue, Nov 30, 2021 at 01:13:21PM +0200, Sam Protsenko wrote:
> > > > Add constants for choosing USIv2 configuration mode in device tree.
> > > > Those are further used in USI driver to figure out which value to write
> > > > into SW_CONF register. Also document USIv2 IP-core bindings.
> > > >
> > > > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > > > ---
> > > > Changes in v2:
> > > >   - Combined dt-bindings doc and dt-bindings header patches
> > > >   - Added i2c node to example in bindings doc
> > > >   - Added mentioning of shared internal circuits
> > > >   - Added USI_V2_NONE value to bindings header
> > > >
> > > >  .../bindings/soc/samsung/exynos-usi.yaml      | 135 ++++++++++++++++++
> > > >  include/dt-bindings/soc/samsung,exynos-usi.h  |  17 +++
> > > >  2 files changed, 152 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
> > > >  create mode 100644 include/dt-bindings/soc/samsung,exynos-usi.h
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml b/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
> > > > new file mode 100644
> > > > index 000000000000..a822bc62b3cd
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
> > > > @@ -0,0 +1,135 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/soc/samsung/exynos-usi.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Samsung's Exynos USI (Universal Serial Interface) binding
> > > > +
> > > > +maintainers:
> > > > +  - Sam Protsenko <semen.protsenko@linaro.org>
> > > > +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> > > > +
> > > > +description: |
> > > > +  USI IP-core provides selectable serial protocol (UART, SPI or High-Speed I2C).
> > > > +  USI shares almost all internal circuits within each protocol, so only one
> > > > +  protocol can be chosen at a time. USI is modeled as a node with zero or more
> > > > +  child nodes, each representing a serial sub-node device. The mode setting
> > > > +  selects which particular function will be used.
> > > > +
> > > > +  Refer to next bindings documentation for information on protocol subnodes that
> > > > +  can exist under USI node:
> > > > +
> > > > +  [1] Documentation/devicetree/bindings/serial/samsung_uart.yaml
> > > > +  [2] Documentation/devicetree/bindings/i2c/i2c-exynos5.txt
> > > > +  [3] Documentation/devicetree/bindings/spi/spi-samsung.txt
> > > > +
> > > > +properties:
> > > > +  $nodename:
> > > > +    pattern: "^usi@[0-9a-f]+$"
> > > > +
> > > > +  compatible:
> > > > +    const: samsung,exynos-usi-v2
> > >
> > > Use SoC based compatibles.
> > >
> >
> > In this particular case, I'd really prefer to have it like this. Most
> > likely we'll only have USIv1 and USIv1 in the end, and I think that
> > would be more clear to have USI version in compatible, rather than SoC
> > name. Please let me know if you have a strong opinion on this one --
> > if so I'll re-send.
>
> Fine if you have some evidence the ratio of versions to SoC are much
> more than 1:1 and the versions correspond to something (IOW, you
> aren't making them up).
>

Yes, it's documented in TRM for different SoCs (USI version 2), and
there are even dedicated registers where you can read the USI IP-core
version. Right now we only know about two USI versions: v1 and v2 (can
be found for example from different published Samsung downstream
kernels, and from TRMs). So the USI block is standardized and
versioned.

> We went down the version # path with QCom and in the end about every
> SoC had a different version.
>
> >
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  clocks:
> > > > +    items:
> > > > +      - description: Bus (APB) clock
> > > > +      - description: Operating clock for UART/SPI/I2C protocol
> > > > +
> > > > +  clock-names:
> > > > +    items:
> > > > +      - const: pclk
> > > > +      - const: ipclk
> > > > +
> > > > +  ranges: true
> > > > +
> > > > +  "#address-cells":
> > > > +    const: 1
> > > > +
> > > > +  "#size-cells":
> > > > +    const: 1
> > > > +
> > > > +  samsung,sysreg:
> > > > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > > > +    description:
> > > > +      Should be phandle/offset pair. The phandle to System Register syscon node
> > > > +      (for the same domain where this USI controller resides) and the offset
> > > > +      of SW_CONF register for this USI controller.
> > > > +
> > > > +  samsung,mode:
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > +    description:
> > > > +      Selects USI function (which serial protocol to use). Refer to
> > > > +      <include/dt-bindings/soc/samsung,exynos-usi.h> for valid USI mode values.
> > >
> > > This seems to be redundant. Just check which child is enabled.
> > >
> >
> > I think it's not that easy. Soon we'll have USIv1 support added, and
> > that has some weird configurations, like having dual I2C mode (two
> > child I2C nodes must be enabled) and UART+I2C mode, etc.
>
> So you are going to turn around and make this an array? If you already
> know you have changes, I'd rather review this all at once.
>

No, I'd imagine that would be just a bunch of new dt-bindings
constants, for USI_V1. For example, for USI_V2 you already can see
these:

    #define USI_V2_NONE        0
    #define USI_V2_UART        1
    #define USI_V2_SPI        2
    #define USI_V2_I2C        3

and for USI_V1 it would probably be something like this, judging from [1]:

    #define USI_V1_NONE        4
    #define USI_V1_I2C0  5
    #define USI_V1_I2C1  6
    #define USI_V1_I2C0_I2C1_DUAL  7
    #define USI_V1_SPI  8
    #define USI_V1_UART  9
    #define USI_V1_UART_I2C1_DUAL  10

Guess in that case parsing enabled nodes and figuring out which mode
we have, and which value should be written into SW_CONF -- might be
not trivial. Having explicit "mode" property simplifies things.

[1] https://github.com/ibanezbass/universal7885/blob/oneui/drivers/soc/samsung/usi.c

> > Looks like it
> > might take some not very elegant logic to figure out which exactly
> > mode value should be written in SW_CONF register in that way, it's
> > much easier to just specify mode in USI node. Also, that reflects
> > hardware better: we actually write that specified mode to SW_CONF
> > register.
>
> You just have to compare the child node names or compatibles.
>

For USIv1 that would allow for some invalid combinations (e.g.
UART+I2C1 is possible, but SPI+I2C1 can't be configured). Also, the
list of supported compatibles might grow in future, which will have us
constantly add the list to the driver. And node names might be not
valid (e.g. you can see @hsi2c names are used in some dts's instead of
@i2c; also downstream kernels might have all kinds of names -- not a
strong point, but still).

Anyway, it can be implemented, and maybe I'm a bit biased here; so if
I still didn't convince you that benefits of having "mode" property
outweigh the disadvantages, please let me know -- I can send it in
next submission.

> > Also, later we might want to be able to switch that mode via
> > SysFS, e.g. for testing purposes. Current design seems to be better
> > suited for some things like that.
>
> The binding should have no impact on that. If for testing, use debugfs.
>
> > Please let me know if you have a strong opinion on this one, or it's
> > ok to leave it as is.
> >
> > All other comments are addressed and will be present in v3. Thanks for
> > the review!
