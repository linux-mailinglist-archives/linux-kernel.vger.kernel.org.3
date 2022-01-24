Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86504497FF8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242674AbiAXMtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242338AbiAXMtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:49:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA292C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 04:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rYHuWK5Qi1WJe+lyWjsXdvFID1iuwjPdPSOmLkV/mAs=; b=FAJT+OJki2EuUlnC1L7AN/60wF
        8h06mWRdsutXmsqM6a2AG6SJl0HmWJ8HuZtpn1gcf+GZ0EEAPXYSiQNKapRsLJ+p5PG+xDJTMSoU4
        W9IHbEaxrj3MVUFm9gBdsWZo3qQLmc5MBZolAxmKt56j6yt4EmdcxaEiJ0FkMf56ZIP6aealsUfOG
        7IzVUhShFHTIjFG6Z1lSyvJXPTEEhiM3VQeZPUqKPfNZZZ63O24KUzVBXMPhm/4IvfrWRYLkqB+60
        KgRwOsUcZU4uSFb+RGSpB2xva35V/7NMvolG0CEkcUvOV/KiAJW/WRRQo3QXsXHzv0Fd/63Zs7nmn
        5D6Layww==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBymu-000doh-K7; Mon, 24 Jan 2022 12:49:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B40F13002A6;
        Mon, 24 Jan 2022 13:49:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8DC822B3559BA; Mon, 24 Jan 2022 13:49:35 +0100 (CET)
Date:   Mon, 24 Jan 2022 13:49:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 27/54] lib/bitmap: add bitmap_weight_{cmp, eq, gt, ge,
 lt, le} functions
Message-ID: <Ye6gX6OivJCMb523@hirez.programming.kicks-ass.net>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
 <20220123183925.1052919-28-yury.norov@gmail.com>
 <Ye6egq/6It3LZs19@smile.fi.intel.com>
 <Ye6e8lhJ5rLm+iDl@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ye6e8lhJ5rLm+iDl@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 02:43:30PM +0200, Andy Shevchenko wrote:
> It may be other way around:
> 
> 	if ((unsigned int)num > nbits)

Yes, that's my preferred method too :-)
