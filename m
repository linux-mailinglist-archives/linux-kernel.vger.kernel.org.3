Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2524D507599
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351629AbiDSQvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355132AbiDSQqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:46:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1445339692
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 09:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AJfejJ1xRbeAbdDxHLT7uHPFlknNYzGKCJWzpyqVuJ0=; b=V0K+okUbjL2FdlW0dNWrPRnG19
        hbP+LhTEco8cFNLakW0d+otCS5J0XlGHE5ruV1jrSTdyv6IY4ZgJYHOZahr+dREe8uImL7JRQWMq0
        UY3IbmWubSoUqAMrkHWY+JRecGMLvv0nJpLJ+v/YYW/uFZBTXuY60VYpLzMio0pfvLjxR5rMapwsj
        DLHaYW4PZasQC7Z+BM34rnhdtL+Y1GsWfq8EwSYq2LJE6pp2smCT799O0Vs2UFogwbo/6DmyUNwSi
        k6yBGijSkOzC3x8NU1mv9yg2pyOTfrQtLSsTyDG/B0tmZZywr6iZl6mDPqqQGgPQWo6dbMyaPgjKh
        TVd4LAnw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ngqxD-006s0I-WA; Tue, 19 Apr 2022 16:43:52 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B77DE986195; Tue, 19 Apr 2022 18:43:47 +0200 (CEST)
Date:   Tue, 19 Apr 2022 18:43:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v2 00/25] objtool: Interface overhaul
Message-ID: <20220419164347.GX2731@worktop.programming.kicks-ass.net>
References: <cover.1650300597.git.jpoimboe@redhat.com>
 <20220419115130.GT2731@worktop.programming.kicks-ass.net>
 <20220419153622.ydn6uurtaeencmol@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419153622.ydn6uurtaeencmol@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 08:36:22AM -0700, Josh Poimboeuf wrote:
> On Tue, Apr 19, 2022 at 01:51:30PM +0200, Peter Zijlstra wrote:
> > I've taken the liberty of reordering it slightly:
> > 
> >    objtool: Enable unreachable warnings for CLANG LTO
> >    x86/static_call: Add ANNOTATE_NOENDBR to static call trampoline
> >    x86/retpoline: Add ANNOTATE_ENDBR for retpolines
> >    x86/uaccess: Add ENDBR to __put_user_nocheck*()
> >    x86/xen: Add ANNOTATE_ENDBR to startup_xen()
> >    objtool: Print data address for "!ENDBR" data warnings
> >    objtool: Use offstr() to print address of missing ENDBR
> > 
> > Go into x86/urgent, and I've added Fixes: tags with various patches from
> > the IBT series, and then the rest goes into objtool/core.
> > 
> > As already indicated, there's going to be a few merge conflicts against
> > x86/core, but alas. Resolved as per the below.
> 
> Thanks!  I guess tip bot is broken?

Not pushed out yet, still in queue.git. Hopefully a little later today.
