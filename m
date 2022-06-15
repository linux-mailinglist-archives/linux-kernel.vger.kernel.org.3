Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E5454C298
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 09:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243716AbiFOHZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 03:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbiFOHZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 03:25:11 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D4746B0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 00:25:10 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id a10so5808368wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 00:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NGo4rRV+VZvdT0hcJzW6pnymtoNuY20VyL3BfwK+vsQ=;
        b=PPDREC5zr0fQXQ7G6MaJZgrNi8eSCMpiZLg0TLXmzGOZkcQ5lnGffm023x8RCrxWnm
         0RHnRsCqEQzwRyNVN+EB6znWpMbNwxPeK4kIENpN1ToeaJOJtChy43E4gtApGwIt1YuI
         xISMw3GYeul6bBNJp0m8wvNTxY8bjsBTz6OHqjPv0UGy1Y/r/Xzp1XCeOuE8k5LlY2XI
         GBC3UFDN9aI+z1txwK0jrMlSQnOLOJUJqbTHRgybPZKzFfSI/ygaSlIhzbi4y4+NLHfV
         YxvcwyVon3TauHB+J6R0ejkDHVM7UNHoeQR1Jat8mgf7qHjLK5BzGB4rs9X4dkDbQZm+
         bK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NGo4rRV+VZvdT0hcJzW6pnymtoNuY20VyL3BfwK+vsQ=;
        b=qOQg4vzVdfxfs6zhPMw/ENI56Ej4bP+7V01x3KFd1q/ktJufiEatTYFqIiKgm91qQl
         cqnA0RX9F5SCt6RQOS4GyYb4Z6/nqFRgAQe25676zMiHCdGXOfg24ROAUub42n6eT0XM
         7RJ4qEP1dR6aAjU1s22/GrToIRYvLLyxfHPECd6NWIxVH0Yzv0UT4DFqioZajZlTDAW1
         QHuxoYNJEyXhy7ClfJZoU7XRxmn1l0CrMb3HbbTtOCu7Hxkyj8423+025OZ1GAt/si0j
         15BU7kCPcvmOh3dzEa5m79JSMXMT9XTwiL/osTf8weIliAIKZAuFPy4Ef2EW4TMRMPh2
         LFGQ==
X-Gm-Message-State: AOAM530HkVyhSN7JJhkCO3/P9Uj8w7XUZTFKLnnolFNh41UVZe6AFXvG
        wnPm+KIxG3Z7vVPXeLr6KKgHAA==
X-Google-Smtp-Source: ABdhPJwYNKUeEBAZ4RUybATyRa6XP/R3ueVtMBVOx8BZh7j60wFKsSS2DRvlG4SBSF0xBFk6Exup1A==
X-Received: by 2002:a7b:ce85:0:b0:39c:4b2e:fd26 with SMTP id q5-20020a7bce85000000b0039c4b2efd26mr8388758wmj.114.1655277908515;
        Wed, 15 Jun 2022 00:25:08 -0700 (PDT)
Received: from [10.205.160.53] ([95.83.233.54])
        by smtp.gmail.com with ESMTPSA id k11-20020a056000004b00b0020d02262664sm13919956wrx.25.2022.06.15.00.25.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 00:25:07 -0700 (PDT)
Message-ID: <8293b455-1150-edb5-9005-fda4f2d2971b@conchuod.ie>
Date:   Wed, 15 Jun 2022 08:23:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/5] dt-bindings: pwm: Add Mstar MSC313e PWM devicetree
 bindings documentation
Content-Language: en-US
To:     Romain Perier <romain.perier@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220615070813.7720-1-romain.perier@gmail.com>
 <20220615070813.7720-2-romain.perier@gmail.com>
From:   Conor Dooley <mail@conchuod.ie>
In-Reply-To: <20220615070813.7720-2-romain.perier@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/2022 08:08, Romain Perier wrote:
> This adds the documentation for the devicetree bindings of the Mstar
> MSC313e RTC driver, it includes MSC313e SoCs and SSD20xd.

I figure the RTC is a copy paste error?

> 
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> ---
>   .../bindings/pwm/mstar,msc313e-pwm.yaml       | 47 +++++++++++++++++++
>   1 file changed, 47 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/pwm/mstar,msc313e-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/mstar,msc313e-pwm.yaml b/Documentation/devicetree/bindings/pwm/mstar,msc313e-pwm.yaml
> new file mode 100644
> index 000000000000..82f2357db085
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/mstar,msc313e-pwm.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/mstar,msc313e-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mstar MSC313e PWM controller
> +
> +allOf:
> +  - $ref: "pwm.yaml#"
> +
> +maintainers:
> +  - Daniel Palmer <daniel@0x0f.com>
> +  - Romain Perier <romain.perier@gmail.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +        - enum:
> +          - mstar,msc313e-pwm
> +          - mstar,ssd20xd-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  "#pwm-cells":
> +    const: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pwm: pwm@3400 {
> +      compatible = "mstar,msc313e-pwm";
> +      reg = <0x3400 0x400>;
> +      #pwm-cells = <2>;
> +      clocks = <&xtal_div2>;
> +    };
