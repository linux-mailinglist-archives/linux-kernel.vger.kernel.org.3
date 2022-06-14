Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1741554AE4A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 12:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355302AbiFNK0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 06:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355305AbiFNK0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 06:26:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B425D48311
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 03:26:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E3D6B8184D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:26:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F47C3411B;
        Tue, 14 Jun 2022 10:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655202395;
        bh=l1sxLLZQWeVhqxlzjKTw7wCllLPbQt5ni97m0lqGV5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ludy/N4TC8k0iBsuPVkePMLBpq8hg5NTx2TQ3qnX9p2VfYRBiF5LL+MX49lnBVn5x
         Zk0jpCuPqBBs8ZufKuVYeONEDo/YJjBs8VHFmMkJU0uKo4rIoGXpQLCTq+DTFxicbK
         ZqAv9SwcrEFYXhDycTqj5xE7ucRfRuRR0YAT5gJ4=
Date:   Tue, 14 Jun 2022 12:26:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1] MAINTAINERS: add MEMORY HOT(UN)PLUG section and add
 myself as reviewer
Message-ID: <YqhiWMyuTEeyiLAf@kroah.com>
References: <20220610101258.75738-1-david@redhat.com>
 <YqhV7W68zR4yorQL@kroah.com>
 <2eb3f679-9779-2d7e-0863-5c808cf99ed6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2eb3f679-9779-2d7e-0863-5c808cf99ed6@redhat.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 11:35:28AM +0200, David Hildenbrand wrote:
> On 14.06.22 11:33, Greg Kroah-Hartman wrote:
> > On Fri, Jun 10, 2022 at 12:12:58PM +0200, David Hildenbrand wrote:
> >> There are certainly a lot more files that partially fall into the memory
> >> hot(un)plug category, including parts of mm/sparse.c, mm/page_isolation.c
> >> and mm/page_alloc.c. Let's only add what's almost completely memory
> >> hot(un)plug related.
> >>
> >> Add myself as reviewer so it's easier for contributors to figure out
> >> whom to CC.
> >>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  MAINTAINERS | 12 ++++++++++++
> >>  1 file changed, 12 insertions(+)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index a6d3bd9d2a8d..77aebce76288 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -12848,6 +12848,18 @@ F:	include/linux/vmalloc.h
> >>  F:	mm/
> >>  F:	tools/testing/selftests/vm/
> >>  
> >> +MEMORY HOT(UN)PLUG
> >> +M:	Andrew Morton <akpm@linux-foundation.org>
> >> +R:	David Hildenbrand <david@redhat.com>
> >> +L:	linux-mm@kvack.org
> >> +S:	Maintained
> >> +F:	Documentation/admin-guide/mm/memory-hotplug.rst
> >> +F:	Documentation/core-api/memory-hotplug.rst
> >> +F:	drivers/base/memory.c
> >> +F:	include/linux/memory_hotplug.h
> >> +F:	mm/memory_hotplug.c
> >> +F:	tools/testing/selftests/memory-hotplug/
> > 
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > One question, will patches from you go through my driver core tree, or
> > the -mm tree?  Either is fine for me, just curious.
> 
> In the past, most stuff regarding drivers/base/memory.c went through
> -mm, so I'd say we keep it like that, unless it's really generic changes
> to the driver model etc.

Sounds great to me, thanks for taking this on, much appreciated!

greg k-h
