Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D0E5983A3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244903AbiHRNBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244884AbiHRNBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:01:06 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F86074DFF;
        Thu, 18 Aug 2022 06:01:05 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id cb8so1035783qtb.0;
        Thu, 18 Aug 2022 06:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=zGVvOzOw3FBTHFQT/EuMN6lMzvUv1N/cJk4RG5KAwTQ=;
        b=q8xBcp8cW6k6dOo2NKY3ST6SjuKpyRpBGiTQ/IPluo5tJj7ivPqh6ZtYEQsMN8gW2X
         NMzsba8ULXCPqH4xOdG5glt7L0G2tj3bAaMcUoFK3+ZhsvU8kAayny+w704u+d/p/KuS
         m6PWySkMJfdsCG28U+oG5MqTlw7xgUjw2K0Tq0Uff6d43+HIhG7lM32GnlRLujDRAWVS
         LXTQK6HvgyTmbvSBBdlTkddprUWhZxCVuRjhdIO9OWTbtVkGuG67+nzWQevfU852rw0I
         I7obdl1neCLku8+qN8Pp6Za7hvwx97JIoN1z3HrnVtG4CwDlhdMg/+wQi93NXzSs0xk0
         om7w==
X-Gm-Message-State: ACgBeo0WnqHU6xnqmCeHKtzG+Z24l87HGg9mumqKFSgSpHKyCw13pr9I
        muU1ftC/xAgwDGm0WI6AXs+rlUqwbPBoMQ==
X-Google-Smtp-Source: AA6agR4EWymEQnVwzGos0SwShLSkMgIIIGxXWpaQ1osgKbyN29PSDGXzMC0pipY4rBsM3XTvlfJdiw==
X-Received: by 2002:a05:622a:614:b0:343:487:45d1 with SMTP id z20-20020a05622a061400b00343048745d1mr2319514qta.443.1660827664284;
        Thu, 18 Aug 2022 06:01:04 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id dt2-20020a05620a478200b006bb024c5021sm1514500qkb.25.2022.08.18.06.01.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 06:01:04 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-33365a01f29so39033197b3.2;
        Thu, 18 Aug 2022 06:01:03 -0700 (PDT)
X-Received: by 2002:a25:250b:0:b0:68f:425b:3ee0 with SMTP id
 l11-20020a25250b000000b0068f425b3ee0mr2722232ybl.89.1660827643670; Thu, 18
 Aug 2022 06:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220815151451.23293-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220815151451.23293-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 18 Aug 2022 15:00:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU+srXk8Wv1POMeLaoUnEt6TWUK3KVq-YBAbLtnk9AGjw@mail.gmail.com>
Message-ID: <CAMuHMdU+srXk8Wv1POMeLaoUnEt6TWUK3KVq-YBAbLtnk9AGjw@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] dt-bindings: riscv: Sort the CPU core list alphabetically
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <Conor.Dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 5:16 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Sort the CPU cores list alphabetically for maintenance.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
