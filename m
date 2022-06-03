Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4419B53C667
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 09:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242555AbiFCHiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 03:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242556AbiFCHiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 03:38:09 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E5A2251E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 00:38:07 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id h23so3244007ejj.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 00:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NozlW8gxt+DxbkdUBPQ7v+hGLg98dYyflLdq2vKGNNQ=;
        b=MBwq8iQT08gOCa9rJ8qFqI4BdOqhD9gxgoHyItuiBDjc80GOV0n/0Hvh5h9ccoL8XF
         xXfwjrnjyWzaZ+2Cij/QNwGFjC976k0n2j6+2Qi+WpzIcdXcxw5dO6QrYsKv0N04qOwf
         FiNjb652e0Sz+XA1NbcH2bbuvdW+oNrJttxI4dj/jo5uK2smwDutaZFG1n+EZIjxCIei
         Q9A0TfF42ZXLGFbThtMyAXR5mK7+7FriG/+bgpXU65UpD4vdqxNAk96DMonmFn9TjnVv
         sOeKcfFcFl/gFahHFD+Q5SBYtq3cz0QoCDEoL8mXm1EoazbRvGnVPMnaCq930hlfTLAx
         pyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NozlW8gxt+DxbkdUBPQ7v+hGLg98dYyflLdq2vKGNNQ=;
        b=VK/RpRh7jzrTeIi6QzVKlTaRqHWo3LYW31CSqWIzK3IzECBZfMFn9+ffXgk09qConh
         wpYlBbC5j7LMeRriVUD/jMDN0p1ghPA3Brzp5/Fyp3LTl9+NEi9FfuzFUkEIUzRY6c3g
         NALsqL7U4laQYPOGR1c8OlcFkAkilNY0o32lA3IKQy7aiWx1u1jV5vaPx+xrBTwq2O/k
         Azr+U4SPflZ8xOR9Tx5CBJcLuYYBTUEMBy+Q12Zh1vyomIG9bT5Uxht06Y1zFaQlY+dz
         iVsmOGjAzq8pLts+X/YD2sDJw6DUMAFRdKtUwjmxnL+Io9IbpH54UDPnhelrzUPfDHLS
         ZHfw==
X-Gm-Message-State: AOAM531pxPd0fI+wXJA/GXO2fxASDmVD6c+rf/uTPYcrzfwz9eM5LjZF
        33AAcNLQ53r/uuakMB0qdMpAhA==
X-Google-Smtp-Source: ABdhPJwmUVILxx3fkvi4+hqA/dlgtcQ1M8rziX6YVtWAy/aURal3rjhnY6VgUCnsqW4bsZbXS+ErRw==
X-Received: by 2002:a17:907:7b95:b0:6f4:ff03:981a with SMTP id ne21-20020a1709077b9500b006f4ff03981amr7455667ejc.653.1654241886274;
        Fri, 03 Jun 2022 00:38:06 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id bs13-20020a056402304d00b0042bd6f745fasm3562059edb.92.2022.06.03.00.38.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 00:38:05 -0700 (PDT)
Message-ID: <78714614-bb6a-761d-3a36-cbd758dcec4c@linaro.org>
Date:   Fri, 3 Jun 2022 09:38:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 5/5] arm64: dts: exynos: Add internal eMMC support to
 jackpotlte
Content-Language: en-US
To:     David Virag <virag.david003@gmail.com>
Cc:     phone-devel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220601233743.56317-1-virag.david003@gmail.com>
 <20220601233743.56317-6-virag.david003@gmail.com>
 <b3681990-e358-8e1d-93fe-b72c099902e3@linaro.org>
 <f40aca00a4418c889395d2dab65f85d24e8662c6.camel@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f40aca00a4418c889395d2dab65f85d24e8662c6.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/2022 00:18, David Virag wrote:
> On Thu, 2022-06-02 at 14:01 +0200, Krzysztof Kozlowski wrote:
>> On 02/06/2022 01:37, David Virag wrote:
>>> Add the nodes relevant to provide clocks for Exynos7885 eMMC and to
>>> support eMMC. eMMC is the internal storage used in the Samsung
>>> Galaxy A8
>>> (2018) (jackpotlte), and all other known devices using the
>>> Exynos7885
>>> SoC.
>>>
>>> Signed-off-by: David Virag <virag.david003@gmail.com>
>>> ---
>>>  .../boot/dts/exynos/exynos7885-jackpotlte.dts | 20 ++++++++++++
>>>  arch/arm64/boot/dts/exynos/exynos7885.dtsi    | 32
>>> +++++++++++++++++++
>>>  2 files changed, 52 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts
>>> b/arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts
>>> index 4cf9aa25f618..5db9a81ac7bb 100644
>>> --- a/arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts
>>> +++ b/arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts
>>> @@ -60,6 +60,26 @@ power-key {
>>>         };
>>>  };
>>>  
>>> +&mmc_0 {
>>> +       status = "okay";
>>> +       mmc-hs200-1_8v;
>>> +       mmc-hs400-1_8v;
>>> +       cap-mmc-highspeed;
>>> +       non-removable;
>>> +       mmc-hs400-enhanced-strobe;
>>> +       card-detect-delay = <200>;
>>> +       clock-frequency = <800000000>;
>>
>> Is this real property for MMC? Neither mmc nor DW MSHC bindings
>> mention it.
> 
> It is, but I don't remember trying without it. Seems like it is not
> documented then. It is used in dw_mmc.c in the following places:
> 
> https://github.com/torvalds/linux/blob/master/drivers/mmc/host/dw_mmc.c#L3242-L3243
> 
> https://github.com/torvalds/linux/blob/master/drivers/mmc/host/dw_mmc.c#L3306-L3325
> 
> The Exynos850 device tree has the same property in it's mmc node. 

Indeed, it's fine then. I'll check the bindings and convert them to DT
schema.


Best regards,
Krzysztof
