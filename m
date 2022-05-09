Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E9C51FEF7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 16:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236773AbiEIODw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 10:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236701AbiEIODt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 10:03:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90C618D4ED
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 06:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BTWkAX27uDsyC4vbkOGDA43e2cUCH11HFcXPqJvTq38=; b=awER6OlTyq1mYQEExwvGUYw+4D
        lWQzXNQ+/jGS7ZpQrV6sXkNS6mi9eXaPYZLvAqQHZqOUj/1yub8lhIAxCrTDAGeUIgWmB8siFH/rx
        /pvAP14GNQiQPxPJY4XKvpqEDbKKEycfFFYOAQEcRDM42K/NKeBsJlXJeLHr6pP2jfzn27uubspLw
        bipjqgKe8Xo1L9fIJ/r4mpIxeJRRcQeaUlp9wUjsNdp44TuAuPY0nHgwYPrN0dHBEj0RRTBFI2AcW
        ZGYJohzAPUYd+xvr5xaYmkDRcSTNgY1n92uuEKZsdRaV7J4DX11Hj4CknTiU6VKTefvuI6w1Zy+0U
        UZmlp+MA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1no3vP-003VWx-9Y; Mon, 09 May 2022 13:59:47 +0000
Date:   Mon, 9 May 2022 14:59:47 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Tom Rix <trix@redhat.com>
Cc:     hughd@google.com, akpm@linux-foundation.org, nathan@kernel.org,
        ndesaulniers@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] mm/shmem: initialize folio to NULL
Message-ID: <YnkeUz0Z2O9Xd5O+@casper.infradead.org>
References: <20220509123116.3169267-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509123116.3169267-1-trix@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 08:31:16AM -0400, Tom Rix wrote:
> The clang build fails with
> mm/shmem.c:1704:7: error: variable 'folio' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>   if (!page) {
>        ^~~~~
> The error handler for !page jumps to an if-check for an unset folio.
> So initialize folio to NULL.

I appreciate you're trying to help, but the fourth report of a problem
adds more noise than utility.

https://lore.kernel.org/linux-mm/?q=shmem+folio

shows emails about this from the cgelbot, Dan Carpenter, SeongJae Park,
Colin King, Nathan Chancellor and Sebastian Siewior.  So actually you
were seventh, not fourth.
