Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD994B6D18
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 14:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238134AbiBONMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 08:12:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238089AbiBONMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 08:12:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9353CA5C;
        Tue, 15 Feb 2022 05:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WJCVjdG3llh4Pax4fS+sKC0PQ6TTr4horlSS1/qCeE0=; b=CpIQqwuWuVIIYpAJEwuBFabxE2
        FLqI07WOzty023BhI3LpkZQUvlYVREo3skH4lEkjflWKRGzMdFkoxwiPFWEzLgd8srDJ+zAR+53j1
        /h/XeEnD+/ucwyvtyr3osNk8D4AnlBhxFni/aOwBd678kC4F3mPfdeOKdYkIflSeYHpa1yC/0DuqI
        hNXiAlGwlzrKLB+8JnF62PH5rCjIvBZ3PKyavRRpc5b+JjWXe362RaMHgSSAcGzpusc4ZMiWEmdL9
        lv2f1j88NvovRVTAm+Gdxk6pYc0TsZ03WVhRC6wC9E79reDLH9DGB5mYJptp/yxP1PO4hGbM5lvJ/
        ibvix2Sw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJxcj-00DrTR-37; Tue, 15 Feb 2022 13:12:05 +0000
Date:   Tue, 15 Feb 2022 13:12:05 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the akpm-current tree with the folio
 tree
Message-ID: <YgumpQrC+cuYe91H@casper.infradead.org>
References: <20220215180043.23879691@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215180043.23879691@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 06:00:43PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the block tree got conflicts in:
> 
>   include/linux/mm.h
>   include/linux/rmap.h
>   mm/gup.c
>   mm/huge_memory.c
>   mm/internal.h
>   mm/memory-failure.c
>   mm/migrate.c
>   mm/mlock.c
>   mm/rmap.c
>   mm/vmscan.c
> 
> There is no way I can figure out in a reasonable time (or at all
> probably) the resolution needed here.  You guys need to get together
> and figure out how the folio tree changes are going to progress to
> Linus' tree.
> 
> I have gone back and used the folio tree from next-20220204 again for
> today.

Thanks!

My plan is to take v2 of Hugh's mlock rewrite into my tree today and
redo the folio changes on top of those.  That should reduce the amount
of conflict between akpm's tree and the folio tree to the usual
managable amount.  Let's see how that goes.

