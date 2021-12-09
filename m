Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7949B46ED89
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237057AbhLIQyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234323AbhLIQyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:54:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6F3C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 08:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZGNCIN6H/aM19JWMX7z7yv0cviIb8dJguRtMNUB0fEo=; b=vjdGm1lw5VsZM6VOlD6Ie77ePn
        TydaD6UQFR835wRq0UjYRDoWPozFhebS3AxKdxZ1NkhTaVSGfAANbH+mwZYrxI1jlzA4eas9O8Xce
        /qNPhGQCtO8VUPtY4BaAKJFXPhK5If0hgHzu1asOdPeSBx8JdVCc6XtEy/JJWXDxhSB+l5usviMq8
        Q18gLX7QFdUk53vJ5j1V+Fo6Ga4xzr/LCzbgINRNPAqxORnofFn4HWbeyAqe2F0IKyB/WpnxH3l/o
        R2X7F0tXHv9XLgXVFvH9MLzEXn+kltM06SHiKfYpo70X9RFrNZmsCFfqxWfW11tOJVDMt0tJFDus5
        CC+1sXqA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvMdL-009Wjp-66; Thu, 09 Dec 2021 16:51:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A31BD3000E6;
        Thu,  9 Dec 2021 17:51:02 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8E124205BF89E; Thu,  9 Dec 2021 17:51:02 +0100 (CET)
Date:   Thu, 9 Dec 2021 17:51:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     will@kernel.org, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, mark.rutland@arm.com,
        elver@google.com, keescook@chromium.org, hch@infradead.org,
        torvalds@linux-foundation.org
Subject: Re: [RFC][PATCH 0/5] refcount: Improve code-gen
Message-ID: <YbIz9iPjmaACVskJ@hirez.programming.kicks-ass.net>
References: <20211208183655.251963904@infradead.org>
 <20211209082533.GE16608@worktop.programming.kicks-ass.net>
 <2e62f9cd-514f-578b-79cb-180c283f5482@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e62f9cd-514f-578b-79cb-180c283f5482@kernel.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 09:19:58AM -0700, Jens Axboe wrote:
> On 12/9/21 1:25 AM, Peter Zijlstra wrote:
> > On Wed, Dec 08, 2021 at 07:36:55PM +0100, Peter Zijlstra wrote:
> >> Hi,
> >>
> >> Improves the refcount_t code-gen; I've still got to go through the latest thing
> >> Linus suggested, but figured I should get these patches out to see if there's
> >> other concerns etc..
> >>
> > 
> > Bah, I forgot to Cc Jens, let me bounce him the lot.
> 
> Traveling the next few days, just put me on v2 and I should have time to
> look at this start next week. Bouncing only helps for initial messages,
> I'll have to do dig for followups :-)

Hmm.. I tagged the whole thread and did tag-bounce. Anyway, I'll be sure
to copy you on v2. Thanks!
