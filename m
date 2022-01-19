Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D514941A9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 21:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiASUVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 15:21:34 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:53733 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357255AbiASUV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 15:21:28 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9CC405803E8;
        Wed, 19 Jan 2022 15:21:22 -0500 (EST)
Received: from imap46 ([10.202.2.96])
  by compute5.internal (MEProxy); Wed, 19 Jan 2022 15:21:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=liquorix.net; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=JKT/nV8EFLKtbGZNTCYtvqRmmyTL2Tg
        sz1tu10VSjNQ=; b=cxdUi+cbXCN+4iHGOELe5QBWZOviFSD8GJEG52aBsXsVaIu
        8OqmAhi5Dl4e5hDUIQ/qo3cDovmpunrbZqh9j8ocObhnaUCyYae5RuEfMwGEKA1a
        9+nWS8UwZyKEy+McYZBr78JuzucOxulj8KtwEBGa8sO31HgY7146ViVL1B5CXB9j
        DWrh7jSSkLCROJagKYmyKHJlt01lll4VRxFzB4oBTyeKF3r0NgN5u6gB4p5Kfb+K
        /lEPpBYo6jxZfQ/55+CKH9uu4WS7E8TtIUBSGUqPFdmq1Q6jNIJxkUtWhcwJ+lBa
        pRl+dwNtSJ+aS3Hif3umMzpu90dAjWUSwC3q2LQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=JKT/nV
        8EFLKtbGZNTCYtvqRmmyTL2Tgsz1tu10VSjNQ=; b=m2pZbC12MWeHg5y4W+U1wf
        A+eiOYdWpwCNn1IR5Zagic8Fh6gf4A5dVJhpexiDDOsGdYwVt+29u/5G6ivQmq5i
        DYvn+VLyeZzTFBDBLKx13M4hhiaVuploplxhDN4rcL+tiwoNnoGGTEglzX0k5j9M
        /Bwut0errFggj63mRR2tn8LNTpbYb7DgINX+2pm5xq72G6Or6lRBd7WsE+9vJajG
        2eALcaw6Lynz9sIZmYij6smHQx1ScHOOejLzH0ae/UVgs8R3GebM2EpYr2hU1Sra
        b/7YxD+R5p03hBh+PAyTjBf11uIEl0pt0PBBuI2iTrioWfBDEMM4bVd/723KPb+w
        ==
X-ME-Sender: <xms:wHLoYYN6twqNdJW-i0Q6-Nrmr9R_ftzj8qOCG6d4hJJLZjXtoIgSvA>
    <xme:wHLoYe_36jrc_rHr0EZ2h7NJBqL4F3VEbZt9ETsZdTBKq1w9h3CHPKvIF5Lp0oyf1
    A3KRHyqB9gGp5dAOek>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeigdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhtvghv
    vghnuceurghrrhgvthhtfdcuoehsthgvvhgvnheslhhiqhhuohhrihigrdhnvghtqeenuc
    ggtffrrghtthgvrhhnpeekleffieffheevveeuteduteffkeffvdejuefhuedugfduvdeh
    fedtueeiffelheenucffohhmrghinhepgigrnhhmohgurdhorhhgpdgthhhrohhmihhumh
    drohhrghdprghrtghhlhhinhhugidrohhrghdplhhiqhhuohhrihigrdhnvghtpdhgohho
    ghhlvghsohhurhgtvgdrtghomhdpvgguihdrfihorhhkshenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsthgvvhgvnheslhhiqhhuohhrihig
    rdhnvght
X-ME-Proxy: <xmx:wHLoYfSigPo_sVD8ByZMpCGy8Ue4xJhn1mLg81JMiVzekSDG8ukP8g>
    <xmx:wHLoYQsGAFEFkXhq4wsXvHQxuENDxMrcU-aRtFAeX5IpIHZ03caEiw>
    <xmx:wHLoYQc52Nrzp770RssFw5kwF5B8OeSkJ88YKCFYTgmbLLlmA_71OQ>
    <xmx:wnLoYUMSQxFVToPgasnePQ1J5uHPGV5xjL0w0JIWOM9dGIAsVK82qQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6A2321EE007B; Wed, 19 Jan 2022 15:21:20 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4585-ga9d9773056-fm-20220113.001-ga9d97730
Mime-Version: 1.0
Message-Id: <9203f79f-7910-4613-a593-aa6fda665b42@www.fastmail.com>
In-Reply-To: <Yd1Css8+jsspeZHh@google.com>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <YdSuSHa/Vjl6bPkg@google.com> <Yd1Css8+jsspeZHh@google.com>
Date:   Wed, 19 Jan 2022 14:19:30 -0600
From:   "Steven Barrett" <steven@liquorix.net>
To:     "Yu Zhao" <yuzhao@google.com>
Cc:     "Andi Kleen" <ak@linux.intel.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Hillf Danton" <hdanton@sina.com>, "Jens Axboe" <axboe@kernel.dk>,
        "Jesse Barnes" <jsbarnes@google.com>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Matthew Wilcox" <willy@infradead.org>,
        "Mel Gorman" <mgorman@suse.de>,
        "Michael Larabel" <Michael@michaellarabel.com>,
        "Michal Hocko" <mhocko@kernel.org>,
        "Rik van Riel" <riel@surriel.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Will Deacon" <will@kernel.org>,
        "Ying Huang" <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Subject: Re: [PATCH v6 0/9] Multigenerational LRU Framework
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022, at 2:41 AM, Yu Zhao wrote:
> On Tue, Jan 04, 2022 at 01:30:00PM -0700, Yu Zhao wrote:
> > On Tue, Jan 04, 2022 at 01:22:19PM -0700, Yu Zhao wrote:
> > > TLDR
> > > ====
> > > The current page reclaim is too expensive in terms of CPU usage and it
> > > often makes poor choices about what to evict. This patchset offers an
> > > alternative solution that is performant, versatile and
> > > straightforward.
> > 
> > <snipped>
> > 
> > > Summery
> > > =======
> > > The facts are:
> > > 1. The independent lab results and the real-world applications
> > >    indicate substantial improvements; there are no known regressions.
> > > 2. Thrashing prevention, working set estimation and proactive reclaim
> > >    work out of the box; there are no equivalent solutions.
> > > 3. There is a lot of new code; nobody has demonstrated smaller changes
> > >    with similar effects.
> > > 
> > > Our options, accordingly, are:
> > > 1. Given the amount of evidence, the reported improvements will likely
> > >    materialize for a wide range of workloads.
> > > 2. Gauging the interest from the past discussions [14][15][16], the
> > >    new features will likely be put to use for both personal computers
> > >    and data centers.
> > > 3. Based on Google's track record, the new code will likely be well
> > >    maintained in the long term. It'd be more difficult if not
> > >    impossible to achieve similar effects on top of the existing
> > >    design.
> > 
> > Hi Andrew, Linus,
> > 
> > Can you please take a look at this patchset and let me know if it's
> > 5.17 material?
> > 
> > My goal is to get it merged asap so that users can reap the benefits
> > and I can push the sequels. Please examine the data provided -- I
> > think the unprecedented coverage and the magnitude of the improvements
> > warrant a green light.
> 
> Downstream kernel maintainers who have been carrying MGLRU for more than
> 3 versions, can you please provide your Acked-by tags?
> 
> Having this patchset in the mainline will make your job easier :)
> 
>    Alexandre - the XanMod Kernel maintainer
>                https://xanmod.org
>    
>    Brian     - the Chrome OS kernel memory maintainer
>                https://www.chromium.org
>    
>    Jan       - the Arch Linux Zen kernel maintainer
>                https://archlinux.org
>    
>    Steven    - the Liquorix kernel maintainer
>                https://liquorix.net
>    
>    Suleiman  - the ARCVM (Android downstream) kernel memory maintainer
>                https://chromium.googlesource.com/chromiumos/third_party/kernel
> 
> Also my gratitude to those who have helped test MGLRU:
> 
>    Daniel - researcher at Michigan Tech
>             benchmarked memcached
>    
>    Holger - who has been testing/patching/contributing to various
>             subsystems since ~2008
>    
>    Shuang - researcher at University of Rochester
>             benchmarked fio and provided a report
>    
>    Sofia  - EDI https://www.edi.works
>             benchmarked the top eight memory hogs and provided reports
> 
> Can you please provide your Tested-by tags? This will ensure the credit
> for your contributions.
> 
> Thanks!

This feature has been a huge improvement for desktop linux, system
responsiveness has hit a new level high memory pressure.  Thanks Yu!

Acked-by: Steven Barrett <steven@liquorix.net>
