Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDB658ED95
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbiHJNtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbiHJNtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:49:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1626716C
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 06:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JHf1yBds1DN8UN4Ih9Q475YEN/AiqFSyAzSDvtHNqt0=; b=GKxxSLVznr1xGXv8/kIdYXNC15
        w95xLFNqOTR2yQL6wIqehT+9U2yuQ0OK52k6rBaUKn1CMegjaB5No3+bBgpa+anY9RIhbFQ++GFZT
        ghUWlD8DRZDxsn8FywlN9iWFagKkk2HhBLof6v0xo0JWxbE/2pWtVlzf1mXFqcB3JNk1zpIM8A9u4
        /9dCQNtwwzZ0uItCYzEguqPa2DSRxVaavA7jlf5hC80pvvNA/z3YeLH87vUUrta+Ts9WILp8KHvOc
        33Ith2cgF7B1LKq749p/vzi+B0Tp1YNCFhZfHvnyXHos/CZklLy6w17Q8otlRUZDyn+lQyKWZb0Nj
        WS6N7mTA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oLm4f-00Grh1-73; Wed, 10 Aug 2022 13:48:41 +0000
Date:   Wed, 10 Aug 2022 14:48:41 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     syzbot <syzbot+a7b60a176ec13cafb793@syzkaller.appspotmail.com>
Cc:     Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        alex.gaynor@gmail.com, arve@android.com, brauner@kernel.org,
        cmllamas@google.com, gregkh@linuxfoundation.org, hridya@google.com,
        joel@joelfernandes.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, maco@android.com,
        minchan@kernel.org, ojeda@kernel.org, omosnace@redhat.com,
        surenb@google.com, syzkaller-bugs@googlegroups.com,
        tkjos@android.com, wedsonaf@google.com
Subject: Re: [syzbot] WARNING in find_vma
Message-ID: <YvO3OeojQ2aHVu67@casper.infradead.org>
References: <00000000000085cb1705e5b5d9f6@google.com>
 <0000000000003ee71e05e5e33e10@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000003ee71e05e5e33e10@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 06:44:08AM -0700, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit fd0016c6bd4f6287c5c5f98b6350033ebb3c9753
> Author: Miguel Ojeda <ojeda@kernel.org>
> Date:   Sun Dec 5 18:00:43 2021 +0000
> 
>     scripts: decode_stacktrace: demangle Rust symbols

This bisection has gone astray; those implicated in this commit can
ignore this report.  Liam has already posted a fix for the bug.
