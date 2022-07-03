Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412E45649E9
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 23:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbiGCVRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 17:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbiGCVRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 17:17:06 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95D62DF6
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 14:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=A+w7a21fL8bVldx3NnqUuY6vmPNlyZGB9cj0RjgP32w=; b=OH7x1w/zfKdj3pOPMUDg5IdpkV
        RSysOlePAOIHdkuiZLU2vU8CD5L9IjBhHxqIh0DUd8Wa9YLMVVXHP4Dt6R6v30e0Te49f41GVcRex
        LMVxypXIsAVS1I7Gp2ZKED8/mZ+/74/juFUeeUgyd+1QmfdbHekgV1AHfL/zS3Ej9QqBVplxklGA8
        XB5uuOkZVjPN9uZt+stnpfwypgCm5pkeK2wpsqU0LEwplqXuANoDKbFIQHKb/UdN7I5LUj7u5UulT
        RYFB7ble4et8zaxmjpxfwinqFu4+3MeT+/xoeo1ilqJin1utc1XsRDdl6HyiZZC3Dzk4uAkqCFwxB
        y9r/BH6A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33152)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1o86xT-0007fg-F0; Sun, 03 Jul 2022 22:16:47 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1o86xR-0001WG-As; Sun, 03 Jul 2022 22:16:45 +0100
Date:   Sun, 3 Jul 2022 22:16:45 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/14] arm: Rename PMD_ORDER to PMD_BITS
Message-ID: <YsIHPStHG84Ksu7m@shell.armlinux.org.uk>
References: <20220703141203.147893-1-rppt@kernel.org>
 <20220703211441.3981873-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220703211441.3981873-1-willy@infradead.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 03, 2022 at 10:14:41PM +0100, Matthew Wilcox (Oracle) wrote:
> This is the number of bits used by a PMD entry, not the order of a PMD.

No, it's not the number of bits. A PMD entry doesn't fit in 2 or 3 bits.
This is even more confusing.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
