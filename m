Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7915A4EBB6B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 09:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243602AbiC3HGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 03:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238606AbiC3HGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 03:06:37 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D8CE1240
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 00:04:51 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id a17so23266782edm.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 00:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PxRWqm3rnpFLGrWU5JqDAPNolxFCPocPImxQoA5xqOc=;
        b=O1QpS3M8gBG8es3mcBM6JlyFWmfyi+XsiLthiu82vHSqL+/CACsmDsKasu4AiaSeSG
         TikQdM1udFooOOoQpH9elhb9hg6JEtCT2yDpGYWtoVOTjduHZrtgrIidONthTvV5LW6a
         61m259KGZr0SI4xr3H6Es/pX0WEzlAAoFZLLlvjC/h7ZL0UlXKp+FjI/Sx89ylkRNEdZ
         6XGtmAVHiO9c4V+qXE6VmsD+SEzT7MZVxVAmkz4dKpnFSwKFRR0x6mk5lN41/gSDrCi1
         7/D9hHLs5CxAbQV5DzK/QL9RJLEDlmZQ/LYBzZ2Wze0/AYuEi91rcWobS3ZNrAifrmyk
         iBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PxRWqm3rnpFLGrWU5JqDAPNolxFCPocPImxQoA5xqOc=;
        b=BoTOyvwl6vZ4ZBSdSFuYw+RpZ7PzotVxx57Ywy+H+CRYtnwNtqNM+Edrh4mmklJFG+
         SFOoPlo/sP8bgqyb44fJHtNXaDQDiaszZI0Hp7ImdyxKpmsU49QSWsxMeoVqvi4aHUeD
         ar2fO/xUiD9jo+qWCBymfMledIIZY2mwvckq5QGLwBtaP9P+OJ5KoF3yWa5LHkXRfOsQ
         pPEsPyo45i0RQUFNMwaoOnD4OOhTURWSxfYi5ektyfdA9b2KP+J5imOAa9P7qcVn2qIm
         ZdJ8Q/Hgp/8NGtpvXq26RFQrzOZAPfvl4t+qjd8ZOELwgAlNxwWQLDRe8cawDb1er1WJ
         iy2Q==
X-Gm-Message-State: AOAM533sXF9zMJPC12bh+cZ62K4ppVi7+cFZ9peYgB+c7MA3BFApmOpb
        69LAaY4Z+tiV2iemBji49PYa1w==
X-Google-Smtp-Source: ABdhPJwIXfShLJZQUrVg5NGV9VAbyRRwy3qoOYtRWClHR3idou8IMC8yKvq2rn4dWNEp/IWpHxXayw==
X-Received: by 2002:a05:6402:2318:b0:413:7645:fa51 with SMTP id l24-20020a056402231800b004137645fa51mr9199019eda.201.1648623890308;
        Wed, 30 Mar 2022 00:04:50 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id u26-20020a05640207da00b00419a14928e5sm7395555edy.28.2022.03.30.00.04.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 00:04:49 -0700 (PDT)
Message-ID: <32c99412-3b65-c52b-8417-efae9245ffb8@linaro.org>
Date:   Wed, 30 Mar 2022 09:04:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] dt-bindings: gpio: uniphier: Add hogs parsing
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1648617423-8739-1-git-send-email-hayashi.kunihiko@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1648617423-8739-1-git-send-email-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2022 07:17, Kunihiko Hayashi wrote:
> Allow parsing GPIO controller children nodes with GPIO hogs to fix the
> following warning:
> 
>   uniphier-ld11-ref.dtb: gpio@55000000: 'xirq0-hog' does not match any of the regexes: 'pinctrl-[0-9]+'
>       From schema: Documentation/devicetree/bindings/gpio/socionext,uniphier-gpio.yaml
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
> 
> Changes since v1:
> - Remove outer brackets from a pattern string
> - Add valid properties to patternProperties
> - Add gpios to "required:"
> 
>  .../bindings/gpio/socionext,uniphier-gpio.yaml  | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
