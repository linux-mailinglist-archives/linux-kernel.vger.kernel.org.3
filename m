Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA94755C642
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbiF0GLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 02:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbiF0GK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 02:10:59 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD97A5593;
        Sun, 26 Jun 2022 23:10:57 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id bx13so1105645ljb.1;
        Sun, 26 Jun 2022 23:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lgrkBL8uKPFRXzhMJlCIBm/ZO4xPSeydtzyzWtnDYAg=;
        b=oaKve63Gla3R3Amie+i2M84COlBAP07Ru/mUGMxFkbe6+P4K/YIVdEGVpjwdkWKLoy
         xfN+TKd+3OJMy7vLkiLJKDJ+J4F8BrBluyPGFBWmqfs1c1IIw3Il35umx29zgH4fZ0fK
         uhfN7wkqQT82l768rcKaps7yo32niK5QSxRFhYCZv9XneTgC+7cE0Q6ZXz33Jc2PX8by
         CceGfun4JkqT5yJiZK50PBT3VuscitokTmU4ZIYPW+ViC8cKD5V+dBeoyma6DcG3Ljic
         IoOx0UsczpEgKa/FU3+nDQcDpw6A1hVgnC/paQlVgOqCW7w8cTPgmTr8Xf6MyC+W7Dsa
         DVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lgrkBL8uKPFRXzhMJlCIBm/ZO4xPSeydtzyzWtnDYAg=;
        b=MhqrClLklF9x/4TPzKmoRACoKCr8hf9FMlNlx4z5zobsHcmgzHHcH3Xn9tMIMO40KQ
         HIn7BggTcTacD/t6zrhl7D5X8zOD9nFL1bvzp35Q04Vgk9nfC9R9zzNBW2CHrn1mgKX5
         BMtpqFqkVRZEH17W4FZ4Ud0H5cDvO9F3qU1TvLXe5tMzlZM5NxEKHMZInSqGkQriHrZc
         mQWqveAMI3wtD57dHlApVd7Y1hV8kvQYZCmpPMC76RJKghTiaFCE20nxiATHO1KfkvDU
         VtKojyUD86f//cr63t0LWpbJhD6nC3k0cAHUPH8x+n1iExdTFtf2F7cEwf4DiFkPZwVj
         dg/g==
X-Gm-Message-State: AJIora9uxius0IdJwoolpBM1dUP3FZrT+9phPS0AIONpyS5rloYqjR6J
        PL5VBYCfkdRklx8egXh2Y7cwXVqJRFM=
X-Google-Smtp-Source: AGRyM1ufNV51pT9Ff9NQ6oHN2saCEEDtlf1oPK7vfPfGDlYC+jpWBvZbw8cr15Q+/mJIXhebkOSx8A==
X-Received: by 2002:a05:651c:2107:b0:25b:b088:3259 with SMTP id a7-20020a05651c210700b0025bb0883259mr4795763ljq.142.1656310255996;
        Sun, 26 Jun 2022 23:10:55 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.118.164])
        by smtp.googlemail.com with ESMTPSA id a20-20020a05651c031400b0025aa2f6d700sm1109422ljp.62.2022.06.26.23.10.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 23:10:55 -0700 (PDT)
Message-ID: <4a8114f7-4ee6-a9ad-f5be-ceaf64be8a0e@gmail.com>
Date:   Mon, 27 Jun 2022 09:10:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 5/5] OPP: Remove custom OPP helper support
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Keerthy <j-keerthy@ti.com>, Dave Gerlach <d-gerlach@ti.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <cover.1653991004.git.viresh.kumar@linaro.org>
 <2e6ee73dbc8a231377547a8e9497561cadb38166.1653991004.git.viresh.kumar@linaro.org>
 <565ff879-11e4-1ae4-08d8-1237a875ef12@gmail.com>
 <20220627060636.rfpok75zydgcwwo6@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220627060636.rfpok75zydgcwwo6@vireshk-i7>
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

27.06.2022 09:06, Viresh Kumar пишет:
> Hi Dmitry,
> 
> On 25-06-22, 14:42, Dmitry Osipenko wrote:
>> 31.05.2022 13:10, Viresh Kumar пишет:
>>> The only user of the custom helper is migrated to use
>>> config_regulators() interface. Remove the now unused custom OPP helper
>>> support.
>>>
>>> This cleans up _set_opp() and leaves a single code path to be used by
>>> all users.
> 
>> Unfortunately we can't remove the set_opp_helper(). It's terrible that
>> this function is unused by Tegra 3d driver because it should be used.
>>
>> The patch that supposed to use the devm_pm_opp_register_set_opp_helper()
>> [1] was merged a half year ago and just today I noticed that the merged
>> code doesn't have devm_pm_opp_register_set_opp_helper() [2]. I think
>> Thierry edited my patch before applying it, perhaps there was a merge
>> conflict :/ This needs to be fixed now.
> 
> As the commit log above says, we aren't removing the feature, but just
> changing the interface to cnofig_regulators(). That was the only
> special handling the drivers were required to do earlier as well, for
> which the helper interface was added.
> 

Okay, but Tegra 3d driver doesn't need config_regulators(), it needs
customized set_opp() to set clock rate for both 3d engines.
