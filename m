Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783424C880B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 10:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbiCAJeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 04:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233938AbiCAJd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:33:58 -0500
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE4E5E777;
        Tue,  1 Mar 2022 01:32:59 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id 63so6624730uaw.10;
        Tue, 01 Mar 2022 01:32:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d3Pdt+pViSFJmyiPhXOgAe49q+UjmRIg4LCfdEDwC/w=;
        b=JPV5SSYombXXtVnymdg0gn0FHq4Dejjs8NMUk0ly4uMILQg46+Ye8m93oMxn1lAjlk
         jBAN3ybMrg55Br+8mtruAj+6k5btjmUETovmBzpMccqVcVoz9L7yw64rx55NExrRPvae
         K+sLqx9n4SI2ICVNKTNPuyD0jh5A35tuwQTglqwKjaTTXCLTsdHQzCbPvcCz7LCz5CiI
         6ESa+16pfoeYkmDlwc66QOYbn1Fn23cZPiRgacu5Y/hg97ynRhAJk3Ge67/iCyCkVC16
         y6JBAaH6wvhq2u3U4GE62Bc0Z1xfddvPyJ/IWUHgS8vdjzjJoJQ+Rov71JTf6MDLOiH6
         jIfw==
X-Gm-Message-State: AOAM532jpGtyKjEg78W1pQ+Hx8FpmBWCI5TGLaCwwaWTKYs1mcG8rGTG
        uc3VX4e0GPHlBFPkmAj56bd1Ti6W5+MGMg==
X-Google-Smtp-Source: ABdhPJzlB4s07YvvY7tUyFjNNpSNcHsKUeZGhMRDaSphtqWfRJLVNe2lt839ZKPbe4oMKPu4GSkzSA==
X-Received: by 2002:a9f:2c8a:0:b0:341:f0d9:d864 with SMTP id w10-20020a9f2c8a000000b00341f0d9d864mr9117517uaj.60.1646127178641;
        Tue, 01 Mar 2022 01:32:58 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id g43-20020a05610215ab00b0031b05781453sm1639455vsv.25.2022.03.01.01.32.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 01:32:58 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id q9so15906335vsg.2;
        Tue, 01 Mar 2022 01:32:58 -0800 (PST)
X-Received: by 2002:a67:af08:0:b0:31b:9451:bc39 with SMTP id
 v8-20020a67af08000000b0031b9451bc39mr9523775vsl.68.1646127178172; Tue, 01 Mar
 2022 01:32:58 -0800 (PST)
MIME-Version: 1.0
References: <20220227203744.18355-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220227203744.18355-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220227203744.18355-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 1 Mar 2022 10:32:47 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUM3WBBQb4dz9w075pKxPc6Y3SPqh9R10vVomTS1qR6eg@mail.gmail.com>
Message-ID: <CAMuHMdUM3WBBQb4dz9w075pKxPc6Y3SPqh9R10vVomTS1qR6eg@mail.gmail.com>
Subject: Re: [PATCH 11/12] arm64: dts: renesas: r9a07g054: Add USB2.0 device support
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
> Fillup the hsusb stub node in RZ/V2L (R9A07G054) SoC DTSI which enables
> USB2.0 device support.
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
