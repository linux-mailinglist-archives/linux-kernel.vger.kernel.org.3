Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F1057C8F4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 12:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbiGUK1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 06:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbiGUK1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 06:27:37 -0400
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001AA820F2;
        Thu, 21 Jul 2022 03:27:36 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id t7so822219qvz.6;
        Thu, 21 Jul 2022 03:27:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rCvMc/vUOC3tOb2eOH0GWgA9WCBLLNYDitbf9JR/hfU=;
        b=fpp3noq4BzFCBH2th9e/zGIsV53MuyqNuT12Un9ao837FhsO2L2FUcbdsJDr/xKKPj
         8MtRSzk+bxi4ZRCJhrufOHENuISLoNuNKsDVrT0X+7eciD6KcYB25NOAbQWuNjGGG1Mb
         0NX79K0t+1lzGSv2I+ODZSx6la1aTAZvv+iOMa04hcB9zZplgHKGi8TneEaj8J4uJ76w
         IaY89IkEvDABeKU+wj78pThyniTIzrXE8bgwiw2OOAJyXhJvEIugL8zGW9AOWjLt2Ess
         WyMhWHSwkLhfoSHCYUcMIIv/R6wBMVdjpa30rJblNTdbbMPM+Lp5fWH/VRkkU1Kd1Nwi
         Kd5Q==
X-Gm-Message-State: AJIora9zP1TKGH7RiRgTZioy8iR58Az8WA0AnN9z0O0Jmnq0uneJU/m4
        CZmMa5dt/vkyDYZ1xYt/NfPKv+6y1cdg0Q==
X-Google-Smtp-Source: AGRyM1ttXVWS4N5jakkrb6NlMVajJfSsT5gVwKWLLaKJebOcJpFIjzzP0LhDfFRXQYMgJGFSO13zvQ==
X-Received: by 2002:a05:6214:21ad:b0:473:8d7d:5456 with SMTP id t13-20020a05621421ad00b004738d7d5456mr32809100qvc.88.1658399255984;
        Thu, 21 Jul 2022 03:27:35 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id c23-20020a05620a269700b006a6ebde4799sm1101730qkp.90.2022.07.21.03.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 03:27:35 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-31d85f82f0bso12205897b3.7;
        Thu, 21 Jul 2022 03:27:35 -0700 (PDT)
X-Received: by 2002:a81:84c1:0:b0:31e:4e05:e4f4 with SMTP id
 u184-20020a8184c1000000b0031e4e05e4f4mr16234850ywf.384.1658399255079; Thu, 21
 Jul 2022 03:27:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220718193745.7472-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220718193745.7472-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Jul 2022 12:27:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUmfAPv0NHOm5J_D=f7ayu+tb1dDqrxLy7FFU8PLDs==w@mail.gmail.com>
Message-ID: <CAMuHMdUmfAPv0NHOm5J_D=f7ayu+tb1dDqrxLy7FFU8PLDs==w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: interrupt-controller: renesas,rzg2l-irqc:
 Document RZ/V2L SoC
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 9:38 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Document RZ/V2L (R9A07G054) IRQC bindings. The RZ/V2L IRQC block is
> identical to one found on the RZ/G2L SoC. No driver changes are
> required as generic compatible string "renesas,rzg2l-irqc" will be
> used as a fallback.
>
> While at it, update the comment "# RZ/G2L" to "# RZ/G2{L,LC}" for
> "renesas,r9a07g044-irqc" compatible string as both RZ/G2L and
> RZ/G2LC SoC's use the common SoC DTSI and have the same IRQC block.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
