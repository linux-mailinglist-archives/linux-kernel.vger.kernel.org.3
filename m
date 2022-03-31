Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5FA4EDBF9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 16:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237778AbiCaOrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 10:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237769AbiCaOrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 10:47:17 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A4721F741
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 07:45:30 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id l129so47373pga.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 07:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xfgQ/hscjntjkhJSqBIVuqsDyT9JqCFw1yADTCT6VNE=;
        b=Cryxz/U8r/au4gncdA6PFS4KnQRehXkJCb4NW/0WwLNKYU7vCN5x7eiLjdr4Ugiw6c
         JOu5V+jsvCxSbN42aNqVn8+72/h3nzHgIkPV9sglTAVs4mCC+la1s8m9N8OLeBGCHroy
         y8MQPdmk1jb3DbTZaGSQ/TxSxE37QtYlmIcgDbp1T5KrCpoFhrTHjHNG/a6P497bM1jn
         ZoaGE0XeL/ZaTwCTnp7Kpl9Lz/zaoNon/4630NoUQ2APo9intRbCFIFSkqB9CbUEq/Le
         VRB48KINZDFcuXec4eJJ7XWAmQBqHc+7nQn8DLrcoSsI3ESgIAh2YE3G6kef1vfrilPW
         sOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xfgQ/hscjntjkhJSqBIVuqsDyT9JqCFw1yADTCT6VNE=;
        b=7deoo4oPbO70cCCk2hYOrrJ5O0VEEaViTvUtf6GllGhjiDhSJIXoLYHIm8qOMq8Sz6
         fQtkjF6iYf66keKaKb9fRG2XXVLqQgov82uVolMNqHK4OPjT3aD12hB8kc3rkjORo47W
         7Tgp2PGZtTX6fi0iQmHTb9wOQku7RVUTx/CBZsYEv2eb2P3smQJKzI1fYRkMpYeUqPGo
         5lhodn85u7eAUxy+yJVvjhgZdGfqmzVmGU3O9cDKdb4adCG0WxWGsx58gB21D7efl9NC
         xP3KlrRDnFxHn7LZ80R8j6y7uCsIhtxpe+akF03/a/DtB2EH9/xJoBuMExy9Z/3khAZS
         7q1w==
X-Gm-Message-State: AOAM532ocy2gLYZ2gpA96BubXZRmcYJNjOVL5qouYk+reZErvgU1DBJc
        12EriSxHdRmKoJkeLrwuhVUoB5Qrsadewzqc5n3h6NpthpBrgw==
X-Google-Smtp-Source: ABdhPJz6odjogXjPbjZQSVOrxXIiwODUM/iF16NtaeIDQXPhupgqi2mu1m6o2ftpKXyPUeOM5+O5C4V8KNStHFGJano=
X-Received: by 2002:a63:d34c:0:b0:381:b709:4e21 with SMTP id
 u12-20020a63d34c000000b00381b7094e21mr10984364pgi.267.1648737929694; Thu, 31
 Mar 2022 07:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220329201426.16396-1-kris@embeddedTS.com>
In-Reply-To: <20220329201426.16396-1-kris@embeddedTS.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 31 Mar 2022 16:45:18 +0200
Message-ID: <CAMRc=Me-WKUGcCAVFfuoO+dW8D2SeP5zyeCdpAygKQUsJT61cg@mail.gmail.com>
Subject: Re: [PATCH] gpio: ts5500: Fix Links to Technologic Systems web resources
To:     Kris Bahnsen <kris@embeddedts.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Featherston <mark@embeddedts.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 10:15 PM Kris Bahnsen <kris@embeddedts.com> wrote:
>
> Technologic Systems has rebranded as embeddedTS with the current
> domain eventually going offline. Update web/doc URLs to correct
> resource locations.
>
> Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>
> ---
>  drivers/gpio/gpio-ts5500.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-ts5500.c b/drivers/gpio/gpio-ts5500.c
> index b159e92a3612..8e03614c7a24 100644
> --- a/drivers/gpio/gpio-ts5500.c
> +++ b/drivers/gpio/gpio-ts5500.c
> @@ -11,11 +11,11 @@
>   * Actually, the following platforms have DIO support:
>   *
>   * TS-5500:
> - *   Documentation: http://wiki.embeddedarm.com/wiki/TS-5500
> + *   Documentation: https://docs.embeddedts.com/TS-5500
>   *   Blocks: DIO1, DIO2 and LCD port.
>   *
>   * TS-5600:
> - *   Documentation: http://wiki.embeddedarm.com/wiki/TS-5600
> + *   Documentation: https://docs.embeddedts.com/TS-5600
>   *   Blocks: LCD port (identical to TS-5500 LCD).
>   */
>
> --
> 2.11.0
>

Applied, thanks!

Bart
