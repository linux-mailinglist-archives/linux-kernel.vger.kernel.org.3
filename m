Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027E14A9BF8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 16:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359719AbiBDP3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 10:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiBDP3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:29:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B261C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 07:29:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9811D6159A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 15:29:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E21AC004E1;
        Fri,  4 Feb 2022 15:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643988571;
        bh=0rRhHIJ0JN50qUQ247/rEvq9zqCjY0RAl7MtlWWYHc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LeCX3E59ZSV4loDZut76iURbi2yREvj5vlAxFDszyuIb2XI5SSUi9uB6FkSxLmREk
         svibRACOcUaEtNj4IN2K90/5ZNYQzuDv/UGfn/OurtfuAtbJQsk96MT/3DrBvg4K/V
         Tb6r3ZCmmAQquXbqrr3tX8R+w5Vj7ldU7dYFMeRw=
Date:   Fri, 4 Feb 2022 16:29:28 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Usyskin <alexander.usyskin@intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/5] Add driver for GSC controller
Message-ID: <Yf1GWCExCM0t3b9e@kroah.com>
References: <20220127112103.2336871-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127112103.2336871-1-alexander.usyskin@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 01:20:58PM +0200, Alexander Usyskin wrote:
> GSC is a graphics system controller, it provides
> a chassis controller for graphics discrete cards.
> 
> There are two MEI interfaces in GSC: HECI1 and HECI2.
> 
> This series includes instantiation of the auxiliary devices for HECI2
> and mei-gsc auxiliary device driver that binds to the auxiliary device.
> 
> In v2 the platform device was replaced by the auxiliary device.
> v3 is the rebase over drm-tip to make public CI running.
> In v4 the not needed debug prints and empty line were removed,
>       'select' were replaced by 'depends on' in MEI Kconfig,
>       the new include file now listed in the MAINTATINERS file. 
> 
> Greg KH, please review and ACK the MEI patches after main merge window closure.
> We are pushing all through gfx tree as the auxiliary device belongs there.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
