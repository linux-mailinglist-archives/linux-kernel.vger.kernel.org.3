Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DA251F54B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234945AbiEIH3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236133AbiEIH0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 03:26:40 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97FB7307B
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 00:22:04 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z19so15174888edx.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 00:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=r8EzK3JJsKUErCg00miKoLyoqzj/mxXqLt2F2OYDn18=;
        b=h3nYTW6STSrguhBxcKdiMGFTd91R63i5a+BH8Ybs25nAbv51D6zqqTa0WixnBk0fqp
         txvE/7mCgql9wb7EaqGIafjIXnbDYOQkZPmhdNxScdRg5EHyltKa/SXLo0BMUxU5Svvq
         SvsoqBkuPTBP/cOBFmKmXncWPXHxr84Jpy8M9okii5HQPrL2gaZg+4GbTrHYmL6qq/Fc
         9x4tcxLBJ4H+AXyOmyQhh+NySursoKLAip6foicxUTW7V9Yi1um1X4XuzIR/yvBwqcG/
         zdI+EJx58KaVMqnse9A1qR5AYQAN6pikR4Sv4jxGkbmXB69J4xopjcp7bvYu5YsbNOsC
         if5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=r8EzK3JJsKUErCg00miKoLyoqzj/mxXqLt2F2OYDn18=;
        b=aT342cXbQD4TOneZk5zICPhoR1hvx4625CJpGiSx5RW7vcVDObTug2LuDwx4Z9iIKK
         P/226fTRaJO+Ia+rO2Uio77l0XJ75xEtxpnWYHYcKsaHsF8Vp2vNbNv2aTEaCiUk6bMx
         zPn/P/DCO7k+c6iP58gRryYQa+Ne9/JxwpbIZxN3h1VxTmuRESu9GY25U2P7J8wpBoLu
         X4YXAcLz7QtWuztch8AinFKxyIzj+RYeTBR6RLapoZ7tiJrtZQhYXAJm91x1C4KTWGFF
         tvH59go4mYBijMSndk++schMNdzRT9Y9x465t4z0ktZupZBVkPGAGWIvVgjGlUq9LnP9
         gycA==
X-Gm-Message-State: AOAM533KoU2DMIviinThJtsla6JV0ftJssAsfUkqhc65QK8o9vSXAx8U
        u9I0ETJGMVrhmV+srujXdlwPKA==
X-Google-Smtp-Source: ABdhPJxc79htoQFhb6lZqPqWa/gAX0T5VaQupgDvXbnSToB3iz7+sI1cX79YGbfhWbB0c4V07AY0QA==
X-Received: by 2002:a05:6402:400f:b0:428:325a:b6bb with SMTP id d15-20020a056402400f00b00428325ab6bbmr16212581eda.145.1652080923245;
        Mon, 09 May 2022 00:22:03 -0700 (PDT)
Received: from [192.168.0.242] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id h25-20020a1709070b1900b006f3ef214e5esm4735367ejl.196.2022.05.09.00.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 00:22:02 -0700 (PDT)
Message-ID: <c267066c-40b3-4afd-4050-edc1abfdeb1e@linaro.org>
Date:   Mon, 9 May 2022 09:22:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 07/11] dt-bindings: clocks: qcom,gcc-ipq8074: support
 power domains
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org
References: <20220508104855.78804-1-robimarko@gmail.com>
 <20220508104855.78804-7-robimarko@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220508104855.78804-7-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2022 12:48, Robert Marko wrote:
> GCC inside of IPQ8074 also provides power management via built-in GDSCs.
> In order to do so, '#power-domain-cells' must be set to 1.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>  .../devicetree/bindings/clock/qcom,gcc-ipq8074.yaml          | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml
> index 98572b4a9b60..e3e236e4ce7d 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml
> @@ -27,6 +27,9 @@ properties:
>    '#reset-cells':
>      const: 1
>  
> +  '#power-domain-cells':
> +    const: 1

It seems I reviewed your v2 - please put it before reset-cells. The same
in next hunks.


Best regards,
Krzysztof
