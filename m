Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FA55A4639
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 11:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiH2JjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 05:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiH2JjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 05:39:01 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D76D5C9DF
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 02:38:59 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-334dc616f86so180893727b3.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 02:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=GBvqua5cjMzjDQ/XgF9SZ1D4y+QsnVuyrt4amhV4btE=;
        b=dx6bRQ4JN/hF+3326YxFT0DmQuGRpE34IYiS96EVX69SRQeKSaYPwt5CrXJyN5/6Jy
         LU4sCb/nzEwY7rPM8KQoAIxIfvdbcNm2n40rDMqVfcTJScYRUNc6PFux701CkDOaVS3I
         p/4Hy2JiSHOOSzChWW0xl4APo4fnylJHJ9WrJKbGlSalEnDMAaddVjR/x9qZqTHorbQN
         oIVFtRs/0W/3z2F+EVui2fGdIizOdKUhrhCdwiHSyBf99GrsKuJ0tvJe2EHzoC0aQ+mz
         vJQY/hFbVFBQcwbB98qVRudkPkSpWvK3LFGhdzSkhwWir2jt11UNBByAnC4HQL4DbNqN
         Q4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=GBvqua5cjMzjDQ/XgF9SZ1D4y+QsnVuyrt4amhV4btE=;
        b=1zQ50Xw2ViZaCEYh0JRQex2ZaJNzpepYM50ucZK4++F1gHYvi5bf7GXIf6I8v0YeLQ
         WpGjYbqn92/+zBh+VY1AB4fYxELN2UmmLbMzPHNkpU3m2omr7DnHrPPtHN05YMpBbWI9
         QZlWmh6jLKL86W4o2Bvdkpjm4cw7xSwEk6bkZtVY5kYoVz31ark9HAik4JeHmZF/I0pl
         GW2om5PpHOA639xC+r2VFNteeZoPyWHCte/KUqTjrESBbgKy98yK63LCfHf0oQ+yf3UV
         fUDBEvHFhmxSKw/acfurP8zSSwdk4FiOz066MyBOQjsjOWwIiHof+VG4+yTlUhnYNGsc
         SKDw==
X-Gm-Message-State: ACgBeo3BisO+tXKNRV26sbquHxBOkkhoZ1B2/dyeNt3Wn4k+7bTiWnxS
        y/4s3L5oJSj3nf+tRLyXyvYt/WZBLvQY9I08UPuhoQ==
X-Google-Smtp-Source: AA6agR6q7ad6sf4kgVlbFbNc5qY39/VlvvSlRemTzNOIPH7rueyubBC/OTF7pi8jTZlObaVAtjHrYIlq/M8iqBqxOiw=
X-Received: by 2002:a81:4e04:0:b0:33d:c7dc:9e2b with SMTP id
 c4-20020a814e04000000b0033dc7dc9e2bmr8959772ywb.4.1661765938626; Mon, 29 Aug
 2022 02:38:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220704150514.48816-1-elver@google.com> <20220704150514.48816-12-elver@google.com>
 <YvznKYgRKjDRSMkT@worktop.programming.kicks-ass.net> <CANpmjNN1vv9oDpm1_c99tQKgWVVtXza++u1xcBVeb5mhx5eUHw@mail.gmail.com>
 <Ywx7CmbG+f+wg04z@hirez.programming.kicks-ass.net>
In-Reply-To: <Ywx7CmbG+f+wg04z@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Mon, 29 Aug 2022 11:38:22 +0200
Message-ID: <CANpmjNPFnV2novubKKVmC7zJ8qi72QuRY6bWBEi5jrO_kkRBag@mail.gmail.com>
Subject: Re: [PATCH v3 11/14] perf/hw_breakpoint: Reduce contention with large
 number of tasks
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Aug 2022 at 10:38, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Aug 17, 2022 at 03:14:54PM +0200, Marco Elver wrote:
> > On Wed, 17 Aug 2022 at 15:03, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Mon, Jul 04, 2022 at 05:05:11PM +0200, Marco Elver wrote:
> > > > +static bool bp_constraints_is_locked(struct perf_event *bp)
> > > > +{
> > > > +     struct mutex *tsk_mtx = get_task_bps_mutex(bp);
> > > > +
> > > > +     return percpu_is_write_locked(&bp_cpuinfo_sem) ||
> > > > +            (tsk_mtx ? mutex_is_locked(tsk_mtx) :
> > > > +                       percpu_is_read_locked(&bp_cpuinfo_sem));
> > > > +}
> > >
> > > > @@ -426,18 +521,28 @@ static int modify_bp_slot(struct perf_event *bp, u64 old_type, u64 new_type)
> > > >   */
> > > >  int dbg_reserve_bp_slot(struct perf_event *bp)
> > > >  {
> > > > -     if (mutex_is_locked(&nr_bp_mutex))
> > > > +     int ret;
> > > > +
> > > > +     if (bp_constraints_is_locked(bp))
> > > >               return -1;
> > > >
> > > > -     return __reserve_bp_slot(bp, bp->attr.bp_type);
> > > > +     /* Locks aren't held; disable lockdep assert checking. */
> > > > +     lockdep_off();
> > > > +     ret = __reserve_bp_slot(bp, bp->attr.bp_type);
> > > > +     lockdep_on();
> > > > +
> > > > +     return ret;
> > > >  }
> > > >
> > > >  int dbg_release_bp_slot(struct perf_event *bp)
> > > >  {
> > > > -     if (mutex_is_locked(&nr_bp_mutex))
> > > > +     if (bp_constraints_is_locked(bp))
> > > >               return -1;
> > > >
> > > > +     /* Locks aren't held; disable lockdep assert checking. */
> > > > +     lockdep_off();
> > > >       __release_bp_slot(bp, bp->attr.bp_type);
> > > > +     lockdep_on();
> > > >
> > > >       return 0;
> > > >  }
> > >
> > > Urggghhhh... this is horrible crap. That is, the current code is that
> > > and this makes it worse :/
> >
> > Heh, yes and when I looked at it I really wanted to see if it can
> > change. But from what I can tell, when the kernel debugger is being
> > attached, the kernel does stop everything it does and we need the
> > horrible thing above to not deadlock. And these dbg_ functions are not
> > normally used, so I decided to leave it as-is. Suggestions?
>
> What context is this ran in? NMI should already have lockdep disabled.

kgdb can enter via kgdb_nmicall*() but also via
kgdb_handle_exception(), which isn't for NMI.
