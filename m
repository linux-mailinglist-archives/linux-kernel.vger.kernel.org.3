Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E594893C8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241563AbiAJIkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242048AbiAJIil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:38:41 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5D1C034000
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 00:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=zc18Cqy8RV1eLjJG4jShhfScba
        yEznSMpuklTGkAHnevqvwN5XEfOKtRvbKiaK9Q9mb4u7RD4sKgJ6R1ZOLGKqu2T2liIiuFqVLpUy6
        LOpLMZIMl08ElVKJko7XfDuoGWyGXk85WVV9Cb5WJ2A58FTF/CeHL24SZVwJVevy+DrXG+O/AfShy
        1sLogsYXlz2Nq/vKZcJi/iGe6m5xntmh9TWI7e31EK8XxI2OIe3WvyLp/plYpOtQQh2L2VSkihF8B
        ZgCCsI+euxFbhNQk526/s4bWduDuUJPeJ4LZiRWU4UFCeK364Z26pG3sza91cD7B+TeQEZzOBbg3l
        Q0nQ4/ZA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6qCK-009wcF-D0; Mon, 10 Jan 2022 08:38:36 +0000
Date:   Mon, 10 Jan 2022 00:38:36 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 24/28] gup: Convert gup_huge_pgd() to use a folio
Message-ID: <YdvwjPIj5eKCdgmf@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-25-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110042406.499429-25-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
