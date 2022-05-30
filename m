Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7265A5374D8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbiE3GC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 02:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbiE3GCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 02:02:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825E91A050;
        Sun, 29 May 2022 23:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=3aT4+bciyq1O7l6HFuECMsmrkv
        WdnxOouUz+hV4FtPANHi/jEm83jUDCQXtHKc8BgXqYY1LH9EhVpGBcbEgzdjeHXMA5BPORkluuQzt
        bIBgUJAIbUy8vPrCxlWnZWWJXmGnZegwnk7T0UDQh4jXrHcoZ0Xh9rua0YX7F1aFYCAaqrGcAc6zU
        mGzI399QBV1fW2uVMZURBAr60JgVTBPjXV82qxfXrqAhpD7eR23OOKhTgD9V4CgP2en5QDQk6H2zT
        T2kGNLzZKQLM9cHxzL37wa9kOZuda0KIe7S6DiZMncSZzpEJI3FmmUHSuuAB2dTs9eTlOefnctRWY
        yyif2M6Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nvYTr-005Uhf-VJ; Mon, 30 May 2022 06:02:19 +0000
Date:   Sun, 29 May 2022 23:02:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Donald Buczek <buczek@molgen.mpg.de>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>, Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
Subject: Re: [PATCH v2 16/17] md: Ensure resync is reported after it starts
Message-ID: <YpRd606fMfrYTkw0@infradead.org>
References: <20220526163604.32736-1-logang@deltatee.com>
 <20220526163604.32736-17-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526163604.32736-17-logang@deltatee.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
