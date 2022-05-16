Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D69528861
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245137AbiEPPUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238130AbiEPPUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:20:07 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADDE3BBE4;
        Mon, 16 May 2022 08:20:06 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so20489730fac.7;
        Mon, 16 May 2022 08:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mANvH5Glg28X27DbDs60K/K1FoGHkBM8nBp++djQ2O0=;
        b=x9P/ftnRTcMKDchJpERMlydWaxFD2ZovAasbYh72G/DMoO8gFJC0fhx9bK1gGPVp7M
         spfbcWCwyjCbcJfkbsXPJs2u2F6wIod4KN6LXfeS/WHMNCHItOimTSmEC5i9dLjNOB/Z
         +JA0WnGL1IRY57Vukzudcz9c9qsCeRUWivxmylLIsENfzDV5TSgYhS12gP2q6UWlCVUJ
         iPrhT0opMsLwPnUqsYbjvjtiu0IygKFWGvkPqhGLFadF4EOOQ+IhzKV1ZStEqfRh6ORm
         xapExn1BKkb5roj/2jxmLKz3JpCRV7chmETgVamoE5dOGpM6HCsuQ9LLS5q9Qx/3w2Mg
         ofwg==
X-Gm-Message-State: AOAM530wFYlADfpwiAzQiZQTjL4/2u6pisqLnHfxH+AT2a3tU5adudq1
        hxmQRhf6suWjTM6p3AOCPw==
X-Google-Smtp-Source: ABdhPJw5Z0T6XyGQu+b4aaUc0XyVQeiKkr66PyaL0uiv7QPaF70Yk5G2072wzEbdHmH127RpqVyIPA==
X-Received: by 2002:a05:6870:80d4:b0:f1:8f10:f741 with SMTP id r20-20020a05687080d400b000f18f10f741mr4339845oab.124.1652714405331;
        Mon, 16 May 2022 08:20:05 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a13-20020a4a988d000000b0035eb4e5a6bfsm4250166ooj.21.2022.05.16.08.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 08:20:04 -0700 (PDT)
Received: (nullmailer pid 2666110 invoked by uid 1000);
        Mon, 16 May 2022 15:20:03 -0000
Date:   Mon, 16 May 2022 10:20:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        chrome-platform@lists.linux.dev,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Craig Hesling <hesling@chromium.org>,
        Tom Hughes <tomhughes@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 3/3] dt-bindings: cros-ec: Add ChromeOS fingerprint
 binding
Message-ID: <20220516152003.GB2659134-robh@kernel.org>
References: <20220512013921.164637-1-swboyd@chromium.org>
 <20220512013921.164637-4-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512013921.164637-4-swboyd@chromium.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 06:39:21PM -0700, Stephen Boyd wrote:
> Add a binding to describe the fingerprint processor found on Chromebooks
> with a fingerprint sensor. Previously we've been describing this with
> the google,cros-ec-spi binding but it lacks gpio and regulator control
> used during firmware flashing.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: <devicetree@vger.kernel.org>
> Cc: <chrome-platform@lists.linux.dev>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Craig Hesling <hesling@chromium.org>
> Cc: Tom Hughes <tomhughes@chromium.org>
> Cc: Alexandru M Stan <amstan@chromium.org>
> Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  .../bindings/mfd/google,cros-ec.yaml          | 80 ++++++++++++++++---
>  1 file changed, 71 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> index 409ecef967ce..e5fe60beb9fe 100644
> --- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> +++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> @@ -19,15 +19,19 @@ description:
>  properties:
>    compatible:
>      oneOf:
> -      - description:
> -          For implementations of the EC is connected through I2C.
> -        const: google,cros-ec-i2c
> -      - description:
> -          For implementations of the EC is connected through SPI.
> -        const: google,cros-ec-spi
> -      - description:
> -          For implementations of the EC is connected through RPMSG.
> -        const: google,cros-ec-rpmsg
> +      # For implementations of the EC is connected through I2C.

Using 'description' was preferred.

> +      - items:
> +          - const: google,cros-ec-i2c
> +      # For implementations of the FPMCU connected through SPI.
> +      - items:
> +          - const: google,cros-ec-fp
> +          - const: google,cros-ec-spi
> +      # For implementations of the EC is connected through SPI.
> +      - items:
> +          - const: google,cros-ec-spi
> +      # For implementations of the EC is connected through RPMSG.
> +      - items:
> +          - const: google,cros-ec-rpmsg
>  
>    controller-data:
>      description:
> @@ -132,6 +136,15 @@ properties:
>  
>      additionalProperties: false
>  
> +  reset-gpios:
> +    maxItems: 1
> +
> +  boot0-gpios:
> +    maxItems: 1
> +    description: Assert for bootloader mode.
> +
> +  vdd-supply: true
> +
>  patternProperties:
>    "^i2c-tunnel[0-9]*$":
>      type: object
> @@ -176,6 +189,37 @@ allOf:
>          - reg
>          - interrupts
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: google,cros-ec-fp
> +    then:
> +      properties:
> +        '#address-cells': false
> +        '#size-cells': false
> +        typec: false
> +        ec-pwm: false
> +        keyboard-controller: false
> +        proximity: false
> +        codecs: false
> +        cbas: false
> +
> +      patternProperties:
> +        "^i2c-tunnel[0-9]*$": false
> +        "^regulator@[0-9]+$": false
> +        "^extcon[0-9]*$": false

Is the list of what's allowed shorter? If so, you could list those 
properties and use 'additionalProperties: false'.

Or maybe this is a sign that this should be a separate schema document.

> +
> +      required:
> +        - reset-gpios
> +        - boot0-gpios
> +        - vdd-supply
> +    else:
> +      properties:
> +        reset-gpios: false
> +        boot0-gpios: false
> +        vdd-supply: false
