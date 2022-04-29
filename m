Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8424515679
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 23:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbiD2VQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 17:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbiD2VQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 17:16:54 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2866ED3DB0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:13:35 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z19so10384329edx.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oq0Zya7alVgrjes/Aox+txkeo77UdQpWJ11CNaZCjU4=;
        b=DSDaYI2+JOc5fVJeq4O73f88PTpo/fjuytmL6ZOqRjaI2Eyegq1yOrp93DIeTBrMOx
         xZgBDlf7sdT33mwl3sUpRzO0giyNNlS/dxV2yWOgTh9nwy/frejL36p9dkMkNwod3Xz6
         iwM2EXuiDQbWBDUpiFOq6N2ZOU+SB+7ZMt8CGmDtu6LddcKKsUug8DIUXdSU/Zg2n4jm
         dL+u8LQFc6C2F1ZtYwrqHkZFZiCrbAm+330p8lk7pPSacMviChAy44LsiTaJeyzkMGq/
         EIuW8+biX6E0jVY9bwX5M2SxksjrZ7ir/F1xlbrJC2o1tAGpCBo0nIrAvEUdam3thJi7
         70lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oq0Zya7alVgrjes/Aox+txkeo77UdQpWJ11CNaZCjU4=;
        b=oT8ibUWuXfieKBFebAjuxxkHO6hFrjTj0HffUlrhZ3oY3EQ2+4czyflzzZ+YnJsUx/
         mPZ83hcNel+ROlAbGuVy3nYtTLaAz0oarSr6ToBw2uXwCiwJDMa8jD9IBU3WATtoQyT/
         YjRinMkCzsmTM5a0wIu8S03UEwO2zldAN6r/RY5Vwyu3DdzC2wOC5O7eel8kKF49Xuue
         d8TTBMrdrN71P0DMYDL+TX7m6UDwQp7P8H5Z20Z/SpXwfMXB610XPbGz7AeBIiPyrYlT
         a1HAjF3hPHjxlhlPYE/9QvlsVi7u/Yz/UgTjT2DG1Uj3UdEi1TMpveb2mI8LuYGcJOB/
         bYeA==
X-Gm-Message-State: AOAM532yG3V59uuI5WAaJYWzk8SZowXYe+ReOdVuPbFZulkSJpKCfKau
        BnM9jMzcAmvzAgVBdmGqzHIS5A==
X-Google-Smtp-Source: ABdhPJyVVhDYODMbBzhBifXA7nLpCfzCbTw5ofkKpFDmyCaG4pqIVxjAa/d1qFy9oGOViVNgIBZM+A==
X-Received: by 2002:a05:6402:51d3:b0:426:3a20:738b with SMTP id r19-20020a05640251d300b004263a20738bmr1249084edd.342.1651266813682;
        Fri, 29 Apr 2022 14:13:33 -0700 (PDT)
Received: from [192.168.0.176] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id e16-20020a170906845000b006f3ef214dc7sm952984ejy.45.2022.04.29.14.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 14:13:33 -0700 (PDT)
Message-ID: <839978c5-c337-7784-a04f-26b9883c703b@linaro.org>
Date:   Fri, 29 Apr 2022 23:13:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V5 12/16] dt-bindings: reset: mediatek: Add infra_ao reset
 bit for MT8195
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
 <20220428115620.13512-13-rex-bc.chen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220428115620.13512-13-rex-bc.chen@mediatek.com>
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
> To support reset of infra_ao, add the bit definitions for MT8195.
> The infra_ao reset includes 5 banks and 32 bits for each bank.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>  include/dt-bindings/reset/mt8195-resets.h | 170 ++++++++++++++++++++++
>  1 file changed, 170 insertions(+)
> 
> diff --git a/include/dt-bindings/reset/mt8195-resets.h b/include/dt-bindings/reset/mt8195-resets.h
> index a26bccc8b957..463114014483 100644
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
> @@ -26,4 +27,173 @@
>  
>  #define MT8195_TOPRGU_SW_RST_NUM               16
>  
> +/* INFRA RST0 */
> +#define MT8195_INFRA_RST0_THERM_CTRL_SWRST	0
> +#define MT8195_INFRA_RST0_RSV0			1
> +#define MT8195_INFRA_RST0_DISP_PWM1_SWRST	2
> +#define MT8195_INFRA_RST0_RSV1			3
> +#define MT8195_INFRA_RST0_MSDC3_SWRST		4
> +#define MT8195_INFRA_RST0_MSDC2_SWRST		5
> +#define MT8195_INFRA_RST0_MSDC1_SWRST		6
> +#define MT8195_INFRA_RST0_MSDC0_SWRST		7
> +#define MT8195_INFRA_RST0_RSV2			8
> +#define MT8195_INFRA_RST0_AP_DMA_SWRST		9
> +#define MT8195_INFRA_RST0_MIPI_D_SWRST		10
> +#define MT8195_INFRA_RST0_RSV3			11
> +#define MT8195_INFRA_RST0_RSV4			12
> +#define MT8195_INFRA_RST0_SSUSB_TOP_SWRST	13
> +#define MT8195_INFRA_RST0_DISP_PWM_SWRST	14
> +#define MT8195_INFRA_RST0_AUXADC_SWRST		15
> +#define MT8195_INFRA_RST0_RSV5			16
> +#define MT8195_INFRA_RST0_RSV6			17
> +#define MT8195_INFRA_RST0_RSV7			18
> +#define MT8195_INFRA_RST0_RSV8			19
> +#define MT8195_INFRA_RST0_RSV9			20
> +#define MT8195_INFRA_RST0_RSV10			21
> +#define MT8195_INFRA_RST0_RSV11			22
> +#define MT8195_INFRA_RST0_RSV12			23
> +#define MT8195_INFRA_RST0_RSV13			24
> +#define MT8195_INFRA_RST0_RSV14			25
> +#define MT8195_INFRA_RST0_RSV15			26
> +#define MT8195_INFRA_RST0_RSV16			27
> +#define MT8195_INFRA_RST0_RSV17			28
> +#define MT8195_INFRA_RST0_RSV18			29
> +#define MT8195_INFRA_RST0_RSV19			30
> +#define MT8195_INFRA_RST0_RSV20			31

These are not proper IDs... don't work-around usage of bits with fake
reserved IDs...

Best regards,
Krzysztof
