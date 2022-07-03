Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886B7564A1F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 23:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbiGCVzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 17:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGCVzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 17:55:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A797E26C9
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 14:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+MGiKEfl9xrsgJZ7q400SimQ9kR8E7tJt+7JZCpxN+M=; b=SHfDE5+6mBKPlBCsEOm5QP5yij
        8KU96A8vwOX+IDsEWrs9aJENczKn0RR+ucv0UgGLJuzRETPiRnk97j960pKVDWXup/epaiuhYQ7sc
        lpRtgNCIo0c8+veMEhsKXmjsQbJW2VVFVfK6qURCKgssti0tgSMvYZItSMqiFp7vbMmAM29ep0jby
        7Bm5yyy5R82u59478H5/Zfro9dQkULW/V1um6IBHGR+GCvnusUKMLPuJZWqyAwS2/EMsZWIap6lxX
        X0mdMnIuTGWtBtwX+q5heba1Rwhs658yDib36h3OuX5vfvR7u2AYQi5EvYU3s7QhvfMvhERepib69
        5nTPYdgg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o87YH-00GjBn-FN; Sun, 03 Jul 2022 21:54:49 +0000
Date:   Sun, 3 Jul 2022 22:54:49 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/14] arm: Rename PMD_ORDER to PMD_BITS
Message-ID: <YsIQKdYiswzq5kTG@casper.infradead.org>
References: <20220703141203.147893-1-rppt@kernel.org>
 <20220703211441.3981873-1-willy@infradead.org>
 <YsIHPStHG84Ksu7m@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsIHPStHG84Ksu7m@shell.armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 03, 2022 at 10:16:45PM +0100, Russell King (Oracle) wrote:
> On Sun, Jul 03, 2022 at 10:14:41PM +0100, Matthew Wilcox (Oracle) wrote:
> > This is the number of bits used by a PMD entry, not the order of a PMD.
> 
> No, it's not the number of bits. A PMD entry doesn't fit in 2 or 3 bits.
> This is even more confusing.

Well, what is it then?  The order of something is PAGE_SIZE << n, and
that doesn't seem to be what this is.  Happy to call it whatever you
want to call it.
