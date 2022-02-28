Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF714C6F66
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237065AbiB1O1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiB1O13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:27:29 -0500
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C51373061;
        Mon, 28 Feb 2022 06:26:50 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id t22so13134748vsa.4;
        Mon, 28 Feb 2022 06:26:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rHVfZaJmFUUxRDQIT5T7S/1vPYYPoz8peXZ1+ZnXKGg=;
        b=2Ws8LTW2VKWXPa5VjufKbtaRdPmDehrgKSygWsYKb/qQl1633kYsmu2Q7eOCLqZgsp
         0E5b0JDL0iPydM9/j0tRkfYUjrmb9TmNyRzKmElmHHN1ExDoV18N6XFTfmDaEL7g0/qU
         kdufsBeU/QPJCpDfU4x0ZniVVARxhBjRnjE8E4AeSCiaYuOo0e/3uqKF32lsXL1+vS6k
         23f5gGDfRbH2AsYjHiwST/AG98AtD6UGW5HECM9YlBwrB7vkOmACre6DDjEJzdXHRlpW
         DR0qMl0buDlSnTLvvb3kxBn22n1FiVBDMSe8gM4lImDJKBCLplX9kOXmvrAtkg4BKajk
         4R+w==
X-Gm-Message-State: AOAM531b5Kh5kn7H2F9yQyWocGr030JhP2HokjCJ3YUBUG3OzfbKcSpF
        nekBEKrtKE6asfTiVl/2tETMqfDL6xJ6eg==
X-Google-Smtp-Source: ABdhPJxJBe8kFwXiLQ0in7GgJKfoSIk0LfgsB1/plJqIaBs3tfbN45or2P5Izdcb+/e6CGDN7KLC0Q==
X-Received: by 2002:a67:4284:0:b0:31c:1e12:bc0f with SMTP id p126-20020a674284000000b0031c1e12bc0fmr7127346vsa.23.1646058409578;
        Mon, 28 Feb 2022 06:26:49 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id a25-20020a056102025900b0031c34d0f8d5sm1332033vsq.3.2022.02.28.06.26.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 06:26:49 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id u10so13093928vsu.13;
        Mon, 28 Feb 2022 06:26:49 -0800 (PST)
X-Received: by 2002:a67:b00e:0:b0:30d:dc98:6024 with SMTP id
 z14-20020a67b00e000000b0030ddc986024mr8274728vse.57.1646058408965; Mon, 28
 Feb 2022 06:26:48 -0800 (PST)
MIME-Version: 1.0
References: <20220227225309.28098-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220227225309.28098-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 28 Feb 2022 15:26:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWn=jvt_6rt_Z5OpdfStNT2B6sz_WhZvKrptHqOkqe5mg@mail.gmail.com>
Message-ID: <CAMuHMdWn=jvt_6rt_Z5OpdfStNT2B6sz_WhZvKrptHqOkqe5mg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: watchdog: renesas,wdt: Document RZ/V2L SoC
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>
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

On Sun, Feb 27, 2022 at 11:53 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Document RZ/V2L WDT bindings. RZ/V2L WDT is identical to one found
> on the RZ/G2L SoC. No driver changes are required as generic compatible
> string "renesas,rzg2l-wdt" will be used as a fallback.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
