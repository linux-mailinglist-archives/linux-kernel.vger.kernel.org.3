Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAD94C9073
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 17:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236238AbiCAQfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 11:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235901AbiCAQf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 11:35:28 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FB8513FB1;
        Tue,  1 Mar 2022 08:34:47 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nP5SV-0006n6-01; Tue, 01 Mar 2022 17:34:43 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 91177C28F1; Tue,  1 Mar 2022 17:30:20 +0100 (CET)
Date:   Tue, 1 Mar 2022 17:30:20 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Marc Zyngier <maz@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Yanteng Si <siyanteng01@gmail.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mips: Implement "current_stack_pointer"
Message-ID: <20220301163020.GB13091@alpha.franken.de>
References: <20220224060432.1855897-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224060432.1855897-1-keescook@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 10:04:32PM -0800, Kees Cook wrote:
> To follow the existing per-arch conventions replace open-coded uses
> of asm "sp" as "current_stack_pointer". This will let it be used in
> non-arch places (like HARDENED_USERCOPY).
> 
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Yanteng Si <siyanteng01@gmail.com>
> Cc: linux-mips@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/mips/Kconfig                   | 1 +
>  arch/mips/include/asm/thread_info.h | 2 ++
>  arch/mips/kernel/irq.c              | 3 +--
>  arch/mips/lib/uncached.c            | 4 +---
>  4 files changed, 5 insertions(+), 5 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
