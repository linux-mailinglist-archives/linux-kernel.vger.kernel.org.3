Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD2E56A5B8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 16:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235962AbiGGOnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 10:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235918AbiGGOnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 10:43:45 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3299D1A3A6;
        Thu,  7 Jul 2022 07:43:44 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r14so20867693wrg.1;
        Thu, 07 Jul 2022 07:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7zB98bE99TWpQmWntZaNoL4upEKygyq+84KXNA7Ndxg=;
        b=lmEPdC/BP3rLuGsEFqwbhkQSrZXQSMy1hAHabWq/q5z6rud561BSLIXnt2SeGcmjXs
         3b1CRRK56UM0VRWQZld5EPJfrvTXMJBgjY12MZUG3n4Widm6figX5vxB6YtVFS31C8Fg
         pvVZfcpv1BNCOi3simlg1B7FHULlojFXG6IHoqeSiGuWaX69tW7sdBB62OZKO86GapXa
         TCAkK97Uyz+8OUfzo0LeVF/nt1XPItN6iEPdDjbmOi+8q/mkyB8QvgvjkvEeBPduSic9
         giLlhicb1fcw2IBVfdrGUGMHyZKSu6kVq0KKsSCjyNUfiKK0mlChvRrqkjd8MG6M0UaK
         T8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7zB98bE99TWpQmWntZaNoL4upEKygyq+84KXNA7Ndxg=;
        b=dNKYYjhaxH98l4hpsyrWIwKI1IbRBZ5p0dcc+WzGQM4H8sFAdTTcMTyFhYdDxmucBf
         h20GYTAurcGefnCuk+u2kFnqf9HTWaPMmNY2HEOzufOuH3ACcXURhPtD8CnuaD4c3SBo
         AtVq+8Y82l3G7tu1yid+AKHziJvhAW29v3yZtsMFSmDo/uDbIrdz2/lnAPAKSy0w5Qtx
         ZCZK5bU6S0QZGucHBi24Hf0liRqF+0xQjHeEhNGxgLNJW74k8zYurCmgNJuQQ6RcPFdg
         tBPFJcTaExCJdcIobLWeKAhp4VgRydihIdMoAbmUKq81/2kGXh6l6AlsTh5zHIjHTa+D
         Yq6Q==
X-Gm-Message-State: AJIora+SxLNGvCg4EWGQuQdGVfbHvzuGRxgYj8ilp0e9ECdEzTUo7Ig+
        rMecWRIcfpZuzALofbxJcPk=
X-Google-Smtp-Source: AGRyM1vd3p8horCjkhzOZE22jq24Fc4VcQFDE+KNDBYFXZdgJnYoUBJxiMzjuTvWG3Nk+dC/p4eXaA==
X-Received: by 2002:a05:6000:104c:b0:21d:87bf:63a2 with SMTP id c12-20020a056000104c00b0021d87bf63a2mr2885660wrx.461.1657205022637;
        Thu, 07 Jul 2022 07:43:42 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id n5-20020a1ca405000000b0039c587342d8sm24719301wme.3.2022.07.07.07.43.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 07:43:41 -0700 (PDT)
Message-ID: <24bf3c0f-7070-0bcd-2fae-9fe086d146b2@gmail.com>
Date:   Thu, 7 Jul 2022 16:43:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] arm64: dts: mt8173: Fix nor_flash node
Content-Language: en-US
To:     Xiangsheng Hou <xiangsheng.hou@mediatek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, bin.zhang@mediatek.com,
        benliang.zhao@mediatek.com, linux-mediatek@lists.infradead.org
References: <20220630090157.29486-1-xiangsheng.hou@mediatek.com>
 <20220630090157.29486-2-xiangsheng.hou@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220630090157.29486-2-xiangsheng.hou@mediatek.com>
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



On 30/06/2022 11:01, Xiangsheng Hou wrote:
> Add axi clock since the driver change to DMA mode which need
> to enable axi clock. And change spi clock to 26MHz as default.
> 
> Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>

Applied, thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt8173.dtsi | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index 40d7b47fc52e..e603170100af 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -790,9 +790,12 @@ thermal: thermal@1100b000 {
>   		nor_flash: spi@1100d000 {
>   			compatible = "mediatek,mt8173-nor";
>   			reg = <0 0x1100d000 0 0xe0>;
> +			assigned-clocks = <&topckgen CLK_TOP_SPI_SEL>;
> +			assigned-clock-parents = <&clk26m>;
>   			clocks = <&pericfg CLK_PERI_SPI>,
> -				 <&topckgen CLK_TOP_SPINFI_IFR_SEL>;
> -			clock-names = "spi", "sf";
> +				 <&topckgen CLK_TOP_SPINFI_IFR_SEL>,
> +				 <&pericfg CLK_PERI_NFI>;
> +			clock-names = "spi", "sf", "axi";
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			status = "disabled";
