Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF9C54009E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245063AbiFGOBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245058AbiFGOBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:01:08 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF525C1EDB;
        Tue,  7 Jun 2022 07:01:02 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 257E0Bf3006397;
        Tue, 7 Jun 2022 16:00:11 +0200
Date:   Tue, 7 Jun 2022 16:00:11 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Shah <aams@amazon.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Solar Designer <solar@openwall.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2] Documentation/security-bugs: overhaul
Message-ID: <20220607140011.GE5885@1wt.eu>
References: <20220606194850.26122-1-vegard.nossum@oracle.com>
 <nycvar.YFH.7.76.2206062326230.10851@cbobk.fhfr.pm>
 <87o7z4fvod.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7z4fvod.fsf@meer.lwn.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 07:30:10AM -0600, Jonathan Corbet wrote:
> Jiri Kosina <jikos@kernel.org> writes:
> 
> > - what sense does it make to have embargoed-hardware-issues.rst and 
> >   security-bugs.rst live in different Documentation/ subdirectories 
> >   (admin-guide/ vs process/)? It'd seem to make sense to me to have them 
> >   in one common place?
> 
> Yes, I think that would make sense...a lot of stuff got sorted out into
> the various guides quickly, and it didn't all land in the right place.
> I'd be in favor of moving this over to the process guide, and perhaps
> making a security-specific section there.

I, too, regularly search for it in process/, fail to find it then use
"find" to spot it under admin... Process seems more suitable to me at
least.

Willy
