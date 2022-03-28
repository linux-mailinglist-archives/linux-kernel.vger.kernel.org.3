Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D904E8BBF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 03:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237362AbiC1Bsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 21:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236140AbiC1Bse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 21:48:34 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BA94FC58;
        Sun, 27 Mar 2022 18:46:54 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id s11so11209766qtc.3;
        Sun, 27 Mar 2022 18:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=67cH1QE0vg460QdF1Ds8AdGczJLr6DnLmE8iSZO1ujs=;
        b=A7JB/XVw0UT9w6IIs5Klt+1p9jXGtFS1xRgGNL6wbtYUARLZlCQf0eELviKwGuHhKv
         q3aHhwP5cSSnV8VCN5Bl0SREhwWQ3/1/wBd++peoQ8YDbpjQfDBEI4nzCKLUJLgeLqzk
         udImF94NYtKW/fvMjphaCD3ox7NogSxAILHwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=67cH1QE0vg460QdF1Ds8AdGczJLr6DnLmE8iSZO1ujs=;
        b=cC2yRP8QOR1aACv6B2MZpsmmXspVRdwVK9CuF9Cbh6bVo1jUOArOGrDONVBv8nQdSR
         rzYvlX/DVSxmwJjDeJgMmmp+5M+bzRpJpW8/zMLdBgorRr2qg+Kpi9XTNVkbxAbVxyN3
         zj8YpNig4ueUSlpgW3w7k6okqaMk+VVg1oe1gLVAXlxCGgxK5YD8CP5xzSW+QQU0ZPmy
         ZApV3uDJG9lEXuv3jXgG5qjnPYrqyTlY1OIoQRr0ueMJlu5m/X8VLK0KgcUKco3q39XK
         jFHjfNCtGFs9JDSyFjSYI8iDpD6vGLN9wX+ugsSXkIRJV1Gzf2dEM7iGsYAkZByrVMV9
         6RHg==
X-Gm-Message-State: AOAM5339kI/XHtxYdtDmJudn/4iV4S8Vg+SM9cMx18fttsQfQJlDbwUE
        80lf5KCKD28eXOu+PVYrLdmgA2bgpZaWtpSpRbo=
X-Google-Smtp-Source: ABdhPJzZF+DOZf/7yL6b/t0SWJb98IxMQ99154wPILXLwblfo1Q1aUYOE48CprYh/mEGyOgc/+1UzwiH6klt3fR/XOM=
X-Received: by 2002:a05:622a:60c:b0:2e2:7b3:3231 with SMTP id
 z12-20020a05622a060c00b002e207b33231mr19860099qta.678.1648432013473; Sun, 27
 Mar 2022 18:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220328012205.91454-1-andrew@aj.id.au>
In-Reply-To: <20220328012205.91454-1-andrew@aj.id.au>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 28 Mar 2022 01:46:41 +0000
Message-ID: <CACPK8Xc0-VicXV6fG7qMFWsQnf22fccTECZDKf51Aonds8rbVQ@mail.gmail.com>
Subject: Re: [PATCH] leds: pca955x: Remove unused pca95xx_num_led_regs()
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-leds@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        jacek.anaszewski@gmail.com,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Mar 2022 at 01:22, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> Commit 561099a1a2e9 ("leds: pca955x: add GPIO support") removed the
> remaining use of pca95xx_num_led_regs(). Recently the kernel test robot
> started complaining about the unused symbol after some patches to the
> driver were merged[1]. Drop the unused function.
>
> [1] https://lore.kernel.org/all/202203260634.OFB2IPFf-lkp@intel.com/
>
> Fixes: 561099a1a2e9 ("leds: pca955x: add GPIO support")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/leds/leds-pca955x.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/leds/leds-pca955x.c b/drivers/leds/leds-pca955x.c
> index 81aaf21212d7..33ec4543fb4f 100644
> --- a/drivers/leds/leds-pca955x.c
> +++ b/drivers/leds/leds-pca955x.c
> @@ -145,12 +145,6 @@ static inline int pca95xx_num_input_regs(int bits)
>         return (bits + 7) / 8;
>  }
>
> -/* 4 bits per LED selector register */
> -static inline int pca95xx_num_led_regs(int bits)
> -{
> -       return (bits + 3)  / 4;
> -}
> -
>  /*
>   * Return an LED selector register value based on an existing one, with
>   * the appropriate 2-bit state value set for the given LED number (0-3).
> --
> 2.32.0
>
