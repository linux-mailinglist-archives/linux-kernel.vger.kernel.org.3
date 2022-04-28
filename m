Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CD2512D03
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245471AbiD1Hil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245519AbiD1Hic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:38:32 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BF09D4D5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:35:10 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id j6so7747242ejc.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=4JvsDqqK9ttY5rHf8XBLNsfShpWbe64Z3RuZmn+7sxo=;
        b=CawBNzMbbClMCgqgz10dV/iGLX7SFfUaSWdYT2xbA9cRKfKmMUDlTzeMI9DnmJckip
         oqIMfvzKOwUwmIqkLL/0klX+KJphWlq7X3YAizN+0jtp2s89SHwvW+QmUVEzyEyRvH2F
         +aTvvb0DfReU8RfqDTHwwlfEH3ggI0Alxlugbed0DbUu4GN2uc0CeSePrY0GOw0dGnlT
         so72UaXanc81exPXJ70dm7OMH1Smeeh9q4zFbHTGI+Z7hrCgnD+uijQ3NZzDwDe17IPs
         xNxcslitPsTzfPVdk1iSxtKQzSDvRrZiMRSDq8Ca5FPWKsd0XfXb830/guavDSKR9i4O
         lV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4JvsDqqK9ttY5rHf8XBLNsfShpWbe64Z3RuZmn+7sxo=;
        b=QBYqmcYruU5h32egvyz+sOi+uURvGCArtJ0m2f+mLPG2C5YvNuwYu2k3ok+a2M+sD/
         f+q0qd6vcleuJAJz3GVsCUy9ME1LXGy5C1NPPHcHnLF9zgPRhpaH5qkltCOpnxcFcfT9
         JypYQWYR4TikY6LRkerlTM8iGdSumSev4SYffQNTMFkETZv23OucqSX0Y3lIaObQvwCh
         QvlZkF/jBZVLpPL3HHQdzYtRUik14nyWrQnsO74ZqObjQ3cY9oYFShXf2Uf7ks8e9g5S
         CDqN9f2CMeLhavSm3cgF3INtNO1JzHQOzceFUYgCQn/4MeaGDUyi3Vdzs/wobZ6XGZEQ
         FKBQ==
X-Gm-Message-State: AOAM530975ERNwrM9iCqvCZUAG0MU5ZyE/Bmg3D6gaFy/PACwRE7Li/F
        2R545e+53gjerMsXdoXpZpyhayErnSbGzw==
X-Google-Smtp-Source: ABdhPJzRoxehe5gk4lTTso+tkR4hsOuSW2vMtPQjWj020xAP62C6IRc+IHyj2AGRm63ckwt/5iBSgw==
X-Received: by 2002:a17:906:19c6:b0:6ce:98a4:5ee6 with SMTP id h6-20020a17090619c600b006ce98a45ee6mr30155478ejd.567.1651131308943;
        Thu, 28 Apr 2022 00:35:08 -0700 (PDT)
Received: from [192.168.0.160] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id w14-20020a1709060a0e00b006f01e581668sm7878197ejf.209.2022.04.28.00.35.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 00:35:08 -0700 (PDT)
Message-ID: <edec6367-c2ca-a321-4683-1fcaeb15ba51@linaro.org>
Date:   Thu, 28 Apr 2022 09:35:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 4/4] ARM: dts: pxa: use new 'dma-channels/requests'
 properties
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220427161459.647676-1-krzysztof.kozlowski@linaro.org>
 <20220427161459.647676-5-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220427161459.647676-5-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2022 18:14, Krzysztof Kozlowski wrote:
> The '#dma-channels' and '#dma-requests' properties were deprecated in
> favor of these defined by generic dma-common DT bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/boot/dts/mmp2.dtsi   | 2 +-
>  arch/arm/boot/dts/pxa25x.dtsi | 4 ++--
>  arch/arm/boot/dts/pxa27x.dtsi | 4 ++--
>  arch/arm/boot/dts/pxa3xx.dtsi | 4 ++--
>  4 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
> index 46984d4c5224..1a49b58e8048 100644
> --- a/arch/arm/boot/dts/mmp2.dtsi
> +++ b/arch/arm/boot/dts/mmp2.dtsi
> @@ -275,7 +275,7 @@ dma-controller@d4000000 {
>  				compatible = "marvell,pdma-1.0";
>  				reg = <0xd4000000 0x10000>;
>  				interrupts = <48>;
> -				#dma-channels = <16>;
> +				dma-channels = <16>;

As Rob proposed, the removal of old property does not have to happen in
this patch (but much later). This would allow merging DTS change
immediately.

I will resend in that spirit, unless SoC maintainers prefer the original
approach (where DTS has to wait for next release)?


Best regards,
Krzysztof
