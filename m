Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B5A47BC59
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbhLUJCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:02:21 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:36770 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234135AbhLUJCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:02:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=tBLMC9EtPioLcHEQMNR6XjuU+AyVB9dvUvYUHZe3Hws=; b=ggER2R/uZUJ4h9MLhJZMXC9JuG
        njPeOxGv41YsNu2bMahydFea+LG/SPr3Vr5VYODV3hze94Q//7HtsK8+WCvsiASgnEDZ7gbcpeJYR
        eILgLnFLA2Vcn2ciF0NjgX4PVm3Z6Z090mPoBj+i82YEbFFYqCvnwwI4x0RX9Ibzvo8Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1mzb2D-00H71Y-4D; Tue, 21 Dec 2021 10:02:13 +0100
Date:   Tue, 21 Dec 2021 10:02:13 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>
Subject: Re: [PATCH v2 1/1] ARM: orion/gpio: Get rid of unused first
 parameter in orion_gpio_init()
Message-ID: <YcGYFZSfhZuG9Zcn@lunn.ch>
References: <20211214140656.53694-1-andriy.shevchenko@linux.intel.com>
 <Ybiu1F10qpQ3KlGT@shell.armlinux.org.uk>
 <YcGB2/+Oe7Qr1w3h@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcGB2/+Oe7Qr1w3h@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 09:27:23AM +0200, Andy Shevchenko wrote:
> On Tue, Dec 14, 2021 at 02:48:52PM +0000, Russell King (Oracle) wrote:
> > On Tue, Dec 14, 2021 at 04:06:56PM +0200, Andy Shevchenko wrote:
> > > The OF node pointer is always NULL, get rid of unused parameter in
> > > orion_gpio_init(). As a side effect it will allow to switch GPIO
> > > library to the fwnode API, as well as in case of resurrecting it here
> > > it should be fwnode_handle anyways.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> Thank you, Russell and Andrew, now I'm wondering who can pick this up?

Gregory Clement normally picks up these patches.

	Andrew
