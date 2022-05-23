Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72235531AFE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238796AbiEWQ3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238699AbiEWQ3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:29:00 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E0095DA08;
        Mon, 23 May 2022 09:28:59 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1ntAvS-0003hj-00; Mon, 23 May 2022 18:28:58 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 20388C0312; Mon, 23 May 2022 18:28:45 +0200 (CEST)
Date:   Mon, 23 May 2022 18:28:45 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        "open list:BROADCOM BMIPS MIPS ARCHITECTURE" 
        <linux-mips@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] MIPS: bmips: Fix compiler warning observed on W=1
 build
Message-ID: <20220523162845.GA10839@alpha.franken.de>
References: <20220523121639.16521-1-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523121639.16521-1-jim2101024@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 08:16:39AM -0400, Jim Quinlan wrote:
> The function arch_sync_dma_for_cpu_all() was used but was
> missing a prototype declaration.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  arch/mips/bmips/dma.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/mips/bmips/dma.c b/arch/mips/bmips/dma.c
> index c535f9cb75ec..33788668cbdb 100644
> --- a/arch/mips/bmips/dma.c
> +++ b/arch/mips/bmips/dma.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  
>  #include <linux/types.h>
> +#include <linux/dma-map-ops.h>
>  #include <asm/bmips.h>
>  #include <asm/io.h>
>  
> 
> base-commit: 4b0986a3613c92f4ec1bdc7f60ec66fea135991f
> -- 
> 2.17.1

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
