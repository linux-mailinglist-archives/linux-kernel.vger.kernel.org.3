Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5141452A6C6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 17:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346458AbiEQPeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 11:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241044AbiEQPeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 11:34:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E87B41614
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 08:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QUA40l27Atipc/0PNxihSWYvuPeTEXNlJJYQ6mlD0PE=; b=MKqNRY0K/hJuc4jaPLfKxTmhFK
        yTDgi+8y3M9Llqd2RUDxHdI8XQQtmEUhT3B7C/GFtA9eRlz9cTbqQgy0MKFd3MxbRERyGYGcCGYaT
        F+AjK1QLfdOPca6BvfV1Wx59EL1Yp3N6Vm22f3mZH4qa8zBhftqZy4tOhqsdhc20jhIG7OE5F7dHe
        DrdNfZ3VHcX+AJAhGBxICDJrnJjGtmw/6xzMwuu1t8mLnz57/m1jJMBTGdQpfcf8kRHeVmc5KUV8v
        yx69IHFz3k5jkAqBJsa+nRb18QllZh6GMo4z2Ax9rnpdZ+OSOMpvO699XCTkIJJBOpi+rvsX+qp3L
        gSYT8guw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqzCz-00Axmb-FX; Tue, 17 May 2022 15:34:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2BA64300642;
        Tue, 17 May 2022 17:33:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 11E29206DE508; Tue, 17 May 2022 17:33:59 +0200 (CEST)
Date:   Tue, 17 May 2022 17:33:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: Re: objtool "no non-local symbols" error with tip of tree LLVM
Message-ID: <YoPAZ6JfsF0LrQNc@hirez.programming.kicks-ass.net>
References: <YoK4U9RgQ9N+HhXJ@dev-arch.thelio-3990X>
 <20220516214005.GQ76023@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516214005.GQ76023@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 11:40:06PM +0200, Peter Zijlstra wrote:
> Does something simple like this work? If not, I'll try and reproduce
> tomorrow, it shouldn't be too hard to fix.

Oh, man, I so shouldn't have said that :/

I have something that almost works, except it now mightly upsets
modpost.

I'm not entirely sure how the old code worked as well as it did. Oh
well, I'll get it sorted.
