Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6743C489402
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242164AbiAJIqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241953AbiAJIn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:43:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C628C034008;
        Mon, 10 Jan 2022 00:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Rz5UQILXn7pea3r9p2TDb1W76FhMtiR//aY0Ef16jhk=; b=WBUR2YcWT9KX0Z20PuMrEkF8vF
        T5vBucLynGXhR0GQDiq77GcEtg+B0FmIkKxqftEX+3cw6E//o8ho1W+ggWyeaP1v7o0lF7dbtOzv2
        jGEKRc8SqoynjAoCYky6VxRDD5hSY1OQuTmFSJ0DhTyLAUhHujf1r3u2jfEitIYqKvtndZ/5wnYtB
        XG7VW9KExHgPkEK8es34c8k0W58QGIUz5PhtkBWbtGt3z4gLaxmyzMGtjbTZKwkklpwQU/OBZHBMr
        wy68ycUlUQKTDwLyUPgHMAkPh0upwyNKSXqP5uE1U+TwKlS1AOFpdoZ6OwEDWDGNZ9dbTHaiPtL8H
        OODZCISQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6qHC-009zF7-N6; Mon, 10 Jan 2022 08:43:38 +0000
Date:   Mon, 10 Jan 2022 00:43:38 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     arnd@arndb.de, hch@infradead.org, akpm@linux-foundation.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 02/16] floppy: Remove usage of the deprecated
 "pci-dma-compat.h" API
Message-ID: <YdvxugKJMGmMShGG@infradead.org>
References: <cover.1641500561.git.christophe.jaillet@wanadoo.fr>
 <3b8dfc91908327b983a44adc18bd6a6f4c4b2d9f.1641500561.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b8dfc91908327b983a44adc18bd6a6f4c4b2d9f.1641500561.git.christophe.jaillet@wanadoo.fr>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
