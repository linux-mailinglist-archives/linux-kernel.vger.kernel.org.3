Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3673C5AC486
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 15:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbiIDNjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 09:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiIDNjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 09:39:01 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0A533360;
        Sun,  4 Sep 2022 06:38:59 -0700 (PDT)
Received: from [192.168.1.138] ([37.4.248.23]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N1x6X-1pWnNZ3lcH-012Gv1; Sun, 04 Sep 2022 15:38:41 +0200
Message-ID: <5afffbfc-19d8-3e55-f89f-70dfa9cd8a52@i2se.com>
Date:   Sun, 4 Sep 2022 15:38:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4] clk: bcm2835: Round UART input clock up
Content-Language: en-US
To:     "Ivan T. Ivanov" <iivanov@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Maxime Ripard <maxime@cerno.tech>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc:     Phil Elwell <phil@raspberrypi.com>,
        kernel test robot <lkp@intel.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220829132943.144608-1-iivanov@suse.de>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20220829132943.144608-1-iivanov@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:OvNBCDqBHOPvZXipEMCMhrozSj4KEMvWn/OTOaxH6D8vjoq30RM
 3rCVyQ8E6cKGCfhkoWtIY5N2CjQyErcQ/PBh7+EyKQaQjEmjw3TkvelGnX/JqrRLnwlNshk
 Sd0atQc4M9RNshccsfDbY/ZFkxufpaWBrQv68y/NrHnzkMl0dsejDsKZPg9OtJtXio+MRGJ
 cWE3jek6jZQ7UEtriRsAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dzKqiF6nwdY=:ZRi8sp5gJ3GLRYauFdtgYa
 WwapqoAdgbJynVQYJuOCGSrnWmMn4UBQ6/39p3WBwVMt5FpA2bfqF1+PCQIH77z2c+r7ufGBG
 ze+Kw3CLda1rJnq9Otu6wbQDn0ZvOpMCMVGSA6vHnIV2X9FI9AL9NOIP/qYR+9G6fTK6UObJo
 hlKr8pwnKNrrXxj3OHBvbquwrHf+Nje/fkzOIs6ia6Cupk3U6qEnL+YpwR13QrAhxCsa7XCSX
 XkBjBV8SSPM0VuQZC45b8dIQX1Q6cOJxiBqPtlzTS7FiFqGXAgKIQn/ojmeZAzQCIi/GLjOqd
 jw89A6bG0mjifz7vm1gfX/ed78q861xp4z797V54QKIdEHz0CY7VpBIQF6guc6aur6NOhnayu
 zzvqKT/aZL2MeW/KV3D8+9M5CdNoLme7fVkDnulsU2IOA6+QIG5XNgwDU2h32LUMD7WtZVACN
 L1UGkpmN/4QriMgGicA10J/V8XgcFw8ug23yoi5tfDakd2G/wXAFHpC3UzuJ0aQQtw14V/ywB
 uD6fXMB1jUN+C0pUwjyXAWebs6njcsRPfQYoYWp5/XMqYncRYvrH+Z8mlaV1vNbKUZHRJ3vYn
 T/0awRrU2SG8APpQz5whoTTu0lXnhr03U+dA6EzULaiZuYCKM024qx1eX0EZXSO4IRu0z8yA0
 CbH3Yo9ArV5nV3gng/vqz9npMKwPkGX2mV2wGFpOTyCx9buhKHDy8JTHgCmjXj9wz6FsfmNYx
 K4Oge7JhysWkPKhAIhVoU/jD9SDwaucz2XZfBVy86cxibThmoW+EnkNKEzEgCKHgkimfuiUxN
 hUw+1+Myjv4jiD+MHcQ4nNw/Y3isA==
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ivan,

Am 29.08.22 um 15:29 schrieb Ivan T. Ivanov:
> It was reported that RPi3[1] and RPi Zero 2W boards have issues with
> the Bluetooth. It turns out that when switching from initial to
> operation speed host and device no longer can talk each other because
> host uses incorrect UART baud rate.
> 
> The UART driver used in this case is amba-pl011. Original fix, see
> below Github link[2], was inside pl011 module, but somehow it didn't
> look as the right place to fix. Beside that this original rounding
> function is not exactly perfect for all possible clock values. So I
> deiced to move the hack to the platform which actually need it.
> 
> The UART clock is initialised to be as close to the requested
> frequency as possible without exceeding it. Now that there is a
> clock manager that returns the actual frequencies, an expected
> 48MHz clock is reported as 47999625. If the requested baud rate
> == requested clock/16, there is no headroom and the slight
> reduction in actual clock rate results in failure.
> 
> If increasing a clock by less than 0.1% changes it from ..999..
> to ..000.., round it up.
> 
> [1] https://bugzilla.suse.com/show_bug.cgi?id=1188238
> [2] https://github.com/raspberrypi/linux/commit/ab3f1b39537f6d3825b8873006fbe2fc5ff057b7
> 
> Cc: Phil Elwell <phil@raspberrypi.com>
> Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
> ---
> 
> Changes since v3
> * Rework 'scaler' calculation to avoid overflow
> * Update Phil Elwell email address
> 
> Changes since v2
> * Added more information in commit message
> * Changed hand crafted round function with the one form math.h
> 
> Changes since v1
> Make bcm2835_clock_round() static to fix following warning
> when compiling for riscv:
> drivers/clk/bcm/clk-bcm2835.c:997:15: warning: no previous prototype for 'bcm2835_clock_round' [-Wmissing-prototypes]
> Reported-by: kernel test robot <lkp@intel.com>
> 
>   drivers/clk/bcm/clk-bcm2835.c | 35 +++++++++++++++++++++++++++++++++--
>   1 file changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
> index 48a1eb9f2d55..26a5c9a0dd34 100644
> --- a/drivers/clk/bcm/clk-bcm2835.c
> +++ b/drivers/clk/bcm/clk-bcm2835.c
> @@ -30,6 +30,7 @@
>   #include <linux/debugfs.h>
>   #include <linux/delay.h>
>   #include <linux/io.h>
> +#include <linux/math.h>
>   #include <linux/module.h>
>   #include <linux/of_device.h>
>   #include <linux/platform_device.h>
> @@ -502,6 +503,8 @@ struct bcm2835_clock_data {
>   	bool low_jitter;
>   
>   	u32 tcnt_mux;
> +
> +	bool round_up;
>   };
>   
>   struct bcm2835_gate_data {
> @@ -993,12 +996,34 @@ static long bcm2835_clock_rate_from_divisor(struct bcm2835_clock *clock,
>   	return temp;
>   }
>   
> +static unsigned long bcm2835_clock_round(unsigned long clk)
> +{
> +	unsigned long scaler;
> +	unsigned long limit;;

please remove the additional ';'

Except if this:

Reviewed-by: Stefan Wahren <stefan.wahren@i2se.com>

> +
> +	limit = clk / 100000;
> +
> +	scaler = 1;
> +	while (scaler < limit)
> +		scaler *= 10;
> +
> +	/*
> +	 * If increasing a clock by less than 0.1% changes it
> +	 * from ..999.. to ..000.., round up.
> +	 */
> +	if ((clk + scaler - 1) / scaler % 1000 == 0)
> +		clk = roundup(clk, scaler);
> +
> +	return clk;
> +}
> +
>   static unsigned long bcm2835_clock_get_rate(struct clk_hw *hw,
>   					    unsigned long parent_rate)
>   {
>   	struct bcm2835_clock *clock = bcm2835_clock_from_hw(hw);
>   	struct bcm2835_cprman *cprman = clock->cprman;
>   	const struct bcm2835_clock_data *data = clock->data;
> +	unsigned long rate;
>   	u32 div;
>   
>   	if (data->int_bits == 0 && data->frac_bits == 0)
> @@ -1006,7 +1031,12 @@ static unsigned long bcm2835_clock_get_rate(struct clk_hw *hw,
>   
>   	div = cprman_read(cprman, data->div_reg);
>   
> -	return bcm2835_clock_rate_from_divisor(clock, parent_rate, div);
> +	rate = bcm2835_clock_rate_from_divisor(clock, parent_rate, div);
> +
> +	if (data->round_up)
> +		rate = bcm2835_clock_round(rate);
> +
> +	return rate;
>   }
>   
>   static void bcm2835_clock_wait_busy(struct bcm2835_clock *clock)
> @@ -2143,7 +2173,8 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
>   		.div_reg = CM_UARTDIV,
>   		.int_bits = 10,
>   		.frac_bits = 12,
> -		.tcnt_mux = 28),
> +		.tcnt_mux = 28,
> +		.round_up = true),
>   
>   	/* TV encoder clock.  Only operating frequency is 108Mhz.  */
>   	[BCM2835_CLOCK_VEC]	= REGISTER_PER_CLK(
