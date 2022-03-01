Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA3B4C818D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 04:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbiCADPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 22:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiCADPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 22:15:02 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FC91ADAD
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 19:14:22 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id e5so15110156vsg.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 19:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ch9VoHC/JHV8gfnjOjO4Q2mXLXR2ulANV5loSV0wEKg=;
        b=F4D2tecmCUAaoFxhCdAb38bIpSBF5TXTuO/L+p+i7tq4Przy5m/W7k7sZ+SHOblcj7
         1lQe+5eUPgh3PsF9Ntu23fDXv7iSYrH7nCzTEceGYQDfbiMzePLkJWgdZUvPHw0q97GT
         QWgUL15OKpxkLTmn6/cI3AwL95WRCQ8QrkvZT77SIj+RjZbmUmydrbMcNJaNFNRRnzgd
         pE8oorsQy1YRnTDTzj4m0XF75PniXNyawQjTeUV/7jd3yANA0Kxm+HlnByl8SSRqDAPU
         XON3gk/2b2N3Ne7tsqxhemkZXQVZXkXzvUcp5CErnSeborDrf90qMEwVN53CCsFtoa5d
         0hRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ch9VoHC/JHV8gfnjOjO4Q2mXLXR2ulANV5loSV0wEKg=;
        b=v5uWBPaV50/57ZfQJVUj0AFzuRnfMjdi2HEck8dvHnuJHUpulp/TfS4mvYckxu/sGu
         CSGm11WpCKQG5qH0rJ5cNnn8sWaHpeVZER3Qt7S2V8lT2pkRlbmKHyZojL+WiOQyduI2
         nRqZ//fcfPre03v3akLFmUGl0mn8l/EgQfoql6syjnMiTlJHTQ8eVL/6ANpqo1oDQqmn
         Lg7StRAn0DPlGX5GrJFNxDgn5kKarMALWP/WfWDrr3wiU4nHaErENYJK/ROwdX+IKYwl
         OM47kbnZzFQpPHF8vN801XHBye9OWvMnl6/FD3A93feiVoyXCvACbwBDsRdyf2o46Nq/
         8QdA==
X-Gm-Message-State: AOAM531ZFzMsqaUC0wAUKlwuGUFSDST+QpsfomniYlpchpafV48uJnO3
        fZXCt+lfJMfQTe5s/NXPpHe9QdR7C9NLA/lW3d8=
X-Google-Smtp-Source: ABdhPJxdHR6VlmO/jnCSLKFJT2b7f93sZHJjA+FN2YwBKdKakUxur6Q2gHR9tx5848lCQbt8sr875DHYOzjZb2qat4U=
X-Received: by 2002:a67:e14d:0:b0:31b:9356:40ff with SMTP id
 o13-20020a67e14d000000b0031b935640ffmr9251738vsl.51.1646104462125; Mon, 28
 Feb 2022 19:14:22 -0800 (PST)
MIME-Version: 1.0
References: <20220217224648.113767-1-jrdr.linux@gmail.com>
In-Reply-To: <20220217224648.113767-1-jrdr.linux@gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 1 Mar 2022 08:44:10 +0530
Message-ID: <CAFqt6zboRQmVgCR-Sh_QUVKqjqoWBQ2qFefo4Hj36Msr-Ph=kA@mail.gmail.com>
Subject: Re: [PATCH] ARM: iop32x: add prototype for iop_enable_cp6()
To:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, ardb@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 4:17 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> From: "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>
>
> Kernel test robot throws warning ->
> arch/arm/mach-iop32x/cp6.c:10:6: warning: no previous prototype
> for function 'iop_enable_cp6' [-Wmissing-prototypes]
>
> Adding prototype by including header.

Any comments on this patch ?

>
> Fixes:  6f5d248d05db ("ARM: iop32x: use GENERIC_IRQ_MULTI_HANDLER")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>
> ---
>  arch/arm/mach-iop32x/cp6.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/mach-iop32x/cp6.c b/arch/arm/mach-iop32x/cp6.c
> index 2882674a1c39..7135a0ac9949 100644
> --- a/arch/arm/mach-iop32x/cp6.c
> +++ b/arch/arm/mach-iop32x/cp6.c
> @@ -7,6 +7,8 @@
>  #include <asm/traps.h>
>  #include <asm/ptrace.h>
>
> +#include "iop3xx.h"
> +
>  void iop_enable_cp6(void)
>  {
>         u32 temp;
> --
> 2.25.1
>
