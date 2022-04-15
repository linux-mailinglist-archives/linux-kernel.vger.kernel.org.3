Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B1F502732
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 11:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351671AbiDOJI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 05:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351653AbiDOJIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 05:08:25 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7D75621C;
        Fri, 15 Apr 2022 02:05:57 -0700 (PDT)
Received: from [192.168.1.107] ([37.4.249.94]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MOiLp-1nIWZ60VzT-00QDKM; Fri, 15 Apr 2022 10:52:15 +0200
Message-ID: <0b3356c0-b4c8-91ed-dfde-9f50483ec36f@i2se.com>
Date:   Fri, 15 Apr 2022 10:52:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] clk: bcm2835: Round UART input clock up
Content-Language: en-US
To:     "Ivan T. Ivanov" <iivanov@suse.de>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Phil Elwell <phil@raspberrypi.org>,
        kernel test robot <lkp@intel.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-clk@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220404125113.80239-1-iivanov@suse.de>
 <20220414105656.qt52zmr5vjmjdcxc@suse>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20220414105656.qt52zmr5vjmjdcxc@suse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:UebfG6WqPbhJizg1NMN/mpyZgcPumdWSuBM/6BTDt9v+yXZkEr3
 GndZzAbWe8BDp4QzSQwPPJ3+SmJBMG7kBuYPQAABkxMraT4NPgtVj9kuGjxBYk0TT/Tgi94
 WPgYpXiQ3heRKbRvZgHden647nwMC9ZT5R5edTEYWd4N7yOmifX7WQB8FoypikFloWZ3Ujn
 glSzQtjAu9YfvjjiOochg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:n/2MNXndvdU=:C198cGvvvAFxz0D9X3pb5S
 dr8u/IrT64Ld1N/QV/DdN1yMOfkNTo2PInyA6B3ihzVPW4vbObL5Mf9ORF6lRxw40bOXafILV
 Ddg5RCtOg/dPB/lf4tXKvGc/YHF0RKfCPPdRZkb2ruKWM6d+kuIEvOkgKsDxr0mfdfSAFC5Dp
 Xzi7ryEWdO0Y9IxFVW1nv43UHuhQUAmGJgvCYz3yHyEB/7jGzo8HZStcjuF8Pd1T4H9HsGktO
 ZfwapfwXNMkgo/zOPY0YCnqE40kDVi9eaqGbyhz8ZTaTyeplYKmKNUo66d42tdRaf+XdZjSJ8
 g9h37vs+WYeRoikeXHgbCHNBBd7tZBgBi5+05hRmUvOitnQzMkA2sZVDSKiuOsprVRthkbBWG
 BJ7Q40yZ7B+uPJ/3nCMaAyDG3flsPiqJc1HuwlrQOlipup6q/7B6fy9kIh4LlS5K1mulP4Ks8
 BjVC5wdCmciXgWjyzX6t3vLpm/Nr5I3PNlxethOkQgv2yvd9Tyz0wt924gii9mr87io9rtPkd
 paML7Df1cX17MnuIkDfms5ksJq7pZvP6jon7Har/5ENz3uBsoaqYujH0DLEi9ZWsrM60PLY0s
 fMeEKWu5mX4LPpYAkE3D4mgauCNH66MdqBkBT+usyVQmOiyvCCMRyTPujFvfPWGFO8UJpmpEJ
 WEoR/iIV8bEgXALyNT/dk9UvfXQ5e+8iNO1pBU0osrp1XBxE7DHrE1F/tnHco3g8YI8WvXGch
 JwrVNsJO4/zfMNRF
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_MSPIKE_ZBI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ivan,

Am 14.04.22 um 12:56 schrieb Ivan T. Ivanov:
> Hi Stefan,
>
> Please, could you take a look into following patch?
yes, but i cannot give a technical review. But from my gut feeling this 
doesn't look really elegant to me.
>
> Thanks!
> Ivan
>
> On 04-04 15:51, Ivan T. Ivanov wrote:
>> Subject: [PATCH v2] clk: bcm2835: Round UART input clock up
>> Message-Id: <20220404125113.80239-1-iivanov@suse.de>
>>
>> The UART clock is initialised to be as close to the requested
>> frequency as possible without exceeding it. Now that there is a
>> clock manager that returns the actual frequencies, an expected
>> 48MHz clock is reported as 47999625. If the requested baudrate
>> == requested clock/16, there is no headroom and the slight
>> reduction in actual clock rate results in failure.
>>
>> If increasing a clock by less than 0.1% changes it from ..999..
>> to ..000.., round it up.

Based on this commit message this looks like a fix / workaround for an 
issue. It would be very helpful to know:

What issue should be fixed?

Why is it fixed here and not in the UART driver for instance?

In case it fixes a regression, a Fixes tag should be necessary.

In best case this is explained in the commit message.

Best regards

>>
>> This is reworked version of a downstream fix:
>> https://github.com/raspberrypi/linux/commit/ab3f1b39537f6d3825b8873006fbe2fc5ff057b7
>>
>> Cc: Phil Elwell <phil@raspberrypi.org>
>> Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
>> ---
>> Changes since v1
>> Make bcm2835_clock_round() static to fix following warning
>> when compiling for riscv:
>> drivers/clk/bcm/clk-bcm2835.c:997:15: warning: no previous prototype for 'bcm2835_clock_round' [-Wmissing-prototypes]
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>>   drivers/clk/bcm/clk-bcm2835.c | 30 ++++++++++++++++++++++++++++--
>>   1 file changed, 28 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
>> index 3ad20e75fd23..c29b643d1bf5 100644
>> --- a/drivers/clk/bcm/clk-bcm2835.c
>> +++ b/drivers/clk/bcm/clk-bcm2835.c
>> @@ -502,6 +502,8 @@ struct bcm2835_clock_data {
>>   	bool low_jitter;
>>   
>>   	u32 tcnt_mux;
>> +
>> +	bool round_up;
>>   };
>>   
>>   struct bcm2835_gate_data {
>> @@ -992,12 +994,30 @@ static long bcm2835_clock_rate_from_divisor(struct bcm2835_clock *clock,
>>   	return temp;
>>   }
>>   
>> +static unsigned long bcm2835_clock_round(unsigned long clk)
>> +{
>> +	unsigned long scaler;
>> +
>> +	/*
>> +	 * If increasing a clock by less than 0.1% changes it
>> +	 * from ..999.. to ..000.., round up.
>> +	 */
>> +	scaler = 1;
>> +	while (scaler * 100000 < clk)
>> +		scaler *= 10;
>> +	if ((clk + scaler - 1) / scaler % 1000 == 0)
>> +		clk = (clk / scaler + 1) * scaler;
>> +
>> +	return clk;
>> +}
>> +
>>   static unsigned long bcm2835_clock_get_rate(struct clk_hw *hw,
>>   					    unsigned long parent_rate)
>>   {
>>   	struct bcm2835_clock *clock = bcm2835_clock_from_hw(hw);
>>   	struct bcm2835_cprman *cprman = clock->cprman;
>>   	const struct bcm2835_clock_data *data = clock->data;
>> +	unsigned long rate;
>>   	u32 div;
>>   
>>   	if (data->int_bits == 0 && data->frac_bits == 0)
>> @@ -1005,7 +1025,12 @@ static unsigned long bcm2835_clock_get_rate(struct clk_hw *hw,
>>   
>>   	div = cprman_read(cprman, data->div_reg);
>>   
>> -	return bcm2835_clock_rate_from_divisor(clock, parent_rate, div);
>> +	rate = bcm2835_clock_rate_from_divisor(clock, parent_rate, div);
>> +
>> +	if (data->round_up)
>> +		rate = bcm2835_clock_round(rate);
>> +
>> +	return rate;
>>   }
>>   
>>   static void bcm2835_clock_wait_busy(struct bcm2835_clock *clock)
>> @@ -2142,7 +2167,8 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
>>   		.div_reg = CM_UARTDIV,
>>   		.int_bits = 10,
>>   		.frac_bits = 12,
>> -		.tcnt_mux = 28),
>> +		.tcnt_mux = 28,
>> +		.round_up = true),
>>   
>>   	/* TV encoder clock.  Only operating frequency is 108Mhz.  */
>>   	[BCM2835_CLOCK_VEC]	= REGISTER_PER_CLK(
>> -- 
>> 2.26.2
