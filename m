Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1201A52405D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 00:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348854AbiEKWiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 18:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346776AbiEKWiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 18:38:24 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C016D194
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 15:38:19 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24BMbjUw028543
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 18:37:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1652308668; bh=a5WVc9xN2WEUAgzaf5a+6cwVxtHNBOl0YNd8b5JP2uM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=WSk0IpVUOe5Hu8Q+0eFmpHIbop210WCSWVgXcn6SMRlmuM2OjIm9VCpbjz1UodUJh
         An9FD80T5EU2z/Jso/tVQTBqCus2EQw7U2Qvuwt3Y2+pf4DCU7hcVx67KG/dEEihkd
         +iACUiH4C7xbmJICr7QyT9cgBXMJfux6Enl3tiOTpKs4mrvv32adze16p1uMxFre5B
         0txTrUds+frqaTjhDLFprF1BJrD/YMpi9LICqGJ3Xbsv3KshrUqnH4L9cJr3qc50Wb
         tlnZKXCsoo1oxRXGT0WM6+f1blmpb0PgFo3h4KZM1jNNx3cuteMz6SkSz59earmfrL
         s5brHw7vu7/4w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 1AC1E15C3F0C; Wed, 11 May 2022 18:37:45 -0400 (EDT)
Date:   Wed, 11 May 2022 18:37:45 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zhangfei Gao <zhangfei.gao@foxmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: Link: tag and links to submission and reports (was: Re: [GIT
 pull] core/urgent for v5.18-rc6)
Message-ID: <Ynw6ucTIyJgpr2AG@mit.edu>
References: <165201148069.536527.1960632033331546251.tglx@xen13>
 <CAHk-=wjMmSZzMJ3Xnskdg4+GGz=5p5p+GSYyFBTh0f-DgvdBWg@mail.gmail.com>
 <ff841fdc-4db7-7a3d-8caf-d0cddd0dfa31@leemhuis.info>
 <Ynt1z0eZ19eMqp8I@zn.tnic>
 <YnvbLx9FKgQwZJ/F@mit.edu>
 <CAHk-=wgUVHucyjp6M7qmn8b=aqwucfS4SQpqOCR5sKr16zoO5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgUVHucyjp6M7qmn8b=aqwucfS4SQpqOCR5sKr16zoO5g@mail.gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 08:55:34AM -0700, Linus Torvalds wrote:
> On Wed, May 11, 2022 at 8:50 AM Theodore Ts'o <tytso@mit.edu> wrote:
> >
> > I would argue that it should be the patch submitter's responsibility
> > to explicitly add a URL to the problem report.
> 
> I agree in the perfect case.
> 
> But in practice, we have a lot more patch submitters than we have
> maintainers, and not all "leaf developers" necessarily know how to do
> everything.
> 
> So the maintainer should probably expect to fix things up. Not always,
> but also not a "the developer should have done this, so I won't do it"

Sure... but *because* maintainers are significantly outnumbered by the
patch submitters, what we should document is that it is the
developer's responsibility to provide the link, just as it is the
developer's responsibility to at least *try* to write a clear commit
description.

> This isn't so different from the fact that not everybody writes
> English proficiently - people do hopefully end up fixing things up as
> they get passed onwards.

Maintainers can be the backstop, sure, but if we are trying to make
Maintainers scale well, developers should at least feel obligated to
**try** to lighten the load on maintainers to the limits of their
ability.

And I have a bit more sympathy over someone who doesn't speak English
as their first language, over someone who can't be bothered to look up
a bug report link or a Syzkaller ID.

I guess we could always NACK such a patch until they provide that
information, but if it's for a critical bug fix, that's not
necessarily a good alternative either.  I guess that's why the
Maintainers get paid the big bucks....

					- Ted
