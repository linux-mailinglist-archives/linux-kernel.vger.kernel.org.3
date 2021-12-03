Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E1C467EE6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 21:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383112AbhLCUoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 15:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245055AbhLCUoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 15:44:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661CEC061751;
        Fri,  3 Dec 2021 12:40:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E64FF62B8F;
        Fri,  3 Dec 2021 20:40:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538A6C53FAD;
        Fri,  3 Dec 2021 20:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638564052;
        bh=m/5PNs48MvJxvCWalvbPIW7VE7yADXqjdRwRebDhHmg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rXG5OVPOVOC/Y5koeJfN89aqKHZBfjlF8b1b1dJRqI5qnN0b7zUNyxxEXQEcFb8MP
         h8IKbnPKNW0LnLG2f7oZQ2NrC0DkK2OsNqce001oad5Z3P7hH5d6fiqIS2mQxgu7BM
         +k5P8IRZdhtOpblLS2Zh201IaaXoWvdtGZwuYULPuon2u6R6Kee/1MNnUU9LH+D0g9
         2EQoj+TJIVoMy5CX296EoGR/eXCem8Y6N6O5mUB2TcbphsjOXY77EQafnSZy/hNeK0
         B93y5lkwNmvog+A3lFURbCm6NELOH/+q/wWGCKPM+Ms91uuNhAKJ7ifOWkRqqlGlYd
         PVbvdiK+zXYtw==
Received: by mail-ed1-f48.google.com with SMTP id g14so15902622edb.8;
        Fri, 03 Dec 2021 12:40:52 -0800 (PST)
X-Gm-Message-State: AOAM532YwVUSNC/za+mTFJx9iEtcm+PmueR4MtMttXokCKipeameVXs+
        I+qMThwN4dpo4utG18sTLShjycC/vQXGW8y7VA==
X-Google-Smtp-Source: ABdhPJwSKh/+Zdzs0BqV3JsAvevaoPtzNtQ899Uf3tZORxb4AK5AJVjbsbNnwmQZIy2/s5EX16YVN77kD3Kpl8+dqgw=
X-Received: by 2002:a17:906:9941:: with SMTP id zm1mr25999001ejb.466.1638564050644;
 Fri, 03 Dec 2021 12:40:50 -0800 (PST)
MIME-Version: 1.0
References: <20211130111325.29328-1-semen.protsenko@linaro.org>
 <20211130111325.29328-2-semen.protsenko@linaro.org> <YaZ8BpUaaC+sJYqx@robh.at.kernel.org>
 <CAPLW+4kGGk+umKTVRPNM7R=GaUQa31Uid=K+9ofq8w2mqzGAEA@mail.gmail.com>
In-Reply-To: <CAPLW+4kGGk+umKTVRPNM7R=GaUQa31Uid=K+9ofq8w2mqzGAEA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 3 Dec 2021 14:40:33 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLopqkOEWmnvMDWr2rBa5Dm3jf17soqVA=Jx5Hn9BDS_g@mail.gmail.com>
Message-ID: <CAL_JsqLopqkOEWmnvMDWr2rBa5Dm3jf17soqVA=Jx5Hn9BDS_g@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND 1/5] dt-bindings: soc: samsung: Add Exynos USI bindings
To:     Sam Protsenko <semen.protsenko@linaro.org>
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

On Fri, Dec 3, 2021 at 1:36 PM Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> On Tue, 30 Nov 2021 at 21:31, Rob Herring <robh@kernel.org> wrote:
> >
> > On Tue, Nov 30, 2021 at 01:13:21PM +0200, Sam Protsenko wrote:
> > > Add constants for choosing USIv2 configuration mode in device tree.
> > > Those are further used in USI driver to figure out which value to write
> > > into SW_CONF register. Also document USIv2 IP-core bindings.
> > >
> > > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > > ---
> > > Changes in v2:
> > >   - Combined dt-bindings doc and dt-bindings header patches
> > >   - Added i2c node to example in bindings doc
> > >   - Added mentioning of shared internal circuits
> > >   - Added USI_V2_NONE value to bindings header
> > >
> > >  .../bindings/soc/samsung/exynos-usi.yaml      | 135 ++++++++++++++++++
> > >  include/dt-bindings/soc/samsung,exynos-usi.h  |  17 +++
> > >  2 files changed, 152 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
> > >  create mode 100644 include/dt-bindings/soc/samsung,exynos-usi.h
> > >
> > > diff --git a/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml b/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
> > > new file mode 100644
> > > index 000000000000..a822bc62b3cd
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
> > > @@ -0,0 +1,135 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/soc/samsung/exynos-usi.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Samsung's Exynos USI (Universal Serial Interface) binding
> > > +
> > > +maintainers:
> > > +  - Sam Protsenko <semen.protsenko@linaro.org>
> > > +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> > > +
> > > +description: |
> > > +  USI IP-core provides selectable serial protocol (UART, SPI or High-Speed I2C).
> > > +  USI shares almost all internal circuits within each protocol, so only one
> > > +  protocol can be chosen at a time. USI is modeled as a node with zero or more
> > > +  child nodes, each representing a serial sub-node device. The mode setting
> > > +  selects which particular function will be used.
> > > +
> > > +  Refer to next bindings documentation for information on protocol subnodes that
> > > +  can exist under USI node:
> > > +
> > > +  [1] Documentation/devicetree/bindings/serial/samsung_uart.yaml
> > > +  [2] Documentation/devicetree/bindings/i2c/i2c-exynos5.txt
> > > +  [3] Documentation/devicetree/bindings/spi/spi-samsung.txt
> > > +
> > > +properties:
> > > +  $nodename:
> > > +    pattern: "^usi@[0-9a-f]+$"
> > > +
> > > +  compatible:
> > > +    const: samsung,exynos-usi-v2
> >
> > Use SoC based compatibles.
> >
>
> In this particular case, I'd really prefer to have it like this. Most
> likely we'll only have USIv1 and USIv1 in the end, and I think that
> would be more clear to have USI version in compatible, rather than SoC
> name. Please let me know if you have a strong opinion on this one --
> if so I'll re-send.

Fine if you have some evidence the ratio of versions to SoC are much
more than 1:1 and the versions correspond to something (IOW, you
aren't making them up).

We went down the version # path with QCom and in the end about every
SoC had a different version.

>
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    items:
> > > +      - description: Bus (APB) clock
> > > +      - description: Operating clock for UART/SPI/I2C protocol
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: pclk
> > > +      - const: ipclk
> > > +
> > > +  ranges: true
> > > +
> > > +  "#address-cells":
> > > +    const: 1
> > > +
> > > +  "#size-cells":
> > > +    const: 1
> > > +
> > > +  samsung,sysreg:
> > > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > > +    description:
> > > +      Should be phandle/offset pair. The phandle to System Register syscon node
> > > +      (for the same domain where this USI controller resides) and the offset
> > > +      of SW_CONF register for this USI controller.
> > > +
> > > +  samsung,mode:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description:
> > > +      Selects USI function (which serial protocol to use). Refer to
> > > +      <include/dt-bindings/soc/samsung,exynos-usi.h> for valid USI mode values.
> >
> > This seems to be redundant. Just check which child is enabled.
> >
>
> I think it's not that easy. Soon we'll have USIv1 support added, and
> that has some weird configurations, like having dual I2C mode (two
> child I2C nodes must be enabled) and UART+I2C mode, etc.

So you are going to turn around and make this an array? If you already
know you have changes, I'd rather review this all at once.

> Looks like it
> might take some not very elegant logic to figure out which exactly
> mode value should be written in SW_CONF register in that way, it's
> much easier to just specify mode in USI node. Also, that reflects
> hardware better: we actually write that specified mode to SW_CONF
> register.

You just have to compare the child node names or compatibles.

> Also, later we might want to be able to switch that mode via
> SysFS, e.g. for testing purposes. Current design seems to be better
> suited for some things like that.

The binding should have no impact on that. If for testing, use debugfs.

> Please let me know if you have a strong opinion on this one, or it's
> ok to leave it as is.
>
> All other comments are addressed and will be present in v3. Thanks for
> the review!
