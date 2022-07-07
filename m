Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279B3569EA4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 11:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbiGGJiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 05:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbiGGJiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 05:38:03 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D6D4505C;
        Thu,  7 Jul 2022 02:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1657186680; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kXIlb6hdJqwtDzPJXzLaKXuJUAGqwuysqFCgGoS6L9w=;
        b=NKmYCqFt+Bn8O5D8zNt1stEVUcLMJ7FFoyccHrpplWfWGAESaQJEK3TE3fjxpPWPw8ONIu
        nf1ZpMQezjE6AGoRvyNUsoBGTqXM+YDCpHOsJaYgPQdcEBsrW4/JIoiG1eHRwFFCA0acF0
        BtHJn3OyliNtw4dXcHcKuDRuodF9K6U=
Date:   Thu, 07 Jul 2022 10:37:49 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 05/11] ASoC: jz4740-i2s: Remove unused SoC version IDs
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Message-Id: <1F9NER.E4VHP6MF1K5A2@crapouillou.net>
In-Reply-To: <20220706211330.120198-6-aidanmacdonald.0x0@gmail.com>
References: <20220706211330.120198-1-aidanmacdonald.0x0@gmail.com>
        <20220706211330.120198-6-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le mer., juil. 6 2022 at 22:13:24 +0100, Aidan MacDonald=20
<aidanmacdonald.0x0@gmail.com> a =E9crit :
> Using version IDs makes the code hard to follow -- it's better to
> describe the functional differences between SoCs instead. Remove
> the IDs since they're no longer used.
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>

Acked-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  sound/soc/jz4740/jz4740-i2s.c | 12 ------------
>  1 file changed, 12 deletions(-)
>=20
> diff --git a/sound/soc/jz4740/jz4740-i2s.c=20
> b/sound/soc/jz4740/jz4740-i2s.c
> index cbb89f724f64..8bb9449d13d3 100644
> --- a/sound/soc/jz4740/jz4740-i2s.c
> +++ b/sound/soc/jz4740/jz4740-i2s.c
> @@ -81,15 +81,7 @@
>  #define I2SDIV_IDV_SHIFT 8
>  #define I2SDIV_IDV_MASK (0xf << I2SDIV_IDV_SHIFT)
>=20
> -enum jz47xx_i2s_version {
> -	JZ_I2S_JZ4740,
> -	JZ_I2S_JZ4760,
> -	JZ_I2S_JZ4770,
> -	JZ_I2S_JZ4780,
> -};
> -
>  struct i2s_soc_info {
> -	enum jz47xx_i2s_version version;
>  	struct snd_soc_dai_driver *dai;
>=20
>  	struct reg_field field_rx_fifo_thresh;
> @@ -406,7 +398,6 @@ static struct snd_soc_dai_driver jz4740_i2s_dai =3D=20
> {
>  };
>=20
>  static const struct i2s_soc_info jz4740_i2s_soc_info =3D {
> -	.version =3D JZ_I2S_JZ4740,
>  	.dai =3D &jz4740_i2s_dai,
>  	.field_rx_fifo_thresh	=3D REG_FIELD(JZ_REG_AIC_CONF, 12, 15),
>  	.field_tx_fifo_thresh	=3D REG_FIELD(JZ_REG_AIC_CONF, 8, 11),
> @@ -415,7 +406,6 @@ static const struct i2s_soc_info=20
> jz4740_i2s_soc_info =3D {
>  };
>=20
>  static const struct i2s_soc_info jz4760_i2s_soc_info =3D {
> -	.version =3D JZ_I2S_JZ4760,
>  	.dai =3D &jz4740_i2s_dai,
>  	.field_rx_fifo_thresh	=3D REG_FIELD(JZ_REG_AIC_CONF, 24, 27),
>  	.field_tx_fifo_thresh	=3D REG_FIELD(JZ_REG_AIC_CONF, 16, 20),
> @@ -442,7 +432,6 @@ static struct snd_soc_dai_driver jz4770_i2s_dai =3D=20
> {
>  };
>=20
>  static const struct i2s_soc_info jz4770_i2s_soc_info =3D {
> -	.version =3D JZ_I2S_JZ4770,
>  	.dai =3D &jz4770_i2s_dai,
>  	.field_rx_fifo_thresh	=3D REG_FIELD(JZ_REG_AIC_CONF, 24, 27),
>  	.field_tx_fifo_thresh	=3D REG_FIELD(JZ_REG_AIC_CONF, 16, 20),
> @@ -451,7 +440,6 @@ static const struct i2s_soc_info=20
> jz4770_i2s_soc_info =3D {
>  };
>=20
>  static const struct i2s_soc_info jz4780_i2s_soc_info =3D {
> -	.version =3D JZ_I2S_JZ4780,
>  	.dai =3D &jz4770_i2s_dai,
>  	.field_rx_fifo_thresh	=3D REG_FIELD(JZ_REG_AIC_CONF, 24, 27),
>  	.field_tx_fifo_thresh	=3D REG_FIELD(JZ_REG_AIC_CONF, 16, 20),
> --
> 2.35.1
>=20


