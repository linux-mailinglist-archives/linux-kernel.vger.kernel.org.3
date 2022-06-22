Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117EE554BA7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357475AbiFVNqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236962AbiFVNqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:46:42 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B582027B27
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 06:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=bdqRyaN94a2F/toYtRRwW4KgpaJhL3mLLBaZfLKAwvc=;
  b=IKyah0mNYTKZwqc7WA5l/lL6mD4r4+fRGjigyU7UmU6DawOTvXDMvN7S
   nOM9+dB1v2ARmmirSy9yo/oJZNjK2XiI/HJTe39qeJ7V8aoRlCPd8RjQa
   8/TATm2oxShA3vATMc9msSh8NKBEBu/yEcmJrvBNHD7Vu1yEerSKtgKyV
   0=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.92,212,1650924000"; 
   d="scan'208";a="17503033"
Received: from 71-51-165-43.chvl.centurylink.net (HELO hadrien.PK5001Z) ([71.51.165.43])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 15:46:37 +0200
Date:   Wed, 22 Jun 2022 09:46:13 -0400 (EDT)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To:     Bagas Sanjaya <bagasdotme@gmail.com>
cc:     Julia Lawall <julia.lawall@inria.fr>,
        Shahab Vahedi <Shahab.Vahedi@synopsys.com>,
        Jilin Yuan <yuanjilin@cdjrlc.com>,
        "vgupta@kernel.org" <vgupta@kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARC:mm:Fix syntax errors in comments
In-Reply-To: <1b34e0e5-23aa-96cd-c37f-1434884ff061@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2206220943200.6198@hadrien>
References: <20220622080423.41570-1-yuanjilin@cdjrlc.com> <YrLTCXLrr3HB39lv@debian.me> <4cef89c9-3b27-11e8-2971-66b93b847ede@synopsys.com> <alpine.DEB.2.22.394.2206220513590.2646@hadrien> <46e4b588-d35b-ec50-ad1a-8502c2903677@synopsys.com>
 <alpine.DEB.2.22.394.2206220535300.2646@hadrien> <1b34e0e5-23aa-96cd-c37f-1434884ff061@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 Jun 2022, Bagas Sanjaya wrote:

> On 6/22/22 16:38, Julia Lawall wrote:
> >>> So code that is fine will have typos forever?  Fixing typos in comments
> >>> doesn't break git blame for the following code.  And typos in comments
> >>> give a bad impression about the state of the code in general.
> >>
> >> Of course not! Documentation is as important as the code, if not even more.
> >> However, fixing typos to increase your commit counts to a reputable project
> >> is not fine either. For instance, many of these proposed fixes are targeting
> >> one single typo at a time. Couldn't they just be sent altogether!?!
> >
> > I have the impression that the person is just trying to figure out the
> > patch submission process.  For example, the subject lines are not
> > formatter in the standard way (I sent the person a private email about
> > that).  Perhaps just let him know about how you would rather have received
> > the patches.
>
> In recent times I had seen many typofix patches sent to LKML. You can see most
> of them by querying `s:"fix typo"` on lore.kernel.org. Some of these patches
> have been merged, though.
>
> What I say as starter thread is "ideal" scenario as described in
> Documentation/process/2.Process.rst; that is we prefer to see these minor
> fixes as part of real patches work (say refactoring), rather than just being
> trivial patches.
>
> But what most reviewers here missed is how these typos are found? I guess
> these can be from codespell or some other tools, or even manual review,
> then send the fixes en mass.
>
> Take a look at "fix typo in a comment" aka "delete redundant word" patches
> at [1], [2], [3]. and [4].
>
> [1]: https://lore.kernel.org/lkml/20220618132659.17100-1-wangxiang@cdjrlc.com/
> [2]: https://lore.kernel.org/lkml/20220618130349.11507-1-wangxiang@cdjrlc.com/
> [3]: https://lore.kernel.org/lkml/20220616163830.11366-1-wangxiang@cdjrlc.com/
> [4]: https://lore.kernel.org/lkml/20220606123419.29109-1-wangxiang@cdjrlc.com/
>
> IMHO, these patches should have been in a single, consolidated patch, since
> these strip duplicate (hence redundant) word (single logical change).

They go to different maintainers, so perhaps each one would prefer to get
their own patches?  There was a trivial tree, but it is apparently not
very active.

It would indeed be good to indicate how the problems were found.  That
could suggest whether the problem has been addressed comprehensively, or
whether just some random issues have been detected.

julia
