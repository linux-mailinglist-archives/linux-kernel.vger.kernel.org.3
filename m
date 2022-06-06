Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B6A53E857
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239825AbiFFOfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239809AbiFFOe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:34:56 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0772E0AA;
        Mon,  6 Jun 2022 07:34:55 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 25so18832420edw.8;
        Mon, 06 Jun 2022 07:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UBnTnofx1egjVYMXsVKnzCrT8go4XNCwGGXlPsFzsQA=;
        b=azV5GzMMa++q0Epo0MDaOVueIR/LwrW+VySLdOxKsvHyTQCveKvSoWdowrxeTsXPis
         ADZ8YkUbT/PDj2crA7LNxwxdiS4cq4XsPY0uZpGm0x7jEeMaU0G9Bg8dYGf/jdzv+9we
         s7/qhctFIOJmUnwcJ28H+yT9Z0eiiNnazOu6o9wBPLmMEDOpwJaKVbecD0UQjb+CarAh
         al2usVJSQfVhO3neOz3ESYjQDU2csK5R1sE9uQDCdq42GlTX8ga3dBlZUTkocXYFkdsw
         vQBstuts0wA5bVPDtO6XRccnYYhtA1Z2flHrqkLctTskaoeftkCx6/3ymFoBjYvv2JgR
         fEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UBnTnofx1egjVYMXsVKnzCrT8go4XNCwGGXlPsFzsQA=;
        b=FVpPCIrF17M2MUwSlUoeSKr9D0U6vHkcGMF0SfqkQwd0XtaoXYSnbDLk8ZTfvLZg2u
         yVJRBM917aN0Z7uVyuphpWDo5Vpgjvc3q7uOpowcM9y7j08XQPnwAHCm4VZAgpFhK7AS
         wciabWMPOSCsqixUemh+cyOtEGsRbltJPE+yZfVuYCX4wFsbGQLOGitSBG+x6gMhrUdT
         fjZW08/hKb88r+uUt/B0p8vw2n8ju1HQ1KohC2uXaWeW9Lb40C+iAfVkuRstvkJKz1R9
         xcgtek9ZFDgyy84hXZpj8jDlr8foBcrLBjE77CFGL0USr2Bki/f+lOoEx/KmLRrJCcNx
         /SXw==
X-Gm-Message-State: AOAM531NGYlEJhnkIdm2+4e6vf9wGItGEpAajUhsVRzOaXIWgP0DIjmt
        IeSJ3nP7gWGtZQux4/5+52PhhwzLOSIz89X73hE=
X-Google-Smtp-Source: ABdhPJwfn4g/UnCK2hjftmJUfPtxQcX/+HyTUYgLkCK+SY1VM8dNkEyDTGXdKyzApGi+XESSlUkKXuaI9VnefDP+/SQ=
X-Received: by 2002:aa7:d481:0:b0:42d:d5fd:f963 with SMTP id
 b1-20020aa7d481000000b0042dd5fdf963mr27412796edr.209.1654526094287; Mon, 06
 Jun 2022 07:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220605083825.9854-1-wangxiang@cdjrlc.com>
In-Reply-To: <20220605083825.9854-1-wangxiang@cdjrlc.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 6 Jun 2022 16:34:17 +0200
Message-ID: <CAHp75VcXnKHnEkov0i-=D_qPsVCY_PjasJ9Dni99fj+uKpHjdQ@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250: 8250_omap: Fix syntax errors in comments
To:     Xiang wangx <wangxiang@cdjrlc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Nishanth Menon <nm@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, Jun 6, 2022 at 5:25 AM Xiang wangx <wangxiang@cdjrlc.com> wrote:
>
> Delete the redundant word 'have'.

Not critical right now, but you may shorten the subject by dropping
"8250:" part in the prefix, just leaving "serial: 8250_omap:" is
enough.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
> ---
>  drivers/tty/serial/8250/8250_omap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index ac8bfa042391..a7a95c013fe6 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -345,7 +345,7 @@ static void omap8250_restore_regs(struct uart_8250_port *up)
>  }
>
>  /*
> - * OMAP can use "CLK / (16 or 13) / div" for baud rate. And then we have have
> + * OMAP can use "CLK / (16 or 13) / div" for baud rate. And then we have
>   * some differences in how we want to handle flow control.
>   */
>  static void omap_8250_set_termios(struct uart_port *port,
> --
> 2.36.1
>


-- 
With Best Regards,
Andy Shevchenko
