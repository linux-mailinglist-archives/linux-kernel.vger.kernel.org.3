Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FEA5278B0
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 18:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237629AbiEOQDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 12:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbiEOQDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 12:03:50 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768511EC5D
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 09:03:49 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id DB0A85C0121;
        Sun, 15 May 2022 12:03:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 15 May 2022 12:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1652630628; x=
        1652717028; bh=A+Z6uQVNDpQfDaY0iiQ+fbaP7QdS6F3+IaNBU9dAM3Q=; b=D
        +z2nCfO3F8Qfqlmlb+9WWZTxn283R11k+i8OnH7NOGhJWh6nQt0wIPIi/q9UsMfw
        6SsdA/MHwak0E8QlRmvyZfEdW0V/yu/wJBGa4H3z4goJd5ar0wvIrGzM2CZJOEZa
        7BFhyv5Y7w+zntdtvgtJhjk2k0H6fBmUOpHKPYYq2bALg331zySSFIdEJFuXL/wx
        1ocjidVItT43gtPSMxOThU8xG+wek/p52HGCpTYrxmfKc68oUIBFFfn66LdXjhtX
        f794oiusRZ1TGkXRx6kwLiBHqISshhOblwjN4bBjj6sXo5vv6gifsYZdE5arDayD
        S/fhVybVAC0iMmHr8FFng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1652630628; x=1652717028; bh=A+Z6uQVNDpQfD
        aY0iiQ+fbaP7QdS6F3+IaNBU9dAM3Q=; b=rxNOpCNw1fnzU9vOIiLFgHPmSkbHf
        QhG1A2DKhpfABX4G5HkpDADEh9KLKopSGkKJLMD7fpWa1aNRSYjiLIpFbnrqbBt1
        n7Bov9sUAXXuRcgItGMDfj5PANrEuXVYPECznv2rTr1UGm0lBh59L6gAhtduHk1m
        KL2rXYhOm8bWNIRejetL8/+ki72OkgdbqpiztY6t3exqP6k7FbSfQsCHSoYuOnMU
        I6cNxfyQb5rCKpp/YGUoXLJHkIasHSj8nOuoQGlSO2gCdvpucHNdNNp5MkH1voOM
        x9lcpdM9Gu24rmoHvZXHk/VbZgGNTlSXZUlcTpkpc+Tt7HP8esM+xZZ6g==
X-ME-Sender: <xms:ZCSBYn8c0K3KLGPTpzUdgF0Zn1QYT-N_eOL89Fckawlai5OKiIOggw>
    <xme:ZCSBYjtYQKrn8vPchqYSi-jYrCQ_7dEAevKTwz10RcbY24lOBef_w1XR1urVBlO_c
    vfLx7SQyhJoN62qwg>
X-ME-Received: <xmr:ZCSBYlDrbsS7ksiucVds1o_Rgjewu_qU_gRReuxRKjSq1O5RjcpOBix1Kx3sPseU5NKE2h2ybRak_AB9UxzvwLQAJqE9gdakzozz9bP51_wBL9mbtHu2MvxgLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrheefgdelhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfevfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgfetffefteehkeduieffhfevhfffiefhieekffefjedtgeelleeg
    tefftdfgteefnecuffhomhgrihhnpehhvggrugdrshgsnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdr
    ohhrgh
X-ME-Proxy: <xmx:ZCSBYjd9R91ejSK-ODuir8ZRrYhk1x4ci2ETJtsnp5oEvD0oFhyCSA>
    <xmx:ZCSBYsN-585JVmeItOCXMHh14rYI1fR3gW6RZu7RsuyT2KwJkCazuQ>
    <xmx:ZCSBYlnHHovFUQL7DfayvlirLTaSdpTGJm01WheV1QGw97fBHiRRmQ>
    <xmx:ZCSBYhpfTQmWE7weQh3BgDKoUcs1gOOqgemzfrJD-aq0JB9-VfS_ew>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 May 2022 12:03:47 -0400 (EDT)
Subject: Re: [PATCH 02/13] openrisc: Cleanup emergency print handling
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Openrisc <openrisc@lists.librecores.org>,
        Randy Dunlap <rdunlap@infradead.org>
References: <20220515124158.3167452-1-shorne@gmail.com>
 <20220515124158.3167452-3-shorne@gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <7b18962e-d1ce-699f-dd59-719255f19ade@sholland.org>
Date:   Sun, 15 May 2022 11:03:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220515124158.3167452-3-shorne@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stafford,

On 5/15/22 7:41 AM, Stafford Horne wrote:
> The emergency print support only works for 8250 compatible serial ports.
> Now that OpenRISC platforms may be configured with different serial port
> hardware we don't want emergency print to try to print to non-existent
> hardware which will cause lockups.
> 
> This patch contains several fixes to get emergency print working again:
> 
>  - Update symbol loading to not assume the location of symbols
>  - Split the putc print operation out to its own function to allow
>    for different future implementations.
>  - Update _emergency_print_nr and _emergency_print to use the putc
>    function.
>  - Guard serial 8250 specific sequences by CONFIG_SERIAL_8250
>  - Update string line feed from lf,cr to cr,lf.
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  arch/openrisc/kernel/head.S | 148 +++++++++++++++++++++---------------
>  1 file changed, 85 insertions(+), 63 deletions(-)
> 
> diff --git a/arch/openrisc/kernel/head.S b/arch/openrisc/kernel/head.S
> index 15f1b38dfe03..b1f3a65c271c 100644
> --- a/arch/openrisc/kernel/head.S
> +++ b/arch/openrisc/kernel/head.S
> @@ -297,19 +297,23 @@
>  	/* temporary store r3, r9 into r1, r10 */		;\
>  	l.addi	r1,r3,0x0					;\
>  	l.addi	r10,r9,0x0					;\
> -	/* the string referenced by r3 must be low enough */	;\
> +	LOAD_SYMBOL_2_GPR(r9,_string_unhandled_exception)	;\
> +	tophys	(r3,r9)						;\
>  	l.jal	_emergency_print				;\
> -	l.ori	r3,r0,lo(_string_unhandled_exception)		;\
> +	 l.nop							;\
>  	l.mfspr	r3,r0,SPR_NPC					;\
>  	l.jal	_emergency_print_nr				;\
> -	l.andi	r3,r3,0x1f00					;\
> -	/* the string referenced by r3 must be low enough */	;\
> +	 l.andi	r3,r3,0x1f00					;\
> +	LOAD_SYMBOL_2_GPR(r9,_string_epc_prefix)		;\
> +	tophys	(r3,r9)						;\
>  	l.jal	_emergency_print				;\
> -	l.ori	r3,r0,lo(_string_epc_prefix)			;\
> +	 l.nop							;\
>  	l.jal	_emergency_print_nr				;\
> -	l.mfspr	r3,r0,SPR_EPCR_BASE				;\
> +	 l.mfspr r3,r0,SPR_EPCR_BASE				;\
> +	LOAD_SYMBOL_2_GPR(r9,_string_nl)			;\
> +	tophys	(r3,r9)						;\
>  	l.jal	_emergency_print				;\
> -	l.ori	r3,r0,lo(_string_nl)				;\
> +	 l.nop							;\
>  	/* end of printing */					;\
>  	l.addi	r3,r1,0x0					;\
>  	l.addi	r9,r10,0x0					;\
> @@ -1530,65 +1534,99 @@ trampoline_out:
>  	l.jr	r9
>  	l.nop
>  
> -
>  /*
> - * DSCR: prints a string referenced by r3.
> + * DESC: Prints ASCII character stored in r7
>   *
> - * PRMS: r3     	- address of the first character of null
> - *			terminated string to be printed
> + * PRMS: r7	- a 32-bit value with an ASCII character in the first byte
> + *		position.
>   *
> - * PREQ: UART at UART_BASE_ADD has to be initialized
> + * PREQ: The UART at UART_BASE_ADD has to be initialized
>   *
> - * POST: caller should be aware that r3, r9 are changed
> + * POST: internally used but restores:
> + * 	 r4	- to store UART_BASE_ADD
> + *	 r5	- for loading OFF_TXFULL / THRE,TEMT
> + *	 r6	- for storing bitmask (SERIAL_8250)
>   */
> -ENTRY(_emergency_print)
> +ENTRY(_emergency_putc)
>  	EMERGENCY_PRINT_STORE_GPR4
>  	EMERGENCY_PRINT_STORE_GPR5
>  	EMERGENCY_PRINT_STORE_GPR6
> -	EMERGENCY_PRINT_STORE_GPR7
> -2:
> -	l.lbz	r7,0(r3)
> -	l.sfeq	r7,r0
> -	l.bf	9f
> -	l.nop
>  
> -// putc:
>  	l.movhi r4,hi(UART_BASE_ADD)
> +	l.ori	r4,r4,lo(UART_BASE_ADD)
>  
> +#elif defined(CONFIG_SERIAL_8250)

This needs to use #if in this patch (and #elif in the next patch).

Regards,
Samuel

> +	/* Check UART LSR THRE (hold) bit */
>  	l.addi  r6,r0,0x20
>  1:      l.lbz   r5,5(r4)
>  	l.andi  r5,r5,0x20
>  	l.sfeq  r5,r6
>  	l.bnf   1b
> -	l.nop
> +	 l.nop
>  
> +	/* Write character */
>  	l.sb    0(r4),r7
>  
> +	/* Check UART LSR THRE|TEMT (hold, empty) bits */
>  	l.addi  r6,r0,0x60
>  1:      l.lbz   r5,5(r4)
>  	l.andi  r5,r5,0x60
>  	l.sfeq  r5,r6
>  	l.bnf   1b
> -	l.nop
> +	 l.nop
> +#endif
> +	EMERGENCY_PRINT_LOAD_GPR6
> +	EMERGENCY_PRINT_LOAD_GPR5
> +	EMERGENCY_PRINT_LOAD_GPR4
> +	l.jr	r9
> +	 l.nop
> +
> +/*
> + * DSCR: prints a string referenced by r3.
> + *
> + * PRMS: r3     	- address of the first character of null
> + *			terminated string to be printed
> + *
> + * PREQ: UART at UART_BASE_ADD has to be initialized
> + *
> + * POST: caller should be aware that r3, r9 are changed
> + */
> +ENTRY(_emergency_print)
> +	EMERGENCY_PRINT_STORE_GPR7
> +	EMERGENCY_PRINT_STORE_GPR9
> +
> +	/* Load character to r7, check for null terminator */
> +2:	l.lbz	r7,0(r3)
> +	l.sfeqi	r7,0x0
> +	l.bf	9f
> +	 l.nop
> +
> +	l.jal	_emergency_putc
> +	 l.nop
>  
>  	/* next character */
>  	l.j	2b
> -	l.addi	r3,r3,0x1
> +	 l.addi	r3,r3,0x1
>  
>  9:
> +	EMERGENCY_PRINT_LOAD_GPR9
>  	EMERGENCY_PRINT_LOAD_GPR7
> -	EMERGENCY_PRINT_LOAD_GPR6
> -	EMERGENCY_PRINT_LOAD_GPR5
> -	EMERGENCY_PRINT_LOAD_GPR4
>  	l.jr	r9
> -	l.nop
> +	 l.nop
>  
> +/*
> + * DSCR: prints a number in r3 in hex.
> + *
> + * PRMS: r3     	- a 32-bit unsigned integer
> + *
> + * PREQ: UART at UART_BASE_ADD has to be initialized
> + *
> + * POST: caller should be aware that r3, r9 are changed
> + */
>  ENTRY(_emergency_print_nr)
> -	EMERGENCY_PRINT_STORE_GPR4
> -	EMERGENCY_PRINT_STORE_GPR5
> -	EMERGENCY_PRINT_STORE_GPR6
>  	EMERGENCY_PRINT_STORE_GPR7
>  	EMERGENCY_PRINT_STORE_GPR8
> +	EMERGENCY_PRINT_STORE_GPR9
>  
>  	l.addi	r8,r0,32		// shift register
>  
> @@ -1600,58 +1638,39 @@ ENTRY(_emergency_print_nr)
>  	/* don't skip the last zero if number == 0x0 */
>  	l.sfeqi	r8,0x4
>  	l.bf	2f
> -	l.nop
> +	 l.nop
>  
>  	l.sfeq	r7,r0
>  	l.bf	1b
> -	l.nop
> +	 l.nop
>  
>  2:
>  	l.srl	r7,r3,r8
>  
>  	l.andi	r7,r7,0xf
>  	l.sflts	r8,r0
> -	l.bf	9f
> +	 l.bf	9f
>  
> +	/* Numbers greater than 9 translate to a-f */
>  	l.sfgtui r7,0x9
>  	l.bnf	8f
> -	l.nop
> +	 l.nop
>  	l.addi	r7,r7,0x27
>  
> -8:
> -	l.addi	r7,r7,0x30
> -// putc:
> -	l.movhi r4,hi(UART_BASE_ADD)
> -
> -	l.addi  r6,r0,0x20
> -1:      l.lbz   r5,5(r4)
> -	l.andi  r5,r5,0x20
> -	l.sfeq  r5,r6
> -	l.bnf   1b
> -	l.nop
> -
> -	l.sb    0(r4),r7
> -
> -	l.addi  r6,r0,0x60
> -1:      l.lbz   r5,5(r4)
> -	l.andi  r5,r5,0x60
> -	l.sfeq  r5,r6
> -	l.bnf   1b
> -	l.nop
> +	/* Convert to ascii and output character */
> +8:	l.jal	_emergency_putc
> +	 l.addi	r7,r7,0x30
>  
>  	/* next character */
>  	l.j	2b
>  	l.addi	r8,r8,-0x4
>  
>  9:
> +	EMERGENCY_PRINT_LOAD_GPR9
>  	EMERGENCY_PRINT_LOAD_GPR8
>  	EMERGENCY_PRINT_LOAD_GPR7
> -	EMERGENCY_PRINT_LOAD_GPR6
> -	EMERGENCY_PRINT_LOAD_GPR5
> -	EMERGENCY_PRINT_LOAD_GPR4
>  	l.jr	r9
> -	l.nop
> -
> +	 l.nop
>  
>  /*
>   * This should be used for debugging only.
> @@ -1676,7 +1695,9 @@ ENTRY(_emergency_print_nr)
>  
>  ENTRY(_early_uart_init)
>  	l.movhi	r3,hi(UART_BASE_ADD)
> +	l.ori	r3,r3,lo(UART_BASE_ADD)
>  
> +#if defined(CONFIG_SERIAL_8250)
>  	l.addi	r4,r0,0x7
>  	l.sb	0x2(r3),r4
>  
> @@ -1694,9 +1715,10 @@ ENTRY(_early_uart_init)
>  	l.addi  r4,r0,((UART_DIVISOR) & 0x000000ff)
>  	l.sb	UART_DLL(r3),r4
>  	l.sb	0x3(r3),r5
> +#endif
>  
>  	l.jr	r9
> -	l.nop
> +	 l.nop
>  
>  	.align	0x1000
>  	.global _secondary_evbar
> @@ -1711,13 +1733,13 @@ _secondary_evbar:
>  
>  	.section .rodata
>  _string_unhandled_exception:
> -	.string "\n\rRunarunaround: Unhandled exception 0x\0"
> +	.string "\r\nRunarunaround: Unhandled exception 0x\0"
>  
>  _string_epc_prefix:
>  	.string ": EPC=0x\0"
>  
>  _string_nl:
> -	.string "\n\r\0"
> +	.string "\r\n\0"
>  
>  
>  /* ========================================[ page aligned structures ]=== */
> 

