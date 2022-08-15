Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C8F594364
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 00:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350661AbiHOWcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 18:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350469AbiHOW0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 18:26:49 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E7C65A6;
        Mon, 15 Aug 2022 12:45:22 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-32194238c77so98780527b3.4;
        Mon, 15 Aug 2022 12:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=aKAUEkS+nxe+8CF3Cg4JzlhCE0M6xQePI/Wm6Vu7wQ8=;
        b=oHDu53VBYdrBxP0O0VnR86YXNBBfpUPpOthxZldcqPDnZ+Ax2dM6/E2D6YUpQvxvzK
         VHQ3fyvr5hJ+nffN1kDZxF4DuihzqpFdhZm8LckcpnUJNiiTVPyN5MxNf0VaXX2csK/s
         ksqZ2/2perzZUkuJNxMJu+l0O9F3KJQFvgTSK5dTgT7f4bH3vtUhJckA2hz0C62ujK4f
         fQufWXGzdZe/carpvrscoOzBYxOOaCIThPoTUipebBddGm7MP1EW6mK7FYJdKD+/gOV4
         1/Jn39vgFs9VokZVpwDPbCY/3zf7BcUe+a88CFXopD3Z5meODzRIOVEAQ6OS7ZES4jte
         13cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=aKAUEkS+nxe+8CF3Cg4JzlhCE0M6xQePI/Wm6Vu7wQ8=;
        b=jRek9V6ENnQ7LHTcew2xNEfGUVk0WUGckqQBe3IsKQUxyD26K56GuJ0inQhbpQhPWp
         ZR5OxBbkhGl/qQo7b1bkBKhMmg08noH4n3e6zxvjBlkU5NGQU0K+v2OpG/BjMg57sWQ5
         DK+9+72hEJQWgF/XCsR/Gv/tr1OmAdE9DjQNtciX7Q9WqpOGwrdNjItV7ZfIzl7Sclba
         Qw5t4Lz/h1VcDw3WkrdIORCVm0NFPviVCiutq+eBYv4+jpddDognO5fUgL6ZZSGFK9t9
         KW/6L5CKLiRORewSc2PTDQkrlfcFxvj/46/DK91xBIIXgZk1TCVuyHgAQakDsm6M7YX6
         71wA==
X-Gm-Message-State: ACgBeo3CBLWkjmX3AMZlO6KmTBgFEBzNQIiy4fVLgCVo0vba3AIiZRem
        OAk0NS6tW658oUIrZtis9/kEBa9dT8u+aUNG7xE=
X-Google-Smtp-Source: AA6agR6r36ZxL/xnpPXAmgiVzKS611cTDSGT1HVsjeqfqgBQRurO87Va5m0cLkbjwqM4Gbyd/++Vy9xExcdTjdU9amE=
X-Received: by 2002:a81:910e:0:b0:332:4030:4f06 with SMTP id
 i14-20020a81910e000000b0033240304f06mr2876771ywg.340.1660592721375; Mon, 15
 Aug 2022 12:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220815151451.23293-9-prabhakar.mahadev-lad.rj@bp.renesas.com> <ca555430-055c-debb-fdb4-fa7f78129780@microchip.com>
In-Reply-To: <ca555430-055c-debb-fdb4-fa7f78129780@microchip.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 15 Aug 2022 20:44:53 +0100
Message-ID: <CA+V-a8s=RoZmMvDqnBpYZTR2uotv6srumeoRn2=828zhAbOQZA@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] RISC-V: configs: defconfig: Enable Renesas RZ/Five SoC
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

Thank you for the review.

On Mon, Aug 15, 2022 at 7:52 PM <Conor.Dooley@microchip.com> wrote:
>
> On 15/08/2022 16:14, Lad Prabhakar wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > Enable Renesas RZ/Five SoC config in defconfig. It allows the default
> > upstream kernel to boot on RZ/Five SMARC EVK board.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v1->v2
> > * New patch
> > ---
> >  arch/riscv/configs/defconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> > index aed332a9d4ea..de0ccf816c08 100644
> > --- a/arch/riscv/configs/defconfig
> > +++ b/arch/riscv/configs/defconfig
> > @@ -26,6 +26,7 @@ CONFIG_EXPERT=y
> >  # CONFIG_SYSFS_SYSCALL is not set
> >  CONFIG_PROFILING=y
> >  CONFIG_SOC_MICROCHIP_POLARFIRE=y
> > +CONFIG_SOC_RENESAS_RZFIVE=y
> >  CONFIG_SOC_SIFIVE=y
> >  CONFIG_SOC_STARFIVE=y
> >  CONFIG_SOC_VIRT=y
> > @@ -123,6 +124,7 @@ CONFIG_INPUT_MOUSEDEV=y
> >  CONFIG_SERIAL_8250=y
> >  CONFIG_SERIAL_8250_CONSOLE=y
> >  CONFIG_SERIAL_OF_PLATFORM=y
> > +CONFIG_SERIAL_SH_SCI=y
>
> What's this? The patch text makes this look like an accidental
> inclusion, but I figure it is required for boot?
This enables the serial driver used by the RZ/Five SoC. SInce the
intention was to have a bootable board with default defconfig. I'll
update the commit message.

Cheers,
Prabhakar

> Thanks,
> Conor.
>
> >  CONFIG_VIRTIO_CONSOLE=y
> >  CONFIG_HW_RANDOM=y
> >  CONFIG_HW_RANDOM_VIRTIO=y
> > --
> > 2.25.1
> >
>
