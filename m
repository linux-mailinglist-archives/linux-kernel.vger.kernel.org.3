Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334F6561B77
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 15:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235033AbiF3NiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 09:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234515AbiF3Nh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 09:37:58 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4B22ED49;
        Thu, 30 Jun 2022 06:37:57 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-31c1d580e4bso47124517b3.3;
        Thu, 30 Jun 2022 06:37:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7NtscKgnr/TPZ4pSkCV8fTHou2/3bzArnwcRicRt7Lk=;
        b=TTtjPq3NiWyruZey2USm5L96m3yb8fEggtfTS03G87FoHrAipXCourgJoM2EUby8Jc
         nRCbgJ8B+Jlme7F67JL3NTEHu5tpsULeP9PUqc3kKK2911oiY5hqtGbRc7mhDNuJN7/3
         PfQYROXIB5cMvQuFt5z1Z1e0/kKK24WS2a1pb+wmo4OPkGzSlk4WBS9sZHLrs0/1qBI3
         ovbc2sEBJMKAE3fHmob0TsgcBxZjCb5RhkxFrESQjcjZkj+kPXehRYnEdpbW+0dmZ7k0
         pCzBofEhYcUlkuCP6zja600u+d8r+A5Hf7AELmFeRHygATVRKaiEB+7dFiJbf44KmU9F
         r4QA==
X-Gm-Message-State: AJIora++0yr3rZLHNKJVgTzQDoyt6StKPBeTogdlmlHHhqaxkFxg5dDy
        RGMX6RAbSDDjMuGIlrgTeEIvvDTeFFJ8OrOuyCA=
X-Google-Smtp-Source: AGRyM1t57QTon5503C9GLG8fWbNKXBFL/wnqjXCZ3GgK4VAKR/+nr5BpBmCGjgXwk93gtEili3G9bekl2vLWYkeo/1E=
X-Received: by 2002:a0d:e804:0:b0:317:9c5f:97a4 with SMTP id
 r4-20020a0de804000000b003179c5f97a4mr10661578ywe.19.1656596276849; Thu, 30
 Jun 2022 06:37:56 -0700 (PDT)
MIME-Version: 1.0
References: <03056170-6501-3f4d-0331-37866d12330e@gmail.com>
In-Reply-To: <03056170-6501-3f4d-0331-37866d12330e@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Jun 2022 15:37:45 +0200
Message-ID: <CAJZ5v0iu_ZZGK-FpO-yWHs67bKzJ6K5i9gj7-GvC0U6Ap9uoKA@mail.gmail.com>
Subject: Re: [GIT PULL] devfreq fixes for 5.19-rc5
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:DEVICE FREQUENCY (DEVFREQ)" <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanwoo Choi <chanwoo@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 11:32 PM Chanwoo Choi <cwchoi00@gmail.com> wrote:
>
> Dear Rafael,
>
> This is devfreq-fixes pull request for v5.19-rc5. I add detailed description of
> this pull request on the following tag. Please pull devfreq with
> following updates.
>
> Best Regards,
> Chanwoo Choi
>
>
> The following changes since commit 03c765b0e3b4cb5063276b086c76f7a612856a9a:
>
>   Linux 5.19-rc4 (2022-06-26 14:22:10 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-fixes-for-5.19-rc5
>
> for you to fetch changes up to f08fe6fcbe13f83558ecccc4acaf5af3dce71a1f:
>
>   PM / devfreq: passive: revert an editing accident in SPDX-License line (2022-06-30 05:11:17 +0900)
>
> ----------------------------------------------------------------
>
> Update devfreq for 5.19-rc5
>
> Detailed description for this pull request:
> 1. Fix devfreq passive governor issue when cpufreq policy are not ready
> during kernel booting because some cpus turn on after kernel booting or others.
>
>   - Re-initialize the vairables of struct devfreq_passive_data when PROBE_DEFER
>   happen when cpufreq_get_returns NULL
>
>   - Use dev_err_probe to mute warning when PROBE_DEFER
>
>   - Fix cpufreq passive unregister erroring on PROBE_DEFER
>   by using the allocated parent_cpu_data list to free resouce
>   instead of for_each_possible_cpu.
>
>   - Remove duplicate cpufreq passive unregister and warning when PROBE_DEFER
>
>   - Use HZ_PER_KZH macro in units.h
>
>   - Fix wrong indentation in SPDX-License line
>
> 2. Fix reference count leak of exynos-ppmu.c by using of_node_put()
>
> 3. Rework freq_table to be local to devfreq struct
>   - struct devfreq_dev_profile includes freq_table array to store
>   the supported frequencies. If devfreq driver doesn't initialize
>   the freq_table, devfreq core allocate the memory and initialize
>   the freq_table.
>
>   On a devfreq PROBE_DEFER, the freq_table in the driver profile struct,
>   is never reset and may be leaved in an undefined state. To fix this
>   and correctly handle PROBE_DEFER, use a local freq_table and
>   max_state in the devfreq struct.
>
> ----------------------------------------------------------------
> Christian Marangi (5):
>       PM / devfreq: Fix kernel panic with cpu based scaling to passive gov
>       PM / devfreq: Mute warning on governor PROBE_DEFER
>       PM / devfreq: Fix cpufreq passive unregister erroring on PROBE_DEFER
>       PM / devfreq: Rework freq_table to be local to devfreq struct
>       PM / devfreq: Fix kernel warning with cpufreq passive register fail
>
> Lukas Bulwahn (1):
>       PM / devfreq: passive: revert an editing accident in SPDX-License line
>
> Miaoqian Lin (1):
>       PM / devfreq: exynos-ppmu: Fix refcount leak in of_get_devfreq_events
>
> Yicong Yang (1):
>       PM / devfreq: passive: Use HZ_PER_KHZ macro in units.h
>
>  drivers/devfreq/devfreq.c           | 76 ++++++++++++++++++-------------------
>  drivers/devfreq/event/exynos-ppmu.c |  8 +++-
>  drivers/devfreq/governor_passive.c  | 62 +++++++++++++-----------------
>  include/linux/devfreq.h             |  5 +++
>  4 files changed, 75 insertions(+), 76 deletions(-)

Pulled and pushed out, thanks!
