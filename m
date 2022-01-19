Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9EDA49340C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 05:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351294AbiASEgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 23:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239102AbiASEgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 23:36:37 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09A3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 20:36:37 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id s11so1313623ioe.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 20:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Cap/PxeNnv1OJYjUI7Ahsg5U527hUTt+9b0IAzY98A=;
        b=Mwp2mFsxVmsDd0cRblkrzyqLSwPBDBcubnHNSZxbA0WEDJWilr7V+H3x8Rtjr3Ew7T
         7t+QP4BcL4tBo7leBHcNbY8R9HmWvZsSpkO5fGwkFbUCsrKxhXkH+DF9chPjK+kyeZyq
         HFzw+R6QiQIRp1Lb93BieJEjwkDoiC3iX8meYC+lgOC0BRIvUpzLgccNEWAx9Bpd3kca
         RnsBQqL+iqQn7X8U+1t+rCQ7k4vRXpJtNTkrMJ5rnhSZRFPEVPk0IFhL8YXpL+cYy0Ty
         OXNkDQt6ays8YL0P4zYg5XZLmXin+Dv6kdR76pdtPbxBJhPk/cjPudTYE/Z684VzckhA
         OlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Cap/PxeNnv1OJYjUI7Ahsg5U527hUTt+9b0IAzY98A=;
        b=zGjGE9u0exTaqH+DMoSyYd2NQ2xaUi8bNgceg23x7sX3qOXZecrPrC1Sm9lFY4IsxL
         6AkJzq25VGuKlQHBGS/NzYOiS/Uz8jQ0RrRQb9tzsvj6KPnQH8SeNP1i49S3oeTCtHL/
         lWmeZ+gJRafGhiTihLf/INwcSBUFEOFqyHYTZvPpMGcLLlf3eY7iGdB9q4nnwbKv6lrQ
         dJcWGgtGb6aEF4ikPIlL71GOKcfzYhXh63obFv4SqbOsDSLXcBFjKh1eZfJuDsYnV/Hr
         QrL7n3t+p17KZx/3GI0e0dT8SfvH/tQ9Eh/Xw8tzEblAYJ+qeYxdrgBElXys7y6fZhLO
         /pHQ==
X-Gm-Message-State: AOAM5317d2WmPIHjYdgAOJ2lhHvUOchaYGejBMcJ7h73WL7nxa887hj8
        IVUl9K+NDizblHOQuP5ac1klGAbn2aAtiaTJfhc=
X-Google-Smtp-Source: ABdhPJwL8khuogtYzmWQG/CyUnZY9UbrmZJd6/eRRzAQYXXODykU5b9it5wwUOIs2oG4feF1K34RUbPsZHZeLJpAlFc=
X-Received: by 2002:a02:8648:: with SMTP id e66mr12789960jai.145.1642566996961;
 Tue, 18 Jan 2022 20:36:36 -0800 (PST)
MIME-Version: 1.0
References: <202201191239.XKS6Ud9B-lkp@intel.com>
In-Reply-To: <202201191239.XKS6Ud9B-lkp@intel.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 18 Jan 2022 20:36:25 -0800
Message-ID: <CAEf4BzawhgxW6jvFyJ9twyYE6buu9+QE=gFK9H7U+Bf6gryNwg@mail.gmail.com>
Subject: Re: [ammarfaizi2-block:google/android/kernel/common/android13-5.10
 9989/9999] main.c:118:5: warning: no previous prototype for 'eprintf'
To:     kernel test robot <lkp@intel.com>
Cc:     "Connor O'Brien" <connoro@google.com>, kbuild-all@lists.01.org,
        "GNU/Weeb Mailing List" <gwml@gnuweeb.org>,
        open list <linux-kernel@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 8:33 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android13-5.10
> head:   976a28295a01db618903406bd67cae53a4c29832
> commit: 44b9bfcd4cdbc57889a0fecf79a6d30237f21bed [9989/9999] FROMGIT: tools/resolve_btfids: Build with host flags
> config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220119/202201191239.XKS6Ud9B-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/ammarfaizi2/linux-block/commit/44b9bfcd4cdbc57889a0fecf79a6d30237f21bed
>         git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
>         git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android13-5.10
>         git checkout 44b9bfcd4cdbc57889a0fecf79a6d30237f21bed
>         # save the config file to linux build tree
>         mkdir build_dir
>         make W=1 O=build_dir ARCH=x86_64 prepare
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> main.c:118:5: warning: no previous prototype for 'eprintf' [-Wmissing-prototypes]
>      118 | int eprintf(int level, int var, const char *fmt, ...)
>          |     ^~~~~~~
>    main.c: In function 'symbols_collect':
>    main.c:407:7: warning: unused variable 'err' [-Wunused-variable]
>      407 |   int err = -1;
>          |       ^~~
>    main.c:404:9: warning: unused variable 'tmp' [-Wunused-variable]
>      404 |   char *tmp, *prefix;
>          |         ^~~
>    main.c: In function 'eprintf':
> >> main.c:128:9: warning: 'ret' may be used uninitialized in this function [-Wmaybe-uninitialized]
>      128 |  return ret;
>          |         ^~~
>

All this has been addressed 9 months (!) ago by:

e27bfefb21f2 ("tools/resolve_btfids: Fix warnings")


> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
