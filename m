Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEA358739E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 23:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbiHAVx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 17:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbiHAVxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 17:53:24 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98073DF19
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 14:53:22 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id g20-20020a9d6a14000000b0061c84e679f5so9147545otn.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 14:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=jiDy8u6AhseNgTMjQZ7K+bzlVAcgc3R52GUHZiVxKaU=;
        b=zKNFfFkbWG/TWx35OCRuJ/ueqBSuW18cDw3C6zDQaUgVc+TfivhzhNFkfMe5UKO/qM
         zlV4aoQpnb3WjtpzztgAxDdajcN0tdWAaOoklZhEIN6bLslznS8vnXzdzWENI8uRZNUx
         w9RSVOQxbbmVsWXLzDdVP1kx1mZMuAanON2Y3/jcYk872sbEeTRfN4UTmrVr5L/4WgMI
         PhWXqzZvS/nPmzYc7p61v8a3fCKQqwaF1HIz1PeOD/r9QomVNW7/XksY1OrjphhEau9r
         U8LBx0C5g+uc9Wmx3qVFlybbvuYeIPCWv2nJueX0c7Uf2E3ff3bp5SdXk8dnhR49R0MV
         jEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=jiDy8u6AhseNgTMjQZ7K+bzlVAcgc3R52GUHZiVxKaU=;
        b=d7a6XevhpEdRiZciPb0eKTmPxDqrBSQoPsiiBZ+4NkQyst2d7z5936WWOD7dv16kzG
         PFJ39UFbcUUhaPJjUPRyhBhO2EpYMWIDi/qvbtbpm+zJ7UN7tskUz72Hq4Nd93aZRGqV
         cY5+czvJ9ZLos1Y/cavvAmFt83eYrM+1ehqtjD6d+eefnNBnaiWvus7SaTgvRQS1l3UW
         FI1Y1uBxA993Ug+s2CeBZ0DPAaw42TGRaw2Tefn832MA3lhnqnSlH4p1jchbVmKSbegn
         1JitwaOPe0GRnpmhCCb43D6amhxs5uUfjXN0qvJ+DULYkMD+bZfL0qNnvrTKKS6F/VZH
         U3Bw==
X-Gm-Message-State: AJIora9cJ78lWU/Kr+UDueCSpLQCfVS4EnJkawFCnW8nC3sG/HpH5hk8
        5F/PHjVPzh/9f0NXMxj6Ng2dQA==
X-Google-Smtp-Source: AGRyM1sJuIVQMtPZhDw5zuIjb8tS905DCFPNuo04y3pyhYQYGbFCdk5MTmvcKTpEMtwGSVIOGEUOeQ==
X-Received: by 2002:a05:6830:349a:b0:61c:bfb6:b01a with SMTP id c26-20020a056830349a00b0061cbfb6b01amr6216645otu.294.1659390802193;
        Mon, 01 Aug 2022 14:53:22 -0700 (PDT)
Received: from [192.168.17.16] ([189.219.75.211])
        by smtp.gmail.com with ESMTPSA id y11-20020a056870428b00b0010e046491f8sm3359730oah.57.2022.08.01.14.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 14:53:21 -0700 (PDT)
Message-ID: <97c75cb0-2932-b1e8-c997-c79a76406f41@linaro.org>
Date:   Mon, 1 Aug 2022 16:53:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 5.15 00/69] 5.15.59-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com
References: <20220801114134.468284027@linuxfoundation.org>
From:   =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20220801114134.468284027@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 01/08/22 06:46, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.59 release.
> There are 69 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 03 Aug 2022 11:41:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.59-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.15.59-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: f7c660e98f9bd2987c86dfe0017ad54afb4026e1
* git describe: v5.15.57-273-gf7c660e98f9b
* test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.57-273-gf7c660e98f9b

## No test regressions (compared to v5.15.58)

## No metric regressions (compared to v5.15.58)

## No test fixes (compared to v5.15.58)

## No metric fixes (compared to v5.15.58)

## Test result summary
total: 138438, pass: 122071, fail: 702, skip: 14903, xfail: 762

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 311 total, 308 passed, 3 failed
* arm64: 68 total, 66 passed, 2 failed
* i386: 57 total, 51 passed, 6 failed
* mips: 50 total, 47 passed, 3 failed
* parisc: 14 total, 14 passed, 0 failed
* powerpc: 59 total, 56 passed, 3 failed
* riscv: 27 total, 27 passed, 0 failed
* s390: 26 total, 23 passed, 3 failed
* sh: 26 total, 24 passed, 2 failed
* sparc: 14 total, 14 passed, 0 failed
* x86_64: 61 total, 59 passed, 2 failed

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
* ltp-smoke
* ltp-syscalls
* ltp-tracing
* network-basic-tests
* packetdrill
* rcutorture
* ssuite
* v4l2-compliance
* vdso


Greetings!

Daniel Díaz
daniel.diaz@linaro.org

-- 
Linaro LKFT
https://lkft.linaro.org
