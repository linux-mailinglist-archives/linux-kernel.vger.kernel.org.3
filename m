Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FC74E9F62
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 21:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245433AbiC1TGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 15:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240477AbiC1TGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 15:06:34 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261D826138
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 12:04:52 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id r7so8966244wmq.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 12:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZWOM0ViJyiVUZfrXv5W9VV5JgeOyviOZAZVjLWPXwZw=;
        b=nAI7p2HJfjHpqntcTQReQgjnoKjDA+zCAAzqZMEJ9LPBhGkBOiW5kXBW86fkHdopjc
         iZuSo+sC5BK1W5NpVq3mkEOykmq5R5bvInuo1SBT92TipqVku/EG6Xc0HMmJ26gugbZY
         YLtoQWhxrK/mYffFLtgrP+KePTrFHNYpSm/ZA18icWGzOCuj3gTjf8zDl8pO2JFWGC6L
         Cpqg5K6XrLwiNa/RbNBabfrqrySwz6gzaXrIYmGWWYaaifG6/p0OloPl6d93hWyI0BMs
         2PXxKamXx8tDBzX/X7giQs6bcHY/2YStHO+vN96BSuBkzfFFmozZV6R+UQG3DTvZKh5A
         5KlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZWOM0ViJyiVUZfrXv5W9VV5JgeOyviOZAZVjLWPXwZw=;
        b=ilRaSps/x7GiEghtXbscaLugsKSTX1iXX39dOTOJKzJwliXlG8q33OhoUJE4Ha87Bx
         tWuvU7siNM9wX1VTwVazk/I5Swomb7aGMS7YALmqFbQf+KofG3+E0pxWSOzFQazCZRoy
         kzMt+tVsdCcR/6t2AL9SNMCBXeuoZ6sSH0iNZfK4+I0UIwrUp0tCcaPzbaygJ2RRicBh
         mJCx3VBQpEhfRV4bIbyb6kIYWFb+XQ+hHLMBnzFpueAOU1nubCz952q3kC1vJgG4TrEr
         gqiHfcwuLhmGtxCslcaBPcfaE+di6PQd53FSb/1NXCK5f6LWSgfcdtOwpRB21t14U/P9
         Lftg==
X-Gm-Message-State: AOAM533ztyR6BjrNPX3rZBqJoJp/FHlOvJMcDP0Xhx5iMbk1VG12h3mI
        cNg+neDmNx/+z7GLMsWr6kVpYA==
X-Google-Smtp-Source: ABdhPJyI8bbkl32W0f/Fs3gwfDAYhpU9jfBTsBbXSGzduC32W7r6dq+GpfB1T0yZpFALl2pYjBkf3A==
X-Received: by 2002:a05:600c:a0b:b0:389:dd65:66f1 with SMTP id z11-20020a05600c0a0b00b00389dd6566f1mr843831wmp.95.1648494290725;
        Mon, 28 Mar 2022 12:04:50 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b0038cb8b38f9fsm273855wmq.21.2022.03.28.12.04.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 12:04:49 -0700 (PDT)
Message-ID: <9f7355de-8154-7ff2-ce29-c89ccfb89cab@linaro.org>
Date:   Mon, 28 Mar 2022 21:04:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: gpio: uniphier: Add hogs parsing
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1648430916-21988-1-git-send-email-hayashi.kunihiko@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1648430916-21988-1-git-send-email-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2022 03:28, Kunihiko Hayashi wrote:
> Allow parsing GPIO controller children nodes with GPIO hogs to fix the
> following warning:
> 
>   uniphier-ld11-ref.dtb: gpio@55000000: 'xirq0-hog' does not match any of the regexes: 'pinctrl-[0-9]+'
>       From schema: Documentation/devicetree/bindings/gpio/socionext,uniphier-gpio.yaml
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../devicetree/bindings/gpio/socionext,uniphier-gpio.yaml  | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/socionext,uniphier-gpio.yaml b/Documentation/devicetree/bindings/gpio/socionext,uniphier-gpio.yaml
> index bcafa494ed7a..b6f5963a2ae6 100644
> --- a/Documentation/devicetree/bindings/gpio/socionext,uniphier-gpio.yaml
> +++ b/Documentation/devicetree/bindings/gpio/socionext,uniphier-gpio.yaml
> @@ -52,6 +52,13 @@ properties:
>        <child-interrupt-base parent-interrupt-base length> triplets.
>      $ref: /schemas/types.yaml#/definitions/uint32-matrix
>  
> +patternProperties:
> +  "^(.+-hog(-[0-9]+)?)$":

The outer () are not needed.

> +    type: object

You need also properties. See for example:
Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml

> +
> +    required:
> +      - gpio-hog
> +
>  required:
>    - compatible
>    - reg


Best regards,
Krzysztof
