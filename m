Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD29B515686
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 23:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbiD2VRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 17:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbiD2VRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 17:17:30 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E84D3AD7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:14:11 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id g6so17688003ejw.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5KwQXg3kAfcueRIgWTz8+NJpII/FC8wWWYg6Q9Nthhc=;
        b=mSmefWgKqpjdEIThnO+p+FrR4IlVHz/aNeVt5V101jsLbtXHw+BYZRl5xTcyqyvWab
         8aEoiEpPi2yHf/oPuQxhTjAs+GVRsCA37+PiwXGepxyti1yh0+uQG8b+xCfrg3R4QHYt
         UfMB3qpecwjcCrFylGBsw4ZtR/ZrEP5/DjDmigOc7q9cWfgQ02tqgJFBCsuD7s5sYH86
         U0MLJXTBJ8I6pCZJ5Rtl7YRdHFiRLK7A6iYSSTX2/P+J++kFRAHDulh626RT+UBUwq3J
         g+07638sGr11NU+cC4r2BCmznCcOb4BJU2B12C2q7o1zai+a/zoq6w5yJG4ErEOK5Fky
         CRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5KwQXg3kAfcueRIgWTz8+NJpII/FC8wWWYg6Q9Nthhc=;
        b=c5CvzU4Zf9b+ccmcheYQSm3Vy2qzpIrR270Ny0yypbnS3+UAg7Dko4pjQVHzvy2KhO
         9ipxcFDLqZ/tmLizxKtPPtJaOrEKr9RhkFPoFebQ3LhPowirE/b5TOHvail9LS/giaub
         w10pvSJYJiR002tXIPM/9j+yWh99QS4dCLfCooag7DV3xLUZS2FMENl8YRYBpUZDzdb/
         zGWMqNmCO8Ytw/EEdzhm5WJs8Mru/7cjoygntxCM2N+JcQxgFbqiqj48zvmUHGTvz8ex
         FgRz7UPmOkdD25ohdjHVwxxST7ml51UPO5S/pueSvfew8v005LnfOsObw2NmuanxAo6c
         xxIw==
X-Gm-Message-State: AOAM530hRPq1iuelvn7fFkUFtnBlmYXN1L83yTYNkiKsRj5EPHQq6bl4
        9aX3Wpew+wqKpTNrUUVdjbVnXQ==
X-Google-Smtp-Source: ABdhPJxA3AMKRcsX7oz+W7wdrr79LG0j9RCZsK//gaPa8R0aALk15ZUNTze57cPZ6d9bBthB755RpA==
X-Received: by 2002:a17:906:5d11:b0:6f4:a04:6b44 with SMTP id g17-20020a1709065d1100b006f40a046b44mr1130215ejt.167.1651266849614;
        Fri, 29 Apr 2022 14:14:09 -0700 (PDT)
Received: from [192.168.0.176] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ze12-20020a170906ef8c00b006f3ef214e68sm967751ejb.206.2022.04.29.14.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 14:14:09 -0700 (PDT)
Message-ID: <6f70854f-1b5d-5445-5b63-23d7899f6871@linaro.org>
Date:   Fri, 29 Apr 2022 23:14:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V5 13/16] dt-bindings: reset: mediatek: Add infra_ao reset
 bit for MT8192
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, mturquette@baylibre.com,
        sboyd@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     p.zabel@pengutronix.de, angelogioacchino.delregno@collabora.com,
        chun-jie.chen@mediatek.com, wenst@chromium.org,
        runyang.chen@mediatek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220428115620.13512-1-rex-bc.chen@mediatek.com>
 <20220428115620.13512-14-rex-bc.chen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220428115620.13512-14-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/2022 13:56, Rex-BC Chen wrote:
> To support reset of infra_ao, add the bit definitions for MT8192.
> There are 5 banks for infra reset and 32 bits for each bank.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>  include/dt-bindings/reset/mt8192-resets.h | 163 ++++++++++++++++++++++
>  1 file changed, 163 insertions(+)
> 
> diff --git a/include/dt-bindings/reset/mt8192-resets.h b/include/dt-bindings/reset/mt8192-resets.h
> index be9a7ca245b9..5863d138568a 100644
> --- a/include/dt-bindings/reset/mt8192-resets.h
> +++ b/include/dt-bindings/reset/mt8192-resets.h
> @@ -7,6 +7,7 @@
>  #ifndef _DT_BINDINGS_RESET_CONTROLLER_MT8192
>  #define _DT_BINDINGS_RESET_CONTROLLER_MT8192
>  
> +/* TOPRGU resets */
>  #define MT8192_TOPRGU_MM_SW_RST					1
>  #define MT8192_TOPRGU_MFG_SW_RST				2
>  #define MT8192_TOPRGU_VENC_SW_RST				3
> @@ -27,4 +28,166 @@
>  
>  #define MT8192_TOPRGU_SW_RST_NUM				23
>  
> +/* INFRA RST0 */
> +#define MT8192_INFRA_RST0_THERM_CTRL_SWRST	0
> +#define MT8192_INFRA_RST0_USB_TOP_SWRST		1
> +#define MT8192_INFRA_RST0_AP_MD_CCIF_4_SWRST	2
> +#define MT8192_INFRA_RST0_MM_IOMMU_SWRST	3
> +#define MT8192_INFRA_RST0_MSDC3_SWRST		4
> +#define MT8192_INFRA_RST0_MSDC2_SWRST		5
> +#define MT8192_INFRA_RST0_MSDC1_SWRST		6
> +#define MT8192_INFRA_RST0_MSDC0_SWRST		7
> +#define MT8192_INFRA_RST0_AP_DMA_SWRST		8
> +#define MT8192_INFRA_RST0_MIPI_D_SWRST		9
> +#define MT8192_INFRA_RST0_MIPI_C_SWRST		10
> +#define MT8192_INFRA_RST0_BTIF_SWRST		11
> +#define MT8192_INFRA_RST0_SSUSB_TOP_SWRST	12
> +#define MT8192_INFRA_RST0_DISP_PWM_SWRST	13
> +#define MT8192_INFRA_RST0_AUXADC_SWRST		14
> +#define MT8192_INFRA_RST0_RSV0			15
> +#define MT8192_INFRA_RST0_RSV1			16
> +#define MT8192_INFRA_RST0_RSV2			17
> +#define MT8192_INFRA_RST0_RSV3			18
> +#define MT8192_INFRA_RST0_RSV4			19
> +#define MT8192_INFRA_RST0_RSV5			20
> +#define MT8192_INFRA_RST0_RSV6			21
> +#define MT8192_INFRA_RST0_RSV7			22
> +#define MT8192_INFRA_RST0_RSV8			23
> +#define MT8192_INFRA_RST0_RSV9			24
> +#define MT8192_INFRA_RST0_RSV10			25
> +#define MT8192_INFRA_RST0_RSV11			26
> +#define MT8192_INFRA_RST0_RSV12			27
> +#define MT8192_INFRA_RST0_RSV13			28
> +#define MT8192_INFRA_RST0_RSV14			29
> +#define MT8192_INFRA_RST0_RSV15			30
> +#define MT8192_INFRA_RST0_RSV16			31

Same problem as with previous patch - these are not IDs, but register
values with gaps.

Best regards,
Krzysztof
