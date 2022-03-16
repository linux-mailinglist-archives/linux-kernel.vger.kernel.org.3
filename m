Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5D44DAAC0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 07:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353938AbiCPGfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 02:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349781AbiCPGf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 02:35:27 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25523CA4B;
        Tue, 15 Mar 2022 23:34:13 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id q5so1779697ljb.11;
        Tue, 15 Mar 2022 23:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=++sa46MhpxjLZvQiBNBROIYgnEoEgMiydkA3vO85G7U=;
        b=SNUuaqm75EI0XWtB8fHZf6wvFEokjwp2fTUs+dK+S/Zm1Ow/VfJ3qlTL3AcuVao/C+
         tWWS4RCRZ/w9FQC58sXFjAM904UYhyMAbGwnnp74AIAZqojBGXDNccIrFBvVj12CuJ+c
         cBzbfOE1OBeCqj4x625ts2yQaXf0aXVP0zA9NuJxA25NWFOB4LHd7jfccKuRWjCn90x9
         /AGL+3XN++s61neGYD5kt9FV/xghZ8v/iDJ2KJCqSbIAxGo8IsTuJkpK7o4tMFC46mG3
         cmAIPx7OyXQrZWpGtjWs5vMwCz9wh28jxJrs0C/wghLM1jQs9OCzT3itsXvuNgHwc/sV
         Nlyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=++sa46MhpxjLZvQiBNBROIYgnEoEgMiydkA3vO85G7U=;
        b=BmxJTI/RLXXY1mFkL9kOA4svkKKvZgO8QTCV2pH7QCSOL0h+Q2ef6d9Q4up6Xn9sqo
         lbk3OTkCkli0rODvrqnZb77AJ+1FTdttBIqX0ZAvbyli5e1IechwLPcWUb8N9HyBq5Yw
         khz/VPdy65vkQrrNWPskeZZ1PTwBayE8/y7ptKL9XrWHWp4d4RP5+dpTFxI6ToGd0QUy
         Wsh8Vioa9tnkLwCbaoYSlJg2erSyZ4jHaprXwxVHjs2ey+f06/ahE/TeZtVrv5ge7n0X
         ST5xFvJI1rE/dsdP2gv34pHNOzVlFpCmA5dQbO7BWm+TocSPlb9gz/9LH9NVj8TiR3a1
         Pssw==
X-Gm-Message-State: AOAM530kE4rgaFbt62kbbR/FY3Tnj4sPdgNHabevGXLd1W0aJZxOjJYs
        0R1to8OMK4GkmuV3NfGGbuc=
X-Google-Smtp-Source: ABdhPJw9Ww1GDbf/aCnm1Gvac/Z8tRDtL6lbAgGCsIzAKktioAvkLknuASghcm3WBucuxEXIZ8MTOA==
X-Received: by 2002:a2e:b004:0:b0:247:e29f:fbd4 with SMTP id y4-20020a2eb004000000b00247e29ffbd4mr19034842ljk.315.1647412452039;
        Tue, 15 Mar 2022 23:34:12 -0700 (PDT)
Received: from [10.0.0.127] (91-159-150-230.elisa-laajakaista.fi. [91.159.150.230])
        by smtp.gmail.com with ESMTPSA id l9-20020a2ea309000000b00246299de080sm102223lje.48.2022.03.15.23.34.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 23:34:11 -0700 (PDT)
Message-ID: <4d3c65c0-1bc3-bc8f-393a-22c964f18120@gmail.com>
Date:   Wed, 16 Mar 2022 08:34:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ASoC: ti: Fix spelling mistake "cant" -> "can't"
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-omap@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220315230816.2964577-1-colin.i.king@gmail.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20220315230816.2964577-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/03/2022 01:08, Colin Ian King wrote:
> There is a spelling mistake in a dev_err message. Fix it.

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  sound/soc/ti/omap-dmic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/ti/omap-dmic.c b/sound/soc/ti/omap-dmic.c
> index a26588e9c3bc..f3eed20611a3 100644
> --- a/sound/soc/ti/omap-dmic.c
> +++ b/sound/soc/ti/omap-dmic.c
> @@ -474,7 +474,7 @@ static int asoc_dmic_probe(struct platform_device *pdev)
>  
>  	dmic->fclk = devm_clk_get(dmic->dev, "fck");
>  	if (IS_ERR(dmic->fclk)) {
> -		dev_err(dmic->dev, "cant get fck\n");
> +		dev_err(dmic->dev, "can't get fck\n");
>  		return -ENODEV;
>  	}
>  

-- 
Péter
