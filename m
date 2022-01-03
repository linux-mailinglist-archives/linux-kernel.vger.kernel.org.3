Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D089A4833E6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 16:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbiACPH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 10:07:59 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:57332 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiACPH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 10:07:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6793ECE110C;
        Mon,  3 Jan 2022 15:07:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC72C36AED;
        Mon,  3 Jan 2022 15:07:53 +0000 (UTC)
Date:   Mon, 3 Jan 2022 10:07:51 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        eranian@google.com
Subject: Re: [was: libtraceevent: Increase libtraceevent logging when
 verbose]
Message-ID: <20220103100751.53fbd5bc@gandalf.local.home>
In-Reply-To: <YdMQlctMPpHIvf+I@kernel.org>
References: <20210923001024.550263-1-irogers@google.com>
        <20210923001024.550263-4-irogers@google.com>
        <bc2b0786-8965-1bcd-2316-9d9bb37b9c31@kernel.org>
        <c19ca2a2-54c9-88b1-b705-5a2cd4dd9580@kernel.org>
        <YdMQlctMPpHIvf+I@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jan 2022 12:04:53 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Mon, Jan 03, 2022 at 09:25:26AM +0100, Jiri Slaby escreveu:
> > Ping -- perf build is still broken in 5.16-rc8 due to this.  
> 
> Back from year end vacation, I'll try to fix this, from a quick read it
> uses in tree tools/lib/traceevent headers while building with the distro
> provided libtraceevent-devel package.

I'll try to take a look at this too. I'm pretty much done with my office
renovation, and can now do some volunteer work ;-)

-- Steve
