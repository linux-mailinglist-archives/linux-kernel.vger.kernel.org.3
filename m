Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036CB4C4517
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 13:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240815AbiBYM6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 07:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbiBYM6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:58:39 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33B814FFFE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2aM4nYhMNuI90TLrntQnFZCWIB4nglnfTdwNn+wIi6Q=; b=Ttx3x0FMGw6Q3GIvt45s9pmWIM
        t8yYtBRuqBzRFqOzBDmFA6gliwnyvCN6OcnnaItnkRlSatlIiLiNg6fzWw+C5tNl9MS6Kff6HBbUY
        RWzeoPme5iWDwEVl67rwjtRhpajsGT4p7/gq7sJnOhU4+yZEHTqM13DqXBnXYyLANFnWk8uK7zNgJ
        aFetuLcZNRPEXxuUqEuvbAqQK4+nETdFztbWWcFdHPawruagBUaIFJkoKb9EQYD6JpXrBx04XYFeb
        Yp2wlzq+Ql2LiCf0KwGidRZMJ89uWnqnJZKyKs+cgKw3iZvfjejFnmLyFtu1kElU5pJ0sUpeEkG8/
        TJcAqqjw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNaAK-005myO-AJ; Fri, 25 Feb 2022 12:57:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A2F1D3001C0;
        Fri, 25 Feb 2022 13:57:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 67C272D6F91B2; Fri, 25 Feb 2022 13:57:42 +0100 (CET)
Date:   Fri, 25 Feb 2022 13:57:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 21/39] x86/ibt: Annotate text references
Message-ID: <YhjSRufZMjXH74e3@hirez.programming.kicks-ass.net>
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

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2023,6 +2023,9 @@ static int read_noendbr_hints(struct obj
 			return -1;
 		}
 
+		if (insn->type == INSN_ENDBR)
+			WARN_FUNC("ANNOTATE_NOENDBR on ENDBR", insn->sec, insn->offset);
+
 		insn->noendbr = 1;
 	}
 

vmlinux.o: warning: objtool: .entry.text+0x160: ANNOTATE_NOENDBR on ENDBR
vmlinux.o: warning: objtool: xen_pvh_init()+0x0: ANNOTATE_NOENDBR on ENDBR

right you are... /me goes fix
