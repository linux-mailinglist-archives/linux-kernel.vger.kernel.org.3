Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20DE5B0F3E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 23:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiIGViU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 17:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiIGViR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 17:38:17 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A72B7752
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 14:38:16 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id b142so12562917iof.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 14:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=6rBN7kbnMQYf7kObJ9WtbMZk6eRV31FVrweeYnfKHJo=;
        b=GsBUnRMkGO5dIw7tKSqvNBSv8O6uCa4sXvZoRyGF82NiJatez4G6FekKpAO2g5lHhb
         ioBB06C8djv7sgDL5LJVAzCbNMAsD4opDc/GlUhhS/HCAc7i5bP5S29gHxqJXDeIORxA
         wji2yJFZQJdtAeGEO2Y3xGnoGpDil7p7ZMFt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=6rBN7kbnMQYf7kObJ9WtbMZk6eRV31FVrweeYnfKHJo=;
        b=PW4lMpEdzSa+h+QOq0w7dlk0T+yVU0QzusB3A9L15twugT19LPQjYVUMSGvOD0PXJF
         7mj7s8MqTJWmq4XIbbUZ439qRcV16KbHM5bmuH8BesAPbX4aiG8mQbnRqALuRco4fIlj
         plnNz488GUEsNW+euBlcmBOjVHZDyc6OxifzWv620QddE/6Nz5Gu2WlPn54geLZf3fgr
         eCZhFBbh50nGmcUSiWv4KMbbhnrkSOcuPC5h6uc6zAf+EbcJ9HLQFIi1qRJIjArnBI01
         d5y+0pnzXAgRMLcFc/4oOfirKMH6pjs3zWiVFV0gHOGntLDcm+E/pq42mh6QWFg1XbJy
         4UzA==
X-Gm-Message-State: ACgBeo1hziJc0oPdwmnsiF6YXf9EhUybknJthzOa29A0W/tbXj4rTZCz
        T1Az8fsZ/KKArxVjIBP6B2lo3A==
X-Google-Smtp-Source: AA6agR6B39GPaBcn12tQVkSuKNn+ADOzyYixhCwj8vYzrAK2PbdGI8JoV2lX1SICEk5Fv3cheNeRtQ==
X-Received: by 2002:a05:6602:160c:b0:68a:9ed3:e6ff with SMTP id x12-20020a056602160c00b0068a9ed3e6ffmr2641420iow.207.1662586696063;
        Wed, 07 Sep 2022 14:38:16 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id a191-20020a0216c8000000b003583635ab97sm569577jaa.28.2022.09.07.14.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 14:38:15 -0700 (PDT)
Message-ID: <23414197-aa0b-a5fb-a818-35873f7b0482@linuxfoundation.org>
Date:   Wed, 7 Sep 2022 15:38:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [Suggested-by:Shuah Khan Patch V2 1/1] cpufreq: amd-pstate: Add
 explanation for X86_AMD_PSTATE_UT
Content-Language: en-US
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
References: <20220905071418.1518338-1-li.meng@amd.com>
 <20220905071418.1518338-2-li.meng@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20220905071418.1518338-2-li.meng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/22 01:14, Meng Li wrote:
> This kernel module is used for testing. It's safe to say M here.
> It can also be built-in without X86_AMD_PSTATE enabled.
> Currently, only tests for amd-pstate are supported. If X86_AMD_PSTATE
> is set disabled, it can tell the users test can only run on amd-pstate
> driver, please set X86_AMD_PSTATE enabled.
> In the future, comparison tests will be added. It can set amd-pstate
> disabled and set acpi-cpufreq enabled to run test cases, then compare
> the test results.
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> ---
>   drivers/cpufreq/Kconfig.x86                         | 12 +++++++-----
>   tools/testing/selftests/amd-pstate/amd-pstate-ut.sh |  1 +
>   2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> index fd1582716c58..310779b07daf 100644
> --- a/drivers/cpufreq/Kconfig.x86
> +++ b/drivers/cpufreq/Kconfig.x86
> @@ -58,11 +58,13 @@ config X86_AMD_PSTATE_UT
>   	help
>   	  This kernel module is used for testing. It's safe to say M here.
>   
> -	  It can be modprobed even without amd-pstate module.
> -	  When the comparison test is performed, it can load other module
> -	  like acpi-cpufreq to test cases, then compare the test results.
> -	  When only the test for amd-pstate is performed, it can tell the
> -	  users they loaded a wrong module like acpi-cpufreq.
> +	  It can also be built-in without X86_AMD_PSTATE enabled.
> +	  Currently, only tests for amd-pstate are supported. If X86_AMD_PSTATE
> +	  is set disabled, it can tell the users test can only run on amd-pstate
> +	  driver, please set X86_AMD_PSTATE enabled.
> +	  In the future, comparison tests will be added. It can set amd-pstate
> +	  disabled and set acpi-cpufreq enabled to run test cases, then compare
> +	  the test results.
>   
>   config X86_ACPI_CPUFREQ
>   	tristate "ACPI Processor P-States driver"
> diff --git a/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh b/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
> index 273364650285..f8e82d91ffcf 100755
> --- a/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
> +++ b/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
> @@ -32,6 +32,7 @@ fi
>   scaling_driver=$(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_driver)
>   if [ "$scaling_driver" != "amd-pstate" ]; then
>   	echo "$0 # Skipped: Test can only run on amd-pstate driver."
> +	echo "$0 # Please set X86_AMD_PSTATE enabled."
>   	echo "$0 # Current cpufreq scaling drvier is $scaling_driver."
>   	exit $ksft_skip
>   fi

This patch doesn't apply on top of the previous patch series in
linux-kselftest next - please rebase and resend the patch.

thanks,
-- Shuah
