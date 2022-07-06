Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191B5568B92
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 16:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbiGFOox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 10:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbiGFOou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:44:50 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA62B2558E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 07:44:49 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id cl1so22415670wrb.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 07:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=T4FrRUb0DfNNeiIOJ6UoB6T/ZeA/7blEUxoZjvhTMZc=;
        b=oQAX5rVsQMEfWl/PpNXkTAUqdDqBlJ6Vs+R2mVHHOwP/SibVT08ZPWWK7+LvguHYaD
         0E31n0CZdMMdqjm+lAx7yolJeIEdc9Y7PfDf2SM0RsikU+fvZfNbvviKRDnFKYynEoBT
         hHvlG/ircGG7vVBXXSF0kV6PV+EdbzuJWfRHQo4geDccI2jM8JFu0IKH7sEKItd5wG2D
         lNjidUR9RI85y9s/F4w34rZuNamG0eGkfpWvgFXzenMie0D9Uh76qmJ6QsUr3RMDj7G5
         bOCsshBXA3D0kwA3aTfkkiYO/Elv2NscifjQRkCXjtkvLoWy/zKbJcB5k9xxW/Wy6Vp/
         1Pyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T4FrRUb0DfNNeiIOJ6UoB6T/ZeA/7blEUxoZjvhTMZc=;
        b=nopsLzPTLgvf7bTMXttVxt+edgTFd19vz0wOws2qP3OhMJjlNyvgrxQEk0A8jBLIZi
         kvv96Wg65SptFb5L607yfK0qYfUe5Ce30v2z1DzFyAgZT3/27adBGUxcSblLPXSgxxBJ
         SUNXBtKiHMdimc1XZgol6x92d3axcakkwEAeNyOYGW+tTkmLhnMjPFn65iavpYl1yo2P
         zge1ZiYphirFy6NEi1nxvHAJe8iNhBhoEYnp+nSo6Yg6ubkLzniiLzr0JIG3YDG7u8Xm
         4ITxxTvWTLvXh6TP9EXf2KPOFF1Rf/VjHcMv/OYxa6QO11oifD68lQ/eJv/3lBlRf9u2
         2Eng==
X-Gm-Message-State: AJIora/DT8aks60tO+Bnq9D6xmEuQcP5WRA0HMdiJsT90mKwEHrWgX9N
        tt9k8P6br0f9l416qnFma1FsYg==
X-Google-Smtp-Source: AGRyM1tovYUNYZnvA8h+OPMMRHuDEWjSIPryBw5YWMnMz0hfdwdBOtsX7JK8HvvKWEIZxIKJyB31Pg==
X-Received: by 2002:adf:9bc7:0:b0:21d:6adc:fba6 with SMTP id e7-20020adf9bc7000000b0021d6adcfba6mr15660980wrc.328.1657118688211;
        Wed, 06 Jul 2022 07:44:48 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id m9-20020a05600c3b0900b003a04d19dab3sm25158191wms.3.2022.07.06.07.44.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 07:44:47 -0700 (PDT)
Message-ID: <6828f2cc-33cc-fea9-8bc8-e9566f13d26b@linaro.org>
Date:   Wed, 6 Jul 2022 16:44:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] thermal/core: Use clamp() helper in the stepwise
 governor
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
References: <20220629151012.3115773-1-daniel.lezcano@linaro.org>
 <92c86903-354f-0114-a796-64571667a923@linaro.org>
 <CAJZ5v0jPdo5=YWS_ZjLDojtXkpxqejzircN+fGG9y1pnCyH_qg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0jPdo5=YWS_ZjLDojtXkpxqejzircN+fGG9y1pnCyH_qg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2022 14:26, Rafael J. Wysocki wrote:
> On Wed, Jul 6, 2022 at 2:07 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 29/06/2022 17:10, Daniel Lezcano wrote:
>>> The code is actually clampling the next cooling device state using the
>>> lowest and highest states of the thermal instance.
>>>
>>> That code can be replaced by the clamp() macro which does exactly the
>>> same. It results in a simpler routine to read.
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> ---
>>
>> I'll apply this series if nobody has comments
> 
> Sounds good to me.
> 
> Please feel free to add ACKs from me to the patches.
> 

Sure, thanks!



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
