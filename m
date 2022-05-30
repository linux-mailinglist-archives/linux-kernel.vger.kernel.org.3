Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343C25374ED
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbiE3GCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 02:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbiE3GCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 02:02:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45891117A;
        Sun, 29 May 2022 23:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gALyP/CMA6emj8d/vZKE9o5rrBEKx+kILp+mMDTKqmQ=; b=IUrcmREBTTE/w8QfgnZ/hEOkOT
        18B5s3XuAXNJYul7S8WaoOxQVEcnygbbwAciZL8LKbZs9slKqIKjzVeV9JHtVyfMmeDmaU2cet53w
        OHf0+P0GOp1akbb82wSR1nJRnKSmrEeGE+I5/CL9qjUgCQh+K+RCs+w46/1y9Z6onAUo82TBp06Dd
        Vti72+i0wgol2U47RMaKXkWq6GC/zl60eIYxaUm+U9ae9ZNkOtTH6a1kHCfhb9ob3HlnK1/Lk01BQ
        YeA8Lp7WrpJjuDYFBQoJAxzRpH4v1nBT/JS/PKuZvJZ87MM1dLXZQ6v6p6rICE55DIBunpVY4rHD7
        1hprkNhw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nvYTX-005Ude-OH; Mon, 30 May 2022 06:02:00 +0000
Date:   Sun, 29 May 2022 23:01:59 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Donald Buczek <buczek@molgen.mpg.de>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>, Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
Subject: Re: [PATCH v2 15/17] md: Use enum for overloaded magic numbers used
 by mddev->curr_resync
Message-ID: <YpRd13d/pXVEWlrE@infradead.org>
References: <20220526163604.32736-1-logang@deltatee.com>
 <20220526163604.32736-16-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526163604.32736-16-logang@deltatee.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 10:36:02AM -0600, Logan Gunthorpe wrote:
> Comments in the code document special values used for
> mddev->curr_resync. Make this clearer by using an enum to label these
> values.
> 
> The only functional change is a couple places use the wrong comparison
> operator that implied 3 is another special value. They are all
> fixed to imply that 3 or greater is an active resync.

This already looks good, but shouldn't the curr_resync also be changed
to the new enum type?

Reviewed-by: Christoph Hellwig <hch@lst.de>
