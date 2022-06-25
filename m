Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014AE55A759
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 07:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbiFYFdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 01:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiFYFdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 01:33:06 -0400
X-Greylist: delayed 48680 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Jun 2022 22:32:59 PDT
Received: from forward500p.mail.yandex.net (forward500p.mail.yandex.net [77.88.28.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE3B5FE0;
        Fri, 24 Jun 2022 22:32:58 -0700 (PDT)
Received: from sas1-0e0150e31af0.qloud-c.yandex.net (sas1-0e0150e31af0.qloud-c.yandex.net [IPv6:2a02:6b8:c14:392a:0:640:e01:50e3])
        by forward500p.mail.yandex.net (Yandex) with ESMTP id 7AF10F05027;
        Sat, 25 Jun 2022 08:32:56 +0300 (MSK)
Received: from sas2-cc22fd2335f8.qloud-c.yandex.net (sas2-cc22fd2335f8.qloud-c.yandex.net [2a02:6b8:c08:6c82:0:640:cc22:fd23])
        by sas1-0e0150e31af0.qloud-c.yandex.net (mxback/Yandex) with ESMTP id xFjlaQOfax-WufmqaGT;
        Sat, 25 Jun 2022 08:32:56 +0300
X-Yandex-Fwd: 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1656135176;
        bh=T7iFQChTVP8pQJbKquVBw3SXg4q3eSNB/OuZ7Wdi5nY=;
        h=In-Reply-To:Subject:Cc:To:From:References:Date:Message-ID;
        b=REi6Fi33vfxc6G8PQgKXwwVO4u9o8q/VvoTAvqLRbNsTxW9hdIp06YqD/hCHmNnSO
         xW23Xm7/p0kMv4ZWgW5/tFLCLuJDC/aWx13KQOXFw8lIcbM8cATPtbMXbeuVQsq/jv
         OFGm9C4oeoJ1feYjSmYn9YrtoWkSf4F/HqGZj6vI=
Authentication-Results: sas1-0e0150e31af0.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by sas2-cc22fd2335f8.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id gseD0Q4hf9-WsNK6FZJ;
        Sat, 25 Jun 2022 08:32:55 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Date:   Sat, 25 Jun 2022 08:32:53 +0300
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Anup Patel <anup@brainfault.org>,
        =?UTF-8?B?Sm/Do28gTcOhcmlv?= Domingos 
        <joao.mario@tecnico.ulisboa.pt>, linux <linux@yadro.com>,
        Nikita Shubin <n.shubin@yadro.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v4 3/5] perf arch events: riscv arch std event files
Message-ID: <20220625083253.61b3e0db@redslave.neermore.group>
In-Reply-To: <CAOnJCU+B+dXXhqL6CYRG7Lhr_QWwyxrDZdGZG6HphnTEE9o5Mw@mail.gmail.com>
References: <20220624160117.3206-1-nikita.shubin@maquefel.me>
        <20220624160117.3206-4-nikita.shubin@maquefel.me>
        <CAOnJCU+B+dXXhqL6CYRG7Lhr_QWwyxrDZdGZG6HphnTEE9o5Mw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Atish!

On Fri, 24 Jun 2022 10:01:07 -0700
Atish Patra <atishp@atishpatra.org> wrote:

> On Fri, Jun 24, 2022 at 9:01 AM Nikita Shubin
> <nikita.shubin@maquefel.me> wrote:
> >
> > From: Nikita Shubin <n.shubin@yadro.com>
> >
> > cycles, time and instret counters are defined by RISC-V privileged
> > spec and they should be available on any RISC-V implementation,
> > epose them to arch std event files, so they can be reused by
> > particular PMU bindings.
> >
> > Derived-from-code-by: Jo=C3=A3o M=C3=A1rio Domingos
> > <joao.mario@tecnico.ulisboa.pt> Signed-off-by: Nikita Shubin
> > <n.shubin@yadro.com> =20
>=20
> Why do we need this ? The PMU driver already parses the standard perf
> events. So you can pass -e cycles -e instructions.
>=20
> Even though time is described as a counter and accessibility
> controlled by mcounteren, you can not start/stop it (no bit in
> mcountinhibit).
> Thus, it can't be used from perf.

My first thought was that we can use cycle, time, instret on any RISC-V
platform even without any bindings, but as you pointed out it's
indeed useless.

I'll drop this one.

>=20
> > ---
> >  .../pmu-events/arch/riscv/riscv-generic.json  | 20
> > +++++++++++++++++++ 1 file changed, 20 insertions(+)
> >  create mode 100644
> > tools/perf/pmu-events/arch/riscv/riscv-generic.json
> >
> > diff --git a/tools/perf/pmu-events/arch/riscv/riscv-generic.json
> > b/tools/perf/pmu-events/arch/riscv/riscv-generic.json new file mode
> > 100644 index 000000000000..a7ffbe87a0f7
> > --- /dev/null
> > +++ b/tools/perf/pmu-events/arch/riscv/riscv-generic.json
> > @@ -0,0 +1,20 @@
> > +[
> > +  {
> > +    "PublicDescription": "CPU Cycles",
> > +    "EventCode": "0x00",
> > +    "EventName": "riscv_cycles",
> > +    "BriefDescription": "CPU cycles RISC-V generic counter"
> > +  },
> > +  {
> > +    "PublicDescription": "CPU Time",
> > +    "EventCode": "0x01",
> > +    "EventName": "riscv_time",
> > +    "BriefDescription": "CPU time RISC-V generic counter"
> > +  },
> > +  {
> > +    "PublicDescription": "CPU Instructions",
> > +    "EventCode": "0x02",
> > +    "EventName": "riscv_instret",
> > +    "BriefDescription": "CPU retired instructions RISC-V generic
> > counter"
> > +  }
> > +]
> > --
> > 2.35.1
> > =20
>=20
>=20

