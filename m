Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6426A515F49
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 18:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383140AbiD3QjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 12:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383169AbiD3QjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 12:39:02 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2B018B18
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 09:35:37 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1nkq45-00087w-AY; Sat, 30 Apr 2022 18:35:25 +0200
Date:   Sat, 30 Apr 2022 17:35:15 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        John Crispin <blogic@openwrt.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm: mediatek: select arch timer for mt7623
Message-ID: <Ym1lQ/4WHmWYEBX+@makrotopia.org>
References: <20220430162748.535317-1-gch981213@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220430162748.535317-1-gch981213@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 01, 2022 at 12:27:48AM +0800, Chuanhong Guo wrote:
> armv7 arch timer is required on this platform for a functional system
> clock. Select HAVA_ARM_ARCH_TIMER for MT7623.
Typo: HAVA_ARM_ARCH_TIMER should be HAVE_ARM_ARCH_TIMER.

Otherise:
Acked-by: Daniel Golle <daniel@makrotopia.org>
> 
> Fixes: 31ac0d69a1d4 ("ARM: dts: mediatek: add MT7623 basic support")
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> ---
>  arch/arm/mach-mediatek/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
> index 35a3430c7942..8a8d9142260a 100644
> --- a/arch/arm/mach-mediatek/Kconfig
> +++ b/arch/arm/mach-mediatek/Kconfig
> @@ -26,6 +26,7 @@ config MACH_MT6592
>  config MACH_MT7623
>  	bool "MediaTek MT7623 SoCs support"
>  	default ARCH_MEDIATEK
> +	select HAVE_ARM_ARCH_TIMER
>  
>  config MACH_MT7629
>  	bool "MediaTek MT7629 SoCs support"
> -- 
> 2.35.1
> 
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
