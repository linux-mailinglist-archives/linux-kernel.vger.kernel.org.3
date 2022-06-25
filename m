Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B8855A75A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 07:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbiFYFj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 01:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiFYFj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 01:39:27 -0400
Received: from forward500j.mail.yandex.net (forward500j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393954DF68;
        Fri, 24 Jun 2022 22:39:23 -0700 (PDT)
Received: from iva1-5d4bed9ec33e.qloud-c.yandex.net (iva1-5d4bed9ec33e.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:298:0:640:5d4b:ed9e])
        by forward500j.mail.yandex.net (Yandex) with ESMTP id 2E2AA6CB8553;
        Sat, 25 Jun 2022 08:39:21 +0300 (MSK)
Received: from iva6-2d18925256a6.qloud-c.yandex.net (iva6-2d18925256a6.qloud-c.yandex.net [2a02:6b8:c0c:7594:0:640:2d18:9252])
        by iva1-5d4bed9ec33e.qloud-c.yandex.net (mxback/Yandex) with ESMTP id 6mNwP7t9KO-dJfSARhe;
        Sat, 25 Jun 2022 08:39:21 +0300
X-Yandex-Fwd: 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1656135561;
        bh=sO6lv1ZaVsGCGLQcMcTq6F56qYmSsejjTXP/P42zzXY=;
        h=In-Reply-To:Subject:Cc:To:From:References:Date:Message-ID;
        b=o5oyqrUGzYOQV9pIoheCfiSYg/iYp5RNTfmP5Rqp6hyA0t2jBZUjqDsLrpwofU/i+
         eT+y4CEGRYKpEvQ+C4PmFKo3hxCJ4qhe5/KbXXbuz3R4uL4axfkLIoroPBsNLsXg5O
         GeOELEHAjAXBeCZ8qbTccK8xNPq6vUqHQfcKiAiE=
Authentication-Results: iva1-5d4bed9ec33e.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by iva6-2d18925256a6.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id FJ8J2gkSvz-dHMu2Cgc;
        Sat, 25 Jun 2022 08:39:18 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Date:   Sat, 25 Jun 2022 08:39:16 +0300
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Anup Patel <anup@brainfault.org>,
        =?UTF-8?B?Sm/Do28gTcOhcmlv?= Domingos 
        <joao.mario@tecnico.ulisboa.pt>, linux <linux@yadro.com>,
        Nikita Shubin <n.shubin@yadro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 0/5] RISC-V: Create unique identification for SoC PMU
Message-ID: <20220625083916.66e75def@redslave.neermore.group>
In-Reply-To: <CAOnJCU+2mOMj7MPzLKVZQ46gRs=ghxP6FK6oWkss0DfN_si3DQ@mail.gmail.com>
References: <20220624160117.3206-1-nikita.shubin@maquefel.me>
        <CAOnJCU+2mOMj7MPzLKVZQ46gRs=ghxP6FK6oWkss0DfN_si3DQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Atish!

On Fri, 24 Jun 2022 10:05:34 -0700
Atish Patra <atishp@atishpatra.org> wrote:

> On Fri, Jun 24, 2022 at 9:01 AM Nikita Shubin
> <nikita.shubin@maquefel.me> wrote:
> >
> > From: Nikita Shubin <n.shubin@yadro.com>
> >
> > This series aims to provide matching vendor SoC with corresponded
> > JSON bindings.
> >
> > The ID string is proposed to be in form of
> > MVENDORID-MARCHID-MIMPID, for example for Sifive Unmatched the
> > corresponding string will be:
> >
> > 0x489-0x8000000000000007-0x[[:xdigit:]]+,v1,sifive/u74,core
> >
> > Where MIMPID can vary as all impl supported the same number of
> > events, this might not be true for all future SoC however.
> >
> > Also added 3 counters which are standart for all RISC-V
> > implementations and SBI firmware events prerry names, as any
> > firmware that supports SBI PMU should also support firmare events.
> >
> > Link:
> > https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/riscv-sbi.adoc
> > Link:
> > https://patchwork.kernel.org/project/linux-riscv/list/?series=648017
> > --- v3->v4:
> > - drop pmuid in riscv_pmu_sbi, we are using /proc/cpuinfo
> > - rework util/header.c to use /proc/cpuinfo
> > - add SBI firmware events
> > - add firmware and std arch events to U74 pmu bindings
> > - change U74 id string and description in mapfile.csv
> > ---
> > Nikita Shubin (5):
> >   drivers/perf: riscv_pmu_sbi: perf format
> >   perf tools riscv: Add support for get_cpuid_str function
> >   perf arch events: riscv arch std event files
> >   perf arch events: riscv sbi firmare std event files
> >   perf vendor events riscv: add Sifive U74 JSON file
> >
> >  drivers/perf/riscv_pmu_sbi.c                  |  20 +++
> >  tools/perf/arch/riscv/util/Build              |   1 +
> >  tools/perf/arch/riscv/util/header.c           | 109 ++++++++++++++
> >  tools/perf/pmu-events/arch/riscv/mapfile.csv  |  17 +++
> >  .../pmu-events/arch/riscv/riscv-generic.json  |  20 +++
> >  .../arch/riscv/riscv-sbi-firmware.json        | 134
> > ++++++++++++++++++ .../arch/riscv/sifive/u74/firmware.json       |
> > 68 +++++++++ .../arch/riscv/sifive/u74/generic.json        |  11 ++
> >  .../arch/riscv/sifive/u74/instructions.json   |  92 ++++++++++++
> >  .../arch/riscv/sifive/u74/memory.json         |  32 +++++
> >  .../arch/riscv/sifive/u74/microarch.json      |  57 ++++++++
> >  11 files changed, 561 insertions(+)
> >  create mode 100644 tools/perf/arch/riscv/util/header.c
> >  create mode 100644 tools/perf/pmu-events/arch/riscv/mapfile.csv
> >  create mode 100644
> > tools/perf/pmu-events/arch/riscv/riscv-generic.json create mode
> > 100644 tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json
> > create mode 100644
> > tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json create
> > mode 100644
> > tools/perf/pmu-events/arch/riscv/sifive/u74/generic.json create
> > mode 100644
> > tools/perf/pmu-events/arch/riscv/sifive/u74/instructions.json
> > create mode 100644
> > tools/perf/pmu-events/arch/riscv/sifive/u74/memory.json create mode
> > 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/microarch.json
> >
> > --
> > 2.35.1
> >  
> 
> Thanks Nikita for reworking on the patches. It is good to specify that
> this series now depends
> on Anup's patch[1] that adds the mvendorid/mimpid to the
> /proc/cpuinfo.
> 
> [1] https://lkml.org/lkml/2022/6/20/498
> 

I will correct the remarks and fire a v5 next week then, hope some more
comments will rise for current version.

Do you have any thoughts or comments on cpuid form
"MVENDORID-MARCHID-MIMPID" ?

