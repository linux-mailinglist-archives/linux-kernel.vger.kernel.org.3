Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67673468A78
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 12:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbhLELVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 06:21:40 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:42399 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233086AbhLELVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 06:21:39 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id D8D9332003C0;
        Sun,  5 Dec 2021 06:18:11 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute5.internal (MEProxy); Sun, 05 Dec 2021 06:18:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm3; bh=LxSkG
        ZtzcYOwK3Wg6V5aRu/uic48z3swIacO01DWYDo=; b=aBeKyha+lkxob5OJASEys
        cEpWqNvuK+3g7sq6IqpS/KRSu/p6CLowc9uS+Siy0toIb8poVJHBH22912sEMcnS
        AZXWIJbFFjeNzTj3IeClaJHmPQ9yfoIBvcUyxL4YNH62VRJDfAcE5yQZOaf0NxQu
        lWxqIgf5eL2HxSPXtcwv7LVSNFCTybhJ7CXukzz2ErM1cjovlODSEAvgMTteeK0k
        Tc5f8U9TsVTC12PQGzJDSYYnA+3urtREtAPcTkVFgui4Wjdx/q55tKfLLAOJYmsF
        /zbBC213cPd9FRkjZQFUyo3yZfrnUYXfo9TYNDoI+KlcNvi80Zu2K2PBkewc6jZW
        g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=LxSkGZtzcYOwK3Wg6V5aRu/uic48z3swIacO01DWY
        Do=; b=df5+rN/dKLo8fStVLIn9h+eGF/mRGlMwsSpmJF8RH+xeeImg/avilHdXE
        J+I4wwOiGOAqWojdufyGNeEQUptyStBM9YL2GuWS5FI4eZy8MeHgVY48G8G6Tt0D
        JcA211LkQTBOJ/r5yqCWC/0sYOewCLoOjgFIPrUyTqBdwynhs8uTnaxLLoUr7Ffv
        ItB6Ysv5wt53WyEslPfjlUf1Mxeiug7ae9/Y/lvePrRkbe2wp9pCL564OA9joDCF
        TAviKvMGnDnSFVS48GKz0uT7f66bKaXZvpMPOVkSxEKywe0lxkvDXKliVztty2mC
        J1ukaCFsANmMaOFAYcOYILE/ug1JA==
X-ME-Sender: <xms:8p-sYac9eEU9k3ioKwOr9wo4gXFXjz6A3I3nEzMiPQ6Ix6A4bqcDDg>
    <xme:8p-sYUNmgIvMYR-acGO-kP12mRen4RtVTTlXIbkzrCLf8SSpHgdUz5r6geTGrNvVM
    Bwy8jUVbe4X-rfgxPc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrjedugddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdflihgr
    gihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpeelteduleffvdegvdfgvddvvdehfeehffethfdvgffhheev
    uefhteetteduheegfeenucffohhmrghinhepuhhvrgdrvghsnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhl
    hihgohgrthdrtghomh
X-ME-Proxy: <xmx:8p-sYbgUsBg9g3C7-X3IlPSw9-TsGD1eqhC0tY4Uuxfl1pvyLiLGoA>
    <xmx:8p-sYX-OGaQAxZlDVMc3QcSP9Cfo4NYMONs_Si6afGy990Vvjn2eiw>
    <xmx:8p-sYWuKP5Cv8MPTKC8fGDyY6V9Og6y3Pb84YjpET354UeH8m6Y4cQ>
    <xmx:85-sYf5Za0L3H04jRRIpuTREQBdFUdYFKBidvoSEmPXfmzSZ9vy7uw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id ADAC7FA0AA6; Sun,  5 Dec 2021 06:18:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4458-g51a91c06b2-fm-20211130.004-g51a91c06
Mime-Version: 1.0
Message-Id: <3c32dc38-2c19-4108-b111-59d45d974252@www.fastmail.com>
In-Reply-To: <168ff668.a3c5.17d88da8d21.Coremail.suijingfeng@loongson.cn>
References: <20211204120051.376260-1-suijingfeng@loongson.cn>
 <eae2a82b-2e81-4224-a551-90ec8d5882b0@www.fastmail.com>
 <168ff668.a3c5.17d88da8d21.Coremail.suijingfeng@loongson.cn>
Date:   Sun, 05 Dec 2021 11:17:49 +0000
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     suijingfeng <suijingfeng@loongson.cn>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Cc:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips/loongson64: using __fast_iob implement __wbflush() instead of
 sync
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actually I tried the same thing years a ago and it breaks some driver on=
 3A2000....

Write Buffer is not limited to UCA buffer but also some write gathering =
buffer like store fill buffer. On Loongson they're write back is tied to=
 memory barrier.


Thanks.

- Jiaxun

=E5=9C=A82021=E5=B9=B412=E6=9C=885=E6=97=A5=E5=8D=81=E4=BA=8C=E6=9C=88 =E4=
=B8=8A=E5=8D=884:29=EF=BC=8C=E9=9A=8B=E6=99=AF=E5=B3=B0=E5=86=99=E9=81=93=
=EF=BC=9A
> Hi Jiaxun,=20
>
> I'm not toward to  loongson cpu's barriers, but the semantic of wbflus=
h().=20
>
> And it is not necessary the safest way:=20
>
>
>
> before applying this patch,  wbflush() will be expanded to double __sy=
nc(),=20
>
> if __sync() can empty the uncached store buffer,  single one is enough=
.=20
>
> After apply this patch, wbflush() will be expanded to a __sync()=20
> followed by a  __fast_iob();=20
>
> this is more safe than your's version which blindly copy code from=20
> loongson2ef/common/setup.c.=20
>
> Note, Uncached Accelerated cache mode is only implemented after ls3a20=
00.=20
>
>
>
> Again, *wbflush is mean to empty data gathered in the uncache store=20
> buffers within the CPU*.=20
>
> __wbflush() is only mean to be used internally, wbflush() should be=20
> used outside of wbflush.h.=20
>
> by separate __wbflush out of setup.c, the code is more modularity. it=20
> allow you  to deselect=20
>
> CPU_HAS_WB easily and see what will happen.=20
>
>
>
> Actually nothing strange is happen, because  uncached accelerated cach=
e=20
> mode does not=20
>
> get used in upstream kernel.=20
>
>
>
> See Mips Run Say:=20
>
> Most write queues can be emptied out by performing an uncached store t=
o=20
>
> any location and then performing an operation that reads the same data=
 back.=20
>
> Put a sync instruction between the write and the read, and that should=20
> be effective=20
>
> on any system compliant with MIPS32/64.=20
>
> A write queue certainly can't permit the read to overtake the write, i=
t=20
> would return stale data.=20
>
> This is effective, but not necessarily ef=EF=AC=81cient; you can minim=
ize the overhead=20
>
> by loading from the fastest memory available. Perhaps your system offe=
rs=20
>
> something system speci=EF=AC=81c but faster.=20
>
>
>
> On 2021/12/4 =E4=B8=8B=E5=8D=888:32, Jiaxun Yang wrote:
>> Hi Jingfeng,
>> I'd suggest you not to mess with barriers on Loongson.
>> It's a hell.
>>=20
>> Also Loongson had changed semantics of sync/synci many times.
>> They got redefined and swapped. So the present way is just the safest=
 way.
>>=20
>> Thanks.
>>=20
>> - Jiaxun
>>=20
>> =E5=9C=A82021=E5=B9=B412=E6=9C=884=E6=97=A5=E5=8D=81=E4=BA=8C=E6=9C=88=
 =E4=B8=8B=E5=8D=8812:00=EF=BC=8Csuijingfeng=E5=86=99=E9=81=93=EF=BC=9A
>>> 1) loongson's cpu(ls3a3000, ls3a4000, ls3a5000) have uncache store b=
uffers
>>>     which is for uncache accleration.
>>>=20
>>>     Uncached Accelerated is the name under which the R10000 introduc=
ed
>>>     a cache mode that uses the CPU's write buffer to combine writes
>>>     but that otherwise is uncached.
>>>=20
>>>     wbflush is mean to empty data gathered in the uncache store buff=
ers
>>>     within the CPU.
>>>=20
>>>  2) The SYNC instruction in R10000
>>>=20
>>>     A SYNC instruction is not prevented from graduating if the uncac=
hed
>>>     buffer contains any uncached accelerated stores[1].
>>>=20
>>>  3) wbflush() implementation of IDT CPU.
>>>=20
>>>     IDT CPUs enforce strict write priority (all pending writes retir=
ed
>>>     to memory before main memory is read). Thus, implementing wbflus=
h()
>>>     is as simple as implementing an uncached load.
>>>=20
>>>     for loongson's cpu, __wbflush should also be implemented with
>>>     __fast_iob not sync.
>>>=20
>>> [1] https://www.ele.uva.es/~jesman/BigSeti/ftp/Microprocesadores/MIP=
S/t5.ver.2.0.book.pdf Signed-off-by: suijingfeng <suijingfeng@loongson.c=
n> ---
>>>  arch/mips/loongson64/Makefile  |  1 +
>>>  arch/mips/loongson64/setup.c   | 17 -----------------
>>>  arch/mips/loongson64/smp.c     |  6 +++---
>>>  arch/mips/loongson64/wbflush.c | 28 ++++++++++++++++++++++++++++
>>>  4 files changed, 32 insertions(+), 20 deletions(-)
>>>  create mode 100644 arch/mips/loongson64/wbflush.c
>>>=20
>>> diff --git a/arch/mips/loongson64/Makefile b/arch/mips/loongson64/Ma=
kefile
>>> index e806280bbb85..ad00d92c2871 100644
>>> --- a/arch/mips/loongson64/Makefile
>>> +++ b/arch/mips/loongson64/Makefile
>>> @@ -12,3 +12,4 @@ obj-$(CONFIG_SUSPEND) +=3D pm.o
>>>  obj-$(CONFIG_PCI_QUIRKS) +=3D vbios_quirk.o
>>>  obj-$(CONFIG_CPU_LOONGSON3_CPUCFG_EMULATION) +=3D cpucfg-emul.o
>>>  obj-$(CONFIG_SYSFS) +=3D boardinfo.o
>>> +obj-$(CONFIG_CPU_HAS_WB) +=3D wbflush.o
>>> diff --git a/arch/mips/loongson64/setup.c b/arch/mips/loongson64/set=
up.c
>>> index 6fe3ffffcaa6..cb10d14da433 100644
>>> --- a/arch/mips/loongson64/setup.c
>>> +++ b/arch/mips/loongson64/setup.c
>>> @@ -3,10 +3,7 @@
>>>   * Copyright (C) 2007 Lemote Inc. & Institute of Computing Technolo=
gy
>>>   * Author: Fuxin Zhang, zhangfx@lemote.com */
>>> -#include <linux/export.h>
>>>  #include <linux/init.h>
>>> -
>>> -#include <asm/wbflush.h>
>>>  #include <asm/bootinfo.h>
>>>  #include <linux/libfdt.h>
>>>  #include <linux/of_fdt.h>
>>> @@ -17,20 +14,6 @@
>>>=20
>>>  void *loongson_fdt_blob;
>>>=20
>>> -static void wbflush_loongson(void)
>>> -{
>>> -	asm(".set\tpush\n\t"
>>> -	    ".set\tnoreorder\n\t"
>>> -	    ".set mips3\n\t"
>>> -	    "sync\n\t"
>>> -	    "nop\n\t"
>>> -	    ".set\tpop\n\t"
>>> -	    ".set mips0\n\t");
>>> -}
>>> -
>>> -void (*__wbflush)(void) =3D wbflush_loongson;
>>> -EXPORT_SYMBOL(__wbflush);
>>> -
>>>  void __init plat_mem_setup(void)
>>>  {
>>>  	if (loongson_fdt_blob)
>>> diff --git a/arch/mips/loongson64/smp.c b/arch/mips/loongson64/smp.c
>>> index 660e1de4412a..0d9f249c95f9 100644
>>> --- a/arch/mips/loongson64/smp.c
>>> +++ b/arch/mips/loongson64/smp.c
>>> @@ -42,13 +42,13 @@ static uint32_t core0_c0count[NR_CPUS];
>>>  #define loongson3_ipi_write32(action, addr)	\
>>>  	do {					\
>>>  		writel(action, addr);		\
>>> -		__wbflush();			\
>>> +		wbflush();			\
>>>  	} while (0)
>>>  /* write a 64bit value to ipi register */
>>>  #define loongson3_ipi_write64(action, addr)	\
>>>  	do {					\
>>>  		writeq(action, addr);		\
>>> -		__wbflush();			\
>>> +		wbflush();			\
>>>  	} while (0)
>>>=20
>>>  static u32 (*ipi_read_clear)(int cpu);
>>> @@ -418,7 +418,7 @@ static irqreturn_t loongson3_ipi_interrupt(int i=
rq,=20
>>> void *dev_id)
>>>  		c0count =3D c0count ? c0count : 1;
>>>  		for (i =3D 1; i < nr_cpu_ids; i++)
>>>  			core0_c0count[i] =3D c0count;
>>> -		__wbflush(); /* Let others see the result ASAP */
>>> +		wbflush(); /* Let others see the result ASAP */
>>>  	}
>>>=20
>>>  	return IRQ_HANDLED;
>>> diff --git a/arch/mips/loongson64/wbflush.c b/arch/mips/loongson64/w=
bflush.c
>>> new file mode 100644
>>> index 000000000000..49f0e4c53196
>>> --- /dev/null
>>> +++ b/arch/mips/loongson64/wbflush.c
>>> @@ -0,0 +1,28 @@
>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>> +/*
>>> + * This file is subject to the terms and conditions of the GNU Gene=
ral Public
>>> + * License.  See the file "COPYING" in the main directory of this a=
rchive
>>> + * for more details.
>>> + *
>>> + * Copyright (C) 2021 suijingfeng@loongson.cn + */
>>> +#include <linux/export.h>
>>> +#include <linux/init.h>
>>> +#include <asm/wbflush.h>
>>> +#include <asm/barrier.h>
>>> +
>>> +#ifdef CONFIG_CPU_HAS_WB
>>> +
>>> +/*
>>> + * I/O ASIC systems use a standard writeback buffer that gets flush=
ed
>>> + * upon an uncached read.
>>> + */
>>> +static void wbflush_mips(void)
>>> +{
>>> +	__fast_iob();
>>> +}
>>> +
>>> +void (*__wbflush)(void) =3D wbflush_mips;
>>> +EXPORT_SYMBOL(__wbflush);
>>> +
>>> +#endif
>>> --=20
>>> 2.25.1
>
>
> *=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E5=90=
=AB=E6=9C=89=E9=BE=99=E8=8A=AF=E4=B8=AD=E7=A7=91=E7=9A=84=E5=95=86=E4=B8=
=9A=E7=A7=98=E5=AF=86=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=
=8E=E5=8F=91=E9=80=81=E7=BB=99=E4=B8=8A=E9=9D=A2=E5=9C=B0=E5=9D=80=E4=B8=
=AD=E5=88=97=E5=87=BA=E7=9A=84=E4=B8=AA=E4=BA=BA=E6=88=96=E7=BE=A4=E7=BB=
=84=E3=80=82=E7=A6=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E5=85=B6=E4=BB=96=E4=BA=
=BA=E4=BB=A5=E4=BB=BB=E4=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=EF=BC=
=88=E5=8C=85=E6=8B=AC=E4=BD=86=E4=B8=8D=E9=99=90=E4=BA=8E=E5=85=A8=E9=83=
=A8=E6=88=96=E9=83=A8=E5=88=86=E5=9C=B0=E6=B3=84=E9=9C=B2=E3=80=81=E5=A4=
=8D=E5=88=B6=E6=88=96=E6=95=A3=E5=8F=91=EF=BC=89=E6=9C=AC=E9=82=AE=E4=BB=
=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E4=B8=AD=E7=9A=84=E4=BF=A1=E6=81=
=AF=E3=80=82=E5=A6=82=E6=9E=9C=E6=82=A8=E9=94=99=E6=94=B6=E6=9C=AC=E9=82=
=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=E6=82=A8=E7=AB=8B=E5=8D=B3=E7=94=B5=E8=AF=
=9D=E6=88=96=E9=82=AE=E4=BB=B6=E9=80=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=
=BA=E5=B9=B6=E5=88=A0=E9=99=A4=E6=9C=AC=E9=82=AE=E4=BB=B6=E3=80=82=20
> This email and its attachments contain confidential information from=20
> Loongson Technology , which is intended only for the person or entity=20
> whose address is listed above. Any use of the information contained=20
> herein in any way (including, but not limited to, total or partial=20
> disclosure, reproduction or dissemination) by persons other than the=20
> intended recipient(s) is prohibited. If you receive this email in=20
> error, please notify the sender by phone or email immediately and=20
> delete it. *

--=20
- Jiaxun
