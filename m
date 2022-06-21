Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46FA552D1F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 10:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiFUIgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 04:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiFUIgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 04:36:19 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F360C25EA1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 01:36:18 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id p69so11564954ybc.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 01:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XK3NOZN6D3jmWfxj6zcoKoNJkVxGQRZizBH81dPFmTw=;
        b=luiiUMRJeorIuth+JmLI90EZ5LCuCxBcDBbByb9XgBBE/7f4FmfrXWqSVNKADIYCD7
         uTT9I0U7qE1a1UUf/pZXlWq3A3XuwJwxpdfpuuZBT5OHBZpU92iev8qtXfOF0/koDvUH
         VF10BAFdOvEZ6goVMZwkUizgPUGUSkigzIfVt4is3/q9uhGyoRLijGRryo/ND26ADBaM
         f9hGWie8FuBZFj1zFZNlLGiEq7M0r0VPL6nWF3iP9HXcT7GKXNMAI0Ke78jcIEcD1UFh
         biuyD3Zkm7xKlX1ewXbV/YxP582sdWciF9Cim7qrnmZZztNZ8J6E7bb2A9+7JQylgnSp
         zFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XK3NOZN6D3jmWfxj6zcoKoNJkVxGQRZizBH81dPFmTw=;
        b=PYq6H0NPjkbfcTRGQazLf9/GhUsjDgXx8VoaLZuIcX+N0JY+jO6t/Y1wGGtZnXBszi
         +g6yX05YtZhEdtJV79Dfvh0Pzxi6Gzu/yOLqeYVPO8heIJbQZL6TbmGsbnNcJ0FmgyTm
         ksY3jmjT98uV6aXmSNEYbkRCpFVNfYbC5STpk2nCkqa7hMH2muIv3zsZF3fYUgmYCEqE
         g0vdRTYZa27hE8cprxZlqGZHF+8MnYH/jjjFUDDAWXDnKe4LQUu3Q1gZD54JJLCWmMNc
         296/O1SAbx8zjWaDRDyN/phPm5hD+qMoy6FTkKua7ypPxbbbGrI/9Qcod7JujadeAWFd
         0IjA==
X-Gm-Message-State: AJIora/9n2VNu/7IguqgOHprbg8pArmEweE6Ub3FIe+Sidma+pXUJdA6
        ahoPZMMLaQ8Oi9XJQuoGZA1kmJyJJk6AaeB36A8Fyw==
X-Google-Smtp-Source: AGRyM1u0GLsG/mCzq0HCyNwfzW6+MAPhfU7oxo/FlKD+fLxWg+L2HL360XBPmSgozeFNjVnUmLl9Q/2864LVwW1QsIA=
X-Received: by 2002:a25:cb12:0:b0:668:be92:a574 with SMTP id
 b18-20020a25cb12000000b00668be92a574mr20938131ybg.617.1655800578069; Tue, 21
 Jun 2022 01:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220620124724.380838401@linuxfoundation.org>
In-Reply-To: <20220620124724.380838401@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 21 Jun 2022 14:06:06 +0530
Message-ID: <CA+G9fYsvY-0ub_CXbb5is0vRLQ9+SaPS8Op=9mZzCkeccUN+mg@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/106] 5.15.49-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com
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

On Mon, 20 Jun 2022 at 18:36, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.49 release.
> There are 106 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 22 Jun 2022 12:47:02 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.49-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Following commit causing regression while building allmodconfig for clang-13
on arm64, riscv and x86_64.

> Linus Torvalds <torvalds@linux-foundation.org>
>     netfs: gcc-12: temporarily disable '-Wattribute-warning' for now

fs/afs/inode.c:29:32: error: unknown warning group
'-Wattribute-warning', ignored [-Werror,-Wunknown-warning-option]
#pragma GCC diagnostic ignored "-Wattribute-warning"
                               ^
1 error generated.

Regressions:
  - arm64/build/clang-13-allmodconfig - Failed
  - riscv/build/clang-13-allmodconfig - Failed
  - x86_64/build/clang-13-allmodconfig - Failed

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log details:
https://builds.tuxbuild.com/2AqLnz5M3EvhXrUvjkISFVrUvlo/


--
Linaro LKFT
https://lkft.linaro.org
