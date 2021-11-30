Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C283463B61
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhK3QQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238282AbhK3QPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:15:54 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2943EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:12:35 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v11so45585303wrw.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zDaiQPffjNp4iybPUhurwpppB/YpQCmQGrvkn6Me5qw=;
        b=nkbZz82dt9scXK2A+g9RhTRBDyjIiR0FK5ycaMlRHqk8CiFRgdBzskWic2LZkpV+7/
         huzjaFigBUnP1mJ2QPU9Zh57PKiwB8+7JQMiX0G/vKnALPj8yJ55cWjzGMBi/vOCnFv2
         1aLVYG5DIF1bOt8wpT6QpxUObGB7Xz3T/S0tST0rKTFk32Q/HsEfeXjpTyrCf8yKLn/g
         pkmWU2LeR6kr/9q33TW0TKou1HdgaDVE/Mrw8O2zNkINud+CiflSeq42rANSEx4AK4/Y
         ZV1+uKDd6vo+ygwqiFt5SrR8JkuuzZhkN+4XbK9TGiFu+cC36uMuOqyXcpfkOvFXewla
         oBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zDaiQPffjNp4iybPUhurwpppB/YpQCmQGrvkn6Me5qw=;
        b=Ata1wkho5/i9osA62jveGZ2Vg+ajspGNiEwrlXtr2U355QQm0GgnrrrrdqiVRK3CVv
         59Qx49hnD+g7nSSjvNuNjrAEZbXd7MIZtnKCLhu3l4C7QyQj5vDWongOK2OFBpQicgHb
         HEvKM6+ueApTqggsqwI6Iarg4EsRybh0YGs9Nj9fkENPjS3prWsg6xrBh0fj9ggogOBP
         Ju0aYSrIC5zo3sfKIA9ObCt/KdAhHmurSRfz1bbH5nuo40S8wQhLyBmGufMw93tmZrHf
         Zibca61BdTUT97IutUdgdhD0EaH9MNSdrB6tn+CXBMDdNJKrGJb5Iz5Lyd9n+WYJnnBK
         vFHA==
X-Gm-Message-State: AOAM533h/oStmITWNNR+2Y3AsY0ID2vD04jGQaiA7PVLWoOulYLthNpK
        OG3o9iCm0+HV1mvoHycbbUyvyQ==
X-Google-Smtp-Source: ABdhPJzJn7/kISZJVRhH/QR4s3BI3SCVsBSjZFNoK0tsCcq4/alh1DfkIh+mV6TEnfaHX5AecNA3lg==
X-Received: by 2002:a5d:530e:: with SMTP id e14mr43009022wrv.12.1638288753779;
        Tue, 30 Nov 2021 08:12:33 -0800 (PST)
Received: from smtpclient.apple (global-5-141.nat-2.net.cam.ac.uk. [131.111.5.141])
        by smtp.gmail.com with ESMTPSA id h13sm17229706wrx.82.2021.11.30.08.12.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Nov 2021 08:12:33 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH V4 1/2] dt-bindings: riscv: add MMU Standard Extensions
 support for Svpbmt
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <CAAeLtUC0Qc6ysf31sh0dkvfJD-JsREZbyFFk=Ko0vQeBRzyjaw@mail.gmail.com>
Date:   Tue, 30 Nov 2021 16:12:27 +0000
Cc:     =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
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
        =?utf-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
        hch@lst.de, liush@allwinnertech.com, Wei Wu <lazyparser@gmail.com>,
        drew@beagleboard.org,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <03B8F784-4AF3-425D-99B6-F753F7970273@jrtc27.com>
References: <20211129014007.286478-1-wefu@redhat.com>
 <1909580.k68io2XIxi@diego> <D7F256F9-F31F-4663-AADD-A535E159F87C@jrtc27.com>
 <2728314.U2HhIfhhqV@diego> <C19C85E6-821B-4A87-B764-56CF4D53E7FA@jrtc27.com>
 <CAAeLtUC0Qc6ysf31sh0dkvfJD-JsREZbyFFk=Ko0vQeBRzyjaw@mail.gmail.com>
To:     Philipp Tomsich <philipp.tomsich@vrull.eu>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Nov 2021, at 15:01, Philipp Tomsich <philipp.tomsich@vrull.eu> =
wrote:
>=20
> We did touch on this in our coordination call a few weeks ago: the
> grouping under mmu and the bool-entries were chosen because of their
> similarity to other extensions (i.e. for Zb[abcs] there could/should
> be a bool-entry under each cpu-node =E2=80=94 for some Zv* entries a =
subnode
> might be needed with further parameters).
>=20
> The string-based approach (as in the originally proposed "mmu-type=3D")
> would like not scale with the proliferation of small & modular
> extensions.

I don=E2=80=99t see why the Sv* extensions need to be under an mmu node =
then,
unless the intent is that every extension be grouped under a sub-node
(which doesn=E2=80=99t seem viable due to extensions like Zbk*, unless =
you
group by Ss, Sv and Z)?

Also, what is going to happen to the current riscv,isa? Will that
continue to exist and duplicate the info, or will kernels be required
to reconstruct the string themselves if they want to display it to
users?

As a FreeBSD developer I=E2=80=99m obviously not a part of many of these
discussions, but what the Linux community imposes as the device tree
bindings has a real impact on us.

Jess

> On Tue, 30 Nov 2021 at 14:59, Jessica Clarke <jrtc27@jrtc27.com> =
wrote:
>>=20
>> On 30 Nov 2021, at 13:27, Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>>>=20
>>> Hi,
>>>=20
>>> Am Dienstag, 30. November 2021, 14:17:41 CET schrieb Jessica Clarke:
>>>> On 30 Nov 2021, at 12:07, Heiko St=C3=BCbner <heiko@sntech.de> =
wrote:
>>>>>=20
>>>>> Am Montag, 29. November 2021, 13:06:23 CET schrieb Heiko St=C3=BCbne=
r:
>>>>>> Am Montag, 29. November 2021, 09:54:39 CET schrieb Heinrich =
Schuchardt:
>>>>>>> On 11/29/21 02:40, wefu@redhat.com wrote:
>>>>>>>> From: Wei Fu <wefu@redhat.com>
>>>>>>>>=20
>>>>>>>> Previous patch has added svpbmt in arch/riscv and add =
"riscv,svpmbt"
>>>>>>>> in the DT mmu node. Update dt-bindings related property here.
>>>>>>>>=20
>>>>>>>> Signed-off-by: Wei Fu <wefu@redhat.com>
>>>>>>>> Co-developed-by: Guo Ren <guoren@kernel.org>
>>>>>>>> Signed-off-by: Guo Ren <guoren@kernel.org>
>>>>>>>> Cc: Anup Patel <anup@brainfault.org>
>>>>>>>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
>>>>>>>> Cc: Rob Herring <robh+dt@kernel.org>
>>>>>>>> ---
>>>>>>>> Documentation/devicetree/bindings/riscv/cpus.yaml | 10 =
++++++++++
>>>>>>>> 1 file changed, 10 insertions(+)
>>>>>>>>=20
>>>>>>>> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml =
b/Documentation/devicetree/bindings/riscv/cpus.yaml
>>>>>>>> index aa5fb64d57eb..9ff9cbdd8a85 100644
>>>>>>>> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
>>>>>>>> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
>>>>>>>> @@ -63,6 +63,16 @@ properties:
>>>>>>>>      - riscv,sv48
>>>>>>>>      - riscv,none
>>>>>>>>=20
>>>>>>>> +  mmu:
>>>>>>>=20
>>>>>>> Shouldn't we keep the items be in alphabetic order, i.e. mmu =
before
>>>>>>> mmu-type?
>>>>>>>=20
>>>>>>>> +    description:
>>>>>>>> +      Describes the CPU's MMU Standard Extensions support.
>>>>>>>> +      These values originate from the RISC-V Privileged
>>>>>>>> +      Specification document, available from
>>>>>>>> +      https://riscv.org/specifications/
>>>>>>>> +    $ref: '/schemas/types.yaml#/definitions/string'
>>>>>>>> +    enum:
>>>>>>>> +      - riscv,svpmbt
>>>>>>>=20
>>>>>>> The privileged specification has multiple MMU related =
extensions:
>>>>>>> Svnapot, Svpbmt, Svinval. Shall they all be modeled in this =
enum?
>>>>>>=20
>>>>>> I remember in some earlier version some way back there was the
>>>>>> suggestion of using a sub-node instead and then adding boolean
>>>>>> properties for the supported extensions.
>>>>>>=20
>>>>>> Aka something like
>>>>>>   mmu {
>>>>>>           riscv,svpbmt;
>>>>>>   };
>>>>>=20
>>>>> For the record, I'm talking about the mail from september
>>>>> =
https://lore.kernel.org/linux-riscv/CAAeLtUChjjzG+P8yg45GLZMJy5UR2K5RRBoLF=
VZhtOaZ5pPtEA@mail.gmail.com/
>>>>>=20
>>>>> So having a sub-node would make adding future extensions
>>>>> way nicer.
>>>>=20
>>>> Svpbmt is just an ISA extension, and should be treated like any =
other.
>>>> Let=E2=80=99s not invent two different ways of representing that in =
the device
>>>> tree.
>>>=20
>>> Heinrich asked how the other extensions should be handled
>>> (Svnapot, Svpbmt, Svinval), so what do you suggest to do with these?
>>=20
>> Whatever is done for Zb[abcs], Zk*, Zv*, Zicbo*, etc. There may not =
be
>> a concrete plan for that yet, but that means you should speak with =
the
>> people involved with such extensions and come up with something
>> appropriate together.
>>=20
>> Jess
>>=20

