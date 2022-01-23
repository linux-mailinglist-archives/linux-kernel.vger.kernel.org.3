Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 861F94972AD
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 16:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235183AbiAWPmc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 23 Jan 2022 10:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiAWPma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 10:42:30 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2C9C06173B;
        Sun, 23 Jan 2022 07:42:28 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7FAF8FF803;
        Sun, 23 Jan 2022 15:42:21 +0000 (UTC)
Date:   Sun, 23 Jan 2022 16:42:20 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Colin Ian King <colin.king@intel.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-wireless@vger.kernel.org (open list:BROADCOM SPECIFIC AMBA DRIVER
        (BCMA)),
        bcm-kernel-feedback-list@broadcom.com (open list:BROADCOM STB NAND
        FLASH DRIVER)
Subject: Re: [PATCH v3 0/9] BCMA support for brcmnand
Message-ID: <20220123164220.58f01b76@xps13>
In-Reply-To: <20220107184614.2670254-1-f.fainelli@gmail.com>
References: <20220107184614.2670254-1-f.fainelli@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

f.fainelli@gmail.com wrote on Fri,  7 Jan 2022 10:46:05 -0800:

> Hi all,
> 
> This patch series adds support for the BRCMNAND controller revision 3.4
> embedded in MIPS-based SoCs such as 5357, typically found in the Netgear
> WNR3500L v2 and other kinds of Wi-Fi routers. The upstream platform that
> uses this controller is under arch/mips/bcm47xx/ and does not use Device
> Tree (and probably never will by now). BCMA (Broadcom AMBA) is a special
> kind of discoverable memory mapped interface which requires the use of
> special accessors to read from/write to the hardware block.
> 
> The integration of brcmnand into that SoC is a bit quirky in that every
> register offering byte level data about the flash (OOB, device ID, etc.)
> requires byte swapping. The command shift should also have been 24, but
> is in fact 0, took me a while to understand why no reads were actually
> working because of that.
> 
> This has been tested with Linux 5.10.82 and Linus' master with OpenWrt
> and confirmed that the squashfs + jffs2 overlay that OpenWrt creates is
> entirely functional and that written data is made persistent.

Series applied on nand/next.

Thanks,
Miquèl
