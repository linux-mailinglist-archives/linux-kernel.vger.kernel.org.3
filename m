Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFED250D61B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 02:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239983AbiDYAI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 20:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239975AbiDYAIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 20:08:24 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7202630;
        Sun, 24 Apr 2022 17:05:05 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 5C5625C0106;
        Sun, 24 Apr 2022 20:05:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 24 Apr 2022 20:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1650845104; x=
        1650931504; bh=hrQ+5ooneUvzjewgwp5sKBI4+dt7nM1LNckL2JHcpz0=; b=t
        zGUYKl6BZNt9vedo2LFR4PFEtH4lznHKYYLM+kdDaIJT5iF/6Qsc541LERgYaTVX
        gqIV5cxP0IQAy0Ao81YDa40zQ5Dkzs0QTIm0prALrXr4lV47O3lDo2GcthSkDSTc
        Ovf/16G89dIPclhcTa7wWEueeEYbI5EsqUYKnPT/Q2D5dnQFT/HlKDOURZ2it4Fk
        82pegeLw6iz9Y+TtzbH9P5HLa8A0vSvnlvkWJp9qyCJoD1adV8uzao6wbxxfEiKh
        OxDoIyAUQSCfaiByGyjNcsXp0AKID4mDIpJo+sAc8McETCkHlnUXucMkw0Vjw6lY
        9ipISOxkzdmF7D6XEQxlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1650845104; x=1650931504; bh=hrQ+5ooneUvzj
        ewgwp5sKBI4+dt7nM1LNckL2JHcpz0=; b=VcXvoCSuCl6gOhu81suq3ZBDLgbVq
        uqqBReq/Kh+/M+9Mj3Yz7NP9YXUcTuGdE302zqKVVDMlw3Fpw23jtipop7Rm9UiH
        yHa2M9RYN2bl848SKKg7EgCbk7AxOmaSmtNMzJz8d8U5r01RyondGF4wBBhX98DV
        nIIReJIDhSsO4TsQz83UtNxKPqjLtrHnIwy0ehTNPsZgwrC8nKAK2oGgFP5U+DMI
        8XGeoNftCI0b0UD2FO5L9VMVMUnaIzn6HKUuEJdFyz5qtspgmZFXR+HTDnwtuOEx
        qW9baQbMpaAp49FZi23yeGb+4SLILuzo71PO89Wkv8gI63p2R9R7LSIGA==
X-ME-Sender: <xms:r-VlYpSXUZxo21bFgQWa5LveUpRW9phC-dtbvG9wUC5YEwiO7gTlbg>
    <xme:r-VlYiyeUjl_o0PLtT5aIaF7cBMeCIi6RBQENINI3tNt2YbLh0Xws9_qIQyrqCoJ-
    2qirZ72RfYMkwlhpA>
X-ME-Received: <xmr:r-VlYu04OZILUpo37pdmMiGn1IOHmF7o0O99sjQLOQoEkl9HXqslQcp2IydEZvlBhbOsFlF7fNa43X4m_jE-qz2KYaqCoRnmQN4o_3ifhsoCCTNNCN_hO55WfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddtgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfevfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepffdtveekvdegkeeuueetgfetffeileevudekuefhheelvdfhiedt
    heduhfduhefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:r-VlYhCX4fAKvZCbe5AgWgeASNS3zQHwBKd8ibCVJXREcFRRrB1KiA>
    <xmx:r-VlYih2yZxKTF-S7iw3csQxtG7J1C_PdY384EgnSAvkPpluchvJbg>
    <xmx:r-VlYlrbtd91p7p17A_2miCySwQpJHqHIguqpN1po7F-Pl8sgdj7eQ>
    <xmx:sOVlYpp4QZxaszvpGEa9a5ncRlRHqgFA5HVHcF6i8_FKD6QNuxAYGg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Apr 2022 20:05:02 -0400 (EDT)
Subject: Re: [PATCH v10 01/18] clk: sunxi-ng: h616-r: Add RTC gate clock
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Ondrej Jirman <megous@megous.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
References: <20220211122643.1343315-1-andre.przywara@arm.com>
 <20220211122643.1343315-2-andre.przywara@arm.com>
 <01e8d2a0-cdeb-ab64-42a7-48376b49c00e@sholland.org>
 <20220425003557.696c9de8@slackpad.lan>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <67675179-d25a-9154-b307-7168f87095db@sholland.org>
Date:   Sun, 24 Apr 2022 19:05:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220425003557.696c9de8@slackpad.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,

On 4/24/22 6:36 PM, Andre Przywara wrote:
> On Tue, 22 Feb 2022 21:22:07 -0600
> Samuel Holland <samuel@sholland.org> wrote:
> 
> Hi Samuel,
> 
>> On 2/11/22 6:26 AM, Andre Przywara wrote:
>>> The H616 features an (undocumented) bus clock gate for accessing the RTC
>>> registers. This seems to be enabled at reset (or by the BootROM), but is
>>> there anyway.
>>> Since the new RTC clock binding for the H616 requires this "bus" clock
>>> to be specified in the DT, add this to R_CCU clock driver and expose it
>>> on the DT side with a new number.  
>>
>> It would be good to note why you didn't add this clock to H6, even though it
>> exists in that hardware.
> 
> What explanation do you prefer here? The main reason I expose this is
> because of the H616 binding, so this is not required for the H6.
> Plus is would break compatibility with older kernels, which is not so
> much an issue for the H616.
> Do you want to expose the clock on the H6 side as well, and mark it
> as CLK_IS_CRITICAL there? I guess otherwise it would get turned off.
> Or were you just after some kind of rationale as above, for the
> commit log records?

Today I found out that this commit breaks booting on H6 because the clock is not
added there. clk_hw_onecell_data::hws is a flexible array member, so
incrementing CLK_NUMBER doesn't actually make the array larger. That means .num
gets interpreted as .hws[CLK_R_APB1_RTC], and that ends with a NULL dereference.

The easiest solution seems to be adding the clock on H6 as well. I think
CLK_IGNORE_UNUSED is sufficient, but CLK_IS_CRITICAL would work as well.

The rationale I'm looking for is something along the lines of "the H6 binding
prevents us from referencing this clock from the devicetree, and the way the
driver is written prevents us from changing the binding."

>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>>> ---
>>>  drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c      | 4 ++++
>>>  drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h      | 2 +-
>>>  include/dt-bindings/clock/sun50i-h6-r-ccu.h | 1 +
>>>  3 files changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
>>> index 712e103382d8..26fb092f6df6 100644
>>> --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
>>> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
>>> @@ -98,6 +98,8 @@ static SUNXI_CCU_GATE(r_apb1_ir_clk,	"r-apb1-ir",	"r-apb1",
>>>  		      0x1cc, BIT(0), 0);
>>>  static SUNXI_CCU_GATE(r_apb1_w1_clk,	"r-apb1-w1",	"r-apb1",
>>>  		      0x1ec, BIT(0), 0);
>>> +static SUNXI_CCU_GATE(r_apb1_rtc_clk,	"r-apb1-rtc",	"r-apb1",
>>> +		      0x20c, BIT(0), 0);  
>>
>> All of the documentation I have found (manuals, A100 driver, BSP D1 driver)
>> points to this clock coming off of R_AHB, not R_APB1.
> 
> Really, can you provide some pointer? In the H616 manual I see
> AHBS->AHB2APB->APBS1BUS->RTC, next to the other R_ peripherals. Also
> typically *register access* is done via APB busses, not AHB.
> Is any of those documentation sources actually reliable? And
> regardless, the AHB vs. APB parenthood is mostly academic, isn't it?

You are right. I'm looking at the "RTC Application Diagram". For both H6 and
H616, the diagram and the caption have register access via APB1. A100/R329/D1
have register access via AHBS (and this matches the CCU bus tree diagram). So it
looks like this was changed for A100.

Regards,
Samuel

>>>  
>>>  /* Information of IR(RX) mod clock is gathered from BSP source code */
>>>  static const char * const r_mod0_default_parents[] = { "osc32k", "osc24M" };
>>> @@ -147,6 +149,7 @@ static struct ccu_common *sun50i_h616_r_ccu_clks[] = {
>>>  	&r_apb2_i2c_clk.common,
>>>  	&r_apb2_rsb_clk.common,
>>>  	&r_apb1_ir_clk.common,
>>> +	&r_apb1_rtc_clk.common,
>>>  	&ir_clk.common,
>>>  };
>>>  
>>> @@ -179,6 +182,7 @@ static struct clk_hw_onecell_data sun50i_h616_r_hw_clks = {
>>>  		[CLK_R_APB2_I2C]	= &r_apb2_i2c_clk.common.hw,
>>>  		[CLK_R_APB2_RSB]	= &r_apb2_rsb_clk.common.hw,
>>>  		[CLK_R_APB1_IR]		= &r_apb1_ir_clk.common.hw,
>>> +		[CLK_R_APB1_RTC]	= &r_apb1_rtc_clk.common.hw,
>>>  		[CLK_IR]		= &ir_clk.common.hw,
>>>  	},
>>>  	.num	= CLK_NUMBER,
>>> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h
>>> index 7e290b840803..10e9b66afc6a 100644
>>> --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h
>>> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h
>>> @@ -14,6 +14,6 @@
>>>  
>>>  #define CLK_R_APB2	3
>>>  
>>> -#define CLK_NUMBER	(CLK_R_APB2_RSB + 1)
>>> +#define CLK_NUMBER	(CLK_R_APB1_RTC + 1)
>>>  
>>>  #endif /* _CCU_SUN50I_H6_R_H */
>>> diff --git a/include/dt-bindings/clock/sun50i-h6-r-ccu.h b/include/dt-bindings/clock/sun50i-h6-r-ccu.h
>>> index 890368d252c4..a96087abc86f 100644
>>> --- a/include/dt-bindings/clock/sun50i-h6-r-ccu.h
>>> +++ b/include/dt-bindings/clock/sun50i-h6-r-ccu.h
>>> @@ -22,5 +22,6 @@
>>>  #define CLK_W1			12
>>>  
>>>  #define CLK_R_APB2_RSB		13
>>> +#define CLK_R_APB1_RTC		14
>>>  
>>>  #endif /* _DT_BINDINGS_CLK_SUN50I_H6_R_CCU_H_ */
>>>   
>>
>>
> 

