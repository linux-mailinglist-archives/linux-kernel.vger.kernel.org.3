Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B57F56BDD0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 18:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238850AbiGHPXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 11:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237631AbiGHPXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 11:23:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D79F6D559;
        Fri,  8 Jul 2022 08:23:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE8CB611DC;
        Fri,  8 Jul 2022 15:23:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36808C341C0;
        Fri,  8 Jul 2022 15:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657293800;
        bh=ZcgjiUXsY2nVzDJIVwV5cYUXobg29wTGZ1OMibhE4ls=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=O2M3khxdqUno1UAN7PwcZYfpvHkHY/ehW83XX5vYBg9Nqu99m26BEi+jhvSBIs9bm
         YHmT5suNUC+p9yLxbjm5s7qg6HObXb26MzggTi77lJeONjwny4EiZZTR7gLUCCtFqP
         63/PVys9Z/IK73VjcFhQxKN/AxKYk1FzC+/ft3hu7Yk1kgjTLHyuAFv9q0BrR0vecG
         hjWYzYWFCx0+fYXquqYd/IZnRJOGTU/f1c5vOtosNCBfbl8dyofQjPiAI6AkByTmd2
         quNvr3LsfKJclvDbfDUMjmlOd4s1aYETeIhXNl2zK3v3lUN5odp9u/gWmuGjD0089K
         i4c/ikvV1pTfw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B38A15C0328; Fri,  8 Jul 2022 08:23:19 -0700 (PDT)
Date:   Fri, 8 Jul 2022 08:23:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: linux-next: manual merge of the rcu tree with Linus' tree
Message-ID: <20220708152319.GS1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220708141246.43111241@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708141246.43111241@canb.auug.org.au>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 02:12:46PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the rcu tree got a conflict in:
> 
>   arch/loongarch/Kconfig
> 
> between commit:
> 
>   7fd6ef61a5d6 ("LoongArch: Drop these obsolete selects in Kconfig")
> 
> from Linus' tree and commit:
> 
>   24a9c54182b3 ("context_tracking: Split user tracking Kconfig")
> 
> from the rcu tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thank you, Stephen!  I have noted this for my pull request.

							Thanx, Paul

> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc arch/loongarch/Kconfig
> index 53a912befb62,130dc65f3c85..000000000000
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@@ -75,7 -76,8 +75,7 @@@ config LOONGARC
>   	select HAVE_ARCH_TRACEHOOK
>   	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
>   	select HAVE_ASM_MODVERSIONS
> - 	select HAVE_CONTEXT_TRACKING
> + 	select HAVE_CONTEXT_TRACKING_USER
>  -	select HAVE_COPY_THREAD_TLS
>   	select HAVE_DEBUG_STACKOVERFLOW
>   	select HAVE_DMA_CONTIGUOUS
>   	select HAVE_EXIT_THREAD


