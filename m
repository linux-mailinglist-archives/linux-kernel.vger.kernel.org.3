Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B498B5259A0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 04:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376479AbiEMCQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 22:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347937AbiEMCQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 22:16:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0803C4BFF3
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 19:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sJnARy5TGz4NpCzf3IzEC2y86PKjT72on0U1COCcsiY=; b=La+cZ0PiXhgVAZf9GrKw0MGt13
        A/qJeOL+7cPMG0h4QGK1tPteCkZSWazDjuWDc+XVBShe/Fe2p+nBRAyYYbK5QdHjE8KXIXze5GhX2
        B/cmHpiiqGGA5iy96ptFNHXE+Aw38ny02uI0DCYoolfcplF11yeT0KmQ3bB4k+1w2+aFwMncosdXP
        kixjpgxm2+zAdWt+16cG++hFBwgMIjkwTEoBtGIkcyI/BDKkK5WFc6wxKY2ngUpoWzlIRCe37ZItb
        LLV2HWk10fW+59HOfQjLAr9z0ziBWLeIgCt22gKkEs/karD3ZSLdB7Itz/qgN+Hfqu49IdfKxrztw
        +got7fdg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1npKrE-006xVl-Lc; Fri, 13 May 2022 02:16:44 +0000
Date:   Fri, 13 May 2022 03:16:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     songmuchun@bytedance.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: rmap: use the correct parameter name for
 DEFINE_PAGE_VMA_WALK
Message-ID: <Yn2/jIOgJKBtEdoc@casper.infradead.org>
References: <20220512174551.81279-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512174551.81279-1-shy828301@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 10:45:50AM -0700, Yang Shi wrote:
> The parameter used by DEFINE_PAGE_VMA_WALK is _page not page, fix the
> parameter name.  It didn't cause any build error, it is probably because
> the only caller is write_protect_page() from ksm.c, which pass in page.
> 
> Fixes: 2aff7a4755be ("mm: Convert page_vma_mapped_walk to work on PFNs")
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Oops.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
