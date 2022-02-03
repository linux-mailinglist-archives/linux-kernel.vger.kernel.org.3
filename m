Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092EB4A85A6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350953AbiBCOBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbiBCOA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:00:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26999C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 06:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CG7qhRTZqFuGbV5KI21kTvEgW0iKHq6T7r1QvRxD/2M=; b=eW+lm/XgE3echvTFXo9YykT+Jb
        aLS0JyHij9OJeRzd2cYEU3K5iuPvKXoD01Ye7n7tdf25z+hJk1M+ZPIb0fQ7YudqWZF+pOjfjuyjH
        J6bNvWp8r+NSkwsROi7U/vxuzahTka5HBgedkmhZUZlgdm9wifsNoHQTRfPMz3eMJXbLxVwegWMju
        jDa++Z8ubTXt52cFO1HVN/dyusGtGZTCXLnmcCk/63yci45VhbEMJLxv5cwFa58rZ0cOyESJbOHS7
        wPiA//K8IkHtMeBzj1XXcr7pdX+c63F9B7GOnXu4zkZbmU1wrEE7p0njSGEt5u3QI9/jWB4Jaz9jk
        083LxB9A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFcfD-001VeD-Nr; Thu, 03 Feb 2022 14:00:43 +0000
Date:   Thu, 3 Feb 2022 06:00:43 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        David Hildenbrand <david@redhat.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jan Kara <jack@suse.cz>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH v3 1/4] mm: Fix invalid page pointer returned with
 FOLL_PIN gups
Message-ID: <YfvgC5Y9mTb3vKlV@infradead.org>
References: <20220203093232.572380-1-jhubbard@nvidia.com>
 <20220203093232.572380-2-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203093232.572380-2-jhubbard@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 01:32:29AM -0800, John Hubbard wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> Alex reported invalid page pointer returned with pin_user_pages_remote() from
> vfio after upstream commit 4b6c33b32296 ("vfio/type1: Prepare for batched
> pinning with struct vfio_batch").  This problem breaks NVIDIA vfio mdev.

There still isn't any nvidia vfio mdev driver in the tree, so this
changelog stilldoesn't make sense.
