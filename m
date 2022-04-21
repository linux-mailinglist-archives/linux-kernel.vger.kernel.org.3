Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AED509C54
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387685AbiDUJeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387684AbiDUJeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:34:19 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8427B1A80E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 02:31:26 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso5441393wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 02:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NpVbGkWT0mxI2z+QAaSeB8XReImeuL8/00d31gyn1MM=;
        b=NY9XSGico1KIM7Fqq1EwGMyOn23m25iSrqopxZzF4wmajHZm5QZcwf++tU2uNOffNB
         UeVQd/I1bq4JozXtv6evYNUmcNwYfU/KfNtBG7MDWdWVG2JUYJIFJJHAM0H15lRuEZKa
         R9S3PYlmM9lI7sako+G/6+A4F4ltAbThft8OH+6SbmAVH38hR1PdfkQvBJOGJz5OSt1B
         oRx1boWIrxsw5sr7IU6KGuPsr1cOnaZuvL0KyAF8dmMrwqhEs803oPzeNQB8MlrYOMGT
         cbVboZi+ArEXiI1u2DpaENkXwf7cCecA0XbX8tQTiI38P52z3Gws4A5MFjd9jVeSaXlF
         HoEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NpVbGkWT0mxI2z+QAaSeB8XReImeuL8/00d31gyn1MM=;
        b=msS3eNajVxsN+ZTtLGQJlULSlK+aMu6GonKLHhKGjJwJzh9PIuHHECj9bhj+PU/776
         A+oLVKOW9Rpa3V/1SgZmMK4/kquvxE4ZFtLZAKwrF93dVjNU3m1LJvDSAmI2A3Zs2DE9
         m9x+8qX4Bx4VhlOM79V1wmhLHl+gqo6WFqTuDzCC6CQfw8mdD2ew8mTz0BckWuOJnq3a
         kkU+UO1eMeU7vJ1xWU9jpLY3H6a6NqBTVIgF+G97WPs+l+ozlkOY+/3EuXoI4MEqYBQM
         WA2krxN3+rm+fvwX/gnbywQHjK27UhzR9r77Mbtm8TlJErBDfZy7Upx5W0M+Fl5jsLq1
         Nvrg==
X-Gm-Message-State: AOAM530qD8/W49575xRdsQaSJEJuIHbTMvaTPJviGTrPQsMGRgS/d8Ei
        b6teacHc9QvNbHyGmGDftr44aQ==
X-Google-Smtp-Source: ABdhPJxaoLhiuIhW9HJh8IcFoEychIb2KfG7PIpMWfHCfoHwz8QnTOir1Vnoo5J6Q0KLFVR7ZlZwjw==
X-Received: by 2002:a05:600c:a06:b0:392:a4f2:2097 with SMTP id z6-20020a05600c0a0600b00392a4f22097mr7718250wmp.97.1650533485120;
        Thu, 21 Apr 2022 02:31:25 -0700 (PDT)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id v13-20020a5d4b0d000000b00207a8815063sm1795043wrq.2.2022.04.21.02.31.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 02:31:24 -0700 (PDT)
Message-ID: <8a91822c-d68a-a2d8-6865-3985f2f85c0b@linaro.org>
Date:   Thu, 21 Apr 2022 10:31:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4] ASoC: codecs: wsa881x: add runtime pm support
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, tiwai@suse.com,
        quic_srivasam@quicinc.com
References: <20220228144235.24208-1-srinivas.kandagatla@linaro.org>
 <b1b0a8b9-5fc2-bfe1-dfde-692a0a7ac34a@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <b1b0a8b9-5fc2-bfe1-dfde-692a0a7ac34a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/04/2022 18:59, Pierre-Louis Bossart wrote:
> Hi Srini,
> 
>> +static int __maybe_unused wsa881x_runtime_resume(struct device *dev)
>> +{
>> +	struct sdw_slave *slave = dev_to_sdw_dev(dev);
>> +	struct regmap *regmap = dev_get_regmap(dev, NULL);
>> +	struct wsa881x_priv *wsa881x = dev_get_drvdata(dev);
>> +
>> +	gpiod_direction_output(wsa881x->sd_n, 1);
>> +
>> +	wait_for_completion_timeout(&slave->initialization_complete,
>> +				    msecs_to_jiffies(WSA881X_PROBE_TIMEOUT));
> 
> while I was revisiting pm_runtime support, I also saw that this codec driver is the only one that doesn't check for errors
> 
> max98373-sdw.c: time = wait_for_completion_timeout(&slave->initialization_complete,
> 
> rt1308-sdw.c:   time = wait_for_completion_timeout(&slave->initialization_complete,
> 
> rt1316-sdw.c:   time = wait_for_completion_timeout(&slave->initialization_complete,
> 
> rt5682-sdw.c:   time = wait_for_completion_timeout(&slave->initialization_complete,
> 
> rt5682.c:                       &slave->initialization_complete,
> 
> rt700-sdw.c:    time = wait_for_completion_timeout(&slave->initialization_complete,
> 
> rt711-sdca-sdw.c:       time = wait_for_completion_timeout(&slave->initialization_complete,
> 
> rt711-sdw.c:    time = wait_for_completion_timeout(&slave->initialization_complete,
> 
> rt715-sdw.c:    time = wait_for_completion_timeout(&slave->initialization_complete,
> 
> wsa881x.c:      wait_for_completion_timeout(&slave->initialization_complete,
> 
> 
> If the attachment fails for some reason, you probably want to avoid starting regmap syncs that will fail by construction, no?

Thanks Pierre for auditing the calls.

Yes syncs would fail on reg writes if initialization timeout.
Do you already have fix patch to this or do you want me to send one?

Am also trying to understand what is the expected behavior in the resume 
failure cases, should pm attempt to resume the codec after some time, if 
so returning -ETIMEOUT is the right error code?


--srini
> 
>> +
>> +	regcache_cache_only(regmap, false);
>> +	regcache_sync(regmap);
>> +
>> +	return 0;
>> +}
