Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1277463572
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 14:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240342AbhK3NbU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 30 Nov 2021 08:31:20 -0500
Received: from gloria.sntech.de ([185.11.138.130]:48242 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233573AbhK3NbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 08:31:19 -0500
Received: from ip5f5b2004.dynamic.kabel-deutschland.de ([95.91.32.4] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1ms3Ak-00058Q-BT; Tue, 30 Nov 2021 14:27:50 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     linux-riscv@lists.infradead.org, Jessica Clarke <jrtc27@jrtc27.com>
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
        Christoph =?ISO-8859-1?Q?M=FCllner?= 
        <christoph.muellner@vrull.eu>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>, hch@lst.de,
        liush@allwinnertech.com, Wei Wu <lazyparser@gmail.com>,
        drew@beagleboard.org,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH V4 1/2] dt-bindings: riscv: add MMU Standard Extensions support for Svpbmt
Date:   Tue, 30 Nov 2021 14:27:48 +0100
Message-ID: <2728314.U2HhIfhhqV@diego>
In-Reply-To: <D7F256F9-F31F-4663-AADD-A535E159F87C@jrtc27.com>
References: <20211129014007.286478-1-wefu@redhat.com> <1909580.k68io2XIxi@diego> <D7F256F9-F31F-4663-AADD-A535E159F87C@jrtc27.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Dienstag, 30. November 2021, 14:17:41 CET schrieb Jessica Clarke:
> On 30 Nov 2021, at 12:07, Heiko Stübner <heiko@sntech.de> wrote:
> > 
> > Am Montag, 29. November 2021, 13:06:23 CET schrieb Heiko Stübner:
> >> Am Montag, 29. November 2021, 09:54:39 CET schrieb Heinrich Schuchardt:
> >>> On 11/29/21 02:40, wefu@redhat.com wrote:
> >>>> From: Wei Fu <wefu@redhat.com>
> >>>> 
> >>>> Previous patch has added svpbmt in arch/riscv and add "riscv,svpmbt"
> >>>> in the DT mmu node. Update dt-bindings related property here.
> >>>> 
> >>>> Signed-off-by: Wei Fu <wefu@redhat.com>
> >>>> Co-developed-by: Guo Ren <guoren@kernel.org>
> >>>> Signed-off-by: Guo Ren <guoren@kernel.org>
> >>>> Cc: Anup Patel <anup@brainfault.org>
> >>>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> >>>> Cc: Rob Herring <robh+dt@kernel.org>
> >>>> ---
> >>>>  Documentation/devicetree/bindings/riscv/cpus.yaml | 10 ++++++++++
> >>>>  1 file changed, 10 insertions(+)
> >>>> 
> >>>> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> >>>> index aa5fb64d57eb..9ff9cbdd8a85 100644
> >>>> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> >>>> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> >>>> @@ -63,6 +63,16 @@ properties:
> >>>>        - riscv,sv48
> >>>>        - riscv,none
> >>>> 
> >>>> +  mmu:
> >>> 
> >>> Shouldn't we keep the items be in alphabetic order, i.e. mmu before 
> >>> mmu-type?
> >>> 
> >>>> +    description:
> >>>> +      Describes the CPU's MMU Standard Extensions support.
> >>>> +      These values originate from the RISC-V Privileged
> >>>> +      Specification document, available from
> >>>> +      https://riscv.org/specifications/
> >>>> +    $ref: '/schemas/types.yaml#/definitions/string'
> >>>> +    enum:
> >>>> +      - riscv,svpmbt
> >>> 
> >>> The privileged specification has multiple MMU related extensions: 
> >>> Svnapot, Svpbmt, Svinval. Shall they all be modeled in this enum?
> >> 
> >> I remember in some earlier version some way back there was the
> >> suggestion of using a sub-node instead and then adding boolean
> >> properties for the supported extensions.
> >> 
> >> Aka something like
> >> 	mmu {
> >> 		riscv,svpbmt;	
> >> 	};
> > 
> > For the record, I'm talking about the mail from september
> > https://lore.kernel.org/linux-riscv/CAAeLtUChjjzG+P8yg45GLZMJy5UR2K5RRBoLFVZhtOaZ5pPtEA@mail.gmail.com/
> > 
> > So having a sub-node would make adding future extensions
> > way nicer.
> 
> Svpbmt is just an ISA extension, and should be treated like any other.
> Let’s not invent two different ways of representing that in the device
> tree.

Heinrich asked how the other extensions should be handled
(Svnapot, Svpbmt, Svinval), so what do you suggest to do with these?


Thanks
Heiko


