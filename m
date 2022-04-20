Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64BB508B8B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379974AbiDTPIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241054AbiDTPH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:07:58 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FD636B5B;
        Wed, 20 Apr 2022 08:05:10 -0700 (PDT)
Received: from [185.156.123.69] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nhBtC-0006R6-OT; Wed, 20 Apr 2022 17:05:06 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-gpio@vger.kernel.org,
        Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pinctrl: rockchip: sort the rk3308_mux_recalced_data entries
Date:   Wed, 20 Apr 2022 17:05:06 +0200
Message-ID: <4520799.LvFx2qVVIh@phil>
In-Reply-To: <20220420142432.248565-2-luca.ceresoli@bootlin.com>
References: <20220420142432.248565-1-luca.ceresoli@bootlin.com> <20220420142432.248565-2-luca.ceresoli@bootlin.com>
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

Am Mittwoch, 20. April 2022, 16:24:32 CEST schrieb Luca Ceresoli:
> All the entries are sorted according to num/pin except for two
> entries. Sort them too.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  drivers/pinctrl/pinctrl-rockchip.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
> index 65fa305b5f59..2cb79e649fcf 100644
> --- a/drivers/pinctrl/pinctrl-rockchip.c
> +++ b/drivers/pinctrl/pinctrl-rockchip.c
> @@ -512,20 +512,6 @@ static struct rockchip_mux_recalced_data rk3308_mux_recalced_data[] = {
>  		.reg = 0x34,
>  		.bit = 8,
>  		.mask = 0xf
> -	}, {
> -		/* gpio3b4_sel */
> -		.num = 3,
> -		.pin = 12,
> -		.reg = 0x68,
> -		.bit = 8,
> -		.mask = 0xf
> -	}, {
> -		/* gpio3b5_sel */
> -		.num = 3,
> -		.pin = 13,
> -		.reg = 0x68,
> -		.bit = 12,
> -		.mask = 0xf
>  	}, {
>  		/* gpio2a2_sel */
>  		.num = 2,
> @@ -561,6 +547,20 @@ static struct rockchip_mux_recalced_data rk3308_mux_recalced_data[] = {
>  		.reg = 0x68,
>  		.bit = 6,
>  		.mask = 0x3
> +	}, {
> +		/* gpio3b4_sel */
> +		.num = 3,
> +		.pin = 12,
> +		.reg = 0x68,
> +		.bit = 8,
> +		.mask = 0xf
> +	}, {
> +		/* gpio3b5_sel */
> +		.num = 3,
> +		.pin = 13,
> +		.reg = 0x68,
> +		.bit = 12,
> +		.mask = 0xf
>  	},
>  };
>  
> 




