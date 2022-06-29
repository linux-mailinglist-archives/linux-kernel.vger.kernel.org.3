Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E95560571
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbiF2QJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbiF2QJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:09:33 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0591E240B5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 09:09:32 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id i205-20020a1c3bd6000000b003a03567d5e9so497521wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 09:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8I4xTuCAIj7p4jZTE7jxL30+O2A4Baj92YRuLJCD+2E=;
        b=kws0GL/xKMY13kVKn2OsJYtYy4FcSDfeIzROdP+wdqZkq3V9xeg2Uo5us2nn0FSe8Y
         civ8MIuPYUDEnjtQtD4+196WxZDhMcubB8zE42ZeZ4ohhZO3EzQvmfEquY6K+hyeXQsx
         hlYM0vK8Vp5pHQC/RXWRLUqKWky4TNHBrUlBMc9ty8YkjdLq9bz3HmbJ80l9WzMW/c1Y
         fP8DO/xp73Ov60anXHeO8shQa9Jz3CSV33sd5bha+Dwjat1znxuivO/pDKKeP+AXR6yo
         6HkErcYGeKZ2xjA0demS9oyMYHku3Rdj2QFhaTz70Arf80zeZ5qPYnIRLPr7mOCdlI4E
         HE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8I4xTuCAIj7p4jZTE7jxL30+O2A4Baj92YRuLJCD+2E=;
        b=GtzqiZ9/H0cAM9m/9sbLiiKaqu9VcG+90prgXSFuFFun2XGGylEVeYd+xQ1Ze6jyg1
         T60zqY+1soHOhBXVMI9CTterer3z6Z3aWcJjo9hyGaJp00PDizhT1/HMKBE0YpcUS/Jc
         zpzbTylSXvhU9zUpsGhdEr1eFQhImCe9P8MTh/1wcd3aTcs20xfZJGi3ywBoHz2Rp5Hf
         VsGrjkgSYKsQZtwTfckQunUfudtAbhEQLQIQ8B/F3xyx1sPFgM/yudxaKVkExxfcC371
         Sq2ZM16fZdhTR7cUPonogorcypUMgJhlp+9smqaine1Du411I9kDFt9bQNDgBus/gpcP
         vlXA==
X-Gm-Message-State: AJIora8scu/R9xBI3rU6DLs5ssNdzV8F8OA8UtyZrB1V9BMu4mehZXP7
        iRmWbVibiv1gLXWp9pQru/fWEQ==
X-Google-Smtp-Source: AGRyM1uyWk+rVr8oXOX4c4yI0mrtAqKSViVpKIZUxTVc4c/q+bxK6VZgfa6KJYmZLwBHnyQpgFgHHQ==
X-Received: by 2002:a7b:cc10:0:b0:3a0:7d75:b576 with SMTP id f16-20020a7bcc10000000b003a07d75b576mr4600543wmh.92.1656518970550;
        Wed, 29 Jun 2022 09:09:30 -0700 (PDT)
Received: from [192.168.86.238] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id r185-20020a1c2bc2000000b003a0484c069bsm4067034wmr.41.2022.06.29.09.09.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 09:09:29 -0700 (PDT)
Message-ID: <c12b67b3-2024-2133-9fdb-3d90410a4501@linaro.org>
Date:   Wed, 29 Jun 2022 17:09:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/4] ASoC: codecs: add wsa883x amplifier support
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, tiwai@suse.com
References: <20220629090644.67982-1-srinivas.kandagatla@linaro.org>
 <20220629090644.67982-3-srinivas.kandagatla@linaro.org>
 <352fac7e-597c-84af-d33b-bdff0e2acdb6@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <352fac7e-597c-84af-d33b-bdff0e2acdb6@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Pierre,

On 29/06/2022 16:03, Pierre-Louis Bossart wrote:
> 
>> +/* 4 ports */
>> +static struct sdw_dpn_prop wsa_sink_dpn_prop[WSA883X_MAX_SWR_PORTS] = {
>> +	{
>> +		/* DAC */
>> +		.num = 1,
>> +		.type = SDW_DPN_SIMPLE,
>> +		.min_ch = 1,
>> +		.max_ch = 1,
>> +		.simple_ch_prep_sm = true,
>> +		.read_only_wordlength = true,
>> +	}, {
> 
> nit-pick: it's unusual to see such opening brackets for structure
> initialization, usually there are on a new line.
> 
>> +		/* COMP */
>> +		.num = 2,
>> +		.type = SDW_DPN_SIMPLE,
>> +		.min_ch = 1,
>> +		.max_ch = 1,
>> +		.simple_ch_prep_sm = true,
>> +		.read_only_wordlength = true,
>> +	}, {
>> +		/* BOOST */
>> +		.num = 3,
>> +		.type = SDW_DPN_SIMPLE,
>> +		.min_ch = 1,
>> +		.max_ch = 1,
>> +		.simple_ch_prep_sm = true,
>> +		.read_only_wordlength = true,
>> +	}, {
>> +		/* VISENSE */
>> +		.num = 4,
>> +		.type = SDW_DPN_SIMPLE,
>> +		.min_ch = 1,
>> +		.max_ch = 1,
>> +		.simple_ch_prep_sm = true,
>> +		.read_only_wordlength = true,
>> +	}
>> +};
> 
>> +static int wsa883x_update_status(struct sdw_slave *slave,
>> +				 enum sdw_slave_status status)
>> +{
>> +	struct wsa883x_priv *wsa883x = dev_get_drvdata(&slave->dev);
>> +
>> +	if (status == SDW_SLAVE_ATTACHED && slave->dev_num > 0)
> 
> do you actually need to test if slave->dev_num is > 0?
> 
Few years back I think it was you who asked me to add this check.. :-)

https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2073074.html


> if I look at drivers/soundwire/bus.c, update_status cannot really be
> invoked with dev_num == 0.
> 
>> +		wsa883x_init(wsa883x);
>> +
>> +	return 0;
>> +}
>> +
> 
>> +static int __maybe_unused wsa883x_runtime_resume(struct device *dev)
>> +{
>> +	struct sdw_slave *slave = dev_to_sdw_dev(dev);
>> +	struct regmap *regmap = dev_get_regmap(dev, NULL);
>> +	struct wsa883x_priv *wsa883x = dev_get_drvdata(dev);
>> +	int ret;
>> +
>> +	ret = regulator_enable(wsa883x->vdd);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to enable vdd regulator (%d)\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	gpiod_direction_output(wsa883x->sd_n, 1);
>> +
>> +	wait_for_completion_timeout(&slave->initialization_complete,
>> +				    msecs_to_jiffies(WSA883X_PROBE_TIMEOUT));
> 
> check for success? You don't want to enable regmap sync below if the
> device never successfully attached and initialized.

Yes, that might be possible, I can spin a fix for this.

thanks,
--srini
> 
>> +
>> +	usleep_range(20000, 20010);
>> +	regcache_cache_only(regmap, false);
>> +	regcache_sync(regmap);
>> +
>> +	return 0;
>> +}
> 
