Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5B7489E7C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 18:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238437AbiAJRgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 12:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238197AbiAJRgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 12:36:33 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A13FC06173F;
        Mon, 10 Jan 2022 09:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Cg6PTGtJDlAWiPThvj1wyyJNeW5hKDAPzKITicALVW8=; b=C4oP80EqKgM2rhrX+cvp+y2fgY
        kqbIl79WkupMAOt9fAfN3aSo4HzcvzfRWHXZWd3TVvkycbbSuusQtl859H0/oE8lbtb9dNHL8vFrd
        Rt4Pehqpr7z52juZub+IcTkKsf98o3yVcEkVsGAziu5ZgDvDnp9sQ3lfnqdw+BSKUtq9rT7sTw3VR
        wS5bmujkO+3YgANbsijQvDlRZGUF1R3M2nqsY6JW1v/96RHbZrhANLF37HhQxE/bWH/2HLE/8QjP2
        7si4nX2wnlP+YM6BHEmE6VE6GAovGdc4ghTdaJ6lnyC0WOpGxMnLGFouEtgN2KmpCS5xPz5CTNqlM
        Xzc+Y+pg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6yap-00CapK-PY; Mon, 10 Jan 2022 17:36:27 +0000
Date:   Mon, 10 Jan 2022 09:36:27 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Wang Jianchao <jianchao.wan9@gmail.com>
Cc:     axboe@kernel.dk, jbacik@fb.com, tj@kernel.org, bvanassche@acm.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/13] blk: make blk-rq-qos policies pluggable and modular
Message-ID: <Ydxum/2iwp6hDw68@infradead.org>
References: <20220110091046.17010-1-jianchao.wan9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110091046.17010-1-jianchao.wan9@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 05:10:33PM +0800, Wang Jianchao wrote:
> This patchset attempts to make blk-rq-qos framework pluggable and modular.

I really don't think making them policies modular is a good thing, and
your new exports/APIs are a very good sign for why it is not a good
idea.
