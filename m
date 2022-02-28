Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A27C4C7E43
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 00:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiB1X0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 18:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiB1X0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 18:26:51 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4019C626D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 15:26:11 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id t22so14740616vsa.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 15:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=678bsp2ErC3AUHByI563pP4zj6fiQdpPo5vEOV1fue0=;
        b=ozH4CPp2zu7LhcVv6S/q7oub5q1+cZ9nyOOxAMKT0uJ9FRpMSi13MW5tFZtzsa/NwO
         40/Sh6X4AmgitON88oEeersWw75CzIQur3pLWkl0n9zYTBBrjUlWVctrJrNQCXCFi+XL
         4fyM/m2U0U1FE8ekyt4aDheSe88K8/xkWgs/zKi5ZxknbHM5u/WeVPeLcfvJwXKjHnyu
         NLf8aSlQCa/dLBwWelqR0TLmoX5ltWj+5mhgRUenrG10+P4R8nXdZLbslyYgwtuGDQGE
         spnZjFMx3kPnns/TPTIrlTR5lCLi3BADefbabo6jj8TOXUc8AEEtM1YdpxA13wIifiZN
         0A7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=678bsp2ErC3AUHByI563pP4zj6fiQdpPo5vEOV1fue0=;
        b=gGNzDZXIE6pe43Sfm1RQ9uwIaCTwbUb7NHDz5V0WeY7kWXSXGOPXxqvlx9uv8AZHKx
         hTyCDyZJMp4j8cJFaGa6a+ZT3jyDrKAYMFzm4pcCycS1kg6XlLVEZEvFhDm/0RcHCZEc
         f/tSj5IqnIPBg0OfdSFrw6eRp3Uc117hY/TUFpj1+lbt6vnhjiOUvRBbweVLjGxhFpMk
         Zn1j5cvIAiRAceJfaBrOmkFiY51/pimepaqDhLUz7MKMDQJiZhaEY0NRLOZkfLQohkDH
         OoT1G8XRjsQy6UMyH9kN4ML79EmMYlDHQ/DGttf+G7LR2A4pVBlSgeJtJ1HRkRkljgVG
         TbIQ==
X-Gm-Message-State: AOAM531D85phLWuoHW3RtbuY5E8pDNdeoU9s6+vVQyorULFPaOhsN1UZ
        mvrczgATssLdLXCh30dw3P8=
X-Google-Smtp-Source: ABdhPJzFW+ebkA33fyzZOlIhybeZny+OBqFcDo8O1cUgrJSuSOoNTuzXQSuYpfpz1FOAgljyzbWoRA==
X-Received: by 2002:a67:e187:0:b0:30f:ec53:be70 with SMTP id e7-20020a67e187000000b0030fec53be70mr10055671vsl.15.1646090770993;
        Mon, 28 Feb 2022 15:26:10 -0800 (PST)
Received: from ishi (072-189-064-222.res.spectrum.com. [72.189.64.222])
        by smtp.gmail.com with ESMTPSA id a25-20020a056102025900b0031c34d0f8d5sm1555132vsq.3.2022.02.28.15.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 15:26:10 -0800 (PST)
Date:   Mon, 28 Feb 2022 18:26:08 -0500
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Mateusz =?utf-8?Q?Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 10/10] x86/Kconfig: remove CONFIG_ISA_BUS
Message-ID: <Yh1aEGwekig1hG9G@ishi>
References: <20220228212826.27080-1-mat.jonczyk@o2.pl>
 <20220228212826.27080-11-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220228212826.27080-11-mat.jonczyk@o2.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 10:28:26PM +0100, Mateusz Jończyk wrote:
> CONFIG_ISA_BUS was used only as a dependency for a single Industrial IO
> driver: CONFIG_CIO_DAC ("Measurement Computing CIO-DAC IIO driver"). At
> least grepping the kernel source for "ISA_BUS" did not find any other
> meaningful results.
> 
> There are more configuration options that select CONFIG_ISA_BUS_API, but
> did not depend on CONFIG_ISA_BUS. Most of these are for Industrial IO and
> GPIO drivers.
> 
> Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: William Breathitt Gray <vilhelm.gray@gmail.com>

For context, the Measurement Computing CIO-DAC device comes in two
form factors: PC104 and ISA. The PC104 bus is typically aimed at
embedded systems and not commonly used by general users, so the
CONFIG_PC104 Kconfig option was introduced to filter out these devices
for most users who would generally not be interested in them. Because
the CIO-DAC device is also available in an ISA form factor, I needed a
way to have the CONFIG_CIO_DAC Kconfig available even on non-PC104
systems; that's how the CONFIG_ISA_BUS Kconfig option came about.

The purpose of the CONFIG_ISA_BUS Kconfig option is filter out ISA bus
devices because few users will have an ISA bus. I suppose it does no
harm to remove that filter because users can still select CONFIG_CIO_DAC
if they want it, so I'm all right with this patch.

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
>  arch/x86/Kconfig        | 11 -----------
>  drivers/iio/dac/Kconfig |  2 +-
>  2 files changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 19acc5954083..2de46adfbde2 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2692,17 +2692,6 @@ config PCI_CNB20LE_QUIRK
>  
>  	  You should say N unless you know you need this.
>  
> -config ISA_BUS
> -	bool "ISA bus support on modern systems" if EXPERT
> -	help
> -	  Expose ISA bus device drivers and options available for selection and
> -	  configuration. Enable this option if your target machine has an ISA
> -	  bus. ISA is an older system, displaced by PCI and newer bus
> -	  architectures -- if your target machine is modern, it probably does
> -	  not have an ISA bus.
> -
> -	  If unsure, say N.
> -
>  # x86_64 have no ISA slots, but can have ISA-style DMA.
>  config ISA_DMA_API
>  	bool "ISA-style DMA support" if (X86_64 && EXPERT)
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index bfcf7568de32..fe0f2a93055d 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -264,7 +264,7 @@ config AD8801
>  
>  config CIO_DAC
>  	tristate "Measurement Computing CIO-DAC IIO driver"
> -	depends on X86 && (ISA_BUS || PC104)
> +	depends on X86
>  	select ISA_BUS_API
>  	help
>  	  Say yes here to build support for the Measurement Computing CIO-DAC
> -- 
> 2.25.1
> 
