Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B36576140
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 14:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbiGOMZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 08:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbiGOMZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 08:25:54 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53967814AF;
        Fri, 15 Jul 2022 05:25:53 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1oCKOG-00082w-01; Fri, 15 Jul 2022 14:25:52 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id D46CCC054D; Fri, 15 Jul 2022 14:24:58 +0200 (CEST)
Date:   Fri, 15 Jul 2022 14:24:58 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-mips@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: BCM47XX: Add support for Netgear WNR3500L v2
Message-ID: <20220715122458.GB2705@alpha.franken.de>
References: <20220714211302.1391015-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714211302.1391015-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 02:13:01PM -0700, Florian Fainelli wrote:
> Add support for the Netgear WNR3500L v2 router based on the BCM47186
> chipset and supporting 802.11n Wi-Fi.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/mips/bcm47xx/board.c                          |  2 ++
>  arch/mips/bcm47xx/buttons.c                        | 10 ++++++++++
>  arch/mips/bcm47xx/leds.c                           | 11 +++++++++++
>  arch/mips/bcm47xx/workarounds.c                    |  1 +
>  arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h |  1 +
>  5 files changed, 25 insertions(+)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
