Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6CB488CA5
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 22:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbiAIVpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 16:45:34 -0500
Received: from elvis.franken.de ([193.175.24.41]:38466 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232093AbiAIVpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 16:45:33 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1n6g0I-0006cw-00; Sun, 09 Jan 2022 22:45:30 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 7C771C0E31; Sun,  9 Jan 2022 22:43:08 +0100 (CET)
Date:   Sun, 9 Jan 2022 22:43:08 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-mips@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] MIPS: BCM47XX: Board updates from OpenWrt
Message-ID: <20220109214308.GA2174@alpha.franken.de>
References: <20220107035141.2325384-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107035141.2325384-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 07:51:36PM -0800, Florian Fainelli wrote:
> Hi all,
> 
> This patch is breaking up the larger patch that OpenWrt carries at:
> 
> https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=target/linux/bcm47xx/patches-5.10/320-MIPS-BCM47XX-Devices-database-update-for-4.x.patch;h=bde811c1956578a33cc230b80c3a2b4a20cd9aa5;hb=HEAD
> 
> into a series of patches that add support for each board individually.
> 
> Florian Fainelli (5):
>   MIPS: BCM47XX: Define Linksys WRT310N V2 buttons
>   MIPS: BCM47XX: Add board entry for Linksys WRT320N v1
>   MIPS: BCM47XX: Add LEDs and buttons for Asus RTN-10U
>   MIPS: BCM47XX: Add support for Netgear R6300 v1
>   MIPS: BCM47XX: Add support for Netgear WN2500RP v1 & v2
> 
>  arch/mips/bcm47xx/board.c                     |  4 ++
>  arch/mips/bcm47xx/buttons.c                   | 44 +++++++++++++++++++
>  arch/mips/bcm47xx/leds.c                      | 21 +++++++++
>  .../include/asm/mach-bcm47xx/bcm47xx_board.h  |  4 ++
>  4 files changed, 73 insertions(+)

series applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
