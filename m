Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13AA57BDDE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 20:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbiGTSeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 14:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbiGTSeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 14:34:23 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332827173A;
        Wed, 20 Jul 2022 11:34:22 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id n18so31728005lfq.1;
        Wed, 20 Jul 2022 11:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=b2IGjPvv1choYzoAV1Tqhyte6OXYF3l5NgOtF5HHS20=;
        b=iYFL0IJ7Jkqoxjp1RcyQ2rt7c64g4N56f4zvzpC6OkXseA9YEoUigicZm4EbSoAbWn
         MAJbohHLv4MjcFefSfAZ5ZjWf6o2tKGwWL/3OnxSxN+aXZNvlFDFHvtcB2KmAUZW5VYF
         EVbUMrwO5a934pg4DSytH9B42vsodpul1HELuhluRODPL1ekWNCiq3SpCtotzI986d8N
         UBbV7+wHxF4z21kqlz7m1SmbuHSpqYTDWonRXvi+Iw6HXccNJSX7U9v3kkkShvwqdocK
         cz3NLO6xnqeuifyuN9PO/pCXFic+4z4xzcfaO5JOUApi1HYNJOVkJEvZ3xhBw9cUPTdV
         D5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=b2IGjPvv1choYzoAV1Tqhyte6OXYF3l5NgOtF5HHS20=;
        b=7arB2+y2Q7wsiK4gXKGt0nAfh1m0zNBbeTTPkhmI9MI8cxRxsi+gfcApclrlhb/gD/
         hno2z+xjFHAKcTRZ+W6HGWlycpmllg2oYsLhqAuDRO+ui3XS7bhgeIDjvbREzT2c0CbB
         RxV8T5ex8xSIIoUE6x0jNiokNLM6XIZwYKPLpzX2SCO0kPqJmS1fibM7rRo8Gc1ult7j
         tgnaT9Lh4XWkjDfr5pL7EezFMMmicKDOnTSjkUmhE+t4PAG1iCnEd63usRFo8krt29hw
         nZ7Ot+tS/xdEPQJ2UPeJeQHMVorqKBGZSwdJ7Q/EErj5vlBgTU3Qe069W9K0wIJ+MDD8
         dAbg==
X-Gm-Message-State: AJIora+miXsZFzW3piRntdv3V3l0gfPLRfoOC63aOldDC5HNKTeFWCN5
        bu1Q/w24kQNBYPvZlp07gHqzR4cn9ZRbwg==
X-Google-Smtp-Source: AGRyM1uUAYYbBd48fiG/kxsmXg01RYS7NmZ3PD6fqO0UdWLn4xzQMhfjvCplPxmst1VRf+olDmgAUg==
X-Received: by 2002:a05:6512:54e:b0:48a:19c9:2495 with SMTP id h14-20020a056512054e00b0048a19c92495mr16960596lfl.496.1658342060315;
        Wed, 20 Jul 2022 11:34:20 -0700 (PDT)
Received: from [10.0.0.127] (91-159-150-230.elisa-laajakaista.fi. [91.159.150.230])
        by smtp.gmail.com with ESMTPSA id k11-20020a05651c10ab00b0025a7bb04a7csm106390ljn.108.2022.07.20.11.34.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 11:34:19 -0700 (PDT)
Message-ID: <de72dd7f-639b-1733-a38b-a0ed9346f3d9@gmail.com>
Date:   Wed, 20 Jul 2022 21:36:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220720112152.22918-1-lukas.bulwahn@gmail.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH] ASoC: ti: remove sound support for DaVinci DM644x and
 DM646x
In-Reply-To: <20220720112152.22918-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

On 20/07/2022 14:21, Lukas Bulwahn wrote:
> Commit 7dd33764486d ("ARM: davinci: Delete DM644x board files") and commit
> b4aed01de486 ("ARM: davinci: Delete DM646x board files") removes the
> support for DaVinci DM644x and DM646x boards.
> 
> Hence, remove the sound support for those boards as well.

This is not going to remove the sound support, it is just removes the
select, which is now rendered NOP as neither MACH_DAVINCI_EVM nor
MACH_DAVINCI_DM6467_EVM is an option to select...

There is still structs and some code in davinci-evm.c in the path of
if (machine_is_davinci_evm())
and
else if (machine_is_davinci_dm6467_evm())

Those can also go, but I can only  drop that in about two weeks from now...

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  sound/soc/ti/Kconfig | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/sound/soc/ti/Kconfig b/sound/soc/ti/Kconfig
> index 40110e9a9e8a..35fddd7c501a 100644
> --- a/sound/soc/ti/Kconfig
> +++ b/sound/soc/ti/Kconfig
> @@ -180,9 +180,6 @@ config SND_SOC_DAVINCI_EVM
>  	select SND_SOC_DAVINCI_ASP if MACH_DAVINCI_DM355_EVM
>  	select SND_SOC_DAVINCI_ASP if SND_SOC_DM365_AIC3X_CODEC
>  	select SND_SOC_DAVINCI_VCIF if SND_SOC_DM365_VOICE_CODEC
> -	select SND_SOC_DAVINCI_ASP if MACH_DAVINCI_EVM # DM6446
> -	select SND_SOC_DAVINCI_MCASP if MACH_DAVINCI_DM6467_EVM
> -	select SND_SOC_SPDIF if MACH_DAVINCI_DM6467_EVM
>  	select SND_SOC_DAVINCI_MCASP if MACH_DAVINCI_DA830_EVM
>  	select SND_SOC_DAVINCI_MCASP if MACH_DAVINCI_DA850_EVM
>  	select SND_SOC_TLV320AIC3X
> @@ -191,8 +188,6 @@ config SND_SOC_DAVINCI_EVM
>  	  DaVinci EVM platforms:
>  	  - DM355
>  	  - DM365
> -	  - DM6446
> -	  - DM6447
>  	  - DM830
>  	  - DM850
>  

-- 
Péter
