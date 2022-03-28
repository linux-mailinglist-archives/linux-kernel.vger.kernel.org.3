Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98BD4E9B45
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 17:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238451AbiC1Pnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 11:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238421AbiC1Pnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 11:43:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501D55FF3A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 08:42:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF0B36132E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 15:42:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1020C004DD;
        Mon, 28 Mar 2022 15:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648482121;
        bh=LecrlOGYhUWTQmy3YSKQPwgzzb/ltTwmfDXzlpnoeU4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FVzPbFQEvLCu5l5mDoTqHQaHw0RpAAHytExHJGUJHY7SRUrw453TLkXNxLsSwxv7b
         rUZT6ygBjAlUxZJnCqBIdjihlLJ6RmNG8WSLa4wwJLwLh3n8ZqjcCEaYmvaL8pDSF2
         UToAab58jAMgTAIXpqUiR4zw3Qx170PRUF9Wm52JxqQbBcK1RYO3Tg0O1h+ZcLOmUj
         of0RYdYucrzcrbORmNnKDa/fb2sjsYMOBN99nXPWUA3f5n3ysJV/2KKWPL6aApKy+X
         +Baiz0McuR3Dm51Mcaf7/JV9P0b+MQqfrqi7WwHj0jwqm1KK+1J31A5Cb4MtDp3Oxc
         qT2ChP7EQNX+g==
Date:   Mon, 28 Mar 2022 08:41:53 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] x86/config: Make the x86 defconfigs a bit more usable
Message-ID: <YkHXQTKImf7Wr+Sk@dev-arch.thelio-3990X>
References: <YjhdcJB4FaLfsoyO@gmail.com>
 <CAHk-=wjS6ptr5=JqmmyEb_qTjDz_68+S=h1o1bL1fEyArVOymA@mail.gmail.com>
 <YjpLiKRUIB4TGJm0@zn.tnic>
 <CAHk-=wifoM9VOp-55OZCRcO9MnqQ109UTuCiXeZ-eyX_JcNVGg@mail.gmail.com>
 <YjsCpoRK7W4l6tSh@zn.tnic>
 <CAHk-=wi9pLxm+dXoCaiGO+f0EbhyfAR_L510vD0c2=hj6rbMXg@mail.gmail.com>
 <YjwsUT/6PkRPjnHE@gmail.com>
 <YjySjys3QZAWFlfo@dev-arch.thelio-3990X>
 <YkC08gKqJOUM7CA8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkC08gKqJOUM7CA8@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2022 at 09:03:14PM +0200, Ingo Molnar wrote:
> Yeah, good catch! ...
> 
> I use defconfigs by explicitly adding in the architecture:
> 
>   kepler:~/tip> make ARCH=i386 defconfig
> 
>   kepler:~/tip> kconfig-arch
>   i386
> 
> ... so never I noticed this bug.

Ah, good point!

> I fixed this in the latest version (attached).
> 
> Arguably 'make ARCH=i386 savedefconfig' should preserve this, so that 
> refreshing defconfigs on bi-arch architectures is idempotent, but that's no 
> excuse to regress the existing defconfig behavior.

Hmmm, I thought that it would, but I think the behavior of savedefconfig
is actually correct with regards to how it handles CONFIG_64BIT in the
presence of an explicit ARCH value, based on how CONFIG_64BIT is
defined:

config 64BIT
	bool "64-bit kernel" if "$(ARCH)" = "x86"
	default "$(ARCH)" != "i386"
	help
	  Say yes to build a 64-bit kernel - formerly known as x86_64
	  Say no to build a 32-bit kernel - formerly known as i386

As the default is no when ARCH == i386 and there is no prompt in that
situation, "# CONFIG_64BIT is not set" gets dropped, as that is the
default. Using savedefconfig without the ARCH variable would do the
right thing.

I tried playing around with these Kconfig symbols to see if I could get
something that would work for savedefconfig with or without ARCH, but I
could not really come up with anything. I did not try super hard though,
it might still be possible.

Cheers,
Nathan
