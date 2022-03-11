Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1C94D61CB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 13:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348671AbiCKMxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 07:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348670AbiCKMxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 07:53:13 -0500
X-Greylist: delayed 559 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Mar 2022 04:52:06 PST
Received: from mailgate.ics.forth.gr (mailgate.ics.forth.gr [139.91.1.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E1E1B754A
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 04:52:06 -0800 (PST)
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 22BCggxc038479
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 14:42:42 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1647002557; x=1649594557;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=u5iax0bPoVIojUOUZZR2XGY8KQMpedcYRWJVPYiMZH0=;
        b=uzkTrBmEE/WI0x55scdRW3+aWDx5mzDbfAy7rwqZGbqPK9gj0A9Ha6aIroxSbkhH
        AEch1W0IKw7mz2COPXBV0GoguEiDWcwWcWchlt5v5DsHEtp/vuptGA0VWTD2cRKB
        /R754oPKU2+q6v+qTjeRrMaujUx2HW4vlpF6iWNVaNKuGmDP2+kefdvPwIP7FTMH
        oIa00rxLPuqbVxwVV5jcaR0AQfxsJiHC/9vM6Nmsu04NODv7MRjz4AaifV8kv0vO
        PeREWnBBh+g2BrunDGcGsyBPnr/mriw6imV/iZSBiORmuq1lRNqcZ2RYIM3fqBU3
        AtL4YeJYeB7eAEhcAZwD2w==;
X-AuditID: 8b5b014d-feeaa700000035db-85-622b43bd8380
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 50.27.13787.DB34B226; Fri, 11 Mar 2022 14:42:37 +0200 (EET)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 11 Mar 2022 14:42:35 +0200
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Atish Kumar Patra <atishp@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree <devicetree@vger.kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>
Subject: Re: [PATCH v5 0/6] Provide a fraemework for RISC-V ISA extensions
Organization: FORTH
In-Reply-To: <CAHBxVyHaFk6mx_uTUcOG1d+XGokT_-Y3_Y1kVJixAnGGmLjAxg@mail.gmail.com>
References: <20220222204811.2281949-1-atishp@rivosinc.com>
 <mhng-4593ea1e-503d-47df-8e55-d2ef06f01518@palmer-ri-x1c9>
 <CAHBxVyHaFk6mx_uTUcOG1d+XGokT_-Y3_Y1kVJixAnGGmLjAxg@mail.gmail.com>
Message-ID: <d8d4fedad13ef063b672aadfe2ee0aff@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.16
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsXSHT1dWXevs3aSweJnvBYtH96xWmz9PYvd
        ouOcm8Xm/1+YLVrbvzFZzD9yjtWi+dh6NouNb38wWVzeNYfNYtvnFjaLl5d7mC3aZvFbdK+s
        tmjde4Tdgc/jWsdGFo+pv8+weMxq6GXzePPyJYvH4Y4v7B6bVnWyeWxeUu9xY1aEx6Xm6+we
        nzfJeey8/ZDJo/1AN1MATxSXTUpqTmZZapG+XQJXxrKzf9gKJohVXO+vaGCcK9jFyMkhIWAi
        8fjeRLYuRi4OIYEjjBJPXs1jh0iYSsze28kIYvMKCEqcnPmEBcRmFrCQmHplPyOELS/RvHU2
        M4jNIqAq0X3lIFgNm4CmxPxLIDYHh4iAtsStLdwg85kFprNK/GyaADZfWMBL4uGjE2D1/ALC
        Ep/uXmQFsTkFAiX2ty9mhDhoH6PEicurWCCOcJG4c7SJGeI4FYkPvx+wgywQBbI3z1WawCg4
        C8mps5CcOgvJqQsYmVcxCiSWGetlJhfrpeUXlWTopRdtYgTHHKPvDsbbm9/qHWJk4mA8xCjB
        wawkwtsUqpEkxJuSWFmVWpQfX1Sak1p8iFGag0VJnJflmkySkEB6YklqdmpqQWoRTJaJg1Oq
        gYnT5oEef13SjHUh7SZPF4q93Wx18K7k7Jufev6HGQfxRFyoFJw25fKpngUp33c5HHHlq3Z6
        /szXTcBn+uTZOfM/ls5ceizu6ETtw9Vuj4/Yu/X8Evjh3nP2Qc3Tct9F97QcNV9xB1gf8Uhs
        itpruliB+9wT1d7KbKbtkur/TG5mtQvblbw+HNncWSU/16Rb6uMSnojFS5p81R8mCnR49Rkc
        inFIent2+qc/lRuZGbL/ty+vlOaZNNE58zO7ztqLfx0nvmUOmnrPwUCv68PJyujP3fdXbhPr
        P/vw6uKM+/wT/bzzHtrd89RIF2LP1Dv84Gfr71PH3h7ZZPNlvgnv/qsKkpEMXHpv09/1f57e
        mqrEUpyRaKjFXFScCAAB0LWVKAMAAA==
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Στις 2022-03-11 02:21, Atish Kumar Patra έγραψε:
> On Thu, Mar 10, 2022 at 3:50 PM Palmer Dabbelt <palmer@dabbelt.com> 
> wrote:
>> 
>> On Tue, 22 Feb 2022 12:48:05 PST (-0800), Atish Patra wrote:
>> > This series implements a generic framework to parse multi-letter ISA
>> > extensions. This series is based on Tsukasa's v3 isa extension improvement
>> > series[1]. I have fixed few bugs and improved comments from that series
>> > (PATCH1-3). I have not used PATCH 4 from that series as we are not using
>> > ISA extension versioning as of now. We can add that later if required.
>> >
>> > PATCH 4 allows the probing of multi-letter extensions via a macro.
>> > It continues to use the common isa extensions between all the harts.
>> > Thus hetergenous hart systems will only see the common ISA extensions.
>> >
>> > PATCH 6 improves the /proc/cpuinfo interface for the available ISA extensions
>> > via /proc/cpuinfo.
>> >
>> > Here is the example output of /proc/cpuinfo:
>> > (with debug patches in Qemu and Linux kernel)
>> >
>> > # cat /proc/cpuinfo
>> > processor     : 0
>> > hart          : 0
>> > isa           : rv64imafdch
>> > isa-ext               : svpbmt svnapot svinval
>> 
>> I know it might seem a bit pedantic, but I really don't want to
>> introduce a new format for encoding ISA extensions -- doubly so if 
>> this
>> is the only way we're giving this info to userspace, as then we're 
>> just
>> asking folks to turn this into a defacto ABI.  Every time we try to do
>> something that's sort of like an ISA string but not exactly what's in
>> the spec we end up getting burned, and while I don't see a specific 
>> way
> 
> I agree that this is an ABI change/improvement which is impossible to
> modify later.
> However, this is a Linux specific ABI. Do you think the RISC-V spec
> will ever say anything about how /proc/cpuinfo is shown to the user ?
> 

Actually there was a discussion on chairs at some point on how isa 
extensions will be represented as a single string. If I recall correctly 
they wanted a way to compare features between implementations so this 
was something the user should be able to read as well. I'm ccing Philipp 
from the Software HC in case he has more details on this.

I also believe we need to discuss this a bit further, also I thought we 
agreed that having everything as a single string (riscv-isa) on the 
device tree doesn't scale, there were some other suggestions regarding 
for example mmu extensions being declared inside an mmu sub-node etc. 
This patch series will not only make it hard to change /proc/cpuinfo 
output in the future, but also establishes a device-tree binding for all 
isa extensions through the riscv-isa string that we also won't be able 
to modify later on.

Regards,
Nick
