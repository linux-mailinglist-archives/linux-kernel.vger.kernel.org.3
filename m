Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E755A9265
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbiIAIup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbiIAIul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:50:41 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F88171BDA
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 01:50:40 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id m16so21349588wru.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 01:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=A2FQLHZdgWMY5+2Vy68SDBQe0FvAsdbyc6G5rfD5/5o=;
        b=H3Q+6UfMvhjnOZlqFelmwDsjl2tA0NTYiE9PmJtYHvY0LVTmXtIP2h/5hldu0NLOke
         GUdEhxQ8A5CNlVtjPMoBCDpVBxrydnv0fOd8T+Hm5Ly4j2/KDWuzIxCK54Ar8HNNb5Wn
         wjER3HrAPCSHJm9gdDna5GrBcUGrSA77QaY7ufo9UtlQcjxu0AhC0APzK5vtYjHjcT7S
         EH513Nl875hXgcaC9IaX4N/DFQxsZCL5XH0VBf7hk4Hm6IUohR1SrLYOtYFt6qlCu6Qg
         CaefkXCVKT3LXzXk7IGSJDo7gqcZjce1tWP5AZmqd/eC1hiQUPLNLgE04w2YV+w3KO3s
         M4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=A2FQLHZdgWMY5+2Vy68SDBQe0FvAsdbyc6G5rfD5/5o=;
        b=jBbmavZJSeBZE+6OHRHpooNlyel25JmLyuIGVjpnPmPeUItoQHl2V04Wwg82gkMcec
         DgIs2vhVseoH/NWyR9RGDXVyFT5YmK/chKW5ZmGRwFvfBClAKbeXCjouWScZzKyvYkQW
         /SMgRRA9kZAVc+nF/N3MbMFXNrzAGOn29Dtg4tFY7QahEdhQrOtG/lmYQT7lIme5tZxO
         KTcBnoch4fdlJuCGMS98AnFmIUx4aRuyZijJoOBx3w0Vnk2dcaie+8dnDaJanYdxpjwe
         G/Ch/ret7284V/x+isoZQidpYYOU9CCEEnZ3RfjlRwRbP+iK7J7YuEM2aEKCI74egsQS
         mBFA==
X-Gm-Message-State: ACgBeo03/owRSjzGfrjtdHpT4HLi6hOUmZ9P/bVP+PDUqDWabxI3WfLA
        iSY7zYwEAT29tZLFcLYlZewopQ==
X-Google-Smtp-Source: AA6agR757jBQEEOMnzTvdrhLU2kaUT9IXbba0+T96klBBO4KX2U+sFZeASnIiyiMLtKuCJfyOQcPdw==
X-Received: by 2002:a5d:5b08:0:b0:226:f421:79ba with SMTP id bx8-20020a5d5b08000000b00226f42179bamr1486062wrb.44.1662022238566;
        Thu, 01 Sep 2022 01:50:38 -0700 (PDT)
Received: from [192.168.86.238] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id q16-20020adffed0000000b00226d1821abesm13352278wrs.56.2022.09.01.01.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 01:50:37 -0700 (PDT)
Message-ID: <8f907b3f-b02f-774a-f3f7-844527795fbd@linaro.org>
Date:   Thu, 1 Sep 2022 09:50:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 6/6] ASoC: codecs: tx-macro: add support for sm8450 and
 sc8280xp
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        broonie@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220818134619.3432-1-srinivas.kandagatla@linaro.org>
 <20220818134619.3432-7-srinivas.kandagatla@linaro.org>
 <aac3942d-bc0b-7763-0d12-f5d6c585cc97@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <aac3942d-bc0b-7763-0d12-f5d6c585cc97@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/09/2022 08:30, Krzysztof Kozlowski wrote:
> On 18/08/2022 16:46, Srinivas Kandagatla wrote:
>> LPASS VA Macro now has soundwire master to deal with access to
>> analog mic in low power island use cases.
>>
>> This is added after sc8280xp, add support for this.
>> Along with this also add compatibles for sm8450 and sc8280xp.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   sound/soc/codecs/lpass-va-macro.c | 64 ++++++++++++++++++++++++++++++-
>>   1 file changed, 62 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
>> index a35f684053d2..f8b0c8caa1db 100644
>> --- a/sound/soc/codecs/lpass-va-macro.c
>> +++ b/sound/soc/codecs/lpass-va-macro.c
>> @@ -25,6 +25,10 @@
>>   #define CDC_VA_FS_CONTROL_EN			BIT(0)
>>   #define CDC_VA_FS_COUNTER_CLR			BIT(1)
>>   #define CDC_VA_CLK_RST_CTRL_SWR_CONTROL		(0x0008)
>> +#define CDC_VA_SWR_RESET_MASK		BIT(1)
>> +#define CDC_VA_SWR_RESET_ENABLE		BIT(1)
>> +#define CDC_VA_SWR_CLK_EN_MASK		BIT(0)
>> +#define CDC_VA_SWR_CLK_ENABLE		BIT(0)
>>   #define CDC_VA_TOP_CSR_TOP_CFG0			(0x0080)
>>   #define CDC_VA_FS_BROADCAST_EN			BIT(1)
>>   #define CDC_VA_TOP_CSR_DMIC0_CTL		(0x0084)
>> @@ -66,6 +70,8 @@
>>   #define CDC_VA_TOP_CSR_SWR_MIC_CTL0		(0x00D0)
>>   #define CDC_VA_TOP_CSR_SWR_MIC_CTL1		(0x00D4)
>>   #define CDC_VA_TOP_CSR_SWR_MIC_CTL2		(0x00D8)
>> +#define CDC_VA_SWR_MIC_CLK_SEL_0_1_MASK		(0xEE)
>> +#define CDC_VA_SWR_MIC_CLK_SEL_0_1_DIV1		(0xCC)
>>   #define CDC_VA_TOP_CSR_SWR_CTRL			(0x00DC)
>>   #define CDC_VA_INP_MUX_ADC_MUX0_CFG0		(0x0100)
>>   #define CDC_VA_INP_MUX_ADC_MUX0_CFG1		(0x0104)
>> @@ -194,6 +200,8 @@ struct va_macro {
>>   	unsigned long active_ch_mask[VA_MACRO_MAX_DAIS];
>>   	unsigned long active_ch_cnt[VA_MACRO_MAX_DAIS];
>>   	u16 dmic_clk_div;
>> +	bool has_swr_master;
>> +	bool reset_swr;
>>   
>>   	int dec_mode[VA_MACRO_NUM_DECIMATORS];
>>   	struct regmap *regmap;
>> @@ -325,6 +333,9 @@ static bool va_is_rw_register(struct device *dev, unsigned int reg)
>>   	case CDC_VA_TOP_CSR_DMIC2_CTL:
>>   	case CDC_VA_TOP_CSR_DMIC3_CTL:
>>   	case CDC_VA_TOP_CSR_DMIC_CFG:
>> +	case CDC_VA_TOP_CSR_SWR_MIC_CTL0:
>> +	case CDC_VA_TOP_CSR_SWR_MIC_CTL1:
>> +	case CDC_VA_TOP_CSR_SWR_MIC_CTL2:
>>   	case CDC_VA_TOP_CSR_DEBUG_BUS:
>>   	case CDC_VA_TOP_CSR_DEBUG_EN:
>>   	case CDC_VA_TOP_CSR_TX_I2S_CTL:
>> @@ -1306,12 +1317,40 @@ static const struct snd_soc_component_driver va_macro_component_drv = {
>>   
>>   static int fsgen_gate_enable(struct clk_hw *hw)
>>   {
>> -	return va_macro_mclk_enable(to_va_macro(hw), true);
>> +	struct va_macro *va = to_va_macro(hw);
>> +	struct regmap *regmap = va->regmap;
>> +	int ret;
>> +
>> +	ret = va_macro_mclk_enable(va, true);
>> +	if (!va->has_swr_master)
>> +		return ret;
>> +
>> +	if (va->reset_swr)
>> +		regmap_update_bits(regmap, CDC_VA_CLK_RST_CTRL_SWR_CONTROL,
>> +				   CDC_VA_SWR_RESET_MASK,
>> +				   CDC_VA_SWR_RESET_ENABLE);
>> +
>> +	regmap_update_bits(regmap, CDC_VA_CLK_RST_CTRL_SWR_CONTROL,
>> +			   CDC_VA_SWR_CLK_EN_MASK,
>> +			   CDC_VA_SWR_CLK_ENABLE);
>> +	if (va->reset_swr)
>> +		regmap_update_bits(regmap, CDC_VA_CLK_RST_CTRL_SWR_CONTROL,
>> +				   CDC_VA_SWR_RESET_MASK, 0x0);
>> +	va->reset_swr = false;
>> +
>> +	return ret;
>>   }
>>   
>>   static void fsgen_gate_disable(struct clk_hw *hw)
>>   {
>> -	va_macro_mclk_enable(to_va_macro(hw), false);
>> +	struct va_macro *va = to_va_macro(hw);
>> +	struct regmap *regmap = va->regmap;
>> +
>> +	if (va->has_swr_master)
>> +		regmap_update_bits(regmap, CDC_VA_CLK_RST_CTRL_SWR_CONTROL,
>> +			   CDC_VA_SWR_CLK_EN_MASK, 0x0);
>> +
>> +	va_macro_mclk_enable(va, false);
>>   }
>>   
>>   static int fsgen_gate_is_enabled(struct clk_hw *hw)
>> @@ -1459,6 +1498,11 @@ static int va_macro_probe(struct platform_device *pdev)
>>   
>>   	dev_set_drvdata(dev, va);
>>   
>> +	if (of_device_is_compatible(dev->of_node, "qcom,sm8450-lpass-va-macro") ||
>> +		of_device_is_compatible(dev->of_node, "qcom,sc8280xp-lpass-va-macro")) {
>> +		va->has_swr_master = true;
>> +		va->reset_swr = true;
> 
> This should go to driver_data. Either via quirks/flags or device type
> (enum for each device). Usually the first (flags) is more flexible if
> you want to support many devices.

Yes, at-least this case is easily doable with driver_data, let me try to 
add this in next spin.


--srini
> 
> This also explains Rob's concerns about unneeded entries in of_device_id
> table.
> 
> 
> Best regards,
> Krzysztof
