Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F505976D2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 21:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240963AbiHQTfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 15:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241283AbiHQTfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 15:35:14 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC097A405F;
        Wed, 17 Aug 2022 12:34:23 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id jm11so10603557plb.13;
        Wed, 17 Aug 2022 12:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=jmv+2JiArmh2uqWeGwCuCSChHG+U1IB821gw+BfUF7s=;
        b=oWFeTwHq9oNo9te/RcgQE9tjTWmaSX1Itf7Hj+bMq1927VxdB0NZ3uFpj8NAlPcnWY
         /XwDolWN4VmlreJ/XbhimiP0ljZMG7LyvNs6MAR0NybxCR8OCdE7eUeKAKeCWgQcfqsk
         ljWSfHNe10mpPP0+F3cZr2P8zVo119V2AwlM2C6HFXEqDKq6cwlnpxQDVFsA4Ziayp95
         l1kzQPW/EnW+IVDLHs/s2iXVMnKQSmunklKoc//3s2U382NBUzr+jL3/3Ybs7FuLrtqq
         fgL8Mos3onsuU+nphS2Na8dkQyYw29RPasoeV0Ml66PQs3zKDxwmReCkf3iVuoVaITRd
         VAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=jmv+2JiArmh2uqWeGwCuCSChHG+U1IB821gw+BfUF7s=;
        b=TUf8KYsH+BBx3M6nFvn2TUe3uSdaOFN2VRoNnh4diiCydcT2co3X0573d7Yxattk9c
         sYDnv1noDtlggUrIVRhIsxuIJM5/8FPVjlQ15Rs+Py2va4csHd+h4YukXvqgpyozQSPP
         21lGCUSClWW1qgAApbgO5Y3EiESC9sFrPN89GE09HfbD7FcNk/9McNeSKiamfxo1UId/
         ocivKOU7QMmwZkI8bAp3/qjsBhg+o4HwDzWP7uVk5eTbL/C5FKuJizfBR7+LEzrc6II5
         TtwUtM0bbpaj4E5U0bOYm32JmHrjtxuHnYPgJMs2Xvud8PybVS653R1M+jW7U+vpX217
         WEiA==
X-Gm-Message-State: ACgBeo3Q+2WubWYXhhIrN6MOLkrKadSbaDZiskHY03DjRXjpX57z447A
        fIlFDH0AQaKZHaM/87ba0Y8=
X-Google-Smtp-Source: AA6agR6TBtrFUcFOKMxzJCHDAYaFnbYYaCLDZweebRQ7bglpTPZnFFxIQqy8RI8oUEdE5aAsGQSHhQ==
X-Received: by 2002:a17:902:788f:b0:170:8b18:8812 with SMTP id q15-20020a170902788f00b001708b188812mr27556461pll.1.1660764863206;
        Wed, 17 Aug 2022 12:34:23 -0700 (PDT)
Received: from [172.30.1.52] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id a3-20020aa79703000000b0052d4cb47339sm10819078pfg.151.2022.08.17.12.34.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 12:34:22 -0700 (PDT)
Message-ID: <bd60a27e-1a47-1f8f-4664-9310aff79344@gmail.com>
Date:   Thu, 18 Aug 2022 04:34:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/9] dt-bindings: clock: Add bindings for Exynos850
 CMU_MFCMSCL
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
References: <20220809113323.29965-1-semen.protsenko@linaro.org>
 <20220809113323.29965-4-semen.protsenko@linaro.org>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20220809113323.29965-4-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 8. 9. 20:33, Sam Protsenko wrote:
> CMU_MFCMSCL generates MFC, M2M, MCSC and JPEG clocks for BLK_MFCMSCL.
> Add clock indices and binding documentation for CMU_MFCMSCL.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
> Changes in v2:
>   - (none)
> 
>  .../clock/samsung,exynos850-clock.yaml        | 25 +++++++++++++++
>  include/dt-bindings/clock/exynos850.h         | 32 ++++++++++++++++++-
>  2 files changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
> index 7f2e0b1c764c..141cf173f87d 100644
> --- a/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
> @@ -39,6 +39,7 @@ properties:
>        - samsung,exynos850-cmu-dpu
>        - samsung,exynos850-cmu-hsi
>        - samsung,exynos850-cmu-is
> +      - samsung,exynos850-cmu-mfcmscl
>        - samsung,exynos850-cmu-peri
>  
>    clocks:
> @@ -216,6 +217,30 @@ allOf:
>              - const: dout_is_vra
>              - const: dout_is_gdc
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: samsung,exynos850-cmu-mfcmscl
> +
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: External reference clock (26 MHz)
> +            - description: Multi-Format Codec clock (from CMU_TOP)
> +            - description: Memory to Memory Scaler clock (from CMU_TOP)
> +            - description: Multi-Channel Scaler clock (from CMU_TOP)
> +            - description: JPEG codec clock (from CMU_TOP)
> +
> +        clock-names:
> +          items:
> +            - const: oscclk
> +            - const: dout_mfcmscl_mfc
> +            - const: dout_mfcmscl_m2m
> +            - const: dout_mfcmscl_mcsc
> +            - const: dout_mfcmscl_jpeg
> +
>    - if:
>        properties:
>          compatible:
> diff --git a/include/dt-bindings/clock/exynos850.h b/include/dt-bindings/clock/exynos850.h
> index f8bf26f118c1..88d5289883d3 100644
> --- a/include/dt-bindings/clock/exynos850.h
> +++ b/include/dt-bindings/clock/exynos850.h
> @@ -73,7 +73,19 @@
>  #define CLK_DOUT_IS_ITP			61
>  #define CLK_DOUT_IS_VRA			62
>  #define CLK_DOUT_IS_GDC			63
> -#define TOP_NR_CLK			64
> +#define CLK_MOUT_MFCMSCL_MFC		64
> +#define CLK_MOUT_MFCMSCL_M2M		65
> +#define CLK_MOUT_MFCMSCL_MCSC		66
> +#define CLK_MOUT_MFCMSCL_JPEG		67
> +#define CLK_GOUT_MFCMSCL_MFC		68
> +#define CLK_GOUT_MFCMSCL_M2M		69
> +#define CLK_GOUT_MFCMSCL_MCSC		70
> +#define CLK_GOUT_MFCMSCL_JPEG		71
> +#define CLK_DOUT_MFCMSCL_MFC		72
> +#define CLK_DOUT_MFCMSCL_M2M		73
> +#define CLK_DOUT_MFCMSCL_MCSC		74
> +#define CLK_DOUT_MFCMSCL_JPEG		75
> +#define TOP_NR_CLK			76
>  
>  /* CMU_APM */
>  #define CLK_RCO_I3C_PMIC		1
> @@ -225,6 +237,24 @@
>  #define CLK_GOUT_IS_SYSREG_PCLK		23
>  #define IS_NR_CLK			24
>  
> +/* CMU_MFCMSCL */
> +#define CLK_MOUT_MFCMSCL_MFC_USER		1
> +#define CLK_MOUT_MFCMSCL_M2M_USER		2
> +#define CLK_MOUT_MFCMSCL_MCSC_USER		3
> +#define CLK_MOUT_MFCMSCL_JPEG_USER		4
> +#define CLK_DOUT_MFCMSCL_BUSP			5
> +#define CLK_GOUT_MFCMSCL_CMU_MFCMSCL_PCLK	6
> +#define CLK_GOUT_MFCMSCL_TZPC_PCLK		7
> +#define CLK_GOUT_MFCMSCL_JPEG_ACLK		8
> +#define CLK_GOUT_MFCMSCL_M2M_ACLK		9
> +#define CLK_GOUT_MFCMSCL_MCSC_CLK		10
> +#define CLK_GOUT_MFCMSCL_MFC_ACLK		11
> +#define CLK_GOUT_MFCMSCL_PPMU_ACLK		12
> +#define CLK_GOUT_MFCMSCL_PPMU_PCLK		13
> +#define CLK_GOUT_MFCMSCL_SYSMMU_CLK		14
> +#define CLK_GOUT_MFCMSCL_SYSREG_PCLK		15
> +#define MFCMSCL_NR_CLK				16
> +
>  /* CMU_PERI */
>  #define CLK_MOUT_PERI_BUS_USER		1
>  #define CLK_MOUT_PERI_UART_USER		2

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
