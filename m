Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF0D54E336
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 16:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377629AbiFPOSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 10:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377090AbiFPOSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 10:18:31 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EDD14D23;
        Thu, 16 Jun 2022 07:18:30 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id c4so2416754lfj.12;
        Thu, 16 Jun 2022 07:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=s5aFrnl2AMyHctil0oe+qIm2HKoq9Fasg76DynmQFT8=;
        b=TaZ91E/BoG18frEgBhkHoS2ZO/yNO/bkZNudGfR/5BjKPibX4g+xoEj2mHHRam+TcJ
         AAKw02u4dGAC1IQztDalowD/g9kOd7w/j+bXr1zdHAvFPdmSpsdQZU3By69Oxj1K259S
         CUXr36ItqScfq3bMuA/K4JMHh88ZxQp7opnpylen4lMe+2qE/INOMwLbhLn2VaO8+wn9
         ctXFFC9LvNaVYlcOJSK0HiLjJlO1/UIO0ApiAG6zf6AmCL2rmgyHlXcUusciOii6fJ1O
         XOADbq5ciJuu/VSp9o7fA1w4LWCfgTeLEWpy1FouNyT2vHlIToUUNOf41SgDB/8/mPPJ
         1FGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=s5aFrnl2AMyHctil0oe+qIm2HKoq9Fasg76DynmQFT8=;
        b=MOkJTpeVeRIsCerIVHTIWSWS9o0/BdfS8zQx37DEH25EiHsTWmVDH6YxbIZBx0tAzq
         LrrcpB0Ofac9ZlnksztiQwAnnb58nQj2XT3E5+Y4JIJqZBc3GmEj4zGg+oUJV9RADksz
         +/L3xEmE7Zpklyiz/hb4ndH14NMQp0J6MbowQcQIgPdbD7TMdz6xid68FH35MEKd2i7b
         JM8JH1bkUhuHV0YBkcFWFB85sSkx9EGgC32qfgojCjsj6+tYqYR1jAozGpvvbYqRddmO
         +pK/iJcmu8BrP5QefB2kfFLAlrfPlG6ms0ZhKYjZH28jUN1w0CL3KgB8WAelAa42i46E
         8rvw==
X-Gm-Message-State: AJIora+a7KuUYugpCDXmrr2/sIWAdZtwiUe7wk6QaO2HcP+TRBllOQGx
        zlaoahjUBcTly7YbnQ4zNVw=
X-Google-Smtp-Source: AGRyM1vVyx9qpPdlvimqOhvHYayIkfga0oQ7ZkWbaRKtWNnWsA/t96Fxv1C4DRgGpjkiU1DItozkVg==
X-Received: by 2002:a05:6512:c07:b0:479:2e0f:9a06 with SMTP id z7-20020a0565120c0700b004792e0f9a06mr2768718lfu.687.1655389108968;
        Thu, 16 Jun 2022 07:18:28 -0700 (PDT)
Received: from [10.0.0.42] (91-159-150-230.elisa-laajakaista.fi. [91.159.150.230])
        by smtp.gmail.com with ESMTPSA id a14-20020a19ca0e000000b004796a17246esm251884lfg.252.2022.06.16.07.18.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 07:18:28 -0700 (PDT)
Message-ID: <cd61d081-8f10-6dc2-c2ae-ffb8658d216b@gmail.com>
Date:   Thu, 16 Jun 2022 17:25:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] ASoC: ti: omap-mcbsp: duplicate sysfs error
Content-Language: en-US
To:     David Owens <dowens@precisionplanting.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220615150955.4140789-1-dowens@precisionplanting.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20220615150955.4140789-1-dowens@precisionplanting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 6/15/22 18:09, David Owens wrote:
> Convert to managed versions of sysfs and clk allocation to simplify
> unbinding and error handling in probe.  Managed sysfs node
> creation specifically addresses the following error seen the second time
> probe is attempted after sdma_pcm_platform_register() previously requsted
> probe deferral:
> 
> sysfs: cannot create duplicate filename '/devices/platform/68000000.ocp/49022000.mcbsp/max_tx_thres'

I have tried to looked up devm_sysfs_remove_group(), which did not
existed, but you found the correct devm ;)

Looks good, thank you!

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>


> Signed-off-by: David Owens <dowens@precisionplanting.com>
> ---
>  sound/soc/ti/omap-mcbsp-priv.h |  2 --
>  sound/soc/ti/omap-mcbsp-st.c   | 21 ++++-----------------
>  sound/soc/ti/omap-mcbsp.c      | 26 ++++----------------------
>  3 files changed, 8 insertions(+), 41 deletions(-)
> 
> diff --git a/sound/soc/ti/omap-mcbsp-priv.h b/sound/soc/ti/omap-mcbsp-priv.h
> index 7865cda4bf0a..da519ea1f303 100644
> --- a/sound/soc/ti/omap-mcbsp-priv.h
> +++ b/sound/soc/ti/omap-mcbsp-priv.h
> @@ -316,8 +316,6 @@ static inline int omap_mcbsp_read(struct omap_mcbsp *mcbsp, u16 reg,
> 
>  /* Sidetone specific API */
>  int omap_mcbsp_st_init(struct platform_device *pdev);
> -void omap_mcbsp_st_cleanup(struct platform_device *pdev);
> -
>  int omap_mcbsp_st_start(struct omap_mcbsp *mcbsp);
>  int omap_mcbsp_st_stop(struct omap_mcbsp *mcbsp);
> 
> diff --git a/sound/soc/ti/omap-mcbsp-st.c b/sound/soc/ti/omap-mcbsp-st.c
> index 0bc7d26c660a..402a57a502e6 100644
> --- a/sound/soc/ti/omap-mcbsp-st.c
> +++ b/sound/soc/ti/omap-mcbsp-st.c
> @@ -292,14 +292,11 @@ static ssize_t st_taps_store(struct device *dev,
> 
>  static DEVICE_ATTR_RW(st_taps);
> 
> -static const struct attribute *sidetone_attrs[] = {
> +static struct attribute *sidetone_attrs[] = {
>         &dev_attr_st_taps.attr,
>         NULL,
>  };
> -
> -static const struct attribute_group sidetone_attr_group = {
> -       .attrs = (struct attribute **)sidetone_attrs,
> -};
> +ATTRIBUTE_GROUPS(sidetone);
> 
>  int omap_mcbsp_st_start(struct omap_mcbsp *mcbsp)
>  {
> @@ -347,7 +344,7 @@ int omap_mcbsp_st_init(struct platform_device *pdev)
>         if (!st_data)
>                 return -ENOMEM;
> 
> -       st_data->mcbsp_iclk = clk_get(mcbsp->dev, "ick");
> +       st_data->mcbsp_iclk = devm_clk_get(mcbsp->dev, "ick");
>         if (IS_ERR(st_data->mcbsp_iclk)) {
>                 dev_warn(mcbsp->dev,
>                          "Failed to get ick, sidetone might be broken\n");
> @@ -359,7 +356,7 @@ int omap_mcbsp_st_init(struct platform_device *pdev)
>         if (!st_data->io_base_st)
>                 return -ENOMEM;
> 
> -       ret = sysfs_create_group(&mcbsp->dev->kobj, &sidetone_attr_group);
> +       ret = devm_device_add_group(mcbsp->dev, &sidetone_group);
>         if (ret)
>                 return ret;
> 
> @@ -368,16 +365,6 @@ int omap_mcbsp_st_init(struct platform_device *pdev)
>         return 0;
>  }
> 
> -void omap_mcbsp_st_cleanup(struct platform_device *pdev)
> -{
> -       struct omap_mcbsp *mcbsp = platform_get_drvdata(pdev);
> -
> -       if (mcbsp->st_data) {
> -               sysfs_remove_group(&mcbsp->dev->kobj, &sidetone_attr_group);
> -               clk_put(mcbsp->st_data->mcbsp_iclk);
> -       }
> -}
> -
>  static int omap_mcbsp_st_info_volsw(struct snd_kcontrol *kcontrol,
>                                     struct snd_ctl_elem_info *uinfo)
>  {
> diff --git a/sound/soc/ti/omap-mcbsp.c b/sound/soc/ti/omap-mcbsp.c
> index 4479d74f0a45..395493a2d965 100644
> --- a/sound/soc/ti/omap-mcbsp.c
> +++ b/sound/soc/ti/omap-mcbsp.c
> @@ -595,16 +595,13 @@ static ssize_t dma_op_mode_store(struct device *dev,
> 
>  static DEVICE_ATTR_RW(dma_op_mode);
> 
> -static const struct attribute *additional_attrs[] = {
> +static struct attribute *additional_attrs[] = {
>         &dev_attr_max_tx_thres.attr,
>         &dev_attr_max_rx_thres.attr,
>         &dev_attr_dma_op_mode.attr,
>         NULL,
>  };
> -
> -static const struct attribute_group additional_attr_group = {
> -       .attrs = (struct attribute **)additional_attrs,
> -};
> +ATTRIBUTE_GROUPS(additional);
> 
>  /*
>   * McBSP1 and McBSP3 are directly mapped on 1610 and 1510.
> @@ -702,8 +699,7 @@ static int omap_mcbsp_init(struct platform_device *pdev)
>                 mcbsp->max_tx_thres = max_thres(mcbsp) - 0x10;
>                 mcbsp->max_rx_thres = max_thres(mcbsp) - 0x10;
> 
> -               ret = sysfs_create_group(&mcbsp->dev->kobj,
> -                                        &additional_attr_group);
> +               ret = devm_device_add_group(mcbsp->dev, &additional_group);
>                 if (ret) {
>                         dev_err(mcbsp->dev,
>                                 "Unable to create additional controls\n");
> @@ -711,16 +707,7 @@ static int omap_mcbsp_init(struct platform_device *pdev)
>                 }
>         }
> 
> -       ret = omap_mcbsp_st_init(pdev);
> -       if (ret)
> -               goto err_st;
> -
> -       return 0;
> -
> -err_st:
> -       if (mcbsp->pdata->buffer_size)
> -               sysfs_remove_group(&mcbsp->dev->kobj, &additional_attr_group);
> -       return ret;
> +       return omap_mcbsp_st_init(pdev);
>  }
> 
>  /*
> @@ -1431,11 +1418,6 @@ static int asoc_mcbsp_remove(struct platform_device *pdev)
>         if (cpu_latency_qos_request_active(&mcbsp->pm_qos_req))
>                 cpu_latency_qos_remove_request(&mcbsp->pm_qos_req);
> 
> -       if (mcbsp->pdata->buffer_size)
> -               sysfs_remove_group(&mcbsp->dev->kobj, &additional_attr_group);
> -
> -       omap_mcbsp_st_cleanup(pdev);
> -
>         return 0;
>  }
> 
> --
> 2.34.1
> 
> This email is intended solely for the use of the individual to whom it is addressed and may contain confidential and/or privileged material. Any views or opinions presented are solely those of the author and do not necessarily represent those of Precision Planting. If you are not the intended recipient, be advised that you have received this email in error and that any use, dissemination, forwarding, printing, or copying of this email is strictly prohibited. Neither AGCO nor the sender accepts any responsibility for viruses, and it is your responsibility to scan, and virus check the e-mail and its attachment(s) (if any).

-- 
Péter
