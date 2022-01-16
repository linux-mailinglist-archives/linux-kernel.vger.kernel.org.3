Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66AE448FC5F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 12:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbiAPLkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 06:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbiAPLkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 06:40:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505C0C061574
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 03:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GjbIpsVAOAmrEcfBkKRG08u4UT49UhuIMkBiZGN3iyo=; b=AdcoAob+I3+156KxlN8UthmDRc
        SIbA9gTPaIIRHiB2NjyCarsiZAR6uM3N+GV98nMN1dACeJG2jUzyPsR/RAlKM0E7oLiNdpwudykUM
        prWHvd81Vgq3SQwyxh7ph0mcB9HwVuJcWojFMOyv0aC/dAurcl6DN7FB/n8e7ezQtf412QM+cfoJ2
        mcwfg89+ZKPG4NpmWiceQ/yBJRoRcVQux2MsRhRX6d/tlLzaR5dgpiFrUMU0MbWwcZlx5xETeql8B
        vRrOTTJwIO2Hm5Njp8/Ns52yBiyiqYQ5eH3sUwTTQHbf4IIC9QCNFm7Teh16NyLZiIag3mTPLCVUr
        5Nam61Aw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n93tn-007ETI-Qb; Sun, 16 Jan 2022 11:40:39 +0000
Date:   Sun, 16 Jan 2022 11:40:39 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: fix missed initialization for
 folio_batch::percpu_pvec_drained
Message-ID: <YeQEN8oOuC+QOWN1@casper.infradead.org>
References: <20220116070227.6854-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220116070227.6854-1-changbin.du@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2022 at 03:02:27PM +0800, Changbin Du wrote:
> The folio_batch_init() forgets to initinize folio_batch::percpu_pvec_drained.

Already reported by Randy three days ago; sitting in linux-next since
then.  commit 6840f9094f2b.
