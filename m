Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9154B510B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 14:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353881AbiBNNFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 08:05:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344837AbiBNNFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:05:12 -0500
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34F24D609;
        Mon, 14 Feb 2022 05:05:03 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id w4so145828vsq.1;
        Mon, 14 Feb 2022 05:05:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I0muS2xi2hk0SUx2u+TUmvYAZnrflht6LNuoC/eSby8=;
        b=A4IShW5nz70VNL7ZMkaREL5ATxGtMHOjVO1agXYe0RxO7VdL/wlWck/qFmJl/hXvuK
         aIz1PbUcFL52IPQSlM3gsCm4kmzGqHEgk/g8buQ+FzQJxSdZaXqR520wm2LtaqZKSRo2
         yK/5XeF/D2u0OGg8YuWwHyVyED6oYiHbVO43w4YW0SVoDM8ZAnehMpR0847S+P5n6HwA
         lwxciuzV2Q/Nw1al40stwD1BG9ExcncGs5+9WXU7A6PS/u3K4itPy4xUHyVbaJVPejeC
         trcUo78l3G2lvx0sPtCWIcJrPvJ8YhBz/k6io8801mnBZlqFnUCicEpWCDphDsx8as4L
         j/2g==
X-Gm-Message-State: AOAM533JCgrcqp+BKa4T3PehQjb6+gwYtgemi8ULFIsSOf6kHUljeb7d
        zeMsv/SpkjAIVsVRN+KYw5oHZcru2cENxw==
X-Google-Smtp-Source: ABdhPJwedacpOLXEDkcLBfzfjh3w5jYvZQPPp+78mMl3W7K5dALR+FN748Cu4v04HN/PHzX+JdK0dw==
X-Received: by 2002:a05:6102:3e90:: with SMTP id m16mr1417142vsv.21.1644843902945;
        Mon, 14 Feb 2022 05:05:02 -0800 (PST)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id l7sm2959561uai.5.2022.02.14.05.05.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 05:05:02 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id p7so7606406vsg.2;
        Mon, 14 Feb 2022 05:05:02 -0800 (PST)
X-Received: by 2002:a67:ec0c:: with SMTP id d12mr3442288vso.77.1644843902259;
 Mon, 14 Feb 2022 05:05:02 -0800 (PST)
MIME-Version: 1.0
References: <2f108f63-0cf7-cc4c-462e-ec63736234cf@omp.ru>
In-Reply-To: <2f108f63-0cf7-cc4c-462e-ec63736234cf@omp.ru>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 14 Feb 2022 14:04:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWRYf7Lh--YPkpnHrnSBGTF52EpuZD+COv==L2scsj2PQ@mail.gmail.com>
Message-ID: <CAMuHMdWRYf7Lh--YPkpnHrnSBGTF52EpuZD+COv==L2scsj2PQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: specify IRC channel for Renesas ARM32 port
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

On Thu, Feb 10, 2022 at 6:58 PM Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
> The Renesas ARM ports do have their own IRC channel #renesas-soc (initially
> created on Freenode, then moved to Liberta.Chat).  Hopefully, adding it to
> this file will attract more people... :-)
>
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Thanks for your patch!

> --- renesas-devel.orig/MAINTAINERS
> +++ renesas-devel/MAINTAINERS
> @@ -2638,6 +2638,7 @@ ARM/SHMOBILE ARM ARCHITECTURE
>  M:     Geert Uytterhoeven <geert+renesas@glider.be>
>  M:     Magnus Damm <magnus.damm@gmail.com>
>  L:     linux-renesas-soc@vger.kernel.org
> +C:     irc://irc.libera.chat/renesas-soc

Should be moved between Q and T below...

>  S:     Supported
>  Q:     http://patchwork.kernel.org/project/linux-renesas-soc/list/
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git next

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.18, with the above fixed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
