Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C30F04684CF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 13:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384925AbhLDMgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 07:36:24 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:37943 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231411AbhLDMgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 07:36:23 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 23B265C01EE;
        Sat,  4 Dec 2021 07:32:58 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute5.internal (MEProxy); Sat, 04 Dec 2021 07:32:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm3; bh=hiNKL
        4p6XKuZrdo4YFeg8QJJ0FNXQzuQbyf/sTUo6Ak=; b=GtWfxUWDUVcc4c9xtk0HT
        DQfGWa78u7bv5+61zcJnfxVv8aepl2EhAVZM9MwDCZf60++uHAAcSwDTOwY8O5wq
        PKPnRhbrLSsAGioxUtDjiqKcQeHO716SzPt2RpEXssCWQHJBuyyGRUwgpSyN9lsh
        Um+/lamVZ9x2HdkaVboycsmB5eiEGfYcMTDtf3w5weaXIXRzTohsSFYge9Kexh2e
        RWazvPSavq26gejt6R0zgyeA+qJtZqmOVAx3o3H1EWc5b9iTNOvRR0H2eJLg57vK
        eAJrTAlQZcoJjozSaXdqPy7PFaGkuUX0m+I5rwLCmt0yauMXKvUmf6QzeNDBm53U
        A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=hiNKL4p6XKuZrdo4YFeg8QJJ0FNXQzuQbyf/sTUo6
        Ak=; b=kJRK8pcJxa7FfaqSM1jDHpBy+2Arv+ytxPYirzxqkW9A1nF8DjqcBLqZ9
        PWmGM9hTnc6KhV6cNKKmQrgVYKNGBZKCZYvDjyRQka5liRGoxHTIDiAdSdJX24j3
        +kKe06kCvwCsM9CmDUn2fKDxc/esgYCH59mGD286oIPw95otAxB0z7uLsGlUskE2
        0zdS3MXN6G7CQnsIJMFdeAC9lIFLk3qLOfdRU1sc+1/HoymavNtZklWtkvCgLLJw
        DMTxxLjNCh7l1MgB8KQvEgGeF87PW9aoejug/Ll9TZBFVArHO60ov5Ro0ICAP8pb
        4c124bKF27kQ3/lY6HIhHz/qplMDA==
X-ME-Sender: <xms:-V-rYYfCt6_rxIkF54BzI9HLqbaQAhVaHNuElCNsnaReFlp9ajYCtA>
    <xme:-V-rYaM5bZjRSXhgAZjIhseyBXBZtgqOPMWeI_cgXaKex61aWgQICf_d9Nc_dJyOb
    8fUvC_5fL4-wle5JJE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieelgdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdflihgr
    gihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpeelteduleffvdegvdfgvddvvdehfeehffethfdvgffhheev
    uefhteetteduheegfeenucffohhmrghinhepuhhvrgdrvghsnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhl
    hihgohgrthdrtghomh
X-ME-Proxy: <xmx:-V-rYZhU7ns0uD6LC1m_YXKJd21897DXQwLv7jLsgiVqQ4mNWCR-GA>
    <xmx:-V-rYd8AfvVZfFdZJWODBXeZpMZj_opjDp2ltsXFlpU1eyFGi6KwjQ>
    <xmx:-V-rYUt9RicAWvafQRDcV8WcIHW_Bv0ZqRPFLNbzZY7btuGyq5GU6Q>
    <xmx:-l-rYd7IiUVJQxb3d2geuseE9JfjElpwC9jdMpozvH4FZkPWVPpbtA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4BBB3FA0AA6; Sat,  4 Dec 2021 07:32:57 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4458-g51a91c06b2-fm-20211130.004-g51a91c06
Mime-Version: 1.0
Message-Id: <eae2a82b-2e81-4224-a551-90ec8d5882b0@www.fastmail.com>
In-Reply-To: <20211204120051.376260-1-suijingfeng@loongson.cn>
References: <20211204120051.376260-1-suijingfeng@loongson.cn>
Date:   Sat, 04 Dec 2021 12:32:37 +0000
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

Hi Jingfeng,
I'd suggest you not to mess with barriers on Loongson.
It's a hell.

Also Loongson had changed semantics of sync/synci many times.
They got redefined and swapped. So the present way is just the safest wa=
y.

Thanks.

- Jiaxun

=E5=9C=A82021=E5=B9=B412=E6=9C=884=E6=97=A5=E5=8D=81=E4=BA=8C=E6=9C=88 =E4=
=B8=8B=E5=8D=8812:00=EF=BC=8Csuijingfeng=E5=86=99=E9=81=93=EF=BC=9A
> 1) loongson's cpu(ls3a3000, ls3a4000, ls3a5000) have uncache store buf=
fers
>     which is for uncache accleration.
>
>     Uncached Accelerated is the name under which the R10000 introduced
>     a cache mode that uses the CPU's write buffer to combine writes
>     but that otherwise is uncached.
>
>     wbflush is mean to empty data gathered in the uncache store buffers
>     within the CPU.
>
>  2) The SYNC instruction in R10000
>
>     A SYNC instruction is not prevented from graduating if the uncached
>     buffer contains any uncached accelerated stores[1].
>
>  3) wbflush() implementation of IDT CPU.
>
>     IDT CPUs enforce strict write priority (all pending writes retired
>     to memory before main memory is read). Thus, implementing wbflush()
>     is as simple as implementing an uncached load.
>
>     for loongson's cpu, __wbflush should also be implemented with
>     __fast_iob not sync.
>
> [1]=20
> https://www.ele.uva.es/~jesman/BigSeti/ftp/Microprocesadores/MIPS/t5.v=
er.2.0.book.pdf
>
> Signed-off-by: suijingfeng <suijingfeng@loongson.cn>
> ---
>  arch/mips/loongson64/Makefile  |  1 +
>  arch/mips/loongson64/setup.c   | 17 -----------------
>  arch/mips/loongson64/smp.c     |  6 +++---
>  arch/mips/loongson64/wbflush.c | 28 ++++++++++++++++++++++++++++
>  4 files changed, 32 insertions(+), 20 deletions(-)
>  create mode 100644 arch/mips/loongson64/wbflush.c
>
> diff --git a/arch/mips/loongson64/Makefile b/arch/mips/loongson64/Make=
file
> index e806280bbb85..ad00d92c2871 100644
> --- a/arch/mips/loongson64/Makefile
> +++ b/arch/mips/loongson64/Makefile
> @@ -12,3 +12,4 @@ obj-$(CONFIG_SUSPEND) +=3D pm.o
>  obj-$(CONFIG_PCI_QUIRKS) +=3D vbios_quirk.o
>  obj-$(CONFIG_CPU_LOONGSON3_CPUCFG_EMULATION) +=3D cpucfg-emul.o
>  obj-$(CONFIG_SYSFS) +=3D boardinfo.o
> +obj-$(CONFIG_CPU_HAS_WB) +=3D wbflush.o
> diff --git a/arch/mips/loongson64/setup.c b/arch/mips/loongson64/setup=
.c
> index 6fe3ffffcaa6..cb10d14da433 100644
> --- a/arch/mips/loongson64/setup.c
> +++ b/arch/mips/loongson64/setup.c
> @@ -3,10 +3,7 @@
>   * Copyright (C) 2007 Lemote Inc. & Institute of Computing Technology
>   * Author: Fuxin Zhang, zhangfx@lemote.com
>   */
> -#include <linux/export.h>
>  #include <linux/init.h>
> -
> -#include <asm/wbflush.h>
>  #include <asm/bootinfo.h>
>  #include <linux/libfdt.h>
>  #include <linux/of_fdt.h>
> @@ -17,20 +14,6 @@
>=20
>  void *loongson_fdt_blob;
>=20
> -static void wbflush_loongson(void)
> -{
> -	asm(".set\tpush\n\t"
> -	    ".set\tnoreorder\n\t"
> -	    ".set mips3\n\t"
> -	    "sync\n\t"
> -	    "nop\n\t"
> -	    ".set\tpop\n\t"
> -	    ".set mips0\n\t");
> -}
> -
> -void (*__wbflush)(void) =3D wbflush_loongson;
> -EXPORT_SYMBOL(__wbflush);
> -
>  void __init plat_mem_setup(void)
>  {
>  	if (loongson_fdt_blob)
> diff --git a/arch/mips/loongson64/smp.c b/arch/mips/loongson64/smp.c
> index 660e1de4412a..0d9f249c95f9 100644
> --- a/arch/mips/loongson64/smp.c
> +++ b/arch/mips/loongson64/smp.c
> @@ -42,13 +42,13 @@ static uint32_t core0_c0count[NR_CPUS];
>  #define loongson3_ipi_write32(action, addr)	\
>  	do {					\
>  		writel(action, addr);		\
> -		__wbflush();			\
> +		wbflush();			\
>  	} while (0)
>  /* write a 64bit value to ipi register */
>  #define loongson3_ipi_write64(action, addr)	\
>  	do {					\
>  		writeq(action, addr);		\
> -		__wbflush();			\
> +		wbflush();			\
>  	} while (0)
>=20
>  static u32 (*ipi_read_clear)(int cpu);
> @@ -418,7 +418,7 @@ static irqreturn_t loongson3_ipi_interrupt(int irq=
,=20
> void *dev_id)
>  		c0count =3D c0count ? c0count : 1;
>  		for (i =3D 1; i < nr_cpu_ids; i++)
>  			core0_c0count[i] =3D c0count;
> -		__wbflush(); /* Let others see the result ASAP */
> +		wbflush(); /* Let others see the result ASAP */
>  	}
>=20
>  	return IRQ_HANDLED;
> diff --git a/arch/mips/loongson64/wbflush.c b/arch/mips/loongson64/wbf=
lush.c
> new file mode 100644
> index 000000000000..49f0e4c53196
> --- /dev/null
> +++ b/arch/mips/loongson64/wbflush.c
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * This file is subject to the terms and conditions of the GNU Genera=
l Public
> + * License.  See the file "COPYING" in the main directory of this arc=
hive
> + * for more details.
> + *
> + * Copyright (C) 2021 suijingfeng@loongson.cn
> + */
> +#include <linux/export.h>
> +#include <linux/init.h>
> +#include <asm/wbflush.h>
> +#include <asm/barrier.h>
> +
> +#ifdef CONFIG_CPU_HAS_WB
> +
> +/*
> + * I/O ASIC systems use a standard writeback buffer that gets flushed
> + * upon an uncached read.
> + */
> +static void wbflush_mips(void)
> +{
> +	__fast_iob();
> +}
> +
> +void (*__wbflush)(void) =3D wbflush_mips;
> +EXPORT_SYMBOL(__wbflush);
> +
> +#endif
> --=20
> 2.25.1

--=20
- Jiaxun
