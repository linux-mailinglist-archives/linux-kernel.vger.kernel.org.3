Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0695C533014
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 20:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240179AbiEXSIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 14:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbiEXSIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 14:08:22 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D9E6BFC6
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 11:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lFZ6Bk1/CVTrZ+nCdM33/kq2PD2SUxOQLTUPko2qmNQ=; b=fpnjK3s0OWQWp74ebkcNlgs/Bq
        S1CVEcK2kIQlcxk/Z6iwZ4bFcOIrWIwCvY/T844gZMikhjFW2AU7W+CTqTKo9Hj0Ev8RXJ8bSQu1w
        ry2IPfCswleFKgHerCDfgjrVqpKq0Tmr5EhmF0l2WZqjOOJzKaFgaz1g9UHF9eRmPHc7/QexTdrtg
        gwoRy99iD/eZeZipc7jD9iJGXrFzv0b5uecghzk7Ba6ZrVbvtbfBKPUvU8/+5k+EUh+JR9VKon/V/
        OwF1FSlgCcpDlYTbexvNCOhgDr09VuZwJrdhj8Dyi5vMbwEV8BxPmqSAcdevr8s4stQ9MZLsoX7qF
        W4C+652w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntYwv-001Oic-Uc; Tue, 24 May 2022 18:08:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 75D8D30048C;
        Tue, 24 May 2022 20:08:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1EBD1201A9991; Tue, 24 May 2022 20:08:05 +0200 (CEST)
Date:   Tue, 24 May 2022 20:08:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] objtool changes for v5.19
Message-ID: <Yo0fBWQEevzxttdZ@hirez.programming.kicks-ass.net>
References: <You3JC/BOIyEnmQj@gmail.com>
 <Yoxucp7aUrCaV9uE@gmail.com>
 <Yox088fRrhh4grBX@gmail.com>
 <CAHk-=whRTihOdCij9MxpG433cB_9ZHhBeMVAVpAA5Bf2mdr5yA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whRTihOdCij9MxpG433cB_9ZHhBeMVAVpAA5Bf2mdr5yA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 10:53:40AM -0700, Linus Torvalds wrote:
> On Mon, May 23, 2022 at 11:02 PM Ingo Molnar <mingo@kernel.org> wrote:
> >
> > Note that with your latest tree you'll get 3 new conflicts:
> 
> No problem, but the conflicts did make something clear: the objtool
> code should just get rid of the "--uaccess" flag that is now
> unconditional when CONFIG_X86_SMAP has been removed.
> 
> I didn't actually do that, and instead just did the mindless merge
> conflict resolution, but it might be a good idea.

Yes, I think there is patch pending for that, but given the total merge
pain we already had, I was waiting for all the dust to settle before
taking it further.
