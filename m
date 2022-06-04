Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F11653D6F7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 15:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348206AbiFDNNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 09:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbiFDNNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 09:13:33 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075B91A83B;
        Sat,  4 Jun 2022 06:13:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A4FE5CE0451;
        Sat,  4 Jun 2022 13:13:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D735FC3411D;
        Sat,  4 Jun 2022 13:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654348406;
        bh=Fx7NsHyw/wnT/ifpyQdku9zgx2YfCmodMydZ2ht+WKs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N3405iKkshru+uTBdYllfI2TlvOQnUsRTOLj9xsA1OZAmH+87fPopWSlEdRkYKTpD
         rBvnK/glwZFg2zNJ4c4YfkacobOA8Ve7EcwYskmCR5kTYwQl/L0kNVgH6M4Zt0uAdd
         5RtqXIRdnggnRDwNhz/Q0qcZbbR07cO5G29ZPjTZiq0/WigU49Uzw1/S9UpwFiG5A4
         EyDclFAQUpDqssh71lj9PQObov8MtQtc+gAK1GivZpyzXdNupFXxpTLXTDPRy3SB9C
         UqEqb26EbfK0kd0jZGKVC+Q7zDA2VGT9AaeUaevQaDDCq1yVHaUxzqbMl8V9EMPGwm
         uJCwO9DvqWwlA==
Received: by mail-il1-f175.google.com with SMTP id b11so9185179ilr.4;
        Sat, 04 Jun 2022 06:13:26 -0700 (PDT)
X-Gm-Message-State: AOAM530/uV/b2My9qY7fDhN8x9XTFbyu02H7Jdr08fkPUTWFyGfA+cCS
        2NBjWoTgKgNqm7Z1X/KXFNWYijePe7RvapOR1W0=
X-Google-Smtp-Source: ABdhPJzVTgy0qI7xz5RT7JYkXykWwcX2jyRnXI9fMZ3vb4uavZT1asZzwQ5XIoJg61AgvTvweMgN8DEFHKw47fbkwiw=
X-Received: by 2002:a92:194c:0:b0:2c8:2a07:74e7 with SMTP id
 e12-20020a92194c000000b002c82a0774e7mr8460476ilm.272.1654348406056; Sat, 04
 Jun 2022 06:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <Yps1Jw6PJdLBya1W@debian>
In-Reply-To: <Yps1Jw6PJdLBya1W@debian>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 4 Jun 2022 21:13:06 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4P_A4CVJp7Zh0YTJWP16Q5k6jo-+-=Q4C3Q7GjMAzRog@mail.gmail.com>
Message-ID: <CAAhV-H4P_A4CVJp7Zh0YTJWP16Q5k6jo-+-=Q4C3Q7GjMAzRog@mail.gmail.com>
Subject: Re: mainline build failure due to fa84f89395e0 ("irqchip/loongson-liointc:
 Fix build error for LoongArch")
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, WANG Xuerui <git@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
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

Hi, Sudip,

On Sat, Jun 4, 2022 at 8:38 PM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> Hi All,
>
> The latest mainline kernel branch fails to build for "mips loongson2k_defconfig"
> with the error:
>
> drivers/irqchip/irq-loongson-liointc.c: In function 'liointc_chained_handle_irq':
> drivers/irqchip/irq-loongson-liointc.c:60:20: error: implicit declaration of function 'cpu_logical_map' [-Werror=implicit-function-declaration]
>    60 |         int core = cpu_logical_map(smp_processor_id()) % LIOINTC_NUM_CORES;
>
>
> git bisect pointed to fa84f89395e0 ("irqchip/loongson-liointc: Fix build error for LoongArch")
>
> And, reverting it on top of mainline branch has fixed the build failure.
Jiaxun has already sent a patch to fix it.

Huacai
>
> --
> Regards
> Sudip
