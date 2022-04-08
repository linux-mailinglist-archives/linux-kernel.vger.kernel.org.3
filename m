Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4764F9E55
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 22:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbiDHUuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 16:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiDHUuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 16:50:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904CF1C1EFA;
        Fri,  8 Apr 2022 13:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jSNlhgteFciJhaFanIIz/zy2rD53IRDwcvBetwHtIQM=; b=mrD47God47Rhpq962QoM1VVzjc
        KK1mF/026DuTnYfWGFDoh8xKdgVe+vat38s8Er328ZS/B05WjMfK2e92WBGLhb18E4XTOsJFBMrUI
        UXBo2/PkRE5hYxAIAt/ItIzbc4tdO/SxYZr9h2RE5soayULihO0SX45nD5fDpMSDOH0z0HIar86MP
        QGAgCGSvWKHsG4U6srhbhIrgFndKJ6u6aGaubWc5qcBEX8k9owEXsFhNHTOwoUPjynY5oOTRVuLtu
        T+i+6/2Bvvv0BoHez5tjKBebyWJ0sf9HQcs8jELGAugpOIAzTpgqLMyVAwchJcXXyQwJjtq+63uan
        4gYttRPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncvWY-00A98f-1r; Fri, 08 Apr 2022 20:48:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8E8FC3000E6;
        Fri,  8 Apr 2022 22:48:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6D07432233317; Fri,  8 Apr 2022 22:48:05 +0200 (CEST)
Date:   Fri, 8 Apr 2022 22:48:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Changbin Du <changbin.du@gmail.com>,
        linux-toolchains@vger.kernel.org,
        clang-built-linux <llvm@lists.linux.dev>
Subject: Re: [PATCH] kbuild: Remove CONFIG_DEBUG_SECTION_MISMATCH
Message-ID: <YlCfhUkOXTvqCfjT@hirez.programming.kicks-ass.net>
References: <7fad83ecde03540e65677959034315f8fbb3755e.1649434832.git.jpoimboe@redhat.com>
 <CAK7LNARvFcQgEB1b0L6giwx0vD7wU9L-OZ5jvm1c5+StLjeOYQ@mail.gmail.com>
 <YlCJm8iQBPSOWIT5@hirez.programming.kicks-ass.net>
 <CAKwvOd=2xeZOg+0HosLPgCegKZxe7F-Cprw0MjOiWf2q=AbNDQ@mail.gmail.com>
 <YlCb3L7ByWwszbaA@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlCb3L7ByWwszbaA@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 10:32:28PM +0200, Peter Zijlstra wrote:

> > > This weird option is having us upgrade quite a few 'inline' to
> > > '__always_inline'.
> > 
> > As is, the assumption that __init functions only call other __init
> > functions or __always_inline is a brittle house of cards that leads to
> > a "what color is your function" [0] scenario, and leads to code that
> > happens to not emit warnings for compiler X (or compiler X version Y).
> > There's also curious exceptions in modpost that look like memory leaks
> > to me.

So I don't see __always_inline that way (also I'm in the 'inline' should
be '__always_inline' camp).

To me inline is more like: 'instantiate that pattern *here*'. It's like
CPP macros, only less horrible. You get the code generated according to
the local rules (instrumentation yes/no, section, and whatever other
function attributes we have that affect code-gen).

So with inline we can get the same pattern instantiated a number of
different times, leading to different actual code, without having to
type the whole thing multiple times (which would be terrible for
maintenance) etc..

Combine __always_inline with constant propagation of inline function
'pointers' and you get do beautiful things ;-) /me runs
