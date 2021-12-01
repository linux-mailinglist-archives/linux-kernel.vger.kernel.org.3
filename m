Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56587464EEA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 14:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349598AbhLANmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 08:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349578AbhLANmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 08:42:37 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024CBC061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 05:39:17 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id q3so29487796wru.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 05:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lE2XEeNXGkQ8mbk4Q/MaQIePfPKsu1W1uPhLzwhUtQQ=;
        b=pF45ZjiKOub/gQBs58xf1hd8DDVofFw9bghJOSD6FB1E03thrQah3agdCyfU5qbQcg
         KyNS+ZcXN24/0bBSXj0I9+zf5kqe+jLj6TDH+txI4MLepo7gyk3vNQeS5QUsUOzfzO42
         ECJuvqCZTcHiwPHF95KTNRkwtdBQyfAPTsH8Hh7/nzgi1p2RvJoUWczFNYfx3vATk5zr
         p2hjRsYQi94mb7q5Larehuok4D66vwtv3Jw7dDu6p/YjMttrhC9Yt/G/szEtW7/cQcXD
         /PkKOBFbSpcFH8L8mzQDsww4CIKvXeBPTZ+AVICq/kjv6v/TcUhuuWKP8O+UHwcHpL0w
         idaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lE2XEeNXGkQ8mbk4Q/MaQIePfPKsu1W1uPhLzwhUtQQ=;
        b=F9GzflLgc24vlJ312Dmx4QT33HqVElvoZiWdM5I0IY01laGZilBakFywlDxZwKww60
         jKNUKe4MSLhj5ZNZdi4WfWsIOH49XsiJmrsVrFeS2WnrpDuB5k1njTmBukmYBHKaID5A
         kGZ+++YsfNwQtbbajIuAESySQgOu0c+FA+CmOyEL0t8UeuBwIY3qymSr3u1GKdO9F5JZ
         7XnA7HGgBPQ9XJc/T3FMroFFzl4zZArJAFkk88c1gqr1ybul7KWXjruHVMUijcxNemRw
         srrH9NwfMn3aB3B0pAtbj7UUyU8eBsEq5EQM0PhBVakJcTEaTajdTwXzi/9I/RWGpzg1
         VB3A==
X-Gm-Message-State: AOAM531OSQqLLVQHiK4/TbwVoTyfnHcBHZw0nwJ141jflcU8yYh5zH8v
        6766MT1yK0fBkPUBxeK/Em2xJA==
X-Google-Smtp-Source: ABdhPJx3IeYQzdypGrNAoTv1cPokvEDl4vkuRgyZ5U1T2Ei4mYUuZ+Lea5KqIld0h+4VI0y1fx5u7w==
X-Received: by 2002:a5d:44d1:: with SMTP id z17mr6887768wrr.143.1638365955451;
        Wed, 01 Dec 2021 05:39:15 -0800 (PST)
Received: from smtpclient.apple (global-5-141.nat-2.net.cam.ac.uk. [131.111.5.141])
        by smtp.gmail.com with ESMTPSA id m17sm18807044wrz.22.2021.12.01.05.39.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Dec 2021 05:39:15 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH V4 1/2] dt-bindings: riscv: add MMU Standard Extensions
 support for Svpbmt
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <CAAeLtUA86dhERyXq02_QHx3q9kN6PC7OTGSKpc88godsQsborw@mail.gmail.com>
Date:   Wed, 1 Dec 2021 13:39:05 +0000
Cc:     =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        atish patra <atishp04@gmail.com>,
        Tsukasa OI <research_trasio@irq.a4lg.com>,
        Atish Patra <atishp@atishpatra.org>,
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
        =?utf-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
        Christoph Hellwig <hch@lst.de>,
        liush <liush@allwinnertech.com>, Wei Wu <lazyparser@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6C7B4C98-31A5-4E62-A494-79947C614563@jrtc27.com>
References: <20211129014007.286478-1-wefu@redhat.com>
 <7587334.dMCaUTs8Vl@diego>
 <CAELrHRDb9oeu_FokyhUFQ+Yu27=4xqvPdz4=08MXQzh3Bj2Myw@mail.gmail.com>
 <2562321.AMx6Y6Rosd@diego>
 <CAAeLtUA86dhERyXq02_QHx3q9kN6PC7OTGSKpc88godsQsborw@mail.gmail.com>
To:     Philipp Tomsich <philipp.tomsich@vrull.eu>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 Dec 2021, at 11:05, Philipp Tomsich <philipp.tomsich@vrull.eu> =
wrote:
>=20
> I hope that cpuinfo is for human consumption only, as we will inject
> this info in machine-readable form via the ELF auxiliary vector.
> We had briefly discussed this as part of psABI and during Kito's
> presentation at LPC.
>=20
> If we can agree that this is for human consumption only, then we
> should aim at making it easy to read for humans (and not care too much
> about how easy this will be to parse).

If it's human-readable then why is it formatted in such a
machine-readable way?

A lot of software parses it[1]. Including lscpu. There=E2=80=99s lots of
information there that won=E2=80=99t appear in AT_HWCAP or similar as =
it=E2=80=99s not
generally relevant to userspace (processor speed, supervisor-level
extensions, physical hartid, ...).

Jess

[1] =
https://codesearch.debian.net/search?q=3D%22%2Fproc%2Fcpuinfo%22&literal=3D=
1&perpkg=3D1

> On Wed, 1 Dec 2021 at 11:21, Heiko St=C3=BCbner <heiko@sntech.de> =
wrote:
>>=20
>> Am Mittwoch, 1. Dezember 2021, 09:41:48 CET schrieb atish patra:
>>> On Wed, Dec 1, 2021 at 12:30 AM Heiko St=C3=BCbner <heiko@sntech.de> =
wrote:
>>>=20
>>>> Am Mittwoch, 1. Dezember 2021, 09:15:18 CET schrieb Atish Patra:
>>>>> On Tue, Nov 30, 2021 at 7:06 PM Tsukasa OI =
<research_trasio@irq.a4lg.com>
>>>> wrote:
>>>>>>=20
>>>>>> On 2021/12/01 10:21, Atish Patra wrote:
>>>>>>> On Tue, Nov 30, 2021 at 8:13 AM Jessica Clarke =
<jrtc27@jrtc27.com>
>>>> wrote:
>>>>>>>>=20
>>>>>>>> On 30 Nov 2021, at 15:01, Philipp Tomsich =
<philipp.tomsich@vrull.eu>
>>>> wrote:
>>>>>>>>>=20
>>>>>>>>> We did touch on this in our coordination call a few weeks ago: =
the
>>>>>>>>> grouping under mmu and the bool-entries were chosen because of
>>>> their
>>>>>>>>> similarity to other extensions (i.e. for Zb[abcs] there
>>>> could/should
>>>>>>>>> be a bool-entry under each cpu-node =E2=80=94 for some Zv* =
entries a
>>>> subnode
>>>>>>>>> might be needed with further parameters).
>>>>>>>>>=20
>>>>>>>>> The string-based approach (as in the originally proposed
>>>> "mmu-type=3D")
>>>>>>>>> would like not scale with the proliferation of small & modular
>>>>>>>>> extensions.
>>>>>>>>=20
>>>>>>>> I don=E2=80=99t see why the Sv* extensions need to be under an =
mmu node
>>>> then,
>>>>>>>> unless the intent is that every extension be grouped under a
>>>> sub-node
>>>>>>>> (which doesn=E2=80=99t seem viable due to extensions like Zbk*, =
unless you
>>>>>>>> group by Ss, Sv and Z)?
>>>>>>>>=20
>>>>>>>=20
>>>>>>> It shouldn't be. All the ISA extensions (i.e. standard, =
supervisor &
>>>> hypervisor)
>>>>>>> with prefix S,Z,H should be kept separate in a separate node for =
easy
>>>>>>> parsing.
>>>>>>=20
>>>>>> "Easy parsing" is not quite convincing.
>>>>>=20
>>>>> The device tree need to carry a very long "riscv,isa" string. The
>>>>> parser need to parse
>>>>> that string in memory as well.
>>>>>=20
>>>>>>=20
>>>>>> There's a reason other than that I made RFC PATCH to parse
>>>>>> multi-letter extensions:
>>>>>>=20
>>>>>> v1: <
>>>> =
http://lists.infradead.org/pipermail/linux-riscv/2021-November/010252.html=

>>>>>=20
>>>>>> v2: <
>>>> =
http://lists.infradead.org/pipermail/linux-riscv/2021-November/010350.html=

>>>>>=20
>>>>>>=20
>>>>>=20
>>>>> It's on my todo list to review the series. I think we can work
>>>>> together to propose a better framework for riscv isa extensions.
>>>>>=20
>>>>>> (note: those patches will break RISC-V KVM because of possible =
ISA
>>>>>>       Manual inconsistency and discussion/resolution needed)
>>>>>>=20
>>>>>> (...continued below...)
>>>>>>=20
>>>>>>>=20
>>>>>>> "riscv,isa" dt property will not scale at all. Just look at the =
few
>>>>>>> extensions that were ratified this year
>>>>>>> and Linux kernel needs to support them.
>>>>>>>=20
>>>>>>> "Sscofpmf", "Svpbmt", "Zicbom"
>>>>>>>=20
>>>>>>>> Also, what is going to happen to the current riscv,isa? Will =
that
>>>>>>>> continue to exist and duplicate the info, or will kernels be
>>>> required
>>>>>>>> to reconstruct the string themselves if they want to display it =
to
>>>>>>>> users?
>>>>>>>>=20
>>>>>=20
>>>>> Sorry. I missed this question earlier. See my answer below.
>>>>>=20
>>>>>>>=20
>>>>>>> This is my personal preference:
>>>>>>> riscv,isa will continue to base Standard ISA extensions that =
have
>>>>>>> single letter extensions.
>>>>>>>=20
>>>>>>> This new DT node will encode all the non-single letter =
extensions.
>>>>>>> I am not sure if it should include some provisions for custom
>>>>>>> extensions starting with X because
>>>>>>> that will be platform specific.
>>>>>>>=20
>>>>>>> Again, this is just my personal preference. I will try to send a
>>>> patch
>>>>>>> soon so that we can initiate a broader
>>>>>>> discussion of the scheme and agree/disagree on something.
>>>>>>=20
>>>>>> For supervisor-only extensions like "Svpbmt", new DT node would =
be a
>>>>>> reasonable solution (and I would not directly object about that =
node).
>>>>>>=20
>>>>>> However, there's many multi-letter extensions that are useful for
>>>>>> user mode.  Because "riscv,isa" is exposed via sysfs and procfs
>>>>>> (/proc/cpuinfo), it can be really helpful to have multi-letter
>>>>>=20
>>>>> Irrespective of the method chosen to parse the device tree in =
kernel,
>>>>> we need to provide the extension information to the userspace.
>>>>>=20
>>>>> This is what I have in mind. An individual row with comma =
separated
>>>>> extension names for each type of extensions (Ss, Sv, Sh)
>>>>> after the base extension (rv64imafdc) in /proc/cpuinfo output. I =
am
>>>>> open to other ideas as well.
>>>>>=20
>>>>> isa   rv64imafdc
>>>>> isa-ext-Sv Svpbmt
>>>>> isa-ext-Ss Sscofpmf
>>>>> isa-ext-Sh <hypervisor related extensions>
>>>>> isa-ext-Z   Zicbom
>>>>>=20
>>>>> We can even explicitly name the extensions after isa-ext. However, =
it
>>>>> may be necessary and too long.
>>>>=20
>>>> Aren't other architectures just using a flags [x86] or features =
[arm64]
>>>> line in cpuinfo to expose the available additional cpu features
>>>> as a space-separated list?
>>>>=20
>>>> So you could also just do something similar like
>>>> isa:   rv64imafdc
>>>> isa-ext: Svpbmt Sscofpmf foo bar
>>>>=20
>>>>=20
>>> A space separated list is also fine by me.
>>> Should we keep all the extensions as one row or split based on the =
type of
>>> extensions (Ss, Sv, Sh,)?
>>>=20
>>> When I look at the flags in x86, my eyes hurt badly ;)
>>=20
>> On arm64
>> Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
>>=20
>> or on arm32
>> Features        : half thumb fastmult vfp edsp thumbee neon vfpv3 tls =
vfpv4 idiva idivt vfpd32 lpae evtstrm
>>=20
>>=20
>>> That's why I suggested splitting by type of extensions to improve
>>> readability.
>>=20
>> Though I guess with that split you introduce more requirements on =
userspace?
>> Because things that parse cpuinfo (think some python library) will =
need to
>> be updated when some new extension category surfaces?
>>=20
>>=20
>>=20
>>>> That would make a nice compromise between length and readability
>>>> by users I guess?
>>>>=20
>>>>=20
>>>> Heiko
>>>>=20
>>>>> I guess you prefer to directly print the entire "riscv,isa" string =
in
>>>>> "isa" row in /proc/cpuinfo output.
>>>>> It is probably okay with the current number of extensions =
available
>>>>> today. However, it will become so long string
>>>>> in the future that it has to be broken into multiple lines.
>>>>>=20
>>>>>> extensions.  Also, current version of Spike, a RISC-V ISA =
Simulator
>>>>>> puts all multi-letter extensions in "riscv,isa" and I thought =
this is
>>>>>> intended.
>>>>>>=20
>>>>>> My preference:
>>>>>> (1) Allow having multi-letter extensions and versions in =
"riscv,isa"
>>>>>> (2) Adding new DT node for supervisor-related extensions would be
>>>>>>    reasonable (but I don't strongly agree/disagree).
>>>>>>=20
>>>>>> Thanks,
>>>>>> Tsukasa
>>>>>>=20
>>>>>>>=20
>>>>>>>=20
>>>>>>>=20
>>>>>>>> As a FreeBSD developer I=E2=80=99m obviously not a part of many =
of these
>>>>>>>> discussions, but what the Linux community imposes as the device =
tree
>>>>>>>> bindings has a real impact on us.
>>>>>>>>=20
>>>>>>>> Jess
>>>>>>>>=20
>>>>>>>>> On Tue, 30 Nov 2021 at 14:59, Jessica Clarke =
<jrtc27@jrtc27.com>
>>>> wrote:
>>>>>>>>>>=20
>>>>>>>>>> On 30 Nov 2021, at 13:27, Heiko St=C3=BCbner =
<heiko@sntech.de> wrote:
>>>>>>>>>>>=20
>>>>>>>>>>> Hi,
>>>>>>>>>>>=20
>>>>>>>>>>> Am Dienstag, 30. November 2021, 14:17:41 CET schrieb Jessica
>>>> Clarke:
>>>>>>>>>>>> On 30 Nov 2021, at 12:07, Heiko St=C3=BCbner =
<heiko@sntech.de>
>>>> wrote:
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> Am Montag, 29. November 2021, 13:06:23 CET schrieb Heiko
>>>> St=C3=BCbner:
>>>>>>>>>>>>>> Am Montag, 29. November 2021, 09:54:39 CET schrieb =
Heinrich
>>>> Schuchardt:
>>>>>>>>>>>>>>> On 11/29/21 02:40, wefu@redhat.com wrote:
>>>>>>>>>>>>>>>> From: Wei Fu <wefu@redhat.com>
>>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>> Previous patch has added svpbmt in arch/riscv and add
>>>> "riscv,svpmbt"
>>>>>>>>>>>>>>>> in the DT mmu node. Update dt-bindings related property
>>>> here.
>>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>> Signed-off-by: Wei Fu <wefu@redhat.com>
>>>>>>>>>>>>>>>> Co-developed-by: Guo Ren <guoren@kernel.org>
>>>>>>>>>>>>>>>> Signed-off-by: Guo Ren <guoren@kernel.org>
>>>>>>>>>>>>>>>> Cc: Anup Patel <anup@brainfault.org>
>>>>>>>>>>>>>>>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
>>>>>>>>>>>>>>>> Cc: Rob Herring <robh+dt@kernel.org>
>>>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>>> Documentation/devicetree/bindings/riscv/cpus.yaml | 10
>>>> ++++++++++
>>>>>>>>>>>>>>>> 1 file changed, 10 insertions(+)
>>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>> diff --git
>>>> a/Documentation/devicetree/bindings/riscv/cpus.yaml
>>>> b/Documentation/devicetree/bindings/riscv/cpus.yaml
>>>>>>>>>>>>>>>> index aa5fb64d57eb..9ff9cbdd8a85 100644
>>>>>>>>>>>>>>>> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
>>>>>>>>>>>>>>>> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
>>>>>>>>>>>>>>>> @@ -63,6 +63,16 @@ properties:
>>>>>>>>>>>>>>>>     - riscv,sv48
>>>>>>>>>>>>>>>>     - riscv,none
>>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>> +  mmu:
>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>> Shouldn't we keep the items be in alphabetic order, i.e. =
mmu
>>>> before
>>>>>>>>>>>>>>> mmu-type?
>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>> +    description:
>>>>>>>>>>>>>>>> +      Describes the CPU's MMU Standard Extensions =
support.
>>>>>>>>>>>>>>>> +      These values originate from the RISC-V =
Privileged
>>>>>>>>>>>>>>>> +      Specification document, available from
>>>>>>>>>>>>>>>> +      https://riscv.org/specifications/
>>>>>>>>>>>>>>>> +    $ref: '/schemas/types.yaml#/definitions/string'
>>>>>>>>>>>>>>>> +    enum:
>>>>>>>>>>>>>>>> +      - riscv,svpmbt
>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>> The privileged specification has multiple MMU related
>>>> extensions:
>>>>>>>>>>>>>>> Svnapot, Svpbmt, Svinval. Shall they all be modeled in =
this
>>>> enum?
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>> I remember in some earlier version some way back there =
was the
>>>>>>>>>>>>>> suggestion of using a sub-node instead and then adding =
boolean
>>>>>>>>>>>>>> properties for the supported extensions.
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>> Aka something like
>>>>>>>>>>>>>>  mmu {
>>>>>>>>>>>>>>          riscv,svpbmt;
>>>>>>>>>>>>>>  };
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> For the record, I'm talking about the mail from september
>>>>>>>>>>>>>=20
>>>> =
https://lore.kernel.org/linux-riscv/CAAeLtUChjjzG+P8yg45GLZMJy5UR2K5RRBoLF=
VZhtOaZ5pPtEA@mail.gmail.com/
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> So having a sub-node would make adding future extensions
>>>>>>>>>>>>> way nicer.
>>>>>>>>>>>>=20
>>>>>>>>>>>> Svpbmt is just an ISA extension, and should be treated like =
any
>>>> other.
>>>>>>>>>>>> Let=E2=80=99s not invent two different ways of representing =
that in the
>>>> device
>>>>>>>>>>>> tree.
>>>>>>>>>>>=20
>>>>>>>>>>> Heinrich asked how the other extensions should be handled
>>>>>>>>>>> (Svnapot, Svpbmt, Svinval), so what do you suggest to do =
with
>>>> these?
>>>>>>>>>>=20
>>>>>>>>>> Whatever is done for Zb[abcs], Zk*, Zv*, Zicbo*, etc. There =
may
>>>> not be
>>>>>>>>>> a concrete plan for that yet, but that means you should speak
>>>> with the
>>>>>>>>>> people involved with such extensions and come up with =
something
>>>>>>>>>> appropriate together.
>>>>>>>>>>=20
>>>>>>>>>> Jess
>>>>>>>>>>=20
>>>>>>>>=20
>>>>>>>>=20
>>>>>>>> _______________________________________________
>>>>>>>> linux-riscv mailing list
>>>>>>>> linux-riscv@lists.infradead.org
>>>>>>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>>>>>>>=20
>>>>>>>=20
>>>>>>>=20
>>>>>>> --
>>>>>>> Regards,
>>>>>>> Atish
>>>>>>>=20
>>>>>>> _______________________________________________
>>>>>>> linux-riscv mailing list
>>>>>>> linux-riscv@lists.infradead.org
>>>>>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>>>>>>>=20
>>>>>=20
>>>>>=20
>>>>>=20
>>>>>=20
>>>>=20
>>>>=20
>>>>=20
>>>>=20
>>>>=20
>>>=20
>>>=20
>>=20
>>=20
>>=20
>>=20

