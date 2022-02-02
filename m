Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859584A6C89
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 08:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241585AbiBBH4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 02:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiBBH4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 02:56:43 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F465C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 23:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=0E5LtGa+NaaWrqjYWYeEbXjOjS
        e0F2tdfp0du7fPw3XvOEx1zw/9tS6e2uBX313+DseCjcQN+aASPQIX/NhxmGemCk/bUt6mMIkpKZt
        BQSoMrv/ehSVNlIX07sclPrS051IXwU8hK2HLAgPEhjvo+LISZBFenHiZfC+7uhaPXIycZDPrVbR7
        ZGE+mkeco8R68blSGb14SPW2VFe/g+wKroHuwqIb856rlbuaIkJWqKWIS/Ba7liGmyef4znY9V9nl
        tvW40TKamotN+Jbq4GKrntpDriD/PUI7tfIbSjNJTY0Geoh5N5EB4qSLamTbSSMJZlSy0ekfchj4g
        hCNHa3Tg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFAVL-00EUOa-8j; Wed, 02 Feb 2022 07:56:39 +0000
Date:   Tue, 1 Feb 2022 23:56:39 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v3 1/1] mm/vmalloc: Move draining areas out of caller
 context
Message-ID: <Yfo5N8XWSr1n+F20@infradead.org>
References: <20220131144058.35608-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131144058.35608-1-urezki@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
