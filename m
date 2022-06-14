Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E44754B7D4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 19:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344225AbiFNRis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 13:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiFNRir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 13:38:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DEF2E9DB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:38:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99D2CB81A3E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 17:38:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C82EC3411B;
        Tue, 14 Jun 2022 17:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1655228323;
        bh=nRucdW5dS3GtPYU9/dtMXyj0lNslN55PKAmMDovGIEU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bgIEbR/jcjX+ZxCpytCjshiiwEn6W/JNhLVMh3XyJEmlPO3eBOcC02a3k7paJYBqF
         yINetEFiw250n4VhSTCADVU4mOuF6Jl4h3uK2uW+RyKYdkllhM4WS9MIBtvYrI/tTI
         xXj7Imz1v4Y4vjhiq0acYvyi/JmfqR/9SmAYfpb4=
Date:   Tue, 14 Jun 2022 10:38:42 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v1] MAINTAINERS: add MEMORY HOT(UN)PLUG section and add
 myself as reviewer
Message-Id: <20220614103842.af0c9a5434e3099cf9060cf5@linux-foundation.org>
In-Reply-To: <72194595-a177-088d-28a9-0a24d4192777@redhat.com>
References: <20220610101258.75738-1-david@redhat.com>
        <72194595-a177-088d-28a9-0a24d4192777@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jun 2022 08:58:55 +0200 David Hildenbrand <david@redhat.com> wrote:

> On 10.06.22 12:12, David Hildenbrand wrote:
> > There are certainly a lot more files that partially fall into the memory
> > hot(un)plug category, including parts of mm/sparse.c, mm/page_isolation.c
> > and mm/page_alloc.c. Let's only add what's almost completely memory
> > hot(un)plug related.
> > 
> > Add myself as reviewer so it's easier for contributors to figure out
> > whom to CC.
> > 
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> >  MAINTAINERS | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index a6d3bd9d2a8d..77aebce76288 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -12848,6 +12848,18 @@ F:	include/linux/vmalloc.h
> >  F:	mm/
> >  F:	tools/testing/selftests/vm/
> >  
> > +MEMORY HOT(UN)PLUG
> > +M:	Andrew Morton <akpm@linux-foundation.org>
> > +R:	David Hildenbrand <david@redhat.com>
> > +L:	linux-mm@kvack.org
> > +S:	Maintained
> > +F:	Documentation/admin-guide/mm/memory-hotplug.rst
> > +F:	Documentation/core-api/memory-hotplug.rst
> > +F:	drivers/base/memory.c
> > +F:	include/linux/memory_hotplug.h
> > +F:	mm/memory_hotplug.c
> > +F:	tools/testing/selftests/memory-hotplug/
> 
> (thanks for the kind words from reviewers :) )
> 
> Thinking about it (and remembering having a discussion about
> submaintainers for MM in general at LSF/MM):
> 
> @Andrew, do we want "official" submaintainers for that section? If so,
> we could turn my R into an M. Further, Oscar did a lot of work in the
> memory hot(un)plug world as well -- so if we want submaintainers, Oscar
> might be a very good fit as well.
> 
> ... I guess, that would mostly reflect reality :)

um, fine, no opinion really.  I think the main thing is to make
get_maintainer.pl spit out all the suitable email addresses.
