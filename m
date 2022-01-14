Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D961B48E184
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 01:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238421AbiANAao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 19:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiANAan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 19:30:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349F1C061574;
        Thu, 13 Jan 2022 16:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=54KQIIRQWaQKeVSpqMmcruRzw4QbdmH7UbY8+htwdso=; b=XBCZFUr1hWoWA1gWKc2wNuyLB3
        aSoF4htM9EklGuEX9QXPb7O0Vg8hHNIHG75WXKji+vYJxmJ34+EPxNVKikUmuHOfTmC2FA8YCilKR
        HpYF2HuWP3dbZFdSaQnBzrX5GmP8W23qgQbZKZTdvKEGq4f556AQob5mS4gO9Fi1XUhgRqIo4FaM/
        fKKqXEk/K4iFTsJcJued0d9lZO+aUDJlFBdqJeF+0HKYPwyeVKTlJpsm23YOndGikXlekQnSoTDlg
        RDBXhwvvIP6c/89lHhybszMR32mvTJlZTTpvKx1ZNV27L78RBeWdLJOdZ3mdN2YeNqYjzOwItMEfh
        CTi4Z86Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n8AUH-005LfN-JG; Fri, 14 Jan 2022 00:30:37 +0000
Date:   Fri, 14 Jan 2022 00:30:37 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: linux-next: Tree for Jan 13 (UBSAN: invalid-load in
 ../mm/swap.c:996:11)
Message-ID: <YeDELXPXWuM1qZc/@casper.infradead.org>
References: <20220113152247.3f7c6c49@canb.auug.org.au>
 <56c04e36-ff53-10c7-34dd-1c1385639de6@infradead.org>
 <YeCP8Kh+4y7NR1K+@casper.infradead.org>
 <24d83e9c-a4d5-176b-1ff3-909d0ad56302@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24d83e9c-a4d5-176b-1ff3-909d0ad56302@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 01:26:48PM -0800, Randy Dunlap wrote:
> 
> 
> On 1/13/22 12:47, Matthew Wilcox wrote:
> > On Thu, Jan 13, 2022 at 12:12:52PM -0800, Randy Dunlap wrote:
> >> [    1.561983] UBSAN: invalid-load in ../mm/swap.c:996:11
> >> [    1.561986] load of value 221 is not a valid value for type '_Bool'
> > 
> > Ooh.  This one's mine.  Randy, does it repeat easily?  This should
> > fix it:
> 
> Yes, 100% of the time (for N = 3).
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Fixed 100% of the time (for N = 3).

Thanks.  It's now at
https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/for-next
so it'll be part of the next linux-next.
