Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B75E5588A0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiFWTYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiFWTXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:23:46 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F147E000
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 11:30:54 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-fe023ab520so520423fac.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 11:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=Cu7lUOJoF8MsEjjhUXAlemBJalFdNx5NoIAp/Yb+L0Q=;
        b=nQ2MU2YT94Izi+5I8Ke/MStU+26iA3FQ3xvEONgZPTjFfFYPAoizbLAA0uG5U81vpE
         NshxXiXosueJ/uRGjjobd3cG3l1+B6lUmVHBpc3V0PLikCz9a1VG3fhPuwbx3c4KB3sw
         Za5hbikmA8b00LbJhlzEAp8zTbksKTtI3lDHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=Cu7lUOJoF8MsEjjhUXAlemBJalFdNx5NoIAp/Yb+L0Q=;
        b=b4obke3YNv7GM/ona8jXMDhNKuEyjqHEEYoLfa7ExrnzNVS/eukAMI8KPmFgpOmv5L
         zek5n63+PikvM0Ukiz99au9EN57Ze6iH+8Bp9YOVUk733Jj9bLya8ie0Dh+0wDma9pLv
         s2Ib+Al12QrgZsUx9U9ZO9MNbBZWGhH1gfVXp22n5PuewxAXnRG+0hL1UBWJh+UgayPZ
         BdC5odZEylRxfR3H+EQ50+rLQUlPnStdQwH5m+YgUKEWMXkFK6eoy5adXFUfGUNlqPt4
         naUYWrn72weULzzztvjo+9OUh9sVXBs9AvHi4LyTA0Bqg3Y3yigWX8fSJnDTZVL2zs43
         XTjw==
X-Gm-Message-State: AJIora9oIjUtbsHFLqrMU03pFU1VwJxCe9xMxSVWoVZAbRHvRkdFRUwr
        lkdgYtc5P3rW1ddY+U8rGZTMixYvok+C+BJMV6upXA==
X-Google-Smtp-Source: AGRyM1saP/3AppAsDEde7X7gr4a6wLFmXqfljFPOVADgh3UBV9SWu3eefISwFStbs1Rv04lvbJFDkeSrzdI0yAqIkb4=
X-Received: by 2002:a05:6870:b381:b0:fe:2004:b3b5 with SMTP id
 w1-20020a056870b38100b000fe2004b3b5mr3345847oap.63.1656009053852; Thu, 23 Jun
 2022 11:30:53 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 23 Jun 2022 14:30:53 -0400
MIME-Version: 1.0
In-Reply-To: <20220622173605.1168416-2-pmalani@chromium.org>
References: <20220622173605.1168416-1-pmalani@chromium.org> <20220622173605.1168416-2-pmalani@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 23 Jun 2022 14:30:53 -0400
Message-ID: <CAE-0n51kcr3VGdR2Kf8j1JaBbLcCmWo9GYhhvkUQ4+jn2iEKLg@mail.gmail.com>
Subject: Re: [PATCH v5 1/9] dt-bindings: usb: Add Type-C switch binding
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     bleung@chromium.org, heikki.krogerus@linux.intel.com,
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

Quoting Prashant Malani (2022-06-22 10:34:30)
> diff --git a/Documentation/devicetree/bindings/usb/typec-switch.yaml b/Documentation/devicetree/bindings/usb/typec-switch.yaml
> new file mode 100644
> index 000000000000..78b0190c8543
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/typec-switch.yaml
> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/typec-switch.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: USB Type-C Switch
> +
> +maintainers:
> +  - Prashant Malani <pmalani@chromium.org>
> +
> +description:
> +  A USB Type-C switch represents a component which routes USB Type-C data
> +  lines to various protocol host controllers (e.g USB, VESA DisplayPort,
> +  Thunderbolt etc.) depending on which mode the Type-C port, port partner
> +  and cable are operating in. It can also modify lane routing based on
> +  the orientation of a connected Type-C peripheral.
> +
> +properties:
> +  compatible:
> +    const: typec-switch
> +
> +  mode-switch:
> +    type: boolean
> +    description: Specify that this switch can handle alternate mode switching.
> +
> +  orientation-switch:
> +    type: boolean
> +    description: Specify that this switch can handle orientation switching.
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    description: OF graph binding modelling data lines to the Type-C switch.
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Link between the switch and a Type-C connector.

Is there an update to the usb-c-connector binding to accept this port
connection?

> +
> +    required:
> +      - port@0
> +
> +required:
> +  - compatible
> +  - ports
> +
> +anyOf:
> +  - required:
> +      - mode-switch
> +  - required:
> +      - orientation-switch
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    drm-bridge {
> +        usb-switch {
> +            compatible = "typec-switch";

I still don't understand the subnode design here. usb-switch as a
container node indicates to me that this is a bus, but in earlier rounds
of this series it was stated this isn't a bus. Why doesn't it work to
merge everything inside usb-switch directly into the drm-bridge node?

> +            mode-switch;
> +            orientation-switch;
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                port@0 {
> +                    reg = <0>;
> +                    anx_ep: endpoint {
> +                        remote-endpoint = <&typec_controller>;
> +                    };
> +                };
> +            };
> +        };
