Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723B5530D68
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbiEWJbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbiEWJa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:30:57 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6BEF749908;
        Mon, 23 May 2022 02:30:56 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nt4Or-0001Pn-01; Mon, 23 May 2022 11:30:53 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id C3125C02F4; Mon, 23 May 2022 11:16:28 +0200 (CEST)
Date:   Mon, 23 May 2022 11:16:28 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Octeon: fix typo in comment
Message-ID: <20220523091628.GB5069@alpha.franken.de>
References: <20220521111145.81697-65-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521111145.81697-65-Julia.Lawall@inria.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 01:11:15PM +0200, Julia Lawall wrote:
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  arch/mips/pci/pcie-octeon.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/pci/pcie-octeon.c b/arch/mips/pci/pcie-octeon.c
> index 50a3394a9d25..c9edd3fb380d 100644
> --- a/arch/mips/pci/pcie-octeon.c
> +++ b/arch/mips/pci/pcie-octeon.c
> @@ -895,7 +895,7 @@ static int __cvmx_pcie_rc_initialize_gen1(int pcie_port)
>  	mem_access_subid.s.nsw = 0;	/* Enable Snoop for Writes. */
>  	mem_access_subid.s.ror = 0;	/* Disable Relaxed Ordering for Reads. */
>  	mem_access_subid.s.row = 0;	/* Disable Relaxed Ordering for Writes. */
> -	mem_access_subid.s.ba = 0;	/* PCIe Adddress Bits <63:34>. */
> +	mem_access_subid.s.ba = 0;	/* PCIe Address Bits <63:34>. */
>  
>  	/*
>  	 * Setup mem access 12-15 for port 0, 16-19 for port 1,

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
