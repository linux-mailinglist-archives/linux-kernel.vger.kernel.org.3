Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E405B1E94
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbiIHNU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbiIHNUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:20:35 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA93B4416;
        Thu,  8 Sep 2022 06:20:28 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id k12so133031qkj.8;
        Thu, 08 Sep 2022 06:20:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=nH7L3KimhWKQ6v9V2FWln1JYYf97pWD4ktksM0pFeVE=;
        b=XuH/Uq2uN91BjVNXsFPkJO9d+aQonnSf/fIJxoRJCr0x0wNU+SYYMx7NzkzhNeJSb2
         iWLQZx4CIj7bDRCFQhB9W3/LEcXg1t4DUT480iz2D+QxdSu3H+bYglgn6SmTE+FndoB5
         Gfg6X23BjznHlrQf5NOfKxYW/saUfDe4cTdAwzS2ufJrXkz5qtso9OzFUOkzm5UeQnSv
         /wT+iDcHEBkCogjnG2rRZDsix7A+IF4BJvb6d6dwkERkDoGlF8dgxIq7fO4E41/mrW59
         iDzt7z7E0/iyliQlNgJmecWRZDH2PMB9431XyPmyUIYKO7D7LJnH4VekDi5tRHztCf+Y
         h/OA==
X-Gm-Message-State: ACgBeo0isBkmMU1yBIfQwe2Els2pX7JsMhLJnHq5NJA5LVYFufjtvxzy
        Rny0bswKFlXWpLvA47hAiEkPyx865UdOvQ==
X-Google-Smtp-Source: AA6agR54xrfPpNd2EUWz4uKizr6+3XfWd/ti74GqR+Xb1XF4lBNMarLsDBZs+4lkCBVtgTWwdjbptg==
X-Received: by 2002:a05:620a:f10:b0:6aa:318e:55a9 with SMTP id v16-20020a05620a0f1000b006aa318e55a9mr6320154qkl.559.1662643226375;
        Thu, 08 Sep 2022 06:20:26 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id x24-20020ac87a98000000b003431446588fsm14268488qtr.5.2022.09.08.06.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 06:20:25 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 11so26448221ybu.0;
        Thu, 08 Sep 2022 06:20:25 -0700 (PDT)
X-Received: by 2002:a25:8247:0:b0:6a9:443a:cc0b with SMTP id
 d7-20020a258247000000b006a9443acc0bmr7305634ybn.89.1662643225008; Thu, 08 Sep
 2022 06:20:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220906102154.32526-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220906102154.32526-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <8ecb62b7-53c4-1c43-65b3-567d8c12e131@microchip.com> <CAOnJCUKLpRz4Fbx1XiMnap-ELw2k1c8E9V8bZiSP+x7z9Z5QrA@mail.gmail.com>
 <f362eaeb-6ccd-4392-a346-55fa5ae25e13@microchip.com> <OS0PR01MB5922833FDCA60892191B211A86409@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <5e894d87-8abb-540d-fbd6-8a1d6f9d0e91@microchip.com> <OS0PR01MB5922F6CC81114BCE7696BEDB86409@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922F6CC81114BCE7696BEDB86409@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 8 Sep 2022 15:20:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXyvVas51e1ozxyYG4_NnVYAMZ1B30raGgaj=FDPeOL2Q@mail.gmail.com>
Message-ID: <CAMuHMdXyvVas51e1ozxyYG4_NnVYAMZ1B30raGgaj=FDPeOL2Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] riscv: vendors: andes: Add support to configure
 the PMA regions
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     "Conor.Dooley@microchip.com" <Conor.Dooley@microchip.com>,
        "atishp@atishpatra.org" <atishp@atishpatra.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "guoheyi@linux.alibaba.com" <guoheyi@linux.alibaba.com>,
        "guoren@linux.alibaba.com" <guoren@linux.alibaba.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "atishp@rivosinc.com" <atishp@rivosinc.com>,
        "apatel@ventanamicro.com" <apatel@ventanamicro.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "prabhakar.csengg@gmail.com" <prabhakar.csengg@gmail.com>
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

Hi Biju,

On Thu, Sep 8, 2022 at 3:01 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > Subject: Re: [RFC PATCH 1/2] riscv: vendors: andes: Add support to
> > configure the PMA regions
> >
> > On 08/09/2022 09:39, Biju Das wrote:
> > > EXTERNAL EMAIL: Do not click links or open attachments unless you know
> > > the content is safe
> > >
> > > Hi Conor, Atish,
> > >
> > > What RISC-V devices you have?
> >
> > A bunch ;)
> >
> > A __couple__ PolarFire SoC boards, HiFive Unleashed, D1 Nezha, Canaan
> > k210 MAIX something & the VisionFive.
>
> If standard DMA api works without any issue means, on these platforms
> IO Coherence port is enabled in the hardware. So all peripherals
> involving DMA work as expected.
>
> > > Ours is RISC-V uniprocessor without IO Coherence Port.
> >
> > What does "IO Coherence Port" mean? Zicbo*?
>
> The HW will provide coherency between CPU and peripheral.
>
> If Zibco* is uniprocessor, then highly it may not have IO coherence
> Port enabled in their design.

Zicbo* is a set of extensions for the instructions.
These cannot be retrofitted to existing silicon, but perhaps they can
be trapped and emulated?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
