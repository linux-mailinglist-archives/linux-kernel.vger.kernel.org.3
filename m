Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1025AE28E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239225AbiIFI3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239190AbiIFI3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:29:11 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4C9760C0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 01:29:07 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id k10so1620415lfm.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 01:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=FhRE8lkrzD8kMfuZSVw/65OUGXiAlHvWxW/GDqr7GIU=;
        b=kDKlYj5eCRkqtWaGExLZuCpi+SiQLIVR3pYHffvNbB/3GFbZtVOvEQ/msomHad34/Y
         XjPsrwEXOivhOlshLOEBSkgNOdB921p4dYUvd/0jR2RXt8KbYZh+IqkuJUDhifYhTcsj
         iKGibSlAhHzdH8JgPgrJMx2rtHcQK9YGf5iT7iMHq0zbZhb1nZq6pqDBDNMDjja3+9zK
         1NPiJ67RHuuRQJKt1CiBOv9c/I8ikRtEygW+jHwwcrH0tfnxpsDAclBf/Iky8io03lbe
         wDkkvuxXXCwXZRK29yW29YUzPf4RsU3jPDp6uGSCAoILbJYegI7+V2vzuUhh0yBd9Rlc
         LiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=FhRE8lkrzD8kMfuZSVw/65OUGXiAlHvWxW/GDqr7GIU=;
        b=RbKxJmDJrQGioHaUCiCMWyP8Ly01FcqspvZOaVyrOE3pcEEviHpLp486W6JuE69OW9
         J3vhqLYCPc3bnhhUdsF8ZGpfmqLqHDrtbJPRGuBcP7VWlN+d2CeCB9yvt8M5bal4dErB
         YOwfeKCQp7O/3HD/5IQt8XpXo44p2agVD23/yDAEYxhXTdtPZE1bk2KAaEvDDiZTpUVE
         UdKe9DVbLB6O2PCq9HSLgDk4on8/JLmZBCLF6swIreRyHw2Dq4jmRc0UiBx47wFEaU9A
         8zBsqrSJRNo60ZWMBcqQiVt4/bHLlUpyP5gF4RM+Mok5xr4EoEVgUOZRHqbSsREjBBYU
         N16g==
X-Gm-Message-State: ACgBeo3Wz3H6dnXk1fTFUE/s7X5NoMCK9P2/nB9xC89s5SZNthqvLpnd
        Q+PQyrYgJVGZbHplFQJqvXJqXQ==
X-Google-Smtp-Source: AA6agR4q7yqpC2fGtbF404qBqRC1jFok+/yK7oqWz5D86QZtbPk6XZ9Y/3OFGLOOwZ/02/v7wO0Rlg==
X-Received: by 2002:a05:6512:1312:b0:492:e14d:54d4 with SMTP id x18-20020a056512131200b00492e14d54d4mr16579896lfu.469.1662452946261;
        Tue, 06 Sep 2022 01:29:06 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id c15-20020a056512238f00b004974da17c2bsm282419lfv.0.2022.09.06.01.29.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 01:29:05 -0700 (PDT)
Message-ID: <14abb0cd-4f65-030e-5479-bf1487979624@linaro.org>
Date:   Tue, 6 Sep 2022 10:29:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/9] dt-bindings: ufs: qcom: Add sm6115 binding
Content-Language: en-US
To:     Iskren Chernev <iskren.chernev@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220903174150.3566935-1-iskren.chernev@gmail.com>
 <20220903174150.3566935-2-iskren.chernev@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220903174150.3566935-2-iskren.chernev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/2022 19:41, Iskren Chernev wrote:
> Add SM6115 UFS to DT schema.
> 
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
> ---
>  .../devicetree/bindings/ufs/qcom,ufs.yaml     | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> index f2d6298d926c..be55a5dfc68f 100644
> --- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> +++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> @@ -28,6 +28,7 @@ properties:
>            - qcom,msm8998-ufshc
>            - qcom,sc8280xp-ufshc
>            - qcom,sdm845-ufshc
> +          - qcom,sm6115-ufshc
>            - qcom,sm6350-ufshc
>            - qcom,sm8150-ufshc
>            - qcom,sm8250-ufshc
> @@ -178,6 +179,31 @@ allOf:
>            minItems: 1
>            maxItems: 1
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sm6115-ufshc
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 8
> +          maxItems: 8
> +        clock-names:
> +          items:
> +            - const: core_clk
> +            - const: bus_aggr_clk
> +            - const: iface_clk
> +            - const: core_clk_unipro
> +            - const: core_clk_ice

This still is not naming and order of sdm845.

> +            - const: ref_clk
> +            - const: tx_lane0_sync_clk
> +            - const: rx_lane0_sync_clk

Best regards,
Krzysztof
