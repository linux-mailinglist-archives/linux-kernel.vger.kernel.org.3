Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2FFC596298
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 20:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236651AbiHPSk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 14:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiHPSky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 14:40:54 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7591C13C;
        Tue, 16 Aug 2022 11:40:53 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-33387bf0c4aso69297947b3.11;
        Tue, 16 Aug 2022 11:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=27/HI5csbdu56H0FY2364f9h5Ztp/gbf7y6HIHR/NSM=;
        b=NWMiPDSG+ofh/8CIaLRjbuJi5an+dkDhk6OZoCSoABtNukXdNTgyJfAUONow5hs4yj
         Gw7DdJYGCYR4qMiegjfr/EXxZdVD9RQVEG2cDj5YiiOR7tPmrR92+seP7rOWI3Uw74dq
         eVbI9689B32Ae0825VJtAI4eDziG/mXSZbdaNbKeMifs8+V0cV03FxIBltp9X0/tPIga
         qcz6VUQFoa9iZh0czIES6t0kI+sv/D1eYLC4zM02GF+cb5g13MBr/TbMzC+chez4gVpU
         1g+EmQzwtfpc9rMZb1FBinQ7yT3GrKZG/UCmHRZglMFo7VcZGSpjVZuYHASJwGbKPWd+
         w9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=27/HI5csbdu56H0FY2364f9h5Ztp/gbf7y6HIHR/NSM=;
        b=mEqlkWcH+r7oHXP1LTESaB4EHL5HMEKrgjx/+4x5ybCt0cHlS33k1sFHWBUARtORVt
         hj+YsqFqbLaKTs8RwiTDwDWJO80ifBu5gBr1Qc9OI89JTAhcvvwFFLatQYbobPhTyx1l
         L/8LIX9a+FxBbKF26qu5uYJx66fplFfLOvYWEjvkHoYm+Bb1OhJQr1IjxUIcbLGUsPdq
         fWJ3/FbOC48KfwwDhhrYcDZkqxsoegxdiQojwHZQXWZEYW7xc+CY3cVBzyUAkwKitO67
         s1qb+BQCKiOCvIMFbZWHzyfn5x8TQ1kUNDi0/rEgfI+e97QYRYRhc9Cq0VaaLyqw2RnT
         Iciw==
X-Gm-Message-State: ACgBeo3OglCIPi3xTG1HZgo64I1E9C3AT6go7IXzzb/Sw6o4uZIczXEG
        a1DbvKwiG6jms/CgCFnDz/W+OnAr6DlmqMkWygA=
X-Google-Smtp-Source: AA6agR5nimwbrYEAQ7+o3F9DBc1jQfu9MTgB8so5q6oiSD2IsGR6KVLOcN8wQpKi+VEZQusgKjZ1oKciopsKVl8ao+k=
X-Received: by 2002:a25:4689:0:b0:671:6d4f:c974 with SMTP id
 t131-20020a254689000000b006716d4fc974mr16659280yba.354.1660675252696; Tue, 16
 Aug 2022 11:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220815111708.22302-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220816174150.GA2428940-robh@kernel.org>
In-Reply-To: <20220816174150.GA2428940-robh@kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 16 Aug 2022 19:40:25 +0100
Message-ID: <CA+V-a8vayVoHONavLMTdfQkYsT_+7NLXid3V58FU+ABzB9kgBg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: soc: renesas: Move renesas.yaml from arm to soc
To:     Rob Herring <robh@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, Aug 16, 2022 at 6:41 PM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Aug 15, 2022 at 12:17:08PM +0100, Lad Prabhakar wrote:
> > renesas.yaml lists out all the Renesas SoC's and the platforms/EVK's which
> > is either ARM32/ARM64. It would rather make sense if we move renesas.yaml
> > to the soc/renesas folder instead. This is in preparation for adding a new
> > SoC (RZ/Five) from Renesas which is based on RISC-V.
>
> Please post this as part of the above.
>
Sure, I just wanted to get some feedback on this so had it posted separately.

> bindings/soc/ is just a dumping ground for stuff that doesn't fit
> anywhere. We've mostly cleaned bindings/arm/ of that, so I don't really
> want to start that again. I would propose bindings/board/ instead if we
> move in this direction.
>
OK. So to clarify, how do we separate it further bindings/board/<based
on SoC vendor> or bindings/board/<board manufacturer>?

Cheers,
Prabhakar
