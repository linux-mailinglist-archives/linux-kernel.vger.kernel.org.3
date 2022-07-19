Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B4357A2DF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 17:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiGSPXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 11:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiGSPXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 11:23:22 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98552564DE
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:23:20 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id u14so9786131lju.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pqhYCDa4k7BSkOT4b1kC76TRKt393t/siOxiGVNN+FI=;
        b=PIMjyrgrsG9g6DN8NQgtQqvQkaB19xb7Eb7e1Ts+N+rZ+Iy6q9lnejF08vOwSza2Wl
         hL5vNVFdOf52quFtQeKwD7f7Lz4l03nnu1jC1CRMkeRkMFLhYuwQyskBgA2p2wT1THmS
         9h3ubm2WjQLxeQ0OyEFv4zLVWZa/5/9Mg64XNd0lNWXyJPfOFMqGtKtDPe9mDao1nNH2
         bUlkbK9rwt7yFiDn2nObmO2aOpp1ti2VrPKLYxw/pSyvF2yfU36fVDnGHT8447EcmpB6
         sI+opxU/rIGM4Fp+vsjrRibeVlx19ph4M4/tXxx91xHHQ0mjH4NTAFWD/F10drlqwX5j
         9/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pqhYCDa4k7BSkOT4b1kC76TRKt393t/siOxiGVNN+FI=;
        b=4NJwb6ZR54hSTvUyjkpVvshzK51OzG36ocWSGR5ZmoqGLa5nC/DGvyCIaVpWqTQr1W
         crFewtDX6ujU9kkdOe0mcWeIkh9IAgR7sheQtX3yPTY90gYy/N399DgvWCv0aT41S6f6
         UwhBo4HPir8CxDI0vpEJHrMs5F3riYk4CHbmn3otLBT0+FUb7S/az5JSgNtvIOEPdDP/
         S7nawTCnzFPsLdl/dmDIRiWzuLgboqXDTXngKy8zncOQC8avE4kLKqNLLsW12itwELCL
         Uklz/8cr7uDHxwHOXQgh7B3cMIFxZFwqomztZUb9AtMR4O67hwqUjXC2SYyH0ySZ1XDV
         LNkg==
X-Gm-Message-State: AJIora8Uf7SxOke++t0OExNsxgB8gGL7wh2Q+ryfXqITsmlVTHla1Dsk
        lNq1i0wkTNd8yWNUpmx24jOXYA==
X-Google-Smtp-Source: AGRyM1tOCKexAFz+e+zGasNjbn1CaiiOB7LbcNcKmkcqU8xiVvgvWs/GGve6vLW44dGoc3R2fu9D/w==
X-Received: by 2002:a2e:9e48:0:b0:258:fc8b:491f with SMTP id g8-20020a2e9e48000000b00258fc8b491fmr15527456ljk.36.1658244198777;
        Tue, 19 Jul 2022 08:23:18 -0700 (PDT)
Received: from [192.168.43.7] ([188.162.64.163])
        by smtp.gmail.com with ESMTPSA id d1-20020a056512368100b0047f4291a118sm3270528lfs.192.2022.07.19.08.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 08:23:18 -0700 (PDT)
Message-ID: <0eda5492-c933-c977-e0db-3bc92749afda@linaro.org>
Date:   Tue, 19 Jul 2022 18:23:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 3/3] clk: qcom: lcc-ipq806x: convert to parent data
Content-Language: en-GB
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220708000338.26572-1-ansuelsmth@gmail.com>
 <20220708000338.26572-3-ansuelsmth@gmail.com> <YtY2NWYq3Xbxu2pc@builder.lan>
 <62d6a229.1c69fb81.d5d0b.ac4a@mx.google.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <62d6a229.1c69fb81.d5d0b.ac4a@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2022 15:23, Christian Marangi wrote:
> On Mon, Jul 18, 2022 at 11:42:29PM -0500, Bjorn Andersson wrote:
>> On Thu 07 Jul 19:03 CDT 2022, Christian Marangi wrote:
>>
>>> Convert lcc-ipq806x driver to parent_data API.
>>>
>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>>> ---
>>> v5:
>>> - Fix the same compilation error (don't know what the hell happen
>>>    to my buildroot)
>>> v4:
>>> - Fix compilation error
>>> v3:
>>>   - Inline pxo pll4 parent
>>>   - Change .name from pxo to pxo_board
>>>
>>>   drivers/clk/qcom/lcc-ipq806x.c | 77 ++++++++++++++++++----------------
>>>   1 file changed, 42 insertions(+), 35 deletions(-)
>>>
>>> diff --git a/drivers/clk/qcom/lcc-ipq806x.c b/drivers/clk/qcom/lcc-ipq806x.c
>>> index ba90bebba597..72d6aea5be30 100644
>>> --- a/drivers/clk/qcom/lcc-ipq806x.c
>>> +++ b/drivers/clk/qcom/lcc-ipq806x.c
>>> @@ -34,7 +34,9 @@ static struct clk_pll pll4 = {
>>>   	.status_bit = 16,
>>>   	.clkr.hw.init = &(struct clk_init_data){
>>>   		.name = "pll4",
>>> -		.parent_names = (const char *[]){ "pxo" },
>>> +		.parent_data = &(const struct clk_parent_data) {
>>> +			.fw_name = "pxo", .name = "pxo_board",
>>
>> This changes the behavior from looking for the globally named "pxo" to
>> look for the globally named "pxo_board", in the event that no
>> clock-names of "pxo" was found (based on the .fw_name).
>>
>> So you probably want to keep this as .fw_name = "pxo", .name = "pxo".
>>
> 
> Hi,
> I will make this change but just for reference, I could be wrong by
> Dimitry pointed out that the pattern is .fw_name pxo .name pxo_board.
> The original patch had both set to pxo and it was asked to be changed.

We are generally trying to get rid of manually registered 'pxo' clock, 
thus all parent_names = pxo/cxo/xo entries are converted to .fw_name = 
"pxo/cxo/xo", .name = "pxo_board/cxo_board/xo_board" clocks. This has 
been done previously for all converted drivers w/o any questions. May be 
it's worth it mentioning pxo_board in the commit message.

> 
>>> +		},
>>>   		.num_parents = 1,
>>>   		.ops = &clk_pll_ops,
>>>   	},
>>> @@ -64,9 +66,9 @@ static const struct parent_map lcc_pxo_pll4_map[] = {
>>>   	{ P_PLL4, 2 }
>>>   };
>>>   
>>> -static const char * const lcc_pxo_pll4[] = {
>>> -	"pxo",
>>> -	"pll4_vote",
>>> +static const struct clk_parent_data lcc_pxo_pll4[] = {
>>> +	{ .fw_name = "pxo", .name = "pxo" },
>>> +	{ .fw_name = "pll4_vote", .name = "pll4_vote" },
>>
>> This is a reference to a clock defined in this same driver, so you can
>> use { .hw = &pll4_vote.clkr.hw } to avoid the lookup all together.
>>
> 
> Eh... pll4_vote is defined in gcc (for some reason) the one we have here
> is pll4.
> 
> I asked if this could be fixed in some way but it was said that it's
> better to not complicate things too much.

The chain is:
pxo -> pll4 @ lcc -> pll4_vote @ gcc -> i2s clocks @ lcc.


> 
>>>   };
>>>   
>>>   static struct freq_tbl clk_tbl_aif_mi2s[] = {
>>> @@ -131,18 +133,14 @@ static struct clk_rcg mi2s_osr_src = {
>>>   		.enable_mask = BIT(9),
>>>   		.hw.init = &(struct clk_init_data){
>>>   			.name = "mi2s_osr_src",
>>> -			.parent_names = lcc_pxo_pll4,
>>> -			.num_parents = 2,
>>> +			.parent_data = lcc_pxo_pll4,
>>> +			.num_parents = ARRAY_SIZE(lcc_pxo_pll4),
>>>   			.ops = &clk_rcg_ops,
>>>   			.flags = CLK_SET_RATE_GATE,
>>>   		},
>>>   	},
>>>   };
>>>   
>>> -static const char * const lcc_mi2s_parents[] = {
>>> -	"mi2s_osr_src",
>>> -};
>>> -
>>>   static struct clk_branch mi2s_osr_clk = {
>>>   	.halt_reg = 0x50,
>>>   	.halt_bit = 1,
>>> @@ -152,7 +150,9 @@ static struct clk_branch mi2s_osr_clk = {
>>>   		.enable_mask = BIT(17),
>>>   		.hw.init = &(struct clk_init_data){
>>>   			.name = "mi2s_osr_clk",
>>> -			.parent_names = lcc_mi2s_parents,
>>> +			.parent_hws = (const struct clk_hw*[]){
>>> +				&mi2s_osr_src.clkr.hw,
>>> +			},
>>>   			.num_parents = 1,
>>>   			.ops = &clk_branch_ops,
>>>   			.flags = CLK_SET_RATE_PARENT,
>>> @@ -167,7 +167,9 @@ static struct clk_regmap_div mi2s_div_clk = {
>>>   	.clkr = {
>>>   		.hw.init = &(struct clk_init_data){
>>>   			.name = "mi2s_div_clk",
>>> -			.parent_names = lcc_mi2s_parents,
>>> +			.parent_hws = (const struct clk_hw*[]){
>>
>> It would be wonderful if you could keep a space between ) and { in
>> these.
>>
> 
> You mean only here or in the entire patch? I assume the latter.
> 
>>> +				&mi2s_osr_src.clkr.hw,
>>> +			},
>>>   			.num_parents = 1,
>>>   			.ops = &clk_regmap_div_ops,
>>>   		},
>>> @@ -183,7 +185,9 @@ static struct clk_branch mi2s_bit_div_clk = {
>>>   		.enable_mask = BIT(15),
>>>   		.hw.init = &(struct clk_init_data){
>>>   			.name = "mi2s_bit_div_clk",
>>> -			.parent_names = (const char *[]){ "mi2s_div_clk" },
>>> +			.parent_hws = (const struct clk_hw*[]){
>>> +				&mi2s_div_clk.clkr.hw,
>>> +			},
>>>   			.num_parents = 1,
>>>   			.ops = &clk_branch_ops,
>>>   			.flags = CLK_SET_RATE_PARENT,
>>> @@ -191,6 +195,10 @@ static struct clk_branch mi2s_bit_div_clk = {
>>>   	},
>>>   };
>>>   
>>> +static const struct clk_parent_data lcc_mi2s_bit_div_codec_clk[] = {
>>> +	{ .hw = &mi2s_bit_div_clk.clkr.hw, },
>>> +	{ .fw_name = "mi2s_codec_clk", .name = "mi2s_codec_clk" },
>>
>> Is mi2s_codec_clk and external clock? I don't see it documented in the
>> DT binding. And if we're introducing new clock-names, perhaps we could
>> skip the _clk suffix - because obviously it's a clock :)
>>
>> Regards,
>> Bjorn
>>
> 
> I also didn't find where is mi2s_codec_clk... but yes I will change the
> fw_name with the clock with _clk stripped.

Downstream seems not to use _codec_clk, it just always uses the 
bit_div_clk as the codec's bit_clk. Maybe Srini knows additional 
details, as APQ8064 has more or less the same structure of clocks.

> 
> Will send v6 with the other question clarified.
> 


-- 
With best wishes
Dmitry
