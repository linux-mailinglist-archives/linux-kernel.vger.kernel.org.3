Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2EF590E26
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 11:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237999AbiHLJcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 05:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiHLJct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 05:32:49 -0400
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3177211825;
        Fri, 12 Aug 2022 02:32:48 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id u8so221212qvv.1;
        Fri, 12 Aug 2022 02:32:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+hBgnelb9rhjkbt7mU640/9Id4DX3C6HryE5K4mmUKE=;
        b=wRUaG5PoSKkv/k13qPcX3yEDfeBWNOHumFmaHewAJXOxeRxJBDPX/sLtEmFSHWqYA/
         N9TeQZPEpU57fIQ4AoVGEbSPjUry3yIFILRtwOsPXcVuNdKRYobdFU81hQ6WjOtIr9mq
         eMWXEe948rA+0QiUTFFoDyKMdk8lxJocRnNCAs+B53sttAuuP8j3Rnw7lFv5X/CLYuvU
         WCNesqI7zjyq0GNqF1mdJoUIXc2Z0R1ai0d602Nx1Mf1N8Qi46aeMkGQOy2wnm1Dp0sO
         OLm6BBO+lDzFcHcYvSFP0kwP4pGCVdAj2NFu944E5hs+QDu5TD6gYf0GBXBU0mkAdDp6
         kXcg==
X-Gm-Message-State: ACgBeo2HWDO3zSS5+Za3fJqxPRxd7vFQHxx1CzHy0sicVP7t/QlBypPO
        yBOHcOVkd+dtancRUvy5edo12/e9FJBJNg==
X-Google-Smtp-Source: AA6agR6XbJYGPJlnFIXO3BaqnHa+oeJ5fGopTMcsrri7p8cq5g0E0f0Nto8MmBORk9hHfVMu3cqyIg==
X-Received: by 2002:ad4:5c8b:0:b0:474:97fb:c4e6 with SMTP id o11-20020ad45c8b000000b0047497fbc4e6mr2561499qvh.68.1660296767152;
        Fri, 12 Aug 2022 02:32:47 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id u13-20020a37ab0d000000b006b9629dc10asm1313428qke.103.2022.08.12.02.32.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 02:32:46 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-324ec5a9e97so4639487b3.7;
        Fri, 12 Aug 2022 02:32:46 -0700 (PDT)
X-Received: by 2002:a81:b049:0:b0:324:7408:94b with SMTP id
 x9-20020a81b049000000b003247408094bmr2973449ywk.283.1660296765944; Fri, 12
 Aug 2022 02:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220726174525.620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220727153738.GA2696116-robh@kernel.org> <CA+V-a8t2LJ1qSsJWK4S-434cLfp0AuqkSKLjk7VgtwrMrNr2SA@mail.gmail.com>
In-Reply-To: <CA+V-a8t2LJ1qSsJWK4S-434cLfp0AuqkSKLjk7VgtwrMrNr2SA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 12 Aug 2022 11:32:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWxSGn7Hohn2oU1i2eiO+LOSHm7gXCX5OByvSgXm+00SA@mail.gmail.com>
Message-ID: <CAMuHMdWxSGn7Hohn2oU1i2eiO+LOSHm7gXCX5OByvSgXm+00SA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: clock: renesas,rzg2l: Document RZ/Five SoC
To:     Rob Herring <robh@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
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

Hi Rob,

On Fri, Aug 12, 2022 at 10:48 AM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Wed, Jul 27, 2022 at 4:37 PM Rob Herring <robh@kernel.org> wrote:
> > On Tue, Jul 26, 2022 at 06:45:25PM +0100, Lad Prabhakar wrote:
> > > The CPG block on the RZ/Five SoC is almost identical to one found on the
> > > RZ/G2UL SoC. "renesas,r9a07g043-cpg" compatible string will be used on
> > > the RZ/Five SoC so to make this clear, update the comment to include
> > > RZ/Five SoC.
> >
> > It's either the same part or it isn't. 'almost identical' doesn't sound
> > like the former. Unless it's the former, it's a nak for me.
> >
> It's the latter.

To me, it looks like both blocks are identical, and the differences
are in the integration into the SoC:
  1. Some clocks do not exist (are not documented?) on RZ/Five,
     because the consumer blocks do not exist (are not documented?).
  2. Some interrupt controller clocks and resets have different names,
     but use the exact same registers and bits.

For 1, probably we could have kept those clocks anyway (they would
be disabled by CCF due to being unused). But I'm not 100% sure it is
safe to write to the corresponding registers (probably the hardware
engineers would recommend not to access the registers, regardless if
it is safe or not ;-), so we do not instantiate these clocks on RISC-V.

For 2, we decided to play it safe, too, and follow the naming in the
documentation, in both bindings and driver.

> > Litering the drivers with #ifdef CONFIG_ARM64/CONFIG_RISCV is not great
> > either. That's not great for compile coverage and they have nothing to
> > do with the architecture.

I agree #ifdef's do have disadvantages.  But they seemed to be the
best pragmatic solution, to avoid two separate drivers.

And the architecture does specify SoC integration.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
