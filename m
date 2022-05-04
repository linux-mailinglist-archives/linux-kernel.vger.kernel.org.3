Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB86451AEC1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377882AbiEDUOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377871AbiEDUOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:14:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F221581A
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 13:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=U8yI+e72U+8IbMMaF+upVD1ctMvqreSBUelKePaelDc=; b=pxxn4rduFxwBSkO5iHAGuqQQFb
        cIQfI+hxQjQxHfSD+Ar2kf7G3Llqdf5w0H+wzUqPrHrEeBK+dBRZnUK3L/5grlYSg6XhQhf2TmnMQ
        z6ci7P33C7XKlJHexB1r8GN806LnAlMd3PWa+pdlyVR7in94NGNLd1rFaPgJCCeADYj2VW5z4pyIr
        JAzGNGcdMdE5JYJgWiwBZlLSG9ser+N+poM/iOVsr8E3nBYHilduP1mDqvrLDPgk8YNjMo5LYEQOp
        USdIcq3WQFcC+74oxOZC+xch0345cgCOi8zAW2zgGC9EjCYhHoPnrDQKAPg3Jj13xyoPte30r0gZ4
        DA8DnAzw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmLKI-00GuXN-1B; Wed, 04 May 2022 20:10:22 +0000
Date:   Wed, 4 May 2022 21:10:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH for mm-unstable 0/3] Fix build errors due to
 folio_test_large() misuse
Message-ID: <YnLdrqzkvzqMPD1U@casper.infradead.org>
References: <20220504200758.314478-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504200758.314478-1-sj@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 08:07:55PM +0000, SeongJae Park wrote:
> Several commits on 'mm-unstable' replaces 'PageTransHuge()' with
> 'folio_test_large()' instead of 'folio_test_transhuge()'.  As a result,
> several build errors occur when 'CONFIG_TRANSPARENT_HUGEPAGE' is unset.

I sent an entire replacement patch series mere minutes ago which I think
fixes everything you mention here.  Please check?

https://lore.kernel.org/linux-mm/20220504182857.4013401-1-willy@infradead.org/T/#t
