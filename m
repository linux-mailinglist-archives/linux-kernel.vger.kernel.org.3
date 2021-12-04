Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA0346843F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 11:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384709AbhLDKyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 05:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbhLDKyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 05:54:37 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852ABC061751;
        Sat,  4 Dec 2021 02:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QRqMG8RGfuulyL/MI0Y5Pjs+qEIm3XSHn3xpOu7rjTc=; b=rQlOAVr97mx1/sQxkZUR7Dfcur
        GJPPDvZY+jrQ/8M9gvVzpQYE+Yx4prmqBcEqa04XQ/8YedUDEIh1uObKhv+L0uHhblI6Rctc5gewF
        MRHqCkt3iiOAh3sa77R7yhj2ufJXj6uMNeiTyOrosmJp49NycAViPKDhdcYo/QVoka8Y/My5ezaYA
        otd20+CaZErP1hJzxTgOw3FLcfXq0eifXZXRqodeAOYTTHaNZdtmuOwkQAKBZuFGrVc/gKQBVz0a/
        IepWVxwmnM71Cf2UNJeRejyKjKbp7YpW9ftsyr0Fn+De163tbBEFY7q6f5HymbCKoV7q6RM4M1jLh
        R/cmqSDg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56052)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mtSdF-0003F5-OJ; Sat, 04 Dec 2021 10:51:05 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mtSdB-0002Ln-Pm; Sat, 04 Dec 2021 10:51:01 +0000
Date:   Sat, 4 Dec 2021 10:51:01 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm/arm64: dts: Add MV88E6393X to CN9130-CRB
 device tree
Message-ID: <YatIFWHBlTV/jm9U@shell.armlinux.org.uk>
References: <20211018011211.3836590-1-chris.packham@alliedtelesis.co.nz>
 <20211018011211.3836590-3-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018011211.3836590-3-chris.packham@alliedtelesis.co.nz>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 02:12:11PM +1300, Chris Packham wrote:
> The CN9130-CRB boards have a MV88E6393X switch connected to eth0. Add
> the necessary dts nodes and properties for this.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

This looks fine, thanks.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
