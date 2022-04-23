Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAE450C94A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 12:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbiDWKbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 06:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234972AbiDWKbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 06:31:33 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A002A1BD59A
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 03:28:36 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id t11so20715142eju.13
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 03:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rEPflbqVq1mwFueQyojCpMmcKQ/e36y3oykipPSeFRU=;
        b=tG3JcefyPmF6/GrC/QJTrF6f5MpDidoi27/C1CIVpJIIzMgykgvW+RWmmiuDpBawlr
         LMXsyNkcwWvwDMUMcjlOQIZYF93Vxljkd/IkIDfHE7DzIlteLFPfUqmTnf/wJJrD4KOu
         BNMCkjeck9KI8/41gw9Kh4jIjya99qSm54prDXHt2DCnpPRbSKeCdhAxcDBU0U2mZTmR
         x5FjHPHzR3JLSmYk++9mSLZEo+g9K5ypkPt2qNzVmLxXBjkbUSJBhZvOVCk/W21xFZtq
         cLe6Lp76kMfmR+m/2jb+W+6rXnu7UjdPzCiaY51/6JB63t+UWVvxmOPZC7uPf/9/zbz9
         hsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rEPflbqVq1mwFueQyojCpMmcKQ/e36y3oykipPSeFRU=;
        b=sYxBfQJ2rDZ+HxH3exYX1uvCmxi56p2M0MgAy4LaLAI2Bp5pgGET+p4Tob09BvWSaO
         6jOn05GHK3VHj9Kc9wZj27mAyg+wYIAVj/fnWUYWa9a1Rpcb8Z4qSpk0VbtCNGOH0edg
         ge0Wq9nLreY1/ua0ptzRfN3ViYkJ27By+/Vi8hwyEA2akwb7a/55hPckRMzpakh2M4e8
         XXAIhb0iNCQyJm3e7ZlKaHLUHzB61DcUwkLAnsn3tvATl+eYBBaujJYyHWyY40JfbePc
         kAaymNdpr/7toFZkiK2lNvCMrozc/+JtO3hJ9d78HfmR39pnahNAWhfMHWZeonVpKhR2
         tBmA==
X-Gm-Message-State: AOAM5314pEZcEtnJLfmjTkjFdp1N88rRdBI9LoLaaWgDi5SQFl3XfuF1
        4Q78g+IYnC3Dp53rikMssFmFzQ==
X-Google-Smtp-Source: ABdhPJwu4TU8jIiiy/g+V6aSryzHQOlfKpEwLod4n/B0Gps/UtOcoR7DPUCkVDSY6/TR/WKuWYhQRQ==
X-Received: by 2002:a17:907:9482:b0:6da:8ad6:c8b5 with SMTP id dm2-20020a170907948200b006da8ad6c8b5mr7771140ejc.372.1650709715250;
        Sat, 23 Apr 2022 03:28:35 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gz15-20020a170906f2cf00b006f3802a963fsm52298ejb.21.2022.04.23.03.28.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 03:28:34 -0700 (PDT)
Message-ID: <e5b18654-ce83-44ee-e4c8-4cdfc4ceaa1d@linaro.org>
Date:   Sat, 23 Apr 2022 12:28:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V3 12/17] dt-binding: mt8192: Add infra_ao reset bit
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
References: <20220422060152.13534-1-rex-bc.chen@mediatek.com>
 <20220422060152.13534-13-rex-bc.chen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220422060152.13534-13-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2022 08:01, Rex-BC Chen wrote:
> To support reset of infra_ao, add the bit definition for thermal/PCIe/SVS.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>  include/dt-bindings/reset/mt8192-resets.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/dt-bindings/reset/mt8192-resets.h b/include/dt-bindings/reset/mt8192-resets.h
> index be9a7ca245b9..d5f3433175c1 100644
> --- a/include/dt-bindings/reset/mt8192-resets.h
> +++ b/include/dt-bindings/reset/mt8192-resets.h
> @@ -27,4 +27,14 @@
>  
>  #define MT8192_TOPRGU_SW_RST_NUM				23
>  
> +/* INFRA RST0 */
> +#define MT8192_INFRA_RST0_LVTS_AP_RST				0
> +/* INFRA RST2 */
> +#define MT8192_INFRA_RST2_PCIE_PHY_RST				15
> +/* INFRA RST3 */
> +#define MT8192_INFRA_RST3_PTP_RST				5
> +/* INFRA RST4 */
> +#define MT8192_INFRA_RST4_LVTS_MCU				12
> +#define MT8192_INFRA_RST4_PCIE_TOP				1

These should be the IDs of reset, not some register values/offsets.
Therefore it is expected to have them incremented by 1.


> +
>  #endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8192 */


Best regards,
Krzysztof
