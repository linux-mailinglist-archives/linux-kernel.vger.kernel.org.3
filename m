Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B030146B0BB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 03:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhLGCkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 21:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhLGCky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 21:40:54 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BED3C061354
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 18:37:24 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id g14so50391846edb.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 18:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t/GfZExWHoNhx8sv7gdU/W7hPMJlZo4iI9nHpyzXMps=;
        b=d64OVHz6GBvX6EQQ91Gn/CFkkouaEdXNL1sOlRcWRb48xNCZpocL3hhGwSoeMZD1+/
         TXt0LQ/RnJDNtj4bUIkkk1ybSZXIpGeZMdyxusIdJqt4ERTea9Izn5B5kJ+ikix0z/cx
         bZP0oEv01ps0mIzQDMzHAlcpSMvsFObZ2xJpJWOMEEgag1XFrjZ3HVqm1spG6fLXmLiJ
         mE1mQnm/wvGOH4zFVVXV2OT+7DXRd+mYtdcecGGSQQF0rX0MQWdGcyokcGktR4bOogy7
         Y6ib34f0nZbNLdfVbFmSHtZqPCaZqwkDYFosSme2PteauGTP2ubhB/qvAko1p9tDQJ6g
         wclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t/GfZExWHoNhx8sv7gdU/W7hPMJlZo4iI9nHpyzXMps=;
        b=ovgz9pAR+ZojOkg2FZd+JhAij+Cv0y/24IRP5Ou68pdYAYH2RWfX3oGFt/7eDteBAQ
         3h7vha8AhuQIt58nbTUg8USKMWEUskk5OOFSZi5IgJn2a5GtONrrM6brGCXNJl+eUEdn
         W7k2gC5AOO25B79JuJAfksOdSZxb6kTcBffXJlpDamyFC1y9FakqkP22w5jYxbOIVhZv
         +R1l1dycOhmGYzKMRLMwPUIJri3YJEjw1muxVALW6qIJ1HHQbqo+DPVWL9lpzCHHnSwN
         k/UhJWV1bHb40u51PoE+NzEVCal01l+WFfL9MbmtS+FF2ojn5/bL24n4l5LM6DoNQP+h
         kxng==
X-Gm-Message-State: AOAM531tQZJlRmA1If781FEK8WKyNRXZRO8qK/jnQM5qZy9EGorc3gmO
        R3cYHwZq5mfuamQwtqY1zXwvoc5CU5zGu7nzstLG/A==
X-Google-Smtp-Source: ABdhPJz9q3ApLmPrlbt6JhwHVnK4FBI5Pxx55Cas/yz+JVfFw0ZGZ1Dh9rgntL7P+af5k3FrQKC/Ig0gO+efZwPWtok=
X-Received: by 2002:a05:6402:2805:: with SMTP id h5mr4548816ede.267.1638844643029;
 Mon, 06 Dec 2021 18:37:23 -0800 (PST)
MIME-Version: 1.0
References: <20211206145559.607158688@linuxfoundation.org>
In-Reply-To: <20211206145559.607158688@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 7 Dec 2021 08:07:11 +0530
Message-ID: <CA+G9fYtYmZY-m1ZCaF3qJeGtn=8CJR_4K8EB_T4W+wuh31CNjg@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/130] 5.10.84-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        f.fainelli@gmail.com, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        stable@vger.kernel.org, pavel@denx.de, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, linux@roeck-us.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2021 at 20:46, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.84 release.
> There are 130 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 08 Dec 2021 14:55:37 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.84-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Regression found while building allmodconfig for the following arch

 - i386 (allmodconfig) with gcc-10 / gcc-11
 - mips (allmodconfig) with gcc-10 / gcc-11
 - powerpc (allmodconfig) with gcc-10 / gcc-11
 - parisc (allmodconfig) with gcc-10 / gcc-11
 - riscv (allmodconfig) with gcc-10 / gcc-11
 - sh (allmodconfig) with gcc-10 / gcc-11
 - s390 (allmodconfig) with gcc-10 / gcc-11


metadata:
  git branch: linux-5.10.y
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git commit: ea2293709b3cac4bdfcb88ad67605c58264608df
  git describe: v5.10.83-131-gea2293709b3c
  toolchain: gcc-10 / gcc-11
  kernel-config: https://builds.tuxbuild.com/21vHJb50DPJcjJuLnT8DzL6vvkn/config
  build location: https://builds.tuxbuild.com/21dB06iPvDP58giSGHdE5W3Qc68/

build error:
--------------
make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/current ARCH=i386
CROSS_COMPILE=i686-linux-gnu- 'CC=sccache i686-linux-gnu-gcc'
'HOSTCC=sccache gcc'
ERROR: modpost: "kgd2kfd_resume_iommu"
[drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
make[2]: *** [/builds/linux/scripts/Makefile.modpost:124:
modules-only.symvers] Error 1
make[2]: *** Deleting file 'modules-only.symvers'
make[2]: Target '__modpost' not remade because of errors.
make[1]: *** [/builds/linux/Makefile:1413: modules] Error 2

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

step to reproduce:
------------------
tuxmake --runtime podman --target-arch i386 --toolchain gcc-11
--kconfig allmodconfig

--
Linaro LKFT
https://lkft.linaro.org
