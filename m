Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B8E4FAE2A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 16:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239728AbiDJOSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 10:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbiDJOST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 10:18:19 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015A03BF9B
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 07:16:06 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id g18so1015393ejc.10
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 07:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+Ier55YBq9PNXban+FxSvSragDYPhYPa5evEDXq/Fig=;
        b=VXS41Q2rOvE4Ds0Sb8/throKElXhXYFYdLPD2TOODisPypChyK2EdZGnQ9nI3Uiaft
         wQTZwA02Whk5jsj59qPhldaBI6sINF4EN4OMfx3BtAdsDWhWdtPfHqzIA46FPNL4okob
         8JSG3Y9pmZJ7zNNBMb0/b74yPOV3dJ33RN+9XF0Zpe1VW9KlZDJnD3RASREkmhk5PiaQ
         NGwSft2kTOs1ItjA4FFuG5bUU/ZGYRNuTmDco9eRXanTVFtf24Yi/oaCAas0xTw4KKbq
         COiRu7PDBoCZhR71sm7jFNzCajya62uuo1eHbWZpTToj5mQOaGWBYFfjzghRuzxUum6x
         bo7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+Ier55YBq9PNXban+FxSvSragDYPhYPa5evEDXq/Fig=;
        b=ftylEUK7FMdbh+JYVZKDtXX8UjCZGe13rgfpcHrD4UpKh8ySd6PU/MDaQhUmxdq+rG
         PBBNgFBRT1++9VDt7pZ/0/olvxz/cDkuBcT6bS8pz8OSjEmTblvMz8H0KE45WCB4JBsf
         c/k/zjbcnQVISjLGyt8XWAB353dHvHvyyCAEfjnLImEjC4Hc9UMPCGHdd/4nD24UvkjG
         +J4/GRyLlwA7ycL0xONZUuMYCbcVZ6E1cYGNIkXRx7oOLt8ygz/ieOO7388Gw8/h/rzD
         g/X5pbT56r9bFOq/+zJ3u2pTN7JEUHZ/AUwAXgvewRmuErLl3jJpvPkbIEYGzemDhcC2
         +5IA==
X-Gm-Message-State: AOAM5306h7nSa2+rSzhzs8diTWdPi6JO9ho5AeCu7zHll3XayWYlr7NJ
        9KcEqbZYC5gid+gCokyGmDl09A==
X-Google-Smtp-Source: ABdhPJzxe2slplshlwQ1W1F6InK0Nb005BmkiOZEL7lFbVsYAFgraYsxv06pLKpb5tSKR1gIsEhcSw==
X-Received: by 2002:a17:907:3e0d:b0:6e0:daaa:63e0 with SMTP id hp13-20020a1709073e0d00b006e0daaa63e0mr26169491ejc.657.1649600165519;
        Sun, 10 Apr 2022 07:16:05 -0700 (PDT)
Received: from [192.168.0.188] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id t19-20020a056402525300b0041952a1a764sm13592317edd.33.2022.04.10.07.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Apr 2022 07:16:04 -0700 (PDT)
Message-ID: <edfc1f7c-3083-7f0d-dc18-e9ab36c2dc9a@linaro.org>
Date:   Sun, 10 Apr 2022 16:16:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v1 1/6] dt-bindings: gpio: realtek-otto: Add rtl9300
 compatible
Content-Language: en-US
To:     Sander Vanheule <sander@svanheule.net>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Bert Vermeulen <bert@biot.com>, linux-kernel@vger.kernel.org
References: <cover.1649533972.git.sander@svanheule.net>
 <7dfad6c63cea64ccd84907f1cf9f7c9c6d1ce3e9.1649533972.git.sander@svanheule.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7dfad6c63cea64ccd84907f1cf9f7c9c6d1ce3e9.1649533972.git.sander@svanheule.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2022 21:55, Sander Vanheule wrote:
> Add the "realtek,rlt9300-gpio", "realtek,otto-gpio" compatible for GPIO
> nodes on the RTL930x SoC series. This SoC requires an extra register
> range, defining the interrupt CPU mapping registers.
> 
> Signed-off-by: Sander Vanheule <sander@svanheule.net>
> ---
>  .../bindings/gpio/realtek,otto-gpio.yaml      | 33 +++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/realtek,otto-gpio.yaml b/Documentation/devicetree/bindings/gpio/realtek,otto-gpio.yaml
> index 100f20cebd76..3c511e9af377 100644
> --- a/Documentation/devicetree/bindings/gpio/realtek,otto-gpio.yaml
> +++ b/Documentation/devicetree/bindings/gpio/realtek,otto-gpio.yaml
> @@ -28,10 +28,10 @@ properties:
>        - enum:
>            - realtek,rtl8380-gpio
>            - realtek,rtl8390-gpio
> +          - realtek,rtl9300-gpio
>        - const: realtek,otto-gpio
>  
> -  reg:
> -    maxItems: 1
> +  reg: true
>  
>    "#gpio-cells":
>      const: 2
> @@ -50,6 +50,23 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +if:

You could put it under allOf:, so if you ever need to extend it, you
don't mess with the indentation, but it's fine as it is.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
