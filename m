Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6322C542C0C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbiFHJym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbiFHJyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:54:09 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C6327FE1C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:24:44 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id bg6so20412415ejb.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 02:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zSLdyx64qSe5gyHdS5UlkceB2srWq2wpIjxpdBXJ6s8=;
        b=jWCXP7B8PfneXoA78HERkc5WPZXWIGc4PTf3ej4mJ1w5NNxASuN1mTgM5THK3gz5eM
         vDQdSPs27hgYuMmswEPRhnu7WRi/MWr4V34+WzzC8yg154n3hUTKJcaTHrqNQ6Zpmnj7
         JbA91n12TX41v9Tw8UT2qKLxraz6N9YYg3Fx/nRqYevY+J91DxuoB0t0c9ZYxpMm5WXf
         SdmlyWvXMyLlCCNLNd8UUyLreq+xj3nXjZSi6P/QPMeEqFbeHv26PZ0NqP51eEcNC59N
         OGd59Seqm0KzfoS8cOxoGhh1rug91Lkk4nisNI0c3V5ehiW0iVFWOA3X0rdYeYIc5J09
         XIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zSLdyx64qSe5gyHdS5UlkceB2srWq2wpIjxpdBXJ6s8=;
        b=I8rFTU+VFhB/EH3Cc5J21CZohQTbmUN5iMIogZudW2Yt6lz0TEX0qNJfgjjcyutSSm
         Ll9szducq6aPqKiG2e5+dGyJUXZKHqswqRqW65l3/pEJOpWqXhHDXYyfzw2VO6VWC/tM
         viOkuGCcg0Rb1rR6JqvfYA24anrPCsfNrFeihuS+o8VyTMf9rueLJRaP3fMw6dHGJmRo
         gfe88JD4NSB0Xb5F8oJbivFS0INOMb80u1c4pMfJupXgfHqYajVoNnY/1+FFvK5c5qGY
         CXJWbYvuR2aahkOsQTOBU5BLjbgv5weiO0zjTfP1ddAkTh+rAjq4hQ800XkEIXqiNyZB
         Gj6w==
X-Gm-Message-State: AOAM530EzQVGCUscvR8pG83O2naJQMQ18zOak0ZM6D7ovl4xN52vlJyk
        paCkTzfqLsohsInhxb0eohw8Ow==
X-Google-Smtp-Source: ABdhPJxYV9tBPj4dwnLBO37vz7PvVAGcb41V0vK9tvKORk36nT5oq7EgD1nyvt40Zy6yk44yCYsFAQ==
X-Received: by 2002:a17:907:2d0c:b0:711:e835:f80c with SMTP id gs12-20020a1709072d0c00b00711e835f80cmr5450514ejc.257.1654680282700;
        Wed, 08 Jun 2022 02:24:42 -0700 (PDT)
Received: from [192.168.0.191] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id b6-20020a17090636c600b006feb6dee4absm8887348ejc.137.2022.06.08.02.24.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 02:24:42 -0700 (PDT)
Message-ID: <fbc48d41-b2cc-86f6-5f1c-7cfcbdb41e46@linaro.org>
Date:   Wed, 8 Jun 2022 11:24:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 4/7] dt-bindings: drm/bridge: anx7625: Add mode-switch
 support
Content-Language: en-US
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     bleung@chromium.org, swboyd@chromium.org,
        heikki.krogerus@linux.intel.com,
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
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Pin-Yen Lin <treapking@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Xin Ji <xji@analogixsemi.com>
References: <20220607190131.1647511-1-pmalani@chromium.org>
 <20220607190131.1647511-5-pmalani@chromium.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220607190131.1647511-5-pmalani@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2022 21:00, Prashant Malani wrote:
> Analogix 7625 can be used in systems to switch USB Type-C DisplayPort
> alternate mode lane traffic between 2 Type-C ports.
> 
> Update the binding to accommodate this usage by introducing a switch
> property.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
>  .../display/bridge/analogix,anx7625.yaml      | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> index 35a48515836e..7e1f655ddfcc 100644
> --- a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> @@ -105,6 +105,26 @@ properties:
>        - port@0
>        - port@1
>  
> +  switches:
> +    type: object
> +    description: Set of switches controlling DisplayPort traffic on
> +      outgoing RX/TX lanes to Type C ports.
> +
> +    properties:
> +      switch:

You allow only one switch with such schema, so no need for "switches"...

> +        $ref: /schemas/usb/typec-switch.yaml#
> +        maxItems: 2

Are you sure this works? what are you limiting here with maxItems? I
think you wanted patternProperties...

> +
> +        properties:
> +          reg:
> +            maxItems: 1
> +
> +        required:
> +          - reg
> +
> +    required:
> +      - switch@0

This does not match the property.

You also need unevaluatedProperties:false


> +
>  required:
>    - compatible
>    - reg
> @@ -167,5 +187,41 @@ examples:
>                      };
>                  };
>              };
> +            switches {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                switch@0 {
> +                    compatible = "typec-switch";
> +                    reg = <0>;
> +                    mode-switch;
> +
> +                    ports {
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
> +                        port@0 {
> +                            reg = <0>;
> +                            anx_typec0: endpoint {
> +                              remote-endpoint = <&typec_port0>;

Messed up indentation. Your previous patch should also switch to 4-space
as recommended by schema coding style.

> +                            };
> +                        };
> +                    };
> +                };
> +                switch@1 {
> +                    compatible = "typec-switch";
> +                    reg = <1>;
> +                    mode-switch;
> +
> +                    ports {
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
> +                        port@0 {
> +                            reg = <0>;
> +                            anx_typec1: endpoint {
> +                              remote-endpoint = <&typec_port1>;

Ditto.

> +                            };
> +                        };
> +                    };
> +                };
> +            };
>          };
>      };


Best regards,
Krzysztof
