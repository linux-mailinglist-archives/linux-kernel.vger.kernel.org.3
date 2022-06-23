Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E6655890F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiFWTef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiFWTcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:32:19 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BBA3EF37
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 12:08:32 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-317741c86fdso3928527b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 12:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cI9+Tt7Z23d5RLVvZyen7R3tMKAwKXD+mtIbHKBAs/0=;
        b=EwRTeyODFUti7GZ+xjLiRABaUIFE+v7VX2QUxT1gLoLb7OcrDvTuc6YmjFeBi4QPK8
         cMcrZYL/sB3CiRaYHBqxYeHyYY9+3MMopZKUBg8OgBIT5gj7y2fBBjARSaMRIu9EVLOi
         /mclFnDn/0H+0h2tsaiH5pZNuBZIw6OokDWIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cI9+Tt7Z23d5RLVvZyen7R3tMKAwKXD+mtIbHKBAs/0=;
        b=xtMX5ibvwwyV/3GFWlRVvFqiLwTw4JxkPrz0B/9guoZDPJNl1tW4fBhtT3c/zDqNsk
         SaCmW2XTcILt+lXD14HTH3sjE6Z/3TdLFn8uicvlbanDoSUxBDIzZ2Ovg7GMAHMRQK/M
         sYWFu3vYgr453BRJoU4Pw72H6Q2+5cfF5hqI9KYcQxaRLb/3ovj7DreY6BaqxcHjrO4f
         OEtbW3GXF9QTAEvC7vUYWaOgpoHhWVEg+49z0otzZWwaYFbqJXz2tVkOgMGEvKpAtzaF
         GZnossbu0WoHnm6NyXWaQyZzXsf3nm8RZdgkACatsTFARsfYjalKoCXuKIEQqUAc1TAY
         FOpw==
X-Gm-Message-State: AJIora+ImzpmXc4aGaBVkKWrJrBzydGopvQ47N1MJiGkUOhYDnthn/yT
        vSEHwzpowULxpbbiXkYD8iRFfena+yFQSlZDDTsDrQ==
X-Google-Smtp-Source: AGRyM1uI+NXVSDSF+kdbOhzo94TrmT6zO+AbQ7d8LLAT0eOAHI6q+f2Lm9Z72G3mIZo/6BEfD/8XNNQ0xyYslCAEtI8=
X-Received: by 2002:a0d:f045:0:b0:317:e6b2:2c64 with SMTP id
 z66-20020a0df045000000b00317e6b22c64mr12234518ywe.350.1656011311909; Thu, 23
 Jun 2022 12:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220622173605.1168416-1-pmalani@chromium.org>
 <20220622173605.1168416-2-pmalani@chromium.org> <CAE-0n51kcr3VGdR2Kf8j1JaBbLcCmWo9GYhhvkUQ4+jn2iEKLg@mail.gmail.com>
In-Reply-To: <CAE-0n51kcr3VGdR2Kf8j1JaBbLcCmWo9GYhhvkUQ4+jn2iEKLg@mail.gmail.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Thu, 23 Jun 2022 12:08:21 -0700
Message-ID: <CACeCKac4eL9++QwbDBKrVTpUzhes=WczqZfh+cFiVgoO4py4MQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/9] dt-bindings: usb: Add Type-C switch binding
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        bleung@chromium.org, heikki.krogerus@linux.intel.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Allen Chen <allen.chen@ite.com.tw>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
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
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Xin Ji <xji@analogixsemi.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 11:30 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Prashant Malani (2022-06-22 10:34:30)
> > diff --git a/Documentation/devicetree/bindings/usb/typec-switch.yaml b/Documentation/devicetree/bindings/usb/typec-switch.yaml
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
> > +  A USB Type-C switch represents a component which routes USB Type-C data
> > +  lines to various protocol host controllers (e.g USB, VESA DisplayPort,
> > +  Thunderbolt etc.) depending on which mode the Type-C port, port partner
> > +  and cable are operating in. It can also modify lane routing based on
> > +  the orientation of a connected Type-C peripheral.
> > +
> > +properties:
> > +  compatible:
> > +    const: typec-switch
> > +
> > +  mode-switch:
> > +    type: boolean
> > +    description: Specify that this switch can handle alternate mode switching.
> > +
> > +  orientation-switch:
> > +    type: boolean
> > +    description: Specify that this switch can handle orientation switching.
> > +
> > +  ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +    description: OF graph binding modelling data lines to the Type-C switch.
> > +
> > +    properties:
> > +      port@0:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: Link between the switch and a Type-C connector.
>
> Is there an update to the usb-c-connector binding to accept this port
> connection?

Not at this time. I don't think we should enforce that either.
(Type-C data-lines could theoretically be routed through intermediate
hardware like retimers/repeaters)

>
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
> > +            compatible = "typec-switch";
>
> I still don't understand the subnode design here. usb-switch as a
> container node indicates to me that this is a bus, but in earlier rounds
> of this series it was stated this isn't a bus.

I am not aware of this as a requirement. Can you please point me to the
documentation that states this needs to be the case?

> Why doesn't it work to
> merge everything inside usb-switch directly into the drm-bridge node?

I attempted to explain the rationale in the previous version [1], but
using a dedicated sub-node means the driver doesn't haven't to
inspect individual ports to determine which of them need switches
registered for them. If it sees a `typec-switch`, it registers a
mode-switch and/or orientation-switch. IMO it simplifies the hardware
device binding too.

It also maps with the internal block diagram for these hardware
components (for ex. the anx7625 crosspoint switch is a separate
sub-block within anx7625).

[1] https://lore.kernel.org/linux-usb/CACeCKaeH6qTTdG_huC4yw0xxG8TYEOtfPW3tiVNwYs=P4QVPXg@mail.gmail.com/

>
> > +            mode-switch;
> > +            orientation-switch;
> > +            ports {
> > +                #address-cells = <1>;
> > +                #size-cells = <0>;
> > +
> > +                port@0 {
> > +                    reg = <0>;
> > +                    anx_ep: endpoint {
> > +                        remote-endpoint = <&typec_controller>;
> > +                    };
> > +                };
> > +            };
> > +        };
