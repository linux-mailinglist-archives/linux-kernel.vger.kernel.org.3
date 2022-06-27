Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A84C55CCE5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240754AbiF0Tvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 15:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238433AbiF0Tvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 15:51:48 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553AD1BE83;
        Mon, 27 Jun 2022 12:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656359507; x=1687895507;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4M4vuBj1FZO2Dx0Ze9OY5eJ59QeeaTSDFNt2IHMzOMc=;
  b=OPy90ekIor3wW+btFI2RZXr9UvFxKyoTW1G+/DQ2gRv6l58QDsOPKQSI
   iz/knB6QEfmpKBywIGwND/2l+bJv5/Uxk6BKsghs7dBr/OYJhDwKTRN9c
   6nq9FEG2BaBQ8LNOVK6ml/zsmtNZ48clVIebPtmUzRDHtPJahROxz4dIU
   o=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 27 Jun 2022 12:51:47 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 12:51:46 -0700
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 27 Jun 2022 12:51:45 -0700
Received: from [10.216.11.205] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 27 Jun
 2022 12:51:39 -0700
Message-ID: <f358606f-0dd5-7dfa-ec6b-b6ade9d5a1a0@quicinc.com>
Date:   Tue, 28 Jun 2022 01:21:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V2 3/8] clk: qcom: Add Global Clock controller (GCC)
 driver for IPQ5018
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <agross@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linus.walleij@linaro.org>,
        <catalin.marinas@arm.com>, <p.zabel@pengutronix.de>,
        <quic_varada@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20220621161126.15883-1-quic_srichara@quicinc.com>
 <20220621161126.15883-4-quic_srichara@quicinc.com>
 <YrU4D+eDBctFl0ZY@builder.lan>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <YrU4D+eDBctFl0ZY@builder.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/24/2022 9:35 AM, Bjorn Andersson wrote:
> On Tue 21 Jun 11:11 CDT 2022, Sricharan R wrote:
>> diff --git a/drivers/clk/qcom/gcc-ipq5018.c b/drivers/clk/qcom/gcc-ipq5018.c
> [..]
>> +static const struct clk_parent_data gcc_xo_gpll0_gpll0_out_main_div2[] = {
>> +	{ .fw_name = "xo", .name = "xo", },
> Please replace .fw_name with .index based lookup, in line with what was
> done in gcc-sc8280xp.c recently.


  Sure, understand will fix it.

>
> There's no reason to include global name lookup (.name) in new drivers,
> so please omit this part.

   ok.


>> +	{ .fw_name = "gpll0", .name = "gpll0", },
>> +	{ .fw_name = "gpll0_out_main_div2", .name = "gpll0_out_main_div2", },
>> +};
>> +
> [..]
>> +static struct clk_alpha_pll gpll0_main = {
>> +	.offset = 0x21000,
>> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
>> +	.clkr = {
>> +		.enable_reg = 0x0b000,
>> +		.enable_mask = BIT(0),
>> +		.hw.init = &(struct clk_init_data){
>> +			.name = "gpll0_main",
>> +			.parent_data = &(const struct clk_parent_data){
>> +				.fw_name = "xo",
>> +				.name = "xo",
> Are you referring to the board XO here, or the CXO pin on the SoC? On
> many platforms these are not the same...
   board XO, will refer your above example and fix it here as well
> Please omit the .name here as well and as this is used a few times,
> please create a struct clk_parent_data for this parent.

   ok.


>> +			},
>> +			.num_parents = 1,
>> +			.ops = &clk_alpha_pll_stromer_ops,
>> +			.flags = CLK_IS_CRITICAL,
>> +		},
>> +	},
>> +};
>> +
>> +static struct clk_fixed_factor gpll0_out_main_div2 = {
>> +	.mult = 1,
>> +	.div = 2,
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "gpll0_out_main_div2",
>> +		.parent_data = &(const struct clk_parent_data){
> It would be nice to have a space inbetween ) and { in all these.

   ok.


>> +			.fw_name = "gpll0_main",
>> +			.name = "gpll0_main",
>> +		},
>> +		.num_parents = 1,
>> +		.ops = &clk_fixed_factor_ops,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
> [..]
>> +static struct clk_branch gcc_gephy_tx_clk = {
>> +	.halt_reg = 0x56014,
>> +	.halt_check = BRANCH_HALT_DELAY,
>> +	.clkr = {
>> +		.enable_reg = 0x56014,
>> +		.enable_mask = BIT(0),
>> +		.hw.init = &(struct clk_init_data){
>> +			.name = "gcc_gephy_tx_clk",
>> +			.parent_data = &(const struct clk_parent_data){
>> +				.fw_name = "gmac0_tx_div_clk_src",
>> +				.name = "gmac0_tx_div_clk_src",
>> +			},
> This parent_data is repeated multiple times, but more importantly it's
> not an external clock, so you should use .parent_hw instead of
> .parent_data.
>
> Please review the parent for all your clocks.

   ok, will do.

Regards,
   Sricharan

