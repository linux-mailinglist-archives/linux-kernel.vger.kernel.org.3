Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0114AB642
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 09:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244021AbiBGIGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 03:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244003AbiBGH6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 02:58:38 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F673C043184
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 23:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=f8QO7dJbkRzQfJ7nmNvBxZECS8
        zadzGUEdeEbqV++w3fDPS+LTnUI4S8TieNLRqVUQYjCWoLW19oyv7DTLPJIXbh9mSNqJ+0xSBklzz
        w8wTE+zzZJPOs2iCuL8nAt0FijE1IE75DvUqVMD5su8ug5m3SWnjbns6jVy1HwN36FDAesnqRqGYx
        ZbOu59ETmm0BcdhVOZl797q5P+LixEt3NexQ4wuDw6bcjd4b+LZwJ+DmnM3wmf0eiXMYx/BKQKubr
        lpO4Ql/RD766rrzuKuWzJdC9p/osybrNsIyWilX/gzwPXtdh+ZZtNqqNFMvAOCSZm7rK89vytDyxW
        2Ke8E0kw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nGyux-009I0f-Qv; Mon, 07 Feb 2022 07:58:35 +0000
Date:   Sun, 6 Feb 2022 23:58:35 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 45/75] mm/rmap: Turn page_referenced() into
 folio_referenced()
Message-ID: <YgDRKw4vpIqC3+bi@infradead.org>
References: <20220204195852.1751729-1-willy@infradead.org>
 <20220204195852.1751729-46-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204195852.1751729-46-willy@infradead.org>
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

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
