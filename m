Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5021C59EB85
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 20:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiHWSx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 14:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234006AbiHWSv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:51:28 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB617C533;
        Tue, 23 Aug 2022 10:15:12 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-31f445bd486so396548217b3.13;
        Tue, 23 Aug 2022 10:15:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=xSFNOJlym8FyrOBEvPYLVgoTndKDA46syAL7gGM1hOQ=;
        b=6o/5GvxRGZiJsEfz6BbwvqQEKK55W3NqRxvr0QHdJzQ+X0EMkO12daAOG6Ynet9kBc
         1/+Nw6p8COC/akG5Fu8B/UpPmbAZE69E0ybAi8G7nnnYM9sOYdA1RyI02ev347wcniRn
         53YtsdKY31Yu+qpaC45lGoxRA1omYkWtAor15a6XmREWVIr9azc8dUXmFDtc5y0vN/4X
         65aGk8oDqn34JXBYcufYS5EaV21qLDPwNS/DrFkMcPY6Q2KSTvGVFlasTOjOhxjk8R7X
         hLW8W6KBP+RRvd8wvMM5/S1cy4vHDjHbbixcZmB2F5n8SvvotnsWeXKqanuiNGqkTCm1
         3Cnw==
X-Gm-Message-State: ACgBeo0SGQDj7xWm2nWGv/sVHfoRpla0UBtBNGFRtyUYRZmQmsSeYYAr
        MP5kYLoR76TgBNUJ/BsB4Z/HBtNyK79M268OPjI=
X-Google-Smtp-Source: AA6agR6wVbKtF7UDOTRRPr2VBYorKqh9xH2F7ddWUbFhnA2Q6INyF/YwWXao1fhCx13Aln4bqi0l+/jeBbnoJGIgFqc=
X-Received: by 2002:a81:9906:0:b0:2db:640f:49d8 with SMTP id
 q6-20020a819906000000b002db640f49d8mr7277324ywg.326.1661274912179; Tue, 23
 Aug 2022 10:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220822091416.6177-1-zeming@nfschina.com>
In-Reply-To: <20220822091416.6177-1-zeming@nfschina.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 Aug 2022 19:15:01 +0200
Message-ID: <CAJZ5v0iFW4OxhWrPiBOvg7AneEuey27sFKYH_XEWSbA+qNppDg@mail.gmail.com>
Subject: Re: [PATCH] power/acpi: Remove unnecessary return in acpi_os_** function;
To:     Li zeming <zeming@nfschina.com>
Cc:     Robert Moore <robert.moore@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
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

On Mon, Aug 22, 2022 at 11:16 AM Li zeming <zeming@nfschina.com> wrote:
>
> Remove the return in the function; it looks clearer.
>
> Signed-off-by: Li zeming <zeming@nfschina.com>

This is ACPICA code, so please submit changes against it to the
upstream ACPICA project on GitHub.  Thanks!

> ---
>  tools/power/acpi/os_specific/service_layers/osunixxf.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/tools/power/acpi/os_specific/service_layers/osunixxf.c b/tools/power/acpi/os_specific/service_layers/osunixxf.c
> index b3651a04d68c..127630c38f1a 100644
> --- a/tools/power/acpi/os_specific/service_layers/osunixxf.c
> +++ b/tools/power/acpi/os_specific/service_layers/osunixxf.c
> @@ -510,8 +510,6 @@ void *acpi_os_map_memory(acpi_physical_address where, acpi_size length)
>
>  void acpi_os_unmap_memory(void *where, acpi_size length)
>  {
> -
> -       return;
>  }
>  #endif
>
> @@ -1313,5 +1311,4 @@ acpi_os_execute(acpi_execute_type type,
>
>  void acpi_os_wait_events_complete(void)
>  {
> -       return;
>  }
> --
> 2.18.2
>
