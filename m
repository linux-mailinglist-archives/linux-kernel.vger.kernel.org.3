Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288CF4DDA7A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 14:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236677AbiCRN27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 09:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236671AbiCRN25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 09:28:57 -0400
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DC612221D;
        Fri, 18 Mar 2022 06:27:33 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id jq9so6490182qvb.0;
        Fri, 18 Mar 2022 06:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hQZn6HCdCoDBrk7b1VDHUCeUiTPMEvUNU16ddZWGYA4=;
        b=FA2X/fFVxOYXJwFJw1B3f4+8l3cn18bCCWmHk2bILLlrHLtM+ls2U3jkRPxtlPMYXE
         o6M9KV2tFGb+Ky8OP9y/fCAJ3HTwSVY6xZVqxnEMP8v/EdTTK5Hsd9JNos1i6IgdZ/i4
         yjTIXRWrzfS3mQ+Ec1BzjhcDPZT9vuOf6s8sY8XFjKR1glHxTNITEfIjj4WkmXrn2vu/
         QrfgQfcplZTqm477g2DZez27wbCdzFwOmU659lNGtIGLJ4nZY92YI9tTb8cnZ6CV7X1p
         qI4f7V2i8jX1qQY3IOoDa9TFwzbOafvu6nmMjbAUR4JPi55GaHbarKqBX9r9jmZC1+Ez
         xKLw==
X-Gm-Message-State: AOAM531qFf2x5IwLSGrYRdjK+icr1JaXh4gbIoZr9gqNu9Esmd8C5TlH
        uDBcFgkucFKbz9U4fuftv7UKJX09RZk4tNzW
X-Google-Smtp-Source: ABdhPJyWrrtb3YLpsKtEloYgLiQI7TcgTjAK03CosJ/rBLDh7z1jol81QZ/p3nznVHyZsJCOd+m8ig==
X-Received: by 2002:a05:6214:21c8:b0:440:ca81:cfae with SMTP id d8-20020a05621421c800b00440ca81cfaemr6623497qvh.19.1647610052536;
        Fri, 18 Mar 2022 06:27:32 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id de26-20020a05620a371a00b0067dc7923b14sm3837101qkb.132.2022.03.18.06.27.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 06:27:32 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id u3so15840238ybh.5;
        Fri, 18 Mar 2022 06:27:32 -0700 (PDT)
X-Received: by 2002:a25:45:0:b0:633:96e2:2179 with SMTP id 66-20020a250045000000b0063396e22179mr10235365yba.393.1647610051868;
 Fri, 18 Mar 2022 06:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220308223324.7456-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220308223324.7456-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220308223324.7456-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 18 Mar 2022 14:27:20 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWwPgg=N=QVwEwkBf8NAVi9rPYfT7Xwq9db8givN+d-Xw@mail.gmail.com>
Message-ID: <CAMuHMdWwPgg=N=QVwEwkBf8NAVi9rPYfT7Xwq9db8givN+d-Xw@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: renesas: r9a07g054: Add OPP table
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

On Tue, Mar 8, 2022 at 11:33 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add OPP table for RZ/V2L SoC.
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
