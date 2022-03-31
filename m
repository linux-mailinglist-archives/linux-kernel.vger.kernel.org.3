Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D6A4EDA36
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 15:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236666AbiCaNHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 09:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236611AbiCaNH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 09:07:26 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB22F4C786
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 06:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+nKY9hwvgqMdRdXDz+2cXbLqQhheSzIRFdLBDTMFs80=; b=GdGRQICrf10dmwbn+iIOKp1jYO
        s6GUAL+7mXyvYud5qulJwvL/VtIwJtY7m9u4tU6j1vQkX4EQ/+YJ0FTTV0u0aGMT6USrbD9urowrp
        1pStOApgHCfIvsArXcmSFlBuPNT4uckQRafDQYTMXLjwwnl8ULWjZq5moKRLBmNs2btXw+bKwagPP
        wxjdEWuPvuKl8TBQBgWK0/eR8/rs4TLPIcdF7uSQWDurwtvLmttGqbE84Oj8//OqfdymToc2/FGXm
        QZe/hMWNDa6copw3R4Arpy/DqzKbcth5Vls3HB2mKf3V9gPlMr4iClJpYqJa3eRTX8HtXGS5y6vj9
        ate2Umwg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58058)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nZuUZ-0004ql-Ga; Thu, 31 Mar 2022 14:05:35 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nZuUX-0007e9-Iz; Thu, 31 Mar 2022 14:05:33 +0100
Date:   Thu, 31 Mar 2022 14:05:33 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Austin Kim <austindh.kim@gmail.com>
Cc:     arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, austin.kim@lge.com,
        p4ranlee@gmail.com
Subject: Re: [PATCH v2] arm: kdump: add invalid input check for
 'crashkernel=0'
Message-ID: <YkWnHbCA1v4nCSTl@shell.armlinux.org.uk>
References: <20220331112416.GA1002@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331112416.GA1002@raspberrypi>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 12:24:16PM +0100, Austin Kim wrote:
> From: Austin Kim <austin.kim@lge.com>
> 
> Add invalid input check expression when 'crashkernel=0' is specified 
> running kdump.
> 
> Signed-off-by: Austin Kim <austin.kim@lge.com>

Thanks, this looks fine. Please send it to the patch system, link
in my signature below. Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
