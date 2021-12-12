Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71C1471CDC
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 21:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhLLUPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 15:15:33 -0500
Received: from mail-lf1-f41.google.com ([209.85.167.41]:38886 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbhLLUPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 15:15:31 -0500
Received: by mail-lf1-f41.google.com with SMTP id bi37so27361779lfb.5;
        Sun, 12 Dec 2021 12:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P9iBGIirnE079mDC33m+ZeyiHq9a58D+yeiB4U9Jaqo=;
        b=ibIriInNreZgcvF3xoBF0Nqe/ta7gRXJYZ26KaXISYrzo1juDykiDuCqEqNmNOXkqc
         VawmNDA44485VSEYzWfNchhmeyA0L6k0FJNEQ6a7eVZbq8HugKKZSDoXH0I5IQFJrQ/m
         p9PZxO0ex+Ag341zpH/z4PRDV3vPzRlVrm6lOoLwbLnGmTGIROLm4BZSsNj78C5oyG/T
         PGG5mC7mVlqLVmKB0uGMBPUkZEOQHyMYenfb0PJbsCjx0PrtSFLxmKcPzVYyYf3cMM8a
         BKrTOQOwJhTEgb+2bD/QtJGY01DduNThIxodRNP/qZlDho7VTTC+rezMX0PJ2FsKt+Fz
         qrdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P9iBGIirnE079mDC33m+ZeyiHq9a58D+yeiB4U9Jaqo=;
        b=7bPY8847pJJ+71zr/uV20lj+4p+p0fbB0HpvsxVFOxcCJMP+WVEsBhjloIfhwyfF0K
         S3pyW5/ybNmmtrAK5oqELMLGrN8Uy5Ks03ba+2IY/UqENq3psBPm8YjIB8aOgqiA+2dB
         muEwncI0BBL+EGuQYAI0vNxioD420fz4EX47Nz3GE18KE/IM3V+nHk8XsITqphEtKVIT
         u8VToNB/hbVIqLPggEDcuKxWBSKWEIWX4LQDqeKl749XVg93Gj8ogg9q3j/hZ0dK9Sr3
         5KaFgw2ZzeuS83u3SZXP+xY995N9XUyCdD5Yb0zYkkKX9DexNtfFa0UAyiwSDFPvnEWj
         gxzw==
X-Gm-Message-State: AOAM531vF1pTz1+YaP4ABSM8qfNmj84a/hPBFCjVB3T3TbG0/bakuC9o
        Cls5bzxv6WFjBCiAa7wjnavAhEnDQ9OcBe8pk7k=
X-Google-Smtp-Source: ABdhPJztDTs592zdaCAV22rEoc3dFDuVKaf9eiwmQtAt59lSuvVTsiLV8ugzBjsdTaZqTsX/Gu3b3Fqp6l4+BQ7aRtM=
X-Received: by 2002:a19:770a:: with SMTP id s10mr26522774lfc.234.1639340069605;
 Sun, 12 Dec 2021 12:14:29 -0800 (PST)
MIME-Version: 1.0
References: <20211105154334.1841927-1-alexandre.ghiti@canonical.com> <20211105154334.1841927-4-alexandre.ghiti@canonical.com>
In-Reply-To: <20211105154334.1841927-4-alexandre.ghiti@canonical.com>
From:   Steve French <smfrench@gmail.com>
Date:   Sun, 12 Dec 2021 14:14:18 -0600
Message-ID: <CAH2r5muPS_PSFpdy1xw2mUNcOJ-CRY5EWU1Zwo9DK+UX6VcDvw@mail.gmail.com>
Subject: Re: [PATCH 3/7] Documentation, arch: Remove leftovers from CIFS_WEAK_PW_HASH
To:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Cc:     Steve French <sfrench@samba.org>, Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jeff Layton <jlayton@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-cachefs@redhat.com,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, linux-power@fi.rohmeurope.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You can add my RB is you would like to this.

Also note an additional typo in the existing config description
"laintext" instead of "plaintext"

On Fri, Nov 5, 2021 at 11:11 AM Alexandre Ghiti
<alexandre.ghiti@canonical.com> wrote:
>
> This config was removed so remove all references to it.
>
> Fixes: 76a3c92ec9e0 ("cifs: remove support for NTLM and weaker authentication algorithms")
> Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
> ---
>  Documentation/admin-guide/cifs/usage.rst    | 7 +++----
>  arch/arm/configs/cm_x300_defconfig          | 1 -
>  arch/arm/configs/ezx_defconfig              | 1 -
>  arch/arm/configs/imote2_defconfig           | 1 -
>  arch/arm/configs/nhk8815_defconfig          | 1 -
>  arch/arm/configs/pxa_defconfig              | 1 -
>  arch/mips/configs/fuloong2e_defconfig       | 1 -
>  arch/mips/configs/malta_qemu_32r6_defconfig | 1 -
>  arch/mips/configs/maltaaprp_defconfig       | 1 -
>  arch/mips/configs/maltasmvp_defconfig       | 1 -
>  arch/mips/configs/maltasmvp_eva_defconfig   | 1 -
>  arch/mips/configs/maltaup_defconfig         | 1 -
>  arch/mips/configs/nlm_xlp_defconfig         | 1 -
>  arch/mips/configs/nlm_xlr_defconfig         | 1 -
>  arch/powerpc/configs/ppc6xx_defconfig       | 1 -
>  arch/sh/configs/titan_defconfig             | 1 -
>  16 files changed, 3 insertions(+), 19 deletions(-)
>
> diff --git a/Documentation/admin-guide/cifs/usage.rst b/Documentation/admin-guide/cifs/usage.rst
> index f170d8820258..3766bf8a1c20 100644
> --- a/Documentation/admin-guide/cifs/usage.rst
> +++ b/Documentation/admin-guide/cifs/usage.rst
> @@ -734,10 +734,9 @@ SecurityFlags              Flags which control security negotiation and
>                         using weaker password hashes is 0x37037 (lanman,
>                         plaintext, ntlm, ntlmv2, signing allowed).  Some
>                         SecurityFlags require the corresponding menuconfig
> -                       options to be enabled (lanman and plaintext require
> -                       CONFIG_CIFS_WEAK_PW_HASH for example).  Enabling
> -                       plaintext authentication currently requires also
> -                       enabling lanman authentication in the security flags
> +                       options to be enabled.  Enabling plaintext
> +                       authentication currently requires also enabling
> +                       lanman authentication in the security flags
>                         because the cifs module only supports sending
>                         laintext passwords using the older lanman dialect
>                         form of the session setup SMB.  (e.g. for authentication
> diff --git a/arch/arm/configs/cm_x300_defconfig b/arch/arm/configs/cm_x300_defconfig
> index 502a9d870ca4..45769d0ddd4e 100644
> --- a/arch/arm/configs/cm_x300_defconfig
> +++ b/arch/arm/configs/cm_x300_defconfig
> @@ -146,7 +146,6 @@ CONFIG_NFS_V3_ACL=y
>  CONFIG_NFS_V4=y
>  CONFIG_ROOT_NFS=y
>  CONFIG_CIFS=m
> -CONFIG_CIFS_WEAK_PW_HASH=y
>  CONFIG_PARTITION_ADVANCED=y
>  CONFIG_NLS_CODEPAGE_437=m
>  CONFIG_NLS_ISO8859_1=m
> diff --git a/arch/arm/configs/ezx_defconfig b/arch/arm/configs/ezx_defconfig
> index a49e699e52de..ec84d80096b1 100644
> --- a/arch/arm/configs/ezx_defconfig
> +++ b/arch/arm/configs/ezx_defconfig
> @@ -314,7 +314,6 @@ CONFIG_NFSD_V3_ACL=y
>  CONFIG_SMB_FS=m
>  CONFIG_CIFS=m
>  CONFIG_CIFS_STATS=y
> -CONFIG_CIFS_WEAK_PW_HASH=y
>  CONFIG_CIFS_XATTR=y
>  CONFIG_CIFS_POSIX=y
>  CONFIG_NLS_CODEPAGE_437=m
> diff --git a/arch/arm/configs/imote2_defconfig b/arch/arm/configs/imote2_defconfig
> index 118c4c927f26..6db871d4e077 100644
> --- a/arch/arm/configs/imote2_defconfig
> +++ b/arch/arm/configs/imote2_defconfig
> @@ -288,7 +288,6 @@ CONFIG_NFSD_V3_ACL=y
>  CONFIG_SMB_FS=m
>  CONFIG_CIFS=m
>  CONFIG_CIFS_STATS=y
> -CONFIG_CIFS_WEAK_PW_HASH=y
>  CONFIG_CIFS_XATTR=y
>  CONFIG_CIFS_POSIX=y
>  CONFIG_NLS_CODEPAGE_437=m
> diff --git a/arch/arm/configs/nhk8815_defconfig b/arch/arm/configs/nhk8815_defconfig
> index 23595fc5a29a..907d6512821a 100644
> --- a/arch/arm/configs/nhk8815_defconfig
> +++ b/arch/arm/configs/nhk8815_defconfig
> @@ -127,7 +127,6 @@ CONFIG_NFS_FS=y
>  CONFIG_NFS_V3_ACL=y
>  CONFIG_ROOT_NFS=y
>  CONFIG_CIFS=m
> -CONFIG_CIFS_WEAK_PW_HASH=y
>  CONFIG_NLS_CODEPAGE_437=y
>  CONFIG_NLS_ASCII=y
>  CONFIG_NLS_ISO8859_1=y
> diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
> index 58f4834289e6..dedaaae3d0d8 100644
> --- a/arch/arm/configs/pxa_defconfig
> +++ b/arch/arm/configs/pxa_defconfig
> @@ -699,7 +699,6 @@ CONFIG_NFSD_V3_ACL=y
>  CONFIG_NFSD_V4=y
>  CONFIG_CIFS=m
>  CONFIG_CIFS_STATS=y
> -CONFIG_CIFS_WEAK_PW_HASH=y
>  CONFIG_CIFS_XATTR=y
>  CONFIG_CIFS_POSIX=y
>  CONFIG_NLS_DEFAULT="utf8"
> diff --git a/arch/mips/configs/fuloong2e_defconfig b/arch/mips/configs/fuloong2e_defconfig
> index 5c24ac7fdf56..ba47c5e929b7 100644
> --- a/arch/mips/configs/fuloong2e_defconfig
> +++ b/arch/mips/configs/fuloong2e_defconfig
> @@ -206,7 +206,6 @@ CONFIG_NFSD_V3_ACL=y
>  CONFIG_NFSD_V4=y
>  CONFIG_CIFS=m
>  CONFIG_CIFS_STATS2=y
> -CONFIG_CIFS_WEAK_PW_HASH=y
>  CONFIG_CIFS_XATTR=y
>  CONFIG_CIFS_POSIX=y
>  CONFIG_CIFS_DEBUG2=y
> diff --git a/arch/mips/configs/malta_qemu_32r6_defconfig b/arch/mips/configs/malta_qemu_32r6_defconfig
> index 614af02d83e6..6fb9bc29f4a0 100644
> --- a/arch/mips/configs/malta_qemu_32r6_defconfig
> +++ b/arch/mips/configs/malta_qemu_32r6_defconfig
> @@ -165,7 +165,6 @@ CONFIG_TMPFS=y
>  CONFIG_NFS_FS=y
>  CONFIG_ROOT_NFS=y
>  CONFIG_CIFS=m
> -CONFIG_CIFS_WEAK_PW_HASH=y
>  CONFIG_CIFS_XATTR=y
>  CONFIG_CIFS_POSIX=y
>  CONFIG_NLS_CODEPAGE_437=m
> diff --git a/arch/mips/configs/maltaaprp_defconfig b/arch/mips/configs/maltaaprp_defconfig
> index 9c051f8fd330..eb72df528243 100644
> --- a/arch/mips/configs/maltaaprp_defconfig
> +++ b/arch/mips/configs/maltaaprp_defconfig
> @@ -166,7 +166,6 @@ CONFIG_TMPFS=y
>  CONFIG_NFS_FS=y
>  CONFIG_ROOT_NFS=y
>  CONFIG_CIFS=m
> -CONFIG_CIFS_WEAK_PW_HASH=y
>  CONFIG_CIFS_XATTR=y
>  CONFIG_CIFS_POSIX=y
>  CONFIG_NLS_CODEPAGE_437=m
> diff --git a/arch/mips/configs/maltasmvp_defconfig b/arch/mips/configs/maltasmvp_defconfig
> index 2e90d97551d6..1fb40d310f49 100644
> --- a/arch/mips/configs/maltasmvp_defconfig
> +++ b/arch/mips/configs/maltasmvp_defconfig
> @@ -167,7 +167,6 @@ CONFIG_TMPFS=y
>  CONFIG_NFS_FS=y
>  CONFIG_ROOT_NFS=y
>  CONFIG_CIFS=m
> -CONFIG_CIFS_WEAK_PW_HASH=y
>  CONFIG_CIFS_XATTR=y
>  CONFIG_CIFS_POSIX=y
>  CONFIG_NLS_CODEPAGE_437=m
> diff --git a/arch/mips/configs/maltasmvp_eva_defconfig b/arch/mips/configs/maltasmvp_eva_defconfig
> index d1f7fdb27284..75cb778c6149 100644
> --- a/arch/mips/configs/maltasmvp_eva_defconfig
> +++ b/arch/mips/configs/maltasmvp_eva_defconfig
> @@ -169,7 +169,6 @@ CONFIG_TMPFS=y
>  CONFIG_NFS_FS=y
>  CONFIG_ROOT_NFS=y
>  CONFIG_CIFS=m
> -CONFIG_CIFS_WEAK_PW_HASH=y
>  CONFIG_CIFS_XATTR=y
>  CONFIG_CIFS_POSIX=y
>  CONFIG_NLS_CODEPAGE_437=m
> diff --git a/arch/mips/configs/maltaup_defconfig b/arch/mips/configs/maltaup_defconfig
> index 48e5bd492452..7b4f247dc60c 100644
> --- a/arch/mips/configs/maltaup_defconfig
> +++ b/arch/mips/configs/maltaup_defconfig
> @@ -165,7 +165,6 @@ CONFIG_TMPFS=y
>  CONFIG_NFS_FS=y
>  CONFIG_ROOT_NFS=y
>  CONFIG_CIFS=m
> -CONFIG_CIFS_WEAK_PW_HASH=y
>  CONFIG_CIFS_XATTR=y
>  CONFIG_CIFS_POSIX=y
>  CONFIG_NLS_CODEPAGE_437=m
> diff --git a/arch/mips/configs/nlm_xlp_defconfig b/arch/mips/configs/nlm_xlp_defconfig
> index c97f00ece828..1c8b73d03263 100644
> --- a/arch/mips/configs/nlm_xlp_defconfig
> +++ b/arch/mips/configs/nlm_xlp_defconfig
> @@ -459,7 +459,6 @@ CONFIG_NFSD=m
>  CONFIG_NFSD_V3_ACL=y
>  CONFIG_NFSD_V4=y
>  CONFIG_CIFS=m
> -CONFIG_CIFS_WEAK_PW_HASH=y
>  CONFIG_CIFS_UPCALL=y
>  CONFIG_CIFS_XATTR=y
>  CONFIG_CIFS_POSIX=y
> diff --git a/arch/mips/configs/nlm_xlr_defconfig b/arch/mips/configs/nlm_xlr_defconfig
> index 60ea102783d9..11acfc173058 100644
> --- a/arch/mips/configs/nlm_xlr_defconfig
> +++ b/arch/mips/configs/nlm_xlr_defconfig
> @@ -411,7 +411,6 @@ CONFIG_NFSD=m
>  CONFIG_NFSD_V3_ACL=y
>  CONFIG_NFSD_V4=y
>  CONFIG_CIFS=m
> -CONFIG_CIFS_WEAK_PW_HASH=y
>  CONFIG_CIFS_UPCALL=y
>  CONFIG_CIFS_XATTR=y
>  CONFIG_CIFS_POSIX=y
> diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
> index 6697c5e6682f..bb549cb1c3e3 100644
> --- a/arch/powerpc/configs/ppc6xx_defconfig
> +++ b/arch/powerpc/configs/ppc6xx_defconfig
> @@ -1022,7 +1022,6 @@ CONFIG_NFSD=m
>  CONFIG_NFSD_V3_ACL=y
>  CONFIG_NFSD_V4=y
>  CONFIG_CIFS=m
> -CONFIG_CIFS_WEAK_PW_HASH=y
>  CONFIG_CIFS_UPCALL=y
>  CONFIG_CIFS_XATTR=y
>  CONFIG_CIFS_POSIX=y
> diff --git a/arch/sh/configs/titan_defconfig b/arch/sh/configs/titan_defconfig
> index ba887f1351be..cd5c58916c65 100644
> --- a/arch/sh/configs/titan_defconfig
> +++ b/arch/sh/configs/titan_defconfig
> @@ -242,7 +242,6 @@ CONFIG_NFSD=y
>  CONFIG_NFSD_V3=y
>  CONFIG_SMB_FS=m
>  CONFIG_CIFS=m
> -CONFIG_CIFS_WEAK_PW_HASH=y
>  CONFIG_PARTITION_ADVANCED=y
>  CONFIG_NLS_CODEPAGE_437=m
>  CONFIG_NLS_ASCII=m
> --
> 2.32.0
>


-- 
Thanks,

Steve
