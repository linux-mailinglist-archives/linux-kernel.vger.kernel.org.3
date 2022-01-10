Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 656264893C7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241560AbiAJIkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241558AbiAJIi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:38:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99333C06175B
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 00:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=wg0iwoyxYffskWMbwkjGNQyp7f
        vrtx4S99MX/SA0jIEUNzuCH4LxD1i4XEDbr1g1BBGOorZVTv21ZsFA6kTpKNgIpqrj9b1JzkOKRCe
        DkI4Fzj4TbM5g/u5YYeRYVs4zpFxJgQUvWPJkNvTJqq+1XK5q1ZpXhbp5yrLyGrj2xojm5CVMBA8A
        gOSiPE42NXwCrPPu33wSGtMgOnG+nTIExqW2BrDOID4tezs48E2qBqG5QNVVcFpovGuFf5AZYs1JW
        ihIR1Lz8aX5qhiXgqe7qIPuuU8XJsiuNaSrF8gfm6veqrR9smg/hFapjUKIUP3q8ylZsFGuafB7xx
        4KrHtGdw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6qC3-009wSA-37; Mon, 10 Jan 2022 08:38:19 +0000
Date:   Mon, 10 Jan 2022 00:38:19 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 23/28] gup: Convert gup_huge_pud() to use a folio
Message-ID: <Ydvwe8XhUk3Uqhr4@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-24-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110042406.499429-24-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
