Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E034893F6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242593AbiAJIpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241179AbiAJImw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:42:52 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A29DC06175B
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 00:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=j4d24K16MTk98iT61N4DmYNvVn
        4RtyfeDN6xaSETeleVowld+VcFKoXy0Kc9+ugrjI3HQG7d216HvM96WTZ7Jb2ZSuzBduky2jm0KaV
        Qz3grgVNkBOxu3OjYa0W6bdGGRZHKcYfwYcAKlUPb/r4WWIdyqX7Cv+23hF6itn3+tx4QjhBsIWJE
        zNUqdNC6e02WP6qEF5hgqBbPwbWfeKZ1gZzEcCKcSXZGRjoJLEqD9T+VU4uY8YDK8ieDZ5L7Fd+vt
        2Jy+uDQ3NKjHqE9g+Gva5UGkbHhS1j0Gw51BEbnmhJRDMA89Odxy7K2Aqj8LVnDwB9PGvAw11bcDA
        Xle32JNQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6qGN-009ypY-O0; Mon, 10 Jan 2022 08:42:47 +0000
Date:   Mon, 10 Jan 2022 00:42:47 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 28/28] gup: Convert check_and_migrate_movable_pages()
 to use a folio
Message-ID: <Ydvxh3YKudHLNcMN@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-29-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110042406.499429-29-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
