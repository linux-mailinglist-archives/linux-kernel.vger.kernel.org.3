Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A9D5A0386
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 23:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239169AbiHXV63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 17:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbiHXV6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 17:58:23 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8C3760FB
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 14:58:21 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id d6so8173318ilg.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 14:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc;
        bh=QNfa8mrO6DZZ6utajVZARmp8HfWOuCIyTAsumuknhTc=;
        b=LUBCvs7w/yHqEsl/GjKnkBwqndy5B3jZLLs9Y8lhgX7wLd8xQgn/W01gQ/Y7x01gzy
         O6CunAS43oZIZnZa60MvdvR8xuePCEL0Xjt6zQW6ZUAaVplf2X4QTD6GxZvVj/UC5v9A
         ICMPXWVupvv9Eaw9O0iiL3ucR0hXV6qq/8Jtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=QNfa8mrO6DZZ6utajVZARmp8HfWOuCIyTAsumuknhTc=;
        b=DoiIu45eAJ2Qm3NIjb3/aR0ioW9Ba84NFW26bc7uyeBHlGziISUPECVDZEwPSb3jSJ
         qFod2duB9Ni0LbfxjqvWhIX+MmYDzo5CMnMV/sBVa72CVg+rZGjAxZbkTLXEqx5fQDpR
         jwc0Yw52ZHSl4wtGKuWWaBO887bSyEyjOEmLWfVSCU/62lwbGCwQCK+q8XVa+mihx/4/
         fpLPdVwMB8BlUCaYrtvT69AO1WpnN0b6VCP3PUFLlHgvSEP5lVawS1RgYk/7afPyhwV4
         3IhYH8IUcIdjVa1D1TtcuInVkXJpygAAMGx9eQhuTPyexTz8zYHmxqFQz8biIDNosw/H
         2Izw==
X-Gm-Message-State: ACgBeo1aWWUeFbRBvTwlUQNfT+82P6GD2ScUsFi0iqYxswptYCyuNP67
        Yc/JFuvH8f8cA9frOvI5gT6XdA==
X-Google-Smtp-Source: AA6agR7tilWgf4Oq1aJhpWSJkjNUW6mJT+raD34bYCMS63TyofuRVwlHmrURT8RlDpazGbb4tsO30g==
X-Received: by 2002:a05:6e02:2187:b0:2e4:45e3:8dfb with SMTP id j7-20020a056e02218700b002e445e38dfbmr429660ila.210.1661378301018;
        Wed, 24 Aug 2022 14:58:21 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id y17-20020a056602179100b0067ba7abc4cesm267180iox.50.2022.08.24.14.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 14:58:20 -0700 (PDT)
Subject: Re: [RESEND PATCH 0/4] Add unit test module for AMD P-State driver
To:     Meng Li <li.meng@amd.com>, Huang Rui <ray.huang@amd.com>,
        linux-pm@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220817034630.1172065-1-li.meng@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c5b18849-1856-e0f0-4112-fdbd0b436bef@linuxfoundation.org>
Date:   Wed, 24 Aug 2022 15:58:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220817034630.1172065-1-li.meng@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/22 9:46 PM, Meng Li wrote:
> Hi all:
> 
> According to shuah's review comments, update the patches based on
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=next
> 
> AMD P-State unit test(amd-pstate-ut) is a kernel module for testing the
> functions of amd-pstate driver.
> It could import as a module to launch some test tasks.
> 1) It can help all users to verify their processor support (SBIOS/
> Firmware or Hardware).
> 2) Kernel can have a basic function test to avoid the kernel regression
> during the update.
> 3) We can introduce more functional or performance tests to align the
> together, it will benefit power and performance scale optimization.
> 
> We upstream out AMD P-state driver into Linux kernel and use this unit
> test module to verify the required conditions and basic functions of
> amd-pstate before integration test.
> 
> We use test module in the kselftest frameworks to implement it.
> We create amd-pstate-ut module and tie it into kselftest.
> 
> For example: The test case aput_acpi_cpc is used to check whether the
> _CPC object is exist in SBIOS.
> The amd-pstate initialization will fail if the _CPC in ACPI SBIOS is not
> existed at the detected processor, so it is a necessary condition.
> 
> At present, it only implements the basic framework and some simple test
> cases.
> 
> TODO : 1) we will add more test cases to improve the depth and coverage
> of the test. E.X. use the script to trigger the tbench, gitsource,
> kernbench, netperf, speedometer, and etc. testing and monitor the cpu
> frequency and performance goals change, power consumption at runtime.
> 
> Please check the documentation amd-pstate.rst for details of the test
> steps.
> 
> See patch series in below git repo:
> V1: https://lore.kernel.org/linux-pm/20220323071502.2674156-1-li.meng@amd.com/
> V2: https://lore.kernel.org/lkml/20220413090510.4039589-1-li.meng@amd.com/
> V3: https://lore.kernel.org/lkml/20220421074152.599419-1-li.meng@amd.com/
> V4: https://lore.kernel.org/lkml/20220427135315.3447550-1-li.meng@amd.com/
> V5: https://lore.kernel.org/lkml/20220505022913.329259-1-li.meng@amd.com/
> V6: https://lore.kernel.org/lkml/20220519134737.359290-1-li.meng@amd.com/
> V7: https://lore.kernel.org/lkml/20220522115423.1147282-1-li.meng@amd.com/
> 
> Changes from V1 -> V2:
> - cpufreq: amd-pstate:
> - - add a trailing of amd-pstate.h to MAINTAINER AMD PSTATE DRIVER.
> - selftests: cpufreq:
> - - add a wrapper shell script for the amd_pstate_testmod module.
> - selftests: cpufreq:
> - - remove amd_pstate_testmod kernel module to
>    .../cpufreq/amd_pstate_testmod.
> - Documentation: amd-pstate:
> - - amd_pstate_testmod rst document is not provided at present.
> 
> Changes from V2 -> V3:
> - cpufreq: amd-pstate:
> - - adjust the order of add amd-pstate.h in MAINTAINERS.
> - selftests: cpufreq:
> - - remove the call of amd_pstate_testmod.sh from cpufreq Makefile to
>    main.sh.
> - selftests: cpufreq:
> - - add explain the goal or intention of the AMD P-State Unit Test
>    module.
> - - modify comments.
> - - use the checkpatch.pl to check my patches.
> - - add conditions judgment before formal test.
> - - delete some unnecessary test cases.
> - - modify test cases about perf and performance etc.
> 
> Changes from V3 -> V4:
> - selftests: amd-pstate:
> - - remove script and test module to tools/testing/selftests/amd-pstate/
> - - uniformly named amd-pstate-ut.
> - - check current architectures and cpufreq driver in amd-pstate-ut.sh
> - - delete codes about conditions in amd-pstate-ut.c
> - Documentation: amd-pstate:
> - - add introduce document about amd-pstate unit test.
> 
> Changes from V4 -> V5:
> - selftests: amd-pstate:
> - - add print the current scaling_driver.
> - - add amd-pstate-ut.ko into TEST_GEN_FILES.
> - - move "insmod/rmmod amd-pstate-ut.ko" stuff into script
>    amd_pstate_ut.sh
> - - add a check of read back from X86_FEATURE_CPPC in get_shared_mem().
> - Documentation: amd-pstate:
> - - delete the test step about insmod/rmmod amd-pstate-ut.ko
> 
> Changes from V5 -> V6:
> - cpufreq: amd-pstate:
> - - add amd-pstate-ut test codes to drivers/cpurfreq
> - - add the macro CONFIG_X86_AMD_PSTATE_UT
> - selftests: amd-pstate:
> - - delete amd-pstate-ut test codes from
>    tools/testing/selftests/amd-pstate/
> 
> Changes from V6 -> V7:
> - cpufreq: amd-pstate:
> - - modify X86_AMD_PSTATE_UT dependencies and default value.
> - - modify a brief description of the amd-pstate-ut module.
> - - remove kselftest_module.h header include.
> - - modify shortform for AMD P-State unit test.
> - - add prefix for the names of test cases.
> - - in the file operation log, add the file path.
> - - add comments about the test cases.
> - - correct syntax errors.
> - selftests: amd-pstate:
> - - delete TEST_GEN_FILES$(TEST_GEN_FILES): $(HEADERS) form amd-pstate
>    Makefile.
> - - simplify the judgment about ARCH.
> - - add the judgment about cpu vendor.
> - - modify the method about load the amd-pstate-ut module.
> - Documentation: amd-pstate:
> - - update the name of the test function.
> - - update kernel log about test result.
> 
> Changes from V7 -> V8:
> - cpufreq: amd-pstate:
> - - amend commit message.
> - - amend module description.
> - Documentation: amd-pstate:
> - - amend commit message.
> - - Remove the personal data.
> 
> Thanks,
> Jasmine
> 
> Meng Li (4):
>    cpufreq: amd-pstate: Expose struct amd_cpudata
>    cpufreq: amd-pstate: Add test module for amd-pstate driver
>    selftests: amd-pstate: Add test trigger for amd-pstate driver
>    Documentation: amd-pstate: Add unit test introduction
> 
>   Documentation/admin-guide/pm/amd-pstate.rst   |  76 +++++
>   MAINTAINERS                                   |   1 +
>   drivers/cpufreq/Kconfig.x86                   |   7 +
>   drivers/cpufreq/Makefile                      |   1 +
>   drivers/cpufreq/amd-pstate-ut.c               | 293 ++++++++++++++++++
>   drivers/cpufreq/amd-pstate.c                  |  60 +---
>   include/linux/amd-pstate.h                    |  77 +++++
>   tools/testing/selftests/Makefile              |   1 +
>   tools/testing/selftests/amd-pstate/Makefile   |   9 +
>   .../selftests/amd-pstate/amd-pstate-ut.sh     |  55 ++++
>   tools/testing/selftests/amd-pstate/config     |   1 +
>   11 files changed, 522 insertions(+), 59 deletions(-)
>   create mode 100644 drivers/cpufreq/amd-pstate-ut.c
>   create mode 100644 include/linux/amd-pstate.h
>   create mode 100644 tools/testing/selftests/amd-pstate/Makefile
>   create mode 100755 tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
>   create mode 100644 tools/testing/selftests/amd-pstate/config
> 

Rafael, Viresh,

I plan to apply these patches to linux-kselftest next for Linux 6.1
Please let me know if you have any objections.

thanks,
-- Shuah
