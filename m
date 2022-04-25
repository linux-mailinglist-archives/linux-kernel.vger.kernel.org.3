Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E81B50E20F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242029AbiDYNoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236348AbiDYNn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:43:57 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60574926F;
        Mon, 25 Apr 2022 06:40:52 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 2ADF25C0193;
        Mon, 25 Apr 2022 09:40:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 25 Apr 2022 09:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1650894049; x=
        1650980449; bh=2nn2zqCEpHBXhjVLysWsPIDVph3o6ucuHdfZc6bQZOA=; b=U
        5uXUoEihluXC0I2wYVBW2QH/01k5ZcB58KsO9Ta2TQfOqh8qDJfZvCAvKUq4Xdbr
        mhRQENUXqsT2biDI46VQ5Iz0OTBq63xoFUa70FsnKl/Fk4gI8qhwhOFy5fcgufLv
        IbKo19jpF2BzTqKnSdU6idK2SMEyFL9STfyZZHY3/gTzOe+yReoYMXRF1jYiH/RG
        qDWMTBMf5wT6HiKqIY1d0nES84oIvFN0B3/31InKYZB2d8kF3oJQf2oePriFPFVY
        +h9nT3y+xZNrW1Gi3rFjnWiSgTpS74mPm9x6p0Ti001x09Onv3497PJV/erWwGz8
        Tn7S44gdN1NAJvQs5sVQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1650894049; x=1650980449; bh=2nn2zqCEpHBXh
        jVLysWsPIDVph3o6ucuHdfZc6bQZOA=; b=l6rrplDG3ZzlR3ohQ0f5YvlRX30fU
        xa47F4+1TDWKudtTnP/kevd+q9UuMBwZ3R27x/GvmGFYUqBmcijXf/gWDX4v4P5g
        OGr5VcQevoTv0L8XC4mS6wjSX9VX7QUJlEowgvQadLfKdKm1zT6jMRf9SFxrN/nO
        fR8wFh/PqDWDKt9wG5XoU+O08AQQyziqA+wCItFGbRyxwmf+TA8VNzNdYjnydREE
        KQxvymWb8nwctsEM1uVXviB2o3slsdAeqBQ2DP54AZZ6XTE7liCt5uEnKWhJB5VA
        6ix9gVe0DA6Fdj+xGDL+Eiwm9AGw65Q1tnoCooANi3E4O4GpWFNs6W0Mw==
X-ME-Sender: <xms:4KRmYrsBEyli04JEkheQcS8JKqGIaErI0zrWqdZzDV24bMiXA5zYfg>
    <xme:4KRmYsfa_5r2vnmp2EYaRrHRdndpxooh4TlO8_hbJn_BqToZY2E06sPfXUQlm7KzE
    hx6zlf5llzKKq5eVQ>
X-ME-Received: <xmr:4KRmYuxIUxafzbh7j1-Se95uFE7DCMaEbpwyDVImN96vU3qC20Rcupygc5eh6D-Jiq8w56wF0falLw_sJZhrlspZQOzfFAtRtQNDv7sljBOwFOxk9wZcWsKvig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddugdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfevfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepffdtveekvdegkeeuueetgfetffeileevudekuefhheelvdfhiedt
    heduhfduhefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:4KRmYqOAbXv_2O2IZzhdJAlf8Q4heBTdY9ZleQi4oVAn5DjvnIQxmA>
    <xmx:4KRmYr_7uRt3Oy0hEnrnFJftUAaJiqGaW9NSHdTu0_T8S-jbO9RIHg>
    <xmx:4KRmYqVmWB3JW7V8t6jwSls_cbGxGiDdzmlFVBK9AMhC0Tcv-FFqVA>
    <xmx:4aRmYs37IsFYIFCv3hOS6dQwLLJb2ig1qGo2OZvmS2KmOtPrC3OeTg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Apr 2022 09:40:47 -0400 (EDT)
Subject: Re: [PATCH] mmc: sunxi-mmc: Correct the maximum segment size
To:     Hans de Goede <hdegoede@redhat.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Chen-Yu Tsai <wens@csie.org>,
        Chris Ball <chris@printf.net>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Mike Turquette <mturquette@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
References: <20220424230640.31735-1-samuel@sholland.org>
 <dcc1b028-7e53-cb94-9a66-41890393f2ed@redhat.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <31a12028-8593-c558-0f21-044d69f97e6f@sholland.org>
Date:   Mon, 25 Apr 2022 08:40:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <dcc1b028-7e53-cb94-9a66-41890393f2ed@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/22 5:40 AM, Hans de Goede wrote:
> Hi Samuel,
> 
> On 4/25/22 01:06, Samuel Holland wrote:
>> According to the DMA descriptor documentation, the lowest two bits of
>> the size field are ignored, so the size must be rounded up to a multiple
>> of 4 bytes. Furthermore, 0 is not a valid buffer size; setting the size
>> to 0 will cause that DMA descriptor to be ignored.
>>
>> Together, these restrictions limit the maximum DMA segment size to 4
>> less than the power-of-two width of the size field.
> 
> I assume that you were seeing some problems where things where not working
> which caused you to investigate this; and that this patch fixes those
> problems?   If yes then it would be good to also mention the problems +
> investigative process in the commit message.

No, this is just based on reading the manual. I was investigating some problems
when I originally wrote this patch, but they turned out to be unrelated, and
reverting this patch doesn't cause any obvious regression.

> I'm no longer involved in sunxi development, but still I wonder if the
> subtraction of 4 from the max_seg_size is really necessary? This seems
> to be based on the notion that as you say "0 is not a valid buffer size"
> where as the code so far has been operating under the assumption that
> putting 0 in sunxi_idma_des.buf_size means maximum buf-size.
> 
> I'm pretty sure that 0 meaning maximum buf-size is correct for at least
> the older chips where idma_des_size_bits equals 13, which means that
> only 2 4K pages fit in a single desc, so we almost certainly have been
> hitting this code path ?
> 
> Although: drivers/mmc/host/dw_mmc.c which seems to be for similar
> hw suggests that on designs where idma_des_size_bits == 13 only
> 4k can be used, which sorta matches what you are doing here except
> that you limit things to 8k - 4 instead of to just 4k.
> 
> Anyways I was just wondering about all this...

It probably deserves someone testing this specific scenario, so we can either
verify the fix is needed, or add a comment explaining that the documentation is
wrong.

Regards,
Samuel

> Regards,
> 
> Hans
> 
> 
> 
>>
>> Fixes: 3cbcb16095f9 ("mmc: sunxi: Add driver for SD/MMC hosts found on Allwinner sunxi SoCs")
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>
>>  drivers/mmc/host/sunxi-mmc.c | 14 ++++++++------
>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
>> index c62afd212692..4bd5f37b1036 100644
>> --- a/drivers/mmc/host/sunxi-mmc.c
>> +++ b/drivers/mmc/host/sunxi-mmc.c
>> @@ -214,6 +214,9 @@
>>  #define SDXC_IDMAC_DES0_CES	BIT(30) /* card error summary */
>>  #define SDXC_IDMAC_DES0_OWN	BIT(31) /* 1-idma owns it, 0-host owns it */
>>  
>> +/* Buffer size must be a multiple of 4 bytes. */
>> +#define SDXC_IDMAC_SIZE_ALIGN	4
>> +
>>  #define SDXC_CLK_400K		0
>>  #define SDXC_CLK_25M		1
>>  #define SDXC_CLK_50M		2
>> @@ -361,17 +364,15 @@ static void sunxi_mmc_init_idma_des(struct sunxi_mmc_host *host,
>>  {
>>  	struct sunxi_idma_des *pdes = (struct sunxi_idma_des *)host->sg_cpu;
>>  	dma_addr_t next_desc = host->sg_dma;
>> -	int i, max_len = (1 << host->cfg->idma_des_size_bits);
>> +	int i;
>>  
>>  	for (i = 0; i < data->sg_len; i++) {
>>  		pdes[i].config = cpu_to_le32(SDXC_IDMAC_DES0_CH |
>>  					     SDXC_IDMAC_DES0_OWN |
>>  					     SDXC_IDMAC_DES0_DIC);
>>  
>> -		if (data->sg[i].length == max_len)
>> -			pdes[i].buf_size = 0; /* 0 == max_len */
>> -		else
>> -			pdes[i].buf_size = cpu_to_le32(data->sg[i].length);
>> +		pdes[i].buf_size = cpu_to_le32(ALIGN(data->sg[i].length,
>> +						     SDXC_IDMAC_SIZE_ALIGN));
>>  
>>  		next_desc += sizeof(struct sunxi_idma_des);
>>  		pdes[i].buf_addr_ptr1 =
>> @@ -1420,7 +1421,8 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
>>  	mmc->max_blk_count	= 8192;
>>  	mmc->max_blk_size	= 4096;
>>  	mmc->max_segs		= PAGE_SIZE / sizeof(struct sunxi_idma_des);
>> -	mmc->max_seg_size	= (1 << host->cfg->idma_des_size_bits);
>> +	mmc->max_seg_size	= (1 << host->cfg->idma_des_size_bits) -
>> +				  SDXC_IDMAC_SIZE_ALIGN;
>>  	mmc->max_req_size	= mmc->max_seg_size * mmc->max_segs;
>>  	/* 400kHz ~ 52MHz */
>>  	mmc->f_min		=   400000;
> 

