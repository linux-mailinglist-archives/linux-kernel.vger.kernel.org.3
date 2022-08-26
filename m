Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA6A5A2B6D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 17:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344152AbiHZPkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 11:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiHZPkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 11:40:36 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C255222BEF;
        Fri, 26 Aug 2022 08:40:33 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id g14so1502981qto.11;
        Fri, 26 Aug 2022 08:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=BBz1rbIuDjVgY8SOEb/J/6vHkLl2zF5hMNhZpHd3Gls=;
        b=ALCc7XOjkA05G+vfYjzMnu5eL8y8qz31JJlYYVlGOFSCVUEJ3BBCJ5P2ctCu/8LjcL
         A3lLi0VVXlvI/9CCWoLPRvR5PPchPlEcXxkp9Uxg3XfOHiUjjM7zi+ftUTcTDT/osffN
         w4G5wzI7cBiuy/dzCmTuOYi7id5WWJ6BQFqPa8YOxUf68vdp0ZKvYZ6e32Tb8vMTK8hG
         /j6sYwsrLapkunaz/6abVMP8nL+6EHVwNDzcE7d6E7WBowl6mgmdUzLdQIwbyP31jl9j
         I+NTX1oVXPetj3Srw2Xb8Q96evZG6ixoY/POg0NwmfAW9iqOp63QnifNe5zhkeCOEm8e
         ymkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=BBz1rbIuDjVgY8SOEb/J/6vHkLl2zF5hMNhZpHd3Gls=;
        b=Lf9jvTeYQLZaNjwyAmVOOb1kmQUElo4xXN6CD2+qLInc1DGHPyktCLCrSkFqKUh9SG
         AKrHMx6/XcvrKqgi3dHk9h0TOELnOyDQV0cKXc0fYycDwNuZm/aXwxzkjzzhbxI0+v4g
         BHjEnr2N5xZG+baNT6bdKNlqvUReOu8yI4xsWRxs4NLGbk7QPJXn3ch0eHbIALmtJoCl
         uKpUxyGIVKc3k4TNmCWKuo/vA77e4S3qzp+LFxQ+wiC+FrzRo4BW9UVBT3SiUowO25nZ
         k4Ud9J1KmcGlbgESgpUOHXt/W7UdWkxrRY6f5EGwC/oSub03ocPWcw3D8kOBAWXDDKDP
         ashQ==
X-Gm-Message-State: ACgBeo3jCaHO28LKyTAqaTgtrx6bpdvMKCmGWxOJtt8pv839vjM81PWL
        FZh6JSeYwPTTD+it+GVZqhCQgaTBhSgA6g/9bk4=
X-Google-Smtp-Source: AA6agR6LNB0+v+psiIwXgSIQnBhtJeuNpT5j5e3kns2O1cE/76sfGCCPuLzoQipQS/hr1xIjOzyVI1pqv/mbRhiD1As=
X-Received: by 2002:a05:622a:491:b0:344:95bf:8f05 with SMTP id
 p17-20020a05622a049100b0034495bf8f05mr248386qtx.61.1661528432951; Fri, 26 Aug
 2022 08:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220826144629.11507-1-ilpo.jarvinen@linux.intel.com> <20220826144629.11507-2-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20220826144629.11507-2-ilpo.jarvinen@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 26 Aug 2022 18:39:57 +0300
Message-ID: <CAHp75Vc8jNDUnEMBcQqe0mvM_o-16TM+f3xjn1NMuedNd6wJZA@mail.gmail.com>
Subject: Re: [PATCH 1/3] serial: Rename vars in uart_get_rs485_config()
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
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

On Fri, Aug 26, 2022 at 5:50 PM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> Make variable names to match uart_set_rs485_config() ones:
>         - rs485 -> rs485_user
>         - aux -> rs485

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
(see below)

> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/tty/serial/serial_core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
> index 12c87cd201a7..9c1bf36b7a93 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1408,16 +1408,16 @@ int uart_rs485_config(struct uart_port *port)
>  EXPORT_SYMBOL_GPL(uart_rs485_config);
>
>  static int uart_get_rs485_config(struct uart_port *port,
> -                        struct serial_rs485 __user *rs485)
> +                        struct serial_rs485 __user *rs485_user)
>  {
>         unsigned long flags;
> -       struct serial_rs485 aux;
> +       struct serial_rs485 rs485;

At the same time you may order it by "the longest line first".

>         spin_lock_irqsave(&port->lock, flags);
> -       aux =3D port->rs485;
> +       rs485 =3D port->rs485;
>         spin_unlock_irqrestore(&port->lock, flags);
>
> -       if (copy_to_user(rs485, &aux, sizeof(aux)))
> +       if (copy_to_user(rs485_user, &rs485, sizeof(rs485)))
>                 return -EFAULT;
>
>         return 0;

--=20
With Best Regards,
Andy Shevchenko
