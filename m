Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF40355495E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357438AbiFVLXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 07:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357666AbiFVLXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 07:23:00 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38503BCA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 04:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gBvjMbdEB4HXFwJi1iuHH2rwe1oTYPzLNlq/O6a44Mw=; b=KEXAQ4gcyIjngK2ACI3vf3Z0wD
        PLkKeRujy7fvjZkfOBunIRJpANIeMgoU/E84QdpvA+dbT47Z1KeAt0kTbO9KIgdjr6vBxDH3EJf4e
        hVs2/L3g62cUeLVtRl8FyoICxGWSwTJaOMNhSCbncNv6TqU20byl7+I1//T4rfArat5G7Wcvqc+lM
        /eZIkHSVuFERNFcIMbNDVzlDPbCyNZf6Qq2zNU24swlUnsT6NiSz+dlNbIaRTJYMjcRZ0S9tUj3pH
        SHIng1WUY5uAPizAvvhl4375y4EkDaKvO2IX2XrQYXSOSEgLHUS/qEf2Ew4cG4WsHYyOHzz1f/Opq
        HExzCXFA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:32980)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1o3yRf-0003T1-6b; Wed, 22 Jun 2022 12:22:50 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1o3yRa-0007Nt-3z; Wed, 22 Jun 2022 12:22:46 +0100
Date:   Wed, 22 Jun 2022 12:22:46 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     mark.rutland@arm.com, mcgrof@kernel.org, paulmck@kernel.org,
        akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm:mm:Fix typo in comment
Message-ID: <YrL7hhhDawm8PL4Q@shell.armlinux.org.uk>
References: <20220622085252.31387-1-yuanjilin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622085252.31387-1-yuanjilin@cdjrlc.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 04:52:52PM +0800, Jilin Yuan wrote:
> Delete the redundant word 'ARM'.

NAK. "ARM ARM" is not a typo. Please never report any of these in
future. Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
