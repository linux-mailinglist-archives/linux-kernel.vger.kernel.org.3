Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66504C87FC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 10:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbiCAJdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 04:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbiCAJdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:33:39 -0500
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0574EBC26;
        Tue,  1 Mar 2022 01:32:53 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id y4so15861419vsd.11;
        Tue, 01 Mar 2022 01:32:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qATJBXg+lI1bSpkrJc+IGAwvfNv4dh3i6v3gPluEZk0=;
        b=fDmD41N4XMxrWbOUI/xknnwS/8cirg7Bn1H6Tmk7wgGpXZrz95JFOQJrQDPESUBARk
         dRUCmwN3IkWSoN7gWOY1s1ikfL3sB8gyEJeixUgQZaCvD8tDYyzHtkcvqzMCSGlfb591
         1K3aD5Cjy0/cI0kYdAWGxbr+QiVAFS04ukPIF+4DNFSmlQx5sAd3gWvzYsaYllxvjkxk
         /FmXrl1Bn7m2kkzuzBq1yFkz4WsCxbckY/WDtqY0/432XljiDgWu/3Be36sZv6vqTy+q
         taxc4tQVq80qgoC8LPZEbFICH51NLkkOPzdAju0keBavz1OSBNzubqEOMVNYHn7wS2b9
         FcZA==
X-Gm-Message-State: AOAM532H5urA0jq9XUwT0a/WFU6NE8KKqGY2xlusUrTLi4Mi8cdFbIXq
        9vozS6wis1yumFcCMN+kDLFvD8v757tDdw==
X-Google-Smtp-Source: ABdhPJxO+bjroY4n/cO9Lv+8nXacSnOfAekyT72QK20w7bZ4LABDLJT7UX/1fuvrWUTehNPBnk64NA==
X-Received: by 2002:a05:6102:d86:b0:30d:ff44:916e with SMTP id d6-20020a0561020d8600b0030dff44916emr9225331vst.5.1646127172857;
        Tue, 01 Mar 2022 01:32:52 -0800 (PST)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id x32-20020ab048a3000000b00342b5e4ab73sm1785533uac.7.2022.03.01.01.32.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 01:32:52 -0800 (PST)
Received: by mail-vk1-f179.google.com with SMTP id l10so6560877vki.9;
        Tue, 01 Mar 2022 01:32:52 -0800 (PST)
X-Received: by 2002:a05:6122:ca1:b0:330:b95b:e048 with SMTP id
 ba33-20020a0561220ca100b00330b95be048mr10182542vkb.39.1646127172419; Tue, 01
 Mar 2022 01:32:52 -0800 (PST)
MIME-Version: 1.0
References: <20220227203744.18355-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220227203744.18355-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220227203744.18355-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 1 Mar 2022 10:32:41 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU0UCazsJW6Qv+AbLvAC52=+cy0mQBi1s9H+NB=-29zHA@mail.gmail.com>
Message-ID: <CAMuHMdU0UCazsJW6Qv+AbLvAC52=+cy0mQBi1s9H+NB=-29zHA@mail.gmail.com>
Subject: Re: [PATCH 10/12] arm64: dts: renesas: r9a07g054: Add USB2.0 phy and
 host support
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
> Add USB2.0 phy and host support to RZ/V2L (R9A07G054) SoC DTSI.
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
