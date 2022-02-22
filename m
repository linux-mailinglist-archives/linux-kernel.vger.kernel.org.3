Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA874BF408
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 09:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiBVIsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 03:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiBVIsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 03:48:13 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28B00BA75D;
        Tue, 22 Feb 2022 00:47:48 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nMQpn-0001CP-04; Tue, 22 Feb 2022 09:47:47 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 2DDFBC2609; Tue, 22 Feb 2022 09:47:14 +0100 (CET)
Date:   Tue, 22 Feb 2022 09:47:14 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] MIPS: Constify static irq_domain_ops structs
Message-ID: <20220222084714.GB7123@alpha.franken.de>
References: <20220207211816.57860-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207211816.57860-1-rikard.falkeborn@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 10:18:13PM +0100, Rikard Falkeborn wrote:
> Constify a number of static irq_domain_ops structs that were never
> modified. This allows the compiler to put them in read-only memory.
> 
> Rikard Falkeborn (3):
>   MIPS: OCTEON: Constify static irq_domain_ops
>   MIPS: ath25: Constify static irq_domain_ops
>   MIPS: pci-ar2315: Constify static irq_domain_ops
> 
>  arch/mips/ath25/ar2315.c             |  2 +-
>  arch/mips/ath25/ar5312.c             |  2 +-
>  arch/mips/cavium-octeon/octeon-irq.c | 10 +++++-----
>  arch/mips/pci/pci-ar2315.c           |  2 +-
>  4 files changed, 8 insertions(+), 8 deletions(-)

series applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
