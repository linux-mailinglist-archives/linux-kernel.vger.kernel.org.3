Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF6751AF3E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378081AbiEDUgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237273AbiEDUgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:36:31 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3729E4FC79;
        Wed,  4 May 2022 13:32:53 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nmLg4-0003MI-00; Wed, 04 May 2022 22:32:52 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 37D00C01D0; Wed,  4 May 2022 22:28:42 +0200 (CEST)
Date:   Wed, 4 May 2022 22:28:42 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH] MIPS: fix typos in comments
Message-ID: <20220504202842.GC23391@alpha.franken.de>
References: <20220430190310.7566-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220430190310.7566-1-Julia.Lawall@inria.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2022 at 09:03:10PM +0200, Julia Lawall wrote:
> Various spelling mistakes in comments.
> Detected with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  arch/mips/alchemy/common/dbdma.c                 |    2 +-
>  arch/mips/cavium-octeon/executive/cvmx-bootmem.c |    2 +-
>  arch/mips/cavium-octeon/executive/cvmx-pko.c     |    2 +-
>  arch/mips/cavium-octeon/octeon-irq.c             |    2 +-
>  arch/mips/cavium-octeon/octeon-usb.c             |    2 +-
>  arch/mips/dec/ioasic-irq.c                       |    4 ++--
>  arch/mips/dec/setup.c                            |    2 +-
>  arch/mips/fw/arc/memory.c                        |    2 +-
>  arch/mips/jazz/irq.c                             |    2 +-
>  arch/mips/kernel/cmpxchg.c                       |    2 +-
>  arch/mips/kernel/cpu-probe.c                     |    2 +-
>  arch/mips/kernel/idle.c                          |    2 +-
>  arch/mips/kernel/perf_event_mipsxx.c             |    2 +-
>  arch/mips/kvm/tlb.c                              |    2 +-
>  arch/mips/net/bpf_jit_comp32.c                   |    2 +-
>  arch/mips/pci/pcie-octeon.c                      |    2 +-
>  arch/mips/pic32/pic32mzda/config.c               |    2 +-
>  arch/mips/tools/loongson3-llsc-check.c           |    2 +-
>  arch/mips/txx9/generic/pci.c                     |    2 +-
>  19 files changed, 20 insertions(+), 20 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
