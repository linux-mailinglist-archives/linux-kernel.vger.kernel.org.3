Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B459F594E43
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 03:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbiHPBxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 21:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240745AbiHPBxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 21:53:12 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D472320D593;
        Mon, 15 Aug 2022 14:45:00 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-32a17d3bba2so105469737b3.9;
        Mon, 15 Aug 2022 14:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=2afX6yrDcfpZBnmChjBnMJ+7mJFMLqevj8PH4SkpX9I=;
        b=oSf3U64JTh1LWoO7F/1/3gk8zZHxArf7adTgKyoI9Ad3nVgVM7RU6UbdANx2U25TUQ
         3amX/TDD5FEIheeSUZ6EuRjIAJbzip+oZADiJZ+Nb3P8hiM0BbcIUPS17Lhf79uryKkE
         yh4xms4uwPu42LcyQrnSqYsIIKqLIcCfiaqv376RT78KMqDubqL5V+WAORKrdXWZTCfz
         qZBulNpsOBBGkkBlYFArHHp0P/fG5cpbiUXmQFW2Bfa7h2wecNh8tm1zA4/m8InBDwWb
         LA+uCNfeAe+F1VTqXrWmd6mbdK5skTqw/TfybgH02G7V62DE4hRxixu3bat5jiZd5Isa
         RKjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=2afX6yrDcfpZBnmChjBnMJ+7mJFMLqevj8PH4SkpX9I=;
        b=tVKB/nK4WjIW6YaEvkU/bTd1IaaBcscMZKmChJh03EN0Y/nEGtfxJiPEgdykjBc7WB
         sU1+7f50zdxAyzAFf2gyr3dBlHhfFdYf0zmC7b7awjmsG4414XyzpXhylNOyX5MrWqF6
         OIY//lhc+auxNWTqOSsBzbiw0V9pA+rFFtq8XPgTtIwjoJsDsfivC5yb22n3z8AQHh/M
         yJRwpU2dWNbDGCWs1HLIyPYJ3rR1SQHZkbUp5XLsobHPPBgN0orcBqURZGp1l6PGgTt4
         XKErtAj39hkhM+BPlY9FGSIQzJcueXmqOqH9pfSgc1ygSHMkoeD5bVaqsPC+NjbNBo4z
         2vqg==
X-Gm-Message-State: ACgBeo3R3m569IP5fWGpppTO7j3ErvmbL2N27rXlYXBE1HhGrxkTAWVr
        /51hWlmHT8suAUJhLSnxPVlo+jm7hTVHRYq/ajhJXbzwIFLSYA==
X-Google-Smtp-Source: AA6agR4nBE/BsnGk7VaQ6Go1ssUjkUMWQ0gHOg5lC40UYQBbJv2HOmOOGs00Z28oIGh+7ulu3gg++WK8aq4GrjMjZUo=
X-Received: by 2002:a0d:f282:0:b0:329:7da1:90e8 with SMTP id
 b124-20020a0df282000000b003297da190e8mr14589755ywf.519.1660599899361; Mon, 15
 Aug 2022 14:44:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220815151451.23293-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <d9d0deef-92e1-05b4-a195-d2ca03801129@microchip.com> <CA+V-a8utT6UE=rc62LPE=UoU0DTJ2dDt7KO9UJ1vAG9r80E2pg@mail.gmail.com>
 <cb3eb397-cc27-c8f2-4194-5c401f6dd690@microchip.com>
In-Reply-To: <cb3eb397-cc27-c8f2-4194-5c401f6dd690@microchip.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 15 Aug 2022 22:44:32 +0100
Message-ID: <CA+V-a8s_t4ipLgcioB-YHOv7D8KQhWe4G0zmL=57594eWt-y6g@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] RISC-V: Kconfig.socs: Add Renesas RZ/Five SoC
 kconfig option
To:     Conor.Dooley@microchip.com
Cc:     "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Anup Patel <anup@brainfault.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
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

Hi Conor,

On Mon, Aug 15, 2022 at 9:05 PM <Conor.Dooley@microchip.com> wrote:
>
> On 15/08/2022 20:57, Lad, Prabhakar wrote:
> > Hi Conor,
> >
> > Thank you for the review.
> >
> > On Mon, Aug 15, 2022 at 8:10 PM <Conor.Dooley@microchip.com> wrote:
> >>
> >> On 15/08/2022 16:14, Lad Prabhakar wrote:
> >>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >>>
> >>> Introduce SOC_RENESAS_RZFIVE config option to enable Renesas RZ/Five
> >>> (R9A07G043) SoC, along side also add ARCH_RENESAS config option as most
> >>> of the Renesas drivers depend on this config option.
> >>
> >> Hey Lad,
> >>
> >> I think I said something similar on v1, but I said it again
> >> to Samuel today so I may as well repost here too:
> >> "I think this and patch 12/12 with the defconfig changes should be
> > patch 8/8.
>
> It was a direct copy paste, hence the quotes ;)
:)
> Your patch 8/8 lines up with the current symbols while Samuel's
> doesn't.
>
> >
> >
> >> deferred until post LPC (which still leaves plenty of time for
> >> making the 6.1 merge window). We already have like 4 different
> >> approaches between the existing SOC_FOO symbols & two more when
> >> D1 stuff and the Renesas stuff is considered.
> >>
> >> Plan is to decide at LPC on one approach for what to do with
> >> Kconfig.socs & to me it seems like a good idea to do what's being
> >> done here - it's likely that further arm vendors will move and
> >> keeping the common symbols makes a lot of sense to me..."
> >>
> > Sure not a problem. But delaying patch 4 and 8 will make RZ/Five SoC
> > not buildable. Is that OK?
>
> No no, I prob just did a bad job of explaining. I meant more
> along the lines of "I don't think this is the right approach
> but I will defer reviewing until after LPC, when we have picked
> one approach to use for everyone". I'm sorry, poor choice of
> words maybe. I didn't mean drop these patches so that it does
> not build, keeping it buildable until then so that we can all
> test/review is the way to go. Not your fault we've done 4 different
> things so far!
>
> Hopefully that makes a bit more sense?
>
Yep, that makes sense.

> >
> >> Also, for the sake of my OCD could you pick either riscv or
> >> RISC-V and use it for the whole series? Pedantic I guess, but
> >> /shrug
> >>
> > Sorry did you mean I add riscv/RISC-V in the subject?
>
> You have some patches with RISC-V and some with riscv.
> What I meant was use one of the two for the whole series.

I followed the previous subjects for that file which were previously
accepted. But not a problem I'll change them to riscv instead.

Cheers,
Prabhakar
