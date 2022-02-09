Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951BB4AF4D6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 16:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbiBIPLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 10:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235574AbiBIPLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 10:11:47 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80738C05CB88;
        Wed,  9 Feb 2022 07:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sGidQ70jxppwHimjiaAK9w5gUO8AIcFSX8ATxwQ5gjw=; b=h63TVA61xOdlt+ZkUCgWDN41SG
        mhja0Jl7mGe+5fDX4rV45c1b++WTwQw8NycQ1NTg81dWpPBw7zptAhoD2CoInrGq8NLnaH0qmwrDB
        HIn7i0efHOkNE6lR0O0xtyiDRs+jA6f1u8+3mSU4JtnamD9FKfQUP45LqPi9uJBTdie3hFh+WTMnA
        xluBAlDg5YANeyIvmNbaSIvJdF8nlTQrKwZT2TlFjelbcRdishBwxZVhhJxDKOwx+Q4jeU+2Nhf8H
        B9bebnrW0EajEjnL8ABAIYpfSlgYfKgQ3zZvaYXjuWCkt8zhP1JG9KiB62Yds26BLcLjJaauyDhNA
        3yHcP6dA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHod9-000WYS-46; Wed, 09 Feb 2022 15:11:39 +0000
Date:   Wed, 9 Feb 2022 07:11:39 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Barry Song <21cnbao@gmail.com>
Cc:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, Barry Song <song.bao.hua@hisilicon.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] dm io: Drop the obsolete and incorrect doc for dm_io()
Message-ID: <YgPZqyMVQGpShohN@infradead.org>
References: <20220207090620.21207-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207090620.21207-1-song.bao.hua@hisilicon.com>
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

On Mon, Feb 07, 2022 at 05:06:20PM +0800, Barry Song wrote:
> Commit 7eaceaccab5f ("block: remove per-queue plugging") dropped
> unplug_delay() and blk_unplug(). And the current code has no
> fundamental difference between sync_io() and async_io() except
> sync_io() uses sync_io_complete() as the notify.fn and explicitly
> calls wait_for_completion_io() to sync. The comment isn't valid
> any more.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
