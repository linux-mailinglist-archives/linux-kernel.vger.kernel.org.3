Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20CB34635F6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241799AbhK3ODp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241947AbhK3ODM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:03:12 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43528C061748
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 05:59:50 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id i12so17542457wmq.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 05:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3PiemsL8KAtgrWTeLvozkXZ216ESpLbj4E8ZhqjaNhE=;
        b=LbW0nZLCksFIENy/o9R0UJZ0ZV7oM7zFE7R4jdfkiLJpQkYAB8cxAC1joNY6rUg7w0
         D2N6D1wNohepKAR1ehbxzwXMEc325fE0f40z3JnYvLBQkIxIbsIf+1Izhpe/q7mB+B0l
         iRTLL6sastrq2r51YApKRut1fog87kLW0aLT3WbJY9SpLzKEoO8zL14Tn47UvJRmNTH2
         cvrJt4s3cFgayCqLcGrE9+T4UkhBI/COe1wm/t+DLNaqzHHfeJEd6hu3fAMVbaxeHXbI
         34aNlz5tzcYjEUXS1Bx0fL3IhalGxGofxkG/CC47c/mwYlekft91NBg99m/sls1bEHUR
         srIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3PiemsL8KAtgrWTeLvozkXZ216ESpLbj4E8ZhqjaNhE=;
        b=N0Lsu3b4/5MVKbJIhJg1PyjNUNr6BZNHGwIC2pIm91lEQ9Zn1kTU5qWuqrGYiNg1Rc
         Gwb/RTk78XGgpv2ATZbqKp04pwb9f55kR0H641ZbB+rkjhflytcXSEbZp1zCw/6scsNS
         VOtKMsl5XynB0oWgv/ZZNjUJg38zh19telQI0RX2KhRa3Bf6nwzZPPtylX4HTHe9zINM
         bnMuk+mWg4gnT/eSmP0cQIOsRrAClx+w7bUT15iLIIBtObONMB13y4vDOjMzj5zsrPq4
         V1TA0U0gsAmVPk61rEgZrZvIpDErSJd+ZF2yQdsTNVgW69/3lzxvqlOjcn0idmlkdSnu
         ycsw==
X-Gm-Message-State: AOAM532mDKDw9wYp0K0HVROAgxbS3sgE4XwmKdrRQsLCeYNJJqXBOmpU
        WjDziz2BJ6TsCpI5gwPxrw1JJw==
X-Google-Smtp-Source: ABdhPJznhnEr+TbXJogEoD38Nn/h4WWYzXhJwrM0ZK+0x02bLXJWusEQhB0My5L3J5bQQe3n68n/6Q==
X-Received: by 2002:a7b:cbd8:: with SMTP id n24mr5145848wmi.150.1638280788820;
        Tue, 30 Nov 2021 05:59:48 -0800 (PST)
Received: from smtpclient.apple (global-5-141.nat-2.net.cam.ac.uk. [131.111.5.141])
        by smtp.gmail.com with ESMTPSA id e12sm21905976wrq.20.2021.11.30.05.59.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Nov 2021 05:59:48 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH V4 1/2] dt-bindings: riscv: add MMU Standard Extensions
 support for Svpbmt
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <2728314.U2HhIfhhqV@diego>
Date:   Tue, 30 Nov 2021 13:59:46 +0000
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
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
        Anup Patel <anup.patel@wdc.com>, atishp04@gmail.com,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Guo Ren <guoren@kernel.org>,
        =?utf-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>, hch@lst.de,
        liush@allwinnertech.com, Wei Wu <lazyparser@gmail.com>,
        drew@beagleboard.org,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C19C85E6-821B-4A87-B764-56CF4D53E7FA@jrtc27.com>
References: <20211129014007.286478-1-wefu@redhat.com>
 <1909580.k68io2XIxi@diego> <D7F256F9-F31F-4663-AADD-A535E159F87C@jrtc27.com>
 <2728314.U2HhIfhhqV@diego>
To:     =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Nov 2021, at 13:27, Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>=20
> Hi,
>=20
> Am Dienstag, 30. November 2021, 14:17:41 CET schrieb Jessica Clarke:
>> On 30 Nov 2021, at 12:07, Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>>>=20
>>> Am Montag, 29. November 2021, 13:06:23 CET schrieb Heiko St=C3=BCbner:=

>>>> Am Montag, 29. November 2021, 09:54:39 CET schrieb Heinrich =
Schuchardt:
>>>>> On 11/29/21 02:40, wefu@redhat.com wrote:
>>>>>> From: Wei Fu <wefu@redhat.com>
>>>>>>=20
>>>>>> Previous patch has added svpbmt in arch/riscv and add =
"riscv,svpmbt"
>>>>>> in the DT mmu node. Update dt-bindings related property here.
>>>>>>=20
>>>>>> Signed-off-by: Wei Fu <wefu@redhat.com>
>>>>>> Co-developed-by: Guo Ren <guoren@kernel.org>
>>>>>> Signed-off-by: Guo Ren <guoren@kernel.org>
>>>>>> Cc: Anup Patel <anup@brainfault.org>
>>>>>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
>>>>>> Cc: Rob Herring <robh+dt@kernel.org>
>>>>>> ---
>>>>>> Documentation/devicetree/bindings/riscv/cpus.yaml | 10 ++++++++++
>>>>>> 1 file changed, 10 insertions(+)
>>>>>>=20
>>>>>> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml =
b/Documentation/devicetree/bindings/riscv/cpus.yaml
>>>>>> index aa5fb64d57eb..9ff9cbdd8a85 100644
>>>>>> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
>>>>>> @@ -63,6 +63,16 @@ properties:
>>>>>>       - riscv,sv48
>>>>>>       - riscv,none
>>>>>>=20
>>>>>> +  mmu:
>>>>>=20
>>>>> Shouldn't we keep the items be in alphabetic order, i.e. mmu =
before=20
>>>>> mmu-type?
>>>>>=20
>>>>>> +    description:
>>>>>> +      Describes the CPU's MMU Standard Extensions support.
>>>>>> +      These values originate from the RISC-V Privileged
>>>>>> +      Specification document, available from
>>>>>> +      https://riscv.org/specifications/
>>>>>> +    $ref: '/schemas/types.yaml#/definitions/string'
>>>>>> +    enum:
>>>>>> +      - riscv,svpmbt
>>>>>=20
>>>>> The privileged specification has multiple MMU related extensions:=20=

>>>>> Svnapot, Svpbmt, Svinval. Shall they all be modeled in this enum?
>>>>=20
>>>> I remember in some earlier version some way back there was the
>>>> suggestion of using a sub-node instead and then adding boolean
>>>> properties for the supported extensions.
>>>>=20
>>>> Aka something like
>>>> 	mmu {
>>>> 		riscv,svpbmt;=09
>>>> 	};
>>>=20
>>> For the record, I'm talking about the mail from september
>>> =
https://lore.kernel.org/linux-riscv/CAAeLtUChjjzG+P8yg45GLZMJy5UR2K5RRBoLF=
VZhtOaZ5pPtEA@mail.gmail.com/
>>>=20
>>> So having a sub-node would make adding future extensions
>>> way nicer.
>>=20
>> Svpbmt is just an ISA extension, and should be treated like any =
other.
>> Let=E2=80=99s not invent two different ways of representing that in =
the device
>> tree.
>=20
> Heinrich asked how the other extensions should be handled
> (Svnapot, Svpbmt, Svinval), so what do you suggest to do with these?

Whatever is done for Zb[abcs], Zk*, Zv*, Zicbo*, etc. There may not be
a concrete plan for that yet, but that means you should speak with the
people involved with such extensions and come up with something
appropriate together.

Jess

