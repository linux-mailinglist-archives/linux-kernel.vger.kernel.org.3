Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0810D4C3544
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 20:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbiBXTDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 14:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbiBXTDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:03:35 -0500
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5BA12E150;
        Thu, 24 Feb 2022 11:03:05 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-2d68d519a33so8620977b3.7;
        Thu, 24 Feb 2022 11:03:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KGEpS7Bhdowi8weL04m6jlf8GznLn7sIWocKtZXzh8Q=;
        b=zkKdx9QWLqkcma1wwhVUH2fMvsX7jGTA1Uh3aCywrYcSWpzpm2tbA8vfJ4WSpl+IGw
         l36sO9Vs0k6+zub+j69ijq5azK9jc5oUy+iL8+mwyWIR83YwCxm2RzSytRuQe6Pc2tjp
         g6Iz3HPOrGwTRxU8RyREecUUlE7qrH8FDZio4+84hgf5tsmDmp0ZSkNhG/Nvs20rIHiI
         WAfcjFVn3ZUDshCXrjJZu059s0ry0j6LlQuSB+tXio13slwm7P4XYWd1e8LDvkPQkLSW
         7t/WQSwzu6ovBg7Hx9zJmu2xyMJwP0V6v5iURlULdbz8QLM3nOqSDAhIGHHcaSQJLz0w
         vbsA==
X-Gm-Message-State: AOAM530I0gYZZW/q4jJ1Tx4VaFonflIR6cuoIT5jYhF9I3qmZjKO6eRh
        thP6UzPjAblj1muRjR+T28uJkEJUkCPRVxU/tfMTsXoL
X-Google-Smtp-Source: ABdhPJyyPpGPB5Swv0lOQOMTpA2ZcbJZajb64+GsWwBlE5yTpEaPa4WjtBh7br1iE9ZkesquRPwe8mRR3znPPiwBHS0=
X-Received: by 2002:a81:1683:0:b0:2d2:aa58:ef87 with SMTP id
 125-20020a811683000000b002d2aa58ef87mr3719714yww.326.1645729384914; Thu, 24
 Feb 2022 11:03:04 -0800 (PST)
MIME-Version: 1.0
References: <9e3ba314-2030-8385-33ad-6b9a0291e5cd@linaro.org>
In-Reply-To: <9e3ba314-2030-8385-33ad-6b9a0291e5cd@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 24 Feb 2022 20:02:54 +0100
Message-ID: <CAJZ5v0iBaE-y_Q0Q4S4qUHd44r=C83JiLgxUzkhEHDLe7oZo=A@mail.gmail.com>
Subject: Re: [GIT PULL] dtpm for v5.18-rc1
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
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

On Thu, Feb 24, 2022 at 4:54 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> The following changes since commit 26291c54e111ff6ba87a164d85d4a4e134b7315c:
>
>    Linux 5.17-rc2 (2022-01-30 15:37:07 +0200)
>
> are available in the Git repository at:
>
>    https://git.linaro.org/people/daniel.lezcano/linux.git tags/dtpm-v5.18
>
> for you to fetch changes up to f1ebef9e55f3c49063b575e97d2019832b8f8ef9:
>
>    dtpm/soc/rk3399: Add the ability to unload the module (2022-02-23
> 19:46:29 +0100)
>
> ----------------------------------------------------------------
> - Added dtpm hierarchy description (Daniel Lezcano)
>
> - Changed the locking scheme (Daniel Lezcano)
>
> - Fixed dtpm_cpu cleanup at exit time and missing virtual dtpm pointer
>    release (Daniel Lezcano)
>
> ----------------------------------------------------------------
> Daniel Lezcano (12):
>        powercap/drivers/dtpm: Convert the init table section to a simple
> array
>        powercap/drivers/dtpm: Add hierarchy creation
>        powercap/drivers/dtpm: Add CPU DT initialization support
>        powercap/drivers/dtpm: Add dtpm devfreq with energy model support
>        rockchip/soc/drivers: Add DTPM description for rk3399
>        powercap/dtpm: Change locking scheme
>        powercap/dtpm_cpu: Reset per_cpu variable in the release function
>        powercap/dtpm: Fixup kfree for virtual node
>        powercap/dtpm: Destroy hierarchy function
>        powercap/dtpm: Move the 'root' reset place
>        powercap/dtpm_cpu: Add exit function
>        dtpm/soc/rk3399: Add the ability to unload the module
>
>   drivers/powercap/Kconfig          |   8 ++++++
>   drivers/powercap/Makefile         |   1 +
>   drivers/powercap/dtpm.c           | 333
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------------------
>   drivers/powercap/dtpm_cpu.c       |  55
> +++++++++++++++++++++++++++++++++-----
>   drivers/powercap/dtpm_devfreq.c   | 203
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/powercap/dtpm_subsys.h    |  22 ++++++++++++++++
>   drivers/soc/rockchip/Kconfig      |   8 ++++++
>   drivers/soc/rockchip/Makefile     |   1 +
>   drivers/soc/rockchip/dtpm.c       |  65
> +++++++++++++++++++++++++++++++++++++++++++++
>   include/asm-generic/vmlinux.lds.h |  11 --------
>   include/linux/dtpm.h              |  36 ++++++++++++-------------
>   11 files changed, 634 insertions(+), 109 deletions(-)
>   create mode 100644 drivers/powercap/dtpm_devfreq.c
>   create mode 100644 drivers/powercap/dtpm_subsys.h
>   create mode 100644 drivers/soc/rockchip/dtpm.c

Pulled, thanks!
