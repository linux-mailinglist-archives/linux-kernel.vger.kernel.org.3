Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1704E4893B1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241855AbiAJIha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241141AbiAJIf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:35:29 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F82C061245
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 00:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=zKFC2ycEVwghWmKN6AS1V3tW7Z
        lh4pQxaHdS9MOjuvlVonNbnRRVPYKDqlak3IAK8lAU9s6ExtlnhBiNrzFe9wd4BTtkii0MqfhGhL/
        KVQKcB5LSUrQ5dwnSjWXdMhY6aS82NVPdoMgmRaZPNaYvHqzSfN+HabHgP4/SDeKZ/AotS5SjqwBU
        ecLXORc7+1z+mtg2xG/pDnoORXmbMhJlJQBbEbeRW4AT/7/ZTZ3qjOF33YC+GSqS/q1lP8jw7cK6Q
        5aGL3kxrPZgnI4ogtJw6NdMojWanIu8kvzFJoe+BSYiJu9wJbDgHy25+qDThNwqQ8LklLmi3phqpo
        xX6YyXHA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6q9G-009uh7-2z; Mon, 10 Jan 2022 08:35:26 +0000
Date:   Mon, 10 Jan 2022 00:35:26 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 17/28] gup: Add gup_put_folio()
Message-ID: <YdvvzrDrdGXiZshw@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-18-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110042406.499429-18-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
