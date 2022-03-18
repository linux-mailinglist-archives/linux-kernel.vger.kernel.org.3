Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D456C4DDA77
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 14:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236667AbiCRN21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 09:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbiCRN2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 09:28:24 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E56EA34D;
        Fri, 18 Mar 2022 06:27:06 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id i8so6801045qtx.6;
        Fri, 18 Mar 2022 06:27:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bP9fF1LcUT/zcxuRZc/z2DEjzPpIQX03/s1Pv3V3kf0=;
        b=5UKPSZbvGb/0pbStNYOFbfi314Bww++7D5w4D51BEflFGXurvKx52d1SvDuBeMUDiw
         WOKBYdN83y3WFxnHKBXD9Gsng8ryGMt8HlNk79MghbCliL/Xrcu3Mkk2L+MdoGEXdSkO
         guGdovShp1+JPPKKVdQCcEK/lTTrUiV6FbYa+DfVSdSgBIVgI3DNdC8n9TAEsNHVhY/0
         HuZnJ1oRWqD9LKDPUKY/Wl/RtTF7hnove21xr/zesqt+zsfI3csbliQM0yIMpptcSMDF
         DyCSllLdUPw+RWr2DetjWK9srX1AsId4eYw3JKZZb9y+FcssIBXoClRIwpSy/SanVWGH
         Bbxw==
X-Gm-Message-State: AOAM5337Zkk2Nm1/omd4+NtAwgzwhfdLsKIxXHG3iWXmjxLySsZyBIrd
        6oG7FFB2L4PEMSTQVe8/NcfGetPII3Sskfzr
X-Google-Smtp-Source: ABdhPJxgIlBRO2ugb8lkfUy2J9ELhXd3MWjNbdJCJ6YkZXK2I1/2WMTRTlNZjFq6OAwAXeAT6MZr6g==
X-Received: by 2002:a05:622a:4d3:b0:2e1:bc11:3b97 with SMTP id q19-20020a05622a04d300b002e1bc113b97mr7329582qtx.189.1647610024845;
        Fri, 18 Mar 2022 06:27:04 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id x20-20020ac85f14000000b002e1ee1c56c3sm4473337qta.76.2022.03.18.06.27.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 06:27:04 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id f38so15849049ybi.3;
        Fri, 18 Mar 2022 06:27:04 -0700 (PDT)
X-Received: by 2002:a25:bc8f:0:b0:628:8649:5c4b with SMTP id
 e15-20020a25bc8f000000b0062886495c4bmr9844508ybk.207.1647610023986; Fri, 18
 Mar 2022 06:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220308223324.7456-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220308223324.7456-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220308223324.7456-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 18 Mar 2022 14:26:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW6Wo-Pd5xLp4AcfAxGvrEFq09pz_si0qWc91vgwBJnPA@mail.gmail.com>
Message-ID: <CAMuHMdW6Wo-Pd5xLp4AcfAxGvrEFq09pz_si0qWc91vgwBJnPA@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: renesas: r9a07g054: Fillup the GPU node
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 8, 2022 at 11:33 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Renesas RZ/V2L SoC has Mali-G31 GPU, this patch fills up the GPU node and
> adds opp table to RZ/V2L (R9A07G054) SoC DTSI.
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
