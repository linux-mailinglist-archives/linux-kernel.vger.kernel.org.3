Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A8B5A1460
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242646AbiHYOl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242660AbiHYOkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:40:35 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F55AB40C
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:39:10 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bt10so15546865lfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=nSmn/Yyj9DKCgM+N60piaxupqHYJ46TSL1XyqG6tkgg=;
        b=Gpy2x12/cadnPkLNfCGDF56/f5kbMRqU93C2pq1OcIEtF874xkVgIYDxNlwwdJJNCD
         vv98D8Ynh1WUvBuxTjwv2oxhIzKM/Kgle3k0HrvrpT9l+ZY1obHTplNbS4T8tUM3nTPn
         k5Qu9LeyBxZHRCldXOZvNNzwFfumnePA9MkoQIZbIkj/Pd57Pp25N7WYfBs7SHwH7QTe
         6bt7r1u0vhsqT9v/ao1gnuwZZZR4wxnfBmvScGpWHvuSkAkKRZqdb8rZKD0eo/AhRSvg
         peol75kJVd4Meln/E5Bf542LVPggxA6W8qD4alOZTvZzEr/ES71os+6B9NinFXAHy4Ee
         h8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=nSmn/Yyj9DKCgM+N60piaxupqHYJ46TSL1XyqG6tkgg=;
        b=hGEKLMqgoQq6cmkazWQh/wAqroANRVXDwLvqL+YEvYl7Ofze9e+85XcdP9vsSgmAQc
         ofBlT2lIYvp8kQw2h9/7TGuEbUderaKnZl8KRQ8kze0o8zKkWAFEJ0k78DNgwSjzY9DR
         gDFRmeLfPeocLPXYxd50W1QJgGo2PaskYK/TSi+3IgexVTNkv9uxT2EOsOvRNxOnBLvR
         DR++99fz4Bby4FG5T0FwnA9SLTAcsW/rTuKCtLf09b+Z6Jx9VOMFzczjGyJL24Q2QTNn
         z6GYv3/IdkD5GBfwNzXpnzOUbynOlVXG/MqkBBmvA24x4/Z8rA2uFWNqnf0EswMAt7co
         bGCQ==
X-Gm-Message-State: ACgBeo3QK4tFslimbSU9Z+jGm2CyJIGStNVpWD49KOviX7dY92dwSqiq
        +UbyYRDAXV3VI80Gj0WK7VYviQ==
X-Google-Smtp-Source: AA6agR67FCoHqMJJ4JUHZwutVBTI6wmpIj6U5TfJNwM72fQASqurH+pIT7bkkPMzerkMvAFNp+mmuw==
X-Received: by 2002:a05:6512:3b14:b0:492:dbf2:a5a0 with SMTP id f20-20020a0565123b1400b00492dbf2a5a0mr1217292lfv.46.1661438349297;
        Thu, 25 Aug 2022 07:39:09 -0700 (PDT)
Received: from [192.168.0.71] (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id b15-20020a05651c0b0f00b00261e42b463dsm594411ljr.84.2022.08.25.07.39.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 07:39:08 -0700 (PDT)
Message-ID: <f088f873-6e40-0548-77f3-378c87ecd812@linaro.org>
Date:   Thu, 25 Aug 2022 17:39:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2] dt-bindings: gpio: mpfs-gpio: allow parsing of hog
 child nodes.
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>, brgl@bgdev.pl,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220825143522.3102546-1-conor.dooley@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220825143522.3102546-1-conor.dooley@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/08/2022 17:35, Conor Dooley wrote:
> The SD card and eMMC on PolarFire SoC are sometimes muxed using a GPIO
> by the bootloader. Add a hog child property to facilitate this.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Changes since v1:
> - move addtionalProperties up under type:
> - drop the explicit match group syntax
> ---
>  .../bindings/gpio/microchip,mpfs-gpio.yaml     | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml b/Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml
> index 110651eafa70..fdc16822fd4b 100644
> --- a/Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml
> +++ b/Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml
> @@ -44,6 +44,24 @@ properties:
>  
>    gpio-controller: true
>  
> +patternProperties:
> +  "^.+-hog(-[0-9]+)?$":
> +    type: object
> +

No need for blank line, but it's ok as well.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
