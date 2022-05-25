Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C4A5340FF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 18:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245363AbiEYQFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 12:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245374AbiEYQFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 12:05:15 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2B5B41D7
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 09:05:14 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id j6so738359ilk.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 09:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WniLzB5SiRVqHzMZUCEbBv/kb3dmETbEX6p4Sn4Jrug=;
        b=cTa6aTwIXDVE5TRe6Qutp+ruroH5hAjEPMipG9ObxavNkGtrvXeGz3CHRE0RiRNypT
         g5bcFQj1rQo7GETNNu6Oi+qLi3ZhffzsRFLW51cfiG2dJ9Zwf/ywTwzXPQuirzfi0+tP
         Oq2G6ZHlT7xd/IIPTAuUhY62o7d70tqnsEvDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WniLzB5SiRVqHzMZUCEbBv/kb3dmETbEX6p4Sn4Jrug=;
        b=HHuqotxHEacvX8ZMBVNZauQnrdfKI6PuJB6Jmintg+RZZkJarVbCPcrIHQHkju99Zx
         gvAQu3FMmUC5PQBQGbtiJQzXMfSy0oQ7pyIo+epacCz278eSxQmjnqMlTO/GQr0YijHM
         ZxNA6ykvHXLQdQojCcwWF7jvSMp29dlFB1SDxAvzvPjNLYJVfeEjDq/N2wKiaetjSLOM
         ZrBpBWeuC2pc7arXMJ0VvKOWjLm0pqnDQ9vyrERw/caE54us6DJ/GTdmWCdPLqlAllBi
         ixOdHseJ2WBZwSwAc8F/NHIMbTog6WfyYm9Em2zBRENpmFXZ87i+kWcSzJHjVdmfEbwg
         esDA==
X-Gm-Message-State: AOAM530UzaPNkVBaZVhka793Az+Sf7VYDYbuimkn040KxnKnGE13IsZB
        5hEZJ9E43huXPSCFMzGJ03Aepw==
X-Google-Smtp-Source: ABdhPJxPVFqJ+rxPJ/rSNc6KMtA5495jM0Ok6y/rfEw/mHFvhZlHY7xyDacOZBhSkKetr3O3vJ5dcA==
X-Received: by 2002:a92:ca0d:0:b0:2d1:aa92:4da6 with SMTP id j13-20020a92ca0d000000b002d1aa924da6mr8792361ils.107.1653494713626;
        Wed, 25 May 2022 09:05:13 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id c17-20020a023b11000000b0032e6f0d3796sm4209055jaa.145.2022.05.25.09.05.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 09:05:13 -0700 (PDT)
Subject: Re: [PATCH V7 2/4] cpufreq: amd-pstate: Add test module for
 amd-pstate driver
To:     Meng Li <li.meng@amd.com>, Huang Rui <ray.huang@amd.com>,
        linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220522115423.1147282-1-li.meng@amd.com>
 <20220522115423.1147282-3-li.meng@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <6e3cdf37-299a-98df-1143-c3392e9acec0@linuxfoundation.org>
Date:   Wed, 25 May 2022 10:05:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220522115423.1147282-3-li.meng@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/22 5:54 AM, Meng Li wrote:
> Add amd-pstate-ut module, which is conceptually out-of-tree module

I didn't notice this before. Let's get rid of "out-of-tree" workding.

> and provides ways for selftests/amd-pstate driver to test various
> kernel module-related functionality. This module will be expected by
> some of selftests to be present and loaded.
> 

What does "various kernel module-related functionality" mean. Can we
rephrase this to say "this module is used by kselftest to unit test
amd-pstate functionality" ?

> Signed-off-by: Meng Li <li.meng@amd.com>
> Acked-by: Huang Rui <ray.huang@amd.com>
> ---

[snip]

> +
> +module_init(amd_pstate_ut_init);
> +module_exit(amd_pstate_ut_exit);
> +
> +MODULE_AUTHOR("Meng Li <li.meng@amd.com>");
> +MODULE_DESCRIPTION("Kselftest for AMD P-state driver");

Change this to "AMD P-state driver Test module"

Having Kselftest in the name is confusing. It is a test driver
that kselftest amd_pstate_test depends on.

> +MODULE_LICENSE("GPL");
> 

With these above changes:

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
