Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A764A9483
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 08:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351409AbiBDHZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 02:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345608AbiBDHZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 02:25:58 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C67CC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 23:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=dUfJ9oIPb09/P1iG8eJikeCtWP
        6cvtKKl8KlCflPCWyrCRDd58kigHzVtX28U1LXhPpOQQGVc6InikohgUsJmrSNMidjmOLZyCdi/uM
        CeQzof8hKPyTULlq/w7AwcrZ19fnQnVwTT77dMZA5Rz9i0poOWBXrLxGtZ9QUdM6JHtPhqtrFXN/Z
        rGe18h5c2p+qIou04xEgvFoY5C6T0IgDs/k3ooKR9wD2c7aIQ/jBWl+mYtfCe5lga3io/zhoXZK+W
        RJVf6BUMduKBNMR9nG8zgkNiW3FV8R4osAYj6XEDSPCxgq/JOBrhlNFzpFdMECM54ywtjvYzkPVgR
        WgHP41cQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFsyZ-003eMs-GH; Fri, 04 Feb 2022 07:25:47 +0000
Date:   Thu, 3 Feb 2022 23:25:47 -0800
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
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 2/5] mm/gup: follow_pfn_pte(): -EEXIST cleanup
Message-ID: <YfzU+50oECv9Amq/@infradead.org>
References: <20220204020010.68930-1-jhubbard@nvidia.com>
 <20220204020010.68930-3-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204020010.68930-3-jhubbard@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
