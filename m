Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450E8493F62
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 18:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356547AbiASRv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 12:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356545AbiASRvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 12:51:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F693C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 09:51:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E134561633
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 17:51:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5CCEC004E1;
        Wed, 19 Jan 2022 17:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642614712;
        bh=QsWDQvNKpqCglgKA2IleZuJy64rc5ENQciBuCdVwMgM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p4sGnrfyDFYnoXmSg+y0jG8I9cT2ka1BLVcuDHbfEDXyl7LPixij10ayGoYSwsZmv
         II2v+e1hxdMt9EtWi/6SDNuqxzEBwJguI0aqQXg1O1uLRGVJtMu6+rVKQ0IeAXIzn6
         WYQMD9ez5ugypn9B7AhcC0Tb256bwvccKX4iJ1z8=
Date:   Wed, 19 Jan 2022 18:51:49 +0100
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
Subject: Re: [PATCH v2 0/5] Add driver for GSC controller
Message-ID: <YehPtWZ2aGlFOvWK@kroah.com>
References: <20220119155807.222657-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119155807.222657-1-alexander.usyskin@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 05:58:02PM +0200, Alexander Usyskin wrote:
> GSC is a graphics system controller, it provides
> a chassis controller for graphics discrete cards.
> 
> There are two MEI interfaces in GSC: HECI1 and HECI2.
> 
> This series includes instantiation of the auxiliary devices for HECI2
> and mei-gsc auxiliary device driver that binds to the auxiliary device.
> 
> In v2 the platform device was replaced by the auxiliary device.
> 
> Greg KH, please review and ACK the MEI patches.
> We are pushing all through gfx tree as the auxiliary device belongs there.

I will review this after 5.17-rc1 is out.  Please give us some time,
there is no rush.

greg k-h
