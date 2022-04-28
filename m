Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A050512B48
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 08:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243527AbiD1GQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 02:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243496AbiD1GQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 02:16:06 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6589C21257
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 23:12:51 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g20so4301019edw.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 23:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wm9yPzx6czvlBQnyn3z1i+GsN8IoN86F4R1Y0e4QEhY=;
        b=n/LreBNeA3e/lXfk7FHUfsy5nVyum/m07hDh6cxldE7ONcu+HRW5ztN6LbpQCj5V5m
         tmZY52qDNngIQ5yz3h2taja2hObSXWVYjYX7eMaPYxUnoDBe22CbecP3do6EqFWTSNJ+
         dwjaYy2Gg/xLWxKbOms6Qrs1r2UPzk2FEZOermql+E8g2pEUd2kfMv4lGZYuJTEAuz3V
         lqUWYPmA4igW9D4k2OKMtXdvUmCUrwUS+0MiwgiDcNq9BQPjBX/9GlffVR5MKNt3o/Mm
         /YPOX1VEW8s8KGJViAyNASO1aIjXmmkGIFAK75v2xJsmBNAhyyPQ87LaQayDrvaQ2YaZ
         ZSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wm9yPzx6czvlBQnyn3z1i+GsN8IoN86F4R1Y0e4QEhY=;
        b=uMk+G2e7S5+aZFfxoYrKjTznMMVB/BhtFpPmZc+H0OJ9FFXUgmA4Ci15UF4TS7nSmg
         6jZBpBtt98BdB+ad/j5u/VWbVk8tCUjWTpH2QoYSE/Bvy+8OTrnUWAgVf1T29PJBNauI
         /EWUFefJz8hU1brmUDb7W1xmcpHNadYWBnGfkNMQ8FatgpboE0cKozWfYLeSxB6fCXza
         wBN5eNzMm5NlCT0oBBTHb3/k0AElX+2JfWfREmUPRtuXlccZN3277FFGQ13L79w2E7Ep
         cKBsA4LSVYAVZHKL+XOWf7Ix7PVtXdH2CRFdvZhca4wTXnC1orOubna87AoaoSfmgC7C
         w5vw==
X-Gm-Message-State: AOAM533zgqFfNZ8vW9pkcXi9BbaK2FK0pnI8tnv5s4uIx+651GdHY0si
        2gEcjXDcMABqZI/EBzcMCi9Y5w==
X-Google-Smtp-Source: ABdhPJwKkUBJFO2jKXoH1LLDlOF7hO+RlyZgidW/QcXeirH3zxkeAeFtvMT8SSM+f7aIRaqx0OyVLA==
X-Received: by 2002:a05:6402:11c9:b0:425:ef56:a1dd with SMTP id j9-20020a05640211c900b00425ef56a1ddmr18383244edw.143.1651126370001;
        Wed, 27 Apr 2022 23:12:50 -0700 (PDT)
Received: from [192.168.0.159] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id t19-20020aa7d4d3000000b0042617ba63c2sm933624edr.76.2022.04.27.23.12.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 23:12:49 -0700 (PDT)
Message-ID: <9248da4f-ca04-82f0-2840-a20797c25d2a@linaro.org>
Date:   Thu, 28 Apr 2022 08:12:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] dt-bindings: google,cros-ec-keyb: Introduce switches
 only compatible
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>
References: <20220427203026.828183-1-swboyd@chromium.org>
 <20220427203026.828183-2-swboyd@chromium.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220427203026.828183-2-swboyd@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2022 22:30, Stephen Boyd wrote:
> If the device is a detachable, this device won't have a matrix keyboard
> but it may have some button switches, e.g. volume buttons and power
> buttons. Let's add a more specific compatible for this type of device
> that indicates to the OS that there are only switches and no matrix
> keyboard present.
> 
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: <devicetree@vger.kernel.org>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> Cc: "Joseph S. Barrera III" <joebar@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  .../bindings/input/google,cros-ec-keyb.yaml          | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml b/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
> index e8f137abb03c..edc1194d558d 100644
> --- a/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
> +++ b/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
> @@ -15,14 +15,20 @@ description: |
>    Google's ChromeOS EC Keyboard is a simple matrix keyboard
>    implemented on a separate EC (Embedded Controller) device. It provides
>    a message for reading key scans from the EC. These are then converted
> -  into keycodes for processing by the kernel.
> +  into keycodes for processing by the kernel. This device also supports
> +  switches/buttons like power and volume buttons.
>  
>  allOf:
>    - $ref: "/schemas/input/matrix-keymap.yaml#"
>  
>  properties:
>    compatible:
> -    const: google,cros-ec-keyb
> +    oneOf:
> +      - items:
> +          - const: google,cros-ec-keyb-switches
> +          - const: google,cros-ec-keyb
> +      - items:
> +          - const: google,cros-ec-keyb
>  

In such case matrix-keymap properties are not valid, right? The
matrix-keymap should not be referenced, IOW, you need to move allOf
below "required" and add:
if:not:...then: $ref: "/schemas/input/matrix-keymap.yaml

Best regards,
Krzysztof
