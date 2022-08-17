Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70ED0597692
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 21:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241488AbiHQTdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 15:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241472AbiHQTcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 15:32:39 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4389DA59A8;
        Wed, 17 Aug 2022 12:31:51 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id z187so12855096pfb.12;
        Wed, 17 Aug 2022 12:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=a4WPDRNFl9VRDXHPolaTqvtCXLp06gA359nw86kZc8I=;
        b=FOCe+A20nesw/7J1qKo2T4ckqoMgejhLqbR6V0ZydB/K5VYcVYa454MddJJgmAImAQ
         jwNT2rBtSxCbtGhLsYSBu4LtBgxsD9F6NS8Z9gUfYXneB1GdLsZA1W9uRK7vDOohMWSo
         dN5V4VdJ4yBzQzaIStR6qQrw25FpCyJpRVQYu7ziqtqx1qjR6RYk1dQMujCnZ+DxoPl3
         EWJFWrpoQRbQ5iC5sq8HWae6PcBr7xkO/bzzNETzxDsJpWU8+d54MRApGgE/cs8DRbEf
         PPdPKJ8Mvx4D1Tn2lDOXey3jb4Vf743hct9e6GnB4Uz4iEIxfg2eNl/psWDm/GrpOZ20
         j8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=a4WPDRNFl9VRDXHPolaTqvtCXLp06gA359nw86kZc8I=;
        b=oqgkrEoY+t86d158pbYQCVJt9riDaGMO2OcwytAv1JhDgcdC0vsjwr4y4ClZM9SQR/
         Q59MhopWFLruFMCtviVt4cgE1Hed59HHlY5CxCvg0aPa9eHXzqzBb2hG6aQMDkukhxP/
         NZMMDzQOy1/J0TKouFeFfP4uvhiR5u6UAFRpD7RkyRdqxtxVjp+a/LcskTQN/h4fyfK0
         cQg4oIgcPNXIQwlUMs6KnSwjyy+zc7o4mUipTv4oeTyJHhnpV3b43nUc+wUvitTfx7/n
         SuaHF+2te4aFh/lYbK99+CNYFBt5k219KTbOG0ZWjX2YD+uTiX3WaO5Xm8Tgwfwdh4TR
         IxDg==
X-Gm-Message-State: ACgBeo1PjvKUsHWwaR9MGU9d3EMaqJ40fMCWus4KIBbzCK9kjTa7mtvc
        DoNyp5vvQN51OH10l/xzA80=
X-Google-Smtp-Source: AA6agR7LDFmS3WjqSZElz8XpZNhIb4Ip39KyynzcmL8+sR0Xj08TPwtLOIbAiv5lPnTcOLCfPDHJVg==
X-Received: by 2002:a63:494a:0:b0:41c:f29e:2a2e with SMTP id y10-20020a63494a000000b0041cf29e2a2emr22908194pgk.477.1660764709539;
        Wed, 17 Aug 2022 12:31:49 -0700 (PDT)
Received: from [172.30.1.52] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id u1-20020a1709026e0100b0016f12cc0ecdsm265468plk.274.2022.08.17.12.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 12:31:48 -0700 (PDT)
Message-ID: <1d8ff716-598d-617a-34d7-62a433632f78@gmail.com>
Date:   Thu, 18 Aug 2022 04:31:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/9] dt-bindings: clock: Add bindings for Exynos850
 CMU_AUD
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
 <20220809113323.29965-2-semen.protsenko@linaro.org>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20220809113323.29965-2-semen.protsenko@linaro.org>
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
> CMU_AUD generates Cortex-A32 clock, bus clock and audio clocks for
> BLK_AUD. Add clock indices and binding documentation for CMU_AUD.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
> Changes in v2:
>   - (none)
> 
>  .../clock/samsung,exynos850-clock.yaml        | 19 ++++++
>  include/dt-bindings/clock/exynos850.h         | 68 ++++++++++++++++++-
>  2 files changed, 86 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
> index aa11815ad3a3..53511f056251 100644
> --- a/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
> @@ -33,6 +33,7 @@ properties:
>      enum:
>        - samsung,exynos850-cmu-top
>        - samsung,exynos850-cmu-apm
> +      - samsung,exynos850-cmu-aud
>        - samsung,exynos850-cmu-cmgp
>        - samsung,exynos850-cmu-core
>        - samsung,exynos850-cmu-dpu
> @@ -88,6 +89,24 @@ allOf:
>              - const: oscclk
>              - const: dout_clkcmu_apm_bus
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: samsung,exynos850-cmu-aud
> +
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: External reference clock (26 MHz)
> +            - description: AUD clock (from CMU_TOP)
> +
> +        clock-names:
> +          items:
> +            - const: oscclk
> +            - const: dout_aud
> +
>    - if:
>        properties:
>          compatible:
> diff --git a/include/dt-bindings/clock/exynos850.h b/include/dt-bindings/clock/exynos850.h
> index 0b6a3c6a7c90..3dc55d4e5b9e 100644
> --- a/include/dt-bindings/clock/exynos850.h
> +++ b/include/dt-bindings/clock/exynos850.h
> @@ -58,7 +58,10 @@
>  #define CLK_MOUT_CLKCMU_APM_BUS		46
>  #define CLK_DOUT_CLKCMU_APM_BUS		47
>  #define CLK_GOUT_CLKCMU_APM_BUS		48
> -#define TOP_NR_CLK			49
> +#define CLK_MOUT_AUD			49
> +#define CLK_GOUT_AUD			50
> +#define CLK_DOUT_AUD			51
> +#define TOP_NR_CLK			52
>  
>  /* CMU_APM */
>  #define CLK_RCO_I3C_PMIC		1
> @@ -87,6 +90,69 @@
>  #define CLK_GOUT_SYSREG_APM_PCLK	24
>  #define APM_NR_CLK			25
>  
> +/* CMU_AUD */
> +#define CLK_DOUT_AUD_AUDIF		1
> +#define CLK_DOUT_AUD_BUSD		2
> +#define CLK_DOUT_AUD_BUSP		3
> +#define CLK_DOUT_AUD_CNT		4
> +#define CLK_DOUT_AUD_CPU		5
> +#define CLK_DOUT_AUD_CPU_ACLK		6
> +#define CLK_DOUT_AUD_CPU_PCLKDBG	7
> +#define CLK_DOUT_AUD_FM			8
> +#define CLK_DOUT_AUD_FM_SPDY		9
> +#define CLK_DOUT_AUD_MCLK		10
> +#define CLK_DOUT_AUD_UAIF0		11
> +#define CLK_DOUT_AUD_UAIF1		12
> +#define CLK_DOUT_AUD_UAIF2		13
> +#define CLK_DOUT_AUD_UAIF3		14
> +#define CLK_DOUT_AUD_UAIF4		15
> +#define CLK_DOUT_AUD_UAIF5		16
> +#define CLK_DOUT_AUD_UAIF6		17
> +#define CLK_FOUT_AUD_PLL		18
> +#define CLK_GOUT_AUD_ABOX_ACLK		19
> +#define CLK_GOUT_AUD_ASB_CCLK		20
> +#define CLK_GOUT_AUD_CA32_CCLK		21
> +#define CLK_GOUT_AUD_CNT_BCLK		22
> +#define CLK_GOUT_AUD_CODEC_MCLK		23
> +#define CLK_GOUT_AUD_DAP_CCLK		24
> +#define CLK_GOUT_AUD_GPIO_PCLK		25
> +#define CLK_GOUT_AUD_PPMU_ACLK		26
> +#define CLK_GOUT_AUD_PPMU_PCLK		27
> +#define CLK_GOUT_AUD_SPDY_BCLK		28
> +#define CLK_GOUT_AUD_SYSMMU_CLK		29
> +#define CLK_GOUT_AUD_SYSREG_PCLK	30
> +#define CLK_GOUT_AUD_TZPC_PCLK		31
> +#define CLK_GOUT_AUD_UAIF0_BCLK		32
> +#define CLK_GOUT_AUD_UAIF1_BCLK		33
> +#define CLK_GOUT_AUD_UAIF2_BCLK		34
> +#define CLK_GOUT_AUD_UAIF3_BCLK		35
> +#define CLK_GOUT_AUD_UAIF4_BCLK		36
> +#define CLK_GOUT_AUD_UAIF5_BCLK		37
> +#define CLK_GOUT_AUD_UAIF6_BCLK		38
> +#define CLK_GOUT_AUD_WDT_PCLK		39
> +#define CLK_MOUT_AUD_CPU		40
> +#define CLK_MOUT_AUD_CPU_HCH		41
> +#define CLK_MOUT_AUD_CPU_USER		42
> +#define CLK_MOUT_AUD_FM			43
> +#define CLK_MOUT_AUD_PLL		44
> +#define CLK_MOUT_AUD_TICK_USB_USER	45
> +#define CLK_MOUT_AUD_UAIF0		46
> +#define CLK_MOUT_AUD_UAIF1		47
> +#define CLK_MOUT_AUD_UAIF2		48
> +#define CLK_MOUT_AUD_UAIF3		49
> +#define CLK_MOUT_AUD_UAIF4		50
> +#define CLK_MOUT_AUD_UAIF5		51
> +#define CLK_MOUT_AUD_UAIF6		52
> +#define IOCLK_AUDIOCDCLK0		53
> +#define IOCLK_AUDIOCDCLK1		54
> +#define IOCLK_AUDIOCDCLK2		55
> +#define IOCLK_AUDIOCDCLK3		56
> +#define IOCLK_AUDIOCDCLK4		57
> +#define IOCLK_AUDIOCDCLK5		58
> +#define IOCLK_AUDIOCDCLK6		59
> +#define TICK_USB			60
> +#define AUD_NR_CLK			61
> +
>  /* CMU_CMGP */
>  #define CLK_RCO_CMGP			1
>  #define CLK_MOUT_CMGP_ADC		2

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
