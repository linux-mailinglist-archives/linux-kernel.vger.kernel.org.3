Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7F755032D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 08:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiFRGTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 02:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiFRGTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 02:19:13 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78D92CE04;
        Fri, 17 Jun 2022 23:19:11 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id be31so9811219lfb.10;
        Fri, 17 Jun 2022 23:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cWBOmuq/uFD0GvmgnMwXmwNwJLSgOJN3gp1rWmCEBdw=;
        b=o+Pgfm4VYkRjIGzmiwlDj8Anc9FWaZpI+Z/rYG9u020MRyd1reT6PBD4oybjb7iErl
         vNkRSzPwNy2kq2qoogMd05DJWEffz6bT7IobsFyfwczXaK695VC6NqPZE6R/oNQ+RKr4
         /8qZ8Ohs1gBZO76q6IoFZvanTJOpeZBc+MekqBmBntqtE6ftMlAWcZt/9k5UBU3lJo2j
         gv6CAzUaLJDGc5HJCtUMhb83j7SlJy613d/k8jAF2WLbNDqaUC7ybS/yWLbzvv4huhrH
         /R9bRRoiOeZh3NqLY0t5xzkCNvxq/CoZVdAPLjT6yRPzdz0TsAUz0DZHLquElQQT1xfC
         Nlkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cWBOmuq/uFD0GvmgnMwXmwNwJLSgOJN3gp1rWmCEBdw=;
        b=Z3GSeT9euW0D9Ogiov4SgY/UuYu+LXYK3qZH8qqeSXR/YrR5sLhyLkjzd2jmJd8tqd
         PRwlgBprCo/iT+DZ4vokFfbQkMdofLccYJRaawKSgDdyIhke2x4ls/Tj4CNz+bkqZkqK
         vrWDpwSe1i9hJNLNKzPNTQQaET1aO1lV9062aZEppwecQ4EBit4wy+F/0LZu2taqqjVx
         WoL+rDBky6MNiQduybG2p3ONrNhGx0bn1yCZpu5P1Eki2nzBV5fX95JiT20W9kd+3b95
         pmvUdm4ZsX3EO4KVGfmHL2uNgfkadeaoPkiCL9mLAhFitTiqKybRWjm5ZA4QsZ3p7CF0
         ksGg==
X-Gm-Message-State: AJIora+5piICwU4dPA5b1fIPi6WRpfTn6QT7gT99bs8dxUu/td0fh3fK
        DxbajnNDuW1VrlIT6XkbBsqV/FDoYbgM73Dh
X-Google-Smtp-Source: AGRyM1vSx+hi/LYGSeDMaymyXtv9rcrCOUGqMGZvn4TzEKXaIcNaKKKoT40Rc6nRaF3QsnN+x73naw==
X-Received: by 2002:a05:6512:308e:b0:479:3986:1d5d with SMTP id z14-20020a056512308e00b0047939861d5dmr7589033lfd.154.1655533149982;
        Fri, 17 Jun 2022 23:19:09 -0700 (PDT)
Received: from [10.0.0.42] (91-159-150-230.elisa-laajakaista.fi. [91.159.150.230])
        by smtp.gmail.com with ESMTPSA id j11-20020a2e800b000000b00258eac98baasm805062ljg.77.2022.06.17.23.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 23:19:09 -0700 (PDT)
Message-ID: <46297969-8d1e-15d5-69da-db9019718c24@gmail.com>
Date:   Sat, 18 Jun 2022 09:26:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3] ASoC: ti: omap-mcbsp: duplicate sysfs error
Content-Language: en-US
To:     David Owens <daowens01@gmail.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     David Owens <dowens@precisionplanting.com>,
        alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220616202645.1645972-1-dowens@precisionplanting.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20220616202645.1645972-1-dowens@precisionplanting.com>
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



On 6/16/22 23:26, David Owens wrote:
> Convert to managed versions of sysfs and clk allocation to simplify
> unbinding and error handling in probe.  Managed sysfs node
> creation specifically addresses the following error seen the second time
> probe is attempted after sdma_pcm_platform_register() previously requested
> probe deferral> 
> sysfs: cannot create duplicate filename '/devices/platform/68000000.ocp/49022000.mcbsp/max_tx_thres'

This does not compile (on linux-next)?

In file included from /home/stens/work/kernel/linux/include/linux/kobject.h:20,
                 from /home/stens/work/kernel/linux/include/linux/module.h:21,
                 from /home/stens/work/kernel/linux/sound/soc/ti/omap-mcbsp-st.c:12:
/home/stens/work/kernel/linux/sound/soc/ti/omap-mcbsp-st.c:299:18: error: 'sidetone_groups' defined but not used [-Werror=unused-variable]
  299 | ATTRIBUTE_GROUPS(sidetone);
      |                  ^~~~~~~~
/home/stens/work/kernel/linux/include/linux/sysfs.h:154:38: note: in definition of macro '__ATTRIBUTE_GROUPS'
  154 | static const struct attribute_group *_name##_groups[] = {       \
      |                                      ^~~~~
/home/stens/work/kernel/linux/sound/soc/ti/omap-mcbsp-st.c:299:1: note: in expansion of macro 'ATTRIBUTE_GROUPS'
  299 | ATTRIBUTE_GROUPS(sidetone);
      | ^~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[4]: *** [/home/stens/work/kernel/linux/scripts/Makefile.build:250: sound/soc/ti/omap-mcbsp-st.o] Error 1
make[4]: *** Waiting for unfinished jobs....
In file included from /home/stens/work/kernel/linux/include/linux/kobject.h:20,
                 from /home/stens/work/kernel/linux/include/linux/module.h:21,
                 from /home/stens/work/kernel/linux/sound/soc/ti/omap-mcbsp.c:12:
/home/stens/work/kernel/linux/sound/soc/ti/omap-mcbsp.c:604:18: error: 'additional_groups' defined but not used [-Werror=unused-variable]
  604 | ATTRIBUTE_GROUPS(additional);
      |                  ^~~~~~~~~~
/home/stens/work/kernel/linux/include/linux/sysfs.h:154:38: note: in definition of macro '__ATTRIBUTE_GROUPS'
  154 | static const struct attribute_group *_name##_groups[] = {       \
      |                                      ^~~~~
/home/stens/work/kernel/linux/sound/soc/ti/omap-mcbsp.c:604:1: note: in expansion of macro 'ATTRIBUTE_GROUPS'
  604 | ATTRIBUTE_GROUPS(additional);
      | ^~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors


> 
> Signed-off-by: David Owens <dowens@precisionplanting.com>
> ---
> 
> Changes in v3:
>  * Whitespace changes only to allow clean applly
> 
> Changes in v2:
>  * Improved error handling
> 
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
>  	&dev_attr_st_taps.attr,
>  	NULL,
>  };
> -
> -static const struct attribute_group sidetone_attr_group = {
> -	.attrs = (struct attribute **)sidetone_attrs,
> -};
> +ATTRIBUTE_GROUPS(sidetone);
>  
>  int omap_mcbsp_st_start(struct omap_mcbsp *mcbsp)
>  {
> @@ -347,7 +344,7 @@ int omap_mcbsp_st_init(struct platform_device *pdev)
>  	if (!st_data)
>  		return -ENOMEM;
>  
> -	st_data->mcbsp_iclk = clk_get(mcbsp->dev, "ick");
> +	st_data->mcbsp_iclk = devm_clk_get(mcbsp->dev, "ick");
>  	if (IS_ERR(st_data->mcbsp_iclk)) {
>  		dev_warn(mcbsp->dev,
>  			 "Failed to get ick, sidetone might be broken\n");
> @@ -359,7 +356,7 @@ int omap_mcbsp_st_init(struct platform_device *pdev)
>  	if (!st_data->io_base_st)
>  		return -ENOMEM;
>  
> -	ret = sysfs_create_group(&mcbsp->dev->kobj, &sidetone_attr_group);
> +	ret = devm_device_add_group(mcbsp->dev, &sidetone_group);
>  	if (ret)
>  		return ret;
>  
> @@ -368,16 +365,6 @@ int omap_mcbsp_st_init(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -void omap_mcbsp_st_cleanup(struct platform_device *pdev)
> -{
> -	struct omap_mcbsp *mcbsp = platform_get_drvdata(pdev);
> -
> -	if (mcbsp->st_data) {
> -		sysfs_remove_group(&mcbsp->dev->kobj, &sidetone_attr_group);
> -		clk_put(mcbsp->st_data->mcbsp_iclk);
> -	}
> -}
> -
>  static int omap_mcbsp_st_info_volsw(struct snd_kcontrol *kcontrol,
>  				    struct snd_ctl_elem_info *uinfo)
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
>  	&dev_attr_max_tx_thres.attr,
>  	&dev_attr_max_rx_thres.attr,
>  	&dev_attr_dma_op_mode.attr,
>  	NULL,
>  };
> -
> -static const struct attribute_group additional_attr_group = {
> -	.attrs = (struct attribute **)additional_attrs,
> -};
> +ATTRIBUTE_GROUPS(additional);
>  
>  /*
>   * McBSP1 and McBSP3 are directly mapped on 1610 and 1510.
> @@ -702,8 +699,7 @@ static int omap_mcbsp_init(struct platform_device *pdev)
>  		mcbsp->max_tx_thres = max_thres(mcbsp) - 0x10;
>  		mcbsp->max_rx_thres = max_thres(mcbsp) - 0x10;
>  
> -		ret = sysfs_create_group(&mcbsp->dev->kobj,
> -					 &additional_attr_group);
> +		ret = devm_device_add_group(mcbsp->dev, &additional_group);
>  		if (ret) {
>  			dev_err(mcbsp->dev,
>  				"Unable to create additional controls\n");
> @@ -711,16 +707,7 @@ static int omap_mcbsp_init(struct platform_device *pdev)
>  		}
>  	}
>  
> -	ret = omap_mcbsp_st_init(pdev);
> -	if (ret)
> -		goto err_st;
> -
> -	return 0;
> -
> -err_st:
> -	if (mcbsp->pdata->buffer_size)
> -		sysfs_remove_group(&mcbsp->dev->kobj, &additional_attr_group);
> -	return ret;
> +	return omap_mcbsp_st_init(pdev);
>  }
>  
>  /*
> @@ -1431,11 +1418,6 @@ static int asoc_mcbsp_remove(struct platform_device *pdev)
>  	if (cpu_latency_qos_request_active(&mcbsp->pm_qos_req))
>  		cpu_latency_qos_remove_request(&mcbsp->pm_qos_req);
>  
> -	if (mcbsp->pdata->buffer_size)
> -		sysfs_remove_group(&mcbsp->dev->kobj, &additional_attr_group);
> -
> -	omap_mcbsp_st_cleanup(pdev);
> -
>  	return 0;
>  }
>  

-- 
Péter
