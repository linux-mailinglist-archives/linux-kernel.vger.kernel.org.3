Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70484FBD3E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 15:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346546AbiDKNiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 09:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiDKNiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 09:38:03 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACFD19C32;
        Mon, 11 Apr 2022 06:35:49 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id b33so10595010qkp.13;
        Mon, 11 Apr 2022 06:35:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6S8S+a0YX9xrAM7ZLPpu+Eb5jo+Pr1Yp9P1ijuzXncc=;
        b=rq0LA6dl809CA45g6UnZEmOMAgXLjFJ38JBd8iE1m13fF7LZorRYJUu0Ah8y/1ntoD
         jkVtiCqLu32wIl4/C2fr6+IOSIHoFiWLDPeW/C+0RMaQulgK5pYLyAKOYyBH64ZfqTGj
         NbNFDOjRCUUMutAItvZ5PtOWHt4Di5tIGpM7NziEraigAqSnMVYQKucUcX4cas2MTMk0
         bURbEHDZVAQkiS30Y3G1cRLGFIyy5/ej/CDe8iWuUchZvMTcCceRMx//vn2sf+Dy8gB/
         kqoWNUoRf/7v1vh+xyuMTINiqAiuDyXYbzOMbcC1cT2lcfeCkyrjEFptLUY5fbhecLjo
         13iw==
X-Gm-Message-State: AOAM532/O2mvglTFcoPtISYwoIQDbfILACWJE1cOrarDrF/nJbGw6sEz
        VnE6yRvyvQpP45o5AlScH6MVTwF4f03VAA==
X-Google-Smtp-Source: ABdhPJzMWbiPHJzD5E/tJf58XoC7dnkFOUfvfYVfnqs00RzsVK0ywczkbe+JqVy07bLaQ5IMZ7599A==
X-Received: by 2002:a05:620a:424e:b0:67e:4c1b:baef with SMTP id w14-20020a05620a424e00b0067e4c1bbaefmr22077478qko.778.1649684147723;
        Mon, 11 Apr 2022 06:35:47 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id s12-20020a05622a018c00b002e1cd88645dsm25399711qtw.74.2022.04.11.06.35.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 06:35:47 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-2ec05db3dfbso44230457b3.7;
        Mon, 11 Apr 2022 06:35:47 -0700 (PDT)
X-Received: by 2002:a0d:e743:0:b0:2eb:3106:9b32 with SMTP id
 q64-20020a0de743000000b002eb31069b32mr26595858ywe.512.1649684146995; Mon, 11
 Apr 2022 06:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220406172956.3953-1-wens@kernel.org> <20220406172956.3953-3-wens@kernel.org>
In-Reply-To: <20220406172956.3953-3-wens@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Apr 2022 15:35:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUMc35MrWwbDXvsRNx9qSRf1bACNrhsGpeFcLCETsL4dw@mail.gmail.com>
Message-ID: <CAMuHMdUMc35MrWwbDXvsRNx9qSRf1bACNrhsGpeFcLCETsL4dw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: display: ssd1307fb: Add entry for
 SINO WEALTH SH1106
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
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

Hi Chen-Yu,

On Wed, Apr 6, 2022 at 10:13 PM Chen-Yu Tsai <wens@kernel.org> wrote:
> From: Chen-Yu Tsai <wens@csie.org>
>
> The SINO WEALTH SH1106 is an OLED display driver that is somewhat
> compatible with the SSD1306. It supports a slightly wider display,
> at 132 instead of 128 pixels. The basic commands are the same, but
> the SH1106 doesn't support the horizontal or vertical address modes.
>
> Add a compatible string for it.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
> +++ b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
> @@ -13,6 +13,7 @@ maintainers:
>  properties:
>    compatible:
>      enum:
> +      - sinowealth,sh1106-i2c

Please don't introduce new compatible values including the bus type.
There is no need for that, and this will only lead to more deprecated
compatible values soon...

Oops, this is already commit 97a40c23cda5d64a ("dt-bindings:
display: ssd1307fb: Add entry for SINO WEALTH SH1106") in
drm-misc/for-linux-next...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
