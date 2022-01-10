Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728734893C5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241494AbiAJIkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241467AbiAJIho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:37:44 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5892CC02982E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 00:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vJ+WHS0Dn2kbdoalK1G05Ydbbm+G0SrDE9/ZBv4L5NU=; b=sYdByOdRyFu0S3dPNtia7vDrkQ
        YC/fNMm1VISjeoCj7qsE/6TzHxDbOcJP1p6bwJxC3kPQ4/44taWFeBR9wVUa318yLwNDo/rWuEzcw
        29klsLx0Vv2bmflOsd1DQEltjlTZHNzdNVgxwJgo+Fq066spif2t7AdbqBTeD1xI0jTZzOKkrmTr1
        0bHq1YiEJgVSsCTasJF0wxvYYdwazpx3rE4ZpvagDD1N1wrgs8tmuZhNC8HBWJHybJR4nhIAxNH/j
        /cDgOwmcQk8h31qvBCP8NSslyZ2G/tBDYuZF+U4bkXFdIsY/HO9XARzzTnLYFDXFELnQcIU2pvMTn
        i6QrR0ow==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6qBQ-009w4S-RZ; Mon, 10 Jan 2022 08:37:40 +0000
Date:   Mon, 10 Jan 2022 00:37:40 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 21/28] gup: Convert gup_hugepte() to use a folio
Message-ID: <YdvwVHEgVi7F/yps@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-22-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110042406.499429-22-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 04:23:59AM +0000, Matthew Wilcox (Oracle) wrote:
> There should be little to no effect from this patch; just removing
> uses of some old APIs.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
