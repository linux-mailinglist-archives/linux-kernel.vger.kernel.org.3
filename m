Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A554C87FF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 10:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbiCAJdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 04:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233824AbiCAJda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:33:30 -0500
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AA8654B;
        Tue,  1 Mar 2022 01:32:48 -0800 (PST)
Received: by mail-vk1-f176.google.com with SMTP id j201so6536796vke.11;
        Tue, 01 Mar 2022 01:32:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FXjE1hDDWL2S020HSBLV7U+4+lMahVb0JHVI1EFr/Gg=;
        b=U8oFuARv+CwXsynEr4dnR83JBZhEQnicC7ArcZm4UezOGqV75OvBxyarTwJWWIKkzi
         KoTPteKD6s3eTou1J/WZ5Se7H+7DNMY0aIEjj6CnemaXQ1mt4/vJsl8R64gRWbUmzYmp
         NZjSxwBwjGsac3SZdNreIF5ZPfEqx5VJwIRJrFhGnxC2CfrRxZ+zinjwmsb8HFPrGdny
         7/q7T3pcMJzdeLZxHLU3+1SaVjpkIUTal2HLnkzCtAv7AeDPO9uCRo4EmNidaPz7aP7n
         dq3h9vmF0B6tuxQkVbOPHwst7Vz7YuHHgfbjn5fTW4HzEYFYKpputGJtPowqmtiYxqBw
         ETHg==
X-Gm-Message-State: AOAM531ReUnTy9gkZ2XSe2QqG41owxldJzh7FTIowIYiN9TKcDgn6TsH
        0j6+VwtFIpoiW0mWKKVOnFS8HFZucodIvA==
X-Google-Smtp-Source: ABdhPJyZgExf2+j28cfJoA7A6tuUdiy5v1onznB7GTFEMcT/xrdzTWbMhAyF/UBK3B/gJ45V+c/6jQ==
X-Received: by 2002:a05:6122:e09:b0:331:d5d4:441 with SMTP id bk9-20020a0561220e0900b00331d5d40441mr9954210vkb.41.1646127167241;
        Tue, 01 Mar 2022 01:32:47 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id x186-20020a1fe0c3000000b00331d1bf1f62sm2355613vkg.54.2022.03.01.01.32.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 01:32:46 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id e26so15905049vso.3;
        Tue, 01 Mar 2022 01:32:46 -0800 (PST)
X-Received: by 2002:a05:6102:4411:b0:31b:6df1:3b80 with SMTP id
 df17-20020a056102441100b0031b6df13b80mr10215855vsb.5.1646127166128; Tue, 01
 Mar 2022 01:32:46 -0800 (PST)
MIME-Version: 1.0
References: <20220227203744.18355-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220227203744.18355-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220227203744.18355-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 1 Mar 2022 10:32:35 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUHWK0v3ic1=-PJn+w5irVQoxx-cVLWVMhN=NfJuSeWAw@mail.gmail.com>
Message-ID: <CAMuHMdUHWK0v3ic1=-PJn+w5irVQoxx-cVLWVMhN=NfJuSeWAw@mail.gmail.com>
Subject: Re: [PATCH 07/12] arm64: dts: renesas: r9a07g054: Fillup the
 OSTM{0,1,2} stub nodes
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
> Fillup the OSTM{0,1,2} stub nodes in RZ/V2L (R9A07G054) SoC DTSI.
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
