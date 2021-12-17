Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42030478357
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 03:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbhLQCpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 21:45:34 -0500
Received: from relay027.a.hostedemail.com ([64.99.140.27]:17450 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229471AbhLQCpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 21:45:34 -0500
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id 28D8B21DE8;
        Fri, 17 Dec 2021 02:45:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id 807072E;
        Fri, 17 Dec 2021 02:45:31 +0000 (UTC)
Message-ID: <44b1244ad563a6de661766b8cc7bfacde82d221b.camel@perches.com>
Subject: Re: [RFC] Add a 'tag' field to MAINTAINERS
From:   Joe Perches <joe@perches.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 16 Dec 2021 18:45:30 -0800
In-Reply-To: <286e55e0c37d2ae60c123412318f90accf0473d0.camel@perches.com>
References: <Ybuy++k9sitvrem3@casper.infradead.org>
         <286e55e0c37d2ae60c123412318f90accf0473d0.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.71
X-Stat-Signature: gojekmtr5fapiqyhcda46bto8mh1ixtq
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 807072E
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18yWhVIbbe4wOaRwEGaz3Y0h7S09ERZwU0=
X-HE-Tag: 1639709131-391824
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(apologies for the blank reply, evolution email client isn't great)

On Thu, 2021-12-16 at 21:43 +0000, Matthew Wilcox wrote:
> People find it hard to use the right tag when sending patches which
> affect a maintainer that they don't interact with often.  If we add
> a field to MAINTAINERS, perhaps a tool will be written some day that
> automatically adds it to patches.

I am not against the concept, but at least the initial entries
should mirror what is currently used.

> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -14927,6 +14929,7 @@ M:	Pawel Osciak <pawel@osciak.com>
>  M:	Marek Szyprowski <m.szyprowski@samsung.com>
>  M:	Kyungmin Park <kyungmin.park@samsung.com>
>  L:	linux-media@vger.kernel.org
> +J:	videobuf
>  S:	Maintained
>  F:	drivers/media/v4l2-core/videobuf2-*
>  F:	include/media/videobuf2-*

This isn't useful.

Almost every patch to this pattern is prefixed with something else.

$ git log --pretty=oneline --no-merges -- 'drivers/media/v4l2-core/videobuf2-*'
03fbdb2fc2b8bb27b0ee0534fd3e9c57cdc3854a media: move videobuf2 to drivers/media/common
c0cb76589c77b9a05f6271691be8707104ff0241 media: vb2: unify calling of set_page_dirty_lock
327553ae8eb87a66b2c9e041e890ea66f21009b2 media: vb2: clear V4L2_BUF_FLAG_LAST when filling vb2_buffer
d28b2cf969b1e887450700191c22df8085574e9b media: v4l2-core: Fix kernel-doc markups
2a87af6ba1b9df4dda91d7e1a7d750f295ce1e57 media: videobuf2: don't use kernel-doc "/**" markups
c4860ad60564838994b74e7ee7dd12ceeda0f520 lib/scatterlist: Fix offset type in sg_alloc_table_from_pages
5b6f9abe5a49df81737fbbfba890ee5b093f8168 media: vb2: add bidirectional flag in vb2_queue
07ca2d4c0f44086eb38bbe0b3f86a379a701e2dc media: vb2: core: Lower the log level of debug outputs
efaf515f0d5124193393e37adbef423866a99273 media: vb2 dma-sg: Constify dma_buf_ops structures
59310b7a06c1f9c7d8fd2d981dbc85226214dc32 media: vb2 vmalloc: Constify dma_buf_ops structures
6e03db38631f5607e81856418ffe779c29e53c56 media: vb2 dma-contig: Constify dma_buf_ops structures
758d90e161382c134b7cbd5f724df4de02f3c67e [media] v4l2-core: Use kvmalloc() for potentially big allocations
72b7876c2e3b6087c72ce030d8145ec4a7328121 [media] vb2: Fix error handling in '__vb2_buf_mem_alloc'
a136f59c0a1f1b09eb203951975e3fc5e8d3e722 [media] vb2: Move buffer cache synchronisation to prepare from queue
6aca5b8fb86681954e6715494e74106db505701c [media] vb2: Rename confusingly named internal buffer preparation functions
ef6ff8f47263b1a98b7c3a8d7ee30c1d5b0afdfa [media] vb2: Fix an off by one error in 'vb2_plane_vaddr'
f9b67f0014cba18f1aabb6fa9272335a043eb6fd dma-buf: Rename dma-ops to prevent conflict with kunmap_atomic macro


