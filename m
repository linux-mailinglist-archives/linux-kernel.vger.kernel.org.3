Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A38E463994
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 16:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243794AbhK3PPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 10:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243372AbhK3PFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 10:05:19 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D29C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 07:01:59 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d24so45154546wra.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 07:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull-eu.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Tt3rzy7U8jtDDkOr2bs9fpOdOEtwyk7EaYJRM5UbHUM=;
        b=YtrhNfmIJKIvBB5hQT4rkZcNSUkuhiHkssVg4vSjLhGAv4gArvLcH7KCIyD13B71oR
         7XsW7sbLRob+sa6/ydYT/y637VgYkbATtaIzB13BbjxHFFqLCggDMprBYkVd+xJ28uzq
         q8FijndPMSoI3y4fyC0TKf65YCw8iRCfnP75HnWlTQQPoR5ZgYS5gRUI8mbXWsmNikas
         yX8zqrJjfoiYNlFmXtN7C0cErClOsxn7hpoSyQkNlRqSpIfG97GTt5EsS2e0coeFnUtu
         X9gYcTuPJIs+y01E3KHl1nBZnze0L5qBkqE1rvmklVeIzVHyc7EZYUF9CSegGpF3F/vj
         SujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Tt3rzy7U8jtDDkOr2bs9fpOdOEtwyk7EaYJRM5UbHUM=;
        b=QiPO+Kqbw0ZBmTqTIelCefxX1PQZpX+nrSMQ8mFpIzs6vJEA0R3U2ruRsgfZp0abrb
         dU7QZ6mvp9vgLo9Nysz5F+FwkAmp0fU3IaNMe7/ZuZTqJS+MoqKEB+TAVUYLAnURQM+S
         PJw48XmmR2DLabIWWrDHhy/Siz0y0caNCPvhyf3lFT8gu0TSoNrWPMDpwypaFn3fakVd
         gIpD0Y/Jrf+PMcLCp5frWlLCEIYH+DZ8JOMv/S9LzkfgGVpAr1sbcTq892ufdpqNM8P5
         Ho26IS+itdsEkIblkK/7fuZWqvkkFwtAG7gpiMkS7fzDFyLttqBm75MRPf+wSjzYygPK
         bUdQ==
X-Gm-Message-State: AOAM531v/pFBp7k5d2rXoo1JmnTWj6vPcJv6Ddsk++gpjqWFLOt0ICgM
        1/eVpxsvq2yCX1V6Xml5dILbZsLdkhiXjgv9JhGDZw==
X-Google-Smtp-Source: ABdhPJzPtijXN7E4GbyZ8xSeGh+7wpmLdDsqXOAZ5ENfPFxSIVDg6BjfnnRGBSaLa1O64aYfYAIau9hY1/IrEKqETZ8=
X-Received: by 2002:adf:eac8:: with SMTP id o8mr42150427wrn.337.1638284517883;
 Tue, 30 Nov 2021 07:01:57 -0800 (PST)
MIME-Version: 1.0
References: <20211129014007.286478-1-wefu@redhat.com> <1909580.k68io2XIxi@diego>
 <D7F256F9-F31F-4663-AADD-A535E159F87C@jrtc27.com> <2728314.U2HhIfhhqV@diego> <C19C85E6-821B-4A87-B764-56CF4D53E7FA@jrtc27.com>
In-Reply-To: <C19C85E6-821B-4A87-B764-56CF4D53E7FA@jrtc27.com>
From:   Philipp Tomsich <philipp.tomsich@vrull.eu>
Date:   Tue, 30 Nov 2021 16:01:47 +0100
Message-ID: <CAAeLtUC0Qc6ysf31sh0dkvfJD-JsREZbyFFk=Ko0vQeBRzyjaw@mail.gmail.com>
Subject: Re: [PATCH V4 1/2] dt-bindings: riscv: add MMU Standard Extensions
 support for Svpbmt
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Wei Fu <wefu@redhat.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        taiten.peng@canonical.com, aniket.ponkshe@canonical.com,
        gordan.markus@canonical.com, Guo Ren <guoren@linux.alibaba.com>,
        arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        Dan Lustig <dlustig@nvidia.com>,
        Greg Favor <gfavor@ventanamicro.com>,
        andrea.mondelli@huawei.com, behrensj@mit.edu, xinhaoqu@huawei.com,
        huffman@cadence.com, Nick Kossifidis <mick@ics.forth.gr>,
        Allen Baum <allen.baum@esperantotech.com>,
        jscheid@ventanamicro.com, rtrauben@gmail.com,
        Anup Patel <anup@brainfault.org>,
        Rob Herring <robh+dt@kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>, atishp04@gmail.com,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Guo Ren <guoren@kernel.org>,
        =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
        hch@lst.de, liush@allwinnertech.com, Wei Wu <lazyparser@gmail.com>,
        drew@beagleboard.org,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We did touch on this in our coordination call a few weeks ago: the
grouping under mmu and the bool-entries were chosen because of their
similarity to other extensions (i.e. for Zb[abcs] there could/should
be a bool-entry under each cpu-node =E2=80=94 for some Zv* entries a subnod=
e
might be needed with further parameters).

The string-based approach (as in the originally proposed "mmu-type=3D")
would like not scale with the proliferation of small & modular
extensions.

Philipp.


On Tue, 30 Nov 2021 at 14:59, Jessica Clarke <jrtc27@jrtc27.com> wrote:
>
> On 30 Nov 2021, at 13:27, Heiko St=C3=BCbner <heiko@sntech.de> wrote:
> >
> > Hi,
> >
> > Am Dienstag, 30. November 2021, 14:17:41 CET schrieb Jessica Clarke:
> >> On 30 Nov 2021, at 12:07, Heiko St=C3=BCbner <heiko@sntech.de> wrote:
> >>>
> >>> Am Montag, 29. November 2021, 13:06:23 CET schrieb Heiko St=C3=BCbner=
:
> >>>> Am Montag, 29. November 2021, 09:54:39 CET schrieb Heinrich Schuchar=
dt:
> >>>>> On 11/29/21 02:40, wefu@redhat.com wrote:
> >>>>>> From: Wei Fu <wefu@redhat.com>
> >>>>>>
> >>>>>> Previous patch has added svpbmt in arch/riscv and add "riscv,svpmb=
t"
> >>>>>> in the DT mmu node. Update dt-bindings related property here.
> >>>>>>
> >>>>>> Signed-off-by: Wei Fu <wefu@redhat.com>
> >>>>>> Co-developed-by: Guo Ren <guoren@kernel.org>
> >>>>>> Signed-off-by: Guo Ren <guoren@kernel.org>
> >>>>>> Cc: Anup Patel <anup@brainfault.org>
> >>>>>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> >>>>>> Cc: Rob Herring <robh+dt@kernel.org>
> >>>>>> ---
> >>>>>> Documentation/devicetree/bindings/riscv/cpus.yaml | 10 ++++++++++
> >>>>>> 1 file changed, 10 insertions(+)
> >>>>>>
> >>>>>> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/D=
ocumentation/devicetree/bindings/riscv/cpus.yaml
> >>>>>> index aa5fb64d57eb..9ff9cbdd8a85 100644
> >>>>>> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> >>>>>> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> >>>>>> @@ -63,6 +63,16 @@ properties:
> >>>>>>       - riscv,sv48
> >>>>>>       - riscv,none
> >>>>>>
> >>>>>> +  mmu:
> >>>>>
> >>>>> Shouldn't we keep the items be in alphabetic order, i.e. mmu before
> >>>>> mmu-type?
> >>>>>
> >>>>>> +    description:
> >>>>>> +      Describes the CPU's MMU Standard Extensions support.
> >>>>>> +      These values originate from the RISC-V Privileged
> >>>>>> +      Specification document, available from
> >>>>>> +      https://riscv.org/specifications/
> >>>>>> +    $ref: '/schemas/types.yaml#/definitions/string'
> >>>>>> +    enum:
> >>>>>> +      - riscv,svpmbt
> >>>>>
> >>>>> The privileged specification has multiple MMU related extensions:
> >>>>> Svnapot, Svpbmt, Svinval. Shall they all be modeled in this enum?
> >>>>
> >>>> I remember in some earlier version some way back there was the
> >>>> suggestion of using a sub-node instead and then adding boolean
> >>>> properties for the supported extensions.
> >>>>
> >>>> Aka something like
> >>>>    mmu {
> >>>>            riscv,svpbmt;
> >>>>    };
> >>>
> >>> For the record, I'm talking about the mail from september
> >>> https://lore.kernel.org/linux-riscv/CAAeLtUChjjzG+P8yg45GLZMJy5UR2K5R=
RBoLFVZhtOaZ5pPtEA@mail.gmail.com/
> >>>
> >>> So having a sub-node would make adding future extensions
> >>> way nicer.
> >>
> >> Svpbmt is just an ISA extension, and should be treated like any other.
> >> Let=E2=80=99s not invent two different ways of representing that in th=
e device
> >> tree.
> >
> > Heinrich asked how the other extensions should be handled
> > (Svnapot, Svpbmt, Svinval), so what do you suggest to do with these?
>
> Whatever is done for Zb[abcs], Zk*, Zv*, Zicbo*, etc. There may not be
> a concrete plan for that yet, but that means you should speak with the
> people involved with such extensions and come up with something
> appropriate together.
>
> Jess
>
