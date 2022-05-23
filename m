Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8D15307F7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 05:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354286AbiEWDKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 23:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354226AbiEWDKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 23:10:02 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F7633EAF;
        Sun, 22 May 2022 20:10:01 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 22CEC5C0097;
        Sun, 22 May 2022 23:09:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 22 May 2022 23:09:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1653275398; x=
        1653361798; bh=dDu98oTe18z7O2jWYV61FHk7bMxBVeuTHkFzuRc4l2I=; b=A
        5rzXkf8VEbFuqG3COPwI5cO7JvJl0Xb2zetemlbHxHZzCxZ7U3lay1YkU0JqXIOM
        BTdSBel30BYkVTnyyoTLf+Y5xAZT/oKCqMFnQJ7/WUCp4eeam/PZBTkM29MuMF6i
        ++oVd2bkY8cIgZz3YMnXUfElHH7lbd7sgv3vVmQyzngycFGJV74L5Lp3QHM293kV
        XByYOPcxt5LNBe2smN9nvz5+gY7KxBUUN3IdNoHkcfR1QmYZd1mejLby2T8lXagS
        /7Hpos7Z8PaYFbRPtdMB+m9+DVXuxOOolKbtroRt2o8tMkxzAZU8DLrhd6W/rq4n
        z8hKDHWZMeWWSw6nSfGjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1653275398; x=1653361798; bh=d
        Du98oTe18z7O2jWYV61FHk7bMxBVeuTHkFzuRc4l2I=; b=MU3HsbdjJ0hb6k3X1
        LBWxRam/mxTlamL5bIIPM887s1egKMIyLTCvzV3vybwoNDLb4uyeQLp+/aZTnqOl
        vShHR5wETK4QT1+oVU1a/UCYlnikEM6yvARMzAhoxbEgLzC4tE+wHvSotNYvSob8
        OfMLs95sxYz5KR0bLGrd95gGcRWRFhmqBb2D2dpOLLfUQ1BSOulqRbBCCDHPpKwR
        L5JbFf+nWPz+Y0bsnZ1bMjdkbugWN4yyvhSls2NKp/cZwRvftEijAz74euWSqkZv
        SeZF1j8TDyQAi15/4mLa8tCA+pMx8rcircBU2u5z4b05lbsXSaxgLVi5ZPSNHYZr
        7U48g==
X-ME-Sender: <xms:BPuKYrr4h0gxSVKHH5LnKOIViMR_VGxf6FPaGS_127DQdWgcJY1OqA>
    <xme:BPuKYlofyurnw-KLoLB2qOBUo-aL6OaeSxdckJ1nsqAAYRL7JvswIN58dXbP-A-o0
    5YE-KsjVYHH9tiWew>
X-ME-Received: <xmr:BPuKYoONknr2C9jonBwCPPrjShOxEn1XuVOt8DaPWanpjaEnKTToSOGyVq_m0ckbkxRF3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrieelgdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpefgveffteelheffjeeukedvkedviedtheevgeefkeehueeiieeuteeu
    gfettdeggeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:BPuKYu5eMS_3MKDfGedw-8ujJYx_Q7jy3fm7zmTWFKgU3qWuQSX3qg>
    <xmx:BPuKYq4D-5bwa52F8tF0jAyVBfYLoUvFg6auJ6GmcrT-pu0dllRpBA>
    <xmx:BPuKYmiBfZfoVyPapko0TgZCIvcJzhfwAZfLbb4LFTCuVUD0ukA7KQ>
    <xmx:BvuKYpRc03d5pSiEO0zWQi2M3ZJyooJVpJlmw0MQK1grF9sDjmt6bw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 May 2022 23:09:55 -0400 (EDT)
Subject: Re: [PATCH v2 1/4] regmap: provide regmap_field helpers for simple
 bit operations
To:     Li Chen <lchen.firstlove@zohomail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-sunxi <linux-sunxi@lists.linux.dev>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
References: <180e702a15f.e737e37e45859.3135149506136486394@zohomail.com>
 <180eeb93909.12110e2de60158.391061173597432851@zohomail.com>
 <180eeba3811.f7218bc260169.7323954027713751119@zohomail.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <e96cb553-1ac7-dbd7-3086-b623511471c5@sholland.org>
Date:   Sun, 22 May 2022 22:09:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <180eeba3811.f7218bc260169.7323954027713751119@zohomail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/22/22 9:23 PM, Li Chen wrote:
> From: Li Chen <lchen@ambarella.com>
> 
> We have set/clear/test operations for regmap, but not for regmap_field yet.
> So let's introduce regmap_field helpers too.
> 
> In many instances regmap_field_update_bits() is used for simple bit setting
> and clearing. In these cases the last argument is redundant and we can
> hide it with a static inline function.
> 
> This adds three new helpers for simple bit operations: set_bits,
> clear_bits and test_bits (the last one defined as a regular function).
> 
> Signed-off-by: Li Chen <lchen@ambarella.com>
> ---
>  drivers/base/regmap/regmap.c | 22 +++++++++++++++++++++
>  include/linux/regmap.h       | 37 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 59 insertions(+)
> 
> diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
> index 5e12f7cb5147..a37d6041b7bd 100644
> --- a/drivers/base/regmap/regmap.c
> +++ b/drivers/base/regmap/regmap.c
> @@ -2208,6 +2208,28 @@ int regmap_field_update_bits_base(struct regmap_field *field,
>  }
>  EXPORT_SYMBOL_GPL(regmap_field_update_bits_base);
>  
> +/**
> + * regmap_field_test_bits() - Check if all specified bits are set in a
> + *                            register field.
> + *
> + * @field: Register field to operate on
> + * @bits: Bits to test
> + *
> + * Returns -1 if the underlying regmap_field_read() fails, 0 if at least one of the
> + * tested bits is not set and 1 if all tested bits are set.
> + */
> +int regmap_field_test_bits(struct regmap_field *field, unsigned int bits)
> +{
> +	unsigned int val, ret;
> +
> +	ret = regmap_field_read(field, &val);
> +	if (ret)
> +		return ret;
> +
> +	return (val & bits) == bits;
> +}
> +EXPORT_SYMBOL_GPL(regmap_field_test_bits);
> +
>  /**
>   * regmap_fields_update_bits_base() - Perform a read/modify/write cycle a
>   *                                    register field with port ID
> diff --git a/include/linux/regmap.h b/include/linux/regmap.h
> index de81a94d7b30..10b410734d9e 100644
> --- a/include/linux/regmap.h
> +++ b/include/linux/regmap.h
> @@ -1324,6 +1324,22 @@ static inline int regmap_field_update_bits(struct regmap_field *field,
>  					     NULL, false, false);
>  }
>  
> +static inline int regmap_field_set_bits(struct regmap_field *field,
> +					unsigned int bits)
> +{
> +	return regmap_field_update_bits_base(field, bits, 0, NULL, false,
> +					     false);
> +}
> +
> +static inline int regmap_field_clear_bits(struct regmap_field *field,
> +					  unsigned int bits)
> +{
> +	return regmap_field_update_bits_base(field, bits, bits, NULL, false,
> +					     false);

The contents of these two functions are swapped when compared to their names.

Regards,
Samuel

> +}
> +
> +int regmap_field_test_bits(struct regmap_field *field, unsigned int bits);
> +
>  static inline int
>  regmap_field_force_update_bits(struct regmap_field *field,
>  			       unsigned int mask, unsigned int val)
> @@ -1757,6 +1773,27 @@ regmap_field_force_update_bits(struct regmap_field *field,
>  	return -EINVAL;
>  }
>  
> +static inline int regmap_field_set_bits(struct regmap_field *field,
> +					unsigned int bits)
> +{
> +	WARN_ONCE(1, "regmap API is disabled");
> +	return -EINVAL;
> +}
> +
> +static inline int regmap_field_clear_bits(struct regmap_field *field,
> +					  unsigned int bits)
> +{
> +	WARN_ONCE(1, "regmap API is disabled");
> +	return -EINVAL;
> +}
> +
> +static inline int regmap_field_test_bits(struct regmap_field *field,
> +					 unsigned int bits)
> +{
> +	WARN_ONCE(1, "regmap API is disabled");
> +	return -EINVAL;
> +}
> +
>  static inline int regmap_fields_write(struct regmap_field *field,
>  				      unsigned int id, unsigned int val)
>  {
> 

