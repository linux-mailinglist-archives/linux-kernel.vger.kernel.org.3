Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282245A14D6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242217AbiHYOtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242122AbiHYOto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:49:44 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E461B285F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:49:43 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id l8so11041138lfc.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=zQBjygS8SCHVF5NWTeRq0S8WBLCqlWIJPLS18A425Jo=;
        b=HLeBSz4kbNvFBK2P5M3BUEWz5YfE1cWTZpxBfcHVg0Xm22DwGf4nM4lNhaKlqKUtTY
         HCG9RVM+gXQMICAR0zuPCPaBxObGxiLDo7tW3/b8Z5aAGl03tj4gcK1awwCxqf98T2kP
         N7AWdUaPU0tpFqwfuiEeviuIA8S5Voofy58ouGqN6E9NFYDl6PO7K3Qhp2u4fPKVEUGz
         z9GNZNcE6iQK0Hjx/kKvJM1kP5/kmNcKVnWAzf7k4sboEACFOSLnB2Rw68p9/3RAwrLx
         6gcZiSpR/wljBf827mhfo9engPN0aQHEsBLwPADZmXOyiLSnS5XXjqEFw+JXRviBex5Y
         zEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=zQBjygS8SCHVF5NWTeRq0S8WBLCqlWIJPLS18A425Jo=;
        b=ZKICsf9QxVypilMpDyBvUX/JkHwqxKSjyZfvwRB3oU6lmeJjBu1jUbKOdcnvmZzPGI
         nEOQvQX0KEk4+MAjgkejqU/cFq2XrTcXFyEVI5PEM01eCF+QsftumO25lyVdTtmr9rLi
         PAwI0U6VuTjzNHoEGQLoBYHd82iujAnYie7xcVxONfptlrU6/OEu41DNtFbm22k9Ir2D
         K64mnwhQIp1eYGKmZD4FKzuiUdU1EL7D7NP68FTgfcHfzYvhvwlkM7HYAEgbOTlUEuhB
         4yfaSPzhA4ol6d55ZhTQjJD+6878PUpBBpQfeXczGMzurDjhi0GDFlsOOg6ZYeKP6AJA
         HZyA==
X-Gm-Message-State: ACgBeo0XzteR7S4BcHgXqv5JrgCdiugpPnbQeTS1DOBTheuOKvjk1v2i
        6QhVD1PIiJkxzkZzTP4N/Dnnsg==
X-Google-Smtp-Source: AA6agR4nHsUMcKPDNfT/Ev+u7ZNpF9ElXAOXYDZRDAdUrPqz6QvM9j3oewQPKa33v+Q+8QyiBiPSqw==
X-Received: by 2002:ac2:515c:0:b0:492:df83:8bc1 with SMTP id q28-20020ac2515c000000b00492df838bc1mr1167327lfd.620.1661438981469;
        Thu, 25 Aug 2022 07:49:41 -0700 (PDT)
Received: from [192.168.0.71] (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id k4-20020a05651210c400b0048d1101d0d6sm532399lfg.121.2022.08.25.07.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 07:49:40 -0700 (PDT)
Message-ID: <b731087b-a6f9-044a-783c-c78129474cd5@linaro.org>
Date:   Thu, 25 Aug 2022 17:49:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 1/2] Documentation: devicetree: update bindings for
 tps23861
Content-Language: en-US
To:     =?UTF-8?Q?Andreas_B=c3=b6hler?= <dev@aboehler.at>
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220825143737.77732-1-dev@aboehler.at>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220825143737.77732-1-dev@aboehler.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/08/2022 17:37, Andreas Böhler wrote:
> The tps23861 driver does not initialize the chip and relies on it being
> in auto-mode by default. On some devices, these controllers default to
> OFF-Mode and hence cannot be used at all.
> 

Thank you for your patch. There is something to discuss/improve.

> This brings minimal support for initializing the controller in a user-
> defined mode.
> 
> Signed-off-by: Andreas Böhler <dev@aboehler.at>

Use subject prefixes matching the subsystem (git log --oneline -- ...).

> ---
>  .../bindings/hwmon/ti,tps23861.yaml           | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml b/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
> index 3bc8e73dfbf0..ed3a703478fb 100644
> --- a/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
> @@ -35,6 +35,50 @@ required:
>    - compatible
>    - reg
>  
> +patternProperties:
> +  "^port@([0-3])$":

No need for ()

> +    type: object
> +    description: Represents ports of the device and their specific configuration.
> +
> +    properties:
> +      reg:
> +        description: The port number
> +        items:
> +          minimum: 0
> +          maximum: 3
> +
> +      mode:
> +        description: The operating mode the device should be initialized with
> +        items:

If this is real array, you need maxItems, but it looks one item, so no
need for "items".

> +          - enum:
> +              - auto
> +              - semiauto
> +              - manual
> +              - off

And how "off" is different from disabled or powered off?

> +
> +      enable:
> +        description: Whether the port should be enabled

This looks confusing... Looks like boolean property, but instead you
define some numbers. What are the values for these numbers? Why these
are numbers not booleans?

Second - what does it mean "enable"? We have a generic "status" property
for it - isn't this the same?

Third, all these properties (especially PoE) look like you keep
describing here network device but this is HWMON part.

> +        items:
> +          minimum: 0
> +          maximum: 1
> +
> +      power:
> +        description: Whether the port should be powered on
> +        items:
> +          minimum: 0
> +          maximum: 1
> +
> +      poe_plus:

No underscores in property names.

> +        description: Whether the port should support PoE+
> +        items:
> +          minimum: 0
> +          maximum: 1
> +


Best regards,
Krzysztof
