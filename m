Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FABB52E86C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 11:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347478AbiETJL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 05:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347605AbiETJLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 05:11:11 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED3BDF0F;
        Fri, 20 May 2022 02:11:09 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id i66so9258834oia.11;
        Fri, 20 May 2022 02:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n78l5RlYFGeFo4MNBVlJMHVJSe7vOSqvMkjGVeopbig=;
        b=SwRH/flpGWQ2Cjxfcl7aQ6iDtBJyYD3zwaVhLcN9vDRZYNUwQEmQEfDwDDHtGESIHt
         DmGc7TmTv4/Fuk2X5DKsr1idacAf95OYtl7BwBzC5Fq2vENwIUpQqpNifA17YPrXO0Z8
         ITVd+8udxyXmidvtnSreiZUp35RyW+8voqGVbJE5TaWx12HIV+q4LQJaZ3avu80aJ2Co
         RCerbuxw3XODbvNoO7HNNtQblji3GNCOPxwPJvakefQJOHdmL7/5Q7Ghe8oUyN5vq1U8
         +jflJ8KxTSZyoxRqfkjsJgXn88IQi1JmmtXtnyyklb4tJEt3YNtKDMd3TZGC4tegTxnO
         oeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n78l5RlYFGeFo4MNBVlJMHVJSe7vOSqvMkjGVeopbig=;
        b=0hjdHYWFwuh61CaLiZRd3f/uFYzuQOQ69zBNWc1NTgxHuBbLQgUGp9KlL7LhsuekaZ
         jqT5BsH9VpALvPl/wqo5lV+HkC8sbqo+o/1L0902yWkuRHTQzQqj5lKcD6JRMQwuX/Ku
         KVFVk6jqp4hO/ZodVyQYXtMEdJviQY9NWKLNeg5HdH+iNGtAbCpcS88KJ7qaQT0xCaFl
         q+CZuXFFGiRrcgm8KmVL3el0/WHF7LHh1cHm4icnxDdaaJidxz2xSuuYRdzOx078A5/L
         LPXKGlI9NcqTuRD0bOopth5NQlSf/YnYTk2SPzBwVXB+kzBtopph09U8Y7FIL+3b5yUR
         HKiQ==
X-Gm-Message-State: AOAM530b7Fcma4IWsE3SY3QXu0Vlk0VBWSwlbhunm/mIYmfgCJBu3P7Y
        yxgmrl5qiS2Wznkwg6N1CjI=
X-Google-Smtp-Source: ABdhPJy7QDmOM+GL7OEQ0lEPwD3lfsn1zoQ2XabM9gR0n5SIf16UEH3vIb+NvgbcTT5Smwg/6andnQ==
X-Received: by 2002:a05:6808:13c3:b0:328:da83:aaeb with SMTP id d3-20020a05680813c300b00328da83aaebmr5213414oiw.184.1653037868747;
        Fri, 20 May 2022 02:11:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v5-20020a056870954500b000e9364288bfsm685962oal.45.2022.05.20.02.11.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 02:11:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6e0f7f48-ecfd-16be-8672-aa4ba11b0c91@roeck-us.net>
Date:   Fri, 20 May 2022 02:11:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] dt-bindings: watchdog: toshiba,visconti-wdt: Update
 the common clock properties
Content-Language: en-US
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, yuji2.ishikawa@toshiba.co.jp,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>
References: <20220520090024.620928-1-nobuhiro1.iwamatsu@toshiba.co.jp>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220520090024.620928-1-nobuhiro1.iwamatsu@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/22 02:00, Nobuhiro Iwamatsu wrote:
> The clock for this driver switched to the common clock controller driver.
> Therefore, update common clock properties for watchdog in the binding document.
> And this matched this example with the actual dts.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>   .../bindings/watchdog/toshiba,visconti-wdt.yaml     | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/toshiba,visconti-wdt.yaml b/Documentation/devicetree/bindings/watchdog/toshiba,visconti-wdt.yaml
> index 690e19ce4b87..52c0e0c022ea 100644
> --- a/Documentation/devicetree/bindings/watchdog/toshiba,visconti-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/toshiba,visconti-wdt.yaml
> @@ -35,20 +35,15 @@ additionalProperties: false
>   
>   examples:
>     - |
> +    #include <dt-bindings/clock/toshiba,tmpv770x.h>
> +
>       soc {
>           #address-cells = <2>;
>           #size-cells = <2>;
>   
> -        wdt_clk: wdt-clk {
> -            compatible = "fixed-clock";
> -            clock-frequency = <150000000>;
> -            #clock-cells = <0>;
> -        };
> -
> -        watchdog@28330000 {
> +        wdt: watchdog@28330000 {
>               compatible = "toshiba,visconti-wdt";
>               reg = <0 0x28330000 0 0x1000>;
> -            clocks = <&wdt_clk>;
> -            timeout-sec = <20>;
> +            clocks = <&pismu TMPV770X_CLK_WDTCLK>;
>           };
>       };

wdt: isn't needed in the example, and I question if it
really improves the quality of the example to remove
timeout-sec.

Guenter
