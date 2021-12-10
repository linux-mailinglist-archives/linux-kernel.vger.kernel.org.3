Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5E4470EC7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 00:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243819AbhLJXjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 18:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239984AbhLJXjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 18:39:03 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E8DC061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 15:35:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 31D79CE2D8B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 23:35:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B52C00446;
        Fri, 10 Dec 2021 23:35:21 +0000 (UTC)
Date:   Fri, 10 Dec 2021 18:35:20 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Marco Elver <elver@google.com>, Ingo Molnar <mingo@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Wei Liu <wei.liu@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Alexander Popov <alex.popov@linux.com>
Subject: Re: [PATCH] panic: use error_report_end tracepoint on warnings
Message-ID: <20211210183520.5cb1c4d4@gandalf.local.home>
In-Reply-To: <YZJ01V8fZBlWz4VW@smile.fi.intel.com>
References: <20211115085630.1756817-1-elver@google.com>
        <YZJw69RdPES7gHBM@smile.fi.intel.com>
        <CANpmjNMcxQ1YrvsbO-+=5vmW6rwhChjgB20FUMKvHQ9HXNwcAg@mail.gmail.com>
        <YZJ01V8fZBlWz4VW@smile.fi.intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2021 16:55:17 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> > > >       ERROR_DETECTOR_KFENCE,
> > > > -     ERROR_DETECTOR_KASAN
> > > > +     ERROR_DETECTOR_KASAN,
> > > > +     ERROR_DETECTOR_WARN  
> > >
> > > ...which exactly shows my point (given many times somewhere else) why comma
> > > is good to have when we are not sure the item is a terminator one in the enum
> > > or array of elements.  
> > 
> > So you want me to add a comma?  
> 
> Yes. And you see exactly why I'm asking for that.
> 
> > (I'm not participating in bikeshedding here, just tell me what to do.)  
> 
> Done!

Is there going to be another patch set? Or did I miss it?

-- Steve
