Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC1654630A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 12:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348330AbiFJKCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 06:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344915AbiFJKCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 06:02:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CDCB36EE;
        Fri, 10 Jun 2022 03:01:58 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 11AAB6601739;
        Fri, 10 Jun 2022 11:01:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654855316;
        bh=dsiCCp9lnFOmS3obijt8p1edAXlox7FEodLqv3vHvrI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AxXNVxBEp5VJxMcRieatCKA2EW2szeAAaQSKNFIYWXLs3xkgJSyCStafvGlTeoK1S
         60qyl/A4H0X8WG/V5ll8BuJKlAKrOrYXAauH7k6N1KBvpshZpFS+dD0n3XxmUpZ2id
         ErAn5N50Jy4ibtO88VjwuWC705RtWYIIXPIV4AJxhLYEVh3oNmEtD3jCiYDWpRDK24
         Djq9U+fG2wldu+YVUSJg6Jny7q8gVZpwRNA8iug+QoiSF4RNXevM3tf0jaCo2D1cjX
         krpFNdLFxNxVVmPM5JFKMdhCOifaXVpqTfHRhshMKU5bCDIYWbe7oYYXBF5LETJsiR
         6gQtGSyGCc9tA==
Message-ID: <d7934e1e-6a57-2c9a-76f7-42f0da180699@collabora.com>
Date:   Fri, 10 Jun 2022 12:01:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v7 3/8] ASoC: mediatek: mt8186: add mt8186-mt6366 common
 driver
Content-Language: en-US
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>, broonie@kernel.org,
        robh+dt@kernel.org
Cc:     aaronyu@google.com, matthias.bgg@gmail.com, trevor.wu@mediatek.com,
        tzungbi@google.com, julianbraha@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220610082724.29256-1-jiaxin.yu@mediatek.com>
 <20220610082724.29256-4-jiaxin.yu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220610082724.29256-4-jiaxin.yu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/06/22 10:27, Jiaxin Yu ha scritto:
> Add mt8186-mt6366 common driver for mt8186 series machine.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> ---
>   sound/soc/mediatek/mt8186/Makefile            |  1 +
>   .../mediatek/mt8186/mt8186-mt6366-common.c    | 59 +++++++++++++++++++
>   .../mediatek/mt8186/mt8186-mt6366-common.h    | 17 ++++++
>   3 files changed, 77 insertions(+)
>   create mode 100644 sound/soc/mediatek/mt8186/mt8186-mt6366-common.c
>   create mode 100644 sound/soc/mediatek/mt8186/mt8186-mt6366-common.h
> 

..snip..

> diff --git a/sound/soc/mediatek/mt8186/mt8186-mt6366-common.c b/sound/soc/mediatek/mt8186/mt8186-mt6366-common.c
> new file mode 100644
> index 000000000000..94e1128e8128
> --- /dev/null
> +++ b/sound/soc/mediatek/mt8186/mt8186-mt6366-common.c
> @@ -0,0 +1,59 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// mt8186-mt6366-common.c
> +//	--  MT8186 MT6366 ALSA common driver
> +//
> +// Copyright (c) 2022 MediaTek Inc.
> +// Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
> +//
> +#include <sound/soc.h>
> +
> +#include "../../codecs/mt6358.h"
> +#include "../common/mtk-afe-platform-driver.h"
> +#include "mt8186-afe-common.h"
> +#include "mt8186-mt6366-common.h"
> +
> +int mt8186_mt6366_init(struct snd_soc_pcm_runtime *rtd)
> +{
> +	struct snd_soc_component *cmpnt_afe =
> +		snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
> +	struct snd_soc_component *cmpnt_codec =
> +		asoc_rtd_to_codec(rtd, 0)->component;
> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt_afe);
> +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> +	struct snd_soc_dapm_context *dapm = &rtd->card->dapm;
> +	int ret;
> +
> +	/* set mtkaif protocol */
> +	mt6358_set_mtkaif_protocol(cmpnt_codec,
> +				   MT6358_MTKAIF_PROTOCOL_1);
> +	afe_priv->mtkaif_protocol = MT6358_MTKAIF_PROTOCOL_1;
> +
> +	ret = snd_soc_dapm_sync(dapm);
> +	if (ret) {
> +		dev_info(rtd->dev, "failed to snd_soc_dapm_sync\n");

This should be a dev_err().

> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mt8186_mt6366_init);
> +
> +int mt8186_mt6366_card_set_be_link(struct snd_soc_card *card,
> +				   struct snd_soc_dai_link *link,
> +				   struct device_node *node,
> +				   char *link_name)
> +{
> +	int ret;
> +
> +	if (node && strcmp(link->name, link_name) == 0) {
> +		ret = snd_soc_of_get_dai_link_codecs(card->dev, node, link);
> +		if (ret < 0) {
> +			dev_err_probe(card->dev, ret, "get dai link codecs fail\n");
> +			return ret;

You may at this point just 'return dev_err_probe(...)'.


Regards,
Angelo
