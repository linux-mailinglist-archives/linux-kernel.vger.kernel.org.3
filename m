Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFD748F2D1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 00:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbiANXFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 18:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbiANXFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 18:05:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4302C061574;
        Fri, 14 Jan 2022 15:05:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8660B62065;
        Fri, 14 Jan 2022 23:05:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4154C36AE9;
        Fri, 14 Jan 2022 23:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642201552;
        bh=eW8qfxOLXmdoe8jddUPKE7G9qg502Iient4wuy9l11I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iecKcacZgzID8/b83zx1M7UUlCj0+BSDXYsyfZsokK9MDNjfllpfTYDSzIY8Oz3ge
         vBHt+OI7i3geYdpP7aSckqswrzFNYRVqyeAqCBlaNw4nxhwgePgSncP0JuEwgobZwl
         ceQ68+uqxOA75qL065+rX6avsuj5DJBN2iDhJd9M8OjoUxOwhpPUeHsgkrozDv8b9M
         b9PScIWVf5ZWEJMerqVOVqCFzeFRJ63EC6ZEjFEGHkJnFRUfM/W+baHS2m9ZkRaV9/
         LnvTyCPoTNeaVZ9Q9/x08jRgwmfqeRQpMl9S3IzU9HGaw2l+vpX06+7JEj/sH5wumY
         2tsfKhUS5o3dw==
Received: by pali.im (Postfix)
        id DA3527D1; Sat, 15 Jan 2022 00:05:49 +0100 (CET)
Date:   Sat, 15 Jan 2022 00:05:49 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 0/6] serial: mvebu-uart: Support for higher baudrates
Message-ID: <20220114230549.56co4qcpnq32muwj@pali>
References: <20210930095838.28145-1-pali@kernel.org>
 <20211103214209.azo2z3z4gy7aj5hu@pali>
 <87ee6bm9hn.fsf@BL-laptop>
 <20220114105100.im6gmkt6fjl2aiwl@pali>
 <20220114225659.D5D79C36AE9@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220114225659.D5D79C36AE9@smtp.kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 January 2022 14:56:58 Stephen Boyd wrote:
> Quoting Pali Rohár (2022-01-14 02:51:00)
> > Hello Stephen!
> > 
> > On Friday 17 December 2021 18:23:00 Gregory CLEMENT wrote:
> > > Hello Pali,
> > > 
> > > > On Thursday 30 September 2021 11:58:32 Pali Rohár wrote:
> > > >> This patch series add support for baudrates higher than 230400 on
> > > >> Marvell Armada 37xx boards.
> > > >
> > > > Stephen, Gregory, are there any issues with this patch series?
> > > 
> > > I am not found of these changes but let's apply it as I didn't take time
> > > to do a better review.
> > > 
> > > However I can't apply the dt part if the driver is not merged.
> > 
> > Stephen, are there any issues with driver (non-DT) part changes in this
> > patch series? If not, could you please merge them? This patch series is
> > here on the list since September without any request for change...
> 
> Oh I missed this thread. I thought it was going to be resent.
> 
> > 
> > We would really like to see support for higher baudrates for Armada 3720
> > platforms in mainline kernel.
> 
> If we're adding new support why can't we break with backwards
> compatibility for the binding and do it a different way?

Because DTS are backwards compatible. I was told more times that kernel
drivers should work correctly with older DTS files. On some boards are
DTB files provided by bootloader and they do not use in-kernel DTS
files.
