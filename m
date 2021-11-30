Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6342246353D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 14:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239614AbhK3NVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 08:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239661AbhK3NVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 08:21:03 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAB0C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 05:17:44 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id u1so44314806wru.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 05:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VEsUwdxPY7Uj9kvn4cA/oDWG3LVG7CgUzhJ5udUVC/0=;
        b=JohDjlcVYhMurxBZlQ2EByjTX4OrXyZsMstLrb17g3YmRDC6ZdroIJEfnCEWD82YaK
         piHQOv6At3x+X54Dp43fIb5pSL40ADU6ouR6rKlG4c80Q99Ny58zHkM4VjSTYjg826ox
         P8Hp5Cn8fYkx8slDoOMccwuy2T5Bm1FzuiAIamo2F6rETxx4sKlqMLeRYAhacdEpksA8
         KpGPsfp+w5PiddKf0OQIRfsAzgjEdwa6VpVqPBNjdTgY/5w4zCioEwXKlVcGsLHDDjlJ
         0+s6JfPKb8OLpqvT/nCCfX7YkCz41WRK/B4fZF1L1G/dkwUs5LHzHZXiGK/GL8xqzWdQ
         RIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VEsUwdxPY7Uj9kvn4cA/oDWG3LVG7CgUzhJ5udUVC/0=;
        b=5UtuVBqj7So8TRyZHOciCJ5Lgd1uNg8MC1CH5Y/kKug765ToF9AdN+ldnEcq8So6yp
         bgUVy+V5FwHfHZd8gcZbHIR2UkGn/zj1xovUqvsI2Zc05uugj8kqfkEZBooRlqAWeaEC
         XAU7aT1c8zJNTXhk0xzqfh9XItcEh7Yopd7629mT3R/UOYw4rfRQXvHqSjtNZEHSmtCE
         1gXgkVF/KmYIGnV0Hwt6xqkKiwzatHf4IIvpEDbg4oY/k0HGpZSeMbF++3+t1/OID9cP
         dA+jwKxPvrsn1N4shxGFdf2BfFYyRIFdaPzzC6rFk8zPIAY1kWfCMQb19sfzcohrghpt
         xdWQ==
X-Gm-Message-State: AOAM533dMDF9PdJTViF30epbQqh4987l4i2M+bfY8sN9BzuI965/6CRL
        qjYtENmVIP2GRlxeHDqkZjliPA==
X-Google-Smtp-Source: ABdhPJyo9i5da+tky2D1vAoae1D7XArRcImXxlP40qx29nfDOYfYi3oVmlZKywKwzRrwz27OcOtQeQ==
X-Received: by 2002:a5d:64cd:: with SMTP id f13mr39488975wri.382.1638278263044;
        Tue, 30 Nov 2021 05:17:43 -0800 (PST)
Received: from smtpclient.apple (global-5-141.nat-2.net.cam.ac.uk. [131.111.5.141])
        by smtp.gmail.com with ESMTPSA id g5sm21775978wri.45.2021.11.30.05.17.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Nov 2021 05:17:42 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH V4 1/2] dt-bindings: riscv: add MMU Standard Extensions
 support for Svpbmt
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <1909580.k68io2XIxi@diego>
Date:   Tue, 30 Nov 2021 13:17:41 +0000
Cc:     Wei Fu <wefu@redhat.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
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
        Anup Patel <anup.patel@wdc.com>, atishp04@gmail.com,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Guo Ren <guoren@kernel.org>,
        =?utf-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>, hch@lst.de,
        liush@allwinnertech.com, Wei Wu <lazyparser@gmail.com>,
        drew@beagleboard.org,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D7F256F9-F31F-4663-AADD-A535E159F87C@jrtc27.com>
References: <20211129014007.286478-1-wefu@redhat.com>
 <97431cab-d67d-4bc7-e181-d64534791f03@canonical.com>
 <9930802.MB9u6SvQ6m@diego> <1909580.k68io2XIxi@diego>
To:     =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Nov 2021, at 12:07, Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>=20
> Am Montag, 29. November 2021, 13:06:23 CET schrieb Heiko St=C3=BCbner:
>> Am Montag, 29. November 2021, 09:54:39 CET schrieb Heinrich =
Schuchardt:
>>> On 11/29/21 02:40, wefu@redhat.com wrote:
>>>> From: Wei Fu <wefu@redhat.com>
>>>>=20
>>>> Previous patch has added svpbmt in arch/riscv and add =
"riscv,svpmbt"
>>>> in the DT mmu node. Update dt-bindings related property here.
>>>>=20
>>>> Signed-off-by: Wei Fu <wefu@redhat.com>
>>>> Co-developed-by: Guo Ren <guoren@kernel.org>
>>>> Signed-off-by: Guo Ren <guoren@kernel.org>
>>>> Cc: Anup Patel <anup@brainfault.org>
>>>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
>>>> Cc: Rob Herring <robh+dt@kernel.org>
>>>> ---
>>>>  Documentation/devicetree/bindings/riscv/cpus.yaml | 10 ++++++++++
>>>>  1 file changed, 10 insertions(+)
>>>>=20
>>>> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml =
b/Documentation/devicetree/bindings/riscv/cpus.yaml
>>>> index aa5fb64d57eb..9ff9cbdd8a85 100644
>>>> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
>>>> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
>>>> @@ -63,6 +63,16 @@ properties:
>>>>        - riscv,sv48
>>>>        - riscv,none
>>>>=20
>>>> +  mmu:
>>>=20
>>> Shouldn't we keep the items be in alphabetic order, i.e. mmu before=20=

>>> mmu-type?
>>>=20
>>>> +    description:
>>>> +      Describes the CPU's MMU Standard Extensions support.
>>>> +      These values originate from the RISC-V Privileged
>>>> +      Specification document, available from
>>>> +      https://riscv.org/specifications/
>>>> +    $ref: '/schemas/types.yaml#/definitions/string'
>>>> +    enum:
>>>> +      - riscv,svpmbt
>>>=20
>>> The privileged specification has multiple MMU related extensions:=20
>>> Svnapot, Svpbmt, Svinval. Shall they all be modeled in this enum?
>>=20
>> I remember in some earlier version some way back there was the
>> suggestion of using a sub-node instead and then adding boolean
>> properties for the supported extensions.
>>=20
>> Aka something like
>> 	mmu {
>> 		riscv,svpbmt;=09
>> 	};
>=20
> For the record, I'm talking about the mail from september
> =
https://lore.kernel.org/linux-riscv/CAAeLtUChjjzG+P8yg45GLZMJy5UR2K5RRBoLF=
VZhtOaZ5pPtEA@mail.gmail.com/
>=20
> So having a sub-node would make adding future extensions
> way nicer.

Svpbmt is just an ISA extension, and should be treated like any other.
Let=E2=80=99s not invent two different ways of representing that in the =
device
tree.

Jess

