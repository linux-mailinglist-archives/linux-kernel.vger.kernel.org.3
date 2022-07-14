Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E1E5750CB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbiGNO3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiGNO3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:29:16 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0157A18B16
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:29:14 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-31bf3656517so18564587b3.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YlzZEqFoTc04SaZBu+v7x99uaEOuP4naXZYf5VPkZpc=;
        b=O/YzZ0aJNVY0Olu0WGI7mfps/K+hxAP/Q5ehQ9uy5W5FbDiZYpkflfBu66QtnT5UoT
         8WQvvcRBZO6qpjjuim4qUGZXrVSNYwib4GqhQtoMwFWNWN8ljQGo8/Zx5TSMD/YRMibi
         KDyRYOewJNHyW3I8zqJkngwbgp5d60pPZAuOkLQncEQ2Sn5BP9CGJqMGZSvydpEL0SQS
         1OizMwLX+6/HdbP/BabSv9/AJ7qi7gzdd+jL5bqY97w82jLciJkdq/rb9ngfNgaZvO2l
         XF5cCgws4GpWiY+gcMhgP7UbUmYV7WEusKRh1sxJDzMsS3CDl1up9yBfhXijAFZPycRB
         +u+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YlzZEqFoTc04SaZBu+v7x99uaEOuP4naXZYf5VPkZpc=;
        b=Pan3oJ4vPf32x8ABcjKA0Fj9a21wsJT8GFhLw1ErpqEvPC27U0eulg4oFnZ8bkGpho
         euOD/I38ewxaGrZi+16PsNxbvmilh8y6P1QBPj/O52N9IcKriNhS+rXuYJVLKNAEzB7g
         dnyRt7ucLSBf1j2ShfkK9j9hlpKblUQUDg73pRScolmWcalzc+qmHizJypKX25FXVC+o
         JABS/rqTwcYg0WexqdSMbwKnM+igPaBvmTxJoDrgITAoDGOVH1paGN/79mDnc6QWfj/t
         9HD4W8QeqzPO0vsrSlVC8b1qCw52mIL63udNxOiHAlzNSoOonx3mntbiFicBszLTAFk0
         2WYA==
X-Gm-Message-State: AJIora+207H9bpwL7yIfAC/u8e+QQEL7B9AGF2pn8rFQaaSh6rBUDJ54
        0C3XprfnPfUHAKoWytqNi/y2vdMfhPC18iTaGj3nww==
X-Google-Smtp-Source: AGRyM1vmdPBPDNRzF1/taI9PrebdFz2nDxBIOBFxahbjY1dlb1Sm6VY7LTHE55gzvKHxyFa+dJlJ43zOPZNBDS/L1RE=
X-Received: by 2002:a81:1216:0:b0:31d:b19e:b72b with SMTP id
 22-20020a811216000000b0031db19eb72bmr10102575yws.265.1657808952998; Thu, 14
 Jul 2022 07:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220622162230.83474-1-kirill.shutemov@linux.intel.com>
 <20220622162230.83474-7-kirill.shutemov@linux.intel.com> <CAG_fn=Uo8E-6r3otLPC9iEfO02=A0=zROO8R8TL=8vXVZVE5Ww@mail.gmail.com>
 <20220712171445.74b46mgdxgaub3qj@black.fi.intel.com>
In-Reply-To: <20220712171445.74b46mgdxgaub3qj@black.fi.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 14 Jul 2022 16:28:36 +0200
Message-ID: <CAG_fn=VeS7eFq5w0ny2VVe0j4YU4DKyaHDL0-b_VomnYwmDYow@mail.gmail.com>
Subject: Re: [PATCHv4 6/8] x86/mm: Provide ARCH_GET_UNTAG_MASK and ARCH_ENABLE_TAGGED_ADDR
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 7:14 PM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Tue, Jul 12, 2022 at 03:12:01PM +0200, Alexander Potapenko wrote:
> > On Wed, Jun 22, 2022 at 6:22 PM Kirill A. Shutemov
> > <kirill.shutemov@linux.intel.com> wrote:
> > >
> > > Add a couple of arch_prctl() handles:
> > >
> > >  - ARCH_ENABLE_TAGGED_ADDR enabled LAM. The argument is required numb=
er
> > >    of tag bits. It is rounded up to the nearest LAM mode that can
> > >    provide it. For now only LAM_U57 is supported, with 6 tag bits.
> > >
> > >  - ARCH_GET_UNTAG_MASK returns untag mask. It can indicates where tag
> > >    bits located in the address.
> > >
> > Am I right that the desired way to detect the presence of LAM without
> > enabling it is to check that arch_prctl(ARCH_GET_UNTAG_MASK, ...)
> > returns zero?
>
> Returns -1UL, but yes.

No, I meant the return value of arch_prctl(), but in fact neither
seems to be true.

Right now e.g. for the 5.17 kernel arch_prctl(ARCH_GET_UNTAG_MASK,
&bits) returns -EINVAL regardless of the underlying hardware.
A new kernel with your patches will return 0 and set bits=3D-1UL on both
non-LAM and LAM-enabled machines. How can we distinguish those?

> >
> > One would expect that `arch_prctl(ARCH_ENABLE_TAGGED_ADDR, 0)`
> > disables tagging for the current process.
> > Shouldn't this workflow be supported as well?
>
> Is there an use-case for it?
>
> I would rather keep the interface minimal. We can always add this in the
> future if an use-case comes.

As discussed offline, we don't have a use-case for this yet, so I don't ins=
ist.

> --
>  Kirill A. Shutemov



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
