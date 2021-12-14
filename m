Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA4D473C5A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 06:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbhLNFNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 00:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhLNFNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 00:13:24 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201A3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 21:13:24 -0800 (PST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 695E7806A8;
        Tue, 14 Dec 2021 18:13:20 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1639458800;
        bh=vbX9H6qcRAeyTb7SB1geAGjdP7mvlxamF8YKfjN/jEI=;
        h=From:To:CC:Subject:Date;
        b=OYzHaGBJmN8BTFCzr6aUzhO8DR8AfiiXfov3iGhwkYwaK0pXHNKtlIpT7U4uDeAJg
         OHWeyRiJvxbjXGPaJWe5LTl/XlmbucfpCP5rO1NClmQJwoB3Br3yY2pErlb6YJVjjX
         m6q5TJuqiLsAxLa1xrm1Fa6EAyDwQuJLimW1DhQRrnl2laRQjg/W515jwJOGUE2U8k
         RcLzwdtVPiSu8jo7K+mpxqpRpABTTxBEhgekn2NLQFqG2Hi/g9ru5K5b5NniIB6R2n
         /PJyTvZ0Eawlm54gBRunrfALJ+eSym05OSwjqjXS9gAtPHjtAsd15x0FpHupm2iApZ
         pzNtYOkpRvqWg==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B61b827f00001>; Tue, 14 Dec 2021 18:13:20 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 14 Dec 2021 18:13:20 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.026; Tue, 14 Dec 2021 18:13:20 +1300
From:   Joshua Scott <Joshua.Scott@alliedtelesis.co.nz>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chris Packham" <Chris.Packham@alliedtelesis.co.nz>
Subject: Unhandled prefetch abort when probing USB flash drive
Thread-Topic: Unhandled prefetch abort when probing USB flash drive
Thread-Index: AQHX8KlPHO/extcMAEO/W4+JL70d6g==
Date:   Tue, 14 Dec 2021 05:13:20 +0000
Message-ID: <d23175b8312e4b4093943b38c2ed59d2@svr-chch-ex1.atlnz.lc>
Accept-Language: en-NZ, en-US
Content-Language: en-NZ
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=XOZOtjpE c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=8nJEP1OIZ-IA:10 a=IOMw9HtfNCkA:10 a=PVGfr0r-XiAdaMvWY7QA:9 a=wPNLvfGTeEIA:10
X-SEG-SpamProfiler-Score: 0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=0A=
=0A=
I have been running into a kernel panic when probing a USB flash drive, and=
 was after some advice or suggestions on what might be going wrong.=0A=
=0A=
First up, the details of my setup:=0A=
 * Initially seen on Linux 5.7.19, but I've tested on a vanilla copy of Lin=
ux 5.15.0 without any extra modules, and the panic still occurs.=0A=
 * Flash drive (lsusb): Bus 001 Device 002: ID 1005:b113 Apacer Technology,=
 Inc. Handy Steno 2.0/HT203=0A=
 * Our system is based on the Marvell 98DX323x SoC (Arm v7, based on the Ar=
mada 370/XP)=0A=
=0A=
The panic occurs after sd_probe() gets called, with the USB flash drive att=
ached. This occurs around 1 time out of 100. We first saw this during a reb=
oot, but it can be reproduced much faster by loading and unloading the sd_m=
od module in a loop, to exercise the probe function.=0A=
=0A=
When adding some diagnostic print statements, I found that adding a delay i=
nto sd_probe(), just after the call to device_add_disk(), seems to prevent =
the issue.=0A=
=0A=
The actual headline of the panic is not always the same, we have seen:=0A=
* Unhandled fault: external abort on non-linefetch (0x808) at 0x9fbfa73c=0A=
* Unhandled fault: imprecise external abort (0x1416) at 0x76f5e508=0A=
* Unhandled prefetch abort: external abort on non-linefetch (0x1008) at 0x8=
03c8a88=0A=
=0A=
Included below is an example of the panic output.=0A=
=0A=
Thank you,=0A=
Joshua Scott=0A=
=0A=
Unhandled prefetch abort: external abort on non-linefetch (0x1008) at 0x801=
8fe20=0A=
Internal error: : 1008 [#1] PREEMPT SMP ARM=0A=
Modules linked in: sd_mod(+) diag tipc platform_driver(O) ipifwd(PO) usb_st=
orage scsi_mod [last unloaded: sd_mod]=0A=
CPU: 0 PID: 178 Comm: udevd Tainted: P           O      5.7.19-at1 #39=0A=
Hardware name: Marvell Armada 370/XP (Device Tree)=0A=
PC is at sys_clock_gettime32+0x58/0xc4=0A=
LR is at ret_fast_syscall+0x0/0x54=0A=
pc : [<8018fe20>]    lr : [<80100060>]    psr: a00e0013=0A=
sp : 9dfcdf80  ip : 10c5387d  fp : 00041150=0A=
r10: 00000107  r9 : 9dfcc000  r8 : 80100288=0A=
r7 : 00000107  r6 : 00000000  r5 : 7eddb208  r4 : 80c052c8=0A=
r3 : 8018ea90  r2 : 00000001  r1 : 7eddb208  r0 : 00000001=0A=
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none=0A=
Control: 10c5387d  Table: 1dfc006a  DAC: 00000051=0A=
Process udevd (pid: 178, stack limit =3D 0xfbd1de7a)=0A=
Stack: (0x9dfcdf80 to 0x9dfce000)=0A=
df80: 00000000 00000000 00000000 ed40bc3c 000000fc ed40bc3c 00000008 000000=
01=0A=
dfa0: 7eddb208 80100060 00000001 7eddb208 00000001 7eddb208 eec19c0e eec19c=
0e=0A=
dfc0: 00000001 7eddb208 00000000 00000107 000402c4 00040308 7eddbcd0 000411=
50=0A=
dfe0: 76f38060 7eddb1f0 0002505c 76ed9bc4 600e0010 00000001 00000000 000000=
00=0A=
[<8018fe20>] (sys_clock_gettime32) from [<80100060>] (ret_fast_syscall+0x0/=
0x54)=0A=
Exception stack(0x9dfcdfa8 to 0x9dfcdff0)=0A=
dfa0:                   00000001 7eddb208 00000001 7eddb208 eec19c0e eec19c=
0e=0A=
dfc0: 00000001 7eddb208 00000000 00000107 000402c4 00040308 7eddbcd0 000411=
50=0A=
dfe0: 76f38060 7eddb1f0 0002505c 76ed9bc4=0A=
Code: e5933080 e3530000 0a000018 e5933008 (e1a0100d) =0A=
---[ end trace 98c4e7c1cd29d9e3 ]---=0A=
