Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2958C54F104
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 08:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380283AbiFQG2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 02:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiFQG17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 02:27:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37304E0A5;
        Thu, 16 Jun 2022 23:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sLPXcyRRmleh61O7Zeku+xyyWKO3/zEOGCYBg9pcfuo=; b=RGLvb0tbAp71EMnijOBRCXGWq/
        PBSmJYrYoue854tCDVOhiR3Sqf2GrAJ4LAPPsnyrnEwW2XI1SbzpUOBJN6Wl7PINcbdGIoq27AV7/
        KXVK4B+zGzLq1GBSSIuvhTpyneuj2hd1kb3r0e5S2v80NzWylq3sX8z5PuSnKhKITJ0MARi9nue6a
        L+nHo+g51L0v4/eofsTk4oh4IUVRgiyS+TddxZQa8rEXIZ/a2xWxf4h/8xRpBM7JjX05aGKC0etNm
        07V+zBml48P9I2+opEhcdU3PGXikW599AmvuUSZt3ZSqtfWvprXc/QmdDeNu1PVXrGQNZp6CKANjG
        7F06uE4Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o25SS-005jF0-1Y; Fri, 17 Jun 2022 06:27:52 +0000
Date:   Thu, 16 Jun 2022 23:27:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Donald Buczek <buczek@molgen.mpg.de>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>, Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 01/11] md/raid5-ppl: Fix argument order in
 bio_alloc_bioset()
Message-ID: <Yqwe6NXL9sedvx7v@infradead.org>
References: <20220608162756.144600-1-logang@deltatee.com>
 <20220608162756.144600-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608162756.144600-2-logang@deltatee.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While I think this whole series needs to get in of course, this one
seems even morge urgent.  Song, can you send it to Jens ASAP, please?
