Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE7C4A948C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 08:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350704AbiBDHZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 02:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237855AbiBDHZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 02:25:36 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F21C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 23:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pSIk8p85bexLoPQZFRwkv0+ES2itcgz4LVldLAyslFc=; b=ga7TLa31ECuvrOpogYl+VPdgMX
        lFCXWAWmUgaUUwfItnclfICRNswZH8D0CsGAOM0ulh1dTv+RDAcSHVX7KO8sdjzNnX4sDEW65NDjc
        bZyWb8QAfCxHpoab6WT2wkdkjCB9cj6SKtaTSieuKERGLW7SvC9/iJuKzCkPJ2WRrTe6VAME2Id83
        OW3iQXjiqHhsVeSR5E0sAjt7wvZqIS0qNdfp1EAvcYGsfbwyvQqScCAI5+8GgpFyVTGd+3dsBgTXe
        dtpMlYofz3tj4GPBrp6wzNIfTV+QHcNeiMUwNZwR3DYIcTZMTuaibccRXG6WVjkAqzuWjfMlTr4Jw
        DaI96LSQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFsy9-003eFM-2M; Fri, 04 Feb 2022 07:25:21 +0000
Date:   Thu, 3 Feb 2022 23:25:21 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        David Hildenbrand <david@redhat.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH v4 1/5] mm: Fix invalid page pointer returned with
 FOLL_PIN gups
Message-ID: <YfzU4Yh/1Oh7Dsw0@infradead.org>
References: <20220204020010.68930-1-jhubbard@nvidia.com>
 <20220204020010.68930-2-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204020010.68930-2-jhubbard@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 06:00:06PM -0800, John Hubbard wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> Alex reported invalid page pointer returned with pin_user_pages_remote() from
> vfio after upstream commit 4b6c33b32296 ("vfio/type1: Prepare for batched
> pinning with struct vfio_batch").

This commit message uses overly long lines all over.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
