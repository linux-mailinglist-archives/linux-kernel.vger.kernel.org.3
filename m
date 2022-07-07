Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3855F569EE7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 11:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbiGGJyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 05:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233939AbiGGJyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 05:54:03 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2D94D14B;
        Thu,  7 Jul 2022 02:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1657187641; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nve6BKmlaYOc+otcI5eNXohDPw2cjmzrRzVfk9qXlSw=;
        b=QV8hoZwQTYaJ3Jt8bNtBQ+DQI0juH8x5zi9rMmqfAh1yP2oH9HizoJIn8ro25vqQChCN1G
        M9ZoL16/rzcKJcqAfnOp+VBukhcMLdDuhYIfNUJ8x/h6/TaEa7+bcVkEkOOKymU+bhNVYu
        KGkMwRNo+s52kdYt5n57pjrCZDEMZwE=
Date:   Thu, 07 Jul 2022 10:53:47 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 11/11] ASoC: jz4740-i2s: Support continuous sample rate
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Message-Id: <N5ANER.SGRSW7GYX3423@crapouillou.net>
In-Reply-To: <20220706211330.120198-12-aidanmacdonald.0x0@gmail.com>
References: <20220706211330.120198-1-aidanmacdonald.0x0@gmail.com>
        <20220706211330.120198-12-aidanmacdonald.0x0@gmail.com>
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



Le mer., juil. 6 2022 at 22:13:30 +0100, Aidan MacDonald=20
<aidanmacdonald.0x0@gmail.com> a =E9crit :
> The I2S controller on JZ47xx SoCs doesn't impose restrictions on
> sample rate and the driver doesn't make any assumptions about it,
> so the DAI should advertise a continuous sample rate range.
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>

Acked-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  sound/soc/jz4740/jz4740-i2s.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/sound/soc/jz4740/jz4740-i2s.c=20
> b/sound/soc/jz4740/jz4740-i2s.c
> index ee99c5e781ec..053697c7f19e 100644
> --- a/sound/soc/jz4740/jz4740-i2s.c
> +++ b/sound/soc/jz4740/jz4740-i2s.c
> @@ -378,13 +378,13 @@ static struct snd_soc_dai_driver jz4740_i2s_dai=20
> =3D {
>  	.playback =3D {
>  		.channels_min =3D 1,
>  		.channels_max =3D 2,
> -		.rates =3D SNDRV_PCM_RATE_8000_48000,
> +		.rates =3D SNDRV_PCM_RATE_CONTINUOUS,
>  		.formats =3D JZ4740_I2S_FMTS,
>  	},
>  	.capture =3D {
>  		.channels_min =3D 2,
>  		.channels_max =3D 2,
> -		.rates =3D SNDRV_PCM_RATE_8000_48000,
> +		.rates =3D SNDRV_PCM_RATE_CONTINUOUS,
>  		.formats =3D JZ4740_I2S_FMTS,
>  	},
>  	.symmetric_rate =3D 1,
> @@ -415,13 +415,13 @@ static struct snd_soc_dai_driver jz4770_i2s_dai=20
> =3D {
>  	.playback =3D {
>  		.channels_min =3D 1,
>  		.channels_max =3D 2,
> -		.rates =3D SNDRV_PCM_RATE_8000_48000,
> +		.rates =3D SNDRV_PCM_RATE_CONTINUOUS,
>  		.formats =3D JZ4740_I2S_FMTS,
>  	},
>  	.capture =3D {
>  		.channels_min =3D 2,
>  		.channels_max =3D 2,
> -		.rates =3D SNDRV_PCM_RATE_8000_48000,
> +		.rates =3D SNDRV_PCM_RATE_CONTINUOUS,
>  		.formats =3D JZ4740_I2S_FMTS,
>  	},
>  	.ops =3D &jz4740_i2s_dai_ops,
> --
> 2.35.1
>=20


