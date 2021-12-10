Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3578247006B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 13:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240851AbhLJMKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 07:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240840AbhLJMKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 07:10:04 -0500
Received: from gentwo.de (gentwo.de [IPv6:2a02:c206:2048:5042::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AED9C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 04:06:29 -0800 (PST)
Received: by gentwo.de (Postfix, from userid 1001)
        id 1C9A2B003EC; Fri, 10 Dec 2021 13:06:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 1A266B00377;
        Fri, 10 Dec 2021 13:06:28 +0100 (CET)
Date:   Fri, 10 Dec 2021 13:06:28 +0100 (CET)
From:   Christoph Lameter <cl@gentwo.org>
X-X-Sender: cl@gentwo.de
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@gentwo.de>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: Do we really need SLOB nowdays?
In-Reply-To: <20211210110835.GA632811@odroid>
Message-ID: <alpine.DEB.2.22.394.2112101305500.290446@gentwo.de>
References: <20211017042852.GA3050@kvm.asia-northeast3-a.c.our-ratio-313919.internal> <20211017133618.GA7989@kvm.asia-northeast3-a.c.our-ratio-313919.internal> <20211017135708.GA8442@kvm.asia-northeast3-a.c.our-ratio-313919.internal> <YWw1n6y/AGED14HD@casper.infradead.org>
 <CAB=+i9Tor-tmZuB8YjATT_rv68nnF2W_TvMvyGp55AGaSyKynw@mail.gmail.com> <alpine.DEB.2.22.394.2110251016260.3145@gentwo.de> <20211028100414.GA2928@kvm.asia-northeast3-a.c.our-ratio-313919.internal> <YXqSoo+b9RTclW/2@casper.infradead.org>
 <20211210110835.GA632811@odroid>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Dec 2021, Hyeonggon Yoo wrote:

> > > (But I still have doubt if we can run linux on machines like that.)
> >
> > I sent you a series of articles about making Linux run in 1MB.
>
> After some time playing with the size of kernel,
> I was able to run linux in 6.6MiB of RAM. and the SLOB used
> around 300KiB of memory.

What is the minimal size you need for SLUB?

