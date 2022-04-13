Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA29E4FFA8A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 17:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236654AbiDMPoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 11:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236646AbiDMPoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 11:44:18 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F17F4A93D;
        Wed, 13 Apr 2022 08:41:56 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2eafabbc80aso26634217b3.11;
        Wed, 13 Apr 2022 08:41:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SHFzz4Adk6Spcagd3aayb+Zwmj10ffSyTl1fyLat03Y=;
        b=0hM4BBnQj8mKRciCIxsYmRXevg7mX/vZc41s6r7iMVB35m4VqK9y9ACQsO43BjagJE
         Ng5yLYZjL/JtLDmDzPIoox/whb7CzsdfpVeezuRHOksp9xTjPiBNBipE9aXiHTGP+pGu
         JMPLfSpskjeh9bLyJysr/j1q6tqXpnGNZWtIs3mm+tRlZbBPZDFzMv064ZO+vTMz0v/a
         zqStqFSvdMovx1c/c+JZpguGkWqZM2KIUdEAUgNjpD1xji95qY5MYmwaj0r+gl27YrnC
         /6SLBZuMadCRk/QOIeB/Dx48LqWzBWG0fybt51XhYdd7quKKzsfWiiosLr1xr5dhIZ0U
         fXqg==
X-Gm-Message-State: AOAM530hpxRgEXG8jQZ1BO2ZbWSE10ANPeOkZ91/UdiOlX0mS7Z5sfkw
        PgE4aTTIcf/LP7Uw9VL8GxcI7z6d85iD0bL/w4c=
X-Google-Smtp-Source: ABdhPJz7T/J691Cv/mz1W3q3MZT3b4qfkZuWp3RXQM50EElAZhvyBpcUCEMrPY4T2qJ0YYjoOjsVKL3iXD/skfMzYlc=
X-Received: by 2002:a81:4b8e:0:b0:2ef:5240:69fc with SMTP id
 y136-20020a814b8e000000b002ef524069fcmr1407551ywa.19.1649864515666; Wed, 13
 Apr 2022 08:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220413090510.4039589-1-li.meng@amd.com>
In-Reply-To: <20220413090510.4039589-1-li.meng@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Apr 2022 17:41:44 +0200
Message-ID: <CAJZ5v0jFXhfL=2TwBfzzfEdyKUwYDCxo8OKZuYtJjASKE5Oqfw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Add unit test module for AMD P-State driver
To:     Meng Li <li.meng@amd.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Huang Rui <ray.huang@amd.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 11:06 AM Meng Li <li.meng@amd.com> wrote:
>
> Hi all:
>
> AMD P-State unit test(amd_pstate_testmod) is a kernel module for testing
> the functions of amd-pstate driver.
> It could import as a module to launch some test tasks.
>
> We upstream out AMD P-state driver into Linux kernel and use this unit
> test module to verify the required conditions and basic functions of
> amd-pstate before integration test.
>
> We use test module in the kselftest frameworks to implement it.
> We create amd_pstate_testmod module and tie it into kselftest.
>
> For exmaple: The test case aput_acpi_cpc is used to check whether the
> _CPC object is exist in SBIOS.
> The amd-pstate initialization will fail if the _CPC in ACPI SBIOS is
> not existed at the detected processor, so it is a necessary condition.
>
> At present, its test cases are very simple, and the corresponding test
> cases will continue to be added later to improve the test coverage.
>
> See patch series in below git repo:
> V1: https://lore.kernel.org/linux-pm/20220323071502.2674156-1-li.meng@amd.com/
>
> Changes from V1 -> V2:
> - cpufreq: amd-pstate:
> - - add a trailing of amd-pstate.h to MAINTAINER AMD PSTATE DRIVER
> - selftests: cpufreq
> - - add a wrapper shell script for the amd_pstate_testmod module
> - selftests: cpufreq:
> - - remove amd_pstate_testmod kernel module to .../cpufreq/amd_pstate_testmod
> - Documentation: amd-pstate:
> - - amd_pstate_testmod rst document is not provided at present.
>
> Thanks,
> Jasmine
>
> Meng Li (3):
>   cpufreq: amd-pstate: Expose struct amd_cpudata

Please collect an ACK from Ray for this one as per MAINTAINERS and I
will leave the series to Shuah as it is selftests mostly.

Thanks!

>   selftests: cpufreq: Add wapper script for test AMD P-State
>   selftests: cpufreq: Add amd_pstate_testmod kernel module for testing
>
>  MAINTAINERS                                   |   1 +
>  drivers/cpufreq/amd-pstate.c                  |  60 +---
>  include/linux/amd-pstate.h                    |  74 +++++
>  tools/testing/selftests/cpufreq/Makefile      |   2 +-
>  .../selftests/cpufreq/amd_pstate_testmod.sh   |   4 +
>  .../cpufreq/amd_pstate_testmod/Makefile       |  20 ++
>  .../amd_pstate_testmod/amd_pstate_testmod.c   | 302 ++++++++++++++++++
>  tools/testing/selftests/cpufreq/config        |   1 +
>  8 files changed, 404 insertions(+), 60 deletions(-)
>  create mode 100644 include/linux/amd-pstate.h
>  create mode 100755 tools/testing/selftests/cpufreq/amd_pstate_testmod.sh
>  create mode 100644 tools/testing/selftests/cpufreq/amd_pstate_testmod/Makefile
>  create mode 100644 tools/testing/selftests/cpufreq/amd_pstate_testmod/amd_pstate_testmod.c
>
> --
> 2.25.1
>
