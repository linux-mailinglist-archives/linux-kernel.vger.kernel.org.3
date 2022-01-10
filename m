Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2AB48939E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241195AbiAJIgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241396AbiAJIez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:34:55 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8184C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 00:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=WNPxGyYwnSzqiNMv+BSEwhMgaq
        17ADOE6J9cFtj4gGdqVk0aPyFrRJOlP1+owC3f/lZqB5Kc2lZnj9/l7hUrWKkbCF4bprzl83TYKYW
        kYb7M8d1Fen5ToDjz1XyqDuAFypEUVXP9jo+HXp17OEFGY901wU3bId4fFqPhhHjBk+m3A5PIIWQo
        NBQrKiiyhiT5vppD7W4+mAOg0Z0bAJwVpWXZPMOGJnxOCmqXIvjk4Hpbfv9u3A2/DM7iLveuEczQ1
        sZjxpaQGGZypbBdFcYolGCWNFizrz9x+zLyMooulwsgy0kBSuiMizK51W5cBuQ2r5ujajSyltZ6bP
        1K2jyMuA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6q8h-009uJp-Bq; Mon, 10 Jan 2022 08:34:51 +0000
Date:   Mon, 10 Jan 2022 00:34:51 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 15/28] gup: Add try_get_folio() and try_grab_folio()
Message-ID: <Ydvvq0aLuYwnpNdM@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-16-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110042406.499429-16-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
