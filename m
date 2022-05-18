Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1809E52C406
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 22:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242200AbiERUCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 16:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242110AbiERUCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 16:02:42 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE88B1EE091
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 13:02:40 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id d3so2251153ilr.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 13:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mj28eAA7jFmQsuBi8F2d/CpOSog8MsvJJWpWNUXOAqY=;
        b=c0xg0dXTIMvvVLpM9pxFLIASs/USM8les0/qR9K+D5itQ2NBoW4ldkbunCJnr9ftRh
         YMT2nk4JcRIYdccAZ/hFCsq8zvh+VCtCwc/saB48SkxtDSQ0+Yo6zFqzAuxHa3IqZY5K
         Km4+KzVtjrJb6hTD7I3HrzpSO2+CbIczQlJNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mj28eAA7jFmQsuBi8F2d/CpOSog8MsvJJWpWNUXOAqY=;
        b=gl2QskxB2w1HNnpGC7CXlnjyINAt3hqRjP2m9h7v/9Yjiko+IVVIvyxWN8O1LMljhl
         z0+crfqSE9BbdQ1Z8tlPyWua2pmdUl9Junfg5Zjv0cOr5ok09A9GxNDzgDRPdPIeLjXP
         oqElnVTsO/dtHhvJ9P7d0wH58Tsc9qfw9K6ksSurL+c9CLlYiO3CX7jPLAKQVDpRhNiM
         RPBUlfBEts5I6A3lWKSzY2eoA1tjmqPgeq4R8/1Uc2Nv7VGYNhYqJDSNsP7z8M43YDpW
         METmSNS97cspd3NzvpVpYG4xwDdq8EmtMGA+mZX2NDGiszGocaeUEwaPV1kqlaN1WY2O
         aPAw==
X-Gm-Message-State: AOAM533Kn4Ip7oPy7bKylt7t6kEQ81bT+YIAHIGqVjiyBnI7p+2VYhG4
        eQ7YPvlRZPYH7qGOGK91ZK5ObA==
X-Google-Smtp-Source: ABdhPJyodFs+oGS3ms9XYWcg56utelXkCdpo91qxHRbf//xPU48zYUhJXJt0/3+l9ZeJnz271kd/jA==
X-Received: by 2002:a92:d20b:0:b0:2d1:1588:385e with SMTP id y11-20020a92d20b000000b002d11588385emr756936ily.23.1652904160177;
        Wed, 18 May 2022 13:02:40 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id e17-20020a022111000000b0032e2c859d8esm110971jaa.138.2022.05.18.13.02.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 13:02:39 -0700 (PDT)
Subject: Re: [PATCH V5 0/3] Add unit test module for AMD P-State driver
To:     Huang Rui <ray.huang@amd.com>
Cc:     "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220505022913.329259-1-li.meng@amd.com>
 <YnNxlzRW2NGCx5dO@amd.com>
 <615adab4-515c-7d61-5662-bd342b759d6d@linuxfoundation.org>
 <27434868-1d0f-4493-3265-bea4e1dc8494@linuxfoundation.org>
 <YoSB6JRplJR79Beu@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <bafe3aab-166d-7d9f-8909-8ffa41579a47@linuxfoundation.org>
Date:   Wed, 18 May 2022 14:02:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YoSB6JRplJR79Beu@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/22 11:19 PM, Huang Rui wrote:
> On Wed, May 18, 2022 at 04:03:05AM +0800, Shuah Khan wrote:

>> I reviewed the patches and the test driver amd-pstate-ut doesn't belong under
>> selftests. I would recommend the following approach:
>>
>> - add this test driver under drivers/cpufreq
>>
>> - KUnit is a better fit for this unit test driver unless you want
>>     to be able to run this without KUnit configured
>>
>> - add the test script under selftests - the script then can load the
>>     test driver and run tests and unload the driver.
>>
> 
> Thanks Shuah. We would like to introduce more CPU benchmark testing based
> the amd-pstate-ut next step, it may not be all the stuff in the kernel
> module. E.X.  use the script to trigger the tbench, gitsource, kernbench,
> netperf, speedometer, and etc. testing and monitor the cpu frequency and
> performance goals change, power consumption at runtime. Can the KUnit +
> Kselftests work more straight forward in user scenario?
> 

I am not sure if I understand your question. Also I am not sure if understand
the scope of the testing you are intending to do using amd-pstate-ut.

tbench, gitsource etc. are external tests (meaning not in kernel repo). Do these
tests depend on amd-pstate-ut?

It would be helpful to understand the scope first. What exactly will amd-pstate-ut
used for? Based on the patch series it looked like:

-- amd-pstate-ut has unit test code which will be triggered from kselftest

This is perfectly fine. The driver can reside under drivers/cpufreq and a test.sh
can reside under selftests. It can just use kselftest framework.

Based on what you are saying. kselftest might be a good choice.

thanks,
-- Shuah

