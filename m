Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D176147A578
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 08:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237750AbhLTHqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 02:46:20 -0500
Received: from mail.thorsis.com ([92.198.35.195]:39931 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229680AbhLTHqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 02:46:19 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.thorsis.com (Postfix) with ESMTP id 240F9144D;
        Mon, 20 Dec 2021 08:46:18 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.thorsis.com
Received: from mail.thorsis.com ([127.0.0.1])
        by localhost (mail.thorsis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qpMcXO4EMgae; Mon, 20 Dec 2021 08:46:18 +0100 (CET)
Received: by mail.thorsis.com (Postfix, from userid 109)
        id E3DFF10F5; Mon, 20 Dec 2021 08:46:17 +0100 (CET)
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NO_RECEIVED,
        NO_RELAYS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.2
X-Spam-Report: * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        * -0.0 NO_RELAYS Informational: message was not relayed via SMTP
        *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: microchip.com]
        * -0.0 NO_RECEIVED Informational: message has no Received headers
Date:   Mon, 20 Dec 2021 08:46:03 +0100
From:   Alexander Dahl <ada@thorsis.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, robh+dt@kernel.org,
        linux@armlinux.org.uk, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] ARM: configs: at91: sama7: enable cpu idle
Message-ID: <YcA0uxt8O/kO3Bo5@ada-deb-carambola.ifak-system.com>
Mail-Followup-To: Claudiu Beznea <claudiu.beznea@microchip.com>,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, robh+dt@kernel.org,
        linux@armlinux.org.uk, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211216141338.35144-1-claudiu.beznea@microchip.com>
 <20211216141338.35144-8-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216141338.35144-8-claudiu.beznea@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Claudiu,

Am Thu, Dec 16, 2021 at 04:13:37PM +0200 schrieb Claudiu Beznea:
> Enable CPU idle support for SAMA7 config.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  arch/arm/configs/sama7_defconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
> index 938aae4bd80b..95c2a7ed4816 100644
> --- a/arch/arm/configs/sama7_defconfig
> +++ b/arch/arm/configs/sama7_defconfig
> @@ -26,6 +26,7 @@ CONFIG_FORCE_MAX_ZONEORDER=15
>  CONFIG_UACCESS_WITH_MEMCPY=y
>  # CONFIG_ATAGS is not set
>  CONFIG_CMDLINE="console=ttyS0,115200 earlyprintk ignore_loglevel"
> +CONFIG_CPU_IDLE=y
>  CONFIG_VFP=y
>  CONFIG_NEON=y
>  CONFIG_KERNEL_MODE_NEON=y
> @@ -33,7 +34,6 @@ CONFIG_MODULES=y
>  CONFIG_MODULE_FORCE_LOAD=y
>  CONFIG_MODULE_UNLOAD=y
>  CONFIG_MODULE_FORCE_UNLOAD=y
> -# CONFIG_BLK_DEV_BSG is not set
>  CONFIG_PARTITION_ADVANCED=y
>  # CONFIG_EFI_PARTITION is not set
>  # CONFIG_COREDUMP is not set
> @@ -90,6 +90,7 @@ CONFIG_BLK_DEV_RAM_SIZE=8192
>  CONFIG_EEPROM_AT24=y
>  CONFIG_SCSI=y
>  CONFIG_BLK_DEV_SD=y
> +# CONFIG_BLK_DEV_BSG is not set

That move of the CONFIG_BLK_DEV_BSG entry is not related to enabling
the CONFIG_CPU_IDLE option, right?

Greets
Alex

>  CONFIG_NETDEVICES=y
>  CONFIG_MACB=y
>  CONFIG_MICREL_PHY=y
> -- 
> 2.32.0
> 
