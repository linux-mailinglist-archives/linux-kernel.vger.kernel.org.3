Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4339F48569B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 17:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241906AbiAEQYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 11:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiAEQYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 11:24:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97270C061245;
        Wed,  5 Jan 2022 08:24:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3719A61804;
        Wed,  5 Jan 2022 16:24:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9488CC36AEF;
        Wed,  5 Jan 2022 16:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641399846;
        bh=D0rtMVXuXMmUWBMa4J5OtDKJwvzjFcYkZkPaaIZc6mM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XXxEs+bvODAOdzI/uFkSnfQrBoH2EClb57Ao0xFI3dtfvKAEM3Z2X11qWdNn5VYr5
         +YbYcjVDB5pQuvYEN9mgDNc30c4pvWgHAAKM2NSJkbfxAdTXlj26MKXFYNHLQlZNDb
         7txpG9hDFQU3sB+QN8ls/pfSVeeUIrofA0V0r6yINi8ibhEUSdpqEeKC/Fqn9hhVYF
         3zRagylZF/bd865vYLIq/NM7km+dwB0sV5cZEkQj84Lu9pNb73T6Rze7Tkx5l2cyBF
         YKzCJi1E0iVlF8sMUsb57XuLrcQW0Xib59tetmhl32p2dJPM6BlB+Q9IFxqbg2CMTF
         HXQEGlofjSEKQ==
Received: by mail-ed1-f53.google.com with SMTP id k15so1149935edk.13;
        Wed, 05 Jan 2022 08:24:06 -0800 (PST)
X-Gm-Message-State: AOAM5324dNGYnxEWAr3okmEZgWzalOo9xE31d9eVzu1i4rxCrYmm15Uf
        lU/M+cN6bbBqk+4m4EGoVqTPSjrnchiMdQixwQ==
X-Google-Smtp-Source: ABdhPJz5VVwi03tRm0U13TScGgTT7GNYvhHXOBDK8IpQTLIsJYlrKfqJYWDuhEBYHgXnTXGmYNJNekP/aGrkJ6tqO6E=
X-Received: by 2002:a17:906:229b:: with SMTP id p27mr43028591eja.264.1641399844761;
 Wed, 05 Jan 2022 08:24:04 -0800 (PST)
MIME-Version: 1.0
References: <20210906102837.2190387-1-martin.kepplinger@puri.sm>
 <20210906102837.2190387-3-martin.kepplinger@puri.sm> <CAL_JsqJQAutUp9cB2LaoOQQX7mToCc5MkGm59oOmh65yZG0xZQ@mail.gmail.com>
In-Reply-To: <CAL_JsqJQAutUp9cB2LaoOQQX7mToCc5MkGm59oOmh65yZG0xZQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 5 Jan 2022 10:23:53 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKzaZC0A4OwnMyAuEWm2pCcHyQxHyrBVtkiPNUeMDd+oA@mail.gmail.com>
Message-ID: <CAL_JsqKzaZC0A4OwnMyAuEWm2pCcHyQxHyrBVtkiPNUeMDd+oA@mail.gmail.com>
Subject: Re: [PATCH v9 2/4] dt-bindings: media: document SK Hynix Hi-846 MIPI
 CSI-2 8M pixel sensor
To:     Martin Kepplinger <martin.kepplinger@puri.sm>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@iki.fi>, devicetree@vger.kernel.org,
        Purism Kernel Team <kernel@puri.sm>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        phone-devel@vger.kernel.org, Shawn Tu <shawnx.tu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 3, 2021 at 10:19 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Sep 6, 2021 at 5:29 AM Martin Kepplinger
> <martin.kepplinger@puri.sm> wrote:
> >
> > Document the bindings used for the SK Hynix Hi-846 CMOS camera driver.
> >
> > Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../bindings/media/i2c/hynix,hi846.yaml       | 120 ++++++++++++++++++
> >  1 file changed, 120 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml b/Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml
> > new file mode 100644
> > index 000000000000..85a8877c2f38
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml
> > @@ -0,0 +1,120 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/media/i2c/hynix,hi846.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: SK Hynix Hi-846 1/4" 8M Pixel MIPI CSI-2 sensor
> > +
> > +maintainers:
> > +  - Martin Kepplinger <martin.kepplinger@puri.sm>
> > +
> > +description: |-
> > +  The Hi-846 is a raw image sensor with an MIPI CSI-2 image data
> > +  interface and CCI (I2C compatible) control bus. The output format
> > +  is raw Bayer.
> > +
> > +properties:
> > +  compatible:
> > +    const: hynix,hi846
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: Reference to the mclk clock.
> > +
> > +  assigned-clocks:
> > +    maxItems: 1
> > +
> > +  assigned-clock-rates:
> > +    maxItems: 1
> > +
> > +  reset-gpios:
> > +    description: Reference to the GPIO connected to the RESETB pin. Active low.
> > +    maxItems: 1
> > +
> > +  shutdown-gpios:
> > +    description: Reference to the GPIO connected to the XSHUTDOWN pin. Active low.
> > +    maxItems: 1
> > +
> > +  vddio-supply:
> > +    description: Definition of the regulator used for the VDDIO power supply.
> > +
> > +  vdda-supply:
> > +    description: Definition of the regulator used for the VDDA power supply.
> > +
> > +  vddd-supply:
> > +    description: Definition of the regulator used for the VDDD power supply.
> > +
> > +  port:
> > +    $ref: /schemas/graph.yaml#/properties/port
>
> This needs to be:
>
> $ref: /schemas/graph.yaml#/$defs/port-base
>
> to fix the warning reported. You have to use the 'main' branch of
> dtschema which has unevaluatedProperties support. I'll be making a
> release soonish.

This is still failing, can you please fix it.

Rob
