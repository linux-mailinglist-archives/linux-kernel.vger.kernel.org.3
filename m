Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AD54EAADF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 11:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbiC2KA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 06:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbiC2KA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:00:27 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68ABF3BF91;
        Tue, 29 Mar 2022 02:58:44 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r13so23969444wrr.9;
        Tue, 29 Mar 2022 02:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Cqxr6OhCLAeis14Ai1MXs5IbZsdF6NcwLCK9JA8OCCk=;
        b=APkLu1nrcJCt/DUy6IoHQg+vXFfPUQpIBuInTdRsn9n+DSItES39e8hU5u3bRelbyB
         RymW7jdF2JhdotCR/QQ8OAdIj1/IPVJT3LXE7aiQ8rb+UPFgIdpFOk4U3DtB7q1wXliw
         8EgXvGen5NVyIzI5lgOQB7WSMNfyP9yN2RpYRxYm31LxnREzsSyd1tFUkQBRXjYWZu7o
         adexctW1y40/DCBI7WHJL6o0EY3bKZ/CY0zixRissxuynDmho4ND2RwV+qddNCW7QFWN
         Idce5bpc1guxX9+YSz309F2GuQNMRf4M3ZjEEKTMUK+Iumyrk8itZSVBpBVQRl+jl4kD
         XBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Cqxr6OhCLAeis14Ai1MXs5IbZsdF6NcwLCK9JA8OCCk=;
        b=C1J/DyGkTE9RhJMj5aaimMhJuuBB/qRuPnQ0ONyiJtEDRZoCWN6gWZqe7O6TsApQ17
         mp3bKZgxl3R9yJ38QqqY25z0F8XnpuSDbs1h2K5FiZ0CZGwYqdT7XC/k17z7+iLe5e0d
         e3rCBBY1ByI+ZiSbnaqeXRvwNqKaY3kk5JpbuoU6cMNj3m50YS9l01DbsHaxWeng0qPq
         lyYUo1dhy2gzodCh/YmwV8tSAd/Ixzq/wpzwegzTvtIPTjb9p40vMx8Zudjhow8U7gSi
         HRdbxtSB8EikdNkekQSpLJOCeaVX3Prk8ACZHp03xWybLhSr5t4v9a/x09smrlWgFqDr
         I6kg==
X-Gm-Message-State: AOAM533+KDG7Ome39VsnMH1AFMLaz7niwcHX5doPqzPnpPPwrnXHAmOX
        SoPQ7ods4KL0GUDBO8+TfUY=
X-Google-Smtp-Source: ABdhPJzxnYdYXMhuUZ0oZHT2rxzYUX+MKBj+eCpNozcEdgx5kp2txaItFhIM1PdWk5f+lsuYwpzm3g==
X-Received: by 2002:a5d:588c:0:b0:205:7f17:3901 with SMTP id n12-20020a5d588c000000b002057f173901mr29825326wrf.359.1648547922831;
        Tue, 29 Mar 2022 02:58:42 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id p23-20020a1c5457000000b0038c98c12ea9sm1812512wmi.1.2022.03.29.02.58.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 02:58:42 -0700 (PDT)
Message-ID: <9e4e1905-6c43-44c6-e812-58d802baf88b@gmail.com>
Date:   Tue, 29 Mar 2022 11:58:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 16/22] arm64: dts: mt8192: Add vcodec lat and core
 nodes
Content-Language: en-US
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>
References: <20220318144534.17996-1-allen-kh.cheng@mediatek.com>
 <20220318144534.17996-17-allen-kh.cheng@mediatek.com>
 <70350446-9e89-3c7b-d515-22cb2ed5a9ca@gmail.com>
 <af19b42faf9a510578e48d6f497e7d2069327195.camel@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <af19b42faf9a510578e48d6f497e7d2069327195.camel@mediatek.com>
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



On 29/03/2022 11:09, allen-kh.cheng wrote:
> Hi Matthias,
> 
> On Fri, 2022-03-25 at 16:22 +0100, Matthias Brugger wrote:
>>
>> On 18/03/2022 15:45, Allen-KH Cheng wrote:
>>> Add vcodec lat and core nodes for mt8192 SoC.
>>>
>>> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
>>> ---
>>>    arch/arm64/boot/dts/mediatek/mt8192.dtsi | 61
>>> ++++++++++++++++++++++++
>>>    1 file changed, 61 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>> b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>> index 63893779b193..71ad3adeed51 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>> @@ -1285,6 +1285,67 @@
>>>    			power-domains = <&spm
>>> MT8192_POWER_DOMAIN_ISP2>;
>>>    		};
>>>    
>>> +		vcodec_dec: vcodec-dec@16000000 {
>>> +			compatible = "mediatek,mt8192-vcodec-dec";
>>> +			reg = <0 0x16000000 0 0x1000>;	/* VDEC_SYS
>>> */
>>> +			mediatek,scp = <&scp>;
>>> +			iommus = <&iommu0 M4U_PORT_L4_VDEC_MC_EXT>;
>>> +			#address-cells = <2>;
>>> +			#size-cells = <2>;
>>> +			ranges = <0 0 0 0x16000000 0 0x26000>;
>>> +
>>> +			vcodec_lat: vcodec-lat@10000 {
>>> +				compatible = "mediatek,mtk-vcodec-lat";
>>> +				reg = <0x0 0x10000 0 0x800>;		
>>> /* VDEC_MISC */
>>> +				interrupts = <GIC_SPI 426
>>> IRQ_TYPE_LEVEL_HIGH 0>;
>>> +				iommus = <&iommu0
>>> M4U_PORT_L5_VDEC_LAT0_VLD_EXT>,
>>> +					 <&iommu0
>>> M4U_PORT_L5_VDEC_LAT0_VLD2_EXT>,
>>> +					 <&iommu0
>>> M4U_PORT_L5_VDEC_LAT0_AVC_MV_EXT>,
>>> +					 <&iommu0
>>> M4U_PORT_L5_VDEC_LAT0_PRED_RD_EXT>,
>>> +					 <&iommu0
>>> M4U_PORT_L5_VDEC_LAT0_TILE_EXT>,
>>> +					 <&iommu0
>>> M4U_PORT_L5_VDEC_LAT0_WDMA_EXT>,
>>> +					 <&iommu0
>>> M4U_PORT_L5_VDEC_LAT0_RG_CTRL_DMA_EXT>,
>>> +					 <&iommu0
>>> M4U_PORT_L5_VDEC_UFO_ENC_EXT>;
>>> +				clocks = <&topckgen CLK_TOP_VDEC_SEL>,
>>> +					 <&vdecsys_soc
>>> CLK_VDEC_SOC_VDEC>,
>>> +					 <&vdecsys_soc
>>> CLK_VDEC_SOC_LAT>,
>>> +					 <&vdecsys_soc
>>> CLK_VDEC_SOC_LARB1>,
>>> +					 <&topckgen
>>> CLK_TOP_MAINPLL_D4>;
>>> +				clock-names = "vdec-sel", "vdec-soc-
>>> vdec", "vdec-soc-lat",
>>> +					      "vdec-vdec", "vdec-top";
>>
>> Clock names do not match binding description. We have superfluous
>> "vdec-"
>> prefix. Same holds for mtk-vcodec-core. Anway I applied that patch as
>> the driver
>> does not care about the clock name. In any case it would be good if
>> you could
>> send a follow-up patch to fix the clock name.
>>
>> Applied, thanks
>>
> 
> Sorry, This is our mistake. those clk names should not append "vdec-"
> prefix from Rob's suggestion [1]. ('vdec-' is redundant)
> 
> Please drop this patch in v5.18-next/dts64.  I will send the corrected
> version.
> 

Ok, I dropped the commit from the branch for now.

> I apologize any inconvenience caused.
> 

No worries.

Regards,
Matthias

> [1] https://lore.kernel.org/all/YYFCaHI%2FDASUz+Vu@robh.at.kernel.org/
> 
> Thanks,
> Allen
> 
>>> +				assigned-clocks = <&topckgen
>>> CLK_TOP_VDEC_SEL>;
>>> +				assigned-clock-parents = <&topckgen
>>> CLK_TOP_MAINPLL_D4>;
>>> +				power-domains = <&spm
>>> MT8192_POWER_DOMAIN_VDEC>;
>>> +			};
>>> +
>>> +			vcodec_core: vcodec-core@25000 {
>>> +				compatible = "mediatek,mtk-vcodec-
>>> core";
>>> +				reg = <0 0x25000 0 0x1000>;	/*
>>> VDEC_CORE_MISC */
>>> +				interrupts = <GIC_SPI 425
>>> IRQ_TYPE_LEVEL_HIGH 0>;
>>> +				iommus = <&iommu0
>>> M4U_PORT_L4_VDEC_MC_EXT>,
>>> +					 <&iommu0
>>> M4U_PORT_L4_VDEC_UFO_EXT>,
>>> +					 <&iommu0
>>> M4U_PORT_L4_VDEC_PP_EXT>,
>>> +					 <&iommu0
>>> M4U_PORT_L4_VDEC_PRED_RD_EXT>,
>>> +					 <&iommu0
>>> M4U_PORT_L4_VDEC_PRED_WR_EXT>,
>>> +					 <&iommu0
>>> M4U_PORT_L4_VDEC_PPWRAP_EXT>,
>>> +					 <&iommu0
>>> M4U_PORT_L4_VDEC_TILE_EXT>,
>>> +					 <&iommu0
>>> M4U_PORT_L4_VDEC_VLD_EXT>,
>>> +					 <&iommu0
>>> M4U_PORT_L4_VDEC_VLD2_EXT>,
>>> +					 <&iommu0
>>> M4U_PORT_L4_VDEC_AVC_MV_EXT>,
>>> +					 <&iommu0
>>> M4U_PORT_L4_VDEC_RG_CTRL_DMA_EXT>;
>>> +				clocks = <&topckgen CLK_TOP_VDEC_SEL>,
>>> +					 <&vdecsys CLK_VDEC_VDEC>,
>>> +					 <&vdecsys CLK_VDEC_LAT>,
>>> +					 <&vdecsys CLK_VDEC_LARB1>,
>>> +					 <&topckgen
>>> CLK_TOP_MAINPLL_D4>;
>>> +				clock-names = "vdec-sel", "vdec-soc-
>>> vdec", "vdec-soc-lat",
>>> +					      "vdec-vdec", "vdec-top";
>>> +				assigned-clocks = <&topckgen
>>> CLK_TOP_VDEC_SEL>;
>>> +				assigned-clock-parents = <&topckgen
>>> CLK_TOP_MAINPLL_D4>;
>>> +				power-domains = <&spm
>>> MT8192_POWER_DOMAIN_VDEC2>;
>>> +			};
>>> +		};
>>> +
>>>    		larb5: larb@1600d000 {
>>>    			compatible = "mediatek,mt8192-smi-larb";
>>>    			reg = <0 0x1600d000 0 0x1000>;
> 
