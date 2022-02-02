Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD5B4A72AD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237234AbiBBOGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiBBOF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:05:58 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1118C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 06:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=JDYtA5jWOUZSexGCh+7Spp+EnN
        ITCr1zEfkwQFjng2PlT7sccnabJWyJtdrLoCvtuVY/0TmVRQ6xDQAxeLsE9a/gY5zRrrWb9k+L9wO
        fM3mC6REGCG4jxoAcJjjcV5x4nPhbqMa+HIzHMxzUCNCd3/nJifG+Oej4y2G6IfF7azJvJTgIrugx
        gRygVPc8+euQMI6OwHFxyTovDgKCFpO0J4g4mMIOm6tCg4UtZl+detZPq0LA8YSZRMU/6wsrXw2VI
        riJhkfMHDp4ZxOT3mbN5zuz1uqZw8YG9GKCeTdM3nfeHLLrTztubXYJYOnFOGYk/iLQqpXcQxYw81
        p6VhYkow==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFGGe-00FXFI-L2; Wed, 02 Feb 2022 14:05:52 +0000
Date:   Wed, 2 Feb 2022 06:05:52 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Jan Kara <jack@suse.cz>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH 3/4] mm/gup: remove unused pin_user_pages_locked()
Message-ID: <YfqPwNI3DOGOxufQ@infradead.org>
References: <20220131051752.447699-1-jhubbard@nvidia.com>
 <20220131051752.447699-4-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131051752.447699-4-jhubbard@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
