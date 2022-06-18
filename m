Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C86C550332
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 08:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbiFRG3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 02:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiFRG3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 02:29:12 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4302542A1E;
        Fri, 17 Jun 2022 23:29:11 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id e4so6784886ljl.1;
        Fri, 17 Jun 2022 23:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=cPy9joT+1+3PYEmZjTwlcma7C0AAkZHDJUmmbBmbHyc=;
        b=FLM1eSYbQTSyBh329bA9vE5dZMnRtC42op9RbyFwzmqLigHVXaUACAzDpYl+6zZMze
         O8JCmChog4CCu9Gg0qtQCPKmfJL+8TShMfKfuISl4C4PELrrHfPHV8CzfGZsjoZYdzTc
         CBp/lHjO3RTmF1K9PGGlI0b6Z1ZjsaaUcxauIVIFqsc/lwxwl5X29XiZgt9+AGXdUxTW
         L/ycsoalA/uWRVsVNx0gdCUcdXTHievUsEhz/YOCyS+aYW5936ABqCARncQsJy1VtXXQ
         YgRfH2ilscH5DApM/gT5B5i2mzQi/mJA/IapH5KYrQvS8g7qYfjjjK5OXNIKNeyZOZC0
         pVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=cPy9joT+1+3PYEmZjTwlcma7C0AAkZHDJUmmbBmbHyc=;
        b=DGNN0lH4ZBtdBLt1RGvUHgaojzP14WM8u2YWtwp3B8HZkB0fpT8KeAl9rHXkWU7cYG
         YEF52Y3fZWSG6iieX7KIs6JPb+WUn/6U/x7zWa/ipafvkFCY0K8JNaSj0VzfwfMMe66q
         w+/TN0BXzD4MQ0x03i3pageiZHMRv1kHAlnMnPpr53GGChOzD2ZVe0aAgiFPMVfp0m2B
         0rrOaTO2Qx4tU66lE3xHBOsalbBRD78x6sptdxrKKHN4s70QGYE4gJU7dX2hwMO31bT+
         0MCWIdgsoBwy9p+SMXAGfH/B1bsjRxpARYuFk0y0Hvx/fNvC7ETSYM9qDv+XILtUYrrS
         83Vg==
X-Gm-Message-State: AJIora+4MIdD8cGimVdFBy8uJ18z6CgD4mJ3po05UZrx6AI3Snrgkl+J
        4okqO8+DnP6GnAqzMPfK1E4=
X-Google-Smtp-Source: AGRyM1vgHh/O2TVGDtcibl1DHHY96rEcQTJcmusqbmImxj7+DvQWlTxphMIwqQYqQH8PBSMahs3b2w==
X-Received: by 2002:a2e:3315:0:b0:258:dfff:e252 with SMTP id d21-20020a2e3315000000b00258dfffe252mr6701205ljc.141.1655533749354;
        Fri, 17 Jun 2022 23:29:09 -0700 (PDT)
Received: from [10.0.0.42] (91-159-150-230.elisa-laajakaista.fi. [91.159.150.230])
        by smtp.gmail.com with ESMTPSA id h4-20020a05651c124400b00253c8dfc4e4sm787632ljh.101.2022.06.17.23.29.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 23:29:08 -0700 (PDT)
Message-ID: <6506993b-40ac-883c-71e1-707f2e1f647e@gmail.com>
Date:   Sat, 18 Jun 2022 09:36:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3] ASoC: ti: omap-mcbsp: duplicate sysfs error
Content-Language: en-US
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
To:     David Owens <daowens01@gmail.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     David Owens <dowens@precisionplanting.com>,
        alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220616202645.1645972-1-dowens@precisionplanting.com>
 <46297969-8d1e-15d5-69da-db9019718c24@gmail.com>
In-Reply-To: <46297969-8d1e-15d5-69da-db9019718c24@gmail.com>
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



On 6/18/22 09:26, Péter Ujfalusi wrote:
> 
> 
> On 6/16/22 23:26, David Owens wrote:
>> Convert to managed versions of sysfs and clk allocation to simplify
>> unbinding and error handling in probe.  Managed sysfs node
>> creation specifically addresses the following error seen the second time
>> probe is attempted after sdma_pcm_platform_register() previously requested
>> probe deferral> 
>> sysfs: cannot create duplicate filename '/devices/platform/68000000.ocp/49022000.mcbsp/max_tx_thres'
> 
> This does not compile (on linux-next)?

The foillowing diff is needed:

diff --git a/sound/soc/ti/omap-mcbsp-st.c b/sound/soc/ti/omap-mcbsp-st.c
index 402a57a502e6..bae4f67165c1 100644
--- a/sound/soc/ti/omap-mcbsp-st.c
+++ b/sound/soc/ti/omap-mcbsp-st.c
@@ -296,7 +296,10 @@ static struct attribute *sidetone_attrs[] = {
 	&dev_attr_st_taps.attr,
 	NULL,
 };
-ATTRIBUTE_GROUPS(sidetone);
+
+static const struct attribute_group sidetone_group = {
+	.attrs = sidetone_attrs,
+};

 int omap_mcbsp_st_start(struct omap_mcbsp *mcbsp)
 {
diff --git a/sound/soc/ti/omap-mcbsp.c b/sound/soc/ti/omap-mcbsp.c
index 176abe4271e9..6fcd860778e9 100644
--- a/sound/soc/ti/omap-mcbsp.c
+++ b/sound/soc/ti/omap-mcbsp.c
@@ -601,7 +601,10 @@ static struct attribute *additional_attrs[] = {
 	&dev_attr_dma_op_mode.attr,
 	NULL,
 };
-ATTRIBUTE_GROUPS(additional);
+
+static const struct attribute_group additional_group = {
+	.attrs = additional_attrs,
+};

 /*
  * McBSP1 and McBSP3 are directly mapped on 1610 and 1510.




> 
> In file included from /home/stens/work/kernel/linux/include/linux/kobject.h:20,
>                  from /home/stens/work/kernel/linux/include/linux/module.h:21,
>                  from /home/stens/work/kernel/linux/sound/soc/ti/omap-mcbsp-st.c:12:
> /home/stens/work/kernel/linux/sound/soc/ti/omap-mcbsp-st.c:299:18: error: 'sidetone_groups' defined but not used [-Werror=unused-variable]
>   299 | ATTRIBUTE_GROUPS(sidetone);
>       |                  ^~~~~~~~
> /home/stens/work/kernel/linux/include/linux/sysfs.h:154:38: note: in definition of macro '__ATTRIBUTE_GROUPS'
>   154 | static const struct attribute_group *_name##_groups[] = {       \
>       |                                      ^~~~~
> /home/stens/work/kernel/linux/sound/soc/ti/omap-mcbsp-st.c:299:1: note: in expansion of macro 'ATTRIBUTE_GROUPS'
>   299 | ATTRIBUTE_GROUPS(sidetone);
>       | ^~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[4]: *** [/home/stens/work/kernel/linux/scripts/Makefile.build:250: sound/soc/ti/omap-mcbsp-st.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
> In file included from /home/stens/work/kernel/linux/include/linux/kobject.h:20,
>                  from /home/stens/work/kernel/linux/include/linux/module.h:21,
>                  from /home/stens/work/kernel/linux/sound/soc/ti/omap-mcbsp.c:12:
> /home/stens/work/kernel/linux/sound/soc/ti/omap-mcbsp.c:604:18: error: 'additional_groups' defined but not used [-Werror=unused-variable]
>   604 | ATTRIBUTE_GROUPS(additional);
>       |                  ^~~~~~~~~~
> /home/stens/work/kernel/linux/include/linux/sysfs.h:154:38: note: in definition of macro '__ATTRIBUTE_GROUPS'
>   154 | static const struct attribute_group *_name##_groups[] = {       \
>       |                                      ^~~~~
> /home/stens/work/kernel/linux/sound/soc/ti/omap-mcbsp.c:604:1: note: in expansion of macro 'ATTRIBUTE_GROUPS'
>   604 | ATTRIBUTE_GROUPS(additional);
>       | ^~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> 
>>
>> Signed-off-by: David Owens <dowens@precisionplanting.com>
>> ---
>>
>> Changes in v3:
>>  * Whitespace changes only to allow clean applly
>>
>> Changes in v2:
>>  * Improved error handling
>>
>> ---
>>  sound/soc/ti/omap-mcbsp-priv.h |  2 --
>>  sound/soc/ti/omap-mcbsp-st.c   | 21 ++++-----------------
>>  sound/soc/ti/omap-mcbsp.c      | 26 ++++----------------------
>>  3 files changed, 8 insertions(+), 41 deletions(-)
>>
>> diff --git a/sound/soc/ti/omap-mcbsp-priv.h b/sound/soc/ti/omap-mcbsp-priv.h
>> index 7865cda4bf0a..da519ea1f303 100644
>> --- a/sound/soc/ti/omap-mcbsp-priv.h
>> +++ b/sound/soc/ti/omap-mcbsp-priv.h
>> @@ -316,8 +316,6 @@ static inline int omap_mcbsp_read(struct omap_mcbsp *mcbsp, u16 reg,
>>  
>>  /* Sidetone specific API */
>>  int omap_mcbsp_st_init(struct platform_device *pdev);
>> -void omap_mcbsp_st_cleanup(struct platform_device *pdev);
>> -
>>  int omap_mcbsp_st_start(struct omap_mcbsp *mcbsp);
>>  int omap_mcbsp_st_stop(struct omap_mcbsp *mcbsp);
>>  
>> diff --git a/sound/soc/ti/omap-mcbsp-st.c b/sound/soc/ti/omap-mcbsp-st.c
>> index 0bc7d26c660a..402a57a502e6 100644
>> --- a/sound/soc/ti/omap-mcbsp-st.c
>> +++ b/sound/soc/ti/omap-mcbsp-st.c
>> @@ -292,14 +292,11 @@ static ssize_t st_taps_store(struct device *dev,
>>  
>>  static DEVICE_ATTR_RW(st_taps);
>>  
>> -static const struct attribute *sidetone_attrs[] = {
>> +static struct attribute *sidetone_attrs[] = {
>>  	&dev_attr_st_taps.attr,
>>  	NULL,
>>  };
>> -
>> -static const struct attribute_group sidetone_attr_group = {
>> -	.attrs = (struct attribute **)sidetone_attrs,
>> -};
>> +ATTRIBUTE_GROUPS(sidetone);
>>  
>>  int omap_mcbsp_st_start(struct omap_mcbsp *mcbsp)
>>  {
>> @@ -347,7 +344,7 @@ int omap_mcbsp_st_init(struct platform_device *pdev)
>>  	if (!st_data)
>>  		return -ENOMEM;
>>  
>> -	st_data->mcbsp_iclk = clk_get(mcbsp->dev, "ick");
>> +	st_data->mcbsp_iclk = devm_clk_get(mcbsp->dev, "ick");
>>  	if (IS_ERR(st_data->mcbsp_iclk)) {
>>  		dev_warn(mcbsp->dev,
>>  			 "Failed to get ick, sidetone might be broken\n");
>> @@ -359,7 +356,7 @@ int omap_mcbsp_st_init(struct platform_device *pdev)
>>  	if (!st_data->io_base_st)
>>  		return -ENOMEM;
>>  
>> -	ret = sysfs_create_group(&mcbsp->dev->kobj, &sidetone_attr_group);
>> +	ret = devm_device_add_group(mcbsp->dev, &sidetone_group);
>>  	if (ret)
>>  		return ret;
>>  
>> @@ -368,16 +365,6 @@ int omap_mcbsp_st_init(struct platform_device *pdev)
>>  	return 0;
>>  }
>>  
>> -void omap_mcbsp_st_cleanup(struct platform_device *pdev)
>> -{
>> -	struct omap_mcbsp *mcbsp = platform_get_drvdata(pdev);
>> -
>> -	if (mcbsp->st_data) {
>> -		sysfs_remove_group(&mcbsp->dev->kobj, &sidetone_attr_group);
>> -		clk_put(mcbsp->st_data->mcbsp_iclk);
>> -	}
>> -}
>> -
>>  static int omap_mcbsp_st_info_volsw(struct snd_kcontrol *kcontrol,
>>  				    struct snd_ctl_elem_info *uinfo)
>>  {
>> diff --git a/sound/soc/ti/omap-mcbsp.c b/sound/soc/ti/omap-mcbsp.c
>> index 4479d74f0a45..395493a2d965 100644
>> --- a/sound/soc/ti/omap-mcbsp.c
>> +++ b/sound/soc/ti/omap-mcbsp.c
>> @@ -595,16 +595,13 @@ static ssize_t dma_op_mode_store(struct device *dev,
>>  
>>  static DEVICE_ATTR_RW(dma_op_mode);
>>  
>> -static const struct attribute *additional_attrs[] = {
>> +static struct attribute *additional_attrs[] = {
>>  	&dev_attr_max_tx_thres.attr,
>>  	&dev_attr_max_rx_thres.attr,
>>  	&dev_attr_dma_op_mode.attr,
>>  	NULL,
>>  };
>> -
>> -static const struct attribute_group additional_attr_group = {
>> -	.attrs = (struct attribute **)additional_attrs,
>> -};
>> +ATTRIBUTE_GROUPS(additional);
>>  
>>  /*
>>   * McBSP1 and McBSP3 are directly mapped on 1610 and 1510.
>> @@ -702,8 +699,7 @@ static int omap_mcbsp_init(struct platform_device *pdev)
>>  		mcbsp->max_tx_thres = max_thres(mcbsp) - 0x10;
>>  		mcbsp->max_rx_thres = max_thres(mcbsp) - 0x10;
>>  
>> -		ret = sysfs_create_group(&mcbsp->dev->kobj,
>> -					 &additional_attr_group);
>> +		ret = devm_device_add_group(mcbsp->dev, &additional_group);
>>  		if (ret) {
>>  			dev_err(mcbsp->dev,
>>  				"Unable to create additional controls\n");
>> @@ -711,16 +707,7 @@ static int omap_mcbsp_init(struct platform_device *pdev)
>>  		}
>>  	}
>>  
>> -	ret = omap_mcbsp_st_init(pdev);
>> -	if (ret)
>> -		goto err_st;
>> -
>> -	return 0;
>> -
>> -err_st:
>> -	if (mcbsp->pdata->buffer_size)
>> -		sysfs_remove_group(&mcbsp->dev->kobj, &additional_attr_group);
>> -	return ret;
>> +	return omap_mcbsp_st_init(pdev);
>>  }
>>  
>>  /*
>> @@ -1431,11 +1418,6 @@ static int asoc_mcbsp_remove(struct platform_device *pdev)
>>  	if (cpu_latency_qos_request_active(&mcbsp->pm_qos_req))
>>  		cpu_latency_qos_remove_request(&mcbsp->pm_qos_req);
>>  
>> -	if (mcbsp->pdata->buffer_size)
>> -		sysfs_remove_group(&mcbsp->dev->kobj, &additional_attr_group);
>> -
>> -	omap_mcbsp_st_cleanup(pdev);
>> -
>>  	return 0;
>>  }
>>  
> 

-- 
Péter
