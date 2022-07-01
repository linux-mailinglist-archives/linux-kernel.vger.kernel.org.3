Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C932A5637FB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 18:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbiGAQdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 12:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiGAQdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 12:33:42 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C3D37A18
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 09:33:38 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220701163331euoutp02b3437e0fa843a7abc00b20d27ee7d98a~9wbLWQQdp2671226712euoutp02Z
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 16:33:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220701163331euoutp02b3437e0fa843a7abc00b20d27ee7d98a~9wbLWQQdp2671226712euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656693211;
        bh=bizoWPlPK5st/YO8xYIpTf+rNLa6oVJvb3nqJKze7k0=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=ZMoamkS11lLdMYZsydoOGEIcOU3Hr81KRUa1t6mszgm1FwfWZmBmXnuHHK7+0AAeB
         7O0sndw6W2o70ooGfGiHK6wuS4w3mvzfC4c6RnxcteBx0ZeO1mXya6g1z4BgJviEZN
         FGqXVa1sa2SdDp8Zz8lVSaQZzZF10k7RV1zmIQAA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220701163331eucas1p210850633cd72817d6822168d92f65c85~9wbKxUFZY3139931399eucas1p2q;
        Fri,  1 Jul 2022 16:33:31 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id BC.81.09580.BD12FB26; Fri,  1
        Jul 2022 17:33:31 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220701163330eucas1p13456e7757d9d2bc8d0aa35c16f143590~9wbKQl4O_0661706617eucas1p1r;
        Fri,  1 Jul 2022 16:33:30 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220701163330eusmtrp2c62d95bf9221f3c331a24cd6106409b4~9wbKP0wxq0506105061eusmtrp2J;
        Fri,  1 Jul 2022 16:33:30 +0000 (GMT)
X-AuditID: cbfec7f5-9adff7000000256c-f2-62bf21db2e43
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 95.69.09095.AD12FB26; Fri,  1
        Jul 2022 17:33:30 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220701163329eusmtip1ccb491e6e39932d89b59f9cc9cb94ad0~9wbJiXe2w2253322533eusmtip1S;
        Fri,  1 Jul 2022 16:33:29 +0000 (GMT)
Message-ID: <acaaf77f-3282-8544-dd3c-7915fc1a6a4f@samsung.com>
Date:   Fri, 1 Jul 2022 18:33:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v2 11/12] regmap-irq: Add get_irq_reg() callback
Content-Language: en-US
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        andy.shevchenko@gmail.com, mazziesaccount@gmail.com,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20220623211420.918875-12-aidanmacdonald.0x0@gmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsWy7djP87q3FfcnGXzdymxxa+NuVouXEw4z
        Wkx9+ITNonnxejaL8+c3sFtc3jWHzWLG+X1MFnOWnmCxmPtlKrMDp8fOWXfZPTat6mTz2D93
        DbvH501yASxRXDYpqTmZZalF+nYJXBlHDhxjKmgvqbj0greB8XZkFyMnh4SAicTD/imMXYxc
        HEICKxglrp+7zQLhfGGU2HdhISuE85lR4uv6Q2wwLZv7V7NDJJYzSiw+coodJCEk8JFRYvO8
        WhCbV8BO4sa7XhYQm0VAReLIs+2sEHFBiZMzn4DFRQWSJc6dvQo2VFjARaLlx1Ewm1lAXOLW
        k/lMILaIgJvE9q3HwU5iFnjFKPHg5xOwZWwChhJdb7vAGjiBmmfv+sYK0Swvsf3tHGaQBgmB
        JxwSZzpns0Cc7SKxa0k7I4QtLPHq+BZ2CFtG4v9OkG0cQHa+xN8ZxhDhColrr9cwQ9jWEnfO
        /WIDKWEW0JRYv0sfIuwoMafnG1Qnn8SNt4IQF/BJTNo2nRkizCvR0SYEUa0mMev4OridBy9c
        Yp7AqDQLKVBmIXl+FpJfZiHsXcDIsopRPLW0ODc9tdg4L7Vcrzgxt7g0L10vOT93EyMwEZ3+
        d/zrDsYVrz7qHWJk4mA8xCjBwawkwss2b2+SEG9KYmVValF+fFFpTmrxIUZpDhYlcd7kzA2J
        QgLpiSWp2ampBalFMFkmDk6pBqYpXgaLXs+5fG7hgqL7/qvUftee+7ZabPqT4w4vZP1kdgVY
        HAmLmPgqc5Pn7e2H8s489z669GAfX9yG1cqTp63K/ci9ofEJs85O9arL/PqOLJyzD25fz/LJ
        gdXzTGus3L/vBUeCpmzymf/KdRFT2KGZt4Tfrrv6cskn7Z36yaz69iwNvg+fHtlinWgeVLcl
        4cXLtdK2d++y5+lWNNkfXKiwniPu4/wit+unDy3v/bL7ht1h3V9i/y+G7p8gxL6OR8tPYuNN
        z0O/l+lMKdnecngL6/GQJ5xCH5avcON0W2rM7GYkevvb9x8h9sfrgv0fX6yabx14cN+Ghfev
        laVZzPc7k2w4oVAn+OMl27g39z+UVCqxFGckGmoxFxUnAgA74wxoswMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsVy+t/xu7q3FPcnGXQ8kLa4tXE3q8XLCYcZ
        LaY+fMJm0bx4PZvF+fMb2C0u75rDZjHj/D4mizlLT7BYzP0yldmB02PnrLvsHptWdbJ57J+7
        ht3j8ya5AJYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQi
        fbsEvYwjB44xFbSXVFx6wdvAeDuyi5GTQ0LARGJz/2r2LkYuDiGBpYwS775tZoFIyEicnNbA
        CmELS/y51sUGUfSeUWLZk1Z2kASvgJ3EjXe9YA0sAioSR55tZ4WIC0qcnPkELC4qkCzRvOUQ
        E4gtLOAi0fLjKBuIzSwgLnHryXywuIiAm8T2rcdZQBYwC7xilNjSvxqsWUigRmLD/i2MIDab
        gKFE19susGZOoEGzd31jhRhkJtG1tYsRwpaX2P52DvMERqFZSO6YhWTfLCQts5C0LGBkWcUo
        klpanJueW2yoV5yYW1yal66XnJ+7iREYf9uO/dy8g3Heq496hxiZOBgPMUpwMCuJ8LLN25sk
        xJuSWFmVWpQfX1Sak1p8iNEUGBgTmaVEk/OBCSCvJN7QzMDU0MTM0sDU0sxYSZzXs6AjUUgg
        PbEkNTs1tSC1CKaPiYNTqoGJ50+3zovGH6zdG0X9PrHlr1X90sobXb23aZsfn5whQ93sF07J
        pdpR3ccC72xJPj7dffXeybdWr1lqUTFZVpPnWnPdtneph0PvzQ3ffrkz5fX+S+9ucB24+Yet
        ve67LdtaPqG4q/mceYHxP0sMnZPXtYt1l9/8rtpYoOuoWT1t4cIcYW91pz3asQ5RLy5vnf7v
        iojIXoemJ3X839lUHMKSbE/GfqljYH9UzJUeff7G8h2qR04H+Dvpnzp3MJ4r3T05V/By945T
        00V6l0bOrnxZ4yq5Zz7vmx8Fcm4M8Uax79cY676Zp3tp0xw3UY4dNQ3l2lp5n+f2JdyK3RVX
        ky41b1mvntGSLYlPj8mnaiuxFGckGmoxFxUnAgD12Xv1SAMAAA==
X-CMS-MailID: 20220701163330eucas1p13456e7757d9d2bc8d0aa35c16f143590
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220701163330eucas1p13456e7757d9d2bc8d0aa35c16f143590
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220701163330eucas1p13456e7757d9d2bc8d0aa35c16f143590
References: <20220623211420.918875-1-aidanmacdonald.0x0@gmail.com>
        <20220623211420.918875-12-aidanmacdonald.0x0@gmail.com>
        <CGME20220701163330eucas1p13456e7757d9d2bc8d0aa35c16f143590@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 23.06.2022 23:14, Aidan MacDonald wrote:
> Replace the internal sub_irq_reg() function with a public callback
> that drivers can use when they have more complex register layouts.
> The default implementation is regmap_irq_get_irq_reg_linear(), used
> if the chip doesn't provide its own callback.
>
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---

This patch landed in today's linux next-20220701 as commit bdf9b86cd3ad 
("regmap-irq: Add get_irq_reg() callback"). I've noticed that it causes 
a regression on my test systems: the RTC alarm stopped working on all 
boards with Samsung PMICs (drivers/mfd/sec*.c). There are no 
warnings/oopses/etc. Waitng for the RTC alarm lasts forever, so it looks 
that something is broken with interrupts. Reverting it on top of 
linux-next fixes the issue.

Unfortunately I'm going for a holidays for the whole next week and I'm 
not able to analyze this issue further today. Krzysztof: maybe You will 
be able to provide some more hints which regmap irq variant is broken?


>   drivers/base/regmap/regmap-irq.c | 126 ++++++++++++++++++++-----------
>   include/linux/regmap.h           |  15 +++-
>   2 files changed, 93 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
> index 2c724ae185c4..71de097847a7 100644
> --- a/drivers/base/regmap/regmap-irq.c
> +++ b/drivers/base/regmap/regmap-irq.c
> @@ -46,30 +46,12 @@ struct regmap_irq_chip_data {
>   
>   	unsigned int irq_reg_stride;
>   
> +	unsigned int (*get_irq_reg)(struct regmap_irq_chip_data *data,
> +				    unsigned int base, int index);
> +
>   	unsigned int clear_status:1;
>   };
>   
> -static int sub_irq_reg(struct regmap_irq_chip_data *data,
> -		       unsigned int base_reg, int i)
> -{
> -	const struct regmap_irq_chip *chip = data->chip;
> -	struct regmap *map = data->map;
> -	struct regmap_irq_sub_irq_map *subreg;
> -	unsigned int offset;
> -	int reg = 0;
> -
> -	if (!chip->sub_reg_offsets || !chip->not_fixed_stride) {
> -		/* Assume linear mapping */
> -		reg = base_reg + (i * map->reg_stride * data->irq_reg_stride);
> -	} else {
> -		subreg = &chip->sub_reg_offsets[i];
> -		offset = subreg->offset[0];
> -		reg = base_reg + offset;
> -	}
> -
> -	return reg;
> -}
> -
>   static inline const
>   struct regmap_irq *irq_to_regmap_irq(struct regmap_irq_chip_data *data,
>   				     int irq)
> @@ -81,7 +63,13 @@ static bool regmap_irq_can_bulk_read_status(struct regmap_irq_chip_data *data)
>   {
>   	struct regmap *map = data->map;
>   
> +	/*
> +	 * While possible that a user-defined ->get_irq_reg() callback might
> +	 * be linear enough to support bulk reads, most of the time it won't.
> +	 * Therefore only allow them if the default callback is being used.
> +	 */
>   	return data->irq_reg_stride == 1 && map->reg_stride == 1 &&
> +	       data->get_irq_reg == regmap_irq_get_irq_reg_linear &&
>   	       !map->use_single_read;
>   }
>   
> @@ -109,7 +97,7 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
>   
>   	if (d->clear_status) {
>   		for (i = 0; i < d->chip->num_regs; i++) {
> -			reg = sub_irq_reg(d, d->chip->status_base, i);
> +			reg = d->get_irq_reg(d, d->chip->status_base, i);
>   
>   			ret = regmap_read(map, reg, &val);
>   			if (ret)
> @@ -127,7 +115,7 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
>   	 */
>   	for (i = 0; i < d->chip->num_regs; i++) {
>   		if (d->mask_base) {
> -			reg = sub_irq_reg(d, d->mask_base, i);
> +			reg = d->get_irq_reg(d, d->mask_base, i);
>   			ret = regmap_update_bits(d->map, reg,
>   					d->mask_buf_def[i], d->mask_buf[i]);
>   			if (ret)
> @@ -136,7 +124,7 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
>   		}
>   
>   		if (d->unmask_base) {
> -			reg = sub_irq_reg(d, d->unmask_base, i);
> +			reg = d->get_irq_reg(d, d->unmask_base, i);
>   			ret = regmap_update_bits(d->map, reg,
>   					d->mask_buf_def[i], ~d->mask_buf[i]);
>   			if (ret)
> @@ -144,7 +132,7 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
>   					reg);
>   		}
>   
> -		reg = sub_irq_reg(d, d->chip->wake_base, i);
> +		reg = d->get_irq_reg(d, d->chip->wake_base, i);
>   		if (d->wake_buf) {
>   			if (d->chip->wake_invert)
>   				ret = regmap_update_bits(d->map, reg,
> @@ -168,7 +156,7 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
>   		 * it'll be ignored in irq handler, then may introduce irq storm
>   		 */
>   		if (d->mask_buf[i] && (d->chip->ack_base || d->chip->use_ack)) {
> -			reg = sub_irq_reg(d, d->chip->ack_base, i);
> +			reg = d->get_irq_reg(d, d->chip->ack_base, i);
>   
>   			/* some chips ack by write 0 */
>   			if (d->chip->ack_invert)
> @@ -192,7 +180,7 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
>   		for (i = 0; i < d->chip->num_type_reg; i++) {
>   			if (!d->type_buf_def[i])
>   				continue;
> -			reg = sub_irq_reg(d, d->chip->type_base, i);
> +			reg = d->get_irq_reg(d, d->chip->type_base, i);
>   			if (d->chip->type_invert)
>   				ret = regmap_update_bits(d->map, reg,
>   					d->type_buf_def[i], ~d->type_buf[i]);
> @@ -208,8 +196,8 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
>   	if (d->chip->num_virt_regs) {
>   		for (i = 0; i < d->chip->num_virt_regs; i++) {
>   			for (j = 0; j < d->chip->num_regs; j++) {
> -				reg = sub_irq_reg(d, d->chip->virt_reg_base[i],
> -						  j);
> +				reg = d->get_irq_reg(d, d->chip->virt_reg_base[i],
> +						     j);
>   				ret = regmap_write(map, reg, d->virt_buf[i][j]);
>   				if (ret != 0)
>   					dev_err(d->map->dev,
> @@ -221,7 +209,7 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
>   
>   	for (i = 0; i < d->chip->num_config_bases; i++) {
>   		for (j = 0; j < d->chip->num_config_regs; j++) {
> -			reg = sub_irq_reg(d, d->chip->config_base[i], j);
> +			reg = d->get_irq_reg(d, d->chip->config_base[i], j);
>   			ret = regmap_write(map, reg, d->config_buf[i][j]);
>   			if (ret)
>   				dev_err(d->map->dev,
> @@ -382,14 +370,17 @@ static inline int read_sub_irq_data(struct regmap_irq_chip_data *data,
>   	const struct regmap_irq_chip *chip = data->chip;
>   	struct regmap *map = data->map;
>   	struct regmap_irq_sub_irq_map *subreg;
> +	unsigned int reg;
>   	int i, ret = 0;
>   
>   	if (!chip->sub_reg_offsets) {
> -		/* Assume linear mapping */
> -		ret = regmap_read(map, chip->status_base +
> -				  (b * map->reg_stride * data->irq_reg_stride),
> -				   &data->status_buf[b]);
> +		reg = data->get_irq_reg(data, chip->status_base, b);
> +		ret = regmap_read(map, reg, &data->status_buf[b]);
>   	} else {
> +		/*
> +		 * Note we can't use ->get_irq_reg() here because the offsets
> +		 * in 'subreg' are *not* interchangeable with indices.
> +		 */
>   		subreg = &chip->sub_reg_offsets[b];
>   		for (i = 0; i < subreg->num_regs; i++) {
>   			unsigned int offset = subreg->offset[i];
> @@ -455,10 +446,18 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
>   		 * sake of simplicity. and add bulk reads only if needed
>   		 */
>   		for (i = 0; i < chip->num_main_regs; i++) {
> -			ret = regmap_read(map, chip->main_status +
> -				  (i * map->reg_stride
> -				   * data->irq_reg_stride),
> -				  &data->main_status_buf[i]);
> +			/*
> +			 * For not_fixed_stride, don't use ->get_irq_reg().
> +			 * It would produce an incorrect result.
> +			 */
> +			if (data->chip->not_fixed_stride)
> +				reg = chip->main_status +
> +					i * map->reg_stride * data->irq_reg_stride;
> +			else
> +				reg = data->get_irq_reg(data,
> +							chip->main_status, i);
> +
> +			ret = regmap_read(map, reg, &data->main_status_buf[i]);
>   			if (ret) {
>   				dev_err(map->dev,
>   					"Failed to read IRQ status %d\n",
> @@ -523,7 +522,7 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
>   
>   	} else {
>   		for (i = 0; i < data->chip->num_regs; i++) {
> -			unsigned int reg = sub_irq_reg(data,
> +			unsigned int reg = data->get_irq_reg(data,
>   					data->chip->status_base, i);
>   			ret = regmap_read(map, reg, &data->status_buf[i]);
>   
> @@ -551,7 +550,7 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
>   		data->status_buf[i] &= ~data->mask_buf[i];
>   
>   		if (data->status_buf[i] && (chip->ack_base || chip->use_ack)) {
> -			reg = sub_irq_reg(data, data->chip->ack_base, i);
> +			reg = data->get_irq_reg(data, data->chip->ack_base, i);
>   
>   			if (chip->ack_invert)
>   				ret = regmap_write(map, reg,
> @@ -611,6 +610,36 @@ static const struct irq_domain_ops regmap_domain_ops = {
>   	.xlate	= irq_domain_xlate_onetwocell,
>   };
>   
> +/**
> + * regmap_irq_get_irq_reg_linear() - Linear IRQ register mapping callback.
> + * @data: Data for the &struct regmap_irq_chip
> + * @base: Base register
> + * @index: Register index
> + *
> + * Returns the register address corresponding to the given @base and @index
> + * by the formula ``base + index * regmap_stride * irq_reg_stride``.
> + */
> +unsigned int regmap_irq_get_irq_reg_linear(struct regmap_irq_chip_data *data,
> +					   unsigned int base, int index)
> +{
> +	const struct regmap_irq_chip *chip = data->chip;
> +	struct regmap *map = data->map;
> +
> +	/*
> +	 * FIXME: This is for backward compatibility and should be removed
> +	 * when not_fixed_stride is dropped (it's only used by qcom-pm8008).
> +	 */
> +	if (chip->not_fixed_stride && chip->sub_reg_offsets) {
> +		struct regmap_irq_sub_irq_map *subreg;
> +
> +		subreg = &chip->sub_reg_offsets[0];
> +		return base + subreg->offset[0];
> +	}
> +
> +	return base + index * map->reg_stride * chip->irq_reg_stride;
> +}
> +EXPORT_SYMBOL_GPL(regmap_irq_get_irq_reg_linear);
> +
>   /**
>    * regmap_irq_set_type_config_simple() - Simple IRQ type configuration callback.
>    * @buf: Buffer containing configuration register values, this is a 2D array of
> @@ -862,6 +891,11 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
>   	else
>   		d->irq_reg_stride = 1;
>   
> +	if (chip->get_irq_reg)
> +		d->get_irq_reg = chip->get_irq_reg;
> +	else
> +		d->get_irq_reg = regmap_irq_get_irq_reg_linear;
> +
>   	if (regmap_irq_can_bulk_read_status(d)) {
>   		d->status_reg_buf = kmalloc_array(chip->num_regs,
>   						  map->format.val_bytes,
> @@ -881,7 +915,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
>   		d->mask_buf[i] = d->mask_buf_def[i];
>   
>   		if (d->mask_base) {
> -			reg = sub_irq_reg(d, d->mask_base, i);
> +			reg = d->get_irq_reg(d, d->mask_base, i);
>   			ret = regmap_update_bits(d->map, reg,
>   					d->mask_buf_def[i], d->mask_buf[i]);
>   			if (ret) {
> @@ -892,7 +926,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
>   		}
>   
>   		if (d->unmask_base) {
> -			reg = sub_irq_reg(d, d->unmask_base, i);
> +			reg = d->get_irq_reg(d, d->unmask_base, i);
>   			ret = regmap_update_bits(d->map, reg,
>   					d->mask_buf_def[i], ~d->mask_buf[i]);
>   			if (ret) {
> @@ -906,7 +940,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
>   			continue;
>   
>   		/* Ack masked but set interrupts */
> -		reg = sub_irq_reg(d, d->chip->status_base, i);
> +		reg = d->get_irq_reg(d, d->chip->status_base, i);
>   		ret = regmap_read(map, reg, &d->status_buf[i]);
>   		if (ret != 0) {
>   			dev_err(map->dev, "Failed to read IRQ status: %d\n",
> @@ -918,7 +952,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
>   			d->status_buf[i] = ~d->status_buf[i];
>   
>   		if (d->status_buf[i] && (chip->ack_base || chip->use_ack)) {
> -			reg = sub_irq_reg(d, d->chip->ack_base, i);
> +			reg = d->get_irq_reg(d, d->chip->ack_base, i);
>   			if (chip->ack_invert)
>   				ret = regmap_write(map, reg,
>   					~(d->status_buf[i] & d->mask_buf[i]));
> @@ -943,7 +977,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
>   	if (d->wake_buf) {
>   		for (i = 0; i < chip->num_regs; i++) {
>   			d->wake_buf[i] = d->mask_buf_def[i];
> -			reg = sub_irq_reg(d, d->chip->wake_base, i);
> +			reg = d->get_irq_reg(d, d->chip->wake_base, i);
>   
>   			if (chip->wake_invert)
>   				ret = regmap_update_bits(d->map, reg,
> @@ -963,7 +997,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
>   
>   	if (chip->num_type_reg && !chip->type_in_mask) {
>   		for (i = 0; i < chip->num_type_reg; ++i) {
> -			reg = sub_irq_reg(d, d->chip->type_base, i);
> +			reg = d->get_irq_reg(d, d->chip->type_base, i);
>   
>   			ret = regmap_read(map, reg, &d->type_buf_def[i]);
>   
> diff --git a/include/linux/regmap.h b/include/linux/regmap.h
> index 708f36dfaeda..ae5f1f7d4b5a 100644
> --- a/include/linux/regmap.h
> +++ b/include/linux/regmap.h
> @@ -1424,6 +1424,8 @@ struct regmap_irq_sub_irq_map {
>   	unsigned int *offset;
>   };
>   
> +struct regmap_irq_chip_data;
> +
>   /**
>    * struct regmap_irq_chip - Description of a generic regmap irq_chip.
>    *
> @@ -1515,6 +1517,13 @@ struct regmap_irq_sub_irq_map {
>    *		     and configure virt regs. Deprecated, use @set_type_config
>    *		     callback and config registers instead.
>    * @set_type_config: Callback used for configuring irq types.
> + * @get_irq_reg: Callback for mapping (base register, index) pairs to register
> + *		 addresses. The base register will be one of @status_base,
> + *		 @mask_base, etc., @main_status, or any of @config_base.
> + *		 The index will be in the range [0, num_main_regs[ for the
> + *		 main status base, [0, num_type_settings[ for any config
> + *		 register base, and [0, num_regs[ for any other base.
> + *		 If unspecified then regmap_irq_get_irq_reg_linear() is used.
>    * @irq_drv_data:    Driver specific IRQ data which is passed as parameter when
>    *		     driver specific pre/post interrupt handler is called.
>    *
> @@ -1569,11 +1578,13 @@ struct regmap_irq_chip {
>   			     unsigned long hwirq, int reg);
>   	int (*set_type_config)(unsigned int **buf, unsigned int type,
>   			       const struct regmap_irq *irq_data, int idx);
> +	unsigned int (*get_irq_reg)(struct regmap_irq_chip_data *data,
> +				    unsigned int base, int index);
>   	void *irq_drv_data;
>   };
>   
> -struct regmap_irq_chip_data;
> -
> +unsigned int regmap_irq_get_irq_reg_linear(struct regmap_irq_chip_data *data,
> +					   unsigned int base, int index);
>   int regmap_irq_set_type_config_simple(unsigned int **buf, unsigned int type,
>   				      const struct regmap_irq *irq_data, int idx);
>   

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

