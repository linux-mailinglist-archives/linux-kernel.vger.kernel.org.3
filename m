Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0418504F81
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 13:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236826AbiDRLqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 07:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236769AbiDRLqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 07:46:12 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EAA15A02
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 04:43:32 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id y10so8966760ejw.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 04:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=K5VFTkItBhPN90YMdU8CWhA6XeIV4gqA7vd7xl6JZvs=;
        b=IIOonIr6w+EOL7nEdJx1+v5w8AjbfrzABOsF2hgt/cGhEcnJUSN1e7xq2gGEZnJRpW
         y/sTz/qBzkUN7FijyoN0QMG/NjifiR3aRXMsCgq2HnNun+hqblYT/GfZIyOejR2SySPv
         0gKrAJsMYx8DvIVpfOi/ljQ8VAer9qZscUS1A002a1k1hMeUbBFWXQZSI2I3yd/AfZSd
         ncKVOqbDgSrWdtoAw4r1KS32CbIkLYr1iwwYV3EBDdpYsMQHN2ew5iBzf+3c0JiRqLJD
         ZCuCbLWUKYK+XvP2o7BqGAsngxT56uxWCvuYaj5FdJym5G3yyXNLTTlZVLR4c0YwOAip
         jo0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=K5VFTkItBhPN90YMdU8CWhA6XeIV4gqA7vd7xl6JZvs=;
        b=0bjHbZpsAx4p+avuLvUrv9Txj85ansHEStK1mVR2ve21i1ScS7/JB1LZ93rlx3Uq1t
         9iEiPAIcRpvT+awJgIatMQok0AufPsf9dFeU4bjoDUsJ6M4v6HtJlAMlxL+Cdq8CTs67
         FNLoC7AH2tAyfqz03Hgjwx3Qnm1kQ27mcARUNMb9BBRu39ln3EAv5EfTS5ZRqEsVyKDe
         yPIU/vZ6tGreDBlONsCvas2pkHeuE45aIESIKPbXkloV3dKy995J0qxO93RuVuPaVEPM
         VHZWYQGGmaiyhNgwKuSIX9jZhbflkkfuEdOqhQ4bpBArsB+vS3wHb/t/Psu/acneJv0b
         ZFLw==
X-Gm-Message-State: AOAM531GugnQQF+36A0m1B9fqBpom3w6y04IWzq45KnSNgmEAocGsdlI
        pMYf7vxKC3ooivUfPeLm42zU7Q==
X-Google-Smtp-Source: ABdhPJxjYZY985v8Pfrex1Cnl+eJoXXj6gpnlZklI4bIIFwGaCNeV6NELuvZ0KWRcpU1IjSmuy37Mg==
X-Received: by 2002:a17:906:52c7:b0:6ce:a880:50a3 with SMTP id w7-20020a17090652c700b006cea88050a3mr8643692ejn.437.1650282211473;
        Mon, 18 Apr 2022 04:43:31 -0700 (PDT)
Received: from [192.168.0.217] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id n14-20020a50934e000000b0042053e79386sm6936955eda.91.2022.04.18.04.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 04:43:30 -0700 (PDT)
Message-ID: <1e3ede4e-994b-4d87-b907-ec68661fb958@linaro.org>
Date:   Mon, 18 Apr 2022 13:43:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 4/4] dt-bindings: mmc: convert sdhci-dove to JSON schema
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220414230603.567049-1-chris.packham@alliedtelesis.co.nz>
 <20220414230603.567049-5-chris.packham@alliedtelesis.co.nz>
 <YlivMII9rDCcB6lk@lunn.ch>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YlivMII9rDCcB6lk@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/2022 01:33, Andrew Lunn wrote:
> Hi Chris
> 
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/mmc/host/sdhci-dove.c#L78
> 
> https://elixir.bootlin.com/linux/latest/source/arch/arm/boot/dts/dove.dtsi#L344
> 
> Dove does actually have a clock. It looks like it is optional in the
> driver, but the .dtsi file has it. It is not documented in the current
> .txt file, so i can understand you missing it.
> 
> I'm surprised the DT tools didn't complain about an unexpected
> property.

They did. :)

It seems binding is a bit out of date, so Chris should extend/update it.

Same comments about maintainer as for patch #3.

Best regards,
Krzysztof
