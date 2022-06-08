Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064DF542BF8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234796AbiFHJuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235483AbiFHJuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:50:21 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8960D392A2E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:18:38 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z7so26189012edm.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 02:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uslo1ay+/qxoDJknXX4jPIC6SbHTLg2hMT/co1gVHAM=;
        b=Pqt7muh1OBZiOFSiS3jyVF1QSLKEUn1uSY8nr2V3ACJvzmkgVnQHkAfGVZauD+0c1v
         +hbhGHn5MnERl91/CB0MMUI9XDTrcXhx0xM3sYOanaEnHzpdQmnI3TNih+WK9C1iHNkT
         xYWWuW3xA5Ocf/tmlVbVefF7Jso7rh5Jh4AGyQ0BuqDFP19TMjU4BRRmRMAqtP+wrr2c
         1hK3Qb1ssTEMomdCVyzMefEjWQ98Tl0LZxhibkrlEE8aFG/MV2Mv36nNxUfUbo2ChLCz
         iEzuVGRJ22qzlV6VKnZGcI7LF9aLW+tFAh1BdCSbZAEdRsoACcYubLtMyucU9tKAXSi5
         /1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uslo1ay+/qxoDJknXX4jPIC6SbHTLg2hMT/co1gVHAM=;
        b=RcWJdgrEdfz5fBUlsFe9Nk8rALKy/TizuGbRciUMaZzYHJ4UT+hgtLuFS37U58+9XH
         ZqOQkPwPaTUg0L6vXRKyYuDBL8+WXX/jNqkGK+BldIw/ZqHAbW8RvXX952sRBSoHCuci
         N3M5zlOoPv7pVmfTB9cR6TaAsksaTJidQXh0t9F4lkE2UMcZNd3r7jjydBNNy4kYAFNm
         ny6RgmU6T7MiZSxSrpX2h3o2Gmx1MNp9PsT3axAa+6g5QbtHtSQX6LpxVzvcdK3KIb8D
         mdZYbMT4VtTsWCNQ5Yh2Y3lg0XTAXJJXaD2qjW9/YdY8XgK0a/QWmXl8iUKh47VcMOuR
         u8mA==
X-Gm-Message-State: AOAM530YSM6tCXpvkCXx2wi2cD3mMP+hbDCyHlos4B3BKZHfPqoA7akh
        jOhpwU5VffE0MhPfHtMAAP6cg8xevhbu8Q==
X-Google-Smtp-Source: ABdhPJxhwRETD56REVG88NNrnjg9TIUTndzhZYmh/uo+HYu0/kJkj0sbCqXQDYyYFhdRJ09ufgeBng==
X-Received: by 2002:aa7:d9d9:0:b0:42d:f9e4:49e0 with SMTP id v25-20020aa7d9d9000000b0042df9e449e0mr37661598eds.299.1654679916702;
        Wed, 08 Jun 2022 02:18:36 -0700 (PDT)
Received: from [192.168.0.190] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id e1-20020a1709062c0100b0070bdc059ab2sm7432535ejh.138.2022.06.08.02.18.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 02:18:36 -0700 (PDT)
Message-ID: <ba499783-1794-1c00-348a-d912c9562e1e@linaro.org>
Date:   Wed, 8 Jun 2022 11:18:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 3/7] dt-bindings: usb: Add Type-C switch binding
Content-Language: en-US
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     bleung@chromium.org, swboyd@chromium.org,
        heikki.krogerus@linux.intel.com,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
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
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Pin-Yen Lin <treapking@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Xin Ji <xji@analogixsemi.com>
References: <20220607190131.1647511-1-pmalani@chromium.org>
 <20220607190131.1647511-4-pmalani@chromium.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220607190131.1647511-4-pmalani@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2022 21:00, Prashant Malani wrote:
> Introduce a binding which represents a component that can control the
> routing of USB Type-C data lines as well as address data line
> orientation (based on CC lines' orientation).
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
>  .../devicetree/bindings/usb/typec-switch.yaml | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/typec-switch.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/typec-switch.yaml b/Documentation/devicetree/bindings/usb/typec-switch.yaml
> new file mode 100644
> index 000000000000..60a600a63fef
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/typec-switch.yaml
> @@ -0,0 +1,76 @@
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
> +    items:

Single item, so no need for items.

> +      - enum:
> +          - typec-switch
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

Why true? I see usb-connector has it from commit 6a0e321ea735
("dt-bindings: Explicitly allow additional properties in common schemas")
 but that looks also weird - this is not a common schema, but a
complete, generic one.

> +
> +examples:
> +  - |
> +    anx7625 {

Generic node name.

> +      typecswitch {

I guess here as well, so "usb-switch"?

> +        compatible = "typec-switch";
> +        mode-switch;
> +        orientation-switch;
> +        ports {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          port@0 {
> +            reg = <0>;
> +            anx_ep: endpoint {
> +              remote-endpoint = <&typec_controller>;
> +            };
> +          };
> +        };
> +      };
> +    };


Best regards,
Krzysztof
