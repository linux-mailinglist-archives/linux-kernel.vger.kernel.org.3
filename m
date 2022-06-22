Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF345547BF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349617AbiFVL76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 07:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357425AbiFVL7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 07:59:45 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC523D4A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 04:59:44 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id t5so1195647eje.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 04:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=DZU7yMbXa4P+Gd4uGBEFY4wwtiYkAUkzlhILMat6l/o=;
        b=OQavwAI28a9L9KdZhcA2DZvhpudJzVv3Y4A/eL02kiClu0lv+TbDzezFSzNslpAt9V
         VKW50MzB7ZVmYNjfRoAsXxNaNFYxj2pfk4tVazyC8qGKJkNfI9DI2Fhh3ygIQusVDLuk
         Zc3J9B7L8Bu+ClnjSgmnPh4MZlvE8954+PP5+PI6xJ/5bnGmlryjy+XAmN1C5eMEOwRH
         bi4ZJ+ItGwJkdlo/1AoitCP6MrIfwmUOOaWdZ5yr0Pa/exd8I0V3OlL08mnLJmPCr5pm
         /Xi+cFVxm3B0pmp3j6swnJvaMicEficBuujVyUO15l/+6OyFc2ScXf4qPKG9W3V0NVjs
         WGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DZU7yMbXa4P+Gd4uGBEFY4wwtiYkAUkzlhILMat6l/o=;
        b=kJijS0l06XwgkfNEcmGXs3V1b43c4lZJ3CuuNg9QTIwWzs4zqmGldkil7psAFkBWPN
         3Lac55giGAz7GA+wyUWDw3A07YmQLtrMuxoBvWZD+R27RK0nA+SNYl+bG4FrIjp5UGSx
         d3vSqlOU+UTtSr+MwSH7ec0jraOEQDO8NnF4wtI1671qrO5KzmlKxm8/sK4MJmS/BqeN
         XrDYn4/WVBwVrllr/pJzycmht6SU1/vPzn9xrgedmcDLok1IBF4Wwl2s9p4cIe762CGB
         EJu4vi8+4QJz1/GJhwGJWVvt5OAkeV/T5FbNH5RNRUnajpk0KgaXz5Rb8uA4pKzxdkt4
         mwoQ==
X-Gm-Message-State: AJIora/I4/BdyvchaV7YzFzn7ps0N/IfH9VyOROnEeUO2yrss9hCszPD
        EkC/n77N4FJv15+R5s73nuXGxw==
X-Google-Smtp-Source: AGRyM1sLi7a4kBO3JthSo4Cm36WUXfT8Gem0ucOSW3Mc1lDmNrfdb0myCuFRlgJKnXF4QxcDvSZkUA==
X-Received: by 2002:a17:906:ee1:b0:70d:d293:7b30 with SMTP id x1-20020a1709060ee100b0070dd2937b30mr2743102eji.134.1655899182685;
        Wed, 22 Jun 2022 04:59:42 -0700 (PDT)
Received: from [192.168.0.224] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id yy16-20020a170906dc1000b00722e19fec6dsm2819950ejb.156.2022.06.22.04.59.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 04:59:42 -0700 (PDT)
Message-ID: <ad708829-6ee3-b95d-d3ef-27dd85ff5df5@linaro.org>
Date:   Wed, 22 Jun 2022 13:59:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 03/14] ARM: dts: qcom: use generic sram as name for imem
 and ocmem nodes
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Brian Masney <masneyb@onstation.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220607171848.535128-1-krzysztof.kozlowski@linaro.org>
 <20220607171848.535128-3-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220607171848.535128-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2022 19:18, Krzysztof Kozlowski wrote:
> According to Devicetree specification, the device nodes should be
> generic, reflecting the function of the device.  The typical name for
> memory regions is "sram".
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts | 2 +-
>  arch/arm/boot/dts/qcom-msm8974.dtsi                | 4 ++--
>  arch/arm/boot/dts/qcom-sdx55.dtsi                  | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 

Bjorn,

Any comments from your side on these cleanups?

Best regards,
Krzysztof
