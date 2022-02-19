Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521AA4BC6AF
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 08:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241652AbiBSH2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 02:28:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiBSH2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 02:28:18 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D481675605;
        Fri, 18 Feb 2022 23:27:59 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8062D68BEB; Sat, 19 Feb 2022 08:27:55 +0100 (CET)
Date:   Sat, 19 Feb 2022 08:27:55 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-mm@kvack.org,
        William Kucharski <william.kucharski@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Christoph Hellwig <hch@lst.de>, Hugh Dickins <hughd@google.com>
Subject: Re: linux-next: manual merge of the akpm-current tree with the
 folio tree
Message-ID: <20220219072755.GA27008@lst.de>
References: <20220215180043.23879691@canb.auug.org.au> <YgumpQrC+cuYe91H@casper.infradead.org> <20220216172109.72fd0a38@canb.auug.org.au> <Yg1hf0iHdKcjnq6l@casper.infradead.org> <20220217163026.5e48ccb1@canb.auug.org.au> <20220216215124.169c42a52e31575cedc4dea5@linux-foundation.org> <20220217173810.0addd3ed@canb.auug.org.au> <Yg6778VW5JX512GL@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yg6778VW5JX512GL@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 09:19:43PM +0000, Matthew Wilcox wrote:
> > > Let's try Matthew's idea - I'll get Hugh's and Christoph's series via
> > > linux-next and shall figure out the rest.
> > 
> > OK, but I am on vacation from tomorrow until Feb 28th, so I will assume
> > you will have it all ready for me by then.
> 
> I assume you mean that you'll do one last pull and release a
> next-20220218, rather than saying that the next release will be
> next-20220229?
> 
> I have pushed out f82e2137bc1e to infradead/for-next.  xfstests currently
> running.  It includes:

Not sure where this mail started, but I already suggested a git tree
in the cover letter of the ZONE_DEVICE series, so the overall approach
sounds fine to me.
