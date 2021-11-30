Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 408F8463F88
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 21:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343890AbhK3U76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 15:59:58 -0500
Received: from soltyk.jannau.net ([144.76.91.90]:49970 "EHLO soltyk.jannau.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343817AbhK3U7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 15:59:05 -0500
Received: by soltyk.jannau.net (Postfix, from userid 1000)
        id 5C4AB261BA6; Tue, 30 Nov 2021 21:55:28 +0100 (CET)
Date:   Tue, 30 Nov 2021 21:55:28 +0100
From:   Janne Grunau <j@jannau.net>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] watchdog: Add Apple SoC watchdog driver
Message-ID: <20211130205528.GC28130@jannau.net>
References: <20211130161809.64591-1-sven@svenpeter.dev>
 <20211130161809.64591-2-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130161809.64591-2-sven@svenpeter.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hej,

On 2021-11-30 17:18:09 +0100, Sven Peter wrote:
> Add support for the watchdog timer found in Apple SoCs. This driver is
> also required to reboot these machines.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
> v1 -> v2:
>  - set the default timeout to 30s and call watchdog_init_timeout
>    to allow the device tree to override it
>  - set WDOG_HW_RUNNING if the watchdog is enabled at boot
>  - check that the clock rate is not zero
>  - use unsigned long instead of u32 for clk_rate
>  - use devm_add_action_or_reset instead of manually calling
>    clk_disable_unprepare
>  - explain the magic number in apple_wdt_restart
> 
>  MAINTAINERS                  |   1 +
>  drivers/watchdog/Kconfig     |  12 ++
>  drivers/watchdog/Makefile    |   1 +
>  drivers/watchdog/apple_wdt.c | 226 +++++++++++++++++++++++++++++++++++
>  4 files changed, 240 insertions(+)
>  create mode 100644 drivers/watchdog/apple_wdt.c

Tested on M1 and M1 Max. Feel free to add
Tested-by: Janne Grunau <j@jannau.net>

best
Janne
