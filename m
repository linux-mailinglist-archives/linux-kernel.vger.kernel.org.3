Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3DF4AEC90
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 09:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241802AbiBIIeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 03:34:17 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241529AbiBIIeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 03:34:12 -0500
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB7EC03C1A3;
        Wed,  9 Feb 2022 00:34:05 -0800 (PST)
Received: by mail-vs1-f49.google.com with SMTP id r20so1810724vsn.0;
        Wed, 09 Feb 2022 00:34:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E8GmvvUEovjq8L63GgeisXiih83gj7UpFOrlWJvTagg=;
        b=8QXO2GdQY+5+8sABduiRr8lSZIWXpC4yi2IQmWML6cwHzcGyAgcSc37yCd0vGJymfi
         2h3dpSpxkqiXfpMzVailLyMzYGjmdWuiqWs1BljcftkgYe8Ud7ms/u4aNL3rdfazce2K
         R3hT5neHVjXJXNgMaY5L9uImZTN3KCbB8ivNsIM1gWEU4ETsEoIkq0SSftuHvlRc3Wzo
         dE5R1eGS/G0pr5Xwh3Kl5gZf6M0kbJSbkLiR38RGBHvU0bAiYakbWGJvgYeT5aGgLQrB
         cJ0gQQAhpNc052g0wWzE+4p5sW1yFWm71HVLUmltiUt+H6lGfkutUpfGVCni7jSx1RHl
         cibg==
X-Gm-Message-State: AOAM530xYWVT36AQ7Zcw2ER+8x5N75xAL0jUcm6VJH7H4FdlRYLFcf+x
        7WBE8To3mbwT6q7scBgK5iLRKRnKz7vSaA==
X-Google-Smtp-Source: ABdhPJxhDvEtzlzpKOrwHaZqylqIzxdgvsguoeb8soB1a5GSy/wwKO3ijT+hW4TjHRZgfkEg4s6nlA==
X-Received: by 2002:a67:d811:: with SMTP id e17mr353325vsj.7.1644395640415;
        Wed, 09 Feb 2022 00:34:00 -0800 (PST)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id d5sm643227vsd.19.2022.02.09.00.33.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 00:34:00 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id f6so1744080vsa.5;
        Wed, 09 Feb 2022 00:33:59 -0800 (PST)
X-Received: by 2002:a67:a401:: with SMTP id n1mr327572vse.38.1644395639705;
 Wed, 09 Feb 2022 00:33:59 -0800 (PST)
MIME-Version: 1.0
References: <20220208183511.2925304-1-jjhiblot@traphandler.com> <20220208183511.2925304-5-jjhiblot@traphandler.com>
In-Reply-To: <20220208183511.2925304-5-jjhiblot@traphandler.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Feb 2022 09:33:48 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXye8+z9rm25R96nHJz_BSNRHHjizXRTey9OYstdqYBuw@mail.gmail.com>
Message-ID: <CAMuHMdXye8+z9rm25R96nHJz_BSNRHHjizXRTey9OYstdqYBuw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] ARM: dts: r9a06g032-rzn1d400-db: Enable watchdog0
 with a 60s timeout
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, Feb 8, 2022 at 7:35 PM Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
> 60s is a sensible default value.
>
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
