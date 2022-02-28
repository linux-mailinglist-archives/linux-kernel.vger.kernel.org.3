Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829EF4C6FAF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237231AbiB1OkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236629AbiB1OkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:40:13 -0500
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE547EB30;
        Mon, 28 Feb 2022 06:39:31 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id w4so13203433vsq.1;
        Mon, 28 Feb 2022 06:39:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NgPIIS3M2iTi6HGFIRcC5El8608r4c/KqNVPec9SSG4=;
        b=ffmocanYAypu5L+ic6J4Ofg+rMeCmubsQkdIU4eiZPn6NIVFxkZMts/h5/a8JJltFU
         QOmGFQf+6STnU1ndj11APO1Vx1qA/RYd4rZ554Cdx7dhnzv8AUIjrN2s6padSHy/Dm3g
         RQ1K9/cA6PPU0XLrOlF1cyyPMb18IGsreaQ1OyUFiGzkbb+oYYmnxd9bWdFrAXJsXueJ
         Jn9+61dtJbblTv2XxbjmeR8Wqludz0GBoMOqJIHZvhcx6x7WhUrPg+ascfMjUyrqCs88
         MiWKdaNey7GbiqLJNaxkxfOhOSNonXm0gwQRXfD+fUeST7Eh4sXBE++sAMVlssWYlm6h
         rddA==
X-Gm-Message-State: AOAM530MsidFvP3VUJhw4V+hSyJdm2JLidEqV0uOIbdMgr/OYAsONsBG
        5NQRrZeJwVkh4Ksfq3SdlxnQLccOgGJAvA==
X-Google-Smtp-Source: ABdhPJxy2QXChRRRWCURNZDdchQO0wgb0eFxxABpB3l0RqxmsL2eGT98L6xaShVkxMBpC0ndRXro0w==
X-Received: by 2002:a67:cc19:0:b0:31b:b3be:a32a with SMTP id q25-20020a67cc19000000b0031bb3bea32amr7907335vsl.80.1646059170808;
        Mon, 28 Feb 2022 06:39:30 -0800 (PST)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id g21-20020a056102245500b0031b6426f679sm1332980vss.26.2022.02.28.06.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 06:39:30 -0800 (PST)
Received: by mail-vk1-f169.google.com with SMTP id l10so5259609vki.9;
        Mon, 28 Feb 2022 06:39:30 -0800 (PST)
X-Received: by 2002:a05:6122:ca1:b0:330:b95b:e048 with SMTP id
 ba33-20020a0561220ca100b00330b95be048mr8242679vkb.39.1646059170224; Mon, 28
 Feb 2022 06:39:30 -0800 (PST)
MIME-Version: 1.0
References: <20220227231531.32279-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220227231531.32279-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 28 Feb 2022 15:39:19 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVzMFwHnfmybZAoqqa0sW1QiHYSYvKoS68m_y0+BjB=rA@mail.gmail.com>
Message-ID: <CAMuHMdVzMFwHnfmybZAoqqa0sW1QiHYSYvKoS68m_y0+BjB=rA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: usb: renesas,usbhs: Document RZ/V2L bindings
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        USB list <linux-usb@vger.kernel.org>
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

On Mon, Feb 28, 2022 at 12:15 AM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Document RZ/V2L (R9A07G054) SoC bindings. USBHS block is identical to one
> found on RZ/A2 SoC. No driver changes are required as generic compatible
> string "renesas,rza2-usbhs" will be used as a fallback.
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
