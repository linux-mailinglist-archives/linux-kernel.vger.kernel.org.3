Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAFD4A72DF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344883AbiBBOTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243866AbiBBOT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:19:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7096BC061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 06:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R7P6aHcpNQUxSRbUd6NngdbOWiqXR/+pSIq7P8Kh2co=; b=WRdh2fEj0lJy4glcqBKN9nk/B2
        UzZ00kp+N9Svk/GIe1QeMQ0zNt+5PwceAn/vEadJmrQc/v6mrhKMD0f8DndB4R3NlEwLuYM7iZKga
        KMogCDcVnGSUVM1GfbED3KXzpsX+UFvDjEazUPHaIcbFkyFt/mSD01o2I2VNT8LpM0D6PeG5ceTHN
        DjFNmN+0w5ES2smF84cExGsZ0nMN59VGyEBWGDTGJ45PrOe39DyMzLZJ2RdjLsNvkdt5AlIF8GEge
        X8khw6oyLeijqitV0vYfFP7qOZH39sgCj9/WCNMmjzFnK9sPiIi6f8dH3ucdAMnmHWoZC2xjOcolW
        Dqw2aulw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFGTf-00Ek1p-DY; Wed, 02 Feb 2022 14:19:19 +0000
Date:   Wed, 2 Feb 2022 14:19:19 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/page_alloc: Don't pass pfn to free_unref_page_commit()
Message-ID: <YfqS51s+IHgw1xQM@casper.infradead.org>
References: <20220202140451.415928-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202140451.415928-1-nsaenzju@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 03:04:51PM +0100, Nicolas Saenz Julienne wrote:
> free_unref_page_commit() doesn't make use of its pfn argument, so get
> rid of it.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
