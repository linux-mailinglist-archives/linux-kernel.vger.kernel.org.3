Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6A0550A46
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 13:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbiFSLdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 07:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235421AbiFSLc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 07:32:59 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C0D6436
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 04:32:58 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id CFF535C0053;
        Sun, 19 Jun 2022 07:32:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 19 Jun 2022 07:32:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1655638375; x=1655724775; bh=yN3e7rKx5D
        9uS9dPcZntcA1m4Ds21bYlPqY3EuFSszs=; b=ql3H+SBUPccgSTrGx0Uasw0CgD
        V/jmSipLZUYK9SCyLH3q9C0qKF+R0smjp0FbEIg8GR/DUHzPTZuKJSZ8j+/643QD
        YW0lNIhreCVFnFqj3y66Iq2quSRKhPwpnGyrzNk1RdQiaeLCJPDRKW9yhLRPddd9
        856ZljDWvbIZ+yZhhS2dw7ytYCJaNT9DaZQ7aSpkgcZ41jEzvcrTm7sU1LwUAkLI
        5r/B/e/9aAGyVgawRUnArdBGkwZb8+5MTejduiPFFlcEaR1W7M1ejnmM1RRrTA0J
        4GH0IkEcileb1n9M1dfbw+Cj3zyAi7WeFrxrUR7VILOxuECoDVXhMO2v9PcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1655638375; x=1655724775; bh=yN3e7rKx5D9uS9dPcZntcA1m4Ds2
        1bYlPqY3EuFSszs=; b=IYWqvkOhwN5gX/zOo/zVPqwQw2mch9LTGm0tXGIBAG28
        FE/Z9b4nV7yDYs7xnvJsa2SWJMSV3Hq8xSBEM9dmO8lYIxt1vJKJbkZxSgB+pWG5
        u+qmLx71aRg8jZpCFcQqq3T+nE/XMnHjVXr81r0iHDYPOPEi5YVKLu79rfR5UbEu
        co21eM0CKDAHNEQl6VyuliX+XXGtu37HN1sSxuMKfJD9xaeWY84t7xZ2mm6dKMHE
        mQqECGX+cbPmkoeTOOehF1yFI7rYYzqLS5a768Ck1DRhMjwoGft2GHa+mCYFHulJ
        RdPD3K4emNcPWP42aLmM1HlamMZzlc6fRSC/27QwyA==
X-ME-Sender: <xms:ZwmvYv_hxRranQEqgdXX1JtzXCOdZd79DVKaHvoPQltM6nWOVd7Dvw>
    <xme:ZwmvYrtvVvCCpRWWbIu0fqLIsqdQsn6BO5vOwyLXUlEw80Nw7E-B1ao8tDsHxPanY
    DNakmBhBUxq1A>
X-ME-Received: <xmr:ZwmvYtDs8x7k6QawWGqKZ2cNKGGx_r2BvMrMPudhYfRZexqfKkFdvhSB9Zt8UXfKPRCVCAwZEq19zxev9zXq2f9AkwPCXWIq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddvledggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmqdfjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeeuvd
    evgeefueegfefgvddvjeejjefgffdvvdffffduueeltdeludelveeuleekfeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:ZwmvYrcgQkkDh0x7oVD3M8IqNJW278Ebv2uIPQ4W83rPlHpKQvpiYw>
    <xmx:ZwmvYkMchLHTZrBuFLKBHdNXb2tY5t92Gi01Ak49S6VxON3rJJjs_A>
    <xmx:ZwmvYtnWTu-PwaDGw9mRYQHYzCTYTi_HPlNQlaSEuaWG-sHw0Zsyfg>
    <xmx:ZwmvYlipt0k-lwKspKiM_WuwwvCP3zvRX7KtwLeceA_b6Qyx-Q9LTQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Jun 2022 07:32:54 -0400 (EDT)
Date:   Sun, 19 Jun 2022 13:32:52 +0200
From:   Greg K-H <greg@kroah.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Char/Misc driver fixes 5.19-rc3
Message-ID: <Yq8JZMQiUqdmfqx+@kroah.com>
References: <Yqw4Jujzz5ZzZ2Wg@kroah.com>
 <Yqywy+Md2AfGDu8v@dev-arch.thelio-3990X>
 <CAHk-=wh59Decy5ksYBW1kD2pmcgo8T0JdKa37iaeaEO5LUN62g@mail.gmail.com>
 <CE205655-557F-486C-AF6A-099749208327@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CE205655-557F-486C-AF6A-099749208327@kroah.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 07:43:26PM +0200, Greg K-H wrote:
> 
> 
> On June 17, 2022 6:59:50 PM GMT+02:00, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >On Fri, Jun 17, 2022 at 9:50 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >>
> >> I think you tagged the wrong branch (char-misc-next vs. char-misc-linus)?
> >> The commits below do not match the tag description above.
> >
> >Good catch. I verified the diffstat etc, but yeah, the actual
> >explanation in the tag doesn't match the contents.
> >
> >It's pulled now, and the code changes look fairly harmless, but I
> >suspect Greg will want to send a real pull for the changes that were
> >intended to come in here..
> >
> >                   Linus
> 
> 
> Crap, i messed that up. I'm away from my laptop until Monday so I'll
> verify it then. The one time i go out of town for the weekend...

Heat drove us home a day early so I've now created a new tag, on the
correct branch and sent the pull request.  Sorry about the mess, all
should be good now.

greg k-h
