Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D03D577672
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 15:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbiGQNtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 09:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGQNtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 09:49:47 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0520BCE2F;
        Sun, 17 Jul 2022 06:49:45 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1oD4eV-0005M5-00; Sun, 17 Jul 2022 15:49:43 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 0850DC0181; Sun, 17 Jul 2022 15:49:33 +0200 (CEST)
Date:   Sun, 17 Jul 2022 15:49:32 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-mips@vger.kernel.org,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] MIPS: BMIPS: Improved early panic support
Message-ID: <20220717134932.GA17494@alpha.franken.de>
References: <20220715213747.111321-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715213747.111321-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 02:37:45PM -0700, Florian Fainelli wrote:
> Hi Thomas,
> 
> This patch series adds support for cfe_die() which can be used during
> early platform initialization when we do not yet have a valid DTB to
> infer an earlycon console from. This is useful while bringing up new
> platforms/DTBs as well.
> 
> Thanks!
> 
> Changes in v2:
> 
> - ensure that we do not break multi-CPU builds by reading the CPU's PrID
>   to perform the appropriate XKS01 disabling before handing over to CFE
> 
> Florian Fainelli (2):
>   MIPS: CFE: Add cfe_die()
>   MIPS: BMIPS: Utilize cfe_die() for invalid DTB
> 
>  arch/mips/Kconfig                      |  1 +
>  arch/mips/bmips/setup.c                | 14 +++++-
>  arch/mips/fw/cfe/cfe_api.c             | 68 +++++++++++++++++++++++++-
>  arch/mips/include/asm/fw/cfe/cfe_api.h |  2 +
>  4 files changed, 83 insertions(+), 2 deletions(-)

series applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
