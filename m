Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2A8591909
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 08:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235978AbiHMGbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 02:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiHMGbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 02:31:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E9B615B;
        Fri, 12 Aug 2022 23:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ib7FhGUcOkl40121Az7kItJ3LG0GIfLh/eK0bW3X/RU=; b=fdAeTKaZF8HEzUbYj0cD0DbIoD
        yiw9n+QrviwsfTaXtC4GEmtngAFjdHLxgbXTceuj+mSsXuzue3GDFpcxhfLiYVEiItnxKo8uIUXPU
        Nf6i/9Mhzw4o6clXHO8LX2b6bcHezQbjU20oX4q3WG6B7R/idS8H9/1Hj1QzPXW7zUB4V1+Dt8R0V
        rBJ8RD/BfPq3+D55uWZ2dUKCwMOGt/zONWKF+QHyMDmV16RbqXhqUj62NT6sxLlN9adauzfFVAc1K
        GAu7qN3z4i3I7Unm7Qvb3Bu9M1E9zy+Injr2v9urH5BvFpo30/MiTaj8L+/dAtqCTTl326NnnMsx6
        m8F2x6+Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oMkfm-006Fm7-13; Sat, 13 Aug 2022 06:31:02 +0000
Date:   Fri, 12 Aug 2022 23:31:01 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
Subject: Re: [PATCH 0/5] More fixups for raid5
Message-ID: <YvdFJRCZh8SqShhs@infradead.org>
References: <20220811171417.147697-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811171417.147697-1-logang@deltatee.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series looks fine to me, but all except for patch 1 really
is 6.1 material.
