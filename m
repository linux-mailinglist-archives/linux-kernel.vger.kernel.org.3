Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726DC4A8B4D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 19:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244376AbiBCSOL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Feb 2022 13:14:11 -0500
Received: from mail-ua1-f46.google.com ([209.85.222.46]:43746 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiBCSOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 13:14:07 -0500
Received: by mail-ua1-f46.google.com with SMTP id a24so6644296uat.10;
        Thu, 03 Feb 2022 10:14:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zuRi1gvJwraHGGMX689FTEbY0oO0ny4SiA1loHIIfa4=;
        b=Xkicu1baHOvh7+oWkWlki03k6ytH+V0ewC0kxru99npNOP1G+njJ56rCHSI20JWrMm
         1U34EwIHEI2dU3hhTVz12y+ipL4Cei5l7PSwccI3f2941jkFLe3pIQQMr+0ANAvMNBis
         vSXIkRHapE6yIAsTq+IVaSTKayjSIWmTvYMrts9iEkWspCuRdzusmoYb5bmm4ultMlvU
         FM69iBCivknW6GhhcdE1hoEk8AZLi6bKIsnTqkVwapd2/CrmkDtSA4ZpNqeEtT+CkX7d
         CBmLPRGWyjMApCfI6e3qtrDj73Vkfa8rscP/36YdzYEbkJbuE944OL5Tb5jCyeqzqKEU
         SH9A==
X-Gm-Message-State: AOAM531TkxAEV3zABg7dNtYkJbgm8LjE3qr9P0FEk2HxPIRldGPZwht9
        0d0T9d/5il22/Ei81bUQc8BHE99rTuaKsA==
X-Google-Smtp-Source: ABdhPJwc2inlvxxoMABqR8gjzt4c1RpubplvkwdfA2/XGqgaQKaY3sfqiqp7sBvsm92240JasO7Jgw==
X-Received: by 2002:a05:6102:669:: with SMTP id z9mr13973898vsf.76.1643912046925;
        Thu, 03 Feb 2022 10:14:06 -0800 (PST)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id b26sm8172188uam.6.2022.02.03.10.14.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 10:14:06 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id e17so6669497uad.9;
        Thu, 03 Feb 2022 10:14:06 -0800 (PST)
X-Received: by 2002:a67:fd63:: with SMTP id h3mr12840615vsa.77.1643912046347;
 Thu, 03 Feb 2022 10:14:06 -0800 (PST)
MIME-Version: 1.0
References: <6c1f0131-fb02-f30a-86ed-63ce3788901b@omp.ru>
In-Reply-To: <6c1f0131-fb02-f30a-86ed-63ce3788901b@omp.ru>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 3 Feb 2022 19:13:55 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVjCzEpDLnW-jy_kpHoV8DEa=KCAjp=QeXnr8auh3B5Pg@mail.gmail.com>
Message-ID: <CAMuHMdVjCzEpDLnW-jy_kpHoV8DEa=KCAjp=QeXnr8auh3B5Pg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add myself as Renesas R-Car SATA driver reviewer
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-ide@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC linux-reneas-soc

Hi Sergey,

On Thu, Feb 3, 2022 at 6:51 PM Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
> Add myself as a reviewer for the Renesas R-Car SATA driver -- I don't have
> the hardware anymore (Geert Uytterhoeven does have a lot of hardware!) but
> I do have the manuals still! :-)

I guess some of the manuals are publicly available on the Renesas
website?

> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Thanks for the offer!

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- libata.orig/MAINTAINERS
> +++ libata/MAINTAINERS
> @@ -16469,6 +16469,13 @@ F:     Documentation/devicetree/bindings/i2c
>  F:     drivers/i2c/busses/i2c-rcar.c
>  F:     drivers/i2c/busses/i2c-sh_mobile.c
>
> +RENESAS R-CAR SATA DRIVER
> +R:     Sergey Shtylyov <s.shtylyov@omp.ru>
> +L:     linux-ide@vger.kernel.org
> +L:     linux-renesas-soc@vger.kernel.org
> +F:     Documentation/devicetree/bindings/ata/renesas,rcar-sata.yaml
> +F:     drivers/ata/sata_rcar.c
> +
>  RENESAS R-CAR THERMAL DRIVERS
>  M:     Niklas Söderlund <niklas.soderlund@ragnatech.se>
>  L:     linux-renesas-soc@vger.kernel.org

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
