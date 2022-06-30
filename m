Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0332C561785
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 12:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbiF3KSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 06:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiF3KSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 06:18:21 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0947B26D4;
        Thu, 30 Jun 2022 03:18:21 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id h187so30695814ybg.0;
        Thu, 30 Jun 2022 03:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VoXYvf7J8M13YBxMTmTnsi6ikqoH1MwKYJUW6+sW6jA=;
        b=l+xjvoyHkxKBWUaxeMnNN//yCLYeBo9MxaIEECt5B4IBxxkbX2xUJeO8rXd1jOOiV6
         zZp/u54Az5A33Xq2t4TryIZuZyyHbWdJJ5Qc6dDzvH7ZoEG4OsMWwXGbLGnEqJC4xADk
         xQof005r0QGNwBOTEqEPZxyn3WxQPScsyDlTINQBJk8coY8dvGyfba2xi87nrpIHjNLj
         u5fXjh1ZMvkFTeMTOzB+lmIzV1IbytHQ6qFUTDyqmO6AkB5HnzGsB0re9ngzeTxf2rd6
         U2ZrbFE29Gm8v/GmzvASh4GkffE/6egG3Ih9UYtEqowNmCWUlpmUFDI/hULRJ7JOmiyp
         ersA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VoXYvf7J8M13YBxMTmTnsi6ikqoH1MwKYJUW6+sW6jA=;
        b=0yVizlP5HYtYlWo2zLdT4FIFS4g0mAjrjKNufpSKt9H/NyNO8zimT/l08PHBi6upwp
         7LRtruKreTbsUoqWMNexdYIWnwq9KJWmBR5pOjo2qp/ovreytspfP+QNV6tTZELjpSEm
         UVwTAdFJJEaTnBKHf1oITxAmH8MScJiFkCGmMJJB6LuLna7datxj8oOspOdgOvgFVMY2
         StJvb8kjqBSFFYvx6wZCAJpS3QN2EEgtA0ra20bt/0MnknoQet6VCJApRkfb4PNMJLqz
         hKB5YsSp6GrDr19AEOu4V1Km/TaIS7czrjSJEQPxgq8mdf7C9iDML98FZLSh2KVu1sF/
         v7PQ==
X-Gm-Message-State: AJIora+b4NLN9QboZbxLkUst8L0Hr0meG51+YX/KOGHIra70c4kiLHvx
        x3jY28EWpAt7E4mJ7fgzwkndbB8H1ckE1vzlqOOeDVMkdMqRpg==
X-Google-Smtp-Source: AGRyM1sZ0/jyT8b9+neGVpNeFK9+ZnmDyE7FYipe2HjDbIQY6VUL6apvtKzzfZ8O8L6YNtv5hiZqINFnPWRX+iK0AO8=
X-Received: by 2002:a25:dd83:0:b0:66c:8d8d:4f5f with SMTP id
 u125-20020a25dd83000000b0066c8d8d4f5fmr8492821ybg.79.1656584300103; Thu, 30
 Jun 2022 03:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220630100536.41329-1-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20220630100536.41329-1-ilpo.jarvinen@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 30 Jun 2022 12:17:42 +0200
Message-ID: <CAHp75VcH9O6=Lk06w3Set==zBEFyseCSDN6OUE3n7g4ZnBM4Bg@mail.gmail.com>
Subject: Re: [PATCH 1/1] 8250_dwlib: Convert bitops to newer form
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, Jun 30, 2022 at 12:08 PM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> Instead of open-coding, use BIT(), GENMASK(), and FIELD_GET() helpers.

FIELD_GET() requires bitfield.h to be included. Is this the case already?
If so,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_dwlib.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/82=
50/8250_dwlib.c
> index da330ef46446..a8bbed74ea70 100644
> --- a/drivers/tty/serial/8250/8250_dwlib.c
> +++ b/drivers/tty/serial/8250/8250_dwlib.c
> @@ -46,21 +46,21 @@
>  #define DW_UART_LCR_EXT_TRANSMIT_MODE  BIT(3)
>
>  /* Component Parameter Register bits */
> -#define DW_UART_CPR_ABP_DATA_WIDTH     (3 << 0)
> -#define DW_UART_CPR_AFCE_MODE          (1 << 4)
> -#define DW_UART_CPR_THRE_MODE          (1 << 5)
> -#define DW_UART_CPR_SIR_MODE           (1 << 6)
> -#define DW_UART_CPR_SIR_LP_MODE                (1 << 7)
> -#define DW_UART_CPR_ADDITIONAL_FEATURES        (1 << 8)
> -#define DW_UART_CPR_FIFO_ACCESS                (1 << 9)
> -#define DW_UART_CPR_FIFO_STAT          (1 << 10)
> -#define DW_UART_CPR_SHADOW             (1 << 11)
> -#define DW_UART_CPR_ENCODED_PARMS      (1 << 12)
> -#define DW_UART_CPR_DMA_EXTRA          (1 << 13)
> -#define DW_UART_CPR_FIFO_MODE          (0xff << 16)
> +#define DW_UART_CPR_ABP_DATA_WIDTH     GENMASK(1, 0)
> +#define DW_UART_CPR_AFCE_MODE          BIT(4)
> +#define DW_UART_CPR_THRE_MODE          BIT(5)
> +#define DW_UART_CPR_SIR_MODE           BIT(6)
> +#define DW_UART_CPR_SIR_LP_MODE                BIT(7)
> +#define DW_UART_CPR_ADDITIONAL_FEATURES        BIT(8)
> +#define DW_UART_CPR_FIFO_ACCESS                BIT(9)
> +#define DW_UART_CPR_FIFO_STAT          BIT(10)
> +#define DW_UART_CPR_SHADOW             BIT(11)
> +#define DW_UART_CPR_ENCODED_PARMS      BIT(12)
> +#define DW_UART_CPR_DMA_EXTRA          BIT(13)
> +#define DW_UART_CPR_FIFO_MODE          GENMASK(23, 16)
>
>  /* Helper for FIFO size calculation */
> -#define DW_UART_CPR_FIFO_SIZE(a)       (((a >> 16) & 0xff) * 16)
> +#define DW_UART_CPR_FIFO_SIZE(a)       (FIELD_GET(DW_UART_CPR_FIFO_MODE,=
 (a)) * 16)
>
>  /*
>   * divisor =3D div(I) + div(F)
> --
> 2.30.2
>


--=20
With Best Regards,
Andy Shevchenko
