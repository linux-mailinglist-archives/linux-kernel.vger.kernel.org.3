Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033F454AD6E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240252AbiFNJdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiFNJdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:33:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592A6369D1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 02:33:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4316616C2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:33:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB631C3411B;
        Tue, 14 Jun 2022 09:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655199216;
        bh=eAD2Nm40ZGfqfqGV8vZO6LXK5PtcsG7DGBs49wgdhL4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SxqNsJgpOTvs7OHthIb+Vqs8wl4JCTWD5BAyOG14tchTnun3YyBLFnOf2JUdcYnNQ
         M7LQUlV7iQ4XygYlKLRLV1H/bO75ilPJD++Al87DkpAn4gqRJdCoBkFTa9hvihC1+i
         yv2CPn6vqlDQ0G9OzMUUnQcwErYrDQgkG+s8drKE=
Date:   Tue, 14 Jun 2022 11:33:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1] MAINTAINERS: add MEMORY HOT(UN)PLUG section and add
 myself as reviewer
Message-ID: <YqhV7W68zR4yorQL@kroah.com>
References: <20220610101258.75738-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610101258.75738-1-david@redhat.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 12:12:58PM +0200, David Hildenbrand wrote:
> There are certainly a lot more files that partially fall into the memory
> hot(un)plug category, including parts of mm/sparse.c, mm/page_isolation.c
> and mm/page_alloc.c. Let's only add what's almost completely memory
> hot(un)plug related.
> 
> Add myself as reviewer so it's easier for contributors to figure out
> whom to CC.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  MAINTAINERS | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a6d3bd9d2a8d..77aebce76288 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12848,6 +12848,18 @@ F:	include/linux/vmalloc.h
>  F:	mm/
>  F:	tools/testing/selftests/vm/
>  
> +MEMORY HOT(UN)PLUG
> +M:	Andrew Morton <akpm@linux-foundation.org>
> +R:	David Hildenbrand <david@redhat.com>
> +L:	linux-mm@kvack.org
> +S:	Maintained
> +F:	Documentation/admin-guide/mm/memory-hotplug.rst
> +F:	Documentation/core-api/memory-hotplug.rst
> +F:	drivers/base/memory.c
> +F:	include/linux/memory_hotplug.h
> +F:	mm/memory_hotplug.c
> +F:	tools/testing/selftests/memory-hotplug/

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

One question, will patches from you go through my driver core tree, or
the -mm tree?  Either is fine for me, just curious.

thanks,

greg k-h
