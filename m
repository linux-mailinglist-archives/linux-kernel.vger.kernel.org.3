Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97886598694
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343864AbiHRO4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343852AbiHRO4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:56:21 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59266BD0A6;
        Thu, 18 Aug 2022 07:56:12 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id y18so1282290qtv.5;
        Thu, 18 Aug 2022 07:56:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Z5riCaypRqhNHMxmNIhnODlP9dCEQqyLvOBXtOwqdlQ=;
        b=E8bkGO6PUCXAshIvoamIdOzAC2O4p7zs+36Ttl6NkvkyEN+747BFDTe69XnVz3D/6V
         9pBKrGwQrJa5xEUozPVXODDLkspn0+M/Z6lJ0vCp9nElDApb9MBjZQcPwBGn+XSWZl7o
         HvWk3sKQSBduAVkRYQ07plM2lHklA4CKRGte0pCHNF5RT+/4ssjb0mlAgg0jk1NSx8m1
         xWK4GPGD5giQMd+HNAZOaeJqS+AwJCCbXowbjiTOhNXVOCdaGhRjJVBpeZsoQB1zh/AK
         68n+F75lE/dZUQ+Y384e7WREcj5dAkxyQnbU1gcNYwL7iCDNMTEHEEfUZVJWNLoz9ff6
         E6GQ==
X-Gm-Message-State: ACgBeo2fm3TgC32J5+aGXCHm+LlNKgDYbrgvRlcTn+zVvYZe3qTiSlWa
        MQ3MSnL83LSa9mN+YpiQ3gfJK4s+qL48vQ==
X-Google-Smtp-Source: AA6agR5Ebjm/s8oU54E86TfyViN/0FPqnPBXu04+q3QB6twTZWxUxKhMCfkxIiwWiNZ+WM9Va8NSpw==
X-Received: by 2002:a05:622a:552:b0:342:f8c2:442 with SMTP id m18-20020a05622a055200b00342f8c20442mr2972817qtx.478.1660834571031;
        Thu, 18 Aug 2022 07:56:11 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id g7-20020a05620a40c700b006a6ebde4799sm563332qko.90.2022.08.18.07.56.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 07:56:10 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-31f445bd486so47283337b3.13;
        Thu, 18 Aug 2022 07:56:10 -0700 (PDT)
X-Received: by 2002:a81:658:0:b0:334:a23e:6caa with SMTP id
 85-20020a810658000000b00334a23e6caamr3027947ywg.283.1660834569918; Thu, 18
 Aug 2022 07:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220815151451.23293-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220815151451.23293-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 18 Aug 2022 16:55:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXxxdfGoqELDZY7fT2v=hv1Kgsy=nrTSLivaDQVy0FMww@mail.gmail.com>
Message-ID: <CAMuHMdXxxdfGoqELDZY7fT2v=hv1Kgsy=nrTSLivaDQVy0FMww@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] dt-bindings: riscv: Add Andes AX45MP core to the list
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
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
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 5:16 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> The Renesas RZ/Five microprocessor includes a RISC-V CPU Core (AX45MP
> Single) from Andes. In preparation to add support for RZ/Five SoC add
> the Andes AX45MP core to the list.
>
> More details about Andes AX45MP core can be found here:
> [0] http://www.andestech.com/en/products-solutions/andescore-processors/riscv-ax45mp/
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
