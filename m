Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17DC5A5938
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 04:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiH3CQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 22:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiH3CQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 22:16:10 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E707A53B
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 19:16:06 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 92-20020a9d0be5000000b0063946111607so7164027oth.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 19:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=CZ0kufqvjx/I7T9RB2coE9VUWjPdxE/sVVAlyg7UGwE=;
        b=VYmp1WzYpFrX+l0IGItMBHfALgTQEw2W9Q+KQs9JIqJLgyowLtOKuNdFVk8eG+/p0A
         /gQ/dsJf6E29Okzit2R8CLmUN5eV2+ohVrzyjkPNxYDFACrzyj9rpWBsZRRFZCe9bqXD
         ki6c+BAq2ZrEp/USs93f1M4K2pBT2kbKK3EdbzCTsSkkwmI3nHy0WHzGIrnMCNZRZygE
         E/LLgJSYILsom1wxktVaIdeOIwswemVKW+JYEH81wIEicWppn9JznjKawbn8QmsOJEd7
         QQiVMYaoDxsiuuVp5RZAgPhmsGxHLDVgrTGfgO48I3L3UrdbsI8zcy+jR3eukPm5uv3F
         AECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=CZ0kufqvjx/I7T9RB2coE9VUWjPdxE/sVVAlyg7UGwE=;
        b=nhN1FzjP5VxiaR3UTz1SU+V3lBNehzirtDx3hr46Js+DOcorMbwXKN2hfhQ6U5RVbV
         M8bG2VKtZh/iaC9ezQ8nb05BdcUytni7n6fyPJv46jQhbpvyeM8+SVqyya5qJNhSMnJZ
         tbKSldQRrIebeFs5eoF6N/lvnHIbmZ5PTKVx0bQj/BqoCycHf2UXdety435UISkRmdDs
         OBjk6VFNtVJ+NnRyyhGgD8Tp4CJcxB1lCYG7gZjKjtkeiXlNtSDPn4NLeffvZlZXGWc7
         CKVrjdnvYz9oHU8nOHZuYSgux+4KurkjpWcDluJVnCi2Lfh0Z+9n+b4F4Pn+lTamhgkJ
         Qb8Q==
X-Gm-Message-State: ACgBeo3e5zJNDxcWLOU1Dv5LLcC/TNk6KBJ9XrGsLf5RyNgMOyyz4Ech
        Afeumrche8ScW03Z/JuChcZ1CQ==
X-Google-Smtp-Source: AA6agR5+MSiMLzPPsNRzHOq5T5iOjRjMY/tQK7I48odOwNGVOMbyKxd7wLMwep2CrAB4djJYOV+dIQ==
X-Received: by 2002:a9d:6c81:0:b0:639:1e16:35ae with SMTP id c1-20020a9d6c81000000b006391e1635aemr8059855otr.364.1661825765344;
        Mon, 29 Aug 2022 19:16:05 -0700 (PDT)
Received: from [192.168.17.16] ([189.219.72.147])
        by smtp.gmail.com with ESMTPSA id g15-20020a056870a70f00b0011d23ed5365sm7109101oam.43.2022.08.29.19.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 19:16:04 -0700 (PDT)
Message-ID: <45103585-eb88-2501-1d28-a4f21ca67efc@linaro.org>
Date:   Mon, 29 Aug 2022 21:16:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 5.10 00/86] 5.10.140-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com
References: <20220829105756.500128871@linuxfoundation.org>
From:   =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20220829105756.500128871@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 29/08/22 05:58, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.140 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 31 Aug 2022 10:57:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.140-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.10.140-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.10.y
* git commit: 10c6bbc07890234ed728ef39924dcdd3bd211e15
* git describe: v5.10.138-89-g10c6bbc07890
* test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.138-89-g10c6bbc07890

## No test regressions (compared to v5.10.139)

## No metric regressions (compared to v5.10.139)

## No test fixes (compared to v5.10.139)

## No metric fixes (compared to v5.10.139)

## Test result summary
total: 117997, pass: 106134, fail: 761, skip: 10810, xfail: 292

## Build Summary
* arc: 20 total, 20 passed, 0 failed
* arm: 590 total, 590 passed, 0 failed
* arm64: 110 total, 107 passed, 3 failed
* i386: 92 total, 89 passed, 3 failed
* mips: 90 total, 90 passed, 0 failed
* parisc: 24 total, 24 passed, 0 failed
* powerpc: 102 total, 102 passed, 0 failed
* riscv: 54 total, 54 passed, 0 failed
* s390: 42 total, 42 passed, 0 failed
* sh: 48 total, 48 passed, 0 failed
* sparc: 24 total, 24 passed, 0 failed
* x86_64: 97 total, 94 passed, 3 failed

## Test suites summary
* fwts
* igt-gpu-tools
* kunit
* kvm-unit-tests
* libgpiod
* libhugetlbfs
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-cpuhotplug
* ltp-crypto
* ltp-cve
* ltp-dio
* ltp-fcntl-locktests
* ltp-filecaps
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-fsx
* ltp-hugetlb
* ltp-io
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-open-posix-tests
* ltp-pty
* ltp-sched
* ltp-securebits
* ltp-syscalls
* ltp-tracing
* network-basic-tests
* packetdrill
* rcutorture
* v4l2-compliance
* vdso


Greetings!

Daniel Díaz
daniel.diaz@linaro.org

-- 
Linaro LKFT
https://lkft.linaro.org
