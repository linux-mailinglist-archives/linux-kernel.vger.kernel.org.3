Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3886D4A948F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 08:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351896AbiBDH1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 02:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350514AbiBDH1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 02:27:18 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F42AC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 23:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=HZiCDYhZpzvytC9iZRuSMu1VdQ
        b4ZansFXJ+uDQmEW8vA97ehgxfvApD3PlUB0vaadpAEvsrEzkE7toB/V9sezXT03d/7m3a9Tzf5x2
        C2VuQ7vGp3X47zexZk/jPWoSW7+8xS7Wh3+DkTtCtj/AuQlXv1LJ7+KgczblGCu7qqsRP0hddQzgc
        pvM+7hphaQZtZXIIiIbo+Zqp6VN9LZ+St1sQPMaQ6V61vGKVkDKDECDlI/tRH/5NYo2FgnDLc5BRK
        hPg3DdtnhVm5tAY68mfZpUYh9eWqKdADqUuoReGvpzdQW3W7qJ5P43QULsogWtGePcz3JAIKngcsr
        HS+D0XwA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFszt-003eZm-MK; Fri, 04 Feb 2022 07:27:09 +0000
Date:   Thu, 3 Feb 2022 23:27:09 -0800
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
Subject: Re: [PATCH v4 4/5] mm: change lookup_node() to use
 get_user_pages_fast()
Message-ID: <YfzVTQjqF4Sq8FYO@infradead.org>
References: <20220204020010.68930-1-jhubbard@nvidia.com>
 <20220204020010.68930-5-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204020010.68930-5-jhubbard@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
