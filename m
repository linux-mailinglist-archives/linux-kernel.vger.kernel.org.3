Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCD94ABEF8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448190AbiBGNKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382905AbiBGM3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 07:29:53 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD7FC1DF3F0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 04:20:00 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id z62so27084124ybc.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 04:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VHNFlCmigziJYsY7QoVzu5haHaeukfsTdmobb9TO3j8=;
        b=LQLjBYiLGL4wmygWsQlLUjGwQvJXBVwTdEL2M8BH3Gx4jP/fVduLt/LdMM8rh9jIsB
         F6FfGIslomU1jb2TotoJFA14x24mnEVt7VXgqPFYjo8h5OaVXWu0SSsUxOkiVc16ME3p
         +30xfdeNKunJBoByaSCH1Fa6REk9vLcNcI+UT/hF9wlynoIf8wKUgRWO0rz4qzyrIN8T
         +0AhV3xDPIm/D15znH2TDto0nd1a9AHCMbsPTDVyhd6ulVrCM/tBPKS1iQolGacdq7EQ
         fjZ+pykwq4cDZAWzf56aI1pgRr/aVcDpcQ0NsS93UMqQQikZC3XzyTxUpSnLRUBnvsXP
         XgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VHNFlCmigziJYsY7QoVzu5haHaeukfsTdmobb9TO3j8=;
        b=HQClPxVA50oxPYJ8/tanNXz4QQ5awmUmQEoliLEJBHoV2pIK1Edm6G3Lew9XJ6u3fo
         ckCJPYeghK8hu0suleVpbL61rADmyVru9Gf/piyezA25JWDzsV6l1FYo2XRP0lNX+BX4
         E2NFjhGZlC47WDrO0IXwRq+jFUlUG6k0JJEWYe1Owm/nLdYajVABmGrh0hrDJIXzyeNW
         U23HTh417NsGiteqAleOytNEEPpk9t9C+uPeFtBV2QxOsq2yZcwgMp4IACg2W+ONWdvm
         K64GRPwiTifTRSi2eM5z+iaKROQRsHilp2GoaKxxa1iaNm4XebYQ/4zRULKm1CiP9BBi
         5RLg==
X-Gm-Message-State: AOAM530cmN6dlp/P1rMEdtll+Z9Gc1rOB/CZg8u1Pc5ijIVWOauHnjW/
        Ywo4dH2AHry5lQyCgkgUmA6PEPAtWN4LFebI8nu8kA==
X-Google-Smtp-Source: ABdhPJyrWjotRFPL1k46j6tfUbmGvI5LdgYUvJ+NC6Opl84UW0tcgzx6coW5EgUf03fwKzLZHrnowYgYGBhbBULA4ME=
X-Received: by 2002:a25:1402:: with SMTP id 2mr9304845ybu.684.1644236399245;
 Mon, 07 Feb 2022 04:19:59 -0800 (PST)
MIME-Version: 1.0
References: <20220207103804.053675072@linuxfoundation.org>
In-Reply-To: <20220207103804.053675072@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 7 Feb 2022 17:49:48 +0530
Message-ID: <CA+G9fYsd_kjuXOJx9umAhkaA7rRx40gVhY9ZBEe6xsMOZ2oTQg@mail.gmail.com>
Subject: Re: [PATCH 5.16 000/126] 5.16.8-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com, Arnd Bergmann <arnd@arndb.de>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Feb 2022 at 17:01, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.16.8 release.
> There are 126 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 09 Feb 2022 10:37:42 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.16.8-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Linux stable-rc 5.16 arm64 builds failed due to below errors.

  kvm/arm64: rework guest entry logic
  [ Upstream commit 8cfe148a7136bc60452a5c6b7ac2d9d15c36909b ]

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

arch/arm64/kvm/arm.c: In function 'kvm_arm_vcpu_enter_exit':
arch/arm64/kvm/arm.c:778:9: error: implicit declaration of function
'guest_state_enter_irqoff'; did you mean 'guest_enter_irqoff'?
[-Werror=implicit-function-declaration]
  778 |         guest_state_enter_irqoff();
      |         ^~~~~~~~~~~~~~~~~~~~~~~~
      |         guest_enter_irqoff
arch/arm64/kvm/arm.c:780:9: error: implicit declaration of function
'guest_state_exit_irqoff'; did you mean 'guest_exit_irqoff'?
[-Werror=implicit-function-declaration]
  780 |         guest_state_exit_irqoff();
      |         ^~~~~~~~~~~~~~~~~~~~~~~
      |         guest_exit_irqoff
arch/arm64/kvm/arm.c: In function 'kvm_arch_vcpu_ioctl_run':
arch/arm64/kvm/arm.c:875:17: error: implicit declaration of function
'guest_timing_enter_irqoff'; did you mean 'guest_enter_irqoff'?
[-Werror=implicit-function-declaration]
  875 |                 guest_timing_enter_irqoff();
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~
      |                 guest_enter_irqoff
arch/arm64/kvm/arm.c:925:17: error: implicit declaration of function
'guest_timing_exit_irqoff'; did you mean 'guest_exit_irqoff'?
[-Werror=implicit-function-declaration]
  925 |                 guest_timing_exit_irqoff();
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~
      |                 guest_exit_irqoff
cc1: some warnings being treated as errors


build link:
-----------
https://builds.tuxbuild.com/24mSvZ8HXKXM8ToJvie1FaTpCz0/


--
Linaro LKFT
https://lkft.linaro.org
