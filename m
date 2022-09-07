Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43CE5B04F8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 15:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiIGNP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 09:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiIGNPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 09:15:34 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B23B8048D;
        Wed,  7 Sep 2022 06:15:15 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1oVutd-0000YC-00; Wed, 07 Sep 2022 15:15:13 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 8E9DDC0DBF; Wed,  7 Sep 2022 15:02:20 +0200 (CEST)
Date:   Wed, 7 Sep 2022 15:02:20 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Alexander A Sverdlin <alexander.sverdlin@nokia.com>
Cc:     Yu Zhao <yuzhao@google.com>, Joe Perches <joe@perches.com>,
        linux-mips@vger.kernel.org, Corey Minyard <cminyard@mvista.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MIPS: octeon: Get rid of preprocessor directives
 around RESERVE32
Message-ID: <20220907130220.GA17817@alpha.franken.de>
References: <20220906083239.10163-1-alexander.sverdlin@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906083239.10163-1-alexander.sverdlin@nokia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 10:32:39AM +0200, Alexander A Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> 
> Some of them were pointless because CONFIG_CAVIUM_RESERVE32 is now always
> defined, some were not enough (Yu Zhao reported
> "Failed to allocate CAVIUM_RESERVE32 memory area" error).
> 
> Removing the directives allows for compiler coverage of RESERVE32 code and
> replacing one of [always-true] "ifdef" with a compiler conditional fixes
> the [cosmetic] error message.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> ---
> 
> Changelog:
> v2:
> * Reduced the scope of addr variable
> 
>  arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c |  4 ----
>  arch/mips/cavium-octeon/setup.c                    | 27 +++++++++-------------

applied to mips-fixes with

Fixes: 3e3114ac460e ("MIPS: Introduce CAVIUM_RESERVE32 Kconfig option")

added.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
