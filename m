Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1EBE49DB5A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 08:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237192AbiA0HXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 02:23:02 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:35509 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230171AbiA0HXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 02:23:01 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 19E055C00CE;
        Thu, 27 Jan 2022 02:23:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 27 Jan 2022 02:23:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=jmOFRNqeia8Jwv6HakalwIdHv5r33fycUZ8Ohh
        YSdrI=; b=gjbVRNyHosFvzz7vHX7EjSXxLm54HwhfugkQqbhbiNtiF3MzOlhK7A
        7yjpRkc+s3pe7JAvKqHdMmK21/5mlD6Y+judlvIte/jPkLPRRJPbdrm7nIBkKPfE
        fuMhRoPAZXwWdal90I9tlnuc09mAvTk9MWZce66MYAY9mIBpb2CBnblNWUtEpEkK
        toiDhiQ6vslrgo+wScHqLcXdoSAwz520IOEbDJICXz0+YU4WA3G+azxqmQyNzx+5
        GQZ7VIeLbmMbhTairpuGYQB6jht+NE6O03bEH7a+BS5S8OUHpkY39yVVBtZvuHY3
        zn3z9KHKo7oFqVkKH4EZy+96FF/21skA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=jmOFRNqeia8Jwv6Ha
        kalwIdHv5r33fycUZ8OhhYSdrI=; b=U/DG73Ek6XPZTNwdQwwGcgLUVuOS3elJv
        svGvi4QgszniwRu0MbYaWVNiqMDP9pXQ8jHkp9Y48labRMz73QsFiVeMioB4etTi
        7BOHjdEsfSRXewwvkf61/pWMZUNhFphLOY5U+EBPyQQhX8zVRrF9rkFFYMn5c6B6
        k9PsJ7FFBPjeNz2iJQeHHU/nKqwgjfrxwbRAOQ2j4N5yWjSEp9MR4YhlWT0F0BWO
        Kaw3Uiinc0JwRfi7GpPMmk2wM+I5dnFN+ofspg2UbM72Ikc8GthYSfY6OPzzbICE
        czoh+xZiIqtMXob64V7MuuyXfb2qGUB6GJyEgHGKh8r8U+P96c0jQ==
X-ME-Sender: <xms:VEjyYfxuqCyXymG9V1EaKkPFwNXD9UDxzbdVJrci1XrcDMl9OJGRLg>
    <xme:VEjyYXTFs3fJECy9X9OOKbxdQd5vtGefrb7mlD54MXIekG5F_x_dlQ_wwA_Uixe9S
    33oPVR3IO-ESQ>
X-ME-Received: <xmr:VEjyYZWiQRElVILXOHfJ224wKhiwchTpOpcJdD6ftUP_k8nt9_QkSDGyvLnO1z_dUU_nfOHq2y6bDZQ2-ssEheILl9hndchG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrfedvgddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:VEjyYZiDQ60J3N4ziFtf6QT0On3bYQh5EuHwmatgRH2T3ZTh6ljNmw>
    <xmx:VEjyYRBcXcq42kPxeb9-8w3ZDRJV1ULN7lVXpPCri8RwitBXZP5rEw>
    <xmx:VEjyYSIvHUpmdQdkGtZ__yMOPow3k0bgwvPxaDxAskEjxPNZlMD4pg>
    <xmx:VUjyYT2LPx2yq3mzEmeXykuCC8QmRF_PBoVh_RMSkBlSNvmbZ7Qarg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Jan 2022 02:22:59 -0500 (EST)
Date:   Thu, 27 Jan 2022 08:22:56 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Maciej W. Rozycki" <macro@embecosm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the tty.current tree
Message-ID: <YfJIUIj1mDcShwpV@kroah.com>
References: <20220127091800.1e8f333b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127091800.1e8f333b@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 09:18:00AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the tty.current tree, today's linux-next build (x86_64
> allmodconfig) produced these warnings:
> 
> In file included from <command-line>:
> ./usr/include/linux/cyclades.h:6:2: warning: #warning "Support for features provided by this header has been removed" [-Wcpp]
>     6 | #warning "Support for features provided by this header has been removed"
>       |  ^~~~~~~
> ./usr/include/linux/cyclades.h:7:2: warning: #warning "Please consider updating your code" [-Wcpp]
>     7 | #warning "Please consider updating your code"
>       |  ^~~~~~~
> 
> 
> Introduced by commit
> 
>   f23653fe6447 ("tty: Partially revert the removal of the Cyclades public API")
> 
> This is a bit annoying :-(

Sorry, odd it doesn't show up in my builds, nor in 0-day.

> Can we exclude include/uapi/linux/cyclades.h from the headers checking,
> please?

Let me fix this up, thanks.

greg k-h
