Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B3352FC17
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 13:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345535AbiEULiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 07:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349464AbiEULiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 07:38:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC8B50473;
        Sat, 21 May 2022 04:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=tBG+QAHfylo0Vezf2SxMj6xAkG
        s85+FEczMn8zbrHbIv+ZNs5vCRTdQbKiPv/ebIHRWcA0iR4FMCFUZeBeBwkDmTnfLabCVBdxQbkBX
        vpYFjoS2b74qw0h2vRjO1YJpe71LRwl3qqswV9+jDZmo+01njk4Ddj0vx0wzcHGj3gYAhfqOO1Gq/
        vN5XlUTChKVJ6BoAoBmD33J5ClMuJliJ8lssKHQ2fcq2bMpvRr4Oy0MhZE4Vjck9/IE1J9wvZeBxT
        lC3+XYzLVJ7OR3YyuAyVKWQGfy1XIb9fd4uvR93ocQ+e2toJiiWPU548FhFd7L/xARhlNdNd1y3+W
        1gmN3/GA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nsNQu-00GPG9-Ic; Sat, 21 May 2022 11:38:08 +0000
Date:   Sat, 21 May 2022 04:38:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>, Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
Subject: Re: [PATCH v1 04/15] md/raid5-cache: Refactor
 r5l_flush_stripe_to_raid() to take a struct r5conf
Message-ID: <YojPIDmU8zfkxYuS@infradead.org>
References: <20220519191311.17119-1-logang@deltatee.com>
 <20220519191311.17119-5-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519191311.17119-5-logang@deltatee.com>
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
