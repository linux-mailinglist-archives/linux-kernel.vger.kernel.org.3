Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE675534B2C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 10:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346565AbiEZIGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 04:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244339AbiEZIGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 04:06:19 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99019FD33
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 01:06:17 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id t26so911288edt.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 01:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=sUkmzj/ADcLd5/ZTwCBIMC1VkofTmfRrB5QzPtIaDYU=;
        b=v+j82K8mfWplzPhJgQTvvkdsrW4ep2fg0akniwwQRvQGw1N1vv6rzKO8bLSE87v6RH
         qHY7bpwZM4pu3NQ1CWJElgwg7x4jSDN38D7qilYSji7vcXlebCDtj6I7jFHSHQiC0HVM
         HA16tLdBsMZV6BPjfg2vFdSOUvYRdf4YiRQxFFGyJZB3RXTGPuY1Ie8jQ0HMAnqScPzE
         cGHhqogr+jYP5YubxOScrh6Q0O0ip+lfBTf9CC2M1W34s5MYT4O177ip0u7YSIzThoku
         ZSIu7YadVYQRnw71EncaJBmsf3GGQwvvnSPsKVhggXGFGntOmSVEUsDJDxW89x6vRzDv
         iPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sUkmzj/ADcLd5/ZTwCBIMC1VkofTmfRrB5QzPtIaDYU=;
        b=Ygh0KEtdEzezJvH82nOibo8PG/G213DN38r/bv3oATjVboDU5yeXqHznECdPRMtV5e
         MGfyxStK/Sn3jjufb5YOiLMQWbZV1AIlvEiw4UVT/FPVI+t1UwH8lM1CQPozFL5s8KaA
         x9ufuvr9tUGkzwg42Cn5CACPkriEbjgHjtN+bJ1vWOmE9yVm68J9IWEjCw/dTlQJSh5t
         vmyXa53BRR2TyqOHobXnWfCloMpT68LjkpNAtP58MLueCzp8vyb842gm3wCHyrLgJVRo
         y/K0IQWN7DjHzihEnjgAZ6gAN5VV5HgaGNRm194gBvWlYXz+dRz0mihgz9hDyn5lk6Jw
         /sTw==
X-Gm-Message-State: AOAM530XnADYteeKBrL3kewzKvOINeEGBWT4m6hcelqcWfvVecAvr+bz
        GbUr9/iWBVjIbkZDu91DwJ5kNw==
X-Google-Smtp-Source: ABdhPJxWjuIfxzMKDXFsg01+5Vhg8sivYXhTKhgry/uxO/ijt7GFzDqruEKAGFJicT2JghXL094i6Q==
X-Received: by 2002:a05:6402:34c1:b0:42b:4047:20b8 with SMTP id w1-20020a05640234c100b0042b404720b8mr26707436edc.88.1653552376113;
        Thu, 26 May 2022 01:06:16 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u10-20020a50950a000000b0042617ba63a5sm458132eda.47.2022.05.26.01.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 01:06:15 -0700 (PDT)
Message-ID: <1c7ab94c-a736-c629-bd8c-8a974803e2b9@linaro.org>
Date:   Thu, 26 May 2022 10:06:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] dt-bindings: backlight: rt4831: Add the new property
 for ocp level selection
Content-Language: en-US
To:     cy_huang <u0084500@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee.jones@linaro.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     pavel@ucw.cz, deller@gmx.de, cy_huang@richtek.com,
        lucas_tsai@richtek.com, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1653534995-30794-1-git-send-email-u0084500@gmail.com>
 <1653534995-30794-2-git-send-email-u0084500@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1653534995-30794-2-git-send-email-u0084500@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/2022 05:16, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add the new property for ocp level selection.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  .../bindings/leds/backlight/richtek,rt4831-backlight.yaml         | 8 ++++++++
>  include/dt-bindings/leds/rt4831-backlight.h                       | 5 +++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
> index e0ac686..c1c59de 100644
> --- a/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
> +++ b/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
> @@ -47,6 +47,14 @@ properties:
>      minimum: 0
>      maximum: 3
>  
> +  richtek,bled-ocp-sel:

Skip "sel" as it is a shortcut of selection. Name instead:
"richtek,backlight-ocp"


> +    description: |
> +      Backlight OCP level selection, currently support 0.9A/1.2A/1.5A/1.8A

Could you explain here what is OCP (unfold the acronym)?


Best regards,
Krzysztof
