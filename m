Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92B3597699
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 21:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241612AbiHQTej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 15:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241582AbiHQTeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 15:34:19 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E440EA7226;
        Wed, 17 Aug 2022 12:32:59 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id x63-20020a17090a6c4500b001fabbf8debfso1990719pjj.4;
        Wed, 17 Aug 2022 12:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=n3IxGvOVNH9U85Kg8eBOTnyB5DQ4Xd4Dbe6kaJQkeJ8=;
        b=S2F3CtusZXN/+XYMinPldBJkV6GU7hn13yuaPXrftc1JFhU3uVjL+BTG+ZlkSTmDGd
         2RsGZLgb7p+L9XgZkvXHsuy1JNTvJcOEpSyK9x7HUjf5Kg0ed7suP8//SfNwiwGrdMTM
         Ahn7j3s9RVROYY9CX8mkNlq+mX1RAU9wiQm5Tf64eiGTvTduj5VkgtTbd1AIOuIAwv+X
         DLSSoex7hBI1LVIFcFrFsURIiNq/jk6Ju+ZqBepcZEiYOy+oK+2FukiZDQ6eFFsqESlj
         unfgq/cFnIHMTbpljzwYN2lmMJi1/2STPTBkE01k8jR2PcBkCAq5bCr2eWdZkQZVHTAG
         mpiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=n3IxGvOVNH9U85Kg8eBOTnyB5DQ4Xd4Dbe6kaJQkeJ8=;
        b=TGnAVbVwZmpIJNjkfV2/i/wQkAVjxZgLJ7fS8z4jt5iGd7Q/rieeNrfwv1pz3/u9B9
         RKG8xwMnFPZWuAT2TO6X7lyslSce2qgFjhdkH2UoewTQojq7cHB9nVuDCOcxm09p4Ika
         ZIqFgHYIMGKpJyhGTvLwwBcE9SburyKrqMcXTu8taUWhgsgjnMmxoFfXWgwZxcXqHdDQ
         ClP779OUJ91JpKAaCW3g/gQfTuhEE2znMCiVb89K3srbd06H0lok3BiBmvbmXAX1C2CT
         2re+AmDR/Yk4R28r+vupmpiRZFseUDY+Q5Gajf/KKdJQVuhiDfe/B8NyFKGhJ1T0zgj8
         Ohrg==
X-Gm-Message-State: ACgBeo0nwhxmfRBkujiKv51XAdZea7Jbv0bOrkfTseBbVxwDn+HvOWne
        ns5liDXvj3BoY3PAfnYDcgo=
X-Google-Smtp-Source: AA6agR5smvFO2j4mVLQft5fYRhYCvpIpp7Ma8CQ/5bNckFKNqlyB7Uc9fSIHqRCboF45PfgpUTm3eA==
X-Received: by 2002:a17:902:8605:b0:16b:e755:3c6e with SMTP id f5-20020a170902860500b0016be7553c6emr27744476plo.42.1660764778642;
        Wed, 17 Aug 2022 12:32:58 -0700 (PDT)
Received: from [172.30.1.52] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id o13-20020a170902d4cd00b0017086b082c1sm286322plg.173.2022.08.17.12.32.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 12:32:58 -0700 (PDT)
Message-ID: <2b6636ed-e49e-2b59-4607-57b039b8d0c6@gmail.com>
Date:   Thu, 18 Aug 2022 04:32:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/9] dt-bindings: clock: Add bindings for Exynos850
 CMU_IS
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
 <20220809113323.29965-3-semen.protsenko@linaro.org>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20220809113323.29965-3-semen.protsenko@linaro.org>
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
> CMU_IS generates CSIS, IPP, ITP, VRA and GDC clocks for BLK_IS. Add
> clock indices and bindings documentation for CMU_IS domain.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
> Changes in v2:
>   - (none)
> 
>  .../clock/samsung,exynos850-clock.yaml        | 25 ++++++++++++
>  include/dt-bindings/clock/exynos850.h         | 40 ++++++++++++++++++-
>  2 files changed, 64 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
> index 53511f056251..7f2e0b1c764c 100644
> --- a/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
> @@ -38,6 +38,7 @@ properties:
>        - samsung,exynos850-cmu-core
>        - samsung,exynos850-cmu-dpu
>        - samsung,exynos850-cmu-hsi
> +      - samsung,exynos850-cmu-is
>        - samsung,exynos850-cmu-peri
>  
>    clocks:
> @@ -191,6 +192,30 @@ allOf:
>              - const: dout_hsi_mmc_card
>              - const: dout_hsi_usb20drd
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: samsung,exynos850-cmu-is
> +
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: External reference clock (26 MHz)
> +            - description: CMU_IS bus clock (from CMU_TOP)
> +            - description: Image Texture Processing core clock (from CMU_TOP)
> +            - description: Visual Recognition Accelerator clock (from CMU_TOP)
> +            - description: Geometric Distortion Correction clock (from CMU_TOP)
> +
> +        clock-names:
> +          items:
> +            - const: oscclk
> +            - const: dout_is_bus
> +            - const: dout_is_itp
> +            - const: dout_is_vra
> +            - const: dout_is_gdc
> +
>    - if:
>        properties:
>          compatible:
> diff --git a/include/dt-bindings/clock/exynos850.h b/include/dt-bindings/clock/exynos850.h
> index 3dc55d4e5b9e..f8bf26f118c1 100644
> --- a/include/dt-bindings/clock/exynos850.h
> +++ b/include/dt-bindings/clock/exynos850.h
> @@ -61,7 +61,19 @@
>  #define CLK_MOUT_AUD			49
>  #define CLK_GOUT_AUD			50
>  #define CLK_DOUT_AUD			51
> -#define TOP_NR_CLK			52
> +#define CLK_MOUT_IS_BUS			52
> +#define CLK_MOUT_IS_ITP			53
> +#define CLK_MOUT_IS_VRA			54
> +#define CLK_MOUT_IS_GDC			55
> +#define CLK_GOUT_IS_BUS			56
> +#define CLK_GOUT_IS_ITP			57
> +#define CLK_GOUT_IS_VRA			58
> +#define CLK_GOUT_IS_GDC			59
> +#define CLK_DOUT_IS_BUS			60
> +#define CLK_DOUT_IS_ITP			61
> +#define CLK_DOUT_IS_VRA			62
> +#define CLK_DOUT_IS_GDC			63
> +#define TOP_NR_CLK			64
>  
>  /* CMU_APM */
>  #define CLK_RCO_I3C_PMIC		1
> @@ -187,6 +199,32 @@
>  #define CLK_GOUT_SYSREG_HSI_PCLK	13
>  #define HSI_NR_CLK			14
>  
> +/* CMU_IS */
> +#define CLK_MOUT_IS_BUS_USER		1
> +#define CLK_MOUT_IS_ITP_USER		2
> +#define CLK_MOUT_IS_VRA_USER		3
> +#define CLK_MOUT_IS_GDC_USER		4
> +#define CLK_DOUT_IS_BUSP		5
> +#define CLK_GOUT_IS_CMU_IS_PCLK		6
> +#define CLK_GOUT_IS_CSIS0_ACLK		7
> +#define CLK_GOUT_IS_CSIS1_ACLK		8
> +#define CLK_GOUT_IS_CSIS2_ACLK		9
> +#define CLK_GOUT_IS_TZPC_PCLK		10
> +#define CLK_GOUT_IS_CSIS_DMA_CLK	11
> +#define CLK_GOUT_IS_GDC_CLK		12
> +#define CLK_GOUT_IS_IPP_CLK		13
> +#define CLK_GOUT_IS_ITP_CLK		14
> +#define CLK_GOUT_IS_MCSC_CLK		15
> +#define CLK_GOUT_IS_VRA_CLK		16
> +#define CLK_GOUT_IS_PPMU_IS0_ACLK	17
> +#define CLK_GOUT_IS_PPMU_IS0_PCLK	18
> +#define CLK_GOUT_IS_PPMU_IS1_ACLK	19
> +#define CLK_GOUT_IS_PPMU_IS1_PCLK	20
> +#define CLK_GOUT_IS_SYSMMU_IS0_CLK	21
> +#define CLK_GOUT_IS_SYSMMU_IS1_CLK	22
> +#define CLK_GOUT_IS_SYSREG_PCLK		23
> +#define IS_NR_CLK			24
> +
>  /* CMU_PERI */
>  #define CLK_MOUT_PERI_BUS_USER		1
>  #define CLK_MOUT_PERI_UART_USER		2


Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
