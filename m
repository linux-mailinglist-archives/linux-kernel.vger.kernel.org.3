Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A452C46843C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 11:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384697AbhLDKvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 05:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238470AbhLDKvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 05:51:39 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FDDC061751;
        Sat,  4 Dec 2021 02:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uN0UUJmT6U4ujQ7E/bslhmkUFeYza+A9RdqNPKnTQeI=; b=rgJcyJP/TqzPesH7TRhUviB8F9
        LpyX5is/aE6j9gDfc9U3QDZnL3x1ZxwxrzoR7M00MhiXZzIL26AnHlOp2Q6SnTC2OGqrNIRX0jBi4
        ssrwGsLsn8QqvnOoZtBpRpjyTLscqAOni/mCT42IZDpeCsr/k0IQxD5VqFGpVhr1ZQfqh477DGdb6
        ukXDtF7oEkNLvswXzjd67qLuMKS8WvX3VYC3bEEXmRAWr0sTO08kb7gHdD2Q7V4lHo280od+a42BY
        v0dsmNod4J/DPVPZgdPvHpkdQI1QVFOLquv/rHsF6X+4NGyikUEfptzcDE/Y1/qi9P2RLqrxXzlqu
        QQ/U+ZNw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56050)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mtSaJ-0003Ec-77; Sat, 04 Dec 2021 10:48:03 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mtSaE-0002Lg-Dq; Sat, 04 Dec 2021 10:47:58 +0000
Date:   Sat, 4 Dec 2021 10:47:58 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] arm/arm64: dts: Enable more network hardware
Message-ID: <YatHXrO1DQXFpqA+@shell.armlinux.org.uk>
References: <20211018011211.3836590-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018011211.3836590-1-chris.packham@alliedtelesis.co.nz>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 02:12:09PM +1300, Chris Packham wrote:
> This series enables the Switch and 2.5G Ethernet port on the CN9130-CRB. The
> changes are based on the Marvell SDK.
> 
> Note Gregory has already picked up the 2.5G Ethernet patch from v1 so I've not
> included it in v2 of this series.
> 
> Also note that if anyone tries out the SFP+ port on a complete CRB shipped from
> Marvell the chassis prevents the ejector from working so the SFP will get
> stuck. Taking the board out of the chassis allows the SFP to be
> insterted/removed.

Oh, these patches contain a SFP block... I suppose I should review them
then. Sadly not on the To/Cc, I guess I need to add something to
MAINTAINERS to detect the DT compatible...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
