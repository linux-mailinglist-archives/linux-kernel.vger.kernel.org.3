Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20C953A7F3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 16:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354489AbiFAOEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 10:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354862AbiFAOA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 10:00:59 -0400
Received: from condef-10.nifty.com (condef-10.nifty.com [202.248.20.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D745647389;
        Wed,  1 Jun 2022 06:57:23 -0700 (PDT)
Received: from conssluserg-03.nifty.com ([10.126.8.82])by condef-10.nifty.com with ESMTP id 251DroRc014704;
        Wed, 1 Jun 2022 22:53:50 +0900
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 251DrHXv027234;
        Wed, 1 Jun 2022 22:53:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 251DrHXv027234
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654091597;
        bh=T0jniup0tdMhgXOVsaKHUqsHbruaPRstgNPuoFLQ+pc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ajuAOjVhvv07LABF+8ROyRe/wmobxoWCeF+GBjGsv3BNypwdUeUg6McGwAz7bNhIK
         4ZZK/6ScCItnAHovrWEiOgl4K7feWIPxM7JPZUKhIyKlLOZtfv9iokhck/g56lsjQ0
         7pCd5u9YAsd2HIy9QosDc4hLBPasM7LYTye6z9tXadY+HrJuAqLqxEsNxJDkumPGyF
         jQKKyu1v/bZvvo31xslo0a/64JfjDHkqdIjlBEO587igis0fStzgshgrhTNR7lzuRD
         MOYRGPUz34jV5A9jTRwvzvcQpUyYbABnxstkMylyCeDAGUdTwbB8u9zgdkXXNJ+DZc
         ONI9K0yXitALg==
X-Nifty-SrcIP: [209.85.216.54]
Received: by mail-pj1-f54.google.com with SMTP id v5-20020a17090a7c0500b001df84fa82f8so2130406pjf.5;
        Wed, 01 Jun 2022 06:53:17 -0700 (PDT)
X-Gm-Message-State: AOAM532KUQ3U9cNBzHbt/t6gT7tS1QMXmiC4Hj5XY05WhVA2V4sOKTxK
        NBRnVWYMkI+p/B3SXOsVpH/2qxcjVZIraX3al+I=
X-Google-Smtp-Source: ABdhPJy07hu/OahBY3VJHSQdem7BDQ3c4Qu2+hwvYIGknJt0lPvMr2/KyufRbe4Ma0UKT+AqOzywxd7C0LHddmfLNl4=
X-Received: by 2002:a17:903:1205:b0:15e:8cbc:fd2b with SMTP id
 l5-20020a170903120500b0015e8cbcfd2bmr66483581plh.99.1654091596577; Wed, 01
 Jun 2022 06:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220601130819.11171-1-isak01@gmail.com>
In-Reply-To: <20220601130819.11171-1-isak01@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 1 Jun 2022 22:52:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNAReo0ACB_TbcCXu76OPeK6UQhWtAWOxGq=L88GZB5Tv8g@mail.gmail.com>
Message-ID: <CAK7LNAReo0ACB_TbcCXu76OPeK6UQhWtAWOxGq=L88GZB5Tv8g@mail.gmail.com>
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

On Wed, Jun 1, 2022 at 10:08 PM Isak Ellmer <isak01@gmail.com> wrote:
>
> Make nconfig accept jk keybindings for movement in addition to arrow
> keys.
>
> Signed-off-by: Isak Ellmer <isak01@gmail.com>
> ---

Applied to linux-kbuild.
Thanks.



>  scripts/kconfig/nconf.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/kconfig/nconf.c b/scripts/kconfig/nconf.c
> index 7b371bd7fb36..3ba8b1af390f 100644
> --- a/scripts/kconfig/nconf.c
> +++ b/scripts/kconfig/nconf.c
> @@ -52,8 +52,8 @@ static const char nconf_global_help[] =
>  "\n"
>  "Menu navigation keys\n"
>  "----------------------------------------------------------------------\n"
> -"Linewise up                 <Up>\n"
> -"Linewise down               <Down>\n"
> +"Linewise up                 <Up>    <k>\n"
> +"Linewise down               <Down>  <j>\n"
>  "Pagewise up                 <Page Up>\n"
>  "Pagewise down               <Page Down>\n"
>  "First entry                 <Home>\n"
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
