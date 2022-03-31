Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABAA44EDB96
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 16:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237465AbiCaOVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 10:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237455AbiCaOVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 10:21:36 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2E51BE4F9;
        Thu, 31 Mar 2022 07:19:49 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id b17-20020a0568301df100b005ce0456a9efso3774500otj.9;
        Thu, 31 Mar 2022 07:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Vm/tLIcwztm/cAKbFq5hHS63stt8moqDI9vFQVEX30w=;
        b=BacBToiK8uRJiYP8U49LBgQIIk48GIXBiDcFFbQX70JKSoZiVymsFSN84pgd2xGBUP
         I3hhs4i+5uCE3p+wCmcL+oJk+n/mLbzzymDDLXeIVLVU+o2pcWQHSsuE6Sq9TjyeaMi5
         FLt3FFJzp10/llYMGVcgIMsbUBKhefUl1PY3LUzM1rINwwg7Gb87cTpfA59pkFiW0Q6s
         K/SE5gAjNWlrL532/Ng+WvWcZ8dRsL+35hHVQ/sJ/gslQbFz26rIB+54RaRBuUqIMDLi
         VFTX/NBB5Wr0Y14Nl8nVs8bjFssMJrX2GRNq+yjFLZWwUq22gvirxt4jtWFCe/RTCTkX
         d0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Vm/tLIcwztm/cAKbFq5hHS63stt8moqDI9vFQVEX30w=;
        b=VpQlx7EMa49oMBgfuHxkMjmZI7/1pvs2st0YPvnctaV6B7mBNa2OJG+F7tzyckPkqf
         Mm6X6nAdN1XxzprrmjBXz7j0wR4Vv3xn6gIYQnPwHZ0NILpg4/p5zCSvTeAMrAgM9yO1
         KzK1xC0yfkP0qs3gBbU+7GYrUsxNVFDQdaEYt3apPISUUHeuIDvSEcu9EhDGXZWDNZlk
         t3brlfHoN7ZPAdxe256KG8r5svlavqi7qw+8WreamQy4gYuH4SDPeXHuDfnGmFpoLMMf
         7U3mGFK3CUMt/ozWcdvqno4U7VFgKjYM34ATNqIy/U92moGhgOviNTVzE71yOAaXvNDb
         p2YQ==
X-Gm-Message-State: AOAM531X9vBCRtdM7PMTT4lcEAkCn35oXoC+CS5pHkUXX1rOMJJbF1Kp
        KUaLcwF65h164SoaWl64csc=
X-Google-Smtp-Source: ABdhPJxvaMnWlIqOGNm++kxUq/OI22tXvuvCi7hITtxpHtFZJ3FqhnurnjI95U9h2jczQz9rtAONIQ==
X-Received: by 2002:a05:6830:2b0d:b0:5cd:aca2:f3f2 with SMTP id l13-20020a0568302b0d00b005cdaca2f3f2mr5709703otv.212.1648736388863;
        Thu, 31 Mar 2022 07:19:48 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id x25-20020a056830409900b005af164235b4sm11919171ott.2.2022.03.31.07.19.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 07:19:47 -0700 (PDT)
Message-ID: <68f66e54-e5e4-28ff-96a9-d4eaffc08c82@gmail.com>
Date:   Thu, 31 Mar 2022 16:19:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 2/4] arm64: dts: mt8192: Add mmc device nodes
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
References: <20220330133816.30806-1-allen-kh.cheng@mediatek.com>
 <20220330133816.30806-3-allen-kh.cheng@mediatek.com>
 <4cd1c5fa-0982-0355-d5b6-7025b82174a4@gmail.com>
 <ccd28405c8f2c420354f3355fc9d4ef1dd7ea35d.camel@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <ccd28405c8f2c420354f3355fc9d4ef1dd7ea35d.camel@mediatek.com>
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



On 31/03/2022 14:48, allen-kh.cheng wrote:
> Hi Matthias,
> 
> On Thu, 2022-03-31 at 14:02 +0200, Matthias Brugger wrote:
>>
>> On 30/03/2022 15:38, Allen-KH Cheng wrote:
>>> Add mmc nodes for mt8192 SoC.
>>>
>>> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
>>> Reviewed-by: AngeloGioacchino Del Regno <
>>> angelogioacchino.delregno@collabora.com>
>>
>> You forgot to disable the msdc clock node, which I understood we
>> agreed on in in
>> v4. I would consider this change as an substantial one, so in this
>> case please
>> delete the reviewed-by tags.
>>
>> Regards,
>> Matthias
>>
> 
> Is it ok I send a new patch for this instead of a series?

Yes sure.

Matthias

> 
> Best regards,
> Allen
> 
>>> ---
>>>    arch/arm64/boot/dts/mediatek/mt8192.dtsi | 32
>>> ++++++++++++++++++++++++
>>>    1 file changed, 32 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>> b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>> index 69e8d1934d53..c1057878e2c6 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>> @@ -991,6 +991,38 @@
>>>    			#clock-cells = <1>;
>>>    		};
>>>    
>>> +		mmc0: mmc@11f60000 {
>>> +			compatible = "mediatek,mt8192-mmc",
>>> "mediatek,mt8183-mmc";
>>> +			reg = <0 0x11f60000 0 0x1000>, <0 0x11f50000 0
>>> 0x1000>;
>>> +			interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH
>>> 0>;
>>> +			clocks = <&topckgen CLK_TOP_MSDC50_0_SEL>,
>>> +				 <&msdc_top CLK_MSDC_TOP_H_MST_0P>,
>>> +				 <&msdc_top CLK_MSDC_TOP_SRC_0P>,
>>> +				 <&msdc_top CLK_MSDC_TOP_P_CFG>,
>>> +				 <&msdc_top CLK_MSDC_TOP_P_MSDC0>,
>>> +				 <&msdc_top CLK_MSDC_TOP_AXI>,
>>> +				 <&msdc_top
>>> CLK_MSDC_TOP_AHB2AXI_BRG_AXI>;
>>> +			clock-names = "source", "hclk", "source_cg",
>>> "sys_cg",
>>> +				      "pclk_cg", "axi_cg", "ahb_cg";
>>> +			status = "disabled";
>>> +		};
>>> +
>>> +		mmc1: mmc@11f70000 {
>>> +			compatible = "mediatek,mt8192-mmc",
>>> "mediatek,mt8183-mmc";
>>> +			reg = <0 0x11f70000 0 0x1000>, <0 0x11c70000 0
>>> 0x1000>;
>>> +			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH
>>> 0>;
>>> +			clocks = <&topckgen CLK_TOP_MSDC30_1_SEL>,
>>> +				 <&msdc_top CLK_MSDC_TOP_H_MST_1P>,
>>> +				 <&msdc_top CLK_MSDC_TOP_SRC_1P>,
>>> +				 <&msdc_top CLK_MSDC_TOP_P_CFG>,
>>> +				 <&msdc_top CLK_MSDC_TOP_P_MSDC1>,
>>> +				 <&msdc_top CLK_MSDC_TOP_AXI>,
>>> +				 <&msdc_top
>>> CLK_MSDC_TOP_AHB2AXI_BRG_AXI>;
>>> +			clock-names = "source", "hclk", "source_cg",
>>> "sys_cg",
>>> +				      "pclk_cg", "axi_cg", "ahb_cg";
>>> +			status = "disabled";
>>> +		};
>>> +
>>>    		mfgcfg: clock-controller@13fbf000 {
>>>    			compatible = "mediatek,mt8192-mfgcfg";
>>>    			reg = <0 0x13fbf000 0 0x1000>;
> 
