Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507DE52C302
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 21:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241741AbiERTEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 15:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241721AbiERTEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 15:04:32 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7575B20EE27;
        Wed, 18 May 2022 12:04:29 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-2fefb051547so34864037b3.5;
        Wed, 18 May 2022 12:04:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QRP/znsW6twON92OkuCxDQka0yD+6IG0hBq5yN5qSP0=;
        b=EbQp6tEvYlRFvrx2KtPg/OgRf2EePPZtbNWZLJDvPnTI9zZeS3sJnavNWnAtOTSEF/
         Ja+YIIj0RjXBU3Gjw0LHAMqDpip+xv0sBRV+d3VbHS0vVAyDY7KnOis+0cUMmIgQkANq
         atRg8WW/bMx7Pa8C+1PYogqCvQQ3ITSM2ECuv5gdKAHGtdNwHhyCLh8sDmMB1K7annyB
         D5/3O6F/0Bi/nc06C0lNSR/+CIqfbOj8nW63zeXoCh4Wg4KM5T9PZBVjGVtwdXTVizZo
         xg9gaeVTlP8vlUvMNyPexS7lF38V5hk18aiDMi+msvJGoykgW0Q+aXZDE9itmUO+gbjX
         qVNQ==
X-Gm-Message-State: AOAM531oNkRuOSbw/fFd9ABoH8LeLAKe0k82KgTFyxqUZ/ifKlmPTNpz
        w8E2sbSWrI+DWSBjcup0SaM+jjvuMTwIG0r9mlY=
X-Google-Smtp-Source: ABdhPJwpIe9ajHD4rKJrEU1dtxwdKJqPzwBoJd5QiCJoxXrFiFd5xtP2h1riCXK+UeIGlaRu2ObHjC/WEXT47/9ySGo=
X-Received: by 2002:a0d:c8c3:0:b0:2fe:e9eb:664 with SMTP id
 k186-20020a0dc8c3000000b002fee9eb0664mr910598ywd.301.1652900668697; Wed, 18
 May 2022 12:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220518021539epcas1p3449c756c4aca3c12000e2350b288a197@epcas1p3.samsung.com>
 <3acd6c32-6e78-dfc2-3e45-84f69a7d5f36@samsung.com>
In-Reply-To: <3acd6c32-6e78-dfc2-3e45-84f69a7d5f36@samsung.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 18 May 2022 21:04:17 +0200
Message-ID: <CAJZ5v0hRiWXrG1pMzLAqoRE9MidDPm21Mjpk7sjPsE=LA2oVuA@mail.gmail.com>
Subject: Re: [GIT PULL] devfreq next for 5.19
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "Rafael J. Wysocki <rjw@rjwysocki.net>" <rjw@rjwysocki.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
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

On Wed, May 18, 2022 at 4:16 AM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>
> Dear Rafael,
>
> This is devfreq-next pull request for v5.19-rc1. I add detailed description of
> this pull request on the following tag. Please pull devfreq with
> following updates.
> - tag name : devfreq-next-for-5.19
>
> Best Regards,
> Chanwoo Choi
>
>
> The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:
>
>   Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-5.19
>
> for you to fetch changes up to 26984d9d581e5049bd75091d2e789b9cc3ea12e0:
>
>   PM / devfreq: passive: Keep cpufreq_policy for possible cpus (2022-05-17 18:24:39 +0900)
>
> ----------------------------------------------------------------
> Update devfreq next for v5.19
>
> Detailed description for this pull request:
> 1. Update devfreq core
> - Add cpu based scaling support to passive governor. Some device like
> cache might require the dynamic frequency scaling. But, it has very
> tightly to cpu frequency. So that use passive governor to scale
> the frequency according to current cpu frequency.
>
> To decide the frequency of the device, the governor does one of the following:
> : Derives the optimal devfreq device opp from required-opps property of
>   the parent cpu opp_table.
>
> : Scales the device frequency in proportion to the CPU frequency. So, if
>   the CPUs are running at their max frequency, the device runs at its
>   max frequency. If the CPUs are running at their min frequency, the
>   device runs at its min frequency. It is interpolated for frequencies
>   in between.
>
> 2. Update devfreq driver
> - Update rk3399_dmc.c as following:
> : Convert dt-binding document to YAML and deprecate unused properties.
>
> : Use Hz units for the device-tree properties of rk3399_dmc.
>
> : rk3399_dmc is able to set the idle time before changing the dmc clock.
>   Specify idle time parameters by using nano-second unit on dt bidning.
>
> : Add new disable-freq properties to optimize the power-saving feature
>   of rk3399_dmc.
>
> : Disable devfreq-event device on remove() to fix unbalanced
>   enable-disable count.
>
> : Use devm_pm_opp_of_add_table()
>
> : Block PMU (Power-Management Unit) transitions when scaling frequency
>   by ARM Trust Firmware in order to fix the conflict between PMU and DMC
>   (Dynamic Memory Controller).
> ----------------------------------------------------------------
>
> Brian Norris (15):
>       dt-bindings: devfreq: rk3399_dmc: Convert to YAML
>       dt-bindings: devfreq: rk3399_dmc: Deprecate unused/redundant properties
>       dt-bindings: devfreq: rk3399_dmc: Fix Hz units
>       dt-bindings: devfreq: rk3399_dmc: Specify idle params in nanoseconds
>       dt-bindings: devfreq: rk3399_dmc: Add more disable-freq properties
>       PM / devfreq: rk3399_dmc: Drop undocumented ondemand DT props
>       PM / devfreq: rk3399_dmc: Drop excess timing properties
>       PM / devfreq: rk3399_dmc: Use bitfield macro definitions for ODT_PD
>       PM / devfreq: rk3399_dmc: Support new disable-freq properties
>       PM / devfreq: rk3399_dmc: Support new *-ns properties
>       PM / devfreq: rk3399_dmc: Disable edev on remove()
>       PM / devfreq: rk3399_dmc: Use devm_pm_opp_of_add_table()
>       PM / devfreq: rk3399_dmc: Avoid static (reused) profile
>       soc: rockchip: power-domain: Manage resource conflicts with firmware
>       PM / devfreq: rk3399_dmc: Block PMU during transitions
>
> Chanwoo Choi (3):
>       PM / devfreq: Export devfreq_get_freq_range symbol within devfreq
>       PM / devfreq: passive: Reduce duplicate code when passive_devfreq case
>       PM / devfreq: passive: Keep cpufreq_policy for possible cpus
>
> Saravana Kannan (1):
>       PM / devfreq: Add cpu based scaling support to passive governor
>
>  .../devicetree/bindings/devfreq/rk3399_dmc.txt     | 212 -----------
>  .../memory-controllers/rockchip,rk3399-dmc.yaml    | 384 ++++++++++++++++++++
>  drivers/devfreq/devfreq.c                          |  20 +-
>  drivers/devfreq/governor.h                         |  27 ++
>  drivers/devfreq/governor_passive.c                 | 403 +++++++++++++++++----
>  drivers/devfreq/rk3399_dmc.c                       | 312 ++++++++--------
>  drivers/soc/rockchip/pm_domains.c                  | 118 ++++++
>  include/linux/devfreq.h                            |  17 +-
>  include/soc/rockchip/pm_domains.h                  |  25 ++
>  9 files changed, 1063 insertions(+), 455 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/rockchip,rk3399-dmc.yaml
>  create mode 100644 include/soc/rockchip/pm_domains.h

Pulled, thanks!
