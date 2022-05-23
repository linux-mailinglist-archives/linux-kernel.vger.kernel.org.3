Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33EB530DD8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbiEWJbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbiEWJbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:31:05 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53AB61115F;
        Mon, 23 May 2022 02:30:59 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nt4Or-0001Pn-03; Mon, 23 May 2022 11:30:53 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 60FB5C02F4; Mon, 23 May 2022 11:17:21 +0200 (CEST)
Date:   Mon, 23 May 2022 11:17:21 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Stijn Tintel <stijn@linux-ipv6.be>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Octeon: add SNIC10E board
Message-ID: <20220523091721.GD5069@alpha.franken.de>
References: <20220518164810.2432678-1-stijn@linux-ipv6.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518164810.2432678-1-stijn@linux-ipv6.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 07:48:10PM +0300, Stijn Tintel wrote:
> The CN6640-SNIC10E-G and CN6640-SNIC10E-1.1-G PCIe NICs are based on
> this board.
> 
> Signed-off-by: Stijn Tintel <stijn@linux-ipv6.be>
> ---
>  arch/mips/include/asm/octeon/cvmx-bootinfo.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/mips/include/asm/octeon/cvmx-bootinfo.h b/arch/mips/include/asm/octeon/cvmx-bootinfo.h
> index 6c61e0a63924..c1c0b3230e0a 100644
> --- a/arch/mips/include/asm/octeon/cvmx-bootinfo.h
> +++ b/arch/mips/include/asm/octeon/cvmx-bootinfo.h
> @@ -253,6 +253,7 @@ enum cvmx_board_types_enum {
>  	CVMX_BOARD_TYPE_REDWING = 43,
>  	CVMX_BOARD_TYPE_NIC68_4 = 44,
>  	CVMX_BOARD_TYPE_NIC10E_66 = 45,
> +	CVMX_BOARD_TYPE_SNIC10E = 50,
>  	CVMX_BOARD_TYPE_MAX,
>  
>  	/*
> @@ -369,6 +370,7 @@ static inline const char *cvmx_board_type_to_string(enum
>  		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_REDWING)
>  		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_NIC68_4)
>  		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_NIC10E_66)
> +		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_SNIC10E)
>  		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_MAX)
>  
>  			/* Customer boards listed here */
> -- 
> 2.35.1

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
