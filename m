Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2284A9490
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 08:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352100AbiBDH1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 02:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351832AbiBDH1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 02:27:33 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74180C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 23:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=Q81m7RMN9vHzB27mv8Q6asJ1EE
        AhBInTF4FR72mbi7o4MjqPIHaOvzcJdj0ctm+KDtzexzfk0SD2dqkmfX9GyJjQ2SvCG4ZCHGt3e1t
        t38HvrGUpPK7H/lsP5Wqmrru2LIZ3p8xi1kEObTw4hJMAo5BeZmqks1GxEVa51EZAWsg2kvR0sa2r
        ww3Pmuib4JETMRDytEdX9fXDxxRnGRLoAdEM9MdwyiqrytLNGvDvgqH7TuA8AkpU0UB7XHUx02V2u
        P6vDWy/uyFjFzctlwfkGn37UovuWII6c56j0HGWoVe/r25k+ELDpMGqFwUnPhi6677tP0TL3qDT+t
        xfSMRNoA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFt09-003edP-Of; Fri, 04 Feb 2022 07:27:25 +0000
Date:   Thu, 3 Feb 2022 23:27:25 -0800
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
Subject: Re: [PATCH v4 5/5] mm/gup: remove unused get_user_pages_locked()
Message-ID: <YfzVXZVUmmwLNqlm@infradead.org>
References: <20220204020010.68930-1-jhubbard@nvidia.com>
 <20220204020010.68930-6-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204020010.68930-6-jhubbard@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
