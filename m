Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3C44D7FB0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 11:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238153AbiCNKTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 06:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238235AbiCNKTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 06:19:17 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676AD2408A;
        Mon, 14 Mar 2022 03:18:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 503631F43E42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647253086;
        bh=nQGCEaQV4SSt7P7Vs4H6IutV6PQurOMGF3CTakySQ4Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dZPSbnMF4ru8XqiTI61+q3Z0UEJ7yUYvUGIdlnPn8gD/ZAKNSSa9xQKI6cEe39jCT
         yEn5aSAbkzH4PgPoFNVjWXMx09Knhf/u9WT41z1wMPWXxjAl4e34+gi2RL4gFrD4ZF
         sm5PKK1jQRFrwxhYg95pzkz9pL9aQgrB/SAjl1aAfSA7ClNhLIOX0G2TNkoHbmfr5s
         hckhD84BpWv2LmD71gMNYe8wiqVfNke5nffD8VZHRQIGarIxuTViBB3NTIBi+8iTt2
         aFhq4s1Rrx2Iby/cyGUWO9kkNZaaRVmFoMBdHRzILvvqZNzd5njH38XEpiJU3I0H9V
         jiA5EFb9NLzHQ==
Message-ID: <a497b403-5b20-9a2f-498e-b43727b26675@collabora.com>
Date:   Mon, 14 Mar 2022 11:18:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [v3 19/19] ASoC: mediatek: mt6358: add missing EXPORT_SYMBOLs
Content-Language: en-US
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>, broonie@kernel.org,
        robh+dt@kernel.org
Cc:     aaronyu@google.com, matthias.bgg@gmail.com, trevor.wu@mediatek.com,
        tzungbi@google.com, julianbraha@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220313151023.21229-1-jiaxin.yu@mediatek.com>
 <20220313151023.21229-20-jiaxin.yu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220313151023.21229-20-jiaxin.yu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/03/22 16:10, Jiaxin Yu ha scritto:
> This fixes the following build errors when mt6358 is configured as module:
> 
>>> ERROR: modpost: "mt6358_set_mtkaif_protocol"
>>> [sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.ko] undefined!
>>> ERROR: modpost: "mt6358_set_mtkaif_protocol"
>>> [sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.ko] undefined!
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>

Hello Jiaxin,

Can you please add a Fixes tag to this patch and send it separately from
the MT8186 series?

After adding the Fixes tag:
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Thanks,
Angelo

> ---
>   sound/soc/codecs/mt6358.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/sound/soc/codecs/mt6358.c b/sound/soc/codecs/mt6358.c
> index 1fdd2f8cf877..61f2a7632fd4 100644
> --- a/sound/soc/codecs/mt6358.c
> +++ b/sound/soc/codecs/mt6358.c
> @@ -107,6 +107,7 @@ int mt6358_set_mtkaif_protocol(struct snd_soc_component *cmpnt,
>   	priv->mtkaif_protocol = mtkaif_protocol;
>   	return 0;
>   }
> +EXPORT_SYMBOL_GPL(mt6358_set_mtkaif_protocol);
>   
>   static void playback_gpio_set(struct mt6358_priv *priv)
>   {
> @@ -273,6 +274,7 @@ int mt6358_mtkaif_calibration_enable(struct snd_soc_component *cmpnt)
>   			   1 << RG_AUD_PAD_TOP_DAT_MISO_LOOPBACK_SFT);
>   	return 0;
>   }
> +EXPORT_SYMBOL_GPL(mt6358_mtkaif_calibration_enable);
>   
>   int mt6358_mtkaif_calibration_disable(struct snd_soc_component *cmpnt)
>   {
> @@ -296,6 +298,7 @@ int mt6358_mtkaif_calibration_disable(struct snd_soc_component *cmpnt)
>   	capture_gpio_reset(priv);
>   	return 0;
>   }
> +EXPORT_SYMBOL_GPL(mt6358_mtkaif_calibration_disable);
>   
>   int mt6358_set_mtkaif_calibration_phase(struct snd_soc_component *cmpnt,
>   					int phase_1, int phase_2)
> @@ -310,6 +313,7 @@ int mt6358_set_mtkaif_calibration_phase(struct snd_soc_component *cmpnt,
>   			   phase_2 << RG_AUD_PAD_TOP_PHASE_MODE2_SFT);
>   	return 0;
>   }
> +EXPORT_SYMBOL_GPL(mt6358_set_mtkaif_calibration_phase);
>   
>   /* dl pga gain */
>   enum {

