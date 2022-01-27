Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E170649DBA8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 08:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237350AbiA0Hb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 02:31:56 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:34599 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233852AbiA0Hbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 02:31:55 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id DC96D5C006F;
        Thu, 27 Jan 2022 02:31:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 27 Jan 2022 02:31:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=EbdQKynrwM3mxnu0lIvnum4EYaMT0eAuKGC+QK
        OBK/4=; b=UL8wcCDrh7Rx3fT2ReCAy/H+FjwEQ33hxZ21cU0S8FJ4xxV201E2Ti
        YbdGtAI9inZPmT5Exzl978DWvc0xv7rGu7kZk95TIk01RvYl4bjrAKe1oQ6yUOz6
        CTpsMxlkeSrVADQ6OBHkQ5UAgG/8744r9HmldhK8hYaoiV+ykjmDlzV5NYSnm0mt
        H3UkSOFrf96ER2phRXUwQi0T3xejKMl0aTIVkN5YtDDYyJqs9pfCnGYo5ogQAes1
        aG/KKPpDzL3ZC3OVOBgIi9VdYz+H2S6aenIgV+l9csBfVF2kerB31g/6JB9eNebx
        GY/XGL2xpw4r5GvzgdzMNh9ZHqkt85fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=EbdQKynrwM3mxnu0l
        Ivnum4EYaMT0eAuKGC+QKOBK/4=; b=A7c5QZiaFgZPHm8aK+sIbTUhbpLZ9gqYn
        v5dW0kxjRb+x/5rmGwn7Eds7njDlUv3o7JHn6qb3j+lqYZsVH775H9Ls1OBGTGda
        Jkx+0VG85IVa98rwgMtUTOfayGmF85TNWL4l/MMRA36r8brB/cREd2FCXZDCFySw
        ATUcbGFn6FiUgjWUOx+EDpmUwl1YQm6L5SFeZcwJbejDRZxI3vxsdKttxKmxJq+S
        I+Lgj98P4XEvjMhH/qS2Z3e2VAnYRSs7D7T84xcyeM0c559YXWVXgbVQ7LmRdheb
        mgVS8roW8y/qRl06DI9z9WXyfBctaQOj7h7+Khm0i/axZeCuf4qVw==
X-ME-Sender: <xms:akryYWPPXdftbzaHJoW_wEB01WpftdH8cqxHbAF8Z3bAR1rmUaqDQQ>
    <xme:akryYU9bfkwXKL_b9O-SQc4hwkqssvLNmqJRHMSlz-NwfPoUfqBGK4sttE8X52wbP
    h-ZbkCghnVRkw>
X-ME-Received: <xmr:akryYdQyCr7Uq3XWNTjUTffttAU4LU8254QF4U9Z-dtJqKjRggMhTzkokfwmA2hWQOg6by00DG2w5C6S9XoP-8W7LMX1B1JP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrfedvgddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:akryYWuIVQwNMPJlVsTJuqC6EfCa6-XCSa2bH0ROAbArKrkLEsp95Q>
    <xmx:akryYef74uEvO4Q_CsyeuXX6bVHICbz8FjztJPGZgZtSE_LaDcs77g>
    <xmx:akryYa1n0Sc3FEIwyNPHB2zWEPF1Kkwisig1SayGFgymSY89tsb1kQ>
    <xmx:akryYWTTuS4gneLIvJIJO3Ul3ODVg9yqPsDUezbQTteHWWA5aHKaTA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Jan 2022 02:31:53 -0500 (EST)
Date:   Thu, 27 Jan 2022 08:31:46 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Maciej W. Rozycki" <macro@embecosm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the tty.current tree
Message-ID: <YfJKYj3UOYQIHsb0@kroah.com>
References: <20220127091800.1e8f333b@canb.auug.org.au>
 <YfJIUIj1mDcShwpV@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfJIUIj1mDcShwpV@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 08:22:56AM +0100, Greg KH wrote:
> On Thu, Jan 27, 2022 at 09:18:00AM +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the tty.current tree, today's linux-next build (x86_64
> > allmodconfig) produced these warnings:
> > 
> > In file included from <command-line>:
> > ./usr/include/linux/cyclades.h:6:2: warning: #warning "Support for features provided by this header has been removed" [-Wcpp]
> >     6 | #warning "Support for features provided by this header has been removed"
> >       |  ^~~~~~~
> > ./usr/include/linux/cyclades.h:7:2: warning: #warning "Please consider updating your code" [-Wcpp]
> >     7 | #warning "Please consider updating your code"
> >       |  ^~~~~~~
> > 
> > 
> > Introduced by commit
> > 
> >   f23653fe6447 ("tty: Partially revert the removal of the Cyclades public API")
> > 
> > This is a bit annoying :-(
> 
> Sorry, odd it doesn't show up in my builds, nor in 0-day.

Ah, 0-day reported it on the original patch, but not once it was in my
tree.  odd.

