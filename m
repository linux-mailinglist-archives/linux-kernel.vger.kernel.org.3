Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDEE653FB18
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240938AbiFGKXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240914AbiFGKX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:23:28 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509AF52B32;
        Tue,  7 Jun 2022 03:23:27 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id m20so34167539ejj.10;
        Tue, 07 Jun 2022 03:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OukCrFCJWq9SsUmHm9/OILUsFtIRnUo2aSEz9DprVgw=;
        b=AtgqPcm8kAiaknV8i+YKMCjp6/4+RDOT9zF+4AcqbyVIuNs0/eD+1rC19j2Nx08Uvh
         t3/y08Mofm2FfgVMLmysPvpS5AqGE+A+UOCufdC6PFhLwBmx2rrVe8DN8Jr9HvkJgxdF
         0cj7aJHdRuBWVDvUNXgWAExZZPd9cVBaOQ16EoWfpW72fXfQopCC1cKjLcyx55RjhoCw
         1wK+Sr8pwCa0OaUf15NuJ4sB4HR7Irq3GpdfYSvGVDDdWQzQHiRpAJ/zrozPbuj0m7pN
         LbI0zoAdBZEKZtZSztO+N1SHbqvhyrXCHv2+FdsyWD+nFXl/iv3TmDUP750mMCNmoJd/
         0qVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OukCrFCJWq9SsUmHm9/OILUsFtIRnUo2aSEz9DprVgw=;
        b=uayppVbnbpYgD8c4hHsHNB4d5+AvjppMf4X7nLeQRqGn29PwDnSnw3Lp7l2tSdoRLf
         ErvtjaE5F18ElpCmfwEbJfXcmt9LtfQUH931BOIbU3nnGOsV2FC9GVsueVD4uC7tlYQe
         bYOzm2Aa2wG6cAOI3oCWUN60JxuXIOAO4HFr28PqTTOfOVnfELTnsEp2sHYa4D9hfPVz
         nITUGmzmprNC4ocO5a0ZnBzytHcWuTt+5udIOBY9i0K54cYcKKIR6E4vDtlHBy/uyFTF
         FiuiVIhb8Ke8w2VbJQVfyujiWAQMDzT09uww3RpsOt1ywbJIjJ+zrDddYEnHCH/G5mpf
         6m1A==
X-Gm-Message-State: AOAM530No8yjhtRXXmMRMvnroNvzocYUKfZ5yIDOhPZP3ZqsCOb7tzgP
        yFPkUOF1zSDaut753GWncUJ8IPSrdzybqIxaLzlRfQu37usyGQ==
X-Google-Smtp-Source: ABdhPJydW7GF6K0z85km7pWjsn//lCcEbNe6RTaKvs4doPsBXgA/hZ865RbeQF5H/M8ogZSSTMR0VHtN68EW/0MBphU=
X-Received: by 2002:a17:906:1193:b0:70d:cf39:a4db with SMTP id
 n19-20020a170906119300b0070dcf39a4dbmr20407572eja.44.1654597405812; Tue, 07
 Jun 2022 03:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220607082934.7242-1-ilpo.jarvinen@linux.intel.com> <20220607082934.7242-5-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20220607082934.7242-5-ilpo.jarvinen@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 7 Jun 2022 12:22:49 +0200
Message-ID: <CAHp75VfK4v15HrBwwD9b7q6EYdcp3VnP5RGKVuPeSWk4TSyq+w@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] serial: 8250: Adjust misleading LSR related comment
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
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

On Tue, Jun 7, 2022 at 11:16 AM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> serial8250_rx_chars() has max_count based character limit. If it
> triggers, the function returns old LSR value (and it has never returned

the old

> only flags which were not handled). Adjust the comment to match
> behavior and warn about which flags can be depended on.
>
> While I'd have moved LSR read before LSR read and used serial_lsr_in()
> also here but I came across this old discussion about the topic:

>   https://www.spinics.net/lists/linux-serial/msg20555.html

Can it be transformed to lore.kernel.org link? and maybe even moved as
BugLink tag?

> ...so I left it as it is (it works as long as the callers only use
> a subset of the LSR flags which holds true today).

With comments addressed,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_port.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index a0ea048eb2ad..686891f1b2ca 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1782,9 +1782,12 @@ void serial8250_read_char(struct uart_8250_port *u=
p, unsigned char lsr)
>  EXPORT_SYMBOL_GPL(serial8250_read_char);
>
>  /*
> - * serial8250_rx_chars: processes according to the passed in LSR
> - * value, and returns the remaining LSR bits not handled
> - * by this Rx routine.
> + * serial8250_rx_chars: Read characters. The first LSR value must be pas=
sed
> + * in.

While at it, I would do the following:
1) keep on one line;
2) replace : with -.

The idea behind is to easily convert to kernel doc in the future if
needed, or at least be consistent with kernel doc format.

> + *
> + * Returns LSR bits. The caller should rely only non-rx related LSR bits

rely only on

non-Rx

> + * (such as THRE) because the LSR value might come from an already consu=
med
> + * character.
>   */


--=20
With Best Regards,
Andy Shevchenko
