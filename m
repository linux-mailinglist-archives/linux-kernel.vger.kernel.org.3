Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C0A4C8808
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 10:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbiCAJeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 04:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbiCAJd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:33:58 -0500
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F9C5EDCD;
        Tue,  1 Mar 2022 01:33:02 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id d11so15893995vsm.5;
        Tue, 01 Mar 2022 01:33:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lf33iephp6ug1P/9SN9wHQyO21IddGLRrW3tOM/qrS8=;
        b=fbRFJ+x8/XWb03ujSpC2UUOsui//z6C/0XHY18N+e6CEbhgV75hyBeq9acDLRBZWuO
         a+hpoKA4XgO22DpmC/KcNI8I0LySzpU+PqDzKPNEkmeiT0U4wJxgxnk3HvNlqm0FgEHj
         FasxKk2N/1BRvnX0+GZtitfmQuawsC62dq2GswiN5McFLuQm4mzjNV+VME0sL+6XNRLy
         iXXZq+u+59F+HvmVGSMw2LCoALtCXEDWnH8WfGiM6PT0TPw4e6Zmn2L9HOul6KIJldHi
         0VKhSVBkZR9SmS2aQhIpTnKADLEW3NhPHqnk0TLM+YsdsX1f/PzDhHPWG+I+zMba1dyC
         Kpag==
X-Gm-Message-State: AOAM533qRZmC3TzHd3+CAyCvmN5fberyqP64OuxTMvCe224Nf2Knrami
        rzASRcxxFPzsCjAGaJs2nUYLNAsK+oV3NQ==
X-Google-Smtp-Source: ABdhPJxLT6uZi5gkC7PSIWIsqg57BGgz65kyGhj855AKoYFdeM6eEUsg2hIkDsj4FAwIEz2JKrZkyg==
X-Received: by 2002:a67:c80c:0:b0:31b:4428:73ea with SMTP id u12-20020a67c80c000000b0031b442873eamr9502557vsk.54.1646127181922;
        Tue, 01 Mar 2022 01:33:01 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id j8-20020ac5ce08000000b00333295130d5sm1532533vki.0.2022.03.01.01.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 01:33:01 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id q9so15906456vsg.2;
        Tue, 01 Mar 2022 01:33:01 -0800 (PST)
X-Received: by 2002:a67:b00e:0:b0:30d:dc98:6024 with SMTP id
 z14-20020a67b00e000000b0030ddc986024mr10340990vse.57.1646127181303; Tue, 01
 Mar 2022 01:33:01 -0800 (PST)
MIME-Version: 1.0
References: <20220227203744.18355-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220227203744.18355-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220227203744.18355-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 1 Mar 2022 10:32:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXggJm39DkL-DjX7UsGSkzfLOuJoQcvb-XG7vpjgT8O9w@mail.gmail.com>
Message-ID: <CAMuHMdXggJm39DkL-DjX7UsGSkzfLOuJoQcvb-XG7vpjgT8O9w@mail.gmail.com>
Subject: Re: [PATCH 12/12] arm64: dts: renesas: r9a07g054: Add SPI{0,2} nodes
 and fillup SPI1 stub node
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
> Add SPI{0,2} nodes and fillup SPI1 stub node in RZ/V2L (R9A07G054)
> SoC DTSI.
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
