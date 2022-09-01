Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4DB5A9503
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbiIAKqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbiIAKql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:46:41 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3DA74BA6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 03:46:39 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id p16so5785207lfd.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 03:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=q7GfTDbztJBtRyiLzAqPadkhGM0mICn7vR8np4hSo2U=;
        b=ja3k4IT1AJG3cTCogL7Ah/V1RQRMAVc58+3EPHiTIgJpWylZ6l9lvyybcbBMtwi5ja
         k58U2jE80elsd8XkoJS2GhgxfxkdJUehErE0PfH+5xVMcqZYvJSiEW9Nx+BC8zSpBHRL
         VaaJE9+ODRL9JTue5gYdc2KC9nJ9q8XGBE89uyVYg+iMqRFS8UPg3Sw0Mza6SzFxt+po
         BeEUF+igPo9ys7LxA1p4qG2/DZskUpLsee36hl2L0o+33KJNDCuDNDOuWY2sviZX17gd
         FvlQqJI1fZdUyJmO6l9DS1QgBTUpB7s0Y6iYalWWhGng3v6dpvmByewFuXjrjrJRi8H9
         yCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=q7GfTDbztJBtRyiLzAqPadkhGM0mICn7vR8np4hSo2U=;
        b=NHQFV5atcaGNHmMH7n4g8Rhbq0o4cT3hf6zTsCr1RttgCwjV/RKNGGl1Mz3Zzp3qan
         sC1gwguwDZ9BKwwno91bzO+C55btMGf1NZ54MYHp2axm6YJVlwQnEW2oXRdHD/mOeMYH
         mSGKDRdSdVzTomz7/LvZH/zJgy3sG+g6P9/YhUq7SLtLsMpde0By6rMtgA89ep3A78nD
         Ym8aURS51MZaL51Xtrm/bfA1momrRE71gHTAZ702D7ZStvIQLbo/LscB03UXOY+v4CCT
         ULDK29PcXFiGPvdcFewG62QvYF5zsQFSz7uXazNGESjIQMXDzKVJOPn88I0mrFrDSjhV
         AYhg==
X-Gm-Message-State: ACgBeo1tPo6//1KdvhdwZnmDowdypyPs2rvM1PBAcvM/VHpj3x/0oM9s
        iRLV6upGNRWM7nJeBh6NhDSjGw==
X-Google-Smtp-Source: AA6agR42QJyzzyisVHax2ivC+hHxBqHzv3MiqXDqBhGKYSNiL2vKQOpWCYeqeHW9DRVEoPuU292NYQ==
X-Received: by 2002:a05:6512:2520:b0:494:6fbe:2269 with SMTP id be32-20020a056512252000b004946fbe2269mr4951805lfb.387.1662029198290;
        Thu, 01 Sep 2022 03:46:38 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id h3-20020a056512220300b00492f45cbbfcsm2286586lfu.302.2022.09.01.03.46.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 03:46:37 -0700 (PDT)
Message-ID: <ff2d8784-0cf9-fac9-4360-71cac30fbd76@linaro.org>
Date:   Thu, 1 Sep 2022 13:46:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v6 4/6] clk: qcom: gpucc-sc7280: Add cx collapse reset
 support
Content-Language: en-GB
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        krzysztof.kozlowski@linaro.org, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1661923108-789-1-git-send-email-quic_akhilpo@quicinc.com>
 <20220831104741.v6.4.I5e64ff4b77bb9079eb2edeea8a02585c9e76778f@changeid>
 <20220901103449.GC32271@pengutronix.de>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220901103449.GC32271@pengutronix.de>
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

On 01/09/2022 13:34, Philipp Zabel wrote:
> On Wed, Aug 31, 2022 at 10:48:25AM +0530, Akhil P Oommen wrote:
>> Allow a consumer driver to poll for cx gdsc collapse through Reset
>> framework.
>>
>> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>
>> (no changes since v3)
>>
>> Changes in v3:
>> - Convert 'struct qcom_reset_ops cx_gdsc_reset' to 'static const' (Krzysztof)
>>
>> Changes in v2:
>> - Minor update to use the updated custom reset ops implementation
>>
>>   drivers/clk/qcom/gpucc-sc7280.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/gpucc-sc7280.c b/drivers/clk/qcom/gpucc-sc7280.c
>> index 9a832f2..fece3f4 100644
>> --- a/drivers/clk/qcom/gpucc-sc7280.c
>> +++ b/drivers/clk/qcom/gpucc-sc7280.c
>> @@ -433,12 +433,22 @@ static const struct regmap_config gpu_cc_sc7280_regmap_config = {
>>   	.fast_io = true,
>>   };
>>   
>> +static const struct qcom_reset_ops cx_gdsc_reset = {
>> +	.reset = gdsc_wait_for_collapse,
> 
> This should be accompanied by a comment explaining the not-quite-reset
> nature of this workaround, i.e. what is the prerequisite for this to
> actually work as expected?
> 
>> +};
>> +
>> +static const struct qcom_reset_map gpucc_sc7280_resets[] = {
>> +	[GPU_CX_COLLAPSE] = { .ops = &cx_gdsc_reset, .priv = &cx_gdsc },
>> +};
>> +
>>   static const struct qcom_cc_desc gpu_cc_sc7280_desc = {
>>   	.config = &gpu_cc_sc7280_regmap_config,
>>   	.clks = gpu_cc_sc7280_clocks,
>>   	.num_clks = ARRAY_SIZE(gpu_cc_sc7280_clocks),
>>   	.gdscs = gpu_cc_sc7180_gdscs,
>>   	.num_gdscs = ARRAY_SIZE(gpu_cc_sc7180_gdscs),
>> +	.resets = gpucc_sc7280_resets,
>> +	.num_resets = ARRAY_SIZE(gpucc_sc7280_resets),
> 
> See my comment on patch 2. I think instead of adding a const struct
> qcom_reset_ops * to gpucc_sc7280_resets, this should just add a const
> struct reset_control * to gpu_cc_sc7280_desc.

While this will work for the sc7280, the platform that Akhil was 
developing, this will not work for other platforms (like sm8250), where 
the dispcc also provides traditional BCR resets.

-- 
With best wishes
Dmitry

