Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A748550B9B2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448451AbiDVON4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448499AbiDVON2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:13:28 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA455A59B;
        Fri, 22 Apr 2022 07:10:31 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b19so11209337wrh.11;
        Fri, 22 Apr 2022 07:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WHY5obBMCsooLhCw/OdTbOsgtgWent6rNWstqxABc8k=;
        b=e/2yN5QXX5uUIvThPXaFjSw4QvxarL0jFJu3iP+XV2vkhUWldP4uyN5EwZ9F6DjgEv
         4hQtzhWntNtvcgQHNnb8cPLxgGU3MJog3vehgdb9iqLNXHfrd1STE0v1IHHbFu1bfTjP
         h0Anp5g5MzaRrSaxPV+qKmF8EdlhofRpolYT2dCjq+A0v1Qwi4RkzyD35tOhh50y0Alv
         LIza9+/yJpBRZq/6dRs9X9zQfEgZopnC+Mp1RgEI5dVfsva/k94wyvXp2YgYgN+GQoZ9
         31M5Zy041aYQCi5j6Tia2lEH55rF1qdN0zC+9ZGFmjagbpGtxpMd5s8gcpRAe+QmqR3T
         217w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WHY5obBMCsooLhCw/OdTbOsgtgWent6rNWstqxABc8k=;
        b=Ql2TZ4dUAi++dARMwIXLh2XZKrqFS08OUqC9PYO6tcbET9X/QtcdjE3JIq5/lxrXNM
         +qbgJSCfMSYee8VdoTdEF9NBpVmWmD9oYBtRd++LJYiKD1ZrxdptY+x1Ec7yyjbss25E
         rpDVNYIxr3ttoRFY2orRsqBlyH8nKdpBkXqKGakPPADxtNfqYaXpLl2P01FNVqLgGhal
         rE4ZclCn7GSZryIS6q/HqDRRO6zTxnOqG3OB1jcOhfifYJl/sRVZrskwSY/BO5QmX54Z
         EV5I3mzZDRJLSB5AsAkdjxREWRWmRVupP0U0fC/Hhh7urbKUb1mW/i/HDz9UXXgCCeG/
         aFXA==
X-Gm-Message-State: AOAM531tfyfkULyXgHYVqtigXG39i8IenOcqKwxTp9BLPHF/TnQ7Ohnr
        REdmKyq7JNVz7wL5If5P4Ow=
X-Google-Smtp-Source: ABdhPJywHAB77yuMlFtbES0kJl5asaV9vipnnQKpbCcCz58AfmwYxCPCd4qbDAIkHpmtoRB+jxu7yA==
X-Received: by 2002:a05:6000:168c:b0:20a:84ea:6647 with SMTP id y12-20020a056000168c00b0020a84ea6647mr3979628wrd.191.1650636630327;
        Fri, 22 Apr 2022 07:10:30 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id t4-20020adfe104000000b00205b50f04f0sm1818776wrz.86.2022.04.22.07.10.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 07:10:29 -0700 (PDT)
Message-ID: <13768c7c-41e4-e24a-b325-2f01eeb1883f@gmail.com>
Date:   Fri, 22 Apr 2022 16:10:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/1] arm64: dts: mt8192: Add spmi node
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>
References: <20220419063226.15958-1-allen-kh.cheng@mediatek.com>
 <20220419063226.15958-2-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220419063226.15958-2-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/04/2022 08:32, Allen-KH Cheng wrote:
> Add spmi node for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Applied, thanks

> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index a6da7b04b9d4..164fae36a3d8 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -537,6 +537,21 @@
>   			assigned-clock-parents = <&topckgen CLK_TOP_OSC_D10>;
>   		};
>   
> +		spmi: spmi@10027000 {
> +			compatible = "mediatek,mt6873-spmi";
> +			reg = <0 0x10027000 0 0x000e00>,
> +			      <0 0x10029000 0 0x000100>;
> +			reg-names = "pmif", "spmimst";
> +			clocks = <&infracfg CLK_INFRA_PMIC_AP>,
> +				 <&infracfg CLK_INFRA_PMIC_TMR>,
> +				 <&topckgen CLK_TOP_SPMI_MST_SEL>;
> +			clock-names = "pmif_sys_ck",
> +				      "pmif_tmr_ck",
> +				      "spmimst_clk_mux";
> +			assigned-clocks = <&topckgen CLK_TOP_PWRAP_ULPOSC_SEL>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_OSC_D10>;
> +		};
> +
>   		scp_adsp: clock-controller@10720000 {
>   			compatible = "mediatek,mt8192-scp_adsp";
>   			reg = <0 0x10720000 0 0x1000>;
