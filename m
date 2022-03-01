Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E484C922F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236664AbiCARtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiCARtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:49:51 -0500
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F1135DED;
        Tue,  1 Mar 2022 09:49:09 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id e186so4611847ybc.7;
        Tue, 01 Mar 2022 09:49:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Qdj2RGHYXCCm3iO7RYKkfSFjuAWoF/QNWHXobLMf/4=;
        b=5iEheSV3tO9iOzeEKtR1pGW9leq9gjfCXiEOOrHPT0tLDVfc5Xi7VxZFkbdvbUpXkV
         qt4SLbNrN14MI/ybAwDpH8WwerrSOU5g1W+dCKNbsI3XrdSpUf9e8pozj1Keqhv9ZK+Q
         7SkGrBooEfPor90aYilEOMdRKNI6TE1fmBeYk9ydQBy4GpZSlp8IH/EZf5bRs0xJX5OQ
         d62LoSKiUlba/YotV2TxYluiYGDRUyGT8OfJolj0QyHr9OSOOg3E/98THzPIfOnoByfj
         MTTtcSDXIEcakgKHh3mL7S5jGwGLuADanrIMX2jzD0VAZQewqnP0/9jX9cqMtOAKmRH7
         5pgQ==
X-Gm-Message-State: AOAM533NHY7J2AMeJXmBS7tSIm/3nNC1muZXM+vMBo/UBnlUEU4l4jj6
        v3wc/ATo52PZ62dvmi/GzdvT+OjMUqb2ZGaJ+riIQiNc
X-Google-Smtp-Source: ABdhPJzIaXGFBj3wh2v3lfyOJ7M92r8dcA3h5SEf9hhVfShXbXNQPRZcL4YBYV8eRNq2jH9/Jo2Atem76v4xyYAi8O0=
X-Received: by 2002:a25:3f47:0:b0:628:7571:b07d with SMTP id
 m68-20020a253f47000000b006287571b07dmr4721090yba.622.1646156949088; Tue, 01
 Mar 2022 09:49:09 -0800 (PST)
MIME-Version: 1.0
References: <ae1801b4-9c1f-b0eb-f3c6-dd888b689efe@linuxfoundation.org>
In-Reply-To: <ae1801b4-9c1f-b0eb-f3c6-dd888b689efe@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Mar 2022 18:48:58 +0100
Message-ID: <CAJZ5v0j5A8adEmY7Qk44uDqQoJwq4VY6v0he8mw2VU39-wAPtg@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower update for Linux 5.18-rc1
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
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

On Mon, Feb 28, 2022 at 9:45 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Hi Rafael,
>
> Please pull the following cpupower update for Linux 5.18-rc1
>
> This cpupower update for Linux 5.18-rc1 adds AMD P-State Support to
> cpupower tool. AMD P-State kernel support went into 5.17-rc1.
>
> diff is attached.
>
> thanks,
> -- Shuah
>
> ----------------------------------------------------------------
> The following changes since commit 101025ff8e47d3c938ad2ae646a1794b9a8aa730:
>
>    tools/power/cpupower/{ToDo => TODO}: Rename the todo file (2022-01-24 09:07:11 -0700)
>
> are available in the Git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-cpupower-5.18-rc1
>
> for you to fetch changes up to 8382dce5e4835c045f33b8958a5f559d212cdd11:
>
>    cpupower: Add "perf" option to print AMD P-State information (2022-02-23 17:46:21 -0700)
>
> ----------------------------------------------------------------
> linux-cpupower-5.18-rc1
>
> This cpupower update for Linux 5.18-rc1 adds AMD P-State Support to
> cpupower tool. AMD P-State kernel support went into 5.17-rc1.
>
> ----------------------------------------------------------------
> Huang Rui (10):
>        cpupower: Add AMD P-State capability flag
>        cpupower: Add the function to check AMD P-State enabled
>        cpupower: Initial AMD P-State capability
>        cpupower: Add the function to get the sysfs value from specific table
>        cpupower: Introduce ACPI CPPC library
>        cpupower: Add AMD P-State sysfs definition and access helper
>        cpupower: Enable boost state support for AMD P-State module
>        cpupower: Move print_speed function into misc helper
>        cpupower: Add function to print AMD P-State performance capabilities
>        cpupower: Add "perf" option to print AMD P-State information
>
>   tools/power/cpupower/Makefile                      |  6 +-
>   tools/power/cpupower/lib/acpi_cppc.c               | 59 +++++++++++++++
>   tools/power/cpupower/lib/acpi_cppc.h               | 21 ++++++
>   tools/power/cpupower/lib/cpufreq.c                 | 23 ++++--
>   tools/power/cpupower/lib/cpufreq.h                 | 12 +++
>   tools/power/cpupower/man/cpupower-frequency-info.1 |  3 +
>   tools/power/cpupower/utils/cpufreq-info.c          | 87 +++++++++-------------
>   tools/power/cpupower/utils/helpers/amd.c           | 77 +++++++++++++++++++
>   tools/power/cpupower/utils/helpers/cpuid.c         | 13 ++++
>   tools/power/cpupower/utils/helpers/helpers.h       | 22 ++++++
>   tools/power/cpupower/utils/helpers/misc.c          | 60 +++++++++++++++
>   11 files changed, 321 insertions(+), 62 deletions(-)
>   create mode 100644 tools/power/cpupower/lib/acpi_cppc.c
>   create mode 100644 tools/power/cpupower/lib/acpi_cppc.h
> ----------------------------------------------------------------

Pulled, thanks!
