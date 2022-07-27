Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55725825E6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 13:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbiG0Lw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 07:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbiG0LwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 07:52:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE1825285
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 04:52:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA8976192F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 11:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3FB8C433D7;
        Wed, 27 Jul 2022 11:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658922741;
        bh=apzSeAEMUsrgO6S0p4lxITYYJLjQhf8C1uciSeLhtcg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NuaNFCLG+EsrnwY4LYg9sdJgoA5km2//H3LLR+70OqRuL/NNyKQHWS9kSw3Tk2O1Z
         02g+WxStgjgyxXFuyzzVeW6xPLokVC15/Gjm5klfIo6DV3CUfGBHC+IHGZQa8ithfV
         17E9EEouRAFHcfR/GUyadkWk+iGt2hWsHsx1hhMQ=
Date:   Wed, 27 Jul 2022 13:52:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] misc: Mark MICROCODE_MINOR unused
Message-ID: <YuEm8rRmLwfg3gpz@kroah.com>
References: <20220727114948.30123-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727114948.30123-1-bp@alien8.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 01:49:48PM +0200, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> This one is unused since
> 
>   181b6f40e9ea ("x86/microcode: Rip out the OLD_INTERFACE")
> 
> so comment it out.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Link: https://lore.kernel.org/r/20220525161232.14924-1-bp@alien8.de
> ---
>  include/linux/miscdevice.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/miscdevice.h b/include/linux/miscdevice.h
> index 0676f18093f9..99291eff32dc 100644
> --- a/include/linux/miscdevice.h
> +++ b/include/linux/miscdevice.h
> @@ -44,7 +44,7 @@
>  #define AGPGART_MINOR		175
>  #define TOSH_MINOR_DEV		181
>  #define HWRNG_MINOR		183
> -#define MICROCODE_MINOR		184
> +/*#define MICROCODE_MINOR		184 unused */
>  #define KEYPAD_MINOR		185
>  #define IRNET_MINOR		187
>  #define D7S_MINOR		193
> -- 
> 2.35.1
> 

Thanks, will go queue this up!

greg k-h
