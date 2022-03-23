Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083C54E5765
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 18:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343533AbiCWRZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 13:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbiCWRZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 13:25:36 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549F45D5D2;
        Wed, 23 Mar 2022 10:24:06 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id h23so3106937wrb.8;
        Wed, 23 Mar 2022 10:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Hb32dDdO1qQ+N0iO81Os3RXNLwN3DToRtRm2BHJ4zPY=;
        b=DRQktLhWWE7E8r8CBTkIuaY9kDFwj1GbxhNrCUaN4mKjEEvJoAnnnIUlC2KAtxVArp
         p/VyfyXpv1wETZBWfR6TEhNq3LkXs/9TnVkXq0ZybOllat3PX8hBPYETdN9omqua7TBN
         4E4maMMPy9qq/sPLEbxtO7vrmAfmWvqJ2yv7C4J9yThAyxr/4eaBVoYvkYf9Euhfv/Yl
         HejkFDaqKFS9k3wtm7OCoDof6qXtwhNc/I20Vbx/48z+lKZSdNc5gX87SFbWKbqeWACM
         J6OBPyupSfdVTLrs/EJQNhPfBaKYqd44oBOwYckaUG5nkAfjFgsgY1r+PJ3NUElMwrqy
         n0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Hb32dDdO1qQ+N0iO81Os3RXNLwN3DToRtRm2BHJ4zPY=;
        b=MQak1Tqzq/DRxfTTJwOXkMzT0E/Y5N85VQiwDejiZcLpzNJdKvpRT9GXXZMoZX2CRR
         GP0qgjQfYsIxckKKVLFtnn74+dsj4xScITNMoFdJhgQDN3M8eWb4Dg7mdQ6P6kCg4DbH
         48XlPJlVd//avy+cTOP9PVJagIncJ03TswFsJPErQpXqpSUT4wHYmCGzAAYhh29xUEhy
         lPaJHbUezKWS2V36WpfmjqqKws7zWBUxhHx33enETuR8GJHQ5ho4cR8rsDGkzySn7oiR
         AmVZJCzl4+n/Et6+i11wFoZdrzFG8CNgmy0KAnQdw93Li+M8i2vA8kTgDuiMziGuqSQP
         UHdg==
X-Gm-Message-State: AOAM532g/P3U8dWCgAiH4/mHqbPjnqqhYP7y85ptzRLtQUaaPMkdSmkI
        GLTAcQJKm5L46jjnUInBbuU=
X-Google-Smtp-Source: ABdhPJz0gyJKC1sgaW3NYJbopqhfgocbBO3YRKk4AGZ4glvtMs0XETdWdH0DbswGnxUuw50ias6wlw==
X-Received: by 2002:a05:6000:1863:b0:204:101a:b2b4 with SMTP id d3-20020a056000186300b00204101ab2b4mr817017wri.259.1648056244689;
        Wed, 23 Mar 2022 10:24:04 -0700 (PDT)
Received: from [192.168.0.32] ([137.101.87.65])
        by smtp.gmail.com with ESMTPSA id k2-20020a1ca102000000b0038c78fdd59asm4488884wme.39.2022.03.23.10.24.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 10:24:04 -0700 (PDT)
Message-ID: <a4935385-e7a5-8650-914b-73c699d2f8ca@gmail.com>
Date:   Wed, 23 Mar 2022 18:24:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 03/22] arm64: dts: mt8192: Add gce node
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
 <20220318144534.17996-4-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220318144534.17996-4-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
> Add gce node for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 0f9f211ca986..9e1b563bebab 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -6,6 +6,7 @@
>   
>   /dts-v1/;
>   #include <dt-bindings/clock/mt8192-clk.h>
> +#include <dt-bindings/gce/mt8192-gce.h>
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/interrupt-controller/irq.h>
>   #include <dt-bindings/pinctrl/mt8192-pinfunc.h>
> @@ -552,6 +553,15 @@
>   			#size-cells = <0>;
>   		};
>   
> +		gce: mailbox@10228000 {
> +			compatible = "mediatek,mt8192-gce";
> +			reg = <0 0x10228000 0 0x4000>;
> +			interrupts = <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH 0>;
> +			#mbox-cells = <3>;

#mbox-cells should be 2, right?

Regards,
Matthias

> +			clocks = <&infracfg CLK_INFRA_GCE>;
> +			clock-names = "gce";
> +		};
> +
>   		scp_adsp: clock-controller@10720000 {
>   			compatible = "mediatek,mt8192-scp_adsp";
>   			reg = <0 0x10720000 0 0x1000>;
