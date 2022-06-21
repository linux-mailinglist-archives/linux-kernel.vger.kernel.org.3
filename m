Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2DD85539C3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 20:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351718AbiFUSxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 14:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351521AbiFUSxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 14:53:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916A412ACD;
        Tue, 21 Jun 2022 11:53:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 375D86170D;
        Tue, 21 Jun 2022 18:53:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF49C3411C;
        Tue, 21 Jun 2022 18:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655837620;
        bh=+khD1q8RhpxPqrvYCBaL5xyl6Uw1nYGFYmqhJyFMJ+k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=OypHFChoCPYE3niL5+cCNkjXQBktRM8PcAF9WPGY1TBZGHj/zHW5srbRdaWcBojKQ
         Xqp2T9EVzX89bujTo1tZWbGddZyF3aAPrMqXDqYU/g+ONjEb3b+AVyVbLkW1ltyQS7
         HZwQaCA8NLhe6F8GpHdX0sAv0gtt9QT+OO20/oJYqJvAA/PdLef/Nn73lGU9+4Mt5L
         xuRU1CHD7vjxFKl0Zp3WF1fm251p8BGrVEICb8/oeujViCeSLF+ydG/N0AA/z9BSJ6
         /rG4Ve8or+iK4kzZ5LY2pLPv/nA//c3eTrg5RSZgpr4H5UZ+K98HqLZVpq8Zal1cNE
         EhkqpdvllX9jQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2D93D5C09AF; Tue, 21 Jun 2022 11:53:40 -0700 (PDT)
Date:   Tue, 21 Jun 2022 11:53:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH RESEND v1 0/2] docs/memory-barriers.txt: Fix confusing
 name of 'data dependency barrier'
Message-ID: <20220621185340.GK1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <a84435e4-5342-f886-4388-e4c5909298a7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a84435e4-5342-f886-4388-e4c5909298a7@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 05:16:04PM +0900, Akira Yokosawa wrote:
> I used Paul's old email address in RFC and v1.  My bad.
> Sorry for making noise to other recipients.
> 
> Paul, please see RFC [1] for the discussion so far.
> There was no response to v1.

Thank you for resending, Akira!  I have queued it, and also support
the general consensus for creating a "historical" section.

							Thanx, Paul

> -----
> 
> Hi all,
> 
> This is a revised patch set of RFC [1].
> 
> Discussion so far is about possible follow-up improvements,
> so I hereby submit this set as a "v1".
> 
> Changes since RFC [1]:
> 
>   - Rename title of Patch 1/2.
>   - Remove note on the rename of section "DATA DEPENDENCY BARRIER".
>     Rational in the changelog should suffice.
>   - Wordsmith by self review.
>   - Add Patch 2/2 (fixup of long lines).
> 
> [1]: https://lore.kernel.org/linux-doc/cc2c7885-ac75-24f3-e18a-e77f97c91b4c@gmail.com/ # RFC
> 
> For your convenience, diff of "v1 1/2" vs RFC is appended below.
> 
> Following is the explanation of background in RFC (with typo fixes):
> -------------------------------------------------------------------
> This is a response to Michael's report back in last November [2].
> 
> [2]: "data dependency naming inconsistency":
>      https://lore.kernel.org/r/20211011064233-mutt-send-email-mst@kernel.org/
> 
> In the thread, I suggested removing all the explanations of "data dependency
> barriers", which Paul thought was reasonable.
> 
> However, such removal would require involved rewrites in the infamously
> hard-to-grasp document, which is beyond my capability.
> I have become more inclined to just substitute "data dependency barrier"
> with "address-dependency barrier" considering that READ_ONCE() still has
> an implicit address-dependency barrier.
> 
> This patch set is the result of such an attempt.
> 
> Note: I made a mistake in the thread above. Kernel APIs for explicit data
> dependency barriers were removed in v5.9.
> I was confused the removal with the addition of the barrier to Alpha's
> READ_ONCE() in v4.15.
> 
> diff of "v1 1/2" vs RFC
> ------------------------------------------------------------------
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index 306afa1f9347..bdbea3cc66a3 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -391,8 +391,8 @@ Memory barriers come in four basic varieties:
>       memory system as time progresses.  All stores _before_ a write barrier
>       will occur _before_ all the stores after the write barrier.
>  
> -     [!] Note that write barriers should normally be paired with read- or address-
> -     dependency barriers; see the "SMP barrier pairing" subsection.
> +     [!] Note that write barriers should normally be paired with read or
> +     address-dependency barriers; see the "SMP barrier pairing" subsection.
>  
>  
>   (2) Address-dependency barriers (historical).
> @@ -561,17 +561,14 @@ As of v4.15 of the Linux kernel, an smp_mb() was added to READ_ONCE() for
>  DEC Alpha, which means that about the only people who need to pay attention
>  to this section are those working on DEC Alpha architecture-specific code
>  and those working on READ_ONCE() itself.  For those who need it, and for
> -those who are interested in the history, here is the story of address-
> -dependency barriers.
> +those who are interested in the history, here is the story of
> +address-dependency barriers.
>  
> -[!] The title of this section was renamed from "DATA DEPENDENCY BARRIERS"
> -to prevent developer confusion as "data dependencies" usually refers to
> -load-to-store data dependencies.
> -While address dependencies are observed in both load-to-load and load-to-
> -store relations, address-dependency barriers concern only load-to-load
> -situations.
> +[!] While address dependencies are observed in both load-to-load and
> +load-to-store relations, address-dependency barriers are not necessary
> +for load-to-store situations.
>  
> -The usage requirements of address-dependency barriers are a little subtle, and
> +The requirement of address-dependency barriers is a little subtle, and
>  it's not always obvious that they're needed.  To illustrate, consider the
>  following sequence of events:
>  
> @@ -602,8 +599,8 @@ While this may seem like a failure of coherency or causality maintenance, it
>  isn't, and this behaviour can be observed on certain real CPUs (such as the DEC
>  Alpha).
>  
> -To deal with this, an implicit address-dependency barrier of READ_ONCE()
> -or better must be inserted between the address load and the data load:
> +To deal with this, READ_ONCE() provides an implicit address-dependency
> +barrier since kernel release v4.15:
>  
>  	CPU 1		      CPU 2
>  	===============	      ===============
> @@ -659,11 +656,9 @@ can be used to record rare error conditions and the like, and the CPUs'
>  naturally occurring ordering prevents such records from being lost.
>  
>  
> -Note well that the ordering provided by an address or a data dependency is local to
> +Note well that the ordering provided by an address dependency is local to
>  the CPU containing it.  See the section on "Multicopy atomicity" for
>  more information.
>  
> ---------------------------------------------------------------------
> 
>         Thanks, Akira
> --
> Akira Yokosawa (2):
>   docs/memory-barriers.txt: Fix confusing name of 'data dependency
>     barrier'
>   docs/memory-barriers.txt: Fixup long lines
> 
>  Documentation/memory-barriers.txt | 177 ++++++++++++++++--------------
>  1 file changed, 95 insertions(+), 82 deletions(-)
> 
> 
> base-commit: c09ca10d879bae4a8df842dbe8d6bd8b87830633
> -- 
> 2.25.1
> 
