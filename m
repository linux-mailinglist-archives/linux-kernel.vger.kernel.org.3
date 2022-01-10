Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3357B489366
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240428AbiAJIbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240913AbiAJIad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:30:33 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFB6C06118A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 00:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=SzULBy9JtDK/lhy2Mfjzko0nUE
        V+p4581bO0Yex2SspFQYX2Tgx/grzbD2JWVvepf2adjVP8Xn4btk7N6S1D/Ogduz/iujGcKzcm40p
        8usTcgvSfu2NW2Ck+U/+v4Et0mCBRqu409TYwmyyvhW23p+gugFDLUHdgkpJRTQ2CpSn1LDxcZ6FT
        GOEnQ0j13PH8gqQL7+vPBJm6uEuMZHrDydOxy62nzx37KMd9TEzMQYkrNd8Xa0t2asvA7bFCqCLDp
        9I6iiXBT4mNphCLQt+GYdEa3aNMy8QiPdlaWx7RKHXxcJ97DCr+Jqiwiyr3908hn5cjjUi5RsOGYa
        PANgSnhQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6q4Q-009sYB-MH; Mon, 10 Jan 2022 08:30:26 +0000
Date:   Mon, 10 Jan 2022 00:30:26 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 07/28] gup: Remove an assumption of a contiguous memmap
Message-ID: <Ydvuot1jLs0SHgqz@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-8-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110042406.499429-8-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
