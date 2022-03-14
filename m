Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10034D8E1E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 21:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238107AbiCNU3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 16:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbiCNU3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 16:29:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BB3E0D0;
        Mon, 14 Mar 2022 13:28:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F501612AC;
        Mon, 14 Mar 2022 20:28:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92166C340E9;
        Mon, 14 Mar 2022 20:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647289690;
        bh=uY+4uuaxmidExaBH385o2SIVrRyuxahyDyuPncAHc+4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Deb6JE4PkJCAw+uYQATYflcLEy0AFrSCmIFV5Ih/CI4cjAcD62wlEbOLOP9NpQoMd
         Xk+QCVd6tFVXX7ZUxE73TGMBmJqkFB24yeblSrs6B/QEHEw/OWlIXYLFTIp+1qWV2N
         /kXlUbUcpuRYh1eECxbMWIPfuqBk4KAgeLdJMcLpL1NjBwHIimUd+JrnSN9yD4irXO
         LNakmS1hNvFdR6ZI74H4hmJsznsyT6VOxJR7SlYKhetnxxE3G73TlpK7ROlth53tpL
         CanpDpNjMyqyg6TM1glOksyT9sfUEtVhW8n7MDfJvOcB3b8jagoQ9nM4dOhpBpfwnD
         +g3BXL0PC6IXQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 436F65C4162; Mon, 14 Mar 2022 13:28:10 -0700 (PDT)
Date:   Mon, 14 Mar 2022 13:28:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        rcu <rcu@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Subject: Re: [GIT PULL] RCU changes for v5.18
Message-ID: <20220314202810.GX4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220314032823.GA2593360@paulmck-ThinkPad-P17-Gen-1>
 <20220314154857.GA2637810@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wjEVLfoypyZHwdLjh3vX_BSJO1JJBjha2XgcghSX=sdgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjEVLfoypyZHwdLjh3vX_BSJO1JJBjha2XgcghSX=sdgw@mail.gmail.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 01:17:13PM -0700, Linus Torvalds wrote:
> On Mon, Mar 14, 2022 at 8:49 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > OK, I was apparently unable to distinguish v5.17-rc8 from v5.18 yesterday
> > evening.  :-/
> >
> > I will resent both pull requests next week, and please accept my apologies
> > for the bother.
> 
> "resent" and "resend" are very different ;)

;-) ;-) ;-)

> Anyway, no bother - I just assumed this meant that you sent your pull
> request for 5.18 early. Which is very much ok, and no bother at all.
> In fact, if things are ready, early pull requests are generally good
> things.
> 
> But since you resent them, I'll just archive this email (and the LKMM
> one), and am now expecting a new set of pull requests that you don't
> hate that much later..

Glad I could provide a laugh and good to know on the possibility of
sending them early.  Monday mornings!!!  ;-)

							Thanx, Paul
