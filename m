Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D678849E0ED
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240371AbiA0LbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiA0LbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:31:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A534CC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 03:31:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41E1661857
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 11:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F302AC340E4;
        Thu, 27 Jan 2022 11:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643283070;
        bh=7HqwSoW5O1NWejCEkStNnpAuYC+GSrUSOhS0AuQNqAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sY9SbnKTP8q8hHQpER7Gg081wDR01ODW+qbprsBZFm7fIucv7zNyLI8y1KH1kxGH4
         vjm/qc92O62CsggmvNgtJn/4KErVLZ78aiF/vKQWLERDfTY09J61vLKHAujlfyg2lL
         4anSR7pzHuF6emIjS1d4nIJmzZuaEWT0LE6Pr9uY=
Date:   Thu, 27 Jan 2022 12:31:07 +0100
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
Message-ID: <YfKCe9ALCjrUO+89@kroah.com>
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

The merge window already closed, did you forget to update your email?

> We are pushing all through gfx tree as the auxiliary device belongs there.

I'll get to this in a week or so, please be patient.

greg k-h
