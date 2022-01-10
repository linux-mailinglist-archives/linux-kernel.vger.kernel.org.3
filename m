Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAABA489BD1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbiAJPHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiAJPHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:07:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7910C06173F;
        Mon, 10 Jan 2022 07:07:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0FE160E04;
        Mon, 10 Jan 2022 15:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85884C36AE5;
        Mon, 10 Jan 2022 15:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641827264;
        bh=GV9T4EeYhVeOdH8blTnq/mluaQjNNqLiGaxvHrb6ETQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Tlr+AlrEQh8a/qpelHZeMQw0GCxJGcspjeLlUBLajX72rUx7/V9IE3RXpgsvY+2ND
         7Df/K1wu4bCFTysfyVcFY8FV9zXM4M5GtR3/IsPX+rUub7tDu4XIesDUHjGMwmHL+Q
         SYqypf/Eka8HkGhZnSuk9D8UzUt1amqi5IADle37tk4tWwYqMhCSGsAulcmGALgbdQ
         /x1ljllMQNKmnwj5WgW1fG+oMFIDU2h1JHFEq5NofN8tKY1za4JfbcK2RtZAZkEBvx
         t+Cl278+V/cJQCltDP6oAHpmTwNSA/x6dCXyxuR8onBYykWYaqeO8Awt9Xo8mHHklv
         Wlyi8KcSuXOkA==
Date:   Mon, 10 Jan 2022 16:07:39 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: Re: [GIT PULL for v5.17-rc1] New year's media updates
Message-ID: <20220110160739.735f1b49@coco.lan>
In-Reply-To: <YdNEQbgpBJP2lIiP@archlinux-ax161>
References: <20220101024250.39c9b5b6@coco.lan>
        <YdNEQbgpBJP2lIiP@archlinux-ax161>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 3 Jan 2022 11:45:21 -0700
Nathan Chancellor <nathan@kernel.org> escreveu:

> Hi Mauro,
> 
> On Sat, Jan 01, 2022 at 02:42:50AM +0100, Mauro Carvalho Chehab wrote:
> >       media: atomisp: shift some structs from input_system_local  
> 
> Please consider applying my patch that fixes this one to avoid breaking
> certain distribution configurations when CONFIG_WERROR is enabled:
> 
> https://lore.kernel.org/r/20211227164243.2329724-1-nathan@kernel.org/
> 
> I know there has not been much time between when I sent it and now but
> there have been two reports about it from the kernel test robot (one was
> back in November) and it is rather noisy in a build.
> 
> https://lore.kernel.org/r/202111182229.beNw3l9E-lkp@intel.com/
> https://lore.kernel.org/r/202112311809.bEKUPkjh-lkp@intel.com/
> 
> If it cannot be applied now because the tag has been created and the
> pull has been sent, could you make sure it makes it in a fixes pull
> request?

Sure, thanks for reminding me about that. I just added it today to
media-stage. I'll send upstream either during the merge window or as
a fix just afterwards.

Thanks,
Mauro
