Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BBB5A9C18
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbiIAPrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 11:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbiIAPrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:47:12 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C105B8C01D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 08:47:09 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id l16so9518447ilj.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 08:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=cR8Ir4R4yuVk1/9w3KJlXK3iQYqpW+6/KYRzY74rKiY=;
        b=R3UKzrAlLHtXUKFQIbdjd9rA5YoDFOjI4Qk1Qqo9oBR4ezcyVqEHXgLUMH+qpdsEb8
         HwGF8DOSLPC0IxGL432SE13xG1QLKKNBKqomF4yKq8rITRUrF8AYOCrAajjmNyrLYKa8
         qKn9BM5o57RTGEMubeedPi2ytz3EyhCNOrAlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=cR8Ir4R4yuVk1/9w3KJlXK3iQYqpW+6/KYRzY74rKiY=;
        b=mhP77dRkomvUv4ppksbQ5xwbgZWxxagISHzQdOIJngazRj46upsAz3WWCN9980lE2O
         bENUqhmIc/ICOLGqdS43MErmXk3xsxmoMXHg7sPVcZIVtfO5QsaooTGiIaTOXhnRyAEG
         PJq384O01fWM5g2C0Dw5EIh9UK61k/cEDjrUtTHHm6aBG8rD25aoE3UYvOkR9/60g3TM
         9SzzuBDea+/8JwInVP3c0LgIPmrEGpK3GdBlz766LlRvvqtzdSXHb/wi0Bqn8BNVOp3f
         AdJ8RlCVGV1AP4jGbcy4D1aDhjvhebWsrQjF8+c2kNpqPr3datvSm0+akrd/QqZ44t6Z
         tg9w==
X-Gm-Message-State: ACgBeo1yR/K2njWqmCgoFSkcZLysViunF3wSq+QQohSwKvGtZZzUVuXI
        DfHV9M7DggC6TBmGPfR67evRZQ==
X-Google-Smtp-Source: AA6agR6ETM5ONYFMDYU3TZ91zzC/yTF/90lCTohpaRzj5uHJ0D9aODBPkl06wrbUYPuM9mT4rBeBrQ==
X-Received: by 2002:a05:6e02:1347:b0:2ea:e939:fef1 with SMTP id k7-20020a056e02134700b002eae939fef1mr11598351ilr.114.1662047227677;
        Thu, 01 Sep 2022 08:47:07 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id a5-20020a056e0208a500b002eb9fb2d4e3sm1467428ilt.76.2022.09.01.08.47.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 08:47:07 -0700 (PDT)
Message-ID: <d9b85490-94f2-611f-a228-ea9434a95805@linuxfoundation.org>
Date:   Thu, 1 Sep 2022 09:47:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [Suggested-by:Shuah Khan Patch 1/1] cpufreq: amd-pstate: Add
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
References: <20220901143313.1491951-1-li.meng@amd.com>
 <20220901143313.1491951-2-li.meng@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20220901143313.1491951-2-li.meng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/22 08:33, Meng Li wrote:
> This kernel module is used for testing. It's safe to say M here.
> It can be modprobed even without amd-pstate module.
> When the comparison test is performed, it can load other module
> like acpi-cpufreq to test cases, then compare the test  results.
> When only the test for amd-pstate is performed, it can tell the
> users they loaded a wrong module like acpi-cpufreq.
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> ---
>   drivers/cpufreq/Kconfig.x86 | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> index fdd819069d72..fd1582716c58 100644
> --- a/drivers/cpufreq/Kconfig.x86
> +++ b/drivers/cpufreq/Kconfig.x86
> @@ -58,6 +58,12 @@ config X86_AMD_PSTATE_UT
>   	help
>   	  This kernel module is used for testing. It's safe to say M here.
>   
> +	  It can be modprobed even without amd-pstate module.

It can also be built-in without X86_AMD_PSTATE enabled.
I would rephrase this as:

This config option can be enabled without X86_AMD_PSTATE enabled.

Also change the information below to sat enabled as opposed to module
as both these options can be built-in

> +	  When the comparison test is performed, it can load other module
> +	  like acpi-cpufreq to test cases, then compare the test results.
> +	  When only the test for amd-pstate is performed, it can tell the
> +	  users they loaded a wrong module like acpi-cpufreq.
> +
>   config X86_ACPI_CPUFREQ
>   	tristate "ACPI Processor P-States driver"
>   	depends on ACPI_PROCESSOR

Thank you - In addition to this patch please make change to the test
script as well when it fails detecting that X86_AMD_PSTATE is disabled
to say what user has to do to run the test.

This run-time message will be helpful to users.

thanks,
-- Shuah

  
