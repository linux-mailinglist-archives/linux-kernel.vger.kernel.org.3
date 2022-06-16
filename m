Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA2654E2A6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 15:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377365AbiFPN5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 09:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbiFPN5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:57:03 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1601646C90
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 06:57:03 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id s135so1300522pgs.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 06:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WF4lAn49sjJB9tDcffvKOR2ZsYx014rUPjpNYWe2CH4=;
        b=n1wLv515CJx4S59bI6gUm/jJzYE1Jd4ZyAEjXYZY41fVhqp0NKiqt1/QkpPk1D8t82
         iuMkt6sHeax+j1qVZLhL8P9r910GR29TsPcyG7zghs7Ifd1tgKZ16/3DDAi4smkoKOxP
         Esri746E8NxIhzUMoDZT/xDm89MVNCHpLxf2Wiu0m+w3vUNUhaaPneZg/8bqliICfZkp
         t6YRYoINqDoA2xIX7/ZqzCzF2N8+cH7NITpfqyKhEclO+zJ2HNeXjaXOobyxPW3J/UT/
         RIWVO8F9JCy+oiYbnClKxhyepZU6oLJPWlUTAymbkx5n3TGn2CG+1g09mtAmsUrK1k5A
         GpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WF4lAn49sjJB9tDcffvKOR2ZsYx014rUPjpNYWe2CH4=;
        b=4HSa5DscYmE9uexGtO7dajIqVuSJeTtxtbnw0AElkUY2FgdV4vFrLJLx/xTT6xMgsw
         lBubJLDD+fkjoAkaQIlnADqp1xgeR+CL6x9FNkVq5CwM5TcorEerT0DgTcQLOGy8GEG0
         P81DVnabnepGLIZcqwKcFjuhdftdWlVizlKQl1tWqAEmKsqweoObCkinQ3bKZDhX5oH2
         WVyL0eZp6uljyjihdD6/xuLzqZfLuWhpp5V6H4cWGIdZkLKv9TfRdQ47of6voZoRSYKS
         d+ZQWDg7QkcD62evZ8Fm88wP7O8uZx2U1TLgLZRkKvV8l2PLe/5FF8ozJ+/zy1F30ewq
         XjSw==
X-Gm-Message-State: AJIora8IBeeiypmnOFXfjV/qWHJWNrmoffwiwgY9NpMlVNo42LPGgjuN
        PJAx+HWNdm6JGlfCrOXHj+BjAv1KFBQNOA==
X-Google-Smtp-Source: AGRyM1sHbtQQLESsZ+61Z/D9ovq2bt4L/GoaAb4iwdCOR9MeEktPEh/7EQdFda5Tek+t1qulAbQlmQ==
X-Received: by 2002:a05:6a00:a16:b0:518:ffe0:7229 with SMTP id p22-20020a056a000a1600b00518ffe07229mr5022001pfh.49.1655387822594;
        Thu, 16 Jun 2022 06:57:02 -0700 (PDT)
Received: from [172.20.0.255] ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id jd12-20020a170903260c00b0015e8d4eb1dbsm1693992plb.37.2022.06.16.06.57.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 06:57:02 -0700 (PDT)
Message-ID: <b12be0e9-4fbe-ff92-6a75-ab65dbaf5160@linaro.org>
Date:   Thu, 16 Jun 2022 06:57:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/4] dt-bindings: gpio: Add AXP221/AXP223/AXP809
 compatibles
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org
References: <20220616060915.48325-1-samuel@sholland.org>
 <20220616060915.48325-2-samuel@sholland.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220616060915.48325-2-samuel@sholland.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/2022 23:09, Samuel Holland wrote:
> These PMICs each have 2 GPIOs with the same register layout as AXP813,
> but without an ADC function.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  .../devicetree/bindings/gpio/x-powers,axp209-gpio.yaml     | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/x-powers,axp209-gpio.yaml b/Documentation/devicetree/bindings/gpio/x-powers,axp209-gpio.yaml
> index 0f628b088cec..6faa3ef28960 100644
> --- a/Documentation/devicetree/bindings/gpio/x-powers,axp209-gpio.yaml
> +++ b/Documentation/devicetree/bindings/gpio/x-powers,axp209-gpio.yaml
> @@ -19,7 +19,14 @@ properties:
>      oneOf:
>        - enum:
>            - x-powers,axp209-gpio
> +          - x-powers,axp221-gpio
>            - x-powers,axp813-gpio
> +      - items:
> +          - const: x-powers,axp223-gpio
> +          - const: x-powers,axp221-gpio
> +      - items:
> +          - const: x-powers,axp809-gpio

This is just an enum with 223 and 809. No need for two separate entries
here.

> +          - const: x-powers,axp221-gpio
>        - items:
>            - const: x-powers,axp803-gpio
>            - const: x-powers,axp813-gpio


Best regards,
Krzysztof
