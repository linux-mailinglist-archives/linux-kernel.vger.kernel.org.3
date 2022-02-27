Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895044C5AD7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 13:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiB0MFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 07:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiB0MFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 07:05:46 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAF44C7A4
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 04:05:08 -0800 (PST)
Received: from mail-wr1-f43.google.com ([209.85.221.43]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MeC5x-1nxuZ20azn-00bGIA for <linux-kernel@vger.kernel.org>; Sun, 27 Feb
 2022 13:05:07 +0100
Received: by mail-wr1-f43.google.com with SMTP id v21so11271403wrv.5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 04:05:07 -0800 (PST)
X-Gm-Message-State: AOAM532O59Mphp7Q9dF47Gw/8lv5bXui8i3r+7SyGLOfZ5WK2aU7Pn9s
        6NwFUbw6AGO9u0UCs/p9xEEhDSpB1OCX+vNTaIY=
X-Google-Smtp-Source: ABdhPJzYjZbAaK84j1f8O9sOHhjBEhL+qXYDb7kn+XfkuZo4Lus2OZ/igr3bS4Ai5oywWEMDGq9BbqZ9+xxxeUYtCl8=
X-Received: by 2002:adf:edc3:0:b0:1ec:5f11:5415 with SMTP id
 v3-20020adfedc3000000b001ec5f115415mr10535753wro.317.1645963506829; Sun, 27
 Feb 2022 04:05:06 -0800 (PST)
MIME-Version: 1.0
References: <20220226222457.13668-1-rdunlap@infradead.org>
In-Reply-To: <20220226222457.13668-1-rdunlap@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 27 Feb 2022 13:04:50 +0100
X-Gmail-Original-Message-ID: <CAK8P3a07PoFGC8jyRG5_CjfVPCc2T79c7Fs_WmHZEkuqtG+oPg@mail.gmail.com>
Message-ID: <CAK8P3a07PoFGC8jyRG5_CjfVPCc2T79c7Fs_WmHZEkuqtG+oPg@mail.gmail.com>
Subject: Re: [PATCH -next] misc: rtsx: fix build for CONFIG_PM not set
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei WANG <wei_wang@realsil.com.cn>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:YWhlWybzj0laFtQGq0VMCggnFydyeR2tuEemTHNFxU7Jm56a9Ht
 OxMy3HeHp5fgNYbJfxrmTur23p1z/6hO373qA/o159Y+w20ViuHqMvJurbbH8OOoXgrQNKb
 +35IWTIIp8PGUn6bQF6v1VXpb8V+RDb4A3n6WzCBEeuESXk1BvJjfh0Q2AlZ4aBRaubJoN0
 gws3mz6PitLcckHqNMruw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d58jILnMKIQ=:iPgL/7H/2pmB9bq0IzJUN/
 EB82Bsm4yF6DhQEsAVI0A8tM224Y2NoYaYw78egDTBqEE+yS1ozz1IfaZkFQX9HuC/pPrYb5/
 1mqVS1whkkdd+TZBTZ06EJvp7jkxHRfJa0DmRYcCuGc4LLtUQ3vziy83K6KufbUPJMXOAcg8S
 ZQfUA8hDPmjmHPcMurH75StqhMTicm3u9+5IEDPvrhNqLr7VlOIrA3zgE5x8+QU8+jPr0NxHB
 YToZcHxT7no9Vp2ydgbpGy8Q+VUHxcG42cUPS0IHr862LzyXcnOa1leDZncPJ9ZtCT5+APAdN
 /ppJnEb2X7GewNGJkIgLjCF9lQcNAVgVe5N7eF7de7t4pjPxW9MqulBlDHtQYFPxiAX4Lk+5q
 V2tWrYMr2CTBjOwPttynKDAXMOPQLXPdgBkLsgBULleksA9WB6lCcxiPPxzlzMn1VfWbQs6ws
 3OSx9CcOvzkrPgR20EMGxrMwG3eLp23xt8l1ezyq0s0b7+eF08ujtAehDbiDofJrVifxroGut
 CQAgLWPNN+3hYKzgKXCDsEaa9AqV/N2obZ94FBTGGEoHq+Mur0WLS7eo55Pj0Nv+eh5Xo/I+L
 VPoayJHdQPHFnq2gobWOdO8IKUv6vczsu1oiFQkrz7wQibKHfBW4dNkeL/rArbjHSciUxia1/
 XELSyf06Tl748kQ/RRRrioEtQfGo+zSkD2j6rZqx4aWxfvy+LPbN+iERr/Bd8L0lraXk=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2022 at 11:24 PM Randy Dunlap <rdunlap@infradead.org> wrote:

> ---
>  drivers/misc/cardreader/rtsx_pcr.c |    2 ++
>  1 file changed, 2 insertions(+)
>
> --- linux-next-20220225.orig/drivers/misc/cardreader/rtsx_pcr.c
> +++ linux-next-20220225/drivers/misc/cardreader/rtsx_pcr.c
> @@ -1054,6 +1054,7 @@ static int rtsx_pci_acquire_irq(struct r
>         return 0;
>  }
>
> +#ifdef CONFIG_PM
>  static void rtsx_enable_aspm(struct rtsx_pcr *pcr)
>  {
>         if (pcr->ops->set_aspm)
> @@ -1085,6 +1086,7 @@ static void rtsx_pm_power_saving(struct
>  {
>         rtsx_comm_pm_power_saving(pcr);
>  }
> +#endif

Now that we have DEFINE_SIMPLE_DEV_PM_OPS() etc, I think we should
no longer add more __maybe_unused annotations or #ifdef CONFIG_PM checks
but just use the new macros for any new files or whenever a warning like
this shows up.

        Arnd
