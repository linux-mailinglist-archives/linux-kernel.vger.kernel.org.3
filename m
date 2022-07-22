Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB1557DC3D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbiGVIVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbiGVIVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:21:42 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B8D9E294
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 01:21:41 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26M5W98a002873;
        Fri, 22 Jul 2022 03:20:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=GntB1BCtcoPvCgqm5ushfKyKSHcldkf+JZ2aiyILZro=;
 b=gq4iiMo+OzmhxhUU80Fw9ynoV5jlId+PiHfjbDPJRST1dloJsdDvLz/zH9FyxHo6hwaS
 0/DIh38GOy7voa0qxOFR36g2nDTfQxHVdeTdQxkIgSp96aui7pQR1LoemTc2hxeibH+k
 h9ZGJLYuWE5s30TojD+Q+soKxYyaBT8ah9SJnUszDjSUa6sHT60jo2UESpHeTwBgxheG
 bkdGZGtV+QkhVFhZ9gP+PTgMU3nbFemZjNlsrZ2LS94IqAn3swC6fi8yvorFsTj+2rRI
 UsNXabuley0Sb0qgqIDT5PAnt/RwIclWFm/S/jLuO1AI4m2Pn4P6YSLh84P75lTzNiaX xA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3hdxffbm46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 03:20:39 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Fri, 22 Jul
 2022 03:20:37 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1118.9 via Frontend Transport; Fri, 22 Jul 2022 03:20:37 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5C035B0E;
        Fri, 22 Jul 2022 08:20:37 +0000 (UTC)
Date:   Fri, 22 Jul 2022 08:20:37 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <kernel@collabora.com>,
        <david.rhodes@cirrus.com>, <tanureal@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: amd: vangogh: Use non-legacy DAI naming for cs35l41
Message-ID: <20220722082037.GE92394@ediswmail.ad.cirrus.com>
References: <20220721233227.1459374-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220721233227.1459374-1-cristian.ciocaltea@collabora.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: -LieSRoCLqrTKJf1hUJY24KjP9k_P9X2
X-Proofpoint-GUID: -LieSRoCLqrTKJf1hUJY24KjP9k_P9X2
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 02:32:27AM +0300, Cristian Ciocaltea wrote:
> Unlike most CODEC drivers, the CS35L41 driver did not have the
> non_legacy_dai_naming set, meaning the corresponding DAI has been
> traditionally registered using the legacy naming: spi-VLV1776:0x
> 
> The recent migration to the new legacy DAI naming style has implicitly
> corrected that behavior and DAI gets now registered via the non-legacy
> naming, i.e. cs35l41-pcm.
> 
> The problem is the acp5x platform driver is now broken as it continues
> to refer to the above mentioned codec using the legacy DAI naming in
> function acp5x_cs35l41_hw_params() and, therefore, the related setup
> is not being executed anymore.
> 
> Let's fix that by replacing the obsolete DAI name with the correct one.
> 
> Fixes: bc949a3b4af3 ("ASoC: core: Switch core to new DAI naming flag")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---

Looks good to me:

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Looped in David and Lucas from ourside who I believe worked on
the steam deck incase they have any comments too. Apologies for
this one and thank you for fixing it up.

Thanks,
Charles

>  sound/soc/amd/vangogh/acp5x-mach.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/sound/soc/amd/vangogh/acp5x-mach.c b/sound/soc/amd/vangogh/acp5x-mach.c
> index 727de46860b1..af3737ef9707 100644
> --- a/sound/soc/amd/vangogh/acp5x-mach.c
> +++ b/sound/soc/amd/vangogh/acp5x-mach.c
> @@ -178,8 +178,7 @@ static int acp5x_cs35l41_hw_params(struct snd_pcm_substream *substream,
>  	ret = 0;
>  	for (i = 0; i < num_codecs; i++) {
>  		codec_dai = asoc_rtd_to_codec(rtd, i);
> -		if ((strcmp(codec_dai->name, "spi-VLV1776:00") == 0) ||
> -		    (strcmp(codec_dai->name, "spi-VLV1776:01") == 0)) {
> +		if (strcmp(codec_dai->name, "cs35l41-pcm") == 0) {
>  			switch (params_rate(params)) {
>  			case 48000:
>  				bclk_val = 1536000;
> -- 
> 2.37.1
> 
