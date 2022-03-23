Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15C44E5771
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 18:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343557AbiCWR2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 13:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343562AbiCWR2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 13:28:06 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56E47484B;
        Wed, 23 Mar 2022 10:26:36 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id m30so3155874wrb.1;
        Wed, 23 Mar 2022 10:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=V9Yyooz68jl2Yv/SIAxGrm/okwE52nxnEfNEFc+sdng=;
        b=FrlZh6+UbspaaXyxhTyMHIa8XYe0QM+o1xheOIlAv4OtXepnmVZYhqUNJTBunN+QNA
         5EVR1h0DyGH7+43jc5PKu4FYGPEp03inEVfYWsDKTLpKrBHSv7ZWxFD3LoVz5typNvAs
         TO83pHFF1Hs9ATGDeTQWG3BR87fA1HAuTcynG6y84uo4VHkdiEpXHe9p19T1z5NbgpKA
         JBbCDBU2dX0qqapkPCi5FcwJBVxC1cOAYIunSgvLknsg8ibqoYVMILgtktz9EIdnh3YI
         Hv224v0kO4up3iC5sYXvibPhNm88mq3oS7pIUJDKYUUE165JQTX7TUM1pTXowL8KM8mc
         gwUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=V9Yyooz68jl2Yv/SIAxGrm/okwE52nxnEfNEFc+sdng=;
        b=r20G8vm3u0KHyupCtBlsVEkj+XPb9VeacT5PQ8RokSjNhCWt6JxVMdfNwFWjg2AuqY
         0sjrIO+ro5hUaEExWvqFf+bVFRRou5RrBOJYqRHZIp2RPOqqzsM95weZFXxpYYb1hPwi
         rIU5ftP7WT0XvZn+KQRwZ+09vbQH3+CEDf/VO7zMrD+/KKwZOnAzCPNZQfSE/yu7TVWF
         z+oYflLri0egYq8I0d6eWJnTWxrEH0YT8iAYfEyHkEW7Hw024TBgONJkk+Vn5u9LKYR5
         B74KOhRUk3+b8bsULE0oOnyxr3VdvMR5jSLYew6nsJ55vJtFaScDgFPRMIcDcTllgwLC
         3T7A==
X-Gm-Message-State: AOAM531NrMNvq2lPF7Fbgm560a+pVP6uXn2DrJyT+UeVcjXRFQja+C3R
        0b6GXQr3oVuXTe7HOgiPziY=
X-Google-Smtp-Source: ABdhPJz0Yv0mOtu8mBleQKGzx8/1JIWReXJKiILWv0hl+NKIR3DKIt6hnhyV6uzP2eJjCrNVa+qVlA==
X-Received: by 2002:a05:6000:2ca:b0:204:1e6a:d2a9 with SMTP id o10-20020a05600002ca00b002041e6ad2a9mr915767wry.182.1648056395232;
        Wed, 23 Mar 2022 10:26:35 -0700 (PDT)
Received: from [192.168.0.32] ([137.101.87.65])
        by smtp.gmail.com with ESMTPSA id j15-20020a05600c1c0f00b0038cabc63721sm378462wms.30.2022.03.23.10.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 10:26:34 -0700 (PDT)
Message-ID: <3c8b96c5-c390-0ff8-2434-b6bb2e60b3d3@gmail.com>
Date:   Wed, 23 Mar 2022 18:26:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 04/22] arm64: dts: mt8192: Add SCP node
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
 <20220318144534.17996-5-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220318144534.17996-5-allen-kh.cheng@mediatek.com>
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
> Add SCP node for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Applied, thanks

> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 9e1b563bebab..195d50894df4 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -706,6 +706,18 @@
>   			status = "disabled";
>   		};
>   
> +		scp: scp@10500000 {
> +			compatible = "mediatek,mt8192-scp";
> +			reg = <0 0x10500000 0 0x100000>,
> +			      <0 0x10700000 0 0x8000>,
> +			      <0 0x10720000 0 0xe0000>;
> +			reg-names = "sram", "l1tcm", "cfg";
> +			interrupts = <GIC_SPI 435 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&infracfg CLK_INFRA_SCPSYS>;
> +			clock-names = "main";
> +			status = "disabled";
> +		};
> +
>   		nor_flash: spi@11234000 {
>   			compatible = "mediatek,mt8192-nor";
>   			reg = <0 0x11234000 0 0xe0>;
