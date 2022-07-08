Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2634756B402
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237514AbiGHIBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237490AbiGHIB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:01:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7EF7E030
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 01:01:25 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3A78266019D0;
        Fri,  8 Jul 2022 09:01:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657267283;
        bh=LzbKmXmv7B7il/FKmq7QEq+6QN2jxgs/LXih2F4BwGU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CjlJ+P8svhBRvMCG/0a0sKlb5G4gVagcN/c7sYzlGDV0AlznmiMr22htGcxjwHECC
         qQKaGh5T9bsmqD1OCaP/ly9krlA961L8r7Vu6g3wK7WhMBZd/l2h6zWEITQvyY1HSP
         rkgWbC1mffjvVsLGu75tZ+i1cjUMlDE5YjgTp7j9RcIZ5bO3TvMZQobsjxRX4updi8
         t4+wGN2LqTvio2dWsk6hpC8E6lK3TyL9VrS3I6Wn+Z6pTXts220TGrWcDEWbZqlA/g
         RVXOV22Ogoe45YCF+hIepEM7jvRx/nF7jW5KBqGZZXZcSh8K8S7F8Sk+2ud4ypjBc1
         /JN5dK6+CBpFQ==
Message-ID: <ee0d9788-b742-21bb-9cc5-7b729897408b@collabora.com>
Date:   Fri, 8 Jul 2022 10:01:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ASoC: mediatek: mt8186: Remove condition with no effect
Content-Language: en-US
To:     Zhongjun Tan <hbut_tan@163.com>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.c, tiwai@suse.com,
        matthias.bgg@gmail.com, jiaxin.yu@mediatek.com,
        tanzhongjun@coolpad.com, colin.king@intel.com
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220708024651.42999-1-hbut_tan@163.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220708024651.42999-1-hbut_tan@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/07/22 04:46, Zhongjun Tan ha scritto:
> From: Zhongjun Tan <tanzhongjun@coolpad.com>
> 
> Remove condition with no effect
> 
> Signed-off-by: Zhongjun Tan <tanzhongjun@coolpad.com>
> ---
>   sound/soc/mediatek/mt8186/mt8186-dai-adda.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/sound/soc/mediatek/mt8186/mt8186-dai-adda.c b/sound/soc/mediatek/mt8186/mt8186-dai-adda.c
> index db71b032770d..6be6d4f3b585 100644
> --- a/sound/soc/mediatek/mt8186/mt8186-dai-adda.c
> +++ b/sound/soc/mediatek/mt8186/mt8186-dai-adda.c
> @@ -295,8 +295,6 @@ static int mtk_adda_pad_top_event(struct snd_soc_dapm_widget *w,
>   	case SND_SOC_DAPM_PRE_PMU:
>   		if (afe_priv->mtkaif_protocol == MTKAIF_PROTOCOL_2_CLK_P2)
>   			regmap_write(afe->regmap, AFE_AUD_PAD_TOP, 0x39);
> -		else if (afe_priv->mtkaif_protocol == MTKAIF_PROTOCOL_2)
> -			regmap_write(afe->regmap, AFE_AUD_PAD_TOP, 0x31);

I think that this needs some clarification from MediaTek: was 0x31 a typo here?

Regards,
Angelo

>   		else
>   			regmap_write(afe->regmap, AFE_AUD_PAD_TOP, 0x31);
>   		break;


