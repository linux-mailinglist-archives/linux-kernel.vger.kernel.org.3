Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803B34CF3B6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 09:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236075AbiCGIgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 03:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbiCGIgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 03:36:15 -0500
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C10665D9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 00:35:22 -0800 (PST)
Received: by mail-qk1-f173.google.com with SMTP id d84so11303600qke.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 00:35:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lwoi80hKOWtc+skxMuKJlRziZR969/R4qDCbEpgM3eI=;
        b=npT2OwGeHEwN+zbMyAmgoRMTNwQFElR93vAkMEPCgSrIV/0Wc2/nuLZ/Tw6BxIKw5D
         Z5ezMTPvfHR+xKkJOcqt4fzkgjYg6J7UeqmSPwvFppiuCFpg3t2OydzNxAkRLJJLugYG
         pup+zlcFqFLHB46siXZMLL2kkSQWez+FhA1CTI1Y6xnPrGdK+LYm8xxpOyDiCku7WsT4
         ro5dywZ9cdNBgLO9KCZq+vOBCoaS2kcTdbkSBtE9RdH7xCGYzf7xlUM57u51t2JQdbiI
         iT+YoAVKi1+o5QBJ2JiqcbMMAkJbkEWnbefAw0gzvapOxdZll4GzOyL/mkOCmDrLlGT3
         FziA==
X-Gm-Message-State: AOAM532Ex2SyAGz5xtocg00FbwyadNiiMvaZ6yeeLjF+/lLKoTpPkKvu
        MdQ3M4zVHKKdX4ANqCapn5GFvROyZMjLFw==
X-Google-Smtp-Source: ABdhPJyc2qCJ42FZEiPL00ohfrYXyQfSHr340Dv9eEXWqT68KLVPSLnAKiLByt73h88QUCKUQOX82g==
X-Received: by 2002:a37:6c03:0:b0:663:4abb:52b5 with SMTP id h3-20020a376c03000000b006634abb52b5mr6135640qkc.566.1646642120817;
        Mon, 07 Mar 2022 00:35:20 -0800 (PST)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id r64-20020a37a843000000b0067b0cf40b18sm2347710qke.69.2022.03.07.00.35.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 00:35:19 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id w16so29364596ybi.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 00:35:18 -0800 (PST)
X-Received: by 2002:a25:dc4:0:b0:629:2337:f9ea with SMTP id
 187-20020a250dc4000000b006292337f9eamr5533660ybn.6.1646642118604; Mon, 07 Mar
 2022 00:35:18 -0800 (PST)
MIME-Version: 1.0
References: <298f0644275d7d0b4aa3ee7143756a2431a4900c.1646311443.git.geert+renesas@glider.be>
 <af4cffb7-a519-dea1-4b82-f00e9603ce84@baylibre.com>
In-Reply-To: <af4cffb7-a519-dea1-4b82-f00e9603ce84@baylibre.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Mar 2022 09:35:06 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWS+ExaTFeNQFJdNQ7+5y8wwNh3dnDE1bTtnuNw8-81iw@mail.gmail.com>
Message-ID: <CAMuHMdWS+ExaTFeNQFJdNQ7+5y8wwNh3dnDE1bTtnuNw8-81iw@mail.gmail.com>
Subject: Re: [PATCH] drm: Drop commas after SoC match table sentinels
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
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

Hi Neil,

On Mon, Mar 7, 2022 at 9:30 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
> On 03/03/2022 13:44, Geert Uytterhoeven wrote:
> > It does not make sense to have a comma after a sentinel, as any new
> > elements must be added before the sentinel.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Thank you!

> Tell me if you want me to apply it to drm-misc-next.

Do I have other options? ;-)
Thanks in advance!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
