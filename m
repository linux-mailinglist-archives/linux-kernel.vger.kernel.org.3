Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D004893E1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241867AbiAJIoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241837AbiAJImF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:42:05 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0884C029818
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 00:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=UQAps8BDvjs2WdEKtXNE0HXviK
        GNBg2bMBbfspkE/i22At0l4AsAkFjA6Mh4N4n09DKbJX0Z5NB2tRKaQbIp9DRoPwgWsjp8dLhbShj
        Lhb4eE/3ucIHCHekaDNdsnDs2keYxNQPGWy7s5vMg55pUATB5fdj4lYnqojSj7friwSpO42eDQEmz
        8DIH6yHzPDzunDVQlGPT17GgBk4jgiwp6ooqnJ/2+j51iX53IV4rORhW1QVcf4Rtwa5qDavrCbUo2
        wxw1DCbHLAO6kKzUT4CmVaAOaOncuwulyYnGtNkxdRA3c087xwNxX2/Qt/qJuXQtkuKnSZlus1N+O
        WhkUnrug==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6qFd-009yRR-A4; Mon, 10 Jan 2022 08:42:01 +0000
Date:   Mon, 10 Jan 2022 00:42:01 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 27/28] mm: Add isolate_lru_folio()
Message-ID: <YdvxWexCYxNecLIs@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-28-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110042406.499429-28-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
