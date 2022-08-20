Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAD259ABDF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 09:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343505AbiHTG6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 02:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245680AbiHTG57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 02:57:59 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C66C12FE
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 23:57:58 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id B5BC85C01E7;
        Sat, 20 Aug 2022 02:57:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 20 Aug 2022 02:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1660978675; x=
        1661065075; bh=EA5ufC/WgFPB445mJeYn4szYmBjc0cz8G0zs6SD0CbU=; b=j
        U2IA1itxSnm1JImuigBxXwogvS/z1qnKnbaK9uJVYX59xpYZpn2W+5/JywZ+kR7S
        KMvY5MpnBu6iT1LfvZ+o2lfbq5QoRHm4z5HiNXtWsS6AZiD6/z4svi19mcPcnTIx
        V3PCiUnUpzZ14HZy3vd6b2uN/+h8v2njJu9ADZQTYMc3Bmr76USyLCq7iYK1M4cx
        Y3DT14B/ixJVdzv4Ktok5hFsRGdQ0MyKxyaCWqTD42bj9w4k9rqDjzAOHKMVWvtw
        8OfOeBWYUxFf+ZUOCV2vHwFjpcSsnUmAHrtIzE9ISx/P/1hbv2GMy6+UAyG09yWG
        KspMpQmrlXJ6X7bHtCe8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660978675; x=
        1661065075; bh=EA5ufC/WgFPB445mJeYn4szYmBjc0cz8G0zs6SD0CbU=; b=0
        IunKZWEX/z8YGOvv2805GoUQuVHwPFWGynMvihRDBqF2Qg74UsgoBsnhY+OrmJsF
        hNGiTfBLnBEVF6yHJztBbbZaf5WKALkXBgfB9F9o4AQOFotI0VbwfaATcxfTjQUf
        fWXUrQHCq31DInU2F2UmMubBGF3ukqm919ywTlRqx4sE8cCPPoGjbCRrtB6vcdua
        BecBPpsQSdtYvWVymRb+iM7/M+pcY0R8R1QC8/047PnjDed28/9Sma/AOaGYtx32
        +0asZRRQ+lOwACUv//ltA2CuWwYfRzWhvW1AVsmFFdqb+SqKmXcQTXRtktrm5pJF
        G2YsSz2ix7GMlnq3s4ylw==
X-ME-Sender: <xms:8oUAY3WlH8lCdLlqoTfOBtChYPnQzip7yu3dMoJnfy0axwaYd63Ihw>
    <xme:8oUAY_ms8lb85KACVWDe71aAS3nI81xj4QwozPr_28wvhLTh9IF7R1FRapXlzwMuk
    UvX4Rq7lVVKPulRrA>
X-ME-Received: <xmr:8oUAYza0p2fGSG4a324BGO-SDq0KBA29Mftq-YmUlagPLE2PClgzoOEgNKwHXmKkkjAU0bbG0FU-gRw-R4udaQy85MWCDdnEV__Poncb4nNHJ_D1EmmDLPfrPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeivddgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepuffvvehfhffkffgfgggjtgfgse
    htjeertddtfeejnecuhfhrohhmpefurghmuhgvlhcujfholhhlrghnugcuoehsrghmuhgv
    lhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrghtthgvrhhnpefftdevkedvgeekue
    eutefgteffieelvedukeeuhfehledvhfeitdehudfhudehhfenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnh
    gurdhorhhg
X-ME-Proxy: <xmx:84UAYyWr-wjSecZT2JaDDEnwoTIzQ3PBuToPB_EUmrlwa_gyCwCa6w>
    <xmx:84UAYxnhSgeIpngjmtzOeG4kQrj54Byltd4rFo0kDBY8rt7gr_ZnWg>
    <xmx:84UAY_fpEBM0DFHVS_S0S-jMW-1I8i8mHY5q9xdCHh6kjtDe58qrZA>
    <xmx:84UAYyjfFcmqmIhMedYV8pnI2p3m8TQuDoBahfzIzUlcWQD-fbqO7g>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Aug 2022 02:57:54 -0400 (EDT)
Subject: Re: [PATCH v8 1/2] ASoC: sunxi: Add Allwinner H6 Digital MIC driver
To:     Ban Tao <fengzheng923@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, wens@csie.org, jernej.skrabec@gmail.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <1660229343-14133-1-git-send-email-fengzheng923@gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <3fb9adb7-96ef-c85e-069d-ef7f7ff09bc3@sholland.org>
Date:   Sat, 20 Aug 2022 01:57:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1660229343-14133-1-git-send-email-fengzheng923@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/22 9:49 AM, Ban Tao wrote:
> The Allwinner H6 and later SoCs have an DMIC block
> which is capable of capture.
> 
> Signed-off-by: Ban Tao <fengzheng923@gmail.com>

First of all, I tested this driver on the Lichee RV 86 Panel (the only board I
have with DMIC hardware), and it works great, so:

Tested-by: Samuel Holland <samuel@sholland.org>

> ---
> v1->v2:
> 1.Fix some compilation errors.
> 2.Modify some code styles.
> 
> v2->v3:
> None.
> 
> v3->v4:
> 1.add sig_bits.
> 
> v4->v5:
> None.
> 
> v5->v6:
> 1.Modify RXFIFO_CTL_MODE to mode 1.
> 
> v6->v7:
> 1.Modify dmic_rate_s to be a global variable.
> 2.Changed some macro names to make more sense.
> 3.Align code format.
> 4.Add a depends on PM to Kconfig entry.
> 
> v7->v8:
> None.
> ---
>  MAINTAINERS                   |   7 +
>  sound/soc/sunxi/Kconfig       |   8 +
>  sound/soc/sunxi/Makefile      |   1 +
>  sound/soc/sunxi/sun50i-dmic.c | 405 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 421 insertions(+)
>  create mode 100644 sound/soc/sunxi/sun50i-dmic.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e9d5b05..839f625 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -796,6 +796,13 @@ L:	linux-media@vger.kernel.org
>  S:	Maintained
>  F:	drivers/staging/media/sunxi/cedrus/
>  
> +ALLWINNER DMIC DRIVERS
> +M:	Ban Tao <fengzheng923@gmail.com>
> +L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml
> +F:	sound/soc/sunxi/sun50i-dmic.c
> +
>  ALPHA PORT
>  M:	Richard Henderson <rth@twiddle.net>
>  M:	Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> diff --git a/sound/soc/sunxi/Kconfig b/sound/soc/sunxi/Kconfig
> index ddcaaa9..8543234 100644
> --- a/sound/soc/sunxi/Kconfig
> +++ b/sound/soc/sunxi/Kconfig
> @@ -56,6 +56,14 @@ config SND_SUN4I_SPDIF
>  	  Say Y or M to add support for the S/PDIF audio block in the Allwinner
>  	  A10 and affiliated SoCs.
>  
> +config SND_SUN50I_DMIC
> +	tristate "Allwinner H6 DMIC Support"
> +	depends on (OF && PM && ARCH_SUNXI) || COMPILE_TEST

You do not need any of these dependencies. The driver compiles fine with !OF,
and runs fine with !PM. The "ARCH_SUNXI || COMPILE_TEST" dependency is already
covered by the "menu" line at the top of the file.

(In a previous version, Maxime suggested adding a PM dependency and removing the
fallback code. Since you kept the fallback code, you do not need the PM dependency.)

> +	select SND_SOC_GENERIC_DMAENGINE_PCM
> +	help
> +	  Say Y or M to add support for the DMIC audio block in the Allwinner
> +	  H6 and affiliated SoCs.
> +
>  config SND_SUN8I_ADDA_PR_REGMAP
>  	tristate
>  	select REGMAP
> diff --git a/sound/soc/sunxi/Makefile b/sound/soc/sunxi/Makefile
> index a86be34..4483fe9 100644
> --- a/sound/soc/sunxi/Makefile
> +++ b/sound/soc/sunxi/Makefile
> @@ -6,3 +6,4 @@ obj-$(CONFIG_SND_SUN8I_CODEC_ANALOG) += sun8i-codec-analog.o
>  obj-$(CONFIG_SND_SUN50I_CODEC_ANALOG) += sun50i-codec-analog.o
>  obj-$(CONFIG_SND_SUN8I_CODEC) += sun8i-codec.o
>  obj-$(CONFIG_SND_SUN8I_ADDA_PR_REGMAP) += sun8i-adda-pr-regmap.o
> +obj-$(CONFIG_SND_SUN50I_DMIC) += sun50i-dmic.o
> diff --git a/sound/soc/sunxi/sun50i-dmic.c b/sound/soc/sunxi/sun50i-dmic.c
> new file mode 100644
> index 0000000..76b3378
> --- /dev/null
> +++ b/sound/soc/sunxi/sun50i-dmic.c
> @@ -0,0 +1,405 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +//
> +// This driver supports the DMIC in Allwinner's H6 SoCs.
> +//
> +// Copyright 2021 Ban Tao <fengzheng923@gmail.com>
> +
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/of_device.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/reset.h>
> +#include <sound/dmaengine_pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>
> +
> +#define SUN50I_DMIC_EN_CTL             (0x00)
> +	#define SUN50I_DMIC_EN_CTL_GLOBE                BIT(8)
> +	#define SUN50I_DMIC_EN_CTL_CHAN(v)              ((v) << 0)
> +	#define SUN50I_DMIC_EN_CTL_CHAN_MASK            GENMASK(7, 0)
> +#define SUN50I_DMIC_SR                 (0x04)
> +	#define SUN50I_DMIC_SR_SAMPLE_RATE(v)           ((v) << 0)
> +	#define SUN50I_DMIC_SR_SAMPLE_RATE_MASK         GENMASK(2, 0)
> +#define SUN50I_DMIC_CTL                (0x08)
> +	#define SUN50I_DMIC_CTL_OVERSAMPLE_RATE         BIT(0)
> +#define SUN50I_DMIC_DATA               (0x10)
> +#define SUN50I_DMIC_INTC               (0x14)
> +	#define SUN50I_DMIC_FIFO_DRQ_EN                 BIT(2)
> +#define SUN50I_DMIC_INT_STA            (0x18)
> +	#define SUN50I_DMIC_INT_STA_OVERRUN_IRQ_PENDING BIT(1)
> +	#define SUN50I_DMIC_INT_STA_DATA_IRQ_PENDING    BIT(0)

Please consistently use tabs (not spaces) for aligning the macro values. You
have a mix here.

> +#define SUN50I_DMIC_RXFIFO_CTL         (0x1c)
> +	#define SUN50I_DMIC_RXFIFO_CTL_FLUSH            BIT(31)
> +	#define SUN50I_DMIC_RXFIFO_CTL_MODE_MASK	BIT(9)
> +	#define SUN50I_DMIC_RXFIFO_CTL_MODE_LSB		(0 << 9)
> +	#define SUN50I_DMIC_RXFIFO_CTL_MODE_MSB		(1 << 9)
> +	#define SUN50I_DMIC_RXFIFO_CTL_SAMPLE_MASK      BIT(8)
> +	#define SUN50I_DMIC_RXFIFO_CTL_SAMPLE_16        (0 << 8)
> +	#define SUN50I_DMIC_RXFIFO_CTL_SAMPLE_24        (1 << 8)
> +#define SUN50I_DMIC_CH_NUM             (0x24)
> +	#define SUN50I_DMIC_CH_NUM_N(v)                 ((v) << 0)
> +	#define SUN50I_DMIC_CH_NUM_N_MASK               GENMASK(2, 0)
> +#define SUN50I_DMIC_CNT                (0x2c)
> +	#define SUN50I_DMIC_CNT_N                       BIT(0)

This is a count of samples, not a bit mask, so the BIT() macro is misleading here.

> +#define SUN50I_DMIC_HPF_CTRL           (0x38)
> +#define SUN50I_DMIC_VERSION            (0x50)
> +
> +struct sun50i_dmic_dev {
> +	struct clk *dmic_clk;
> +	struct clk *bus_clk;
> +	struct reset_control *rst;
> +	struct regmap *regmap;
> +	struct snd_dmaengine_dai_dma_data dma_params_rx;
> +};
> +
> +struct dmic_rate {
> +	unsigned int samplerate;
> +	unsigned int rate_bit;
> +};
> +
> +static struct dmic_rate dmic_rate_s[] = {

Please make this const.

> +	{48000, 0x0},
> +	{44100, 0x0},
> +	{32000, 0x1},
> +	{24000, 0x2},
> +	{22050, 0x2},
> +	{16000, 0x3},
> +	{12000, 0x4},
> +	{11025, 0x4},
> +	{8000,  0x5},
> +};
> +
> +static int sun50i_dmic_startup(struct snd_pcm_substream *substream,
> +			       struct snd_soc_dai *cpu_dai)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct sun50i_dmic_dev *host = snd_soc_dai_get_drvdata(asoc_rtd_to_cpu(rtd, 0));
> +
> +	/* only support capture */
> +	if (substream->stream != SNDRV_PCM_STREAM_CAPTURE)
> +		return -EINVAL;
> +
> +	regmap_update_bits(host->regmap, SUN50I_DMIC_RXFIFO_CTL,
> +			SUN50I_DMIC_RXFIFO_CTL_FLUSH,
> +			SUN50I_DMIC_RXFIFO_CTL_FLUSH);
> +	regmap_write(host->regmap, SUN50I_DMIC_CNT, SUN50I_DMIC_CNT_N);
> +
> +	return 0;
> +}
> +
> +static int sun50i_dmic_hw_params(struct snd_pcm_substream *substream,
> +				 struct snd_pcm_hw_params *params,
> +				 struct snd_soc_dai *cpu_dai)
> +{
> +	int i = 0;
> +	unsigned long rate = params_rate(params);
> +	unsigned int mclk = 0;
> +	unsigned int channels = params_channels(params);
> +	unsigned int chan_en = (1 << channels) - 1;
> +	struct sun50i_dmic_dev *host = snd_soc_dai_get_drvdata(cpu_dai);
> +
> +	/* DMIC num is N+1 */
> +	regmap_update_bits(host->regmap, SUN50I_DMIC_CH_NUM,
> +			   SUN50I_DMIC_CH_NUM_N_MASK,
> +			   SUN50I_DMIC_CH_NUM_N(channels - 1));
> +	regmap_write(host->regmap, SUN50I_DMIC_HPF_CTRL, chan_en);
> +	regmap_update_bits(host->regmap, SUN50I_DMIC_EN_CTL,
> +			   SUN50I_DMIC_EN_CTL_CHAN_MASK,
> +			   SUN50I_DMIC_EN_CTL_CHAN(chan_en));
> +
> +	switch (params_format(params)) {
> +	case SNDRV_PCM_FORMAT_S16_LE:
> +		regmap_update_bits(host->regmap, SUN50I_DMIC_RXFIFO_CTL,
> +				   SUN50I_DMIC_RXFIFO_CTL_SAMPLE_MASK,
> +				   SUN50I_DMIC_RXFIFO_CTL_SAMPLE_16);
> +		break;
> +	case SNDRV_PCM_FORMAT_S24_LE:
> +		regmap_update_bits(host->regmap, SUN50I_DMIC_RXFIFO_CTL,
> +				   SUN50I_DMIC_RXFIFO_CTL_SAMPLE_MASK,
> +				   SUN50I_DMIC_RXFIFO_CTL_SAMPLE_24);
> +		break;
> +	default:
> +		dev_err(cpu_dai->dev, "Invalid format!\n");
> +		return -EINVAL;
> +	}
> +	regmap_update_bits(host->regmap, SUN50I_DMIC_RXFIFO_CTL,
> +			   SUN50I_DMIC_RXFIFO_CTL_MODE_MASK,
> +			   SUN50I_DMIC_RXFIFO_CTL_MODE_MSB);

I checked the manuals again, and I may have given you bad information. There
appear to be two variants of the DMIC hardware.

A63, H6, V5 V100, and V5x6 manuals list Mode 1 as "reserved" for a 24-bit sample
resolution. The newer SoCs (A50, A133, D1, H616, and R329) describe Mode 1 as
extending the 21-bit sample with three zeros at the LSB to make 24 bits, which
is what we want.

On my D1 board, recording in S24_LE gives me good audio data, with equivalent
loudness to S16_LE, as I would expect. If this also works on older SoCs like H6,
then the manual is wrong, and the driver is fine.

However, if recording in S24_LE does not work on H6, then we will need to limit
the driver to only S16_LE on H6. We could enable S24_LE on later SoCs with a
separate compatible string.

Please, can you test S24_LE on one of the older SoCs? (or let me know how it
works if you have already tested it)

The rest of the driver looks good to me.

Regards,
Samuel
