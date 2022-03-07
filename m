Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20EFC4CFE52
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 13:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242229AbiCGM0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 07:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242136AbiCGM0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:26:19 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 159AF80925;
        Mon,  7 Mar 2022 04:25:25 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nRCQS-00072o-01; Mon, 07 Mar 2022 13:25:20 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 131ABC1280; Mon,  7 Mar 2022 13:20:40 +0100 (CET)
Date:   Mon, 7 Mar 2022 13:20:40 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        kernel test robot <lkp@intel.com>,
        Paul Burton <paulburton@kernel.org>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v3] mips: DEC: honor CONFIG_MIPS_FP_SUPPORT=n
Message-ID: <20220307122039.GB14422@alpha.franken.de>
References: <20220304162427.27276-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304162427.27276-1-rdunlap@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 08:24:27AM -0800, Randy Dunlap wrote:
> Include the DECstation interrupt handler in opting out of
> FPU support.
> 
> Fixes a linker error:
> 
> mips-linux-ld: arch/mips/dec/int-handler.o: in function `fpu':
> (.text+0x148): undefined reference to `handle_fpe_int'
> 
> Fixes: 183b40f992c8 ("MIPS: Allow FP support to be disabled")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Maciej W. Rozycki <macro@orcam.me.uk>
> Cc: linux-mips@vger.kernel.org
> ---
> v2: add another ifdef block in int-handler.S; (Maciej)
>     add an ifdef block in dec/setup.c; (Maciej)
> v3: use IS_ENABLED() instead of an ifdef block in dec/setup.c; (Maciej)
> 
>  arch/mips/dec/int-handler.S |    6 +++---
>  arch/mips/dec/setup.c       |    3 ++-
>  2 files changed, 5 insertions(+), 4 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
