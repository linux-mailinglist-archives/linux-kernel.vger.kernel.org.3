Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D6953F143
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbiFFU7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiFFU7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:59:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97156E8F5
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:48:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56E0EB81895
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 20:48:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1210C34119;
        Mon,  6 Jun 2022 20:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654548503;
        bh=359s1KKgDcNMt55qxeHN3UBGIN7R3YjbiDQJ1Hi2/fw=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=LqDJK0/0onBgmRTXrQ8JwBhhvdfq7SFQuasoF4ZqCtMal2qczaZiFwpUVsOXTtEPG
         ztivCWS2pA2nCLIoOLwj3PcfSeGcngKEHxRnQc6ORh4Rx36dXeXk3dRLrcqvEVtBgz
         tImeQD3JdTi0Yk9CSnKhHLLoBI+iiFY0JYvAWN3sO23kQ5VGdtjYRjqG34WguJV5W4
         sTaKUZu+X8UXZ4m6HimaDLRjL1k439WIYtBwKiHr5oxEnVO4GtemA5xIfQtkdvi34U
         h01rvmLdnJFHuBnWC+5Hi1Vyxil5pJSLGam/5zn8vxxd62OceaseXYV5XGTFFmTUZx
         K3p6H4OIDZ0Qg==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 8E1B527C005B;
        Mon,  6 Jun 2022 16:48:21 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Mon, 06 Jun 2022 16:48:21 -0400
X-ME-Sender: <xms:FWieYl3ouK46008q9fze6jbKFCNNbL91PWwRA33jrRI_AobD0WGW9A>
    <xme:FWieYsGZMKmFmOvc8W9TM3KUPFoV4LSmO_MFkiwE09CTGFGOMDk2rkYJJZtsHj-04
    WDs5Ak0CWZ0NQ92h0M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddtfedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvdfhuedvtdfhudffhfekkefftefghfeltdelgeffteehueegjeff
    udehgfetiefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:FWieYl41IcegCKF5cBV5dbR_EW9zwBtUDg-FZDJjTkHVv1nadnfVqA>
    <xmx:FWieYi2ZoZrGUx0uzZmBEoee-XTaMhGoZyuSKu_jKljLGgB67JgTKg>
    <xmx:FWieYoFqLH6YdLgblCE92dF_CjLBrv59iW1R3mBpl7inTEXUDv_9CQ>
    <xmx:FWieYtNS0jjRbqzwKcU4DVAr1_7jKxsK2atha-fXfwT1--vIVZTLHQ>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EEE8531A005D; Mon,  6 Jun 2022 16:48:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-592-g7095c13f5a-fm-20220603.004-g7095c13f
Mime-Version: 1.0
Message-Id: <234e853b-0c35-45de-b40d-2058976e49e0@www.fastmail.com>
In-Reply-To: <20220606180123.2485171-1-namit@vmware.com>
References: <20220606180123.2485171-1-namit@vmware.com>
Date:   Mon, 06 Jun 2022 13:48:00 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Nadav Amit" <nadav.amit@gmail.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>
Cc:     "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Nadav Amit" <namit@vmware.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Ingo Molnar" <mingo@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Subject: Re: [PATCH v2] x86/mm/tlb: avoid reading mm_tlb_gen when possible
Content-Type: text/plain
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 6, 2022, at 11:01 AM, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
>
> On extreme TLB shootdown storms, the mm's tlb_gen cacheline is highly
> contended and reading it should (arguably) be avoided as much as
> possible.
>
> Currently, flush_tlb_func() reads the mm's tlb_gen unconditionally,
> even when it is not necessary (e.g., the mm was already switched).
> This is wasteful.
>
> Moreover, one of the existing optimizations is to read mm's tlb_gen to
> see if there are additional in-flight TLB invalidations and flush the
> entire TLB in such a case. However, if the request's tlb_gen was already
> flushed, the benefit of checking the mm's tlb_gen is likely to be offset
> by the overhead of the check itself.
>
> Running will-it-scale with tlb_flush1_threads show a considerable
> benefit on 56-core Skylake (up to +24%):

Acked-by: Andy Lutomirski <luto@kernel.org>

But...

I'm suspicious that the analysis is missing something.  Under this kind of workload, there are a whole bunch of flushes being initiated, presumably in parallel.  Each flush does an RMW on mm_tlb_gen (which will make the cacheline exclusive on the initiating CPU).  And each flush sends out an IPI, and the IPI handler reads mm_tlb_gen (which makes the cacheline shared) when it updates the local tlb_gen.  So you're doing (at least!) an E->S and S->E transition per flush.  Your patch doesn't change this.

But your patch does add a whole new case in which the IPI handler simply doesn't flush!  I think it takes either quite a bit of racing or a well-timed context switch to hit that case, but, if you hit it, then you skip a flush and you skip the read of mm_tlb_gen.

Have you tested what happens if you do something like your patch but you also make the mm_tlb_gen read unconditional?  I'm curious if there's more to the story than you're seeing.

You could also contemplate a somewhat evil hack in which you don't read mm_tlb_gen even if you *do* flush and instead use f->new_tlb_gen.  That would potentially do a bit of extra flushing but would avoid the flush path causing the E->S transition.  (Which may be of dubious value for real workloads, since I don't think there's a credible way to avoid having context switches read mm_tlb_gen.)

--Andy
