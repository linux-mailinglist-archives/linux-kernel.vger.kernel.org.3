Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F6458C3F0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 09:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbiHHH2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 03:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234798AbiHHH2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 03:28:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6F95F67;
        Mon,  8 Aug 2022 00:28:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A112B80E06;
        Mon,  8 Aug 2022 07:28:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6468C433B5;
        Mon,  8 Aug 2022 07:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659943711;
        bh=tPouhsWrWeSLGPRJ2CCk3k/KN3kjGILIV+Z8gTm2VAU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oKeKBq6FszAFjZD3qfj8smVNP2EVteVhgqANSIaDOmIh/jlxJfZhb+JncOjNYNKGZ
         p3ZyZufCoXfxUEvMOPU1t6Y6X6hv5kVKg1iAej04/kJmGOrVHFNbGAn4pdINYN9HkW
         VAnNFSu4Me6G6MH3iqyZumCaR8e5sICJlcty9jApvJFl1yUK4+hggVZ60l9xBrlyHJ
         WxpWKb+Wek5vaO8q1axdHyhy+xmFUgOlCEc2tMjnWfkL21ZjUXlHyN8bB+oz53BhUn
         clCJSSzzxLENyx42APZhH6In5VFK8VaUp8h4+C34TT7Rd8wp1E47EPkhd6tohZIaxc
         YZy68o4KrB0Cg==
Received: by mail-ua1-f41.google.com with SMTP id z5so3221656uav.0;
        Mon, 08 Aug 2022 00:28:31 -0700 (PDT)
X-Gm-Message-State: ACgBeo2S3gW0USK8KzO+ajP0e4GCtZuGYhFXI1YwPR6ohF0e0PzG28e8
        rbbUl3xVj7/BABzU2qDTcJSTJSihYlOylOQu/iM=
X-Google-Smtp-Source: AA6agR5uxS9EGIOCSXauvLicZJ2wcmhNZcxFvQv1maHij2VoAjcI8GSlB3W5GMSDwjySqH4/j0WKfySN+RffatA+Xj4=
X-Received: by 2002:ab0:6716:0:b0:38c:cdcd:1556 with SMTP id
 q22-20020ab06716000000b0038ccdcd1556mr641466uam.63.1659943710677; Mon, 08 Aug
 2022 00:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220808090329.4763fe7b@canb.auug.org.au>
In-Reply-To: <20220808090329.4763fe7b@canb.auug.org.au>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 8 Aug 2022 15:28:19 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7b_exCTm5QBGz4Dm2zK8+0JjBasEv8V3VMxcfTbEc2Bg@mail.gmail.com>
Message-ID: <CAAhV-H7b_exCTm5QBGz4Dm2zK8+0JjBasEv8V3VMxcfTbEc2Bg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the loongarch tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Stephen,

On Mon, Aug 8, 2022 at 7:03 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the loongarch tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> drivers/acpi/tables.c: In function 'acpi_table_print_madt_entry':
> drivers/acpi/tables.c:213:14: error: 'ACPI_MADT_TYPE_CORE_PIC' undeclared (first use in this function); did you mean 'ACPI_MADT_TYPE_IO_SAPIC'?
>   213 |         case ACPI_MADT_TYPE_CORE_PIC:
>       |              ^~~~~~~~~~~~~~~~~~~~~~~
>       |              ACPI_MADT_TYPE_IO_SAPIC
> drivers/acpi/tables.c:213:14: note: each undeclared identifier is reported only once for each function it appears in
> In file included from include/linux/printk.h:573,
>                  from include/linux/kernel.h:29,
>                  from drivers/acpi/tables.c:13:
> drivers/acpi/tables.c:218:35: error: invalid use of undefined type 'struct acpi_madt_core_pic'
>   218 |                                  p->processor_id, p->core_id,
>       |                                   ^~
> include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
>   134 |                 func(&id, ##__VA_ARGS__);               \
>       |                             ^~~~~~~~~~~
> include/linux/dynamic_debug.h:162:9: note: in expansion of macro '_dynamic_func_call'
>   162 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
>       |         ^~~~~~~~~~~~~~~~~~
> include/linux/printk.h:588:9: note: in expansion of macro 'dynamic_pr_debug'
>   588 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
>       |         ^~~~~~~~~~~~~~~~
> drivers/acpi/tables.c:217:25: note: in expansion of macro 'pr_debug'
>   217 |                         pr_debug("CORE PIC (processor_id[0x%02x] core_id[0x%02x] %s)\n",
>       |                         ^~~~~~~~
> drivers/acpi/tables.c:218:52: error: invalid use of undefined type 'struct acpi_madt_core_pic'
>   218 |                                  p->processor_id, p->core_id,
>       |                                                    ^~
> include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
>   134 |                 func(&id, ##__VA_ARGS__);               \
>       |                             ^~~~~~~~~~~
> include/linux/dynamic_debug.h:162:9: note: in expansion of macro '_dynamic_func_call'
>   162 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
>       |         ^~~~~~~~~~~~~~~~~~
> include/linux/printk.h:588:9: note: in expansion of macro 'dynamic_pr_debug'
>   588 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
>       |         ^~~~~~~~~~~~~~~~
> drivers/acpi/tables.c:217:25: note: in expansion of macro 'pr_debug'
>   217 |                         pr_debug("CORE PIC (processor_id[0x%02x] core_id[0x%02x] %s)\n",
>       |                         ^~~~~~~~
> drivers/acpi/tables.c:219:36: error: invalid use of undefined type 'struct acpi_madt_core_pic'
>   219 |                                  (p->flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
>       |                                    ^~
> include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
>   134 |                 func(&id, ##__VA_ARGS__);               \
>       |                             ^~~~~~~~~~~
> include/linux/dynamic_debug.h:162:9: note: in expansion of macro '_dynamic_func_call'
>   162 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
>       |         ^~~~~~~~~~~~~~~~~~
> include/linux/printk.h:588:9: note: in expansion of macro 'dynamic_pr_debug'
>   588 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
>       |         ^~~~~~~~~~~~~~~~
> drivers/acpi/tables.c:217:25: note: in expansion of macro 'pr_debug'
>   217 |                         pr_debug("CORE PIC (processor_id[0x%02x] core_id[0x%02x] %s)\n",
>       |                         ^~~~~~~~
>
> Caused by commit
>
>   0541f3fad39f ("LoongArch: Parse MADT to get multi-processor information")
>
> I have used the loongarch tree from next-20220805 for today.
I will fix it today, thanks.

Huacai
>
> --
> Cheers,
> Stephen Rothwell
