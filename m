Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61B6489330
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240055AbiAJIXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240074AbiAJIXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:23:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E369C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 00:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=s5bbJNH5T6m/zyVHmcaRQJ/AUF
        AnC0PbQY+8w40YaWfG7Ee8TLgjgU8sa0NolQIqHx6A/aSFwy8gRuqvZy43R+YqDqDDkmGYDwVizWT
        fliflKfCiKFvWxmNLBMaFrbOo2CuCP7ILt0uLgvL9LXANo+oJn4eW184S777e8XMkcGcaf4fv9t4w
        tVbvx0TMWeguEgUHcTCGqXMkLQaef87CsQ6SqJdsVNtQDfPpynUmoms2+520qtEx8uiJU/veeNrmx
        7BoaT1hmHwIXSZSXtNfPYRtuRmTbgQgJhAZtOX/zumxsBf+eLjNn+WkY1ul247PrFkNdtFWeqNWvS
        J61a8kTA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6pxQ-009pqI-Qc; Mon, 10 Jan 2022 08:23:12 +0000
Date:   Mon, 10 Jan 2022 00:23:12 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 02/28] gup: Remove for_each_compound_head()
Message-ID: <Ydvs8OWRMlvNX/IR@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110042406.499429-3-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
