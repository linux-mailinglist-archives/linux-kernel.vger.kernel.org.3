Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D187595619
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbiHPJYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbiHPJXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:23:33 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4668312A1F5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:38:39 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id b96so12439267edf.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=7buQFKX9OZIlEB4+dje7yWbqm2+cxtfTWEbPmdc/htk=;
        b=KJkXLDKgTHvzZPCN7k9tf4IH4PPK6BZOH9uyrhPmryq0s9v9o5yRTJpg3ZhwM4oSdD
         G1BtDRWtVjT0ZJ2KU7Dx50eIBhZYqrr8p/NSQQjosU5iw16IRP0EGxn7LYrD8RqujJMi
         sITOw529kP/AGl2NAbicN/1Qv8NktRyOhCAGKAal9Prvk1g53LndsHnFy8YTZgCQC6Z4
         tRjZKpakYP2mAV6cEspfEhS2UsWTvBjb92s/WlftIMD+L5SqcjxGo8c39Yt+/r2BkMB5
         7YCAOStgM9VFC5N+HNEaaTjq7Y6p0aLoGWdTvgu1N1bNmvZy961yL04jo2VifDhybAh9
         YRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=7buQFKX9OZIlEB4+dje7yWbqm2+cxtfTWEbPmdc/htk=;
        b=bjbSboAqFWomRqkz1wCbQZBa3K4RM/V76VVZgYEdZiuag6D/MNfLJyIROpfSN0sJT0
         dtXOpbtOqfifYZuyXLp4k+eJrKBuuO4I3JQZt4eRuJVb2BDwwgmxbKEFiw3AbBoXG/m1
         +ZrzZ6rAFslN5zWZaeJ2ZHXDGm7GXTd6fpyjSFG5WU73ILftsN++SC9WxCif0l4IdigW
         fsUzOhkurwmvT6Ey8cnS3DZQosJoDr/YXVlgzzWxdyuyfQvK05HrwLstk7UmSpuebfuj
         k3PFHjgPaGJFN0+7kkcOwdEZj0hy3ciAGM9rOrWh4v3YXNjikHBWAfEFeFivUz8pEWfo
         i9Ew==
X-Gm-Message-State: ACgBeo2acUdJ+MlECsaX2IwDWrfxZvWlSGJ0u4MgKk76hYGNJ1NSSPFm
        7FBCf3yDED76sMbIrtMeXfHqO0o4v1ht9K00FT4O0lH+K0ucBQ==
X-Google-Smtp-Source: AA6agR7GrSqc14k7wysKRF5azz/sO4eA/lQMi8CdCB/5NFWzRpqJa63cCRJbkUP0o2sMCyAsB3ZQJbasaU+jex0kD44=
X-Received: by 2002:a05:6402:2387:b0:43d:3e0:4daf with SMTP id
 j7-20020a056402238700b0043d03e04dafmr17756151eda.208.1660635518010; Tue, 16
 Aug 2022 00:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220815180439.416659447@linuxfoundation.org>
In-Reply-To: <20220815180439.416659447@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 16 Aug 2022 13:08:26 +0530
Message-ID: <CA+G9fYtZP_rYnmRyLbMrxKPGtJuoOw4h412dJXBJnzab41CzUw@mail.gmail.com>
Subject: Re: [PATCH 5.19 0000/1157] 5.19.2-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Aug 2022 at 00:58, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.19.2 release.
> There are 1157 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 17 Aug 2022 18:01:29 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.19.2-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The arm64 clang-14 allmodconfig failed on stable-rc 5.19.
This build failure got fixed on the mainline tree two weeks ago.

* arm64, build
  - clang-12-allmodconfig
  - clang-13-allmodconfig
  - clang-14-allmodconfig
  - clang-nightly-allmodconfig


make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/2/build LLVM=1 LLVM_IAS=1
ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- 'HOSTCC=sccache clang'
'CC=sccache clang' allmodconfig
make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/2/build LLVM=1 LLVM_IAS=1
ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- 'HOSTCC=sccache clang'
'CC=sccache clang'
sound/soc/intel/avs/path.c:815:18: error: stack frame size (2192)
exceeds limit (2048) in 'avs_path_create'
[-Werror,-Wframe-larger-than]
struct avs_path *avs_path_create(struct avs_dev *adev, u32 dma_id,
                 ^
1 error generated.
make[5]: *** [/builds/linux/scripts/Makefile.build:249:
sound/soc/intel/avs/path.o] Error 1

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Steps to reproduce:
-------------------------
# See https://docs.tuxmake.org/ for complete documentation.
# Original tuxmake command with fragments listed below.
# tuxmake --runtime podman --target-arch arm64 --toolchain clang-14
--kconfig allmodconfig LLVM=1 LLVM_IAS=1

tuxmake --runtime podman --target-arch arm64 --toolchain clang-14
--kconfig https://builds.tuxbuild.com/2DPEiUmdALSZq7DeNthZFYoPLaN/config
LLVM=1 LLVM_IAS=1

--
Linaro LKFT
https://lkft.linaro.org
