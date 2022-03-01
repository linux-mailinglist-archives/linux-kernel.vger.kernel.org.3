Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4B94C87ED
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 10:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbiCAJdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 04:33:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbiCAJdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:33:12 -0500
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4B0C3F;
        Tue,  1 Mar 2022 01:32:30 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id g20so15877517vsb.9;
        Tue, 01 Mar 2022 01:32:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GU1fZUmKr8lPWItqxtWN/jbkF8NRwiskScmL2wp5+Tk=;
        b=DxnBXz7gDZjuxkq1JgwTKDXkVOAkoC9J9FKVvn1awhRABB76Lsr96K0AScFW9R9Ti7
         3tfNpJuBMXvSIzNFXDjXX1NGkVS2M3gAwJecZXMtbHXSmCcHFBHHd3Adl6xjDDN3jHQH
         LkQNRAKVX9nd1Jx7PkQCydzaM0SBxsuadsBtl5Go+Y/TBcracQ2UFh3TrB05oMJyQhS6
         VXsKf7dYj407PHikImwF1Yq5FHBu4ZwF5FwYykUGDX/hYgor+wkZkYZEW23sL9TQ6w3R
         VvbdfCtOYa6C//EadrtkzCNO9mmJLcDM59vaMjFT9xWVIJXVYjeH/I9MsnAbaNGq6nXE
         8UIw==
X-Gm-Message-State: AOAM5321ixna3tM9P29gDA5VulnVlKoZcIjZ61dlHhghx6nSHHgf4L99
        uxlDMYidEP4wdolDgagX0OzBb5+M5CpQjQ==
X-Google-Smtp-Source: ABdhPJzJbU/20eXlOs6aDHFJcH5WJRWyTdmUYCYT/LqVEEqEy05tStWfXp+zSFoZ2VCJNKNrtfaLMA==
X-Received: by 2002:a67:f852:0:b0:314:a25f:c5f with SMTP id b18-20020a67f852000000b00314a25f0c5fmr9121331vsp.73.1646127149809;
        Tue, 01 Mar 2022 01:32:29 -0800 (PST)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id bi18-20020a05610234f200b0031b441be417sm1701197vsb.15.2022.03.01.01.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 01:32:29 -0800 (PST)
Received: by mail-vk1-f175.google.com with SMTP id w128so6555972vkd.3;
        Tue, 01 Mar 2022 01:32:29 -0800 (PST)
X-Received: by 2002:a1f:6087:0:b0:328:e94a:54b3 with SMTP id
 u129-20020a1f6087000000b00328e94a54b3mr9766325vkb.20.1646127148863; Tue, 01
 Mar 2022 01:32:28 -0800 (PST)
MIME-Version: 1.0
References: <20220227203744.18355-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220227203744.18355-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220227203744.18355-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 1 Mar 2022 10:32:17 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUYRbXBceZ9atq1csi0xWx3uODOT=_Pn5NT5r93RCjRTA@mail.gmail.com>
Message-ID: <CAMuHMdUYRbXBceZ9atq1csi0xWx3uODOT=_Pn5NT5r93RCjRTA@mail.gmail.com>
Subject: Re: [PATCH 03/12] arm64: dts: renesas: r9a07g054: Fillup the CANFD
 stub node
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
> Fillup the CANFD stub node in RZ/V2L (R9A07G054) SoC DTSI.
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
