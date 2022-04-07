Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30A34F7DE5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 13:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244757AbiDGLW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 07:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244740AbiDGLWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 07:22:47 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1262A1CA13E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 04:20:47 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2e5e9025c20so57628417b3.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 04:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v7Jwe0VrBcAjVk91bGHnhVaDKMA+AJj1/NHbliWEizE=;
        b=yMZ98Ijdg1QRohwPmwdFzysZvyUvsyFs6JZ/qB8PmbOmDbcELZUzICmrdBTjG5ITIg
         rpAHebALkH3xUp8GPhmfBveIelrVhcXq8IGPcz6mkaGSqBvKPpPoQZ3fmPIow/EWBp6X
         N/DGPka4+VwRF2w8AEFnLRzIIsbc6Zd8R0Tk2LtiCRb9gPdU95cU5KTMeaRLG4gXQ/Y3
         9iWtZK95P4gTvNiFi74JsNQw+jJT0cXoHzCdWBlwgpTmImn3ZJMCJrlt9mkWn82/WjWl
         pQ3STnkSihDkH6iErRRHPSQm+OuSlsf4MydRsRMUn6BV6dBRwNFc2tVrPTbnSof94/Tf
         NLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v7Jwe0VrBcAjVk91bGHnhVaDKMA+AJj1/NHbliWEizE=;
        b=z7hOGtw7spsFQqzd6+kBxwyNZNQ1C+ngU8bNByyGURkt9LVAezM008pILJhGZ5aOkZ
         ucwJcsaQEXY1B4qIiHCipUG+On1NR9WyE/+g6+pXu5UllaFUGBTF0CrkStMueYtmYj8e
         VAI3CyrS1y6gMDBAPY7kCZLV9jHqq/8+h+bKlnoor/SmL2iQCKStGUUQ+37bEndRRJGZ
         ebHKSrJgtQJVJ+sFwCSLh7Rai1yzCMzC+pw1+MwxNMKr9pJA9S3ywJ9HXqv1x1vog220
         GymiYkbLZHsjG9MquxU7ztYg6+N8KA6B1oqMlSYt+rZnz7ruMG4a+yFjevdHK7ZobxAX
         p/1g==
X-Gm-Message-State: AOAM5333IZDNo1Eky1NuKNquhmwOr7Ya2IJEbpXgGODEmduxtyjbN7BQ
        rZx7FWutyzb1vJN2O6/gEemDnCg7bwQShMfoN+FuRA==
X-Google-Smtp-Source: ABdhPJwuPnrI9ju/ehvowlCK+6IK9k7uNGJPltBaYDZIbZb+JlDlJrGdYDtKGivvl7sV8hzwrkCu2y9M5ITWeDe4buI=
X-Received: by 2002:a0d:f487:0:b0:2eb:54f5:3abf with SMTP id
 d129-20020a0df487000000b002eb54f53abfmr11246081ywf.141.1649330446172; Thu, 07
 Apr 2022 04:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220406182436.675069715@linuxfoundation.org>
In-Reply-To: <20220406182436.675069715@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 7 Apr 2022 16:50:34 +0530
Message-ID: <CA+G9fYvAL0BUz8KuMrJyAKEWVwcuuk=_ejQksqxocB86Oq30SA@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/43] 4.9.310-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Apr 2022 at 23:57, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.310 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 08 Apr 2022 18:24:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.310-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.

As Guenter reported,
On stable rc 4.9 arm64 build configs allnoconfig and tinyconfig failed.

## Build
* kernel: 4.9.310-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.9.y
* git commit: b5f0e9d665c30ceb3bee566518a1020e54d7bc1f
* git describe: v4.9.309-44-gb5f0e9d665c3
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.9.y-sanity/build=
/v4.9.309-44-gb5f0e9d665c3

## Test Regressions (compared to v4.9.309-163-geeae539a0d5c)
* arm64, build
  - arm64-clang-11-allnoconfig
  - arm64-clang-11-tinyconfig
  - arm64-clang-12-allnoconfig
  - arm64-clang-12-tinyconfig
  - arm64-clang-13-allnoconfig
  - arm64-clang-13-tinyconfig
  - arm64-clang-nightly-allnoconfig
  - arm64-clang-nightly-tinyconfig
  - arm64-gcc-10-allnoconfig
  - arm64-gcc-10-tinyconfig
  - arm64-gcc-11-allnoconfig
  - arm64-gcc-11-tinyconfig
  - arm64-gcc-8-allnoconfig
  - arm64-gcc-8-tinyconfig
  - arm64-gcc-9-allnoconfig
  - arm64-gcc-9-tinyconfig


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

--
Linaro LKFT
https://lkft.linaro.org
