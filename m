Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB5D5AB551
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237006AbiIBPfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235137AbiIBPfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:35:23 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 303F6106DA2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 08:21:10 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 282FH0vP013648;
        Fri, 2 Sep 2022 10:17:00 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 282FH0kg013647;
        Fri, 2 Sep 2022 10:17:00 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 2 Sep 2022 10:16:59 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/vdso: link with -z noexecstack
Message-ID: <20220902151659.GN25951@gate.crashing.org>
References: <24daf2ae379597b8d5dff41e4f7cebdca9db2d9d.1662105421.git.christophe.leroy@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24daf2ae379597b8d5dff41e4f7cebdca9db2d9d.1662105421.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Fri, Sep 02, 2022 at 09:57:09AM +0200, Christophe Leroy wrote:
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -128,7 +128,8 @@ extra-y				+= vmlinux.lds
>  
>  obj-$(CONFIG_RELOCATABLE)	+= reloc_$(BITS).o
>  
> -obj-$(CONFIG_PPC32)		+= entry_32.o setup_32.o early_32.o static_call.o
> +obj-$(CONFIG_PPC32)		+= entry_32.o setup_32.o early_32.o
> +obj-$(CONFIG_HAVE_STATIC_CALL)	+= static_call.o

Did you want to commit this part?  The commit message doesn't mention it.


Segher
