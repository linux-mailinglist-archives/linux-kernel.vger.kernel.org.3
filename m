Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719854893C3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241779AbiAJIjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241817AbiAJIhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:37:22 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755FBC029828
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 00:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DpKvSwxbbfQbLZApW/SnZkrEtdEJ/1VZArTMlGDXrSM=; b=Y7BsiipGKK2DffmCmd+iLr0YAk
        V6JtBSMvnBLFpbxfWYrUkKYID7QJs3IFPJks+isIeD8pDYZx0VHkqLLKE4nhn5sjXCADItWkKgquQ
        2shiUoZFHPNvciDHeWQaOK3tc4Oc/Iv5RuzmxuK42ea5NgCs7CJw9tnKZ81i5ofmWG5ZR4Oc/OUai
        4SmqWj9ldQ4UiTsh+0B96aWwz2UgLYsXaVVJ/Y/SPdbRdDbdJS/8PSVzYuIMcRfh+w8FLqpwQplca
        4NWpcN1RVFrvkMZFOEYnrWnfDOk5MIZX8ZDQZ5rgH6wlmSBJg2N4HwD/rTQ/w/vvW1bGSIQjubkX+
        Su0VXJjQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6qB5-009vpK-1N; Mon, 10 Jan 2022 08:37:19 +0000
Date:   Mon, 10 Jan 2022 00:37:19 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 20/28] gup: Convert gup_pte_range() to use a folio
Message-ID: <YdvwPpGjpViLMCXy@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-21-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110042406.499429-21-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 04:23:58AM +0000, Matthew Wilcox (Oracle) wrote:
> We still call try_grab_folio() once per PTE; a future patch could
> optimise to just adjust the reference count for each page within
> the folio.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
