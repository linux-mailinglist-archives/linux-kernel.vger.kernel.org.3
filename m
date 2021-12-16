Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F4A476E94
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 11:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235755AbhLPKMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 05:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbhLPKMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 05:12:51 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58230C061574;
        Thu, 16 Dec 2021 02:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EIBXUtYOu0an3Nhkb+uz6c/cbOpjGo8AWJj9AI3J6Jo=; b=YgP9RYSD9DNckXKfHcgRHR+Qz4
        Fhp/OGAC8pZItqz8p/bmO71pkDDXzz/o/cSJAjtNVfDnBAtxQvZNS/9oPgXUKTT35do4llJaolDW7
        AQEG9V4Ze3UqBOfFBn+c3XFMNngEso3VkoTLFUKMFjUFcAZPkbUcBH4jgVSqcHOX37ONPfFJOY6QZ
        Qu/it3MITvWRZCInKMYX4g+vBj+2K2+eyjqhIDyw1QDDz7dIfnLQcmoQ0nC7MO//7VWkG42mf52iZ
        CMbgvApo3K2rxO3CWqiI28yxf+50fFSm4M1n+BjIGgOhGrAFIJHUIgWwRuDdXqwIuv9WtmV9g+SDH
        qaWXe9lQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxnkk-004lp1-Lv; Thu, 16 Dec 2021 10:12:46 +0000
Date:   Thu, 16 Dec 2021 02:12:46 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Miko Larsson <mikoxyzzz@gmail.com>
Cc:     minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
        axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] zram: zram_drv: add SPDX license identifiers
Message-ID: <YbsRHkJ6PGauazXk@infradead.org>
References: <20211215192128.108967-1-mikoxyzzz@gmail.com>
 <20211215192128.108967-2-mikoxyzzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215192128.108967-2-mikoxyzzz@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 08:21:27PM +0100, Miko Larsson wrote:
> zram_drv lacks an SPDX license identifier in both its source and in its
> header, so we should add a license identifiers based on the copyright
> info provided by the initial comment block.
> 
> Signed-off-by: Miko Larsson <mikoxyzzz@gmail.com>
> ---
>  drivers/block/zram/zram_drv.c | 2 ++
>  drivers/block/zram/zram_drv.h | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 25071126995b..464ef53adcbc 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1,3 +1,5 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause

Please drop the free form license boilerplate when adding SPDX tags.
