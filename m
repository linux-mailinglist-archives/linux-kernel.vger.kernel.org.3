Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE8B512C93
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244977AbiD1HVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241048AbiD1HVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:21:47 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CB597289
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:18:33 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bv19so7724074ejb.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mBaBjlFs4Qhyum9X+FB4PBgRB7fsIlzVMQhpW1H9ZZ4=;
        b=cqS0hTiH1HfntnnTaStANQsQu27QSlSciZVbyV3aDN8vNZVpLYWulIuZ2qgoMNFiB6
         H+8hhB3oM+M/FruD3+bj8674Jl6s74Bwf9oaXeSwRq1O9qpOBJRcS/3zx8p6dSYx04by
         E/Py+F0tqz2GEc9qT7CAhjplvNC0vZiEi6G/TTGkrp76nnLc7CRJy5x2JFmiglMlqAEu
         1bx9ImhNooMrP29bnJxQuZxAO5NcvpCYBXXHF1r4ZpeCubDA/77j9pKAUAPdw6XlxU3u
         SyTI0Do40VglihVO1CY2kUPCpkYe0r5AAmPRUBxHiC9DWtLSHGAhNvaDQmJkfqnt0LEf
         xDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mBaBjlFs4Qhyum9X+FB4PBgRB7fsIlzVMQhpW1H9ZZ4=;
        b=liCNhT3VqAJtTuDEBJDyt/kGge+/y1XavFw3p2o8VyAp6I/QegqF+gIYkOhphkVVvT
         et8ab1riYSgEj049OSYMMV8bEHB9v3bSCl5vADTFAOQOXa/LwYguHNzFqb3iQUWB4bmY
         fPQiE/8aYNePHIyyhWb/QLl7M5j5PfsQ/qYlODf/1kYxk5kspKGp9hS3EjMmjERK0AQL
         qB4hNn4Fm2VIUS4r/uEQ4ZV+luwlHyMHdUaNVg847DndDLdsD83+Z1yRRZ3TIQSw8ukr
         gOPwv/BbfvWGJX4Mz+1iVS7maPkwLzoeCOkH3PX6d/yT7qutVAtUk8Z+9kbEtXSEtFay
         Vv5A==
X-Gm-Message-State: AOAM533PQ67G6Jr0SXHH8LdniZdGmPyzbK5KEjhQNPi+1AV8jYWYEE4v
        Vyy7rmJOBH+1Olj6K71+LY1B8g==
X-Google-Smtp-Source: ABdhPJwVuNe9f876NcOK+Qs8PuIFfo1l1GuseRL4xqp78YebmrHyUPTihDzB8RCfU4QhFE/K1Vah/w==
X-Received: by 2002:a17:907:7202:b0:6df:83a9:67d2 with SMTP id dr2-20020a170907720200b006df83a967d2mr29760294ejc.327.1651130312292;
        Thu, 28 Apr 2022 00:18:32 -0700 (PDT)
Received: from [192.168.0.160] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q23-20020aa7da97000000b0042617ba6380sm1024491eds.10.2022.04.28.00.18.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 00:18:31 -0700 (PDT)
Message-ID: <d96797dc-8fbd-fe1c-f970-2f6fc8ca5b69@linaro.org>
Date:   Thu, 28 Apr 2022 09:18:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V4 12/15] dt-bindings: reset: mediatek: Add infra_ao reset
 bit for MT8192/MT8195
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
References: <20220427030950.23395-1-rex-bc.chen@mediatek.com>
 <20220427030950.23395-13-rex-bc.chen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220427030950.23395-13-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2022 05:09, Rex-BC Chen wrote:
> - To support reset of infra_ao, add the bit definition of
>   thermal/PCIe/SVS for MT8192.
> - To support reset of infra_ao, add the bit definition of
>   thermal/SVS for MT8195.
> - Add the driver comment to separate the reset index for
>   TOPRGU and INFRA.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>  include/dt-bindings/reset/mt8192-resets.h | 8 ++++++++
>  include/dt-bindings/reset/mt8195-resets.h | 6 ++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/include/dt-bindings/reset/mt8192-resets.h b/include/dt-bindings/reset/mt8192-resets.h
> index be9a7ca245b9..ee0ca02a39bf 100644
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
> @@ -27,4 +28,11 @@
>  
>  #define MT8192_TOPRGU_SW_RST_NUM				23
>  
> +/* INFRA resets */
> +#define MT8192_INFRA_THERMAL_CTRL_RST			0
> +#define MT8192_INFRA_PEXTP_PHY_RST				79
> +#define MT8192_INFRA_PTP_RST					101
> +#define MT8192_INFRA_RST4_PCIE_TOP				129
> +#define MT8192_INFRA_THERMAL_CTRL_MCU_RST		140

This is still wrong. I gave you exactly what has to be used:
0
1
2
...

It's a decimal number incremented by one.


> +
>  #endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8192 */
> diff --git a/include/dt-bindings/reset/mt8195-resets.h b/include/dt-bindings/reset/mt8195-resets.h
> index a26bccc8b957..a3226f40779c 100644
> --- a/include/dt-bindings/reset/mt8195-resets.h
> +++ b/include/dt-bindings/reset/mt8195-resets.h
> @@ -7,6 +7,7 @@
>  #ifndef _DT_BINDINGS_RESET_CONTROLLER_MT8195
>  #define _DT_BINDINGS_RESET_CONTROLLER_MT8195
>  
> +/* TOPRGU resets */
>  #define MT8195_TOPRGU_CONN_MCU_SW_RST          0
>  #define MT8195_TOPRGU_INFRA_GRST_SW_RST        1
>  #define MT8195_TOPRGU_APU_SW_RST               2
> @@ -26,4 +27,9 @@
>  
>  #define MT8195_TOPRGU_SW_RST_NUM               16
>  
> +/* INFRA resets */
> +#define MT8195_INFRA_THERMAL_AP_RST            0
> +#define MT8195_INFRA_PTP_RST                   101
> +#define MT8195_INFRA_THERMAL_MCU_RST           138

Same issue.


Best regards,
Krzysztof
