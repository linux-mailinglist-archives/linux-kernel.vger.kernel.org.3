Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997A4468EFA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 03:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbhLFCH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 21:07:56 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:39926 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231177AbhLFCHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 21:07:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=jj+aGxTa4utnaMB0rtfkIrbaKxrUIVvyG/sU82wYshc=; b=fJawodhrTMmEl5Mnb3dz+DHie1
        P0y5Rk/8yNt3zXSq20p91AYbeMW0nRRH/pfjncOWpblS9FAVoyWhpPXsWpXEub9wJVNebGqLtnQhW
        NJXiYqIObQibeMQRABBvZwhI4DqQqO3cG7wYCCI3FuDRg9w49BlH5AdMQBT5ZTmY2Pqk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1mu3MZ-00Fd2i-WF; Mon, 06 Dec 2021 03:04:20 +0100
Date:   Mon, 6 Dec 2021 03:04:19 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        robh+dt@kernel.org, kabel@kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] arm/arm64: dts: Add MV88E6393X to CN9130-CRB
 device tree
Message-ID: <Ya1voxHygvEe3JEc@lunn.ch>
References: <20211205225618.1565909-1-chris.packham@alliedtelesis.co.nz>
 <20211205225618.1565909-3-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211205225618.1565909-3-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 11:56:18AM +1300, Chris Packham wrote:
> The CN9130-CRB boards have a MV88E6393X switch connected to eth0. Add
> the necessary dts nodes and properties for this.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
