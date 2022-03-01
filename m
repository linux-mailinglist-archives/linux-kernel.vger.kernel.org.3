Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F3F4C87F8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 10:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbiCAJde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 04:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbiCAJd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:33:27 -0500
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39C5CFA;
        Tue,  1 Mar 2022 01:32:42 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id q9so15905582vsg.2;
        Tue, 01 Mar 2022 01:32:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qpscL9B8Nz+lvpBTfdUs1xuYvC00k/bdpIJSBHlbzjY=;
        b=UjaBXvJ6XUTS+onNV5lIuzvcEfJn6FaQ6XQUnw2MiV8waRgr4IexKsQGa7sKvIrotu
         fFOxZfZaN3FhZ6m+yKNOywmbb1fnt49eu/wrWIJ2N0zNldt7q3yaQoIu0e71SqHJQvWV
         YKujrwDqWMDaJk/Sd2HlbF1vJlmSn0AbxuvxK2lAoiM62tAtlyBJJTKt5ba3LOF4F/LX
         4wgQZYG97hI5yvc23nSzTNIZcTDKaAzkrCdSYoJg2NjoE5b+X8tauAdBjI4AAPEyKINt
         u/05E9Yh1Y8tJE5weV8CA6WlTGKdPJRT6RNMTBhr0ACQvpCIPEvisW1tGaC5yIfmEBBD
         buUQ==
X-Gm-Message-State: AOAM530m/YL36TB0PwK9DFb9g9u7AJ6LBiJL5dhfuP78KJWUKTHwvOIm
        oBzrV0OY0qc5kf8jtdE4yIKyb2F7VWFLQg==
X-Google-Smtp-Source: ABdhPJxTz6mNov2ew16/GO+qY5kYysQYIMngc20fOi8igCoTnJR4LEcbr3Hv5bMd+VuNVBiH0LxyVQ==
X-Received: by 2002:a67:e24e:0:b0:31b:f9d7:612e with SMTP id w14-20020a67e24e000000b0031bf9d7612emr9926619vse.51.1646127161086;
        Tue, 01 Mar 2022 01:32:41 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id g9-20020a67fac9000000b0031e6f70befdsm1485235vsq.12.2022.03.01.01.32.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 01:32:40 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id l45so1700886uad.1;
        Tue, 01 Mar 2022 01:32:40 -0800 (PST)
X-Received: by 2002:ab0:7043:0:b0:306:68f7:efb1 with SMTP id
 v3-20020ab07043000000b0030668f7efb1mr9522842ual.30.1646127160138; Tue, 01 Mar
 2022 01:32:40 -0800 (PST)
MIME-Version: 1.0
References: <20220227203744.18355-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220227203744.18355-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220227203744.18355-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 1 Mar 2022 10:32:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWinXFByLXkLMExwAC12P8nbpFMuexp3E3RDbcEkJVSfg@mail.gmail.com>
Message-ID: <CAMuHMdWinXFByLXkLMExwAC12P8nbpFMuexp3E3RDbcEkJVSfg@mail.gmail.com>
Subject: Re: [PATCH 05/12] arm64: dts: renesas: r9a07g054: Fillup the
 I2C{0,1,2,3} stub nodes
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
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

On Sun, Feb 27, 2022 at 9:38 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Fillup the I2C{0,1,2,3} stub nodes in RZ/V2L (R9A07G054) SoC DTSI.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.19.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
