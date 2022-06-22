Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D47555488D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351170AbiFVJjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347856AbiFVJjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:39:00 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B5739822
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GM3qPiNw6bss3JgeWzvrXSm0lamQjaygnBKjic/k7cs=;
  b=YXDgJ29Zl4n/PQJKwPgUA+m5Jy08wqd4U86ipoY05Mcmq29ZIzQNgo7j
   FrvTKGYvzWyqcaew4qbWJE4zGYoQSXqhoQVGLQHlU7BYT/mfvjwp0ZaPW
   W/jC1/2Z4X5vltnYt5k77TJZ9MjWBt7QxiGbsUT+ExkLP2qz1AdJqebsV
   Q=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.92,212,1650924000"; 
   d="scan'208";a="42344526"
Received: from 71-51-165-43.chvl.centurylink.net (HELO hadrien) ([71.51.165.43])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 11:38:55 +0200
Date:   Wed, 22 Jun 2022 05:38:52 -0400 (EDT)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To:     Shahab Vahedi <Shahab.Vahedi@synopsys.com>
cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jilin Yuan <yuanjilin@cdjrlc.com>,
        "vgupta@kernel.org" <vgupta@kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARC:mm:Fix syntax errors in comments
In-Reply-To: <46e4b588-d35b-ec50-ad1a-8502c2903677@synopsys.com>
Message-ID: <alpine.DEB.2.22.394.2206220535300.2646@hadrien>
References: <20220622080423.41570-1-yuanjilin@cdjrlc.com> <YrLTCXLrr3HB39lv@debian.me> <4cef89c9-3b27-11e8-2971-66b93b847ede@synopsys.com> <alpine.DEB.2.22.394.2206220513590.2646@hadrien> <46e4b588-d35b-ec50-ad1a-8502c2903677@synopsys.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 Jun 2022, Shahab Vahedi wrote:

> On 6/22/22 11:16, Julia Lawall wrote:
> >
> >
> > On Wed, 22 Jun 2022, Shahab Vahedi wrote:
> >
> >> On 6/22/22 10:30, Bagas Sanjaya wrote:
> >>
> >>> I think that this kind of cleanup patches (typofixes) are best done
> >>> as part of **actual** work on the code in question (for example
> >>> refactoring or fixing build errors).
> >>
> >> Amen!
> >
> > So code that is fine will have typos forever?  Fixing typos in comments
> > doesn't break git blame for the following code.  And typos in comments
> > give a bad impression about the state of the code in general.
>
> Of course not! Documentation is as important as the code, if not even more.
> However, fixing typos to increase your commit counts to a reputable project
> is not fine either. For instance, many of these proposed fixes are targeting
> one single typo at a time. Couldn't they just be sent altogether!?!

I have the impression that the person is just trying to figure out the
patch submission process.  For example, the subject lines are not
formatter in the standard way (I sent the person a private email about
that).  Perhaps just let him know about how you would rather have received
the patches.

julia
