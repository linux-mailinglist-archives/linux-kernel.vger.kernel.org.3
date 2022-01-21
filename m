Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12964495C7C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 10:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379653AbiAUJEC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 21 Jan 2022 04:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240373AbiAUJD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 04:03:59 -0500
X-Greylist: delayed 83 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 21 Jan 2022 01:03:59 PST
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5F3C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 01:03:58 -0800 (PST)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9D7931C000D;
        Fri, 21 Jan 2022 09:03:56 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Marek =?utf-8?Q?Beh?= =?utf-8?Q?=C3=BAn?= <kabel@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: armada-3720-turris-mox: Add missing
 ethernet0 alias
In-Reply-To: <20220117182006.31412-1-pali@kernel.org>
References: <20220117182006.31412-1-pali@kernel.org>
Date:   Fri, 21 Jan 2022 10:03:56 +0100
Message-ID: <875yqd5ukj.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pali Rohár <pali@kernel.org> writes:

> U-Boot uses ethernet* aliases for setting MAC addresses. Therefore define
> also alias for ethernet0.
>
> Fixes: 7109d817db2e ("arm64: dts: marvell: add DTS for Turris Mox")
> Signed-off-by: Pali Rohár <pali@kernel.org>

Applied on mvebu/fixes

Thanks,

Gregory


> ---
>  arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> index 23e1b07c060a..6581092c2c90 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> @@ -18,6 +18,7 @@
>  
>  	aliases {
>  		spi0 = &spi0;
> +		ethernet0 = &eth0;
>  		ethernet1 = &eth1;
>  		mmc0 = &sdhci0;
>  		mmc1 = &sdhci1;
> -- 
> 2.20.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
