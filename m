Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304414860AA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 07:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbiAFGfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 01:35:07 -0500
Received: from comms.puri.sm ([159.203.221.185]:45780 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229975AbiAFGfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 01:35:06 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 8E6E2DFF7B;
        Wed,  5 Jan 2022 22:35:05 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qSIUyZLDYL5a; Wed,  5 Jan 2022 22:35:04 -0800 (PST)
Message-ID: <fe45a08d6f04f4d6184874782b6c95f6e00f1658.camel@puri.sm>
Subject: Re: [PATCH v9 2/4] dt-bindings: media: document SK Hynix Hi-846
 MIPI CSI-2 8M pixel sensor
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     Rob Herring <robh@kernel.org>,
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
Date:   Thu, 06 Jan 2022 07:34:57 +0100
In-Reply-To: <CAL_JsqKzaZC0A4OwnMyAuEWm2pCcHyQxHyrBVtkiPNUeMDd+oA@mail.gmail.com>
References: <20210906102837.2190387-1-martin.kepplinger@puri.sm>
         <20210906102837.2190387-3-martin.kepplinger@puri.sm>
         <CAL_JsqJQAutUp9cB2LaoOQQX7mToCc5MkGm59oOmh65yZG0xZQ@mail.gmail.com>
         <CAL_JsqKzaZC0A4OwnMyAuEWm2pCcHyQxHyrBVtkiPNUeMDd+oA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, dem 05.01.2022 um 10:23 -0600 schrieb Rob Herring:
> On Fri, Dec 3, 2021 at 10:19 AM Rob Herring <robh@kernel.org> wrote:
> > 
> > On Mon, Sep 6, 2021 at 5:29 AM Martin Kepplinger
> > <martin.kepplinger@puri.sm> wrote:
> > > 
> > > Document the bindings used for the SK Hynix Hi-846 CMOS camera
> > > driver.
> > > 
> > > Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> > > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  .../bindings/media/i2c/hynix,hi846.yaml       | 120
> > > ++++++++++++++++++
> > >  1 file changed, 120 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml
> > > 
> > > diff --git
> > > a/Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml
> > > b/Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml
> > > new file mode 100644
> > > index 000000000000..85a8877c2f38
> > > --- /dev/null
> > > +++
> > > b/Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml
> > > @@ -0,0 +1,120 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/media/i2c/hynix,hi846.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: SK Hynix Hi-846 1/4" 8M Pixel MIPI CSI-2 sensor
> > > +
> > > +maintainers:
> > > +  - Martin Kepplinger <martin.kepplinger@puri.sm>
> > > +
> > > +description: |-
> > > +  The Hi-846 is a raw image sensor with an MIPI CSI-2 image data
> > > +  interface and CCI (I2C compatible) control bus. The output
> > > format
> > > +  is raw Bayer.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: hynix,hi846
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    items:
> > > +      - description: Reference to the mclk clock.
> > > +
> > > +  assigned-clocks:
> > > +    maxItems: 1
> > > +
> > > +  assigned-clock-rates:
> > > +    maxItems: 1
> > > +
> > > +  reset-gpios:
> > > +    description: Reference to the GPIO connected to the RESETB
> > > pin. Active low.
> > > +    maxItems: 1
> > > +
> > > +  shutdown-gpios:
> > > +    description: Reference to the GPIO connected to the
> > > XSHUTDOWN pin. Active low.
> > > +    maxItems: 1
> > > +
> > > +  vddio-supply:
> > > +    description: Definition of the regulator used for the VDDIO
> > > power supply.
> > > +
> > > +  vdda-supply:
> > > +    description: Definition of the regulator used for the VDDA
> > > power supply.
> > > +
> > > +  vddd-supply:
> > > +    description: Definition of the regulator used for the VDDD
> > > power supply.
> > > +
> > > +  port:
> > > +    $ref: /schemas/graph.yaml#/properties/port
> > 
> > This needs to be:
> > 
> > $ref: /schemas/graph.yaml#/$defs/port-base
> > 
> > to fix the warning reported. You have to use the 'main' branch of
> > dtschema which has unevaluatedProperties support. I'll be making a
> > release soonish.
> 
> This is still failing, can you please fix it.
> 
> Rob

Yes I'll send a patch next week. thanks for the reminder,

                           martin

