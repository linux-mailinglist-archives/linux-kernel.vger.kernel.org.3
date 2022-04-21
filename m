Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCC850A2E3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389537AbiDUOpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbiDUOpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:45:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C68B3F31A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:42:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30DF8B824BD
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 14:42:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F5DC385A5;
        Thu, 21 Apr 2022 14:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650552167;
        bh=faSSihUeKhEgOMFaEeqtYEPXOtu+2j1tbYQhSIYwjKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tmxnEZe//McI2jrtHQ1WKUam5+59DxYfZH8iiXgGkeee97pJqIEP+rFcV8DAt6Qzl
         yz3NuZQ+0xtBLq5Y/lnl2ONiFT5cRbrk+1H56LpABvJR4AA71a6MWz4FCtaEaZRjgH
         fxmAwJ1AZWtQFLEx3aUGyA+XnQrr93o+tdJHwoiOFTR41fvxBvtCiYs44/ORq+Giji
         r8CeVosEeNLjj7kFi5sIRkwCviM3YpupmRCgNOQNjMUTRLGoYTMfbTMtJG8BBWI67m
         wBodIke1jnufbZZYoN6s3x2Y9gRVASOCoVXa02uF4vfuSCyZuPH80wGWEodBcmmb9x
         gaA8N/RVW99ag==
Date:   Thu, 21 Apr 2022 17:42:40 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Rebecca Mckeever <remckee0@gmail.com>, outreachy@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] memblock tests: remove extra column of spaces in
 block comment
Message-ID: <YmFtYPlrJtv7iKh3@kernel.org>
References: <cover.1650452552.git.remckee0@gmail.com>
 <663c930475c3c0a32965024c1094d3288629a3af.1650452552.git.remckee0@gmail.com>
 <d46accec-28f7-d678-b475-c4402bba8211@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d46accec-28f7-d678-b475-c4402bba8211@redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 09:09:58AM +0200, David Hildenbrand wrote:
> On 20.04.22 13:19, Rebecca Mckeever wrote:
> > Remove extra space at the beginning of each line in block comment
> > for consistency and to conform to Linux kernel coding style.
> > 
> > Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> > ---
> >  tools/testing/memblock/tests/basic_api.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
> > index 834d8705ff8a..05448a25f1f9 100644
> > --- a/tools/testing/memblock/tests/basic_api.c
> > +++ b/tools/testing/memblock/tests/basic_api.c
> > @@ -303,12 +303,12 @@ static int memblock_add_checks(void)
> >  	return 0;
> >  }
> >  
> > - /*
> > -  * A simple test that marks a memory block of a specified base address
> > -  * and size as reserved and to the collection of reserved memory regions
> > -  * (memblock.reserved). Expect to create a new entry. The region counter
> > -  * and total memory size are updated.
> > -  */
> > +/*
> > + * A simple test that marks a memory block of a specified base address
> > + * and size as reserved and to the collection of reserved memory regions
> > + * (memblock.reserved). Expect to create a new entry. The region counter
> > + * and total memory size are updated.
> > + */
> >  static int memblock_reserve_simple_check(void)
> >  {
> >  	struct memblock_region *rgn;
> 
> I'd pull this patch to the front, so you don't end up modifying a wrong
> style in patch #2. You could also just squash this patch into patch #2
> and mention it in the patch description.

Let's squash this into patch 2.

> -- 
> Thanks,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.
