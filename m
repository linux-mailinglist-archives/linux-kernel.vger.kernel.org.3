Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862C3481D0C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 15:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240046AbhL3O3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 09:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239963AbhL3O3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 09:29:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F361DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 06:29:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89D7E61693
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 14:29:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8794BC36AE7;
        Thu, 30 Dec 2021 14:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640874591;
        bh=3jzZNKtf2goG38YqCOhXGjbSkJOVNdC9TjNp3SYA4LQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bTeUWbvAhBdM3EssgXZQgdaWzJAhIZzB4gsrD71Uj5xHiKjCUdd6FlZCWVKVRuN3a
         qJZ1t08UCU7MUJI9vfrYKZUYn15PdpnMpFPGALLxmWPcKWYLZQvoahvO3h/y7aNj46
         LweAg2LEf+HUi2peSIc4wn85jXSqMonYEg7nSdOY=
Date:   Thu, 30 Dec 2021 15:29:49 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     tkjos@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] android: use "menuconfig" menu entry type for
 CONFIG_ANDROID
Message-ID: <Yc3CXep5zS0u96m9@kroah.com>
References: <20211228200634.18968-1-jengelh@inai.de>
 <Yc2wsGmEe7lefB9h@kroah.com>
 <5po21q10-20p8-5593-2npn-7n5718qsnq73@vanv.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5po21q10-20p8-5593-2npn-7n5718qsnq73@vanv.qr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 03:14:26PM +0100, Jan Engelhardt wrote:
> 
> On Thursday 2021-12-30 14:14, Greg KH wrote:
> >On Tue, Dec 28, 2021 at 09:06:34PM +0100, Jan Engelhardt wrote:
> >> Allow disabling the Android driver section from within the Device
> >> Drivers submenu, without having to descend into the Android drivers
> >> submenu first.
> >> 
> >> Signed-off-by: Jan Engelhardt <jengelh@inai.de>
> >> ---
> >>  drivers/android/Kconfig | 6 +-----
> >>  1 file changed, 1 insertion(+), 5 deletions(-)
> >> 
> >> diff --git drivers/android/Kconfig drivers/android/Kconfig
> >> index 53b22e26266c..dc0a373ab879 100644
> >> --- drivers/android/Kconfig
> >> +++ drivers/android/Kconfig
> >
> >You made this patch at one level too deep, it should look like:
> >
> >--- a/drivers/android/Kconfig
> >+++ b/drivers/android/Kconfig
> >
> >As-is, this will not apply.
> >
> >A normal git diff will output the correct patch file, as will 'git
> >format-patch', how did you create this?
> 
> Uh, I once again ran afoul of my default "diff.noprefix=true" in 
> ~/.gitconfig. Unless there is a magical barrier, `git am -p0`
> should momentarily work for you as I edit my ~/linux/.git/config to 
> set diff.noprefix=false.

I use the tool 'b4' to apply patches, which sucks it out of the public
archive and then uses 'git am' to apply the patch.  So I can't apply
your patch as-is, sorry.

Please resend.

thanks,

greg k-h
