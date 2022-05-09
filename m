Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA9851F4DB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 08:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbiEIGt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 02:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbiEIGnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 02:43:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DC618FF28
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 23:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8LOVqa+y6GGCiHwFvUTHR1I5p3ezUAKURZPtee/I42M=; b=zMqogrOVGRanIshYO1sFXY6BZ4
        OO5QS91Ed30V3Vep5fk7twinCLipI0n+xXqmr4DsjD1olGXsai47X5Q7X8Y2wqgoJXVAi3Pk9DayH
        x7qotH/ScJGGlZ2n3OYBxdxte19hh4yqdAv/fhBKCS6sONNrHGwFncFnfgynUKqJ7iONojlAkTu/T
        RZ4IGKvQazwi536BR5HvLOXbVh41UWVHC58dOwwja+3lARIiSfdedquGl/dUAj43zk8/9PqK6rPPf
        4BA5d1D7TTUbmNfKfGD7BD68RvQtaOgb4vGdzfu+kN7jpnbRkH17NdtzW6iq5XXwzkmbf21e3bHRy
        C4yJMHzw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnx2t-00CjAr-Ku; Mon, 09 May 2022 06:39:03 +0000
Date:   Sun, 8 May 2022 23:39:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Oleksandr Tymoshenko <ovt@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-buf: add option text so it can be enabled by users
Message-ID: <Yni3BzoaaXMaikRd@infradead.org>
References: <20220505045001.363548-1-ovt@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505045001.363548-1-ovt@google.com>
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

On Thu, May 05, 2022 at 04:50:01AM +0000, Oleksandr Tymoshenko wrote:
> This reverts commit 3b32a592ea6e4 ("dma-buf: drop option text so users
> don't select it.") to allow users select DMA_SHARED_BUFFER option
> explicitly. This is required for out-of-tree modules that depend on
> dma-buf functionality, for instance drivers that rely on Google's Gasket
> framework.

Serious, you guys need to stop this crap.  Not offering totally useless
options is a massive improvement for Linux users.  Enabling code for out
of tree crap is not.  Please work with the Andorid ecosystem to make all
this out of tree junk go away instead of making users life painful due
to you not doing your basic work.
