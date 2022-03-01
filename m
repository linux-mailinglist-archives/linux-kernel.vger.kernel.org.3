Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D224C8D8B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 15:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235214AbiCAOUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 09:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234714AbiCAOUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 09:20:33 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EC525C44
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 06:19:50 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8B8C81F37E;
        Tue,  1 Mar 2022 14:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646144389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H2q28eaqalAFoHsvDqKx1NJVDbUBkR/bwOzkpwAOb5I=;
        b=imsIiurITl2SXd78S38Qw+epGmRNfvvMTKtchV9qLqm0/8oHzmUigOxKVJRb/fPN2VYKaT
        hijgKhCsgqkKQ/MVnWffm9cQQ3KnQZufeqrP5fj7fzIq1Aw1W7AR1S7pnUj430SUfEV9q6
        uDINPmCjPMciwur8djnIBQuYs1BJwFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646144389;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H2q28eaqalAFoHsvDqKx1NJVDbUBkR/bwOzkpwAOb5I=;
        b=Z5dNeJ7GioHk2oeaVmwpmtMh0cTDNjZwvSRxpDDA2a3c/J6yGHD2EATIAAZ4bhTdiJXrht
        ZdjZc5qGrut6oiDg==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 55009A3B81;
        Tue,  1 Mar 2022 14:19:49 +0000 (UTC)
Date:   Tue, 1 Mar 2022 15:19:49 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: Re: [PATCH 21/29] objtool: Rename --duplicate to --lto
In-Reply-To: <20220228201847.x2i5frlmuwprfgap@treble>
Message-ID: <alpine.LSU.2.21.2203011517390.8402@pobox.suse.cz>
References: <20220218164902.008644515@infradead.org> <20220218171409.814392411@infradead.org> <20220226194209.bvv3t65hhtnwltmk@treble> <20220226214802.4chmsrtstlerefmu@treble> <YhysYkcfwLr68Job@hirez.programming.kicks-ass.net> <20220228183228.splleoatuxxjr5kq@treble>
 <20220228200934.GF11184@worktop.programming.kicks-ass.net> <20220228201847.x2i5frlmuwprfgap@treble>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Feb 2022, Josh Poimboeuf wrote:

> On Mon, Feb 28, 2022 at 09:09:34PM +0100, Peter Zijlstra wrote:
> > > So how about we just get rid of the magical --vmlinux and --lto options
> > > altogether, and make --noinstr additive, like all the other options?
> > >
> > >   A) legacy mode:
> > >      .o files: objtool check [--module]
> > >       vmlinux: N/A
> > >        module: N/A
> > >
> > >   B) CONFIG_NOINSTR_VALIDATION=y && !(CONFIG_X86_KERNEL_IBT=y || CONFIG_LTO=y):
> > >      .o files: objtool check [--module]
> > >       vmlinux: objtool check --noinstr-only
> > >        module: objtool check --module --noinstr-only
> > >
> > >   C) CONFIG_X86_KERNEL_IBT=y || CONFIG_LTO=y:
> > >      .o files: N/A
> > >       vmlinux: objtool check --noinstr
> > >        module: objtool check --module --noinstr
> > 
> > I like the --noinstr-only thing. But I think I still like a flag to
> > differentiate between TU/.o file and vmlinux/whole-module invocation.
> 
> I'm missing why that would still be useful.
> 
> > Anyway, you ok with me cleaning this up later, in a separate series?
> 
> Sure.  It's already less than ideal today anyway, with '--vmlinux' and
> '--duplicate'.

Since I always have hard times to figure out different passes and options 
of objtool, could you add the above description (its final version) to 
tools/objtool/Documentation/ as a part of the cleanup series, please?

Miroslav
