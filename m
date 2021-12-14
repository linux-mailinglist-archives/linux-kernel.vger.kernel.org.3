Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0C94740AF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 11:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbhLNKp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 05:45:26 -0500
Received: from mout.gmx.net ([212.227.15.15]:49489 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231415AbhLNKpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 05:45:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1639478711;
        bh=drSjkyonQU7oy65m/aGuRAsYLy8dbe9fDUf7Dm9VbPI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=IOMQaJSkEM4yO9yw4VLb5ZYDNq1/zGhdjacLXoUiZqwsxLXJ7hN/Oc7F+02t01ifH
         DBwDq0wOAsS7KIj7AdCj/CLe9yaN1HjhxjDu6Ww2jtNKj/FcVMkzGenMdcdRTnaS7r
         u513aAbZxklx8RsgYNt6DBWvvGwDxFuQKgx5Opps=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.139.19]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSKuA-1n3ad43xRA-00ScCO; Tue, 14
 Dec 2021 11:45:11 +0100
Message-ID: <0314b689-4445-def8-5f17-0c73f7567cf1@gmx.de>
Date:   Tue, 14 Dec 2021 11:45:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] parisc: decompressor: do not copy source files while
 building
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-parisc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Rich Felker <dalias@libc.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
References: <20211213030915.1170219-1-masahiroy@kernel.org>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20211213030915.1170219-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BC5ZmpRDbkwN6GVfkT0uC9g9xvx8/sQ0zFN2GqfOeAfnr67kV2X
 ECzUDVu2koPvoQj46NxkqNeOV8D6A+OxKqLEuRyiQPqeGNQ3Hfc7nGQoHmGBbNCyR5vUkuW
 mY9zTnIp5kVSReT9e3wP7NlyINhWmKv16qlupSknkbHJ1IZB7k2Q+yseMLZg4n33NpBQ8Y6
 Uc7nqRKtgh/rQs8rs1abg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SuxwQnTSisE=:j76seZhXHwZ8ZjspwI4c8d
 o8h7URu0xn9yQRXQnIfmb4n0/+Dj8ojiXy0PH8/Z0EUWJ1JBVov11RaQx2SEf9pQerlesrpZk
 p5M5C29VACWZAm93Ivb0ix6jXhc86Wdeh8TjhyJJYjS/FBE1iUxVzjvALAWj07FwhLFINY2TI
 u8t3DPmG4/9rQo3Nex4bCVbmnoKX5ANBkYoPkYzbKPzoHG0yXi03vf3E3YQTG/E7xO3X6O3fN
 mVqvt7iGpAPog09i4m0U2QRPr43aJU9cOENtQu6ZGLRDUMo860Vh6Q/HSh+kVQ+q3ShRL0gbM
 X1ts0OKPQZxbAU8Bs/0n/ZoS2dAq9HpAyghNmLFj6o10D7TYBE3E17ifhKkJrzRisD3VvTwoT
 Y+e+0h5jDIX4hpDDFHy/q+cPXdOMiIzXFA8KD7aB9PKpJ0/gEhruPxKWgg+gZXXmskDpxkgrG
 n6ZR+22EFbRZWaGIYoRUVbmtUOnJ9ka3nI8ZDC5VkfmaExQFjng1uhNAycrImjL+X1mdwdev7
 p/0sswuL177MGNRVAeB9P0HITqKh3/w3pB3gJaXOvYc+w44YsPJj3aooqW/A1dX0I1ZNCGILw
 kTwab4noqS01wOkMnvu7ynp3wKYGF/+wR9RJqpcpuKJqG0y+0YLFSjjVr/9xCoMF8uCmr0OFG
 eHsKHJ+Jy7emRzpolE0uDc43aK4YzJWAWcm45aWUVonAT1az5czhtGXro3g1wD9jsgrWCbEh/
 qZp170Dxc3jQdh0p5ZcXueRB5VBFZbyDokSTD9wSkLmYWvCCHM4YN+GtRCSV7vXMAa6H78Yf+
 RZgV/lwhmCkeJLsTDqDJXOzIl9ZU7uz5yAbZgDTIhCraAwhUj7ZeoTVZwPxqW76nEQ8BtXamb
 VQN2a1NN2PKLQSPGOjm+DXb85b2XZgpKGqEShcQrH0JCpSpIOgCeiibYr+vGjac5r/+6AKiVq
 MNuSwIY+qYCXru0kb9Ou1x9hUDPFayg66iF+aZxdltQudV/M9ZZrxwV1QjgzpsguBS2Xdlzro
 E2VllLY+xPTVX8M51igsPbm64mT1Z9FBIt+LHNmtQGw+IP3UTTYhTsJXb3Urb9qlkvStElUmu
 UtUF0ICuE6Z5HU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/21 04:09, Masahiro Yamada wrote:
> As commit 7ae4a78daacf ("ARM: 8969/1: decompressor: simplify libfdt
> builds") stated, copying source files during the build time may not
> end up with as clean code as expected.
>
> Do similar for parisc to clean up the Makefile.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Acked-by: Helge Deller <deller@gmx.de>

Thanks!
Helge

> ---
>
>  arch/parisc/boot/compressed/.gitignore | 2 --
>  arch/parisc/boot/compressed/Makefile   | 8 --------
>  arch/parisc/boot/compressed/firmware.c | 2 ++
>  arch/parisc/boot/compressed/real2.S    | 2 ++
>  scripts/remove-stale-files             | 5 +++++
>  5 files changed, 9 insertions(+), 10 deletions(-)
>  create mode 100644 arch/parisc/boot/compressed/firmware.c
>  create mode 100644 arch/parisc/boot/compressed/real2.S
>
> diff --git a/arch/parisc/boot/compressed/.gitignore b/arch/parisc/boot/c=
ompressed/.gitignore
> index b9853a356ab2..a5839aa16706 100644
> --- a/arch/parisc/boot/compressed/.gitignore
> +++ b/arch/parisc/boot/compressed/.gitignore
> @@ -1,6 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -firmware.c
> -real2.S
>  sizes.h
>  vmlinux
>  vmlinux.lds
> diff --git a/arch/parisc/boot/compressed/Makefile b/arch/parisc/boot/com=
pressed/Makefile
> index bf4f2891d0b7..116bd5c1873c 100644
> --- a/arch/parisc/boot/compressed/Makefile
> +++ b/arch/parisc/boot/compressed/Makefile
> @@ -13,7 +13,6 @@ OBJECTS :=3D head.o real2.o firmware.o misc.o piggy.o
>  targets :=3D vmlinux.lds vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin=
.bz2
>  targets +=3D vmlinux.bin.xz vmlinux.bin.lzma vmlinux.bin.lzo vmlinux.bi=
n.lz4
>  targets +=3D $(OBJECTS) sizes.h
> -targets +=3D real2.S firmware.c
>
>  KBUILD_CFLAGS :=3D -D__KERNEL__ -O2 -DBOOTLOADER
>  KBUILD_CFLAGS +=3D -DDISABLE_BRANCH_PROFILING
> @@ -42,14 +41,7 @@ $(obj)/head.o: $(obj)/sizes.h
>  CFLAGS_misc.o +=3D -I$(objtree)/$(obj)
>  $(obj)/misc.o: $(obj)/sizes.h
>
> -$(obj)/firmware.o: $(obj)/firmware.c
> -$(obj)/firmware.c: $(srctree)/arch/$(SRCARCH)/kernel/firmware.c
> -	$(call cmd,shipped)
> -
>  AFLAGS_real2.o +=3D -DBOOTLOADER
> -$(obj)/real2.o: $(obj)/real2.S
> -$(obj)/real2.S: $(srctree)/arch/$(SRCARCH)/kernel/real2.S
> -	$(call cmd,shipped)
>
>  CPPFLAGS_vmlinux.lds +=3D -I$(objtree)/$(obj) -DBOOTLOADER
>  $(obj)/vmlinux.lds: $(obj)/sizes.h
> diff --git a/arch/parisc/boot/compressed/firmware.c b/arch/parisc/boot/c=
ompressed/firmware.c
> new file mode 100644
> index 000000000000..16a07137fe92
> --- /dev/null
> +++ b/arch/parisc/boot/compressed/firmware.c
> @@ -0,0 +1,2 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include "../../kernel/firmware.c"
> diff --git a/arch/parisc/boot/compressed/real2.S b/arch/parisc/boot/comp=
ressed/real2.S
> new file mode 100644
> index 000000000000..cdc6a4da3240
> --- /dev/null
> +++ b/arch/parisc/boot/compressed/real2.S
> @@ -0,0 +1,2 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#include "../../kernel/real2.S"
> diff --git a/scripts/remove-stale-files b/scripts/remove-stale-files
> index f0d53227fe7b..80430b8fb617 100755
> --- a/scripts/remove-stale-files
> +++ b/scripts/remove-stale-files
> @@ -33,4 +33,9 @@ if [ -n "${building_out_of_srctree}" ]; then
>  	do
>  		rm -f arch/mips/boot/compressed/${f}
>  	done
> +
> +	for f in firmware.c real2.S
> +	do
> +		rm -f arch/parisc/boot/compressed/${f}
> +	done
>  fi
>

