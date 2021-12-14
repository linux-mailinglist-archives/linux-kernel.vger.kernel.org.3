Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7DA47458D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 15:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbhLNOs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 09:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbhLNOs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 09:48:56 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDB6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 06:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vnKrhnNSX8Cz7c3zc2oNj8KsYNYBcREmY+9Zua2TEe0=; b=pXytnim82yAWIkfajPcVCS1NX7
        RZU7ocFMBq5QtJ+OvULWzD2qzYpozD3OOhN2fx/UBW4Tf3sGMVbP5XDaJBiX7kV5M+UaCTbkfjPZr
        eGgGOmB4m/rpZ7pQJgMe+uu5navB010xfJkluSn3EH/BAawJ/KJ3WeuYCJ140Ib7DJNLAAElFxcA2
        FqVZg3MkfPFjoNrEPrvwxdM9w60eQN6WiCifk7b3qbpp3lTdjPyxlt1EJkGtiGFY8QlFioD4NYTH8
        wTlyywjG4jEIyA7huVKowFCTChlvrsgedB3a+dyDNzhXi/KRBnkWNgp+PJcikI9r+x3Cl3Gh3NJ6G
        CzjeQN4g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56278)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mx96r-00055Z-PP; Tue, 14 Dec 2021 14:48:53 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mx96q-0003aS-Vm; Tue, 14 Dec 2021 14:48:52 +0000
Date:   Tue, 14 Dec 2021 14:48:52 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>
Subject: Re: [PATCH v2 1/1] ARM: orion/gpio: Get rid of unused first
 parameter in orion_gpio_init()
Message-ID: <Ybiu1F10qpQ3KlGT@shell.armlinux.org.uk>
References: <20211214140656.53694-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214140656.53694-1-andriy.shevchenko@linux.intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 04:06:56PM +0200, Andy Shevchenko wrote:
> The OF node pointer is always NULL, get rid of unused parameter in
> orion_gpio_init(). As a side effect it will allow to switch GPIO
> library to the fwnode API, as well as in case of resurrecting it here
> it should be fwnode_handle anyways.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
