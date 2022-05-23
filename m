Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81511531C1B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244396AbiEWRsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 13:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242232AbiEWR1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 13:27:32 -0400
Received: from condef-05.nifty.com (condef-05.nifty.com [202.248.20.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8591D71DBD;
        Mon, 23 May 2022 10:22:44 -0700 (PDT)
Received: from conssluserg-02.nifty.com ([10.126.8.81])by condef-05.nifty.com with ESMTP id 24NHG9Sw006904;
        Tue, 24 May 2022 02:16:09 +0900
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 24NHFlcu010153;
        Tue, 24 May 2022 02:15:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 24NHFlcu010153
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653326147;
        bh=OGFOsJaaPXTp7udfTBYwnoLO5n8NJB9yqzeeBC2uWGM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j+5jAm9nSHBtPB2Bm2fgLzp42GcQz0hP9lzKC9wM5o8LQ7y68AD787wckNJm9AzkP
         Cjnaxd055ZHKvu9UlMi04sxx2SUb9m1leOExEauRGH4CTxMWE3ctLzeByDq+JPMKFr
         7RijYQ5hKnswouCnMpu7JvIg66kWeUwk5jjz7/rAyJbZgHdQwHDvmb+uca1ZQ3wmAW
         DgJC/ZKEbOBVOZZQb4RWhIfP5KuKbEW+RT+ufaMEnPdx805uO/xmHutcmsKYPIV6i2
         KAPHok8toA+ylwrZn8o1UkoypxxSp1io4sGhLWtc1l8I1ZbisBS0tLmfr590iXHRtK
         1lo3RURqiKULg==
X-Nifty-SrcIP: [209.85.210.44]
Received: by mail-ot1-f44.google.com with SMTP id h9-20020a056830400900b0060b03bfe792so4171879ots.12;
        Mon, 23 May 2022 10:15:47 -0700 (PDT)
X-Gm-Message-State: AOAM533j0uFvUbZHUvHD9/23I2Zm1uK2Ru7YBj/GUeEjGnyem5oDOEoc
        r9WmMZiNQ8KuKPxAvrMIbDcPBTJv4mX13JKLRmk=
X-Google-Smtp-Source: ABdhPJwC/BX9iJtS+me6WCgh4FiVSqSYSjIxoKwp6SUa5MgtH+0lF8YXyOeBRLO/3zxlti48fNjV9tfjg53LtYszjEM=
X-Received: by 2002:a9d:34d:0:b0:60a:ebab:f100 with SMTP id
 71-20020a9d034d000000b0060aebabf100mr6988834otv.55.1653326146590; Mon, 23 May
 2022 10:15:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220516092423.14327-1-isak01@gmail.com>
In-Reply-To: <20220516092423.14327-1-isak01@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 24 May 2022 02:14:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNATfGqzikgDLvK2tTK91ynDsS59G7K7OZobyd+=MOqF_4A@mail.gmail.com>
Message-ID: <CAK7LNATfGqzikgDLvK2tTK91ynDsS59G7K7OZobyd+=MOqF_4A@mail.gmail.com>
Subject: Re: [PATCH] scripts: kconfig: nconf: make nconfig accept jk keybindings
To:     Isak Ellmer <isak01@gmail.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 6:24 PM Isak Ellmer <isak01@gmail.com> wrote:
>
> Make nconfig accept jk keybindings for movement in addition to arrow keys.
>
> Signed-off-by: Isak Ellmer <isak01@gmail.com>
> ---


I am fine with this.


Can you update the help message?


Around line 55:

"Linewise up                 <Up>\n"
"Linewise down               <Down>\n"










>  scripts/kconfig/nconf.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/scripts/kconfig/nconf.c b/scripts/kconfig/nconf.c
> index 7b371bd7fb36..ded40e5aabf8 100644
> --- a/scripts/kconfig/nconf.c
> +++ b/scripts/kconfig/nconf.c
> @@ -1105,9 +1105,11 @@ static void conf(struct menu *menu)
>                                 break;
>                         switch (res) {
>                         case KEY_DOWN:
> +                       case 'j':
>                                 menu_driver(curses_menu, REQ_DOWN_ITEM);
>                                 break;
>                         case KEY_UP:
> +                       case 'k':
>                                 menu_driver(curses_menu, REQ_UP_ITEM);
>                                 break;
>                         case KEY_NPAGE:
> @@ -1287,9 +1289,11 @@ static void conf_choice(struct menu *menu)
>                                 break;
>                         switch (res) {
>                         case KEY_DOWN:
> +                       case 'j':
>                                 menu_driver(curses_menu, REQ_DOWN_ITEM);
>                                 break;
>                         case KEY_UP:
> +                       case 'k':
>                                 menu_driver(curses_menu, REQ_UP_ITEM);
>                                 break;
>                         case KEY_NPAGE:
> --
> 2.35.1
>


-- 
Best Regards
Masahiro Yamada
