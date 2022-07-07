Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE864569EC5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 11:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbiGGJnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 05:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbiGGJnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 05:43:07 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C2A45070;
        Thu,  7 Jul 2022 02:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1657186985; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i8p03/aknxZm4ISCg5osm/QCfwD06OLWvg98PIGVA6k=;
        b=4SIGlYDYz6ZeZwMrdFwcHjdodvrTphUWQoqLzkb/6LkauADFI0vWu+8mpxaajfTFhrYj87
        UHht/fC++I9qD2m9Mw2oNxWMBu2R3rOFRIB8frxKvS5vDhiJiRJAgBjkfneTYy4BzHYz+t
        BaW4ijYk24naRuCXPWWhsdjRcMj/ph4=
Date:   Thu, 07 Jul 2022 10:42:55 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 08/11] ASoC: jz4740-i2s: Align macro values and sort
 includes
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Message-Id: <JN9NER.N2JY086JY5VK2@crapouillou.net>
In-Reply-To: <20220706211330.120198-9-aidanmacdonald.0x0@gmail.com>
References: <20220706211330.120198-1-aidanmacdonald.0x0@gmail.com>
        <20220706211330.120198-9-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le mer., juil. 6 2022 at 22:13:27 +0100, Aidan MacDonald=20
<aidanmacdonald.0x0@gmail.com> a =E9crit :
> Some purely cosmetic changes: line up all the macro values to
> make things easier to read and sort the includes alphabetically.
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>

Acked-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  sound/soc/jz4740/jz4740-i2s.c | 66=20
> +++++++++++++++++------------------
>  1 file changed, 32 insertions(+), 34 deletions(-)
>=20
> diff --git a/sound/soc/jz4740/jz4740-i2s.c=20
> b/sound/soc/jz4740/jz4740-i2s.c
> index b8d2723c5f90..3a21ee9d34d1 100644
> --- a/sound/soc/jz4740/jz4740-i2s.c
> +++ b/sound/soc/jz4740/jz4740-i2s.c
> @@ -4,6 +4,9 @@
>   */
>=20
>  #include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
> @@ -13,11 +16,6 @@
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
>=20
> -#include <linux/clk.h>
> -#include <linux/delay.h>
> -
> -#include <linux/dma-mapping.h>
> -
>  #include <sound/core.h>
>  #include <sound/pcm.h>
>  #include <sound/pcm_params.h>
> @@ -35,36 +33,36 @@
>  #define JZ_REG_AIC_CLK_DIV	0x30
>  #define JZ_REG_AIC_FIFO		0x34
>=20
> -#define JZ_AIC_CONF_OVERFLOW_PLAY_LAST BIT(6)
> -#define JZ_AIC_CONF_INTERNAL_CODEC BIT(5)
> -#define JZ_AIC_CONF_I2S BIT(4)
> -#define JZ_AIC_CONF_RESET BIT(3)
> -#define JZ_AIC_CONF_BIT_CLK_MASTER BIT(2)
> -#define JZ_AIC_CONF_SYNC_CLK_MASTER BIT(1)
> -#define JZ_AIC_CONF_ENABLE BIT(0)
> -
> -#define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE GENMASK(21, 19)
> -#define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE GENMASK(18, 16)
> -#define JZ_AIC_CTRL_ENABLE_RX_DMA BIT(15)
> -#define JZ_AIC_CTRL_ENABLE_TX_DMA BIT(14)
> -#define JZ_AIC_CTRL_MONO_TO_STEREO BIT(11)
> -#define JZ_AIC_CTRL_SWITCH_ENDIANNESS BIT(10)
> -#define JZ_AIC_CTRL_SIGNED_TO_UNSIGNED BIT(9)
> +#define JZ_AIC_CONF_OVERFLOW_PLAY_LAST	BIT(6)
> +#define JZ_AIC_CONF_INTERNAL_CODEC	BIT(5)
> +#define JZ_AIC_CONF_I2S			BIT(4)
> +#define JZ_AIC_CONF_RESET		BIT(3)
> +#define JZ_AIC_CONF_BIT_CLK_MASTER	BIT(2)
> +#define JZ_AIC_CONF_SYNC_CLK_MASTER	BIT(1)
> +#define JZ_AIC_CONF_ENABLE		BIT(0)
> +
> +#define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE	GENMASK(21, 19)
> +#define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE	GENMASK(18, 16)
> +#define JZ_AIC_CTRL_ENABLE_RX_DMA	BIT(15)
> +#define JZ_AIC_CTRL_ENABLE_TX_DMA	BIT(14)
> +#define JZ_AIC_CTRL_MONO_TO_STEREO	BIT(11)
> +#define JZ_AIC_CTRL_SWITCH_ENDIANNESS	BIT(10)
> +#define JZ_AIC_CTRL_SIGNED_TO_UNSIGNED	BIT(9)
>  #define JZ_AIC_CTRL_FLUSH		BIT(8)
> -#define JZ_AIC_CTRL_ENABLE_ROR_INT BIT(6)
> -#define JZ_AIC_CTRL_ENABLE_TUR_INT BIT(5)
> -#define JZ_AIC_CTRL_ENABLE_RFS_INT BIT(4)
> -#define JZ_AIC_CTRL_ENABLE_TFS_INT BIT(3)
> -#define JZ_AIC_CTRL_ENABLE_LOOPBACK BIT(2)
> -#define JZ_AIC_CTRL_ENABLE_PLAYBACK BIT(1)
> -#define JZ_AIC_CTRL_ENABLE_CAPTURE BIT(0)
> -
> -#define JZ_AIC_I2S_FMT_DISABLE_BIT_CLK BIT(12)
> -#define JZ_AIC_I2S_FMT_DISABLE_BIT_ICLK BIT(13)
> -#define JZ_AIC_I2S_FMT_ENABLE_SYS_CLK BIT(4)
> -#define JZ_AIC_I2S_FMT_MSB BIT(0)
> -
> -#define JZ_AIC_I2S_STATUS_BUSY BIT(2)
> +#define JZ_AIC_CTRL_ENABLE_ROR_INT	BIT(6)
> +#define JZ_AIC_CTRL_ENABLE_TUR_INT	BIT(5)
> +#define JZ_AIC_CTRL_ENABLE_RFS_INT	BIT(4)
> +#define JZ_AIC_CTRL_ENABLE_TFS_INT	BIT(3)
> +#define JZ_AIC_CTRL_ENABLE_LOOPBACK	BIT(2)
> +#define JZ_AIC_CTRL_ENABLE_PLAYBACK	BIT(1)
> +#define JZ_AIC_CTRL_ENABLE_CAPTURE	BIT(0)
> +
> +#define JZ_AIC_I2S_FMT_DISABLE_BIT_CLK	BIT(12)
> +#define JZ_AIC_I2S_FMT_DISABLE_BIT_ICLK	BIT(13)
> +#define JZ_AIC_I2S_FMT_ENABLE_SYS_CLK	BIT(4)
> +#define JZ_AIC_I2S_FMT_MSB		BIT(0)
> +
> +#define JZ_AIC_I2S_STATUS_BUSY		BIT(2)
>=20
>  struct i2s_soc_info {
>  	struct snd_soc_dai_driver *dai;
> --
> 2.35.1
>=20


