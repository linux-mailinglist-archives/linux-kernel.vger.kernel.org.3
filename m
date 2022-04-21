Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB87509759
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 08:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384715AbiDUGSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384706AbiDUGSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:18:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE25F63FD;
        Wed, 20 Apr 2022 23:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=f6EWH5rthO03Muo3WGbhpAjEtfkg5mSyUWFrq86zXiU=; b=EhhZCdOAM/m26P2nkSEqoKO3fW
        Hs+Ofyky1w4byqYnpjX6ODOqZWLOL/0ZSvAkEia2WzGhOLceEUxjvuzy/6MKtbVXMzZpbPeMbqeET
        rTSSuiGuQRE5z1cgwbc+Vh+OufYjKSrDC8sN1wcQN/UDoct6agxXHmU2kJMp7+hB4WvdfFHYpEbqk
        SxL3lyj0k+BSKuX6jXw1GLtI1aLnmDi7McLB83JN5ClfBnrY/f9LpSzMukt8G8QOAniYGrd4GUN68
        FH38P+TsFgEWJLyagWhgX9zH/S9DoGvqfPb37qomz96Z5Uyo+E2g43aUuTMw1IF+EFw9nVqgK3wBe
        JrrpbwFQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhQ66-00Begn-6M; Thu, 21 Apr 2022 06:15:22 +0000
Date:   Wed, 20 Apr 2022 23:15:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
Subject: Re: [PATCH v2 07/12] md/raid5: Move read_seqcount_begin() into
 make_stripe_request()
Message-ID: <YmD2epDyQRQ+lMO6@infradead.org>
References: <20220420195425.34911-1-logang@deltatee.com>
 <20220420195425.34911-8-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420195425.34911-8-logang@deltatee.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 01:54:20PM -0600, Logan Gunthorpe wrote:
> Now that prepare_to_wait() isn't in the way, move read_sequcount_begin()
> into make_stripe_request().
> 
> No functional changes intended.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
