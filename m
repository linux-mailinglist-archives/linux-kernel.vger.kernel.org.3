Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C384ED46B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 09:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbiCaHMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 03:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbiCaHMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 03:12:22 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2F65B3D0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 00:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VtSyhCBRl6DDd411G5kv1lVJwnclO4BJfyyDJEiIIQQ=; b=r44vCvmN1Q4mZOvdEid41+bbQ5
        VKde0jyZ1PAJJAX0DQvXUNXjYSbMR1O5y/GpPW12E/zBP4Ou/3pxCBLCxNGgEagFfeZZKdrYbAvAK
        ElofHY/yYSPxonnlV2KM5fTIjQ2+rvQoVtrymkk0xUq8gX6TW5utiHtovTWK4jzin952Psuu6hRKh
        7XhKlR1bR4UQ5Y74um1Q+1n2mTwtQr6cdP50g3hD7RHVsQB3J8jJfAIuBGcTtClXl+iNWZrfzScZ3
        YN52iT+ZbYPjxUAHzZiKDZToAUJtGC+XPCl/vloKT8jPTEFjb5Tt+uPvmme/N9OFiiVv4KXbl6ahh
        1wgxDnqA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58038)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nZowt-0004L7-2C; Thu, 31 Mar 2022 08:10:26 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nZowp-0007QG-Sx; Thu, 31 Mar 2022 08:10:23 +0100
Date:   Thu, 31 Mar 2022 08:10:23 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Austin Kim <austindh.kim@gmail.com>
Cc:     arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, austin.kim@lge.com,
        p4ranlee@gmail.com
Subject: Re: [PATCH] arm: kdump: add invalid value check for 'crashkernel='
Message-ID: <YkVT3z4ksYStau85@shell.armlinux.org.uk>
References: <20220330110715.GA1534@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330110715.GA1534@raspberrypi>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 12:07:15PM +0100, Austin Kim wrote:
> From: Austin Kim <austin.kim@lge.com>
> 
> Add invalid value check expression when no crashkernel= or invalid value 
> specified using kdump.

Hi,

I think you mean when "crashkernel=0" is specified, as other invalid
input should result in -EINVAL being returned. Please update the
patch description and comment.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
