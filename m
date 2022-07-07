Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050F1569EC2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 11:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbiGGJmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 05:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbiGGJmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 05:42:39 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21DD175B0;
        Thu,  7 Jul 2022 02:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1657186957; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R5sBH/LTD5FNjNAFBgLqENfDmdXsl+8JDW39Z5mPsho=;
        b=YOCutFuPxElO81fsay3ThIPZqQO6RzEnWrcrzhD6w1a53aYvQA+Qq9NBqdCJLzyUh4VSLB
        pjpSmiKv5LEtKKZlYHP/uV5uX63u1EIaSII9d91QNdZvbBCnaHMyKBPmckFO+6UW95aoNt
        OYD/g/1EIDMsejdrQWG8s2gf8C0lccA=
Date:   Thu, 07 Jul 2022 10:42:27 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 07/11] ASoC: jz4740-i2s: Remove some unused macros
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Message-Id: <RM9NER.45MCKQG64UDT1@crapouillou.net>
In-Reply-To: <20220706211330.120198-8-aidanmacdonald.0x0@gmail.com>
References: <20220706211330.120198-1-aidanmacdonald.0x0@gmail.com>
        <20220706211330.120198-8-aidanmacdonald.0x0@gmail.com>
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



Le mer., juil. 6 2022 at 22:13:26 +0100, Aidan MacDonald=20
<aidanmacdonald.0x0@gmail.com> a =E9crit :
> These macros are unused and can be dropped; the information is now
> encoded in regmap fields.
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>

I think you can remove the macros in the patches where they are being=20
made obsolete.

Cheers,
-Paul

> ---
>  sound/soc/jz4740/jz4740-i2s.c | 13 -------------
>  1 file changed, 13 deletions(-)
>=20
> diff --git a/sound/soc/jz4740/jz4740-i2s.c=20
> b/sound/soc/jz4740/jz4740-i2s.c
> index 3c3cf78bf848..b8d2723c5f90 100644
> --- a/sound/soc/jz4740/jz4740-i2s.c
> +++ b/sound/soc/jz4740/jz4740-i2s.c
> @@ -35,8 +35,6 @@
>  #define JZ_REG_AIC_CLK_DIV	0x30
>  #define JZ_REG_AIC_FIFO		0x34
>=20
> -#define JZ_AIC_CONF_FIFO_RX_THRESHOLD_MASK (0xf << 12)
> -#define JZ_AIC_CONF_FIFO_TX_THRESHOLD_MASK (0xf <<  8)
>  #define JZ_AIC_CONF_OVERFLOW_PLAY_LAST BIT(6)
>  #define JZ_AIC_CONF_INTERNAL_CODEC BIT(5)
>  #define JZ_AIC_CONF_I2S BIT(4)
> @@ -45,11 +43,6 @@
>  #define JZ_AIC_CONF_SYNC_CLK_MASTER BIT(1)
>  #define JZ_AIC_CONF_ENABLE BIT(0)
>=20
> -#define JZ_AIC_CONF_FIFO_RX_THRESHOLD_OFFSET 12
> -#define JZ_AIC_CONF_FIFO_TX_THRESHOLD_OFFSET 8
> -#define JZ4760_AIC_CONF_FIFO_RX_THRESHOLD_OFFSET 24
> -#define JZ4760_AIC_CONF_FIFO_TX_THRESHOLD_OFFSET 16
> -
>  #define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE GENMASK(21, 19)
>  #define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE GENMASK(18, 16)
>  #define JZ_AIC_CTRL_ENABLE_RX_DMA BIT(15)
> @@ -73,12 +66,6 @@
>=20
>  #define JZ_AIC_I2S_STATUS_BUSY BIT(2)
>=20
> -#define JZ_AIC_CLK_DIV_MASK 0xf
> -#define I2SDIV_DV_SHIFT 0
> -#define I2SDIV_DV_MASK (0xf << I2SDIV_DV_SHIFT)
> -#define I2SDIV_IDV_SHIFT 8
> -#define I2SDIV_IDV_MASK (0xf << I2SDIV_IDV_SHIFT)
> -
>  struct i2s_soc_info {
>  	struct snd_soc_dai_driver *dai;
>=20
> --
> 2.35.1
>=20


