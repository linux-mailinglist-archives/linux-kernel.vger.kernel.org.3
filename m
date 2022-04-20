Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A331508B87
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379982AbiDTPHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241054AbiDTPH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:07:26 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A469A44A21;
        Wed, 20 Apr 2022 08:04:36 -0700 (PDT)
Received: from [185.156.123.69] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nhBsd-0006QZ-7U; Wed, 20 Apr 2022 17:04:31 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-gpio@vger.kernel.org,
        Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] pinctrl: rockchip: fix RK3308 pinmux bits
Date:   Wed, 20 Apr 2022 17:04:23 +0200
Message-ID: <5942762.lOV4Wx5bFT@phil>
In-Reply-To: <20220420142432.248565-1-luca.ceresoli@bootlin.com>
References: <20220420142432.248565-1-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 20. April 2022, 16:24:31 CEST schrieb Luca Ceresoli:
> Some of the pinmuxing bits described in rk3308_mux_recalced_data are wrong,
> pointing to non-existing registers.
> 
> Fix the entire table.
> 
> Also add a comment in front of each entry with the same string that appears
> in the datasheet to make the table easier to compare with the docs.
> 
> This fix has been tested on real hardware for the gpio3b3_sel entry.
> 
> Fixes: 7825aeb7b208 ("pinctrl: rockchip: add rk3308 SoC support")
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Thanks for walking through the datasheet for the fixes :-)

> ---
>  drivers/pinctrl/pinctrl-rockchip.c | 45 ++++++++++++++++++++----------
>  1 file changed, 30 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
> index a1b598b86aa9..65fa305b5f59 100644
> --- a/drivers/pinctrl/pinctrl-rockchip.c
> +++ b/drivers/pinctrl/pinctrl-rockchip.c
> @@ -457,95 +457,110 @@ static  struct rockchip_mux_recalced_data rk3128_mux_recalced_data[] = {
>  
>  static struct rockchip_mux_recalced_data rk3308_mux_recalced_data[] = {
>  	{
> +		/* gpio1b6_sel */
>  		.num = 1,
>  		.pin = 14,
>  		.reg = 0x28,
>  		.bit = 12,
>  		.mask = 0xf
>  	}, {
> +		/* gpio1b7_sel */
>  		.num = 1,
>  		.pin = 15,
>  		.reg = 0x2c,
>  		.bit = 0,
>  		.mask = 0x3
>  	}, {
> +		/* gpio1c2_sel */
>  		.num = 1,
>  		.pin = 18,
>  		.reg = 0x30,
>  		.bit = 4,
>  		.mask = 0xf
>  	}, {
> +		/* gpio1c3_sel */
>  		.num = 1,
>  		.pin = 19,
>  		.reg = 0x30,
>  		.bit = 8,
>  		.mask = 0xf
>  	}, {
> +		/* gpio1c4_sel */
>  		.num = 1,
>  		.pin = 20,
>  		.reg = 0x30,
>  		.bit = 12,
>  		.mask = 0xf
>  	}, {
> +		/* gpio1c5_sel */
>  		.num = 1,
>  		.pin = 21,
>  		.reg = 0x34,
>  		.bit = 0,
>  		.mask = 0xf
>  	}, {
> +		/* gpio1c6_sel */
>  		.num = 1,
>  		.pin = 22,
>  		.reg = 0x34,
>  		.bit = 4,
>  		.mask = 0xf
>  	}, {
> +		/* gpio1c7_sel */
>  		.num = 1,
>  		.pin = 23,
>  		.reg = 0x34,
>  		.bit = 8,
>  		.mask = 0xf
>  	}, {
> +		/* gpio3b4_sel */
>  		.num = 3,
>  		.pin = 12,
>  		.reg = 0x68,
>  		.bit = 8,
>  		.mask = 0xf
>  	}, {
> +		/* gpio3b5_sel */
>  		.num = 3,
>  		.pin = 13,
>  		.reg = 0x68,
>  		.bit = 12,
>  		.mask = 0xf
>  	}, {
> +		/* gpio2a2_sel */
>  		.num = 2,
>  		.pin = 2,
> -		.reg = 0x608,
> -		.bit = 0,
> -		.mask = 0x7
> +		.reg = 0x40,
> +		.bit = 4,
> +		.mask = 0x3
>  	}, {
> +		/* gpio2a3_sel */
>  		.num = 2,
>  		.pin = 3,
> -		.reg = 0x608,
> -		.bit = 4,
> -		.mask = 0x7
> +		.reg = 0x40,
> +		.bit = 6,
> +		.mask = 0x3
>  	}, {
> +		/* gpio2c0_sel */
>  		.num = 2,
>  		.pin = 16,
> -		.reg = 0x610,
> -		.bit = 8,
> -		.mask = 0x7
> +		.reg = 0x50,
> +		.bit = 0,
> +		.mask = 0x3
>  	}, {
> +		/* gpio3b2_sel */
>  		.num = 3,
>  		.pin = 10,
> -		.reg = 0x610,
> -		.bit = 0,
> -		.mask = 0x7
> +		.reg = 0x68,
> +		.bit = 4,
> +		.mask = 0x3
>  	}, {
> +		/* gpio3b3_sel */
>  		.num = 3,
>  		.pin = 11,
> -		.reg = 0x610,
> -		.bit = 4,
> -		.mask = 0x7
> +		.reg = 0x68,
> +		.bit = 6,
> +		.mask = 0x3
>  	},
>  };
>  
> 




