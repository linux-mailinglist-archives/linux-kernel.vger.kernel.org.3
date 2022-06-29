Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A5D5603BF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 17:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbiF2PBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 11:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbiF2PBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 11:01:09 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56A81EAF4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 08:01:05 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b26so10510981wrc.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 08:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BFTLOzROIiPqmhqAxyhqbA3c4cCfg2+85Lj08j7lKrc=;
        b=KSZCIsiOiM5lSrD/SN2KobYz6mYvLmSMkmIYAm6jJkx0besT50xI2w+S/fmkjIc5Lt
         CiENPRHqyHQnjG2/XUvVms/IdIjuXzpiz279AxabuBLqetXpajQmuQgYJYEvWegsAq7m
         g0N0kPNt3eOX0cgC7K0dpvGCTGIkeo0W03voU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BFTLOzROIiPqmhqAxyhqbA3c4cCfg2+85Lj08j7lKrc=;
        b=o5b/ZOhRkEB9PO404lx92AT6cfCDnLy4eI00t8sm0xC9AuTdRb2yMmK3uZkRaDW/DH
         Ov3SIUpRERICbmL+h1wI+ZZ6pySnBP1S1p8uN8LVbpRTYvYBLOEO17MC0z3dEObHqyGK
         bUJeytBZJEyD5W4EbdeQYTJC+5zsCK0t2g8aWqnIuTUy+n3esHmAgDgA9Zn5f2minp1g
         NK0EWWsOfVdy1A29om+z4saDMnCxtbQ/e1VYkQxGsrIczjn/pctVG4PDh1lskKXV8dkA
         Td8DbBIeWj+qxDXUqrKJ2sxlwkvGahu7HK8fCJVSY+WTscGnoyCjcUoU5FqmFjYgOtSO
         nNug==
X-Gm-Message-State: AJIora8RPSR/MroQM5h/rJP7ZwRECMhW1zGN0iTJ0+6/fMdi2411p5qh
        VFSsRDz0VWVAeK5nPFBToQhMAlktsxHXRlsdpHqU5w==
X-Google-Smtp-Source: AGRyM1sfGDisJPMkurvd0csySTU2fbtpR7bD1RXmyKvioUnsN/Dz9FmiK+aIh31YNygfWB8TUXd60BEck363CaWXJJY=
X-Received: by 2002:a05:6000:1245:b0:21b:83b2:191c with SMTP id
 j5-20020a056000124500b0021b83b2191cmr3611692wrx.493.1656514864306; Wed, 29
 Jun 2022 08:01:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220622173605.1168416-1-pmalani@chromium.org>
 <20220622173605.1168416-2-pmalani@chromium.org> <20220627210407.GA2905757-robh@kernel.org>
 <CACeCKackdbDZrk5fk7qyMwSdTdzyTS=m1vHPFnQOj672W=2nOA@mail.gmail.com>
 <20220628182336.GA711518-robh@kernel.org> <CAEXTbpex9nxP-nyPWvSBchAW4j3C4MZfVHTb=5X0iSLY1bSAKg@mail.gmail.com>
In-Reply-To: <CAEXTbpex9nxP-nyPWvSBchAW4j3C4MZfVHTb=5X0iSLY1bSAKg@mail.gmail.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Wed, 29 Jun 2022 23:00:53 +0800
Message-ID: <CAEXTbpf_jxK-R5aA81FCbpAH4bChA2B9+8qExZUbA7Y+Ort=Gg@mail.gmail.com>
Subject: Re: [PATCH v5 1/9] dt-bindings: usb: Add Type-C switch binding
To:     Rob Herring <robh@kernel.org>
Cc:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        bleung@chromium.org, swboyd@chromium.org,
        heikki.krogerus@linux.intel.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Allen Chen <allen.chen@ite.com.tw>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Xin Ji <xji@analogixsemi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 10:33 PM Pin-yen Lin <treapking@chromium.org> wrote=
:
>
> On Wed, Jun 29, 2022 at 2:23 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Mon, Jun 27, 2022 at 02:43:39PM -0700, Prashant Malani wrote:
> > > Hello Rob,
> > >
> > > On Mon, Jun 27, 2022 at 2:04 PM Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Wed, Jun 22, 2022 at 05:34:30PM +0000, Prashant Malani wrote:
> > > > > Introduce a binding which represents a component that can control=
 the
> > > > > routing of USB Type-C data lines as well as address data line
> > > > > orientation (based on CC lines' orientation).
> > > > >
> > > > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > > > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregn=
o@collabora.com>
> > > > > Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com=
>
> > > > > Tested-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> > > > > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > > > > ---
> > > > >
> > > > > Changes since v4:
> > > > > - Added Reviewed-by tags.
> > > > > - Patch moved to 1/9 position (since Patch v4 1/7 and 2/7 were
> > > > >   applied to usb-next)
> > > > >
> > > > > Changes since v3:
> > > > > - No changes.
> > > > >
> > > > > Changes since v2:
> > > > > - Added Reviewed-by and Tested-by tags.
> > > > >
> > > > > Changes since v1:
> > > > > - Removed "items" from compatible.
> > > > > - Fixed indentation in example.
> > > > >
> > > > >  .../devicetree/bindings/usb/typec-switch.yaml | 74 +++++++++++++=
++++++
> > > > >  1 file changed, 74 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/usb/typec-s=
witch.yaml
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/usb/typec-switch.y=
aml b/Documentation/devicetree/bindings/usb/typec-switch.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..78b0190c8543
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/usb/typec-switch.yaml
> > > > > @@ -0,0 +1,74 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/usb/typec-switch.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: USB Type-C Switch
> > > > > +
> > > > > +maintainers:
> > > > > +  - Prashant Malani <pmalani@chromium.org>
> > > > > +
> > > > > +description:
> > > > > +  A USB Type-C switch represents a component which routes USB Ty=
pe-C data
> > > > > +  lines to various protocol host controllers (e.g USB, VESA Disp=
layPort,
> > > > > +  Thunderbolt etc.) depending on which mode the Type-C port, por=
t partner
> > > > > +  and cable are operating in. It can also modify lane routing ba=
sed on
> > > > > +  the orientation of a connected Type-C peripheral.
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    const: typec-switch
> > > > > +
> > > > > +  mode-switch:
> > > > > +    type: boolean
> > > > > +    description: Specify that this switch can handle alternate m=
ode switching.
> > > > > +
> > > > > +  orientation-switch:
> > > > > +    type: boolean
> > > > > +    description: Specify that this switch can handle orientation=
 switching.
> > > > > +
> > > > > +  ports:
> > > > > +    $ref: /schemas/graph.yaml#/properties/ports
> > > > > +    description: OF graph binding modelling data lines to the Ty=
pe-C switch.
> > > > > +
> > > > > +    properties:
> > > > > +      port@0:
> > > > > +        $ref: /schemas/graph.yaml#/properties/port
> > > > > +        description: Link between the switch and a Type-C connec=
tor.
> > > > > +
> > > > > +    required:
> > > > > +      - port@0
> > > > > +
> > > > > +required:
> > > > > +  - compatible
> > > > > +  - ports
> > > > > +
> > > > > +anyOf:
> > > > > +  - required:
> > > > > +      - mode-switch
> > > > > +  - required:
> > > > > +      - orientation-switch
> > > > > +
> > > > > +additionalProperties: true
> > > > > +
> > > > > +examples:
> > > > > +  - |
> > > > > +    drm-bridge {
> > > > > +        usb-switch {
> > > > > +            compatible =3D "typec-switch";
> > > >
> > > > Unless this child is supposed to represent what the parent output i=
s
> > > > connected to, this is just wrong as, at least for the it6505 chip, =
it
> > > > doesn't know anything about Type-C functionality. The bridge is
> > > > just a protocol converter AFAICT.
> > >
> > > I'll let Pin-Yen comment on the specifics of the it6505 chip.
> >
> > We're all waiting...
>
> Yes it6505 is just a protocol converter. But in our use case, the output =
DP
> lines are connected to the Type-C ports and the chip has to know which
> port has DP Alt mode enabled. Does this justify a child node here?
>
> Does it make more sense if we we eliminate the usb-switch node here
> and list the ports in the top level?
> >
> > > > If the child node represents what the output is connected to (like =
a
> > > > bus), then yes that is a pattern we have used.
> > >
> > > For the anx7625 case, the child node does represent what the output i=
s connected
> > > to (the usb-c-connector via the switch). Does that not qualify? Or do=
 you mean
> > > the child node should be a usb-c-connector itself?
> > >
> > > > For example, a panel
> > > > represented as child node of a display controller. However, that on=
ly
> > > > works for simple cases, and is a pattern we have gotten away from i=
n
> > > > favor of using the graph binding.
> > >
> > > The child node will still use a OF graph binding to connect to the
> > > usb-c-connector.
> > > Is that insufficient to consider a child node usage here?
> > > By "using the graph binding", do you mean "only use the top-level por=
ts" ?
> > > I'm trying to clarify this, so that it will inform future versions an=
d patches.
> >
> > What I want to see is block diagrams of possible h/w with different
> > scenarios and then what the binding looks like in those cases. The
> > switching/muxing could be in the SoC, a bridge chip, a Type C
> > controller, a standalone mux chip, or ????. If you want a somewhat
> > genericish binding, then you need to consider all of these.

Then, is it suitable to put the switch binding into the drivers own binding=
s
(i.e., the bindings for it6505 and anx7625), and introduce some helper
functions to eliminate the duplication in the code?
Though we will have two similar bindings in two drivers with this approach.

> >
> > I don't really have the b/w to work thru all this (and switch/mux is
> > just one part of dealing with Type-C). This is just one of about a
> > hundred patches I get to review a week.
> >
> > Rob
