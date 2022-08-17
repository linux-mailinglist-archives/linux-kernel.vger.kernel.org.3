Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A17597828
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 22:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242039AbiHQUmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 16:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234438AbiHQUmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:42:53 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60A5A4B34
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:42:50 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id f8so3800060wru.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=QoIOEkesOX6tbur9d8LUX/KnK9yP+5HJO4rZWjFEduQ=;
        b=oo6YcI+svIa1z/lmQgGZk8Q7nsJubPXcVjZ3MXayaefj28LfV9unJ0bstnGecbLg4/
         joafO8gg3o8U5bpaw00eXhbpZRm56NKp48fMmofwwyITDwTHTZprMtACGEQD7yqvfbHU
         Z00JRFZPqeSBTZxUO1LRfhlRlgGPgIKYxs8po0sOE/Z2Wt4CRllE36sRbc4xnGr7FStd
         H0n5zztUeXcpbLkZvvuf2rS125YurKv1KzrwRpSa1ggUy6wpN+yswAAJ9Q5B8oNAOlFf
         7xQxw6YKIhLKY7A/FTBOC0Zyi9mo5LZwOkUwxnUki39OOZxSYk5Y5NmUmYD8Yd75cAYM
         LsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=QoIOEkesOX6tbur9d8LUX/KnK9yP+5HJO4rZWjFEduQ=;
        b=j8x7UCkh0/MdNgjt+I8dhOfHMbNIDA0fOjV5jDwzBWXkJi8VU+3suEo3tFkmNtQovs
         /rJAPHdxOaFVa7PJrcKDy9P1+s4pPz2PHESkK2ZR84DxSrxkFrQlDsrqGk9iryCubiW0
         ENKmzYt+UJ0NYhZviOuqlcRjIMCbIe+JjOg5A9eVAl9sJcOpiu0nPBWHOEhLPBf1QNFA
         F6P5e3dup8UtCYq0Vw038qPR3ZWeGyYN3o7/cCMtL6iJ/e0hTMTbsngfwz1/4IsP8NPI
         6NqH2/rGZRhgcgg5PfHPSnIV374CyyB97XUq4HHh9YcdR701l6v0gQmjfRuNzvmh3W08
         8HlQ==
X-Gm-Message-State: ACgBeo3ZfNsBsuk1CaMNCLuQkuUJtHfkkF4McYtRe9lBpG2FO5Xgsiwb
        7HH8cDEZvJs0X+l0nA1ZZrtDjWAMDxFy3XyXFbJ9BQ==
X-Google-Smtp-Source: AA6agR6FyAyRCxabqIJ5BxKbWhGlZL1fWRf581nFccgDmzDA4dyuBzc74vyLFDaCXVIwBShKwiJ4vy4XH5CrRRL54lE=
X-Received: by 2002:adf:e28d:0:b0:21e:4c3b:b446 with SMTP id
 v13-20020adfe28d000000b0021e4c3bb446mr14789982wri.300.1660768968461; Wed, 17
 Aug 2022 13:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220817053930.769840-1-irogers@google.com> <20220817053930.769840-3-irogers@google.com>
 <YvzW7FMpjg04bbQy@kernel.org> <CAP-5=fW66XGfBAW7UCzYFG-5R1vF2DBPoxyg0h-qjErtuG9TcQ@mail.gmail.com>
 <Yv04JwLrULQHxjEY@kernel.org>
In-Reply-To: <Yv04JwLrULQHxjEY@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 17 Aug 2022 13:42:35 -0700
Message-ID: <CAP-5=fWjcz0XdSOUu8309Pg_B6DKdS_zpn+Pn-ZyxCBkK2s-WQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] perf mutex: Update use of pthread mutex/cond
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Weiguo Li <liwg06@foxmail.com>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Dario Petrillo <dario.pk1@gmail.com>,
        Wenyu Liu <liuwenyu7@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>,
        yaowenbin <yaowenbin1@huawei.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexandre Truong <alexandre.truong@arm.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Quentin Monnet <quentin@isovalent.com>,
        William Cohen <wcohen@redhat.com>,
        Andres Freund <andres@anarazel.de>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>,
        Colin Ian King <colin.king@intel.com>,
        James Clark <james.clark@arm.com>,
        Fangrui Song <maskray@google.com>,
        Stephane Eranian <eranian@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Lexi Shao <shaolexi@huawei.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 11:49 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Aug 17, 2022 at 06:16:31AM -0700, Ian Rogers escreveu:
> > On Wed, Aug 17, 2022 at 4:54 AM Arnaldo Carvalho de Melo <acme@kernel.o=
rg> wrote:
> > > > +++ b/tools/perf/tests/perf-record.c
> > > > @@ -2,8 +2,6 @@
> > > >  #include <errno.h>
> > > >  #include <inttypes.h>
> > > >  #include <linux/string.h>
> > > > -/* For the CLR_() macros */
> > > > -#include <pthread.h>
>
> > > why are removing these headers when the CLR_() macros are still in us=
e
> > > in this (and other) files?
>
> > If a file isn't using any pthread_ functions:
>
> > $ grep pthread tools/perf/tests/perf-record.c|wc -l
> > 0
>
> > and only using mutex_ functions. I was trying to remove unnecessary
> > header file #includes.
>
> > The comment says the #include is necessary for CLR_ macros:
> >
> > $ grep CLR_ tools/perf/tests/perf-record.c|wc -l
> > 0
>
> oops, one _ too many :-\
>
> > There is a however a CPU_CLR macro used. CPU_CLR is defined in sched.h
>
> Indeed the comment is wrong, it was about CPU_CLR() indeed:
>
> =E2=AC=A2[acme@toolbox perf]$ git blame tools/perf/tests/perf-record.c  |=
 grep CLR
> 1fbe7df819d9958f1 (Arnaldo Carvalho de Melo 2016-07-06 12:19:19 -0300   5=
) /* For the CLR_() macros */
> 16d00fee703866c61 (Jiri Olsa                2012-11-10 01:46:45 +0100  37=
)                              CPU_CLR(i, maskp);
> =E2=AC=A2[acme@toolbox perf]$ git show 1fbe7df819d9958f139b87014a2f0d5b34=
da76d5 | head -5
> commit 1fbe7df819d9958f139b87014a2f0d5b34da76d5
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Wed Jul 6 12:19:19 2016 -0300
>
>     perf tests: Add missing pthread.h include for CPU_*() macros
> =E2=AC=A2[acme@toolbox perf]$
>
> > which is #included immediately below. In any case this is unlikely to
> > break anything as there is always the transitive #include of
> > <pthread.h> via "mutex.h".
>
> We try not to get definitions for what is used in a .c file indirectly
> from what some .h file we include includes, for some reason at some
> point that indirection may be cleaned up.

Yep, a principle called include what you use (IWYU). This isn't a
violation here.

> > > These whould be best done in a separate patch with an explanation as =
to
> > > why it is not needed, is it being obtained from some other header tha=
t
> > > is more appropriate than pthread.h? etc.
> >
> > The old code used pthread_mutex_lock and so needs pthread.h, the new
> > code uses mutex_lock and so doesn't.
>
> It still uses things that are defined, somewhere, in pthread.h, as
> documented, if not in the buggy comment, in the 'git blame' reachable
> commit log message, which, unfortunately is incomplete, I should've have
> recorded where (what distro-version/libc-version) this oddity takes place=
.
>
> I think it was musl libc... lemme dig it...
>
> But then, the less a patch touches, the better, so these cleanups could
> be left for a separate analysis, where this current discussion would
> help clarify things and the "meat" of the patch would have already been
> processed.

So if you are removing uses of a function that a header file declares
it seems to make sense that you should at the same time remove the
#include rather than have 2 patches, one two remove the use and one to
remove the #include. I did the due diligence wrt CPU_CLR and that is
provided by sched.h. I suspect the underlying bug no longer exists. It
seems more IWYU to have 1 patch, so I think even with fewer patches
this part of the patch is correct.

> Patch granularity is important, for bisection and for reviewing, the
> smaller the patch, the less likely it will cause problems and also
> delay reviewing.
>
> Sometimes it isn't possible to make it simpler, smaller, I don't think
> this is one of those times.

Sure, as mentioned it was done this way to maintain the author's tag.
I'm not sure if the author is going to correct this.

> > > In general we prefer more granular patches, so that we help in bisect=
ing
> > > problems, so please break this patch into multiple pieces, say one fo=
r
> > > the 'perf bench' codebase, other for 'perf test', etc.
> >
> > Agreed. I was trying to maintain Pavithra's authorship where their
> > change was monolithic. Here are the stats:
>
> And that is commendable, but at the same time she entered this process
> to try and learn how to submit patches to the Linux kernel and projects
> that try to follow its practices, so this discussion is interesting in
> that sense.

Right, so I guess it is on me to cut this up *sigh*.

Thanks,
Ian


> - Arnaldo
>
> > $ git show 1694c66ea8d3720ec8a55ca3ac10ace61e319644|diffstat
> > bench/epoll-ctl.c               |   33 ++++++++++++-------------
> > bench/epoll-wait.c              |   33 ++++++++++++-------------
> > bench/futex-hash.c              |   33 ++++++++++++-------------
> > bench/futex-lock-pi.c           |   33 ++++++++++++-------------
> > bench/futex-requeue.c           |   33 ++++++++++++-------------
> > bench/futex-wake-parallel.c     |   33 ++++++++++++-------------
> > bench/futex-wake.c              |   33 ++++++++++++-------------
> > bench/numa.c                    |   93
> > +++++++++++++++++++++++++----------------------------------------------
> > builtin-lock.c                  |    1
> > builtin-record.c                |   13 ++++++---
> > builtin-sched.c                 |   67
> > ++++++++++++++++++++++++---------------------------
> > builtin-top.c                   |   40 +++++++++++++++---------------
> > tests/mmap-basic.c              |    2 -
> > tests/openat-syscall-all-cpus.c |    2 -
> > tests/perf-record.c             |    2 -
> > ui/browser.c                    |   20 +++++++--------
> > ui/browsers/annotate.c          |   12 ++++-----
> > ui/setup.c                      |    5 ++-
> > ui/tui/helpline.c               |    5 +--
> > ui/tui/progress.c               |    8 +++---
> > ui/tui/setup.c                  |    8 +++---
> > ui/tui/util.c                   |   18 ++++++-------
> > ui/ui.h                         |    4 +--
> > util/annotate.c                 |   13 ++++-----
> > util/annotate.h                 |    4 +--
> > util/bpf-event.h                |    1
> > util/dso.c                      |   12 ++++-----
> > util/dso.h                      |    4 +--
> > util/hist.c                     |    6 ++--
> > util/hist.h                     |    4 +--
> > util/mmap.h                     |    1
> > util/symbol.c                   |    4 +--
> > util/top.h                      |    5 ++-
> >  33 files changed, 281 insertions(+), 304 deletions(-)
> >
> > Some locks like dso->lock are used in a lot of places so untangling
> > this would be easiest as a rewrite. I was trying to avoid the rewrite
> > to give Pavithra the author's tag.
> >
> > Thanks,
> > Ian
> >
> > > - Arnaldo
> > >
> > > >
> > > >  #include <sched.h>
> > > >  #include <perf/mmap.h>
> > > > diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
> > > > index fa5bd5c20e96..78fb01d6ad63 100644
> > > > --- a/tools/perf/ui/browser.c
> > > > +++ b/tools/perf/ui/browser.c
> > > > @@ -268,9 +268,9 @@ void __ui_browser__show_title(struct ui_browser=
 *browser, const char *title)
> > > >
> > > >  void ui_browser__show_title(struct ui_browser *browser, const char=
 *title)
> > > >  {
> > > > -     pthread_mutex_lock(&ui__lock);
> > > > +     mutex_lock(&ui__lock);
> > > >       __ui_browser__show_title(browser, title);
> > > > -     pthread_mutex_unlock(&ui__lock);
> > > > +     mutex_unlock(&ui__lock);
> > > >  }
> > > >
> > > >  int ui_browser__show(struct ui_browser *browser, const char *title=
,
> > > > @@ -284,7 +284,7 @@ int ui_browser__show(struct ui_browser *browser=
, const char *title,
> > > >
> > > >       browser->refresh_dimensions(browser);
> > > >
> > > > -     pthread_mutex_lock(&ui__lock);
> > > > +     mutex_lock(&ui__lock);
> > > >       __ui_browser__show_title(browser, title);
> > > >
> > > >       browser->title =3D title;
> > > > @@ -295,16 +295,16 @@ int ui_browser__show(struct ui_browser *brows=
er, const char *title,
> > > >       va_end(ap);
> > > >       if (err > 0)
> > > >               ui_helpline__push(browser->helpline);
> > > > -     pthread_mutex_unlock(&ui__lock);
> > > > +     mutex_unlock(&ui__lock);
> > > >       return err ? 0 : -1;
> > > >  }
> > > >
> > > >  void ui_browser__hide(struct ui_browser *browser)
> > > >  {
> > > > -     pthread_mutex_lock(&ui__lock);
> > > > +     mutex_lock(&ui__lock);
> > > >       ui_helpline__pop();
> > > >       zfree(&browser->helpline);
> > > > -     pthread_mutex_unlock(&ui__lock);
> > > > +     mutex_unlock(&ui__lock);
> > > >  }
> > > >
> > > >  static void ui_browser__scrollbar_set(struct ui_browser *browser)
> > > > @@ -352,9 +352,9 @@ static int __ui_browser__refresh(struct ui_brow=
ser *browser)
> > > >
> > > >  int ui_browser__refresh(struct ui_browser *browser)
> > > >  {
> > > > -     pthread_mutex_lock(&ui__lock);
> > > > +     mutex_lock(&ui__lock);
> > > >       __ui_browser__refresh(browser);
> > > > -     pthread_mutex_unlock(&ui__lock);
> > > > +     mutex_unlock(&ui__lock);
> > > >
> > > >       return 0;
> > > >  }
> > > > @@ -390,10 +390,10 @@ int ui_browser__run(struct ui_browser *browse=
r, int delay_secs)
> > > >       while (1) {
> > > >               off_t offset;
> > > >
> > > > -             pthread_mutex_lock(&ui__lock);
> > > > +             mutex_lock(&ui__lock);
> > > >               err =3D __ui_browser__refresh(browser);
> > > >               SLsmg_refresh();
> > > > -             pthread_mutex_unlock(&ui__lock);
> > > > +             mutex_unlock(&ui__lock);
> > > >               if (err < 0)
> > > >                       break;
> > > >
> > > > diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/brow=
sers/annotate.c
> > > > index 44ba900828f6..9bc1076374ff 100644
> > > > --- a/tools/perf/ui/browsers/annotate.c
> > > > +++ b/tools/perf/ui/browsers/annotate.c
> > > > @@ -8,11 +8,11 @@
> > > >  #include "../../util/hist.h"
> > > >  #include "../../util/sort.h"
> > > >  #include "../../util/map.h"
> > > > +#include "../../util/mutex.h"
> > > >  #include "../../util/symbol.h"
> > > >  #include "../../util/evsel.h"
> > > >  #include "../../util/evlist.h"
> > > >  #include <inttypes.h>
> > > > -#include <pthread.h>
> > > >  #include <linux/kernel.h>
> > > >  #include <linux/string.h>
> > > >  #include <linux/zalloc.h>
> > > > @@ -319,7 +319,7 @@ static void annotate_browser__calc_percent(stru=
ct annotate_browser *browser,
> > > >
> > > >       browser->entries =3D RB_ROOT;
> > > >
> > > > -     pthread_mutex_lock(&notes->lock);
> > > > +     mutex_lock(&notes->lock);
> > > >
> > > >       symbol__calc_percent(sym, evsel);
> > > >
> > > > @@ -348,7 +348,7 @@ static void annotate_browser__calc_percent(stru=
ct annotate_browser *browser,
> > > >               }
> > > >               disasm_rb_tree__insert(browser, &pos->al);
> > > >       }
> > > > -     pthread_mutex_unlock(&notes->lock);
> > > > +     mutex_unlock(&notes->lock);
> > > >
> > > >       browser->curr_hot =3D rb_last(&browser->entries);
> > > >  }
> > > > @@ -474,10 +474,10 @@ static bool annotate_browser__callq(struct an=
notate_browser *browser,
> > > >       }
> > > >
> > > >       notes =3D symbol__annotation(dl->ops.target.sym);
> > > > -     pthread_mutex_lock(&notes->lock);
> > > > +     mutex_lock(&notes->lock);
> > > >
> > > >       if (!symbol__hists(dl->ops.target.sym, evsel->evlist->core.nr=
_entries)) {
> > > > -             pthread_mutex_unlock(&notes->lock);
> > > > +             mutex_unlock(&notes->lock);
> > > >               ui__warning("Not enough memory for annotating '%s' sy=
mbol!\n",
> > > >                           dl->ops.target.sym->name);
> > > >               return true;
> > > > @@ -486,7 +486,7 @@ static bool annotate_browser__callq(struct anno=
tate_browser *browser,
> > > >       target_ms.maps =3D ms->maps;
> > > >       target_ms.map =3D ms->map;
> > > >       target_ms.sym =3D dl->ops.target.sym;
> > > > -     pthread_mutex_unlock(&notes->lock);
> > > > +     mutex_unlock(&notes->lock);
> > > >       symbol__tui_annotate(&target_ms, evsel, hbt, browser->opts);
> > > >       sym_title(ms->sym, ms->map, title, sizeof(title), browser->op=
ts->percent_type);
> > > >       ui_browser__show_title(&browser->b, title);
> > > > diff --git a/tools/perf/ui/setup.c b/tools/perf/ui/setup.c
> > > > index 700335cde618..fd10dc6baf07 100644
> > > > --- a/tools/perf/ui/setup.c
> > > > +++ b/tools/perf/ui/setup.c
> > > > @@ -1,5 +1,4 @@
> > > >  // SPDX-License-Identifier: GPL-2.0
> > > > -#include <pthread.h>
> > > >  #include <dlfcn.h>
> > > >  #include <unistd.h>
> > > >
> > > > @@ -8,7 +7,7 @@
> > > >  #include "../util/hist.h"
> > > >  #include "ui.h"
> > > >
> > > > -pthread_mutex_t ui__lock =3D PTHREAD_MUTEX_INITIALIZER;
> > > > +struct mutex ui__lock;
> > > >  void *perf_gtk_handle;
> > > >  int use_browser =3D -1;
> > > >
> > > > @@ -76,6 +75,7 @@ int stdio__config_color(const struct option *opt =
__maybe_unused,
> > > >
> > > >  void setup_browser(bool fallback_to_pager)
> > > >  {
> > > > +     mutex_init(&ui__lock, /*pshared=3D*/false);
> > > >       if (use_browser < 2 && (!isatty(1) || dump_trace))
> > > >               use_browser =3D 0;
> > > >
> > > > @@ -118,4 +118,5 @@ void exit_browser(bool wait_for_ok)
> > > >       default:
> > > >               break;
> > > >       }
> > > > +     mutex_destroy(&ui__lock);
> > > >  }
> > > > diff --git a/tools/perf/ui/tui/helpline.c b/tools/perf/ui/tui/helpl=
ine.c
> > > > index 298d6af82fdd..db4952f5990b 100644
> > > > --- a/tools/perf/ui/tui/helpline.c
> > > > +++ b/tools/perf/ui/tui/helpline.c
> > > > @@ -2,7 +2,6 @@
> > > >  #include <stdio.h>
> > > >  #include <stdlib.h>
> > > >  #include <string.h>
> > > > -#include <pthread.h>
> > > >  #include <linux/kernel.h>
> > > >  #include <linux/string.h>
> > > >
> > > > @@ -33,7 +32,7 @@ static int tui_helpline__show(const char *format,=
 va_list ap)
> > > >       int ret;
> > > >       static int backlog;
> > > >
> > > > -     pthread_mutex_lock(&ui__lock);
> > > > +     mutex_lock(&ui__lock);
> > > >       ret =3D vscnprintf(ui_helpline__last_msg + backlog,
> > > >                       sizeof(ui_helpline__last_msg) - backlog, form=
at, ap);
> > > >       backlog +=3D ret;
> > > > @@ -45,7 +44,7 @@ static int tui_helpline__show(const char *format,=
 va_list ap)
> > > >               SLsmg_refresh();
> > > >               backlog =3D 0;
> > > >       }
> > > > -     pthread_mutex_unlock(&ui__lock);
> > > > +     mutex_unlock(&ui__lock);
> > > >
> > > >       return ret;
> > > >  }
> > > > diff --git a/tools/perf/ui/tui/progress.c b/tools/perf/ui/tui/progr=
ess.c
> > > > index 3d74af5a7ece..71b6c8d9474f 100644
> > > > --- a/tools/perf/ui/tui/progress.c
> > > > +++ b/tools/perf/ui/tui/progress.c
> > > > @@ -45,7 +45,7 @@ static void tui_progress__update(struct ui_progre=
ss *p)
> > > >       }
> > > >
> > > >       ui__refresh_dimensions(false);
> > > > -     pthread_mutex_lock(&ui__lock);
> > > > +     mutex_lock(&ui__lock);
> > > >       y =3D SLtt_Screen_Rows / 2 - 2;
> > > >       SLsmg_set_color(0);
> > > >       SLsmg_draw_box(y, 0, 3, SLtt_Screen_Cols);
> > > > @@ -56,7 +56,7 @@ static void tui_progress__update(struct ui_progre=
ss *p)
> > > >       bar =3D ((SLtt_Screen_Cols - 2) * p->curr) / p->total;
> > > >       SLsmg_fill_region(y, 1, 1, bar, ' ');
> > > >       SLsmg_refresh();
> > > > -     pthread_mutex_unlock(&ui__lock);
> > > > +     mutex_unlock(&ui__lock);
> > > >  }
> > > >
> > > >  static void tui_progress__finish(void)
> > > > @@ -67,12 +67,12 @@ static void tui_progress__finish(void)
> > > >               return;
> > > >
> > > >       ui__refresh_dimensions(false);
> > > > -     pthread_mutex_lock(&ui__lock);
> > > > +     mutex_lock(&ui__lock);
> > > >       y =3D SLtt_Screen_Rows / 2 - 2;
> > > >       SLsmg_set_color(0);
> > > >       SLsmg_fill_region(y, 0, 3, SLtt_Screen_Cols, ' ');
> > > >       SLsmg_refresh();
> > > > -     pthread_mutex_unlock(&ui__lock);
> > > > +     mutex_unlock(&ui__lock);
> > > >  }
> > > >
> > > >  static struct ui_progress_ops tui_progress__ops =3D {
> > > > diff --git a/tools/perf/ui/tui/setup.c b/tools/perf/ui/tui/setup.c
> > > > index b1be59b4e2a4..a3b8c397c24d 100644
> > > > --- a/tools/perf/ui/tui/setup.c
> > > > +++ b/tools/perf/ui/tui/setup.c
> > > > @@ -29,10 +29,10 @@ void ui__refresh_dimensions(bool force)
> > > >  {
> > > >       if (force || ui__need_resize) {
> > > >               ui__need_resize =3D 0;
> > > > -             pthread_mutex_lock(&ui__lock);
> > > > +             mutex_lock(&ui__lock);
> > > >               SLtt_get_screen_size();
> > > >               SLsmg_reinit_smg();
> > > > -             pthread_mutex_unlock(&ui__lock);
> > > > +             mutex_unlock(&ui__lock);
> > > >       }
> > > >  }
> > > >
> > > > @@ -170,10 +170,10 @@ void ui__exit(bool wait_for_ok)
> > > >                                   "Press any key...", 0);
> > > >
> > > >       SLtt_set_cursor_visibility(1);
> > > > -     if (!pthread_mutex_trylock(&ui__lock)) {
> > > > +     if (mutex_trylock(&ui__lock)) {
> > > >               SLsmg_refresh();
> > > >               SLsmg_reset_smg();
> > > > -             pthread_mutex_unlock(&ui__lock);
> > > > +             mutex_unlock(&ui__lock);
> > > >       }
> > > >       SLang_reset_tty();
> > > >       perf_error__unregister(&perf_tui_eops);
> > > > diff --git a/tools/perf/ui/tui/util.c b/tools/perf/ui/tui/util.c
> > > > index 0f562e2cb1e8..3c5174854ac8 100644
> > > > --- a/tools/perf/ui/tui/util.c
> > > > +++ b/tools/perf/ui/tui/util.c
> > > > @@ -95,7 +95,7 @@ int ui_browser__input_window(const char *title, c=
onst char *text, char *input,
> > > >               t =3D sep + 1;
> > > >       }
> > > >
> > > > -     pthread_mutex_lock(&ui__lock);
> > > > +     mutex_lock(&ui__lock);
> > > >
> > > >       max_len +=3D 2;
> > > >       nr_lines +=3D 8;
> > > > @@ -125,17 +125,17 @@ int ui_browser__input_window(const char *titl=
e, const char *text, char *input,
> > > >       SLsmg_write_nstring((char *)exit_msg, max_len);
> > > >       SLsmg_refresh();
> > > >
> > > > -     pthread_mutex_unlock(&ui__lock);
> > > > +     mutex_unlock(&ui__lock);
> > > >
> > > >       x +=3D 2;
> > > >       len =3D 0;
> > > >       key =3D ui__getch(delay_secs);
> > > >       while (key !=3D K_TIMER && key !=3D K_ENTER && key !=3D K_ESC=
) {
> > > > -             pthread_mutex_lock(&ui__lock);
> > > > +             mutex_lock(&ui__lock);
> > > >
> > > >               if (key =3D=3D K_BKSPC) {
> > > >                       if (len =3D=3D 0) {
> > > > -                             pthread_mutex_unlock(&ui__lock);
> > > > +                             mutex_unlock(&ui__lock);
> > > >                               goto next_key;
> > > >                       }
> > > >                       SLsmg_gotorc(y, x + --len);
> > > > @@ -147,7 +147,7 @@ int ui_browser__input_window(const char *title,=
 const char *text, char *input,
> > > >               }
> > > >               SLsmg_refresh();
> > > >
> > > > -             pthread_mutex_unlock(&ui__lock);
> > > > +             mutex_unlock(&ui__lock);
> > > >
> > > >               /* XXX more graceful overflow handling needed */
> > > >               if (len =3D=3D sizeof(buf) - 1) {
> > > > @@ -215,19 +215,19 @@ void __ui__info_window(const char *title, con=
st char *text, const char *exit_msg
> > > >
> > > >  void ui__info_window(const char *title, const char *text)
> > > >  {
> > > > -     pthread_mutex_lock(&ui__lock);
> > > > +     mutex_lock(&ui__lock);
> > > >       __ui__info_window(title, text, NULL);
> > > >       SLsmg_refresh();
> > > > -     pthread_mutex_unlock(&ui__lock);
> > > > +     mutex_unlock(&ui__lock);
> > > >  }
> > > >
> > > >  int ui__question_window(const char *title, const char *text,
> > > >                       const char *exit_msg, int delay_secs)
> > > >  {
> > > > -     pthread_mutex_lock(&ui__lock);
> > > > +     mutex_lock(&ui__lock);
> > > >       __ui__info_window(title, text, exit_msg);
> > > >       SLsmg_refresh();
> > > > -     pthread_mutex_unlock(&ui__lock);
> > > > +     mutex_unlock(&ui__lock);
> > > >       return ui__getch(delay_secs);
> > > >  }
> > > >
> > > > diff --git a/tools/perf/ui/ui.h b/tools/perf/ui/ui.h
> > > > index 9b6fdf06e1d2..99f8d2fe9bc5 100644
> > > > --- a/tools/perf/ui/ui.h
> > > > +++ b/tools/perf/ui/ui.h
> > > > @@ -2,11 +2,11 @@
> > > >  #ifndef _PERF_UI_H_
> > > >  #define _PERF_UI_H_ 1
> > > >
> > > > -#include <pthread.h>
> > > > +#include "../util/mutex.h"
> > > >  #include <stdbool.h>
> > > >  #include <linux/compiler.h>
> > > >
> > > > -extern pthread_mutex_t ui__lock;
> > > > +extern struct mutex ui__lock;
> > > >  extern void *perf_gtk_handle;
> > > >
> > > >  extern int use_browser;
> > > > diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.=
c
> > > > index 2c6a485c3de5..29d804d76145 100644
> > > > --- a/tools/perf/util/annotate.c
> > > > +++ b/tools/perf/util/annotate.c
> > > > @@ -35,7 +35,6 @@
> > > >  #include "arch/common.h"
> > > >  #include "namespaces.h"
> > > >  #include <regex.h>
> > > > -#include <pthread.h>
> > > >  #include <linux/bitops.h>
> > > >  #include <linux/kernel.h>
> > > >  #include <linux/string.h>
> > > > @@ -821,7 +820,7 @@ void symbol__annotate_zero_histograms(struct sy=
mbol *sym)
> > > >  {
> > > >       struct annotation *notes =3D symbol__annotation(sym);
> > > >
> > > > -     pthread_mutex_lock(&notes->lock);
> > > > +     mutex_lock(&notes->lock);
> > > >       if (notes->src !=3D NULL) {
> > > >               memset(notes->src->histograms, 0,
> > > >                      notes->src->nr_histograms * notes->src->sizeof=
_sym_hist);
> > > > @@ -829,7 +828,7 @@ void symbol__annotate_zero_histograms(struct sy=
mbol *sym)
> > > >                       memset(notes->src->cycles_hist, 0,
> > > >                               symbol__size(sym) * sizeof(struct cyc=
_hist));
> > > >       }
> > > > -     pthread_mutex_unlock(&notes->lock);
> > > > +     mutex_unlock(&notes->lock);
> > > >  }
> > > >
> > > >  static int __symbol__account_cycles(struct cyc_hist *ch,
> > > > @@ -1086,7 +1085,7 @@ void annotation__compute_ipc(struct annotatio=
n *notes, size_t size)
> > > >       notes->hit_insn =3D 0;
> > > >       notes->cover_insn =3D 0;
> > > >
> > > > -     pthread_mutex_lock(&notes->lock);
> > > > +     mutex_lock(&notes->lock);
> > > >       for (offset =3D size - 1; offset >=3D 0; --offset) {
> > > >               struct cyc_hist *ch;
> > > >
> > > > @@ -1105,7 +1104,7 @@ void annotation__compute_ipc(struct annotatio=
n *notes, size_t size)
> > > >                       notes->have_cycles =3D true;
> > > >               }
> > > >       }
> > > > -     pthread_mutex_unlock(&notes->lock);
> > > > +     mutex_unlock(&notes->lock);
> > > >  }
> > > >
> > > >  int addr_map_symbol__inc_samples(struct addr_map_symbol *ams, stru=
ct perf_sample *sample,
> > > > @@ -1258,13 +1257,13 @@ int disasm_line__scnprintf(struct disasm_li=
ne *dl, char *bf, size_t size, bool r
> > > >
> > > >  void annotation__init(struct annotation *notes)
> > > >  {
> > > > -     pthread_mutex_init(&notes->lock, NULL);
> > > > +     mutex_init(&notes->lock, /*pshared=3D*/false);
> > > >  }
> > > >
> > > >  void annotation__exit(struct annotation *notes)
> > > >  {
> > > >       annotated_source__delete(notes->src);
> > > > -     pthread_mutex_destroy(&notes->lock);
> > > > +     mutex_destroy(&notes->lock);
> > > >  }
> > > >
> > > >  static void annotation_line__add(struct annotation_line *al, struc=
t list_head *head)
> > > > diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.=
h
> > > > index 986f2bbe4870..3cbd883e4d7a 100644
> > > > --- a/tools/perf/util/annotate.h
> > > > +++ b/tools/perf/util/annotate.h
> > > > @@ -8,9 +8,9 @@
> > > >  #include <linux/types.h>
> > > >  #include <linux/list.h>
> > > >  #include <linux/rbtree.h>
> > > > -#include <pthread.h>
> > > >  #include <asm/bug.h>
> > > >  #include "symbol_conf.h"
> > > > +#include "mutex.h"
> > > >  #include "spark.h"
> > > >
> > > >  struct hist_browser_timer;
> > > > @@ -273,7 +273,7 @@ struct annotated_source {
> > > >  };
> > > >
> > > >  struct annotation {
> > > > -     pthread_mutex_t         lock;
> > > > +     struct mutex lock;
> > > >       u64                     max_coverage;
> > > >       u64                     start;
> > > >       u64                     hit_cycles;
> > > > diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-even=
t.h
> > > > index 144a8a24cc69..1bcbd4fb6c66 100644
> > > > --- a/tools/perf/util/bpf-event.h
> > > > +++ b/tools/perf/util/bpf-event.h
> > > > @@ -4,7 +4,6 @@
> > > >
> > > >  #include <linux/compiler.h>
> > > >  #include <linux/rbtree.h>
> > > > -#include <pthread.h>
> > > >  #include <api/fd/array.h>
> > > >  #include <stdio.h>
> > > >
> > > > diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> > > > index 5ac13958d1bd..c7a5b42d1311 100644
> > > > --- a/tools/perf/util/dso.c
> > > > +++ b/tools/perf/util/dso.c
> > > > @@ -795,7 +795,7 @@ dso_cache__free(struct dso *dso)
> > > >       struct rb_root *root =3D &dso->data.cache;
> > > >       struct rb_node *next =3D rb_first(root);
> > > >
> > > > -     pthread_mutex_lock(&dso->lock);
> > > > +     mutex_lock(&dso->lock);
> > > >       while (next) {
> > > >               struct dso_cache *cache;
> > > >
> > > > @@ -804,7 +804,7 @@ dso_cache__free(struct dso *dso)
> > > >               rb_erase(&cache->rb_node, root);
> > > >               free(cache);
> > > >       }
> > > > -     pthread_mutex_unlock(&dso->lock);
> > > > +     mutex_unlock(&dso->lock);
> > > >  }
> > > >
> > > >  static struct dso_cache *__dso_cache__find(struct dso *dso, u64 of=
fset)
> > > > @@ -841,7 +841,7 @@ dso_cache__insert(struct dso *dso, struct dso_c=
ache *new)
> > > >       struct dso_cache *cache;
> > > >       u64 offset =3D new->offset;
> > > >
> > > > -     pthread_mutex_lock(&dso->lock);
> > > > +     mutex_lock(&dso->lock);
> > > >       while (*p !=3D NULL) {
> > > >               u64 end;
> > > >
> > > > @@ -862,7 +862,7 @@ dso_cache__insert(struct dso *dso, struct dso_c=
ache *new)
> > > >
> > > >       cache =3D NULL;
> > > >  out:
> > > > -     pthread_mutex_unlock(&dso->lock);
> > > > +     mutex_unlock(&dso->lock);
> > > >       return cache;
> > > >  }
> > > >
> > > > @@ -1297,7 +1297,7 @@ struct dso *dso__new_id(const char *name, str=
uct dso_id *id)
> > > >               dso->root =3D NULL;
> > > >               INIT_LIST_HEAD(&dso->node);
> > > >               INIT_LIST_HEAD(&dso->data.open_entry);
> > > > -             pthread_mutex_init(&dso->lock, NULL);
> > > > +             mutex_init(&dso->lock, /*pshared=3D*/false);
> > > >               refcount_set(&dso->refcnt, 1);
> > > >       }
> > > >
> > > > @@ -1336,7 +1336,7 @@ void dso__delete(struct dso *dso)
> > > >       dso__free_a2l(dso);
> > > >       zfree(&dso->symsrc_filename);
> > > >       nsinfo__zput(dso->nsinfo);
> > > > -     pthread_mutex_destroy(&dso->lock);
> > > > +     mutex_destroy(&dso->lock);
> > > >       free(dso);
> > > >  }
> > > >
> > > > diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> > > > index 66981c7a9a18..58d94175e714 100644
> > > > --- a/tools/perf/util/dso.h
> > > > +++ b/tools/perf/util/dso.h
> > > > @@ -2,7 +2,6 @@
> > > >  #ifndef __PERF_DSO
> > > >  #define __PERF_DSO
> > > >
> > > > -#include <pthread.h>
> > > >  #include <linux/refcount.h>
> > > >  #include <linux/types.h>
> > > >  #include <linux/rbtree.h>
> > > > @@ -11,6 +10,7 @@
> > > >  #include <stdio.h>
> > > >  #include <linux/bitops.h>
> > > >  #include "build-id.h"
> > > > +#include "mutex.h"
> > > >
> > > >  struct machine;
> > > >  struct map;
> > > > @@ -145,7 +145,7 @@ struct dso_cache {
> > > >  struct auxtrace_cache;
> > > >
> > > >  struct dso {
> > > > -     pthread_mutex_t  lock;
> > > > +     struct mutex     lock;
> > > >       struct list_head node;
> > > >       struct rb_node   rb_node;       /* rbtree node sorted by long=
 name */
> > > >       struct rb_root   *root;         /* root of rbtree that rb_nod=
e is in */
> > > > diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> > > > index 1c085ab56534..bfce88e5eb0d 100644
> > > > --- a/tools/perf/util/hist.c
> > > > +++ b/tools/perf/util/hist.c
> > > > @@ -1622,13 +1622,13 @@ struct rb_root_cached *hists__get_rotate_en=
tries_in(struct hists *hists)
> > > >  {
> > > >       struct rb_root_cached *root;
> > > >
> > > > -     pthread_mutex_lock(&hists->lock);
> > > > +     mutex_lock(&hists->lock);
> > > >
> > > >       root =3D hists->entries_in;
> > > >       if (++hists->entries_in > &hists->entries_in_array[1])
> > > >               hists->entries_in =3D &hists->entries_in_array[0];
> > > >
> > > > -     pthread_mutex_unlock(&hists->lock);
> > > > +     mutex_unlock(&hists->lock);
> > > >
> > > >       return root;
> > > >  }
> > > > @@ -2805,7 +2805,7 @@ int __hists__init(struct hists *hists, struct=
 perf_hpp_list *hpp_list)
> > > >       hists->entries_in =3D &hists->entries_in_array[0];
> > > >       hists->entries_collapsed =3D RB_ROOT_CACHED;
> > > >       hists->entries =3D RB_ROOT_CACHED;
> > > > -     pthread_mutex_init(&hists->lock, NULL);
> > > > +     mutex_init(&hists->lock, /*pshared=3D*/false);
> > > >       hists->socket_filter =3D -1;
> > > >       hists->hpp_list =3D hpp_list;
> > > >       INIT_LIST_HEAD(&hists->hpp_formats);
> > > > diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> > > > index 7ed4648d2fc2..508428b2c1b2 100644
> > > > --- a/tools/perf/util/hist.h
> > > > +++ b/tools/perf/util/hist.h
> > > > @@ -4,10 +4,10 @@
> > > >
> > > >  #include <linux/rbtree.h>
> > > >  #include <linux/types.h>
> > > > -#include <pthread.h>
> > > >  #include "evsel.h"
> > > >  #include "color.h"
> > > >  #include "events_stats.h"
> > > > +#include "mutex.h"
> > > >
> > > >  struct hist_entry;
> > > >  struct hist_entry_ops;
> > > > @@ -98,7 +98,7 @@ struct hists {
> > > >       const struct dso        *dso_filter;
> > > >       const char              *uid_filter_str;
> > > >       const char              *symbol_filter_str;
> > > > -     pthread_mutex_t         lock;
> > > > +     struct mutex            lock;
> > > >       struct hists_stats      stats;
> > > >       u64                     event_stream;
> > > >       u16                     col_len[HISTC_NR_COLS];
> > > > diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
> > > > index cd8b0777473b..cd4ccec7f361 100644
> > > > --- a/tools/perf/util/mmap.h
> > > > +++ b/tools/perf/util/mmap.h
> > > > @@ -9,7 +9,6 @@
> > > >  #include <linux/bitops.h>
> > > >  #include <perf/cpumap.h>
> > > >  #include <stdbool.h>
> > > > -#include <pthread.h> // for cpu_set_t
> > > >  #ifdef HAVE_AIO_SUPPORT
> > > >  #include <aio.h>
> > > >  #endif
> > > > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > > > index a4b22caa7c24..656d9b4dd456 100644
> > > > --- a/tools/perf/util/symbol.c
> > > > +++ b/tools/perf/util/symbol.c
> > > > @@ -1800,7 +1800,7 @@ int dso__load(struct dso *dso, struct map *ma=
p)
> > > >       }
> > > >
> > > >       nsinfo__mountns_enter(dso->nsinfo, &nsc);
> > > > -     pthread_mutex_lock(&dso->lock);
> > > > +     mutex_lock(&dso->lock);
> > > >
> > > >       /* check again under the dso->lock */
> > > >       if (dso__loaded(dso)) {
> > > > @@ -1964,7 +1964,7 @@ int dso__load(struct dso *dso, struct map *ma=
p)
> > > >               ret =3D 0;
> > > >  out:
> > > >       dso__set_loaded(dso);
> > > > -     pthread_mutex_unlock(&dso->lock);
> > > > +     mutex_unlock(&dso->lock);
> > > >       nsinfo__mountns_exit(&nsc);
> > > >
> > > >       return ret;
> > > > diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
> > > > index 1c2c0a838430..a8b0d79bd96c 100644
> > > > --- a/tools/perf/util/top.h
> > > > +++ b/tools/perf/util/top.h
> > > > @@ -5,6 +5,7 @@
> > > >  #include "tool.h"
> > > >  #include "evswitch.h"
> > > >  #include "annotate.h"
> > > > +#include "mutex.h"
> > > >  #include "ordered-events.h"
> > > >  #include "record.h"
> > > >  #include <linux/types.h>
> > > > @@ -53,8 +54,8 @@ struct perf_top {
> > > >               struct ordered_events   *in;
> > > >               struct ordered_events    data[2];
> > > >               bool                     rotate;
> > > > -             pthread_mutex_t          mutex;
> > > > -             pthread_cond_t           cond;
> > > > +             struct mutex mutex;
> > > > +             struct cond cond;
> > > >       } qe;
> > > >  };
> > > >
> > > > --
> > > > 2.37.1.595.g718a3a8f04-goog
> > >
> > > --
> > >
> > > - Arnaldo
>
> --
>
> - Arnaldo
