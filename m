Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5614D4AAF0B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 12:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbiBFLwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 06:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbiBFLtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 06:49:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3D0C06173B;
        Sun,  6 Feb 2022 03:49:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFF4760F6C;
        Sun,  6 Feb 2022 11:49:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE0EC340E9;
        Sun,  6 Feb 2022 11:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644148151;
        bh=GE5zisvutsw9w2qD1E89YL/IvhBKC7xdtqeCkuIuvTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TKM2BN93Bml0pC3w73cDNXtO3IOG5s4eQfMMUFJRY97h1mB5KS5W0EofRYF8YVbgp
         x17EF9MxHJPsBLzd+MRnUj5KW3b49q91J7waIXOb6VzZaNixG8h64Q5CoPfcnGmY/S
         JfKYFL+PgdClqvjbVPhZHWiFpMRvPT1BNDqjv/rNEKllmM3bu2tv6x3jUu0DYWnjEZ
         ZqV5bCKiut8zMuXEG4uRlr9ZJS4hXplrvrgLe4Zx/zd6C2+L688bL/pX5bhLUx3CFf
         tIpmSZYUibwtXHz8FnUQkVpDMlfUsbGXOOzAVcOHj5Zn6oFyoyz3gKWRz5AogeUu7S
         3YKjS+P7lRc1Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 734BC404A6; Sun,  6 Feb 2022 08:49:09 -0300 (-03)
Date:   Sun, 6 Feb 2022 08:49:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Masanari Iida <standby24x7@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH] perf bpf: Fix a typo in bpf_counter_cgroup.c
Message-ID: <Yf+1tRRYT9W8qgqO@kernel.org>
References: <20211225005558.503935-1-standby24x7@gmail.com>
 <CAM9d7cj0dQvoio-T0yNZzo+AGGDxCFtRWuDxBunFEkipWtDxZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cj0dQvoio-T0yNZzo+AGGDxCFtRWuDxBunFEkipWtDxZA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 28, 2021 at 10:25:08AM -0800, Namhyung Kim escreveu:
> Hello,
> 
> On Fri, Dec 24, 2021 at 4:57 PM Masanari Iida <standby24x7@gmail.com> wrote:
> >
> > This patch fixes a spelling typo in error message.
> >
> > Signed-off-by: Masanari Iida <standby24x7@gmail.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> Thanks,
> Namhyung

Thanks, applied.

- Arnaldo

 
> 
> > ---
> >  tools/perf/util/bpf_counter_cgroup.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
> > index cbc6c2bca488..fea5f2ca03f6 100644
> > --- a/tools/perf/util/bpf_counter_cgroup.c
> > +++ b/tools/perf/util/bpf_counter_cgroup.c
> > @@ -266,7 +266,7 @@ static int bperf_cgrp__read(struct evsel *evsel)
> >                 idx = evsel->core.idx;
> >                 err = bpf_map_lookup_elem(reading_map_fd, &idx, values);
> >                 if (err) {
> > -                       pr_err("bpf map lookup falied: idx=%u, event=%s, cgrp=%s\n",
> > +                       pr_err("bpf map lookup failed: idx=%u, event=%s, cgrp=%s\n",
> >                                idx, evsel__name(evsel), evsel->cgrp->name);
> >                         goto out;
> >                 }
> > --
> > 2.25.0
> >

-- 

- Arnaldo
