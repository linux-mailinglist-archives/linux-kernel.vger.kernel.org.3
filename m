Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6555C5549B7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243685AbiFVKHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 06:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbiFVKHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:07:42 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6455113DDE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 03:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZMGIuvzIQpIqTXJulSXmo+KCl8Gz0aVA91iXdppYFBA=; b=rUMHSpE2Zkccqo4vpVL52BGTn/
        axLvfuou033eWjpeuG6uwnEe458PPgjEbf4coP4EXOrWI85GVFeOlBXavRvIhTQsp4GkG1I7Fq/Lc
        whjD/EHhUXUcQFZeqnu3NvF5/fre/K7k2w1txWS8GV3E4FYg0bmA7S5e//4gMee144DfuACbIEVkQ
        zd27D3IDEcW4lBkYZDE5+vfbYpKd+FXNIg2riVF24C+HOzgBn3hcOYFt2zEJlhQdbbEf0PSOp1yh1
        uVF5I2i07V7vLCD28a34bSLEkfPA2fUVxqKwC6kS59SDU7xVZQscnBPkhMr0lKvPYveMBJUqmJ2KU
        X4xsm+QA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:32976)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1o3xGZ-0003NJ-LI; Wed, 22 Jun 2022 11:07:19 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1o3xGV-0007KF-9R; Wed, 22 Jun 2022 11:07:15 +0100
Date:   Wed, 22 Jun 2022 11:07:15 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        joey.gouly@arm.com, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64:kernel:Fix typo in comment
Message-ID: <YrLp080GdA2S/NBU@shell.armlinux.org.uk>
References: <20220622091951.53449-1-yuanjilin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622091951.53449-1-yuanjilin@cdjrlc.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 05:19:51PM +0800, Jilin Yuan wrote:
> Delete the redundant word 'ARM'.

NAK. This patch is not appropriate.

"ARM" refers to Arm Ltd (using their old capitalisation) _and_ it also
refers to the _A_rchitecture _R_eferene _M_anual. So, "ARM ARM" is never
a typo anywhere in the kernel.

The only possible fixup would be to convert the _first_ "ARM" to be
"Arm" to follow the company's marketing whims, but we don't generally
go around updating stuff like that in the kernel unless other changes
are being made in that area or there is a real pressing need.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
