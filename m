Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589C747BC4B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 09:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbhLUI7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 03:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbhLUI7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 03:59:12 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7BBC061574;
        Tue, 21 Dec 2021 00:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wHV6GRR4eealQww1iJ3X6PIJAgvUqP6QFcBO/7H/dwA=; b=aHBb50Wa5isXtAMsqxF6OqcRS5
        Hmpz+X/6tFqcv5yPwUdnV67lcPCIHy6ZUAL4qO9GPiknrWSLdymdHViVIMvq965OMQoUvx4kF1FP7
        JN4AdLf7oxczerBipw7sjE5qOGAzOH1TkI0RZoDlAKGUlxGX1fojXlxHSw3Gl8OPTUYSODKG9gsAN
        m9pkcXigBpB1QNUYLahgPlN6XDovrC4kSTUZghc/6ZXbZWo3DBMiIEZQdXiBZE3O/J4kgfpAsKwEj
        W3ovp8tMzAW4z2q3yCrn0I17fOPNABRZ8nvhWE5sU3HFUFJ21lMh5FlaV5IBO7/mRwlsB7X6PXG0H
        DiM1rSdA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzazF-0060Dn-PJ; Tue, 21 Dec 2021 08:59:09 +0000
Date:   Tue, 21 Dec 2021 00:59:09 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Miko Larsson <mikoxyzzz@gmail.com>
Cc:     minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
        axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH v2 2/2] zram: zram_drv: replace 'strlcpy()'
Message-ID: <YcGXXQhB8YUMXI3O@infradead.org>
References: <20211217063224.3474-1-mikoxyzzz@gmail.com>
 <20211217063224.3474-3-mikoxyzzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217063224.3474-3-mikoxyzzz@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 07:32:24AM +0100, Miko Larsson wrote:
> 'strlcpy()' shouldn't be used, and should be replaced with safer
> alternatives. Cristoph Hellwig suggested [1] that 'kmemdup_nul()' should
> be used in two cases instead of 'strscpy()', and that a regular
> 'strcpy()' should be used in the third case. [2][3]

Not that strcpy isn't really safer, but if your plan is to get rid
of strlcpy I think it makes more sense there.

Reviewed-by: Christoph Hellwig <hch@lst.de>
