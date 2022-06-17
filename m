Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D1F54F496
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 11:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380453AbiFQJsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 05:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbiFQJsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 05:48:17 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F33457B2;
        Fri, 17 Jun 2022 02:48:16 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x5so5488459edi.2;
        Fri, 17 Jun 2022 02:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wD2kpKzJqFUX67y53Ka9TC3u1l6m/HfRCHZEF9+P7LY=;
        b=O3oJ7EBa1DSYeSpPAl2pwHKAAIzqbPtTv2ruY4dJURFxUWkylGAOtt1Nzx/4Co1l/p
         qZD1unk8hoGYMxLOI3HBtWnp/KbI6TxpXQSplt7cgBmRuiZYF1qG9eO1Y9H1JF78nYvD
         02sUN3pSjcCiBGmKyoWqwhiXELO/e3rajJ9N1y74na1jHkb1OARIPTKFEIN06npNihbb
         /F2WvaDOVAbBG/8bebnVJLyHO0HH+O2pIvNo3v3fQX3wv01pdrqnKOk39RGmsayLYrBU
         yNm1P/qcrFCBqu1tiVF8+cMc/xprN+NsbOUoSptWxNkELNtC4JpXykXIN84fao/jWUnk
         bnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wD2kpKzJqFUX67y53Ka9TC3u1l6m/HfRCHZEF9+P7LY=;
        b=WGlGooKCt9+ngo6NI9EHENyemEJR9XrT0YmO00NkNJBFKI30JK6hJmaS4psN5T7JpS
         PvNRmNT5dvT4HSHbvQM+4PVTFaXJKKjNTWvX8kyznQOeKA6dAztuPbb9Y0aWkoz0pRFa
         pxq8VVbvXyEAvyxvGEK9lTPtF0K/peMYJRaxWBWX8bjNWnlvWgOTHHeZiAMJe+/CG82E
         xYEcPyyA/dfwpNxCjhIGvk1315MZd1nQhUQcTN0/wbuSC6rNtShZaHhacv/SwBLlFvmm
         ZG3w9jtVscTkEdPGbPmspt+UfThh6B0ivkV3Ul3/+Rr7/tbiZ7NMgM//aFCZPjG5dvAb
         FItw==
X-Gm-Message-State: AJIora+W+0guPVR9eOs6ISGL5JLAQfimJkMSMhv9gVf5j495zleHDg2B
        FHAJZbehzdC4kPoP+nZPGqtg6GRupZjwwO+RiNQ=
X-Google-Smtp-Source: AGRyM1uqFe/JXStvN3glFnviA4pS3N3gxtDC5EfBtKciin5PrqBbU8kQk1XiTEG3zneSSb/vnLFf+3CRhVTZ94qZ+tU=
X-Received: by 2002:a05:6402:4390:b0:42e:b7e:e9ac with SMTP id
 o16-20020a056402439000b0042e0b7ee9acmr11329544edc.97.1655459294822; Fri, 17
 Jun 2022 02:48:14 -0700 (PDT)
MIME-Version: 1.0
References: <be58b398-71ff-7c12-1bf1-a09181d9c80@linux.intel.com>
In-Reply-To: <be58b398-71ff-7c12-1bf1-a09181d9c80@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 17 Jun 2022 11:47:37 +0200
Message-ID: <CAHp75VcRgCjD578XrDeuz6WWqMCtS6k-BE7pa4iMfGFkUnhdbg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update DW 8250 UART maintainership
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 11:41 AM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> Add myself as maintainer for DW 8250 UART and up it to Supported.

Thanks!

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>
> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a6d3bd9d2a8d..6c90484f395b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19230,8 +19230,9 @@ F:      Documentation/devicetree/bindings/gpio/sn=
ps,creg-gpio.txt
>  F:     drivers/gpio/gpio-creg-snps.c
>
>  SYNOPSYS DESIGNWARE 8250 UART DRIVER
> +M:     Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>  R:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> -S:     Maintained
> +S:     Supported
>  F:     drivers/tty/serial/8250/8250_dw.c
>  F:     drivers/tty/serial/8250/8250_dwlib.*
>  F:     drivers/tty/serial/8250/8250_lpss.c
>
> --
> tg: (f2906aa86338..) dw/maintainer (depends on: tty-next)



--=20
With Best Regards,
Andy Shevchenko
