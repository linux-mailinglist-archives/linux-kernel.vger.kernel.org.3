Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECDD4C8804
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 10:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbiCAJeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 04:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233891AbiCAJdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:33:44 -0500
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E347BBF7E;
        Tue,  1 Mar 2022 01:32:56 -0800 (PST)
Received: by mail-vk1-f181.google.com with SMTP id j201so6536958vke.11;
        Tue, 01 Mar 2022 01:32:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RH7vc1Kbu92LgRjmvnXCb+Bj6pzUQwOde/W3XJ6RX6M=;
        b=7y7rMV57CM6P6S0tyAQttkOuYRwNs+GxyYLUczvGV7bwn2CeyqVq2Ms5G3RGzsIoD/
         gEWN2+zfTPGOc5I+jAfJiAwA9VsUL7jmXQYGNIdaZNmb38kF1KEOV8xgMrlf+PZ4VhIG
         AVrLmRrIIwmympZGOtYvraWo39/pA3DBNkeNoU6OYaNeSeEMu3APD5VS/JQ/gsVCt9Em
         IIdZL7o5agKsyEnUM6dNH/U4gnnJFIWcBavH+I0MZW46eqATiLyGGvPfVw0IJ98moSbu
         tNVwvTqrxb01kPARoswVFZ72IB4q9yfV1mzNNAdIqLHyAy7mZgD2zPWX4gforiCdYUMr
         jNHA==
X-Gm-Message-State: AOAM532ooM11Ag2j9kUtRHP1BMPsKHt4PW7p3qRcUNjC4+MdWx7Kt/NY
        3SAuVfpIhaDJAOr5+tnN+IO+F9UIR/g/lw==
X-Google-Smtp-Source: ABdhPJxSST1Gjy1Bz/kMDmbc8c4kOdb9EqGiml2aSE0KnzmDfQVr+kFXeN8+uIG2ceozq2vb6u9w4Q==
X-Received: by 2002:a1f:6e0f:0:b0:32d:5a5b:fa30 with SMTP id j15-20020a1f6e0f000000b0032d5a5bfa30mr9737411vkc.9.1646127175847;
        Tue, 01 Mar 2022 01:32:55 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id m13-20020a056122138d00b0032c5d72c395sm2130953vkp.55.2022.03.01.01.32.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 01:32:55 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id d26so15958930vsh.0;
        Tue, 01 Mar 2022 01:32:55 -0800 (PST)
X-Received: by 2002:a67:e113:0:b0:30e:303d:d1d6 with SMTP id
 d19-20020a67e113000000b0030e303dd1d6mr9030372vsl.38.1646127175398; Tue, 01
 Mar 2022 01:32:55 -0800 (PST)
MIME-Version: 1.0
References: <20220227203744.18355-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220227203744.18355-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220227203744.18355-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 1 Mar 2022 10:32:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUFSfFkPMbP-cs77MvjD71XQ4gK6YG5NnrE+L0mndQVtw@mail.gmail.com>
Message-ID: <CAMuHMdUFSfFkPMbP-cs77MvjD71XQ4gK6YG5NnrE+L0mndQVtw@mail.gmail.com>
Subject: Re: [PATCH 09/12] arm64: dts: renesas: r9a07g054: Add SSI{1,2,3}
 nodes and fillup the SSI0 stub node
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
> Add SSI{1,2,3} nodes and fillup the SSI0 stub node in RZ/V2L
> (R9A07G054) SoC DTSI.
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
