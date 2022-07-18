Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7D35783C0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbiGRNdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbiGRNds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:33:48 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258D515715
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4cA63wMDAV5ZgwXYl8SjRPRo5qL0t+IFn/hc3lDLOz8=; b=fHKLlB4/Sdlv23rU6wJznHJPgR
        7aFH278XLJe5I8CAJBULOnh+LVIlGnCNj/Rohzq9d4ef27FCGEPFmCvJ/FHu/BfCpCX02KGato0+6
        x2nPWfjKEl61d7z7PBWAvmg6SrgSpFMZZ+nrgPCNvV/9tPVIBA6JRuSukpswfksY8GRHcigtC2owq
        OWnpH6aqEwm6mhIZSoE0Rtwu0IrZypOYtblL9cDEA9tNqykx8yBeS+NK5QMo2HX7bmxL0lAyMzNSw
        KL2qFBViIFsKdLHAYQ5YohNkBMZfpVanU0QYW8J2CSfQpfKYrkDSWtRM2ZSs9jWCkAfnz0lSc5C/M
        TSi1ky4w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDQsP-004pda-3m; Mon, 18 Jul 2022 13:33:33 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E9176980299; Mon, 18 Jul 2022 15:33:30 +0200 (CEST)
Date:   Mon, 18 Jul 2022 15:33:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wen Pu <puwen@hygon.cn>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: retbleed on hygon
Message-ID: <YtVhKtJkb23CcTtb@worktop.programming.kicks-ass.net>
References: <YtVHr1jDOtUXYF0Z@worktop.programming.kicks-ass.net>
 <584296cf-80d7-5c78-8bd0-6eb53a5bc914@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <584296cf-80d7-5c78-8bd0-6eb53a5bc914@hygon.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 01:03:41PM +0000, Wen Pu wrote:
> On 2022/7/18 19:44, Peter Zijlstra wrote:
> > Hi Pu Wen,
> > 
> > Now that retbleed is public could you please review the patches in
> > question and clarify the situation vs Hygon please? For development I've
> > assumed Hygon is basically Zen1 wrt this issue.
> 
> Hi Peter,
> 
> I'm sorry that there is something wrong with my email these days, so I
> haven't received the patches. Do you mean those with "[peterz: add
> hygon]" added by you? Thanks a lot for taking Hygon into account. I'll
> clarify it as soon as possible.

It's not your email, it was a hardware embargo issue so these patches
have never been mailed out before hitting Linus' tree :-/

Please double check the entire series, see the merge commit:

  ce114c866860 ("Merge tag 'x86_bugs_retbleed' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")

But in specific pay attention to commits:

  a149180fbcf336e97ce4eb2cdc13672727feb94d
  6b80b59b3555706508008f1f127b5412c89c7fd8
  3ebc170068885b6fc7bedda6c667bb2c4d533159
  d7caac991feeef1b871ee6988fd2c9725df09039
  26aae8ccbc1972233afd08fb3f368947c0314265

Basically everything that has HYGON in it. For that first commit, double
check with your hardware folks the mitigation actually works for Hygon
too. For the other commits validate it DTRT wrt HYGON. Please also send
a patch enabling or removing the spectral chicken for hygon.

