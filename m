Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBA0549C7A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345728AbiFMS7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346691AbiFMS6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:58:45 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CCF8A336
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 09:12:05 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id y19so12110456ejq.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 09:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P6lLiFcHNk1LYk41lJatoeCKPrB/NP5ibxP6H+rfMbU=;
        b=WKjgJI44QJjFEdeEeg/V2vwM/ysH6UBEf+SThMJYB5k09nHUmBiCxZOHTcE4OFYK9G
         4gwuPgOXVkN8MSTNMJqrJotfevsWvTOppvK5mjEDbE63hHncgUm5WtROMqoFC8tIU3KN
         c7cJnqGtS7qtrR5yio6WY6UeqUY8TyaYpUna1AIbtVZKqT+Pz9h7JtOR0HTCXCZpXAeN
         Ds/HgqD1bQj+A5ndGZt6DywKpjRr3QTmezSmJctLKy4gE7/z3Y3HuYwzucKsWoINTHvK
         UNJfuTFBTNXgpezdv0/iQqbkPBZ0EWSUi+nzqcMCL6sBvZbjOH8LHbmJzjdl2SjeAVDG
         QKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P6lLiFcHNk1LYk41lJatoeCKPrB/NP5ibxP6H+rfMbU=;
        b=ZTcyo9Ew4XJnRiLKhCXdOPx2zxjOIux1LwQ09tw5Ne/BPjq0AkkUXwnXzWdoV2aIl+
         AA4+y2Htb5P899VoPQEJFVZvLQWOaGYQKv3SLaL3R6NHJ6ns8BfgBvjEDoVDlYROtl/v
         e9OtYj2MF/JCkUjmek++pH5tZ2thcP8q4eXz1UZl+iiwq5htICsVn+R/O7T/WTEk5j6K
         1R6AnIDKIdYCZsYptkARxy1KAGfeVYbCtdnTtZbzKSODQR5bgFi1MqB0NYQcmnOCTDnR
         P/O1kvUHuKT2lABJwNJR2H95DNt62Vi36Urrk+VZksF9KJtFvMS7E0BjXyyPLoepxBjN
         G9mQ==
X-Gm-Message-State: AOAM531MtQT6CbF3tP2gfQ+8AxZf5pPf7I5zbbLbJGQVY3LwysL8LZYn
        WSdG2XPzLqhgyPg9tFd18CkrwFv7vg60uhqfGdfqhg==
X-Google-Smtp-Source: ABdhPJx2YYY2W4TYzHoJIpn3Y15QBwZlPUgrmzriy3AcwiEjKh9UPDmSvoXAIQ/te02GZgqwsYirtnk0B8+m8D7JYxM=
X-Received: by 2002:a17:907:3e21:b0:711:ea36:914e with SMTP id
 hp33-20020a1709073e2100b00711ea36914emr493892ejc.101.1655136723646; Mon, 13
 Jun 2022 09:12:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220613111134.23255-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20220613111134.23255-1-lukas.bulwahn@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 13 Jun 2022 18:11:52 +0200
Message-ID: <CAMRc=Mfa8fMPFTGZcB5Tpj6e-w54u+Oa626+xJyLwHSzcyWCow@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add include/dt-bindings/gpio to GPIO SUBSYSTEM
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 1:11 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Maintainers of the directory Documentation/devicetree/bindings/gpio
> are also the maintainers of the corresponding directory
> include/dt-bindings/gpio.
>
> Add the file entry for include/dt-bindings/gpio to the appropriate
> section in MAINTAINERS.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Linus, Bartosz, please pick this MAINTAINERS addition to your section.
>
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1adf8767422b..d04e74ade88a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8517,6 +8517,7 @@ F:        Documentation/devicetree/bindings/gpio/
>  F:     Documentation/driver-api/gpio/
>  F:     drivers/gpio/
>  F:     include/asm-generic/gpio.h
> +F:     include/dt-bindings/gpio/
>  F:     include/linux/gpio.h
>  F:     include/linux/gpio/
>  F:     include/linux/of_gpio.h
> --
> 2.17.1
>

Applied, thanks!

Bart
