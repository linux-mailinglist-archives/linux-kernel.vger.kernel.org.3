Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CB14E77DE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 16:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378561AbiCYPfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 11:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378884AbiCYP0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 11:26:00 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4CA6542D;
        Fri, 25 Mar 2022 08:24:24 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id kl29so6467926qvb.2;
        Fri, 25 Mar 2022 08:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=enC4Cm+VFbMXJ8ZY/YefPUBsSjow27Oy9HPQpG1Rb48=;
        b=ACrIBionqSd/X6CKhpsW/3KWWBv+AQcW1cxaymUjdMARjWL8SmgP0GEnEsBCNL5RVC
         fMNUcitspAP6r5FV360aMEy5nPmT2FucG1cYyQcolMW/nCLo4gI/DnmzNQN8Exjfe3gg
         IPiP98sy+i44dBw6flJIZ8DaTJKgRYAEHSGFfuY0qNf2yatCdMgpSjhHbcJrvZYEFM5r
         WoTkoW0z4Q8YPwsv+7qOFhLDaus5BHshWUuMra/JzT2QWAsr7Ge4zlFOtIvXUxexue9P
         dhMsBIrznUZuk7MLHrK1wtBs7MpBCx1vN+URf3+muTPXIypmxlExuR3e/6V0q3EfrN/z
         4uMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=enC4Cm+VFbMXJ8ZY/YefPUBsSjow27Oy9HPQpG1Rb48=;
        b=LfuhV2YohWU72OeYV0cLjD1Ya21ZRbP2UA6z066SroI1FF7jAz8mwrjsHd2foJV0fE
         6U6nLfku7TfSvRS3WuSAmkpyM+lbADw100DiR7oFZdSqcK0afL8ida5+XQ5h0Sge9vxV
         tgRIMTo5z3EnwijCHVMuhW4lkYPCZ5TFu+ki6C05F+mpZv/AZiMZjcO/443ClvrXwGUq
         nWaEIJPEhlQty07Hh8uP8clmXCOMa7aBmq+Nre4cMlaLl2Vj514HizcujR+QOyESYmqD
         xGBpksMw0C6m9FQ7xOjZTUQElaMTwsFIGDk0NSrpXHIsa1DTRe4ReLX6RgPYnPDKuXc5
         LCJA==
X-Gm-Message-State: AOAM533DGzDVA3QBeOfgCA1FiuWillgDCqmJ51zjEzE4X8L6L0kjLDnT
        9WIOgvR5vK6iLKV/kk6BijA=
X-Google-Smtp-Source: ABdhPJwcFW7IuU2aDnnWZG2xVtc3QsgNnIq+THxh/PTZSZpAQDxVb1uGYe++SdRidNjxvcwGmijVMw==
X-Received: by 2002:a05:6214:20a5:b0:440:f648:997d with SMTP id 5-20020a05621420a500b00440f648997dmr9582604qvd.130.1648221864117;
        Fri, 25 Mar 2022 08:24:24 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id k1-20020ac85fc1000000b002e1c6420790sm5742466qta.40.2022.03.25.08.24.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 08:24:23 -0700 (PDT)
Message-ID: <019b1a59-7531-75cf-3b86-d2798ca9823a@gmail.com>
Date:   Fri, 25 Mar 2022 16:24:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 17/22] arm64: dts: mt8192: Add dpi node
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>
References: <20220318144534.17996-1-allen-kh.cheng@mediatek.com>
 <20220318144534.17996-18-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220318144534.17996-18-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/03/2022 15:45, Allen-KH Cheng wrote:
> Add dpi node for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 71ad3adeed51..a77d405dd508 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -1236,6 +1236,17 @@
>   			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
>   		};
>   
> +		dpi0: dpi@14016000 {
> +			compatible = "mediatek,mt8192-dpi";
> +			reg = <0 0x14016000 0 0x1000>;
> +			interrupts = <GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&mmsys CLK_MM_DPI_DPI0>,
> +				 <&mmsys CLK_MM_DISP_DPI0>,
> +				 <&apmixedsys CLK_APMIXED_TVDPLL>;
> +			clock-names = "pixel", "engine", "pll";
> +			status = "disabled";

We are missing the output port node here.

Regards,
Matthias

> +		};
> +
>   		iommu0: m4u@1401d000 {
>   			compatible = "mediatek,mt8192-m4u";
>   			reg = <0 0x1401d000 0 0x1000>;
