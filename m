Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B864893C6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241858AbiAJIkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241486AbiAJIh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:37:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF85C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 00:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=uO4eyvq8cRx3GL2PgLz+VTdBWn
        Mvwamt5ypZN2QMmS4KnFEESGrXA8wkIMSSeFk4ISRmK2pewRR7mbXkx3C4LMTKxldFoVyatNlXgWn
        wQwQZWPrrBTit2DYialHaAAXA/4dUsS5YxYIRrjtAfP0ts/V/hNJzmBlJqeGAJ7JkaB5HDx8mJh26
        mokU81c/B0Tkau6qMdpo+69ZQo/pNhBezMcUCFoPROwcOTrDBr4WO7DP9fmOA0WPdHorvVM4BGo30
        FhMGxVsJvrTpEW+DMq88zagqa9oE4tJrlYVDfoWgtaBhu/ctBmjYTrcn5s0W+EIJrI9XPCfV0QTCs
        PfNwDVvA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6qBf-009wDa-Sg; Mon, 10 Jan 2022 08:37:55 +0000
Date:   Mon, 10 Jan 2022 00:37:55 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 22/28] gup: Convert gup_huge_pmd() to use a folio
Message-ID: <YdvwYyJP4q/V4GR/@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-23-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110042406.499429-23-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
