Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F0F46AEBA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 01:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353865AbhLGADa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 19:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238201AbhLGAD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 19:03:29 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357F2C061746;
        Mon,  6 Dec 2021 16:00:00 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id g28so12922393qkk.9;
        Mon, 06 Dec 2021 16:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vH+EyTSx02n/9sSrzkW48FfgfH64lJ0ZkjvaQbTUsms=;
        b=HwPZwxYQ/1r7+8pP9NqaVMVsf+U/zbhb0l4xtYxZi5nV3vU0+/G+FR+ckKCb6EZAtn
         14s62nfBw8hYGdYJLmIj6del6MZWJNBZsmUk5XllJjmLaav18s8wrAC4MBS1dVp8l2uo
         UQLLdfZOM/4ZOgoHRoCFC/KAKYRcQKmQcbiRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vH+EyTSx02n/9sSrzkW48FfgfH64lJ0ZkjvaQbTUsms=;
        b=2lPKM6xRYYCVzArrwkJexN3LR4RC5Z704dlgK5eHjIpgbkyo+Js0nYmewf0OG/joG0
         lgEGL1ppveM+Y1w1QcOmdEAfZgnM7hs1hnH23LlfkX1ldpUcOOaxW2R0qqdBADKag/6S
         GfcuAzqy5OWXE6Le3hsdUZg7YFOIspBKeZ9WXcB/1WMMzgep+3hMd7Z//nyYL5j2Qes0
         yJi/SKuSXVe5QnHILIw+rTaQwrDSfOjOxuAqfEUW+8+8T0ql3b1yK6jN8ViYgPVIqLPA
         931Ype6X7Be/FyHBtP1LyPh+0+kOWrO+RmvltKnrxVMD/BNiqPbGIXw8KcTqLKVGjEO1
         BgWA==
X-Gm-Message-State: AOAM5325jBOqfo0iQ2GwDkYS1S/184PllIcxMQvmhZaHDEbCxh5VSVnx
        66QWJxpFXJNPSsUlmBhSxRgSNyitSB0io7THYrg=
X-Google-Smtp-Source: ABdhPJzJQG5wzaIUOqemw1mDUPRPbTFXQ444i5aqc/kbmA+TsdoCASPXa977dxSKPOxI8d6QayqyYYpSEUR7L4YE6a4=
X-Received: by 2002:a05:620a:1004:: with SMTP id z4mr35939762qkj.243.1638835199182;
 Mon, 06 Dec 2021 15:59:59 -0800 (PST)
MIME-Version: 1.0
References: <20211204204121.2367127-1-gsomlo@gmail.com> <20211204204121.2367127-2-gsomlo@gmail.com>
In-Reply-To: <20211204204121.2367127-2-gsomlo@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 6 Dec 2021 23:59:47 +0000
Message-ID: <CACPK8XcNHwGanjyxeRxQU55FXQCv6aizOa33qbD93G7-GizVmw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] MAINTAINERS: co-maintain LiteX platform
To:     Gabriel Somlo <gsomlo@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Kamil Rakoczy <krakoczy@antmicro.com>,
        mdudek@internships.antmicro.com,
        Paul Mackerras <paulus@ozlabs.org>,
        Stafford Horne <shorne@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        david.abdurachmanov@sifive.com,
        Florent Kermarrec <florent@enjoy-digital.fr>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Dec 2021 at 20:41, Gabriel Somlo <gsomlo@gmail.com> wrote:
>
> Add the litex_mmc (LiteSDCard) driver to the list of files maintained
> under LiteX, and add myself as co-maintainer. I've helped develop some
> of the existing drivers, and am currently curating the out-of-tree
> drivers as they are tested and prepared for upstream submission.
>
> Cc: Karol Gugala <kgugala@antmicro.com>
> Cc: Mateusz Holenko <mholenko@antmicro.com>
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>

Acked-by: Joel Stanley <joel@jms.id.au>

If this is going to be a catch all for the drivers as well as the
platform, we're probably missing a few entries:

$ git grep -l litex
Documentation/admin-guide/kernel-parameters.txt
Documentation/devicetree/bindings/net/litex,liteeth.yaml
Documentation/devicetree/bindings/serial/litex,liteuart.yaml
Documentation/devicetree/bindings/soc/litex/litex,soc-controller.yaml
Documentation/devicetree/bindings/vendor-prefixes.yaml
Documentation/sphinx/kfigure.py
MAINTAINERS
arch/openrisc/boot/dts/or1klitex.dts
arch/openrisc/configs/or1klitex_defconfig
arch/powerpc/boot/dts/microwatt.dts
drivers/net/ethernet/Kconfig
drivers/net/ethernet/Makefile
drivers/net/ethernet/litex/Makefile
drivers/net/ethernet/litex/litex_liteeth.c
drivers/soc/Kconfig
drivers/soc/Makefile
drivers/soc/litex/Kconfig
drivers/soc/litex/Makefile
drivers/soc/litex/litex_soc_ctrl.c
drivers/tty/serial/liteuart.c
include/linux/litex.h
scripts/clang-tools/gen_compile_commands.py

I think we could add these entries to maintainers:

+F:     drivers/soc/litex/*
+F:     drivers/net/ethernet/litex/*
+N:     litex

I would also add my name there.

> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index faa9c34d837d..5fc65d4c4969 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11012,12 +11012,14 @@ F:    lib/list-test.c
>  LITEX PLATFORM
>  M:     Karol Gugala <kgugala@antmicro.com>
>  M:     Mateusz Holenko <mholenko@antmicro.com>
> +M:     Gabriel Somlo <gsomlo@gmail.com>
>  S:     Maintained
>  F:     Documentation/devicetree/bindings/*/litex,*.yaml
>  F:     arch/openrisc/boot/dts/or1klitex.dts
>  F:     drivers/soc/litex/litex_soc_ctrl.c
>  F:     drivers/tty/serial/liteuart.c
>  F:     include/linux/litex.h
> +F:     drivers/mmc/host/litex_mmc.c
>
>  LIVE PATCHING
>  M:     Josh Poimboeuf <jpoimboe@redhat.com>
> --
> 2.31.1
>
