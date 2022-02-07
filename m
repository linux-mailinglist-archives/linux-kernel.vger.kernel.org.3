Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748DB4AB62A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 09:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244610AbiBGHza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 02:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244173AbiBGHzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 02:55:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DA4C043181
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 23:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a+xHKoukJYQlH7UR60wSIIFocEZpefshZy5PJZjlYqc=; b=jRZdyUoQeyWpIFygCdN9m39gvF
        FVDXnVjioRcD+ITPc4KpPmmWldoVDebrqYkVusgJ6rV0fz73TXkbdUj2Yoqq1qGCW1swJmpKBmcXf
        FNPnDbyH8h52j4sGCVNJHP8TuBPX2Id2kaCgIQVqk4D8utlf9wBkqzBi1rqCvvOtzK3tG+qZPHL8x
        029Cet/TQAypM/f/kb2rPNKShCftTwtSZkmWOkv7OxBf7qR3BfuZBBeIJloIG7DfZ7JQ0QECe3KlT
        ufX1Mq8WI6iXLvDsPAO6AAJz3kzIy5CpHAipF9KWhiHTbi6eNtx3sgTyzIXHjEOJDYWQmlQYPwBKh
        84DnkYVQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nGyrk-009GCZ-71; Mon, 07 Feb 2022 07:55:16 +0000
Date:   Sun, 6 Feb 2022 23:55:16 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 39/75] mm: Add folio_pgoff()
Message-ID: <YgDQZNhP6D5Z1urz@infradead.org>
References: <20220204195852.1751729-1-willy@infradead.org>
 <20220204195852.1751729-40-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204195852.1751729-40-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 07:58:16PM +0000, Matthew Wilcox (Oracle) wrote:
> This is the folio equivalent of page_to_pgoff().

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
