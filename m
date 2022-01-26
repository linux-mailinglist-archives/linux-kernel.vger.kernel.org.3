Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825DB49C54D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 09:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238496AbiAZIb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 03:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiAZIb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 03:31:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAD5C06161C;
        Wed, 26 Jan 2022 00:31:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56A12B817E6;
        Wed, 26 Jan 2022 08:31:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44118C340E7;
        Wed, 26 Jan 2022 08:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643185885;
        bh=5XhiZ9KX1O+6kUkna4BitOhkQ8ITLiIjnAMjcJq/erA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ulYF2aCwDeYsDSKdzal7qDeMVH8cUyYiRLAB9ET7S50sbVis5gDUOO6oBhAk0ZiaF
         SaoD1q/qMWN2CmDguFhFPlpE5IMHIDsbgQOk0y5r46raaWZ7EY0NY8cKcZSmT60Jl+
         pTiO25aD0DFIFJgJrJLxp8MPUO7RvYWovnOaq0WA=
Date:   Wed, 26 Jan 2022 09:31:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Phillip Potter <phil@philpotter.co.uk>,
        Lee Jones <lee.jones@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Carlis <zhangxuezhi1@yulong.com>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Helge Deller <deller@gmx.de>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/4] fbtft: Unorphan the driver
Message-ID: <YfEG2qVO9K9G+g1d@kroah.com>
References: <20220125202118.63362-1-andriy.shevchenko@linux.intel.com>
 <20220125202118.63362-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125202118.63362-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 10:21:14PM +0200, Andy Shevchenko wrote:
> Let's maintain occasional fixes to the fbtft driver.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  MAINTAINERS | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ea3e6c914384..16e614606ac1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7372,9 +7372,11 @@ F:	Documentation/fault-injection/
>  F:	lib/fault-inject.c
>  
>  FBTFT Framebuffer drivers
> +M:	Andy Shevchenko <andy@kernel.org>
>  L:	dri-devel@lists.freedesktop.org
>  L:	linux-fbdev@vger.kernel.org
> -S:	Orphan
> +S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-fbtft.git

I'm ok with the files moving if the dri developers agree with it.  It's
up to them, not me.

thanks,

greg k-h
