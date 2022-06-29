Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF205601B8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 15:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbiF2NvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 09:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbiF2NvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 09:51:11 -0400
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02B018E34;
        Wed, 29 Jun 2022 06:51:10 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id x184so25324390ybg.12;
        Wed, 29 Jun 2022 06:51:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JCp/LRokJcxZDVsuGLGOHFR2m172HOBXIzph0VMMKOw=;
        b=UjCVWkrYTSMgHWZOrMmy9fV69edY0W7BFOZcHNd+hBJpA8u4kBbdTLemydBKsASnvy
         nRFhPqFTADEK/CLP1wKevqqQb9hxUuBHN4LXRfe7/XnYLIbZljC63P3DWzl0/jxawPal
         lcq6FMapJN+eGsFNQMIIYLG3ZV1j/LrqLZCTHY3ZWy/TR981Ga32lnPjyhFaw70ziNDo
         N4jDyG2gpaCHe/9BoIAqFkgO3zubLRKC+5kxdMlbthg6UDg5gmjQlCzSmidlgVbSVvmh
         KiLeMC03MoLt54XBXc7f1EP/6+H5mIhqNLjXjL64UJKZRLpSeE2QhxUz3wQv346U2dVX
         irMw==
X-Gm-Message-State: AJIora8EvdiBBblWEZkG1odDKU9iyEBoKNB9e3Xcz32uVn7nar0ktTJI
        oBtHjRBPJjvrgmWdIpPl5OQqvQBtBBXrAdGVqrw=
X-Google-Smtp-Source: AGRyM1s66IF0TiL7HjPl7I4lBUzShSoaC6NNemCaiaGJtRsPoy7MMeZdcDP+G6yttdeXcBU4a++p3p7oNEA0ycJSE6M=
X-Received: by 2002:a25:664f:0:b0:66c:d0f4:36cc with SMTP id
 z15-20020a25664f000000b0066cd0f436ccmr3368498ybm.482.1656510669730; Wed, 29
 Jun 2022 06:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220627165047.336669-1-sudeep.holla@arm.com> <20220629130644.1258904-1-sudeep.holla@arm.com>
In-Reply-To: <20220629130644.1258904-1-sudeep.holla@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Jun 2022 15:50:58 +0200
Message-ID: <CAJZ5v0jdbS9HNfZ5N=M9jDCOp5uiQ5L30LA6haxpoG6QUFrNbw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Remove the unused find_acpi_cpu_cache_topology()
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Atish Patra <atishp@rivosinc.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wang Qing <wangqing@vivo.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
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

On Wed, Jun 29, 2022 at 3:07 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> The sole user of this find_acpi_cpu_cache_topology() was arm64 topology
> which is now consolidated into the generic arch_topology without the need
> of this function.
>
> Drop the unused function find_acpi_cpu_cache_topology().
>
> Reported-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/acpi/pptt.c  | 37 -------------------------------------
>  include/linux/acpi.h |  5 -----
>  2 files changed, 42 deletions(-)
>
> Hi Rafael,
>
> This is another patch that I would like to be part of the series[1].
> Please ack the same if you are OK to route this via Greg. I am avoiding
> to repost the whole series just for this one additional patch for now.

Sure.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> [1] https://lore.kernel.org/all/20220627165047.336669-1-sudeep.holla@arm.com/
>
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index 763f021d45e6..dd3222a15c9c 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -691,43 +691,6 @@ int find_acpi_cpu_topology(unsigned int cpu, int level)
>         return find_acpi_cpu_topology_tag(cpu, level, 0);
>  }
>
> -/**
> - * find_acpi_cpu_cache_topology() - Determine a unique cache topology value
> - * @cpu: Kernel logical CPU number
> - * @level: The cache level for which we would like a unique ID
> - *
> - * Determine a unique ID for each unified cache in the system
> - *
> - * Return: -ENOENT if the PPTT doesn't exist, or the CPU cannot be found.
> - * Otherwise returns a value which represents a unique topological feature.
> - */
> -int find_acpi_cpu_cache_topology(unsigned int cpu, int level)
> -{
> -       struct acpi_table_header *table;
> -       struct acpi_pptt_cache *found_cache;
> -       acpi_status status;
> -       u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
> -       struct acpi_pptt_processor *cpu_node = NULL;
> -       int ret = -1;
> -
> -       status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
> -       if (ACPI_FAILURE(status)) {
> -               acpi_pptt_warn_missing();
> -               return -ENOENT;
> -       }
> -
> -       found_cache = acpi_find_cache_node(table, acpi_cpu_id,
> -                                          CACHE_TYPE_UNIFIED,
> -                                          level,
> -                                          &cpu_node);
> -       if (found_cache)
> -               ret = ACPI_PTR_DIFF(cpu_node, table);
> -
> -       acpi_put_table(table);
> -
> -       return ret;
> -}
> -
>  /**
>   * find_acpi_cpu_topology_package() - Determine a unique CPU package value
>   * @cpu: Kernel logical CPU number
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 4f82a5bc6d98..7b96a8bff6d2 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1429,7 +1429,6 @@ int find_acpi_cpu_topology(unsigned int cpu, int level);
>  int find_acpi_cpu_topology_cluster(unsigned int cpu);
>  int find_acpi_cpu_topology_package(unsigned int cpu);
>  int find_acpi_cpu_topology_hetero_id(unsigned int cpu);
> -int find_acpi_cpu_cache_topology(unsigned int cpu, int level);
>  #else
>  static inline int acpi_pptt_cpu_is_thread(unsigned int cpu)
>  {
> @@ -1451,10 +1450,6 @@ static inline int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
>  {
>         return -EINVAL;
>  }
> -static inline int find_acpi_cpu_cache_topology(unsigned int cpu, int level)
> -{
> -       return -EINVAL;
> -}
>  #endif
>
>  #ifdef CONFIG_ACPI_PCC
> --
> 2.37.0
>
