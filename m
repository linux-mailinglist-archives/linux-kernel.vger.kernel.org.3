Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA204743B0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 14:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbhLNNlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 08:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbhLNNlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 08:41:36 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906C4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 05:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+ZUy/3bMM7/nmZFCJ5b7/UZFV+jJUEvufcYBfP6xYjU=; b=GfKi/11PrvYEx70EAaVLotr8vc
        zwwEmFew961wkODoSjsPlgKLxJJLLuFRvPPz1AQYqv5k95pVFT/vVlL3cgulHFAX4S1nFSd274l6r
        BH76AFMYPU0k/fa2zxiiGVgoWJ+K452iLUuIDmJBjr8PZ5J+Jvl9bUK9Attte+ZymDz/hFgdU9GTc
        Dwgg19UYxQm42eDgFpTLLQ5iTPyaQJ5kVCWardrCjqQOiagnANJ3i923Or+klVnYckY6Ffpk/Z3Hu
        cZiA9PZs+ecltJtRGxvkTq8dfyy3s+RXpEUcGH3YeD+ydtVZraiXQRgD+4KAkM8OZL48mehP/0JBP
        oyAAc6qg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56274)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mx83g-0004z8-QE; Tue, 14 Dec 2021 13:41:32 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mx83d-0003YC-K6; Tue, 14 Dec 2021 13:41:29 +0000
Date:   Tue, 14 Dec 2021 13:41:29 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>
Subject: Re: [PATCH v1 1/1] ARM: orion/gpio: Get rid of unused first
 parameter in orion_gpio_init()
Message-ID: <YbifCSYfbKoYuzDX@shell.armlinux.org.uk>
References: <20211214133243.53199-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214133243.53199-1-andriy.shevchenko@linux.intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 03:32:43PM +0200, Andy Shevchenko wrote:
> The OF node pointer is always NULL, get rid of unused parameter in
> orion_gpio_init(). As a side effect it will allow to switch GPIO
> library to the fwnode API, as well as in case of resurrecting it here
> it should be fwnode_handle anyways.

Please ensure the new code follows the existing style - especially in
terms of wrapping. Some of us still use 80 columns as a general rule.
Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
