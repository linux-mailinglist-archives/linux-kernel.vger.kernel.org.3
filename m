Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40ED24679A1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 15:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381566AbhLCOtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 09:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381534AbhLCOtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 09:49:19 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A39C061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 06:45:55 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 207so6588729ljf.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 06:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=isVI3i0OnnF9HKk7LL+6nbdR6JnxGxIvGGvKoeFOlMs=;
        b=Pl4pmwVCPUPIF2AYBaEOUFoTbHtAE2VsxM7VpuSv/RBCkSZGX34k/NBdso9Tv0jLLp
         KEfLlxmt8wVHVSFloSOH3k4EUquj0I8STkq0WMMwVzKsMeju+DMyC5TA7JQnRrdqSl2N
         9mW9VNLaXAvL/hM/n7WVI5UdfY0ud0ZMFDeiKFuEgJDC3kiKR88r6DwHc0dB+rj+cLeo
         JQLU8JWgkQt7zRrFf8RKkLnTtanGE4fnIBJVJMKz4L42PwfhxNWGItUFBwNus9X0aw7s
         a5CjbPL1yMkybeauqRsYBInMN8tharIrL9coPnjWKcjZe6uRg86edJannynkQwJ8a1+/
         +fJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=isVI3i0OnnF9HKk7LL+6nbdR6JnxGxIvGGvKoeFOlMs=;
        b=o6LtPvLy70DOht3947DlmgIUjLkHnts/J2xeHwZZvYBB84jNcyOtaBN9ZqSAeijZke
         EkrqBY3xfyxeqBQ/z2yn8omcXqn7QFjg0sT6rYH1PuwwYzVCiuAtie20AVT+wzyPmGA8
         zdRfIFJMe2iNdBgPacBCwW9+oiu3xGraydtMDDFzUv9+cg7uKvBoKW8f9BOOfILb6hsf
         PZyAAxOw2pptMUljWJxOjIZf8M0hVpIylrE/DMCT0tekYx7mCmWiYgP5CnESUNQD6grW
         6SHFAKZC8u3xdtwWqoSGPdQO/37+ggSICtN6KhktE3W0xmBcwTULTqhBQsCiUcRxDsAx
         73+Q==
X-Gm-Message-State: AOAM53189WkIRznooNR1V85z8A6fggO9RgDjdaB3DUFJ9A5jG07NHaqY
        yChC5ElZAoepe36bHKSjMbc=
X-Google-Smtp-Source: ABdhPJx3zBP2dIEW33Re8Np8HCSdfQ1NKxZT30mOLTPKIvqlbRVrKtuhDhGOeEjnvH9cBWodlZRg0w==
X-Received: by 2002:a2e:a7c8:: with SMTP id x8mr18583832ljp.524.1638542753575;
        Fri, 03 Dec 2021 06:45:53 -0800 (PST)
Received: from [10.0.0.115] (91-153-170-164.elisa-laajakaista.fi. [91.153.170.164])
        by smtp.gmail.com with ESMTPSA id t69sm434642lff.110.2021.12.03.06.45.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 06:45:53 -0800 (PST)
Message-ID: <7dbddf9f-f8fc-f223-7f94-1e1f6382bc7e@gmail.com>
Date:   Fri, 3 Dec 2021 16:46:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v1 2/2] ASoC: ti: davinci-mcasp: Remove unnecessary
 conditional
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
References: <20211202205612.76216-1-andriy.shevchenko@linux.intel.com>
 <20211202205612.76216-2-andriy.shevchenko@linux.intel.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20211202205612.76216-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/12/2021 22:56, Andy Shevchenko wrote:
> Instead of double validating of_node, return value of
> the boolean property directly.

Nice cleanup, thanks,
Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> We can't remove ifdeffery, because in OF_GPIO=n cases
> it might bring unwanted surprises.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  sound/soc/ti/davinci-mcasp.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
> index 81c1ccec5904..3e105caac95e 100644
> --- a/sound/soc/ti/davinci-mcasp.c
> +++ b/sound/soc/ti/davinci-mcasp.c
> @@ -1870,12 +1870,10 @@ static int mcasp_reparent_fck(struct platform_device *pdev)
>  static bool davinci_mcasp_have_gpiochip(struct davinci_mcasp *mcasp)
>  {
>  #ifdef CONFIG_OF_GPIO
> -	if (mcasp->dev->of_node &&
> -	    of_property_read_bool(mcasp->dev->of_node, "gpio-controller"))
> -		return true;
> -#endif
> -
> +	return of_property_read_bool(mcasp->dev->of_node, "gpio-controller");
> +#else
>  	return false;
> +#endif
>  }
>  
>  static int davinci_mcasp_get_config(struct davinci_mcasp *mcasp,
> 

-- 
Péter
