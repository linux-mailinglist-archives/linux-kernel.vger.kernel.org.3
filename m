Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF855A7F02
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 15:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiHaNh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 09:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiHaNhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:37:08 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13ABC11A19
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 06:36:28 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id q16so14637379ljp.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 06:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=gGkipS5OiOaDWG7u9ok23WWflnT/lUaJfPplZYAiYqM=;
        b=rIgJ2niaj8guR1fs5O83kUj8QJ68k73tiR084IlVWinBwSlGua2nTLyO4+Xo+dYK6m
         /jPSzqDBNjlGYDNcfrUOHFrBvSNqvDF0vW7CRruodQGCMwIbvYJ/6UyfdH7s1fgm3zqT
         tgwN+CihxVRQ29p68jzJ6SMaBNxdb7BDSiovN4dKCVB+xjNtw1RgnEBb/x9oMRl8rDST
         qhUlzz4/7Eyxyq7v6eFFnRwUbSacgm9fR8dfCjasXShYjMJW3km/IeCzluVzyAW/TP5L
         5ygR+yIHst2ni9ru96avWjiaXQivkapvxZGrj6nwZFlXwU3X7nS7nrydxk+VJZkb4cU/
         Tahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=gGkipS5OiOaDWG7u9ok23WWflnT/lUaJfPplZYAiYqM=;
        b=o+otoeKvQQ+JURG9wWiT9aH1CE2W9MUgRSvc+X/fEj88JkIx5uIv/lmEH6h2249mtl
         CNBbp4zGVH9674iGjMPDp2tN7F2bZ5MPCR0Q9WwIXhRqegD2z+NXLGYJ/otfAbFOLz49
         ftctc9PnYBNnqwzeTtJ2VyccuaWyfK95YCdsJ4muc3l7ynQYLLi8+w46sTaVbwfESH/4
         U4/xwH+OkRL0lJgbxOaWm1YBLMvvkeOlJF5O2tMpLu0fWCZC1dVPvmdnm+5i49lN5Q3j
         Ds09qpoYprFbva+Tf+8I6BKdCSbU9BTVGG6PgsJ7vyxqrHvm6Y0yGhhdSCGHcZ4Cm9I0
         SS2Q==
X-Gm-Message-State: ACgBeo2lUGpCn1OnLuY1OucztbPrA7xxwucK6wNm1SonEWp/EJNMz+Tb
        HXz2fwVN9i3JLm5oKmI8811aWQ==
X-Google-Smtp-Source: AA6agR4+4PSsSJU+cVCSvFtVroZCC/ZJUU3CHURUCcI2YOJxgUGe02lowT1jdYfMi/vnOpgoN1K0Hw==
X-Received: by 2002:a2e:b74a:0:b0:25f:3f72:9210 with SMTP id k10-20020a2eb74a000000b0025f3f729210mr8647710ljo.8.1661952987193;
        Wed, 31 Aug 2022 06:36:27 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id y20-20020a05651c107400b00261cd70e41asm1401636ljm.32.2022.08.31.06.36.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 06:36:26 -0700 (PDT)
Message-ID: <d33607e2-42de-ac4e-7ed0-4c25504ac092@linaro.org>
Date:   Wed, 31 Aug 2022 16:36:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/2] bindings: iio: adc: Add max11205 documentation
 file
Content-Language: en-US
To:     Ramona Bolboaca <ramona.bolboaca@analog.com>, jic23@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220831133021.215625-1-ramona.bolboaca@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220831133021.215625-1-ramona.bolboaca@analog.com>
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

On 31/08/2022 16:30, Ramona Bolboaca wrote:
> Add bindings documentation file and MAINTAINERS entry for MAX11205.
> 
> Signed-off-by: Ramona Bolboaca <ramona.bolboaca@analog.com>


> +properties:
> +  compatible:
> +    enum:
> +      - maxim,max11205a
> +      - maxim,max11205b
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 5000000
> +
> +  spi-cpha: true
> +
> +  vref-supply:
> +    description:
> +      The regulator supply for the ADC reference voltage. This is a differential
> +      reference. It is equal to the V_REFP - V_REFN. The maximum value is 3.6V.
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-max-frequency
> +  - spi-cpha
> +  - interrupts
> +  - vref-supply

If you are going to send a new version, please put the properties here
in the same order as they appear in top-level "properties:".

In any case:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
