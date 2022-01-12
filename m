Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5A848BEB2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 07:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348368AbiALGt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 01:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237061AbiALGt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 01:49:56 -0500
Received: from forward501j.mail.yandex.net (forward501j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A09C06173F;
        Tue, 11 Jan 2022 22:49:55 -0800 (PST)
Received: from sas1-df7c155f48c6.qloud-c.yandex.net (sas1-df7c155f48c6.qloud-c.yandex.net [IPv6:2a02:6b8:c08:e119:0:640:df7c:155f])
        by forward501j.mail.yandex.net (Yandex) with ESMTP id DD562623BBF;
        Wed, 12 Jan 2022 09:49:50 +0300 (MSK)
Received: from sas1-1f4a002bb12a.qloud-c.yandex.net (sas1-1f4a002bb12a.qloud-c.yandex.net [2a02:6b8:c14:3908:0:640:1f4a:2b])
        by sas1-df7c155f48c6.qloud-c.yandex.net (mxback/Yandex) with ESMTP id 9tpYaeyDtY-nnfm0EEP;
        Wed, 12 Jan 2022 09:49:50 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1641970190;
        bh=LrY/XSIFvSNDS6egDU78GYzQ11qgsupzEbcN4Qn848A=;
        h=In-Reply-To:Subject:To:From:References:Date:Message-ID:Cc;
        b=dM/tw3jDK4MgFn+LCSfi91j+gng3SfKA77IO3ZpGl6opowJ6ZnuEB4gUXOtUhRO98
         LFDR6Sco76MuUbAwVeta3aTrJPksgfOLUylIQqxgWOhRIgjTTK3yl084nn8qOt+GWQ
         cJnPgZXWf9TtU1I1XaQ93kG3mveybUY6LF4HBBNI=
Authentication-Results: sas1-df7c155f48c6.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by sas1-1f4a002bb12a.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id dfV5spHKxz-nlP0OnIl;
        Wed, 12 Jan 2022 09:49:47 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 2
Date:   Wed, 12 Jan 2022 09:49:45 +0300
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     Atish Patra <atishp@rivosinc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux <linux@yadro.com>, Nikita Shubin <n.shubin@yadro.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Song Liu <song@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] perf tools: Add 'm' event modifier for counting
Message-ID: <20220112094945.49362e4f@redslave.neermore.group>
In-Reply-To: <B6E7919C-9414-4CC1-BB86-7D358085CECD@jrtc27.com>
References: <20220111142054.18733-1-nikita.shubin@maquefel.me>
        <B6E7919C-9414-4CC1-BB86-7D358085CECD@jrtc27.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 14:29:15 +0000
Jessica Clarke <jrtc27@jrtc27.com> wrote:

Hello Jessica!

> On 11 Jan 2022, at 14:20, Nikita Shubin <nikita.shubin@maquefel.me>
> wrote:
> > 
> > From: Nikita Shubin <n.shubin@yadro.com>
> > 
> > This patch is a proposal to add Machine Mode modifier that is
> > currently available only for RISC-V for perf tool.
> > 
> > We don't currently have a level that is lower than kernel, so i
> > don't see we can reuse something existing for this purpose.
> > 
> > The exclude_machine bit seems harmless to as no one will proccess
> > it apart of riscv.  
> 
> Armv8 has equivalent bits in PMEVTYPER<n>_EL0 and PMCCFILTR_EL0 for
> EL-based filtering, which includes filtering EL3.
> 

Thank your for your tip, i ll study it and see if this is a good way to
go.

> Jess
> 
> > Patch depends on Atish Patra PMU series:
> > https://lwn.net/Articles/879905/
> > + some modifications to pass execlude event to SBI PMU extension
> > 
> > Tested with qemu.
> > 
> > Nikita Shubin (1):
> >  perf tools: Add 'm' event modifier for counting machine
> > 
> > include/uapi/linux/perf_event.h        |  3 ++-
> > tools/include/uapi/linux/perf_event.h  |  3 ++-
> > tools/perf/Documentation/perf-list.txt |  1 +
> > tools/perf/tests/parse-events.c        | 18 ++++++++++++++++++
> > tools/perf/util/evsel.c                |  4 +++-
> > tools/perf/util/parse-events.c         | 18 +++++++++++++-----
> > tools/perf/util/parse-events.l         |  2 +-
> > 7 files changed, 40 insertions(+), 9 deletions(-)
> > 
> > -- 
> > 2.31.1
> > 
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv  
> 

