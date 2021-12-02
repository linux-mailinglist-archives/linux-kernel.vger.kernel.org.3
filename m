Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47062465BED
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 02:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348838AbhLBCDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 21:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242154AbhLBCDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 21:03:11 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023A2C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 17:59:50 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id j2so68883348ybg.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 17:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PQbQ01wzti4a86s0mzuGmyRjqSgKeOKXJvkaPDwlmQQ=;
        b=l772S4I6Tkc3ncYGTm3hyJ6KUOQ+rw07AuwbzNu25E6Do8pPBFWhd/Miizq6QPvNXu
         aB2NfCg3dtdaTtPJxvUwr6Ru9ZQbrKzNbFRAYkRWDRTnMKwebo9UgYTzExwuRT9QTMVn
         8iWC3EsuWZoYomEElDfdw55q0ij2Jf1rQzYa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PQbQ01wzti4a86s0mzuGmyRjqSgKeOKXJvkaPDwlmQQ=;
        b=UO3mGQEp68t+Yw0sjSZorBcZUDsfNGjBmVplEJ5+wcdS2Aj6HWuH4rOTdAGSbIsQ+X
         J4t+6SOBaUAa+DmNzfvTRtf4LdNXgO9qeWEVkrHlRWK3lgGCxGEcCP0TdzhyDC34OmDD
         W5bUFHhWdp6XKPxLqP50VQ5WfZ8Tykj/yolqN7mltYXc0b4mHy7X13YBYnGlfWY1P5Kr
         JxoF6WUo9kHT4SQYgL9BVDC+g6de985ItUfx3xix6boKm/mdkeaH1JxLqqjnxJv8B8BW
         uFI9jFyZB9LCwFuKWsroEy8e6zRGiNw4A9iOrcv6y90VH7N0rXHlyfv/7rIRekbI3j/I
         udtA==
X-Gm-Message-State: AOAM530B4sO1uGNj+4/zpIw838/nzHR34bR5PWj50PENRxMKpHfKxSk8
        4E7iJihvHu81Y7LP4KMrJBX3IM7qAew3PQr4VRXJ
X-Google-Smtp-Source: ABdhPJzXw9ht1p5IdtspfcR3Rs31FHDZBP5k4GYV+tQ/lSwPnczsQhO+EW5S+Wbr18E9RrHAhOwm6ttYnXIiMVMAryM=
X-Received: by 2002:a25:4d8:: with SMTP id 207mr11543751ybe.320.1638410389172;
 Wed, 01 Dec 2021 17:59:49 -0800 (PST)
MIME-Version: 1.0
References: <20211129014007.286478-1-wefu@redhat.com> <03B8F784-4AF3-425D-99B6-F753F7970273@jrtc27.com>
 <CAOnJCUKmP6dsrV9xWC52uEaM0=fZh-FNDYyFg1VxQybpQZABMA@mail.gmail.com> <3495709.4EXlkQ93OV@diego>
In-Reply-To: <3495709.4EXlkQ93OV@diego>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 1 Dec 2021 17:59:38 -0800
Message-ID: <CAOnJCUL0mffufWZzWVBDo2akb+kd6rpnDG6aYOuXHWM274i6OA@mail.gmail.com>
Subject: Re: [PATCH V4 1/2] dt-bindings: riscv: add MMU Standard Extensions
 support for Svpbmt
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Jessica Clarke <jrtc27@jrtc27.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Wei Fu <wefu@redhat.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        taiten.peng@canonical.com,
        Aniket Ponkshe <aniket.ponkshe@canonical.com>,
        Gordan Markus <gordan.markus@canonical.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Dan Lustig <dlustig@nvidia.com>,
        Greg Favor <gfavor@ventanamicro.com>,
        Andrea Mondelli <andrea.mondelli@huawei.com>,
        Jonathan Behrens <behrensj@mit.edu>,
        Xinhaoqu <xinhaoqu@huawei.com>,
        Bill Huffman <huffman@cadence.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Allen Baum <allen.baum@esperantotech.com>,
        Josh Scheid <jscheid@ventanamicro.com>,
        Richard Trauben <rtrauben@gmail.com>,
        Anup Patel <anup@brainfault.org>,
        Rob Herring <robh+dt@kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>, atishp04@gmail.com,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Guo Ren <guoren@kernel.org>,
        =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
        Christoph Hellwig <hch@lst.de>,
        liush <liush@allwinnertech.com>, Wei Wu <lazyparser@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 1, 2021 at 5:28 AM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Hi Atish,
>
> Am Mittwoch, 1. Dezember 2021, 02:21:46 CET schrieb Atish Patra:
> > On Tue, Nov 30, 2021 at 8:13 AM Jessica Clarke <jrtc27@jrtc27.com> wrot=
e:
> > >
> > > On 30 Nov 2021, at 15:01, Philipp Tomsich <philipp.tomsich@vrull.eu> =
wrote:
> > > >
> > > > We did touch on this in our coordination call a few weeks ago: the
> > > > grouping under mmu and the bool-entries were chosen because of thei=
r
> > > > similarity to other extensions (i.e. for Zb[abcs] there could/shoul=
d
> > > > be a bool-entry under each cpu-node =E2=80=94 for some Zv* entries =
a subnode
> > > > might be needed with further parameters).
> > > >
> > > > The string-based approach (as in the originally proposed "mmu-type=
=3D")
> > > > would like not scale with the proliferation of small & modular
> > > > extensions.
> > >
> > > I don=E2=80=99t see why the Sv* extensions need to be under an mmu no=
de then,
> > > unless the intent is that every extension be grouped under a sub-node
> > > (which doesn=E2=80=99t seem viable due to extensions like Zbk*, unles=
s you
> > > group by Ss, Sv and Z)?
> > >
> >
> > It shouldn't be. All the ISA extensions (i.e. standard, supervisor & hy=
pervisor)
> > with prefix S,Z,H should be kept separate in a separate node for easy
> > parsing.
> >
> > "riscv,isa" dt property will not scale at all. Just look at the few
> > extensions that were ratified this year
> > and Linux kernel needs to support them.
> >
> > "Sscofpmf", "Svpbmt", "Zicbom"
> >
> > > Also, what is going to happen to the current riscv,isa? Will that
> > > continue to exist and duplicate the info, or will kernels be required
> > > to reconstruct the string themselves if they want to display it to
> > > users?
> > >
> >
> > This is my personal preference:
> > riscv,isa will continue to base Standard ISA extensions that have
> > single letter extensions.
> >
> > This new DT node will encode all the non-single letter extensions.
> > I am not sure if it should include some provisions for custom
> > extensions starting with X because
> > that will be platform specific.
> >
> > Again, this is just my personal preference. I will try to send a patch
> > soon so that we can initiate a broader
> > discussion of the scheme and agree/disagree on something.
>
> that would be really helpful, as it currently looks like we have a number
> of different points-of-view so discussing an actual implementation will
> probably make things a lot easier compared to dancing around theoretic
> cases :-) .
>
> Out of curiosity, how soon is "soon" ? :-D
>

I will be on vacation for next week and I need to wrap up a few other
things before that.
Thus, soon may not be the "soon" you are expecting ;).

If you or Tsukasa have some free cycles, feel free to send the patch
in the meantime.

>
> Heiko
>
>
> > > As a FreeBSD developer I=E2=80=99m obviously not a part of many of th=
ese
> > > discussions, but what the Linux community imposes as the device tree
> > > bindings has a real impact on us.
> > >
> > > Jess
> > >
> > > > On Tue, 30 Nov 2021 at 14:59, Jessica Clarke <jrtc27@jrtc27.com> wr=
ote:
> > > >>
> > > >> On 30 Nov 2021, at 13:27, Heiko St=C3=BCbner <heiko@sntech.de> wro=
te:
> > > >>>
> > > >>> Hi,
> > > >>>
> > > >>> Am Dienstag, 30. November 2021, 14:17:41 CET schrieb Jessica Clar=
ke:
> > > >>>> On 30 Nov 2021, at 12:07, Heiko St=C3=BCbner <heiko@sntech.de> w=
rote:
> > > >>>>>
> > > >>>>> Am Montag, 29. November 2021, 13:06:23 CET schrieb Heiko St=C3=
=BCbner:
> > > >>>>>> Am Montag, 29. November 2021, 09:54:39 CET schrieb Heinrich Sc=
huchardt:
> > > >>>>>>> On 11/29/21 02:40, wefu@redhat.com wrote:
> > > >>>>>>>> From: Wei Fu <wefu@redhat.com>
> > > >>>>>>>>
> > > >>>>>>>> Previous patch has added svpbmt in arch/riscv and add "riscv=
,svpmbt"
> > > >>>>>>>> in the DT mmu node. Update dt-bindings related property here=
.
> > > >>>>>>>>
> > > >>>>>>>> Signed-off-by: Wei Fu <wefu@redhat.com>
> > > >>>>>>>> Co-developed-by: Guo Ren <guoren@kernel.org>
> > > >>>>>>>> Signed-off-by: Guo Ren <guoren@kernel.org>
> > > >>>>>>>> Cc: Anup Patel <anup@brainfault.org>
> > > >>>>>>>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > > >>>>>>>> Cc: Rob Herring <robh+dt@kernel.org>
> > > >>>>>>>> ---
> > > >>>>>>>> Documentation/devicetree/bindings/riscv/cpus.yaml | 10 +++++=
+++++
> > > >>>>>>>> 1 file changed, 10 insertions(+)
> > > >>>>>>>>
> > > >>>>>>>> diff --git a/Documentation/devicetree/bindings/riscv/cpus.ya=
ml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > >>>>>>>> index aa5fb64d57eb..9ff9cbdd8a85 100644
> > > >>>>>>>> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > >>>>>>>> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > >>>>>>>> @@ -63,6 +63,16 @@ properties:
> > > >>>>>>>>      - riscv,sv48
> > > >>>>>>>>      - riscv,none
> > > >>>>>>>>
> > > >>>>>>>> +  mmu:
> > > >>>>>>>
> > > >>>>>>> Shouldn't we keep the items be in alphabetic order, i.e. mmu =
before
> > > >>>>>>> mmu-type?
> > > >>>>>>>
> > > >>>>>>>> +    description:
> > > >>>>>>>> +      Describes the CPU's MMU Standard Extensions support.
> > > >>>>>>>> +      These values originate from the RISC-V Privileged
> > > >>>>>>>> +      Specification document, available from
> > > >>>>>>>> +      https://riscv.org/specifications/
> > > >>>>>>>> +    $ref: '/schemas/types.yaml#/definitions/string'
> > > >>>>>>>> +    enum:
> > > >>>>>>>> +      - riscv,svpmbt
> > > >>>>>>>
> > > >>>>>>> The privileged specification has multiple MMU related extensi=
ons:
> > > >>>>>>> Svnapot, Svpbmt, Svinval. Shall they all be modeled in this e=
num?
> > > >>>>>>
> > > >>>>>> I remember in some earlier version some way back there was the
> > > >>>>>> suggestion of using a sub-node instead and then adding boolean
> > > >>>>>> properties for the supported extensions.
> > > >>>>>>
> > > >>>>>> Aka something like
> > > >>>>>>   mmu {
> > > >>>>>>           riscv,svpbmt;
> > > >>>>>>   };
> > > >>>>>
> > > >>>>> For the record, I'm talking about the mail from september
> > > >>>>> https://lore.kernel.org/linux-riscv/CAAeLtUChjjzG+P8yg45GLZMJy5=
UR2K5RRBoLFVZhtOaZ5pPtEA@mail.gmail.com/
> > > >>>>>
> > > >>>>> So having a sub-node would make adding future extensions
> > > >>>>> way nicer.
> > > >>>>
> > > >>>> Svpbmt is just an ISA extension, and should be treated like any =
other.
> > > >>>> Let=E2=80=99s not invent two different ways of representing that=
 in the device
> > > >>>> tree.
> > > >>>
> > > >>> Heinrich asked how the other extensions should be handled
> > > >>> (Svnapot, Svpbmt, Svinval), so what do you suggest to do with the=
se?
> > > >>
> > > >> Whatever is done for Zb[abcs], Zk*, Zv*, Zicbo*, etc. There may no=
t be
> > > >> a concrete plan for that yet, but that means you should speak with=
 the
> > > >> people involved with such extensions and come up with something
> > > >> appropriate together.
> > > >>
> > > >> Jess
> > > >>
> > >
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
> >
> >
> > --
> > Regards,
> > Atish
> >
>
>
>
>


--=20
Regards,
Atish
