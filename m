Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5580655C413
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241396AbiF0Vn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 17:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241172AbiF0Vnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 17:43:52 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AD4C53
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 14:43:51 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id o19so12439737ybg.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 14:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zVVDV7APfU9r2RLbdKg5/cTGtWPknd1MSe7r7DyJqGA=;
        b=WK98TF2fZfBa0/bAmyVmVIC8Zjaro5lVsqZPE5F2DRd46BRHPENt4IdG+aMKFgGu6J
         UevhukZvj75uZFsswaLyKxkHDNFvW7Cc+3iPnoqOqD4ItNDx0K39pOfz9U6daqXVR8xU
         ur0I66+aTKigkDWmRRrnTlFqWXcdrUkD5QxlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zVVDV7APfU9r2RLbdKg5/cTGtWPknd1MSe7r7DyJqGA=;
        b=fLfEsizcMAN6JxWf5zPbZ5eZW6qjJ8L8w7AGCWLnX2Q2xgbucnbgThgSl43iJpp7rI
         okacOprvtBgem99Mmi9io8c0iybHkahXZtIy2spodX/t2mJRSj0mUUpENCgeoNjIvnF5
         8BejsgPMd0VMR7ESD65hYFMZCUWTAC/eFyML3Cgq8UQTIwK20q4Cgqppw46837iZVF7X
         jsjbjv+GZAVFQn3z+g0U+0vAUOk+XjFuOx9R8R5cWoqNMa/WRN0rHPBRYK5uKgbdn6x6
         mtIS2z6apioPpaNX3YqfsN/+Zl43ht87D8+Jxo0MNvOmsXBpHBm+VssE+3eltYXsnl/Q
         Zb+Q==
X-Gm-Message-State: AJIora8R0SwPVYrRIUNxSt+GEgCGrRjdfRaKLI6pWW0UhlUDu8mL4vTD
        YmwqDLiEvZZbU15xe4VpOLMK5gYJy2a/iVvXjVWwVw==
X-Google-Smtp-Source: AGRyM1vMpp/K/ujDLij5isvZcyN2Qbx0yJqK9sa2MgUAZ3WMBHbnXgtvinV7drhL36FdOgCoVMVawRrt3FHUO4o+rng=
X-Received: by 2002:a25:da0b:0:b0:66c:850f:1b71 with SMTP id
 n11-20020a25da0b000000b0066c850f1b71mr16460322ybf.336.1656366230372; Mon, 27
 Jun 2022 14:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220622173605.1168416-1-pmalani@chromium.org>
 <20220622173605.1168416-2-pmalani@chromium.org> <20220627210407.GA2905757-robh@kernel.org>
In-Reply-To: <20220627210407.GA2905757-robh@kernel.org>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Mon, 27 Jun 2022 14:43:39 -0700
Message-ID: <CACeCKackdbDZrk5fk7qyMwSdTdzyTS=m1vHPFnQOj672W=2nOA@mail.gmail.com>
Subject: Re: [PATCH v5 1/9] dt-bindings: usb: Add Type-C switch binding
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
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
        Pin-Yen Lin <treapking@chromium.org>,
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

Hello Rob,

On Mon, Jun 27, 2022 at 2:04 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Jun 22, 2022 at 05:34:30PM +0000, Prashant Malani wrote:
> > Introduce a binding which represents a component that can control the
> > routing of USB Type-C data lines as well as address data line
> > orientation (based on CC lines' orientation).
> >
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> > Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> > Tested-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > ---
> >
> > Changes since v4:
> > - Added Reviewed-by tags.
> > - Patch moved to 1/9 position (since Patch v4 1/7 and 2/7 were
> >   applied to usb-next)
> >
> > Changes since v3:
> > - No changes.
> >
> > Changes since v2:
> > - Added Reviewed-by and Tested-by tags.
> >
> > Changes since v1:
> > - Removed "items" from compatible.
> > - Fixed indentation in example.
> >
> >  .../devicetree/bindings/usb/typec-switch.yaml | 74 +++++++++++++++++++
> >  1 file changed, 74 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/typec-switch.=
yaml
> >
> > diff --git a/Documentation/devicetree/bindings/usb/typec-switch.yaml b/=
Documentation/devicetree/bindings/usb/typec-switch.yaml
> > new file mode 100644
> > index 000000000000..78b0190c8543
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/typec-switch.yaml
> > @@ -0,0 +1,74 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/usb/typec-switch.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: USB Type-C Switch
> > +
> > +maintainers:
> > +  - Prashant Malani <pmalani@chromium.org>
> > +
> > +description:
> > +  A USB Type-C switch represents a component which routes USB Type-C d=
ata
> > +  lines to various protocol host controllers (e.g USB, VESA DisplayPor=
t,
> > +  Thunderbolt etc.) depending on which mode the Type-C port, port part=
ner
> > +  and cable are operating in. It can also modify lane routing based on
> > +  the orientation of a connected Type-C peripheral.
> > +
> > +properties:
> > +  compatible:
> > +    const: typec-switch
> > +
> > +  mode-switch:
> > +    type: boolean
> > +    description: Specify that this switch can handle alternate mode sw=
itching.
> > +
> > +  orientation-switch:
> > +    type: boolean
> > +    description: Specify that this switch can handle orientation switc=
hing.
> > +
> > +  ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +    description: OF graph binding modelling data lines to the Type-C s=
witch.
> > +
> > +    properties:
> > +      port@0:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: Link between the switch and a Type-C connector.
> > +
> > +    required:
> > +      - port@0
> > +
> > +required:
> > +  - compatible
> > +  - ports
> > +
> > +anyOf:
> > +  - required:
> > +      - mode-switch
> > +  - required:
> > +      - orientation-switch
> > +
> > +additionalProperties: true
> > +
> > +examples:
> > +  - |
> > +    drm-bridge {
> > +        usb-switch {
> > +            compatible =3D "typec-switch";
>
> Unless this child is supposed to represent what the parent output is
> connected to, this is just wrong as, at least for the it6505 chip, it
> doesn't know anything about Type-C functionality. The bridge is
> just a protocol converter AFAICT.

I'll let Pin-Yen comment on the specifics of the it6505 chip.

>
> If the child node represents what the output is connected to (like a
> bus), then yes that is a pattern we have used.

For the anx7625 case, the child node does represent what the output is conn=
ected
to (the usb-c-connector via the switch). Does that not qualify? Or do you m=
ean
the child node should be a usb-c-connector itself?

> For example, a panel
> represented as child node of a display controller. However, that only
> works for simple cases, and is a pattern we have gotten away from in
> favor of using the graph binding.

The child node will still use a OF graph binding to connect to the
usb-c-connector.
Is that insufficient to consider a child node usage here?
By "using the graph binding", do you mean "only use the top-level ports" ?
I'm trying to clarify this, so that it will inform future versions and patc=
hes.

>
> I think Stephen and I are pretty much saying the same thing.
>
> Rob
