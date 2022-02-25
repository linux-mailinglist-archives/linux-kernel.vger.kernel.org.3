Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A4D4C4547
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239328AbiBYNFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239942AbiBYNFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:05:25 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9340188848
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NTSZStXAUG9B0y1Cy11XnlSpMWqZYq+VuPifbu1y+dg=; b=BUmiqCunIQcR2FS/z7HyWJxz5W
        pbESasqbW4QmgyvW11G/gI8qgIj0FpcLlxr6ry/jc3K1PFDOy//EsMMsIu5WvNu9hbisJbEOGMR70
        Jx2DZkIFQMaP3J6/XsUn7rIrJfgFzT3AiJCmpxnbjVyYAeytfCJlbpECxiZU97J6voHHYP7QJYEbM
        j+4+mj3CXI0xbDRhAeEZHPeFuAGFIjWw+uLifxLoT3HUdVi/h/hrsJ7U+ij04KH/3jtc2OeTfnSkz
        YnG+ssyBqjX6fpkAXFL0bHiV+/9+veoelE7Jms/peVv9YGVgnz4EFzX7BZOB9D/6lmul7hgDxwqH/
        TxFl4Nug==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNaGp-00CxuK-Rz; Fri, 25 Feb 2022 13:04:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C5E9E300067;
        Fri, 25 Feb 2022 14:04:26 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A9C58235EF285; Fri, 25 Feb 2022 14:04:26 +0100 (CET)
Date:   Fri, 25 Feb 2022 14:04:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 21/39] x86/ibt: Annotate text references
Message-ID: <YhjT2uSg53IbuGeF@hirez.programming.kicks-ass.net>
References: <20220224145138.952963315@infradead.org>
 <20220224151323.248523488@infradead.org>
 <20220225004716.epyhpxi5lunphzi4@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225004716.epyhpxi5lunphzi4@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 04:47:16PM -0800, Josh Poimboeuf wrote:
> On Thu, Feb 24, 2022 at 03:51:59PM +0100, Peter Zijlstra wrote:
> > @@ -563,12 +564,14 @@ SYM_CODE_END(\asmsym)
> >  	.align 16
> >  	.globl __irqentry_text_start
> >  __irqentry_text_start:
> > +	ANNOTATE_NOENDBR // unwinders
> 
> But the instruction here (first idt entry) actually does have an
> endbr64...
> 
> Also I'm wondering if it would make sense to create an
> 'idt_entry_<vector>' symbol for each entry so objtool knows to validate
> their ENDBRs.

I think we're good on that front since irq_entries_start and
spurious_entries_start capture the first entry and the rest is .rept off
of that.
