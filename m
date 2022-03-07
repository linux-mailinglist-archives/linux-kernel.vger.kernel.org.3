Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B5F4D043A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 17:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244247AbiCGQgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 11:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244239AbiCGQgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:36:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B3B939BA;
        Mon,  7 Mar 2022 08:35:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C4CEB81633;
        Mon,  7 Mar 2022 16:35:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82054C340EF;
        Mon,  7 Mar 2022 16:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646670953;
        bh=2IIH6eo2eE32TuYinxjJtbWqrPLuhbgdrJbkGXoaLug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DgFPRtJqsY+8HVV8CR3tEnN7kZZITk2a4oaMBM7t2vYr2/B1dTamcQJrsmhhGDfWa
         VAtcwd0qknPOcpeMTksTsWGzaAwR/gO+DRzE2qwRQ9NRcmQmydTwhaeI0ckdv/gd3n
         ADZQ62y54grQ2dA7AiARkq2KM9420Bea2OGdqY59BWPLZF25lRy9/Xph1v1F4ubTCB
         DI3NlO9WdmRt+K+5fuBqO1TBpbBtwbwSupvhHJnT2JXdvwxSGo+bzhTNxo78lrHNO9
         BAbNXp4bOHBeAI9lbm7aBSFHf/zGO1ZLMHHB6vJx3AReznVnG0PMkALrIMi4Re+Uun
         1xbEAAwo+1IzA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 471F9403C8; Mon,  7 Mar 2022 13:35:50 -0300 (-03)
Date:   Mon, 7 Mar 2022 13:35:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Linux-v5.17-rc6] Building tools/perf with perl v5.34
Message-ID: <YiY0ZlG9/3y0zlAH@kernel.org>
References: <CA+icZUWHd4VTKNwBtuxt9-fHoiYV+Q7tQ809Cn83k8sbQ_uNHw@mail.gmail.com>
 <YiPDaiYffeK4lF+l@krava>
 <CA+icZUW0XyDHFTYF_j1QECpqP4kmTXqCqX_HfEVvQ4aWZecW5Q@mail.gmail.com>
 <YiTWVjKwOO/bMNz/@krava>
 <CA+icZUWBFAWx1DgN-nqUkr7W9W3hjhNRChEaXrfW5unoU_Lqdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUWBFAWx1DgN-nqUkr7W9W3hjhNRChEaXrfW5unoU_Lqdw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Mar 06, 2022 at 05:00:22PM +0100, Sedat Dilek escreveu:
> On Sun, Mar 6, 2022 at 4:42 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> > I'm getting some other lto related error:
> >
> >         $ cat test-libperl.make.output
> >         clang-13: error: optimization flag '-ffat-lto-objects' is not supported [-Werror,-Wignored-optimization-argument]
> >
 
> I was thinking about syncing the flags for both feature test-perl and
> perf/libperl-support.
 
> tools/build/feature/Makefile
> tools/perf/Makefile.config
 
> So, I guess FLAGS_PERL_EMBED differs.
 
> For building perf '-ffat-lto-objects'  is filtered-out...
 
> $ git grep ffat-lto-objects tools/perf/
> tools/perf/Makefile.config:  PERL_EMBED_CCOPTS := $(filter-out
> -flto=auto -ffat-lto-objects, $(PERL_EMBED_CCOPTS))

Right, with the patch below I can build with clang 13. It would be nice
to have this defined into just one place, but for now, for 5.17 the
minimal fix is preferred, can you send a proper patch, s-o-b, etc?

- Arnaldo

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 1480910c792e2cb3..869073cf84493083 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -218,6 +218,7 @@ PERL_EMBED_LDOPTS = $(shell perl -MExtUtils::Embed -e ldopts 2>/dev/null)
 PERL_EMBED_LDFLAGS = $(call strip-libs,$(PERL_EMBED_LDOPTS))
 PERL_EMBED_LIBADD = $(call grep-libs,$(PERL_EMBED_LDOPTS))
 PERL_EMBED_CCOPTS = `perl -MExtUtils::Embed -e ccopts 2>/dev/null`
+PERL_EMBED_CCOPTS := $(filter-out -ffat-lto-objects, $(PERL_EMBED_CCOPTS))
 FLAGS_PERL_EMBED=$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
 
 $(OUTPUT)test-libperl.bin:
