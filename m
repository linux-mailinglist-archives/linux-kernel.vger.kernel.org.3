Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBD24880F2
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 03:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbiAHClm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 21:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiAHClk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 21:41:40 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E747C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 18:41:40 -0800 (PST)
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CD1EDCE2B0F
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 02:41:38 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9F216024A;
        Sat,  8 Jan 2022 02:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1641609697;
        bh=VnJOQKjOdeXS9YOKhtuUHjp81MAQRP8p0agaiKUXnOA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HGvFPpfQ1/C6fw2IEMdM2ns3t6xRAuZzDlT5BF7Qxh2sTrEkwi0X3WWDLFV7SZI5B
         RZ2UqHZJVBT+aqwjYjYpCHsoceTbMHYOx05GOxQHdKdigg/llN8m71tyCw0qzukB5I
         WkuPlT0TnRX6ah5/hY3OfcSudawYmDOYTFOSWXgQ=
Date:   Fri, 7 Jan 2022 18:41:35 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>, peterz@infradead.org,
        vbabka@suse.cz, will@kernel.org, linyunsheng@huawei.com,
        aarcange@redhat.com, feng.tang@intel.com, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove offset check on page->compound_head and
 folio->lru
Message-Id: <20220107184135.c1af37af712c35597b527414@linux-foundation.org>
In-Reply-To: <YdjfsbAR0UlwyC6b@casper.infradead.org>
References: <20220106235254.19190-1-richard.weiyang@gmail.com>
        <Yde6hZ41agqa2zs3@casper.infradead.org>
        <20220107134059.flxr2hcd6ilb6vt7@master>
        <Ydi6iMbSZ/FewYPT@casper.infradead.org>
        <20220107160825.13c71fdd871d7d5611d116b9@linux-foundation.org>
        <YdjfsbAR0UlwyC6b@casper.infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jan 2022 00:49:53 +0000 Matthew Wilcox <willy@infradead.org> wrote:

> > > If you can't be bothered to read, why should I write?
> > 
> > I don't think the punishment comes close to fitting the crime here :(
> 
> I felt I had to NACk it as quickly as possible so you didn't apply it.
> Otherwise I'd've waited until I was back from holiday before replying
> to the earlier patch.  But you applied that lickety-split, so clearly
> I'm not allowed to take a week off.

https://lkml.kernel.org/r/20220104011734.21714-1-richard.weiyang@gmail.com ?

Yeah, I stashed that away on top of linux-next so it wouldn't fall
through the cracks.  But folios is Matthew stuff so I wouldn't expect
to be sending it upstream without you having commented on it.
