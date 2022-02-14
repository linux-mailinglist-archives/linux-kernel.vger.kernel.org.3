Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634644B4E4B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351154AbiBNLZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:25:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351046AbiBNLYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:24:50 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC636A038
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 03:00:36 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id p5so44649394ybd.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 03:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ql8NUq1Mhfk4FgjJdYn+6AtR/wTalZy71vD2iX7360=;
        b=HaouLhMkFE1Tiq9r67ZkbspsEZEGeDsEDrcBcXHPlhVMTAnQoNqML7O1lgdKdbp6Sy
         0VxaapMKnjgFJqH17uSVhB+naf4kLHC5kmz1MQBGUsjb7Ng8d+E5Hn+SfNFyDEUZIrNb
         AJSF1hjzKM42IFMG7pYWyIply6TGhegP4lACG++dR+vSYq8fOZbIwSJE7px5hElaNRWt
         C7341jM9DgM8SGFMyfu4TF6Wz8tv41ujpV36F8CueKK8Ug1ASS1hMFkQLW2Oj/m8OdET
         GVnHtQCj1PkI18M+WSp+dJ2ix2w3lEoaMHzhkzK0XD89pm0C+JOHiW2gTSFARUBUXF/g
         pU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ql8NUq1Mhfk4FgjJdYn+6AtR/wTalZy71vD2iX7360=;
        b=MT43JCfktwb2ZfYQKAcJYaU0FMvjvqPxIQJunTac6FkEnc5n3f/rTQczwA9/L64wCF
         kmp449J3GN4KSXXB3zqvotuynKWTbCs+kaAdiO9fn7CZL7cJzL2MHxqaA7Tp0DnwQDiu
         HQc/XRlCkOGdkqrIHMZUcjxDxeTk2SIM1gk3oaencfeXAsp3jwtZdU5GXORHQnh7Jkyg
         ikblCgJFgDOZKx0tzhfU8ioI7KjstaPAH7Rxk1ec/OB+fnxoDd51XE9bNM2H/4nh8zdD
         6O+RwKO1PDPZPcINWeIIF4fgzEXXKWWfPkS8ih3fmhVCbhfMx49dwzl5le+AMH56tmWk
         ukfQ==
X-Gm-Message-State: AOAM531k1AjhGvZQqGs49+WhA9sp0uLNvd9L28Bq6wPiXiNSKH/4dTXV
        oUXf2sTFzw3DT5k6PZ+aiJx1ZMpmLO48ANxZKpcghQ==
X-Google-Smtp-Source: ABdhPJy5yJJ+Rt8wVdvh+tLvsVhIt8bcoEhuSC4CHI8yHpu2ldBu+EEupqbDrNGS7Cp4eKQwSrOPWrrzNZyXwLqR52c=
X-Received: by 2002:a81:3542:: with SMTP id c63mr13303504ywa.87.1644836433843;
 Mon, 14 Feb 2022 03:00:33 -0800 (PST)
MIME-Version: 1.0
References: <20220214092506.354292783@linuxfoundation.org>
In-Reply-To: <20220214092506.354292783@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 14 Feb 2022 16:30:22 +0530
Message-ID: <CA+G9fYv72=mb-9UqAF5kK1TZ5+HEEjY=1_372K30tAzKEmAR0g@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/172] 5.15.24-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
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

On Mon, 14 Feb 2022 at 15:16, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.24 release.
> There are 172 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 16 Feb 2022 09:24:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.24-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

On Linux mainline master branch with arm64 clang-nigtly build failed
due to following errors and warnings.
Now it is also noticed on stable-rc 5.15 and 5.16.

net/ipv4/tcp_input.c: clang: error: clang frontend command failed with
exit code 139 (use -v to see invocation)
https://github.com/llvm/llvm-project/issues/53811

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

--
Linaro LKFT
https://lkft.linaro.org
