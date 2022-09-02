Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CADA5AA4D8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 03:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbiIBBGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 21:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbiIBBFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 21:05:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E489D1C132
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 18:05:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C1FE61913
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 01:05:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCCE2C4347C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 01:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662080753;
        bh=9NLQPiptMzTPurM9RAlpc0jk2uNe5aQArXXHZJ8RuZo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OE65Ri7nXEIsLWxcOd3TvvNE2wg+05deylUEsf6XX5ZCqKg2t6eieplUE8UVcMZq9
         Nw2fTdwDoZ2Wzrz6gHZQpG+mvnYwR0cYyQYES3THCXXFea23r72IPxZRZ63Uvv83yN
         jTlq3A2jUh1V3SXGe51ijOffURVRQT+oQLMkt7YHaqr0YIXISGm4TLP97H2Hx0IxQO
         LM49RSJHBcSM4MLxzdUv/BXENYWn0A8j44iNRAdH7s0+Un8cU13/Iz6ZhTxFTmocB/
         dVMbrv9ZWRnY+kxJq1oDmjCC6ehchnw3GuvXJvUMe+PsmY8G5OfypZ0EbxPx1bSW0E
         INSXJLAkT8EpA==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-11edd61a9edso1421475fac.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 18:05:53 -0700 (PDT)
X-Gm-Message-State: ACgBeo25H5cePpLHP1OAV4ouB+n86G1pqJpP9zrl9ujYuSmFN/PxrEd7
        Rg6rXHsANZ9a4rjfREgEAePfnuNJZ93vAG0F30k=
X-Google-Smtp-Source: AA6agR5ETddg8O9I7UdZfSOUYIc86bV/VgE2MIq6v6DQVgWsrzc6vzpZxaqAUeSF//QoVPL846Ap9/agx772SpoKZBc=
X-Received: by 2002:a05:6808:150f:b0:343:3202:91cf with SMTP id
 u15-20020a056808150f00b00343320291cfmr888181oiw.112.1662080752840; Thu, 01
 Sep 2022 18:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220901222744.2210215-1-heiko@sntech.de> <20220901222744.2210215-2-heiko@sntech.de>
In-Reply-To: <20220901222744.2210215-2-heiko@sntech.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 2 Sep 2022 09:05:40 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTdVsoZqn_yRx7VpnjQ+hNvWyVG14KzYToBA+Z1EsOz_g@mail.gmail.com>
Message-ID: <CAJF2gTTdVsoZqn_yRx7VpnjQ+hNvWyVG14KzYToBA+Z1EsOz_g@mail.gmail.com>
Subject: Re: [PATCH 2/4] riscv: drop some idefs from CMO initialization
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, conor.dooley@microchip.com,
        apatel@ventanamicro.com, atishp@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Guo Ren <guoren@kernel.org>

On Fri, Sep 2, 2022 at 6:28 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Wrapping things in #ifdefs makes the code harder to read
> while we also have IS_ENABLED() macros to do this in regular code
> and the extension detection is not _that_ runtime critical.
>
> So define a stub for riscv_noncoherent_supported() in the
> non-CONFIG_RISCV_DMA_NONCOHERENT case and move the code to
> us IS_ENABLED.
>
> Suggested-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/riscv/errata/thead/errata.c    |  7 +++----
>  arch/riscv/include/asm/cacheflush.h |  2 ++
>  arch/riscv/kernel/cpufeature.c      | 22 +++++++++-------------
>  3 files changed, 14 insertions(+), 17 deletions(-)
>
> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
> index 202c83f677b2..bffa711aaf64 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -30,7 +30,9 @@ static bool errata_probe_pbmt(unsigned int stage,
>  static bool errata_probe_cmo(unsigned int stage,
>                              unsigned long arch_id, unsigned long impid)
>  {
> -#ifdef CONFIG_ERRATA_THEAD_CMO
> +       if (!IS_ENABLED(CONFIG_ERRATA_THEAD_CMO))
> +               return false;
> +
>         if (arch_id != 0 || impid != 0)
>                 return false;
>
> @@ -39,9 +41,6 @@ static bool errata_probe_cmo(unsigned int stage,
>
>         riscv_noncoherent_supported();
>         return true;
> -#else
> -       return false;
> -#endif
>  }
>
>  static u32 thead_errata_probe(unsigned int stage,
> diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
> index a60acaecfeda..4363d0beb38a 100644
> --- a/arch/riscv/include/asm/cacheflush.h
> +++ b/arch/riscv/include/asm/cacheflush.h
> @@ -50,6 +50,8 @@ static inline void riscv_init_cbom_blocksize(void) { }
>
>  #ifdef CONFIG_RISCV_DMA_NONCOHERENT
>  void riscv_noncoherent_supported(void);
> +#else
> +static inline void riscv_noncoherent_supported(void) {}
>  #endif
>
>  /*
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 764ea220161f..729f7a218093 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -264,21 +264,17 @@ static bool __init_or_module cpufeature_probe_svpbmt(unsigned int stage)
>
>  static bool __init_or_module cpufeature_probe_zicbom(unsigned int stage)
>  {
> -#ifdef CONFIG_RISCV_ISA_ZICBOM
> -       switch (stage) {
> -       case RISCV_ALTERNATIVES_EARLY_BOOT:
> +       if (!IS_ENABLED(CONFIG_RISCV_ISA_ZICBOM))
> +               return false;
> +
> +       if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
> +               return false;
> +
> +       if (!riscv_isa_extension_available(NULL, ZICBOM))
>                 return false;
> -       default:
> -               if (riscv_isa_extension_available(NULL, ZICBOM)) {
> -                       riscv_noncoherent_supported();
> -                       return true;
> -               } else {
> -                       return false;
> -               }
> -       }
> -#endif
>
> -       return false;
> +       riscv_noncoherent_supported();
> +       return true;
>  }
>
>  /*
> --
> 2.35.1
>


-- 
Best Regards
 Guo Ren
