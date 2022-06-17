Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC4654F779
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 14:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381669AbiFQM1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 08:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245358AbiFQM1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 08:27:30 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D37650B2B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 05:27:30 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id s10so4548649ljh.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 05:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JnQ7ER3/BznrTK6nfzGkCBcRLScePRNEds8wSayDWBU=;
        b=T640Ob++YeWd+T4ihz7vTm05LTeY1mBKCkrscFUItH+rfgs8IQ0zuI+rF5wsrv/uSE
         4smrU/D1K55NAapM7LpLvaSXHuQP8eg2yb3SWc2rmTcxAS5KSD2hsN3fqqIII8A+6MiP
         DbMWkdHmpqnFG0903QpZnEqTu9a5INuuekBkb8vVdCQirDUsG+lZHGpma8s/o7UzVIK8
         t72yJNWYaYTxkgjlJmAJnETqJtChitTyUpd6IcxFgltNZKauQiOWqEAt71NVwEEkD52L
         ivKggtaNSmYESsaOGpLfWglIE624MgV/4TyiIfLSanXQMC47IcQ/kflPwVGXVu68120j
         q5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JnQ7ER3/BznrTK6nfzGkCBcRLScePRNEds8wSayDWBU=;
        b=yxVufD8p26MkHy1lQc4z8ELZrwFaMrnWMWs4EHXal4Icv19gNUJk+J4PL6EPi8dIap
         XW6tmv6RFID8YBU5v7jfgfH0hAx7VLayY8inGA02bUMoUAtqc/eVLLHlTsirogIWsrbO
         Y7XrCG84T3HvR/aKAf8dYPJjuIgExBoPqQZfnYZ2HX9ba9jv862Fi7oVEQLdkJpJ42mv
         WL3J4o4YRDuE+1FpEx2+D35h2dzd3djnZBETlsIaAzT3KjCtXDJgDVEpTem4zAHSmKfn
         IfG6YMEW7C7L4XFTxDMYlNnK26/5qJRAoQx7SWgb6x+Bp4XEYesWsnS8fUS1rDyPufyt
         jRpA==
X-Gm-Message-State: AJIora9Zx81ZF53mhgJl9cAiehgsXQ7EDn7zes3L4WqEB7vEAQrm24Us
        yLkdB6TNE5SJkiydfc6MZTg=
X-Google-Smtp-Source: AGRyM1thk1l/pNJzxUInKJ0RZ+VOJmvPhKqfi3rTTC9JzaLkrNZkk9MrxX7xO+x0ncaIaqoA7DXVtg==
X-Received: by 2002:a2e:a783:0:b0:255:9be1:a471 with SMTP id c3-20020a2ea783000000b002559be1a471mr4816519ljf.215.1655468848267;
        Fri, 17 Jun 2022 05:27:28 -0700 (PDT)
Received: from [10.0.0.127] (91-159-150-230.elisa-laajakaista.fi. [91.159.150.230])
        by smtp.gmail.com with ESMTPSA id x8-20020a056512046800b0047e0061a611sm621093lfd.235.2022.06.17.05.27.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 05:27:27 -0700 (PDT)
Message-ID: <bc447b49-a02c-5c4f-4e04-8071ecdfe1bd@gmail.com>
Date:   Fri, 17 Jun 2022 15:28:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 11/11] ASoC: ti: davinci-mcasp: use
 pm_runtime_resume_and_get()
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20220616220427.136036-1-pierre-louis.bossart@linux.intel.com>
 <20220616220427.136036-12-pierre-louis.bossart@linux.intel.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20220616220427.136036-12-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On 17/06/2022 01:04, Pierre-Louis Bossart wrote:
> The use of pm_runtime_get_sync() is buggy with no use of put_noidle on
> error.
> 
> Use pm_runtime_resume_and_get() instead.

Thanks for the fix,

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> ---
>  sound/soc/ti/davinci-mcasp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
> index e2aab4729f3ab..0201000b619f6 100644
> --- a/sound/soc/ti/davinci-mcasp.c
> +++ b/sound/soc/ti/davinci-mcasp.c
> @@ -2111,8 +2111,7 @@ static int davinci_mcasp_gpio_request(struct gpio_chip *chip, unsigned offset)
>  	}
>  
>  	/* Do not change the PIN yet */
> -
> -	return pm_runtime_get_sync(mcasp->dev);
> +	return pm_runtime_resume_and_get(mcasp->dev);
>  }
>  
>  static void davinci_mcasp_gpio_free(struct gpio_chip *chip, unsigned offset)

-- 
Péter
