Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2889751430C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 09:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354993AbiD2HPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 03:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354793AbiD2HPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 03:15:20 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B24192BE
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 00:12:02 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id i19so13670772eja.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 00:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Edd8ZLYtYb/gwlpyDZkQOxSq27PsRFpIp30d8SMER+g=;
        b=tqpFpORB+WKNr57yBie6HkLBpEWBDwutFEby7Q21Gz862pVw5QVxAdeiQt7SQzvXsg
         d8XFA7qTsBmWwXDwR1qPiiw8lpFCyNNrNjfJ+0azA3SAMJCyg2COrurBTlmlKkDzzlJP
         tE9854dsAw5C4y/dCJ2T7ttXIyHf0PzgHqNBzPWYGmaWqYevybj22Sj9Cf2A1CFR8b+1
         EnILFy5/3CtF8TN/JjKOBAar+YMpFdIJpaH4guyFPc37dhUnqygvIHpEJrr6afnaa8Km
         FbfDP4X7LgxAISo1exzuxi/G+/IZKX/TtB9EW/N2AXGqQl9Avp2eer/OxELapy9qMjD+
         P0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Edd8ZLYtYb/gwlpyDZkQOxSq27PsRFpIp30d8SMER+g=;
        b=fJrOCeh/fyQ20tT7Y3cNMpGw6ql5VSZdmOlyFor6nX8/Rk/0bBwV5L/ajtua+FuMXm
         fE56PbtNA6HMo7WezWcPGwSvnRgtoSATUQeCTAcVPOoH7haMfJniBV2NDxkZeI42RGWK
         +9OqfKA6D1VCz5nTpeycymVjQygQV7TmrF59erqbCfc/7BzzCJu/Yn5kYOuR49cUJWEm
         74Wlbaiy6eFJ5+ikB8X9ZS8P+usZwbSY3qQDb0p2qTMSv4hRbx/SJ5bCdhDOvgwXTN0r
         63rqfa2j2oP3FUmcfhdWhaWjWU02itYBYb63osqqUWdinN/EBDblH3yd+BjZgmBPGCiR
         9bSw==
X-Gm-Message-State: AOAM533n9ClC5TAcTSGNNjLOOniG14DTF/qSHjwZi0cKma+xERsZ+OrY
        PcNNv6p0AAajjxwvXa5XJMgqAg==
X-Google-Smtp-Source: ABdhPJzt/5R7YhS1n1/Tl1fP5rjgP1BaMd1p1mgvE1MTVa32BuX2e89s7ed/ZnNEEjG7z8VMDAwWCQ==
X-Received: by 2002:a17:906:5597:b0:6ce:f3cc:14e8 with SMTP id y23-20020a170906559700b006cef3cc14e8mr34343226ejp.426.1651216321471;
        Fri, 29 Apr 2022 00:12:01 -0700 (PDT)
Received: from [192.168.0.169] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id jl25-20020a17090775d900b006f3ef214dc5sm365463ejc.43.2022.04.29.00.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 00:12:00 -0700 (PDT)
Message-ID: <2f600411-d40e-c4e7-fd54-bd15546bf71f@linaro.org>
Date:   Fri, 29 Apr 2022 09:11:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v9 1/4] memory: tegra: Add memory controller channels
 support
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, digetx@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmitry.osipenko@collabora.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220426073827.25506-1-amhetre@nvidia.com>
 <20220426073827.25506-2-amhetre@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220426073827.25506-2-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2022 09:38, Ashish Mhetre wrote:
> From tegra186 onwards, memory controller support multiple channels.
> Add support for mapping address spaces of these channels.
> Add number of channels supported by tegra186, tegra194 and tegra234.
> In case of old bindings, channels won't be present. If channels are not
> present then print warning and continue so that backward compatibility
> will be preserved in driver.
> During error interrupts from memory controller, appropriate registers
> from these channels need to be accessed for logging error info.
> 
> Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>  drivers/memory/tegra/mc.c       |  6 ++++++
>  drivers/memory/tegra/tegra186.c | 34 +++++++++++++++++++++++++++++++++
>  drivers/memory/tegra/tegra194.c |  1 +
>  drivers/memory/tegra/tegra234.c |  1 +

This does not apply, neither on my mem-ctrl-next, nor on master.
Probably because tegra234 is somewhere else (Thierry?). Either you send
it without tegra234 or it goes via Thierry's tree.

Best regards,
Krzysztof
