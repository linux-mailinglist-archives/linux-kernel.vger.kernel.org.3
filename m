Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87CA4464C54
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 12:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348852AbhLALIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 06:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhLALIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 06:08:36 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2299BC061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 03:05:16 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id i12so20002958wmq.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 03:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull-eu.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cASmlE/JB8XT7AoAc4GGiejGFRxBBR3Z2l1jvd0xmpc=;
        b=BtGzNIy9PmQlXlgEzxeh57FOCRdQuG0SkVg/jurKCSC3Ub7cDvMiGLWB3z0F0JAPuy
         fnzSWhQl0oqLHKJyx0Vw3/kEvkYhyYKhL/3gN3Owq/odfOctCeN7h9lEl4paPS9PvqJS
         MWUnFIBGIkSnIH+CHB30zz8uEkTV9nswyQl9JM1a+CCRGc1fbuqb6lrVUtr++ElNGnrm
         m9X/wluqD3f6MSgSOPQjND/AIxhm/3dWOWvwzxj/jlUz26b1dbVhaCcqcUA6jN2wZbge
         fUJuUFMZdKoN3yTmJA1W1XGozuihvlRwDrBqKfs9AhckLyyS9MIYei+7OqaaUxToY7eh
         WB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cASmlE/JB8XT7AoAc4GGiejGFRxBBR3Z2l1jvd0xmpc=;
        b=IZc8gZV5HUWngDL6GJ0ZzEUiRk8V1/TbQ3BwX+2TMqz4op45Ye6eNd3/ANMtAzx9zL
         WVj2E7Zmwd4V5+7FAxu2lIGH9TmVO+MI/kUHhB5roFSJoDluiCEQfSxuLTIxaqlhXKk3
         16INCZWNZTjXdsJPvmXO4mgKxCBwLRDmw0Pa5GtdapI90JA/q72MXjoccsxLwo1SvLJt
         aLCYXKtpuVzxkL3FX5VAZpHiMNX4w8uyXy5XTCumYPA3ejxG5Jx3lYM1yKwOWG2RkUbQ
         e5jSEkn1TFKvLBZNTXXzOSx7E7anT7UVSbOi4lWH+24boMQobbb/jMAeOuUWVci7ZeQy
         2Uxw==
X-Gm-Message-State: AOAM530Q9lhlr1hUpWhl4zSVnTOl01pR+x9vIiEsKji4Q/I2YPMqHvyi
        cq9FL4h3PVOJDIS+H7A4K9bV29CI6dQgtG+M3TsEfQ==
X-Google-Smtp-Source: ABdhPJylvR1rBiJVnt6NbFETtc14kE6pqZ7subXDhcrs7dylT3b1pbmHN889fciYpNMWPNNpa/kMFgrtOjM05dYKIGg=
X-Received: by 2002:a05:600c:1990:: with SMTP id t16mr6082978wmq.48.1638356714288;
 Wed, 01 Dec 2021 03:05:14 -0800 (PST)
MIME-Version: 1.0
References: <20211129014007.286478-1-wefu@redhat.com> <7587334.dMCaUTs8Vl@diego>
 <CAELrHRDb9oeu_FokyhUFQ+Yu27=4xqvPdz4=08MXQzh3Bj2Myw@mail.gmail.com> <2562321.AMx6Y6Rosd@diego>
In-Reply-To: <2562321.AMx6Y6Rosd@diego>
From:   Philipp Tomsich <philipp.tomsich@vrull.eu>
Date:   Wed, 1 Dec 2021 12:05:03 +0100
Message-ID: <CAAeLtUA86dhERyXq02_QHx3q9kN6PC7OTGSKpc88godsQsborw@mail.gmail.com>
Subject: Re: [PATCH V4 1/2] dt-bindings: riscv: add MMU Standard Extensions
 support for Svpbmt
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     atish patra <atishp04@gmail.com>,
        Tsukasa OI <research_trasio@irq.a4lg.com>,
        Atish Patra <atishp@atishpatra.org>,
        Jessica Clarke <jrtc27@jrtc27.com>,
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
        Anup Patel <Anup.Patel@wdc.com>,
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

I hope that cpuinfo is for human consumption only, as we will inject
this info in machine-readable form via the ELF auxiliary vector.
We had briefly discussed this as part of psABI and during Kito's
presentation at LPC.

If we can agree that this is for human consumption only, then we
should aim at making it easy to read for humans (and not care too much
about how easy this will be to parse).

Philipp.


On Wed, 1 Dec 2021 at 11:21, Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Am Mittwoch, 1. Dezember 2021, 09:41:48 CET schrieb atish patra:
> > On Wed, Dec 1, 2021 at 12:30 AM Heiko St=C3=BCbner <heiko@sntech.de> wr=
ote:
> >
> > > Am Mittwoch, 1. Dezember 2021, 09:15:18 CET schrieb Atish Patra:
> > > > On Tue, Nov 30, 2021 at 7:06 PM Tsukasa OI <research_trasio@irq.a4l=
g.com>
> > > wrote:
> > > > >
> > > > > On 2021/12/01 10:21, Atish Patra wrote:
> > > > > > On Tue, Nov 30, 2021 at 8:13 AM Jessica Clarke <jrtc27@jrtc27.c=
om>
> > > wrote:
> > > > > >>
> > > > > >> On 30 Nov 2021, at 15:01, Philipp Tomsich <philipp.tomsich@vru=
ll.eu>
> > > wrote:
> > > > > >>>
> > > > > >>> We did touch on this in our coordination call a few weeks ago=
: the
> > > > > >>> grouping under mmu and the bool-entries were chosen because o=
f
> > > their
> > > > > >>> similarity to other extensions (i.e. for Zb[abcs] there
> > > could/should
> > > > > >>> be a bool-entry under each cpu-node =E2=80=94 for some Zv* en=
tries a
> > > subnode
> > > > > >>> might be needed with further parameters).
> > > > > >>>
> > > > > >>> The string-based approach (as in the originally proposed
> > > "mmu-type=3D")
> > > > > >>> would like not scale with the proliferation of small & modula=
r
> > > > > >>> extensions.
> > > > > >>
> > > > > >> I don=E2=80=99t see why the Sv* extensions need to be under an=
 mmu node
> > > then,
> > > > > >> unless the intent is that every extension be grouped under a
> > > sub-node
> > > > > >> (which doesn=E2=80=99t seem viable due to extensions like Zbk*=
, unless you
> > > > > >> group by Ss, Sv and Z)?
> > > > > >>
> > > > > >
> > > > > > It shouldn't be. All the ISA extensions (i.e. standard, supervi=
sor &
> > > hypervisor)
> > > > > > with prefix S,Z,H should be kept separate in a separate node fo=
r easy
> > > > > > parsing.
> > > > >
> > > > > "Easy parsing" is not quite convincing.
> > > >
> > > > The device tree need to carry a very long "riscv,isa" string. The
> > > > parser need to parse
> > > > that string in memory as well.
> > > >
> > > > >
> > > > > There's a reason other than that I made RFC PATCH to parse
> > > > > multi-letter extensions:
> > > > >
> > > > > v1: <
> > > http://lists.infradead.org/pipermail/linux-riscv/2021-November/010252=
.html
> > > >
> > > > > v2: <
> > > http://lists.infradead.org/pipermail/linux-riscv/2021-November/010350=
.html
> > > >
> > > > >
> > > >
> > > > It's on my todo list to review the series. I think we can work
> > > > together to propose a better framework for riscv isa extensions.
> > > >
> > > > > (note: those patches will break RISC-V KVM because of possible IS=
A
> > > > >        Manual inconsistency and discussion/resolution needed)
> > > > >
> > > > > (...continued below...)
> > > > >
> > > > > >
> > > > > > "riscv,isa" dt property will not scale at all. Just look at the=
 few
> > > > > > extensions that were ratified this year
> > > > > > and Linux kernel needs to support them.
> > > > > >
> > > > > > "Sscofpmf", "Svpbmt", "Zicbom"
> > > > > >
> > > > > >> Also, what is going to happen to the current riscv,isa? Will t=
hat
> > > > > >> continue to exist and duplicate the info, or will kernels be
> > > required
> > > > > >> to reconstruct the string themselves if they want to display i=
t to
> > > > > >> users?
> > > > > >>
> > > >
> > > > Sorry. I missed this question earlier. See my answer below.
> > > >
> > > > > >
> > > > > > This is my personal preference:
> > > > > > riscv,isa will continue to base Standard ISA extensions that ha=
ve
> > > > > > single letter extensions.
> > > > > >
> > > > > > This new DT node will encode all the non-single letter extensio=
ns.
> > > > > > I am not sure if it should include some provisions for custom
> > > > > > extensions starting with X because
> > > > > > that will be platform specific.
> > > > > >
> > > > > > Again, this is just my personal preference. I will try to send =
a
> > > patch
> > > > > > soon so that we can initiate a broader
> > > > > > discussion of the scheme and agree/disagree on something.
> > > > >
> > > > > For supervisor-only extensions like "Svpbmt", new DT node would b=
e a
> > > > > reasonable solution (and I would not directly object about that n=
ode).
> > > > >
> > > > > However, there's many multi-letter extensions that are useful for
> > > > > user mode.  Because "riscv,isa" is exposed via sysfs and procfs
> > > > > (/proc/cpuinfo), it can be really helpful to have multi-letter
> > > >
> > > > Irrespective of the method chosen to parse the device tree in kerne=
l,
> > > > we need to provide the extension information to the userspace.
> > > >
> > > > This is what I have in mind. An individual row with comma separated
> > > > extension names for each type of extensions (Ss, Sv, Sh)
> > > > after the base extension (rv64imafdc) in /proc/cpuinfo output. I am
> > > > open to other ideas as well.
> > > >
> > > > isa   rv64imafdc
> > > > isa-ext-Sv Svpbmt
> > > > isa-ext-Ss Sscofpmf
> > > > isa-ext-Sh <hypervisor related extensions>
> > > > isa-ext-Z   Zicbom
> > > >
> > > > We can even explicitly name the extensions after isa-ext. However, =
it
> > > > may be necessary and too long.
> > >
> > > Aren't other architectures just using a flags [x86] or features [arm6=
4]
> > > line in cpuinfo to expose the available additional cpu features
> > > as a space-separated list?
> > >
> > > So you could also just do something similar like
> > > isa:   rv64imafdc
> > > isa-ext: Svpbmt Sscofpmf foo bar
> > >
> > >
> > A space separated list is also fine by me.
> > Should we keep all the extensions as one row or split based on the type=
 of
> > extensions (Ss, Sv, Sh,)?
> >
> > When I look at the flags in x86, my eyes hurt badly ;)
>
> On arm64
> Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
>
> or on arm32
> Features        : half thumb fastmult vfp edsp thumbee neon vfpv3 tls vfp=
v4 idiva idivt vfpd32 lpae evtstrm
>
>
> > That's why I suggested splitting by type of extensions to improve
> > readability.
>
> Though I guess with that split you introduce more requirements on userspa=
ce?
> Because things that parse cpuinfo (think some python library) will need t=
o
> be updated when some new extension category surfaces?
>
>
>
> > > That would make a nice compromise between length and readability
> > > by users I guess?
> > >
> > >
> > > Heiko
> > >
> > > > I guess you prefer to directly print the entire "riscv,isa" string =
in
> > > > "isa" row in /proc/cpuinfo output.
> > > > It is probably okay with the current number of extensions available
> > > > today. However, it will become so long string
> > > > in the future that it has to be broken into multiple lines.
> > > >
> > > > > extensions.  Also, current version of Spike, a RISC-V ISA Simulat=
or
> > > > > puts all multi-letter extensions in "riscv,isa" and I thought thi=
s is
> > > > > intended.
> > > > >
> > > > > My preference:
> > > > > (1) Allow having multi-letter extensions and versions in "riscv,i=
sa"
> > > > > (2) Adding new DT node for supervisor-related extensions would be
> > > > >     reasonable (but I don't strongly agree/disagree).
> > > > >
> > > > > Thanks,
> > > > > Tsukasa
> > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > >> As a FreeBSD developer I=E2=80=99m obviously not a part of man=
y of these
> > > > > >> discussions, but what the Linux community imposes as the devic=
e tree
> > > > > >> bindings has a real impact on us.
> > > > > >>
> > > > > >> Jess
> > > > > >>
> > > > > >>> On Tue, 30 Nov 2021 at 14:59, Jessica Clarke <jrtc27@jrtc27.c=
om>
> > > wrote:
> > > > > >>>>
> > > > > >>>> On 30 Nov 2021, at 13:27, Heiko St=C3=BCbner <heiko@sntech.d=
e> wrote:
> > > > > >>>>>
> > > > > >>>>> Hi,
> > > > > >>>>>
> > > > > >>>>> Am Dienstag, 30. November 2021, 14:17:41 CET schrieb Jessic=
a
> > > Clarke:
> > > > > >>>>>> On 30 Nov 2021, at 12:07, Heiko St=C3=BCbner <heiko@sntech=
.de>
> > > wrote:
> > > > > >>>>>>>
> > > > > >>>>>>> Am Montag, 29. November 2021, 13:06:23 CET schrieb Heiko
> > > St=C3=BCbner:
> > > > > >>>>>>>> Am Montag, 29. November 2021, 09:54:39 CET schrieb Heinr=
ich
> > > Schuchardt:
> > > > > >>>>>>>>> On 11/29/21 02:40, wefu@redhat.com wrote:
> > > > > >>>>>>>>>> From: Wei Fu <wefu@redhat.com>
> > > > > >>>>>>>>>>
> > > > > >>>>>>>>>> Previous patch has added svpbmt in arch/riscv and add
> > > "riscv,svpmbt"
> > > > > >>>>>>>>>> in the DT mmu node. Update dt-bindings related propert=
y
> > > here.
> > > > > >>>>>>>>>>
> > > > > >>>>>>>>>> Signed-off-by: Wei Fu <wefu@redhat.com>
> > > > > >>>>>>>>>> Co-developed-by: Guo Ren <guoren@kernel.org>
> > > > > >>>>>>>>>> Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > > >>>>>>>>>> Cc: Anup Patel <anup@brainfault.org>
> > > > > >>>>>>>>>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > > > > >>>>>>>>>> Cc: Rob Herring <robh+dt@kernel.org>
> > > > > >>>>>>>>>> ---
> > > > > >>>>>>>>>> Documentation/devicetree/bindings/riscv/cpus.yaml | 10
> > > ++++++++++
> > > > > >>>>>>>>>> 1 file changed, 10 insertions(+)
> > > > > >>>>>>>>>>
> > > > > >>>>>>>>>> diff --git
> > > a/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > > > >>>>>>>>>> index aa5fb64d57eb..9ff9cbdd8a85 100644
> > > > > >>>>>>>>>> --- a/Documentation/devicetree/bindings/riscv/cpus.yam=
l
> > > > > >>>>>>>>>> +++ b/Documentation/devicetree/bindings/riscv/cpus.yam=
l
> > > > > >>>>>>>>>> @@ -63,6 +63,16 @@ properties:
> > > > > >>>>>>>>>>      - riscv,sv48
> > > > > >>>>>>>>>>      - riscv,none
> > > > > >>>>>>>>>>
> > > > > >>>>>>>>>> +  mmu:
> > > > > >>>>>>>>>
> > > > > >>>>>>>>> Shouldn't we keep the items be in alphabetic order, i.e=
. mmu
> > > before
> > > > > >>>>>>>>> mmu-type?
> > > > > >>>>>>>>>
> > > > > >>>>>>>>>> +    description:
> > > > > >>>>>>>>>> +      Describes the CPU's MMU Standard Extensions sup=
port.
> > > > > >>>>>>>>>> +      These values originate from the RISC-V Privileg=
ed
> > > > > >>>>>>>>>> +      Specification document, available from
> > > > > >>>>>>>>>> +      https://riscv.org/specifications/
> > > > > >>>>>>>>>> +    $ref: '/schemas/types.yaml#/definitions/string'
> > > > > >>>>>>>>>> +    enum:
> > > > > >>>>>>>>>> +      - riscv,svpmbt
> > > > > >>>>>>>>>
> > > > > >>>>>>>>> The privileged specification has multiple MMU related
> > > extensions:
> > > > > >>>>>>>>> Svnapot, Svpbmt, Svinval. Shall they all be modeled in =
this
> > > enum?
> > > > > >>>>>>>>
> > > > > >>>>>>>> I remember in some earlier version some way back there w=
as the
> > > > > >>>>>>>> suggestion of using a sub-node instead and then adding b=
oolean
> > > > > >>>>>>>> properties for the supported extensions.
> > > > > >>>>>>>>
> > > > > >>>>>>>> Aka something like
> > > > > >>>>>>>>   mmu {
> > > > > >>>>>>>>           riscv,svpbmt;
> > > > > >>>>>>>>   };
> > > > > >>>>>>>
> > > > > >>>>>>> For the record, I'm talking about the mail from september
> > > > > >>>>>>>
> > > https://lore.kernel.org/linux-riscv/CAAeLtUChjjzG+P8yg45GLZMJy5UR2K5R=
RBoLFVZhtOaZ5pPtEA@mail.gmail.com/
> > > > > >>>>>>>
> > > > > >>>>>>> So having a sub-node would make adding future extensions
> > > > > >>>>>>> way nicer.
> > > > > >>>>>>
> > > > > >>>>>> Svpbmt is just an ISA extension, and should be treated lik=
e any
> > > other.
> > > > > >>>>>> Let=E2=80=99s not invent two different ways of representin=
g that in the
> > > device
> > > > > >>>>>> tree.
> > > > > >>>>>
> > > > > >>>>> Heinrich asked how the other extensions should be handled
> > > > > >>>>> (Svnapot, Svpbmt, Svinval), so what do you suggest to do wi=
th
> > > these?
> > > > > >>>>
> > > > > >>>> Whatever is done for Zb[abcs], Zk*, Zv*, Zicbo*, etc. There =
may
> > > not be
> > > > > >>>> a concrete plan for that yet, but that means you should spea=
k
> > > with the
> > > > > >>>> people involved with such extensions and come up with someth=
ing
> > > > > >>>> appropriate together.
> > > > > >>>>
> > > > > >>>> Jess
> > > > > >>>>
> > > > > >>
> > > > > >>
> > > > > >> _______________________________________________
> > > > > >> linux-riscv mailing list
> > > > > >> linux-riscv@lists.infradead.org
> > > > > >> http://lists.infradead.org/mailman/listinfo/linux-riscv
> > > > > >
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Regards,
> > > > > > Atish
> > > > > >
> > > > > > _______________________________________________
> > > > > > linux-riscv mailing list
> > > > > > linux-riscv@lists.infradead.org
> > > > > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> > > > > >
> > > >
> > > >
> > > >
> > > >
> > >
> > >
> > >
> > >
> > >
> >
> >
>
>
>
>
