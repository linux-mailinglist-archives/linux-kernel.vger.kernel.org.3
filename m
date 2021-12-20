Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C91847B0BA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 16:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237458AbhLTPzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 10:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbhLTPzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 10:55:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4544FC061574;
        Mon, 20 Dec 2021 07:55:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D61E5611DF;
        Mon, 20 Dec 2021 15:55:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B207DC36AE7;
        Mon, 20 Dec 2021 15:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640015704;
        bh=dUn/siHCed+00iFm6+pbfrfR17i6Fgn0zXZ5qKc0C9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SPqciD3W7ys3TkAP7vRIEcOvkw/yVFTld83zJs9H67NGf+/y92yA4sRT6n5/ex7vk
         OOC2FYgA/dVG65wUoL0/mLtPiHF0yX1gl295zBN6vPBD9+rPqbPVImHIkb4IEmAn2Q
         I27qoKpzCP8WgIaJ1uHV05gnX/eFWbFkw45cU+F4=
Date:   Mon, 20 Dec 2021 16:55:01 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v3 3/5] tty: serial: samsung: Remove USI initialization
Message-ID: <YcCnVfp2DWuVlXIw@kroah.com>
References: <20211204195757.8600-1-semen.protsenko@linaro.org>
 <20211204195757.8600-4-semen.protsenko@linaro.org>
 <ab15a97b-9351-4d50-f392-21cbfdec1289@canonical.com>
 <CAPLW+4m0vYZUujki6D4KHV3TjBCZvnO-cZuoOatefQpfTEV3Yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPLW+4m0vYZUujki6D4KHV3TjBCZvnO-cZuoOatefQpfTEV3Yw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 05:21:16PM +0200, Sam Protsenko wrote:
> On Mon, 13 Dec 2021 at 13:35, Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
> >
> > On 04/12/2021 20:57, Sam Protsenko wrote:
> > > USI control is now extracted to the dedicated USI driver. Remove USI
> > > related code from serial driver to avoid conflicts and code duplication.
> > >
> > > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > > ---
> > > Changes in v3:
> > >   - Spell check fixes in commit message
> > >
> > > Changes in v2:
> > >   - (none)
> > >
> > >  drivers/tty/serial/samsung_tty.c | 36 ++++----------------------------
> > >  include/linux/serial_s3c.h       |  9 --------
> > >  2 files changed, 4 insertions(+), 41 deletions(-)
> > >
> >
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> >
> > Greg,
> > If you are fine with the changes, please take the serial driver changes
> > via your tree.
> >
> 
> Hi Greg,
> 
> If it's ok with you, can you please apply patches 3, 4 and 5 from this
> series? If it's possible, would be nice to see those in v5.17.

All now queued up, thanks.

greg k-h
