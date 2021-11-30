Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8395A4635F3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 14:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241892AbhK3OCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbhK3OCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:02:07 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293BFC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 05:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=o77YFlMZ5q8jKlzGHjL1d9KKHRISLWlW7P0jBZlKEX8=; b=Ybj3uOTYOvCA5/unQ/EcF7kn9j
        oy1aoZKU4MoIgPKW7hXK23g/+AoLaB2wmi/rLgy1BjG+f8N7yM1EBuvt/o6BjCC6i6ArC0bsxtnYI
        cREqV7HN9CIHy+dQKRVRHvDGsrJGObudV8SThs5yn9r99flj2+GtqaHbynsL+F49wOeU8YU9BUdeT
        5rTls/TXYHDrxqI3+myi10q6MMWQatI7Aj07TTw4k1msp8zUTCPWPQwaqX6voUEKQlz2zlaETQbq9
        BFSzAcZN9zFS1KRzVJZWQ1QymuRf35s9kd1pxWb3wUlk6owO1ONYlbGKI+9EUXnkbIpySxSdVhQvk
        mq5bHkAQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55984)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ms3ec-0006yt-9q; Tue, 30 Nov 2021 13:58:42 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ms3eb-00076G-8I; Tue, 30 Nov 2021 13:58:41 +0000
Date:   Tue, 30 Nov 2021 13:58:41 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     kishon@ti.com, vkoul@kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: lan966x: Extend lan966x to support multiple phy
 interfaces.
Message-ID: <YaYuEb/kinBdXCG+@shell.armlinux.org.uk>
References: <20211130101015.164916-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130101015.164916-1-horatiu.vultur@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 11:10:15AM +0100, Horatiu Vultur wrote:
> Currently the driver is supporting only the interfaces QSGMII, SGMII,
> RGMII and GMII. This patch extend the supported interfaces with
> 1000BASE-X and 2500BASE-X.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Acked-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
