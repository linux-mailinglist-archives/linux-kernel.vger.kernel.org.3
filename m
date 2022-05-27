Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC2F5363A1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 15:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352848AbiE0N6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 09:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240514AbiE0N6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 09:58:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A72613CD4;
        Fri, 27 May 2022 06:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653659861;
        bh=sguvIpamEs+8ZftKok+OD4Ae+fTk7JTH8TB8h2DNyw4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=HQymCyj5my8UySLozJjhivzXzt2O0D3r/5PfQ3jcl8OQgtvEq5KzA3SFtU7DNS3Hp
         PWh49sZU3Q7PmNJ+MebkwMDkQ/CbWc/xig115tEzeosFMDkMm9JdfIwVlHhq+2O6/+
         1CaeBDR74w3UZxlqMNdnEVPOd3QKUJjfKEzSsvyY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.153.1]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mkpav-1nYD1e2jCZ-00mLHH; Fri, 27
 May 2022 15:57:41 +0200
Message-ID: <1c12cd26-d8aa-4498-f4c0-29478b9578fe@gmx.de>
Date:   Fri, 27 May 2022 15:57:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v7 3/8] parisc: fix the exit status of arch/parisc/nm
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, llvm@lists.linux.dev,
        linux-parisc@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
References: <20220527100155.1996314-1-masahiroy@kernel.org>
 <20220527100155.1996314-4-masahiroy@kernel.org>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220527100155.1996314-4-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rnzEX+fIh/b7XvFHwFrUOvS+E6bfrWBb0OjbmoABoY7eEYFwol/
 tSEWZTjKLpLoqys43MoXs9LV3XC/t33zohBzXhXDnwtbvSno9l/gRbtG/Pd9sk4M4LPf7Os
 CpX/dRb36KQR5bz4XG8tmGwqNX6rim9wnN5pdQ+n1xXsfFZvb2iNOAOx4n4SREIxmDddzA4
 4wRUOA3dl2IhZ9ivSXCjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ejNS0xTMqGk=:EGcSQ5nJGcNajPmlb+fvdZ
 /QWChlhJsNiHTp0PvSWb62rKbY5nkRZrtbqbWAECIZrY7p+QijMVYLH6Yt+dZHCC4as5kgGGF
 No14sXj55Wh+xoF0pSXptmfZvhjAYKUcfqvNgSzJg2Ri6OV7TyTDRcriDYi74rK6s+7cwWhHI
 w6mNOkVEXlGdHH/1MwMxNPIrvQcaDdtfYqjBTN/5m0htj94ha1XfTCXCfIJx1sxroLA1WR5Es
 cd3JUws5DZM0AWzj3tOEvIuAz24ns3uTLOD52w4kZir7EYrLVvsd5Rc1a8KQZPBaQNRBsKMgV
 A5FpTKj1zGd49+2lS5d4qedChEzIVdSIQQANym0TSN8AsesHV2GqO/Jp0A1RPZv7FxmglYPQE
 tFjIvXuW2AIRZtfQ+5+X4a7x6zT0b7OrrSKStgk64M59cQNJ06Dab92nI62+ruznjiqyagDJn
 dfwZX5lWPL9JAS2smWX1v2xdQf6apJ0ZNidHJgTYocooDB7PYYSAtyorrPLgXyuE+sg9nOOmF
 RBM/h7xf3KVviBjBfITaOK5+IUar/SNWoaY2CrjORe0Y9v767XZXhn5dOmUxQ5QZzpvKQ4Ksq
 MnQciTFX+6VnSwNqknnsvca+Z/+JWGqpn5EqfnHkYPsM5sQhZ9DMEZ/SqDxV+uuo5tlAk4Yhq
 a4TEGB+2Ekh2SYzmVXZUu6W9kj2A6E62yGFtecKRXXO8374ixLAYTH1ooGWeS+ANYGUycv0JY
 l03v08Yq3i1CXa8v7QhCnUM6B5uzXu4slJbPz8SysciVTNHhdtMkOX6SrcLgBPHycpYVU97pY
 CZJsFwQtIKcNJc+EoRYsJ7izdVa04BEwVkfbKT/acXoN9d9trj+uJIeksLiZO61oF8qww4yFz
 HF73JFkJKrDT4pLJX+HR8gnCHLhlSA4fnhj8rzjV/lwCJPMr+ymnLtheTlczF9lk/YlHmynVB
 pEuHsx8P/fv2Sns08Ipp2hyC9dEfKVVdpLfk/xljEhZVFhgcuSiDIrSNgBnnsFxfiL51oNfRQ
 /PVYhx36fXwKU/ICxvqjuG8jgBRYYK2/NRGL1uOQqqEZ+TwG2k0QD3PxASD1U4QyjdstUYLZ6
 Me0dcmpD2Uv65lQIFqL8x4pj6Ew9Mvx4Be3eoepPyNGoTqv3sg1UZdGlA==
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Masahiro,

On 5/27/22 12:01, Masahiro Yamada wrote:
> parisc overrides 'nm' with a shell script. I do not know the reason,
> but anyway it is how it has worked since 2003. [1]

I don't know the reason either...
I assume it was that the older toolchains had bugs and kept lots of local
symbols like .LC? in the object files.

I did a small build without the nm script (and removed it's reference
in the Makefile), and it did not seem to break anything.

> A problem is that this script returns the exit code of grep instead of
> ${CROSS_COMPILE}nm.

Instead of fixing this, I'd suggest that you simply remove the nm script
alltogether. If you like I can apply such a patch in the parisc git tree,
and you just drop this specific patch. Or you change your patch to remove =
it.
Just let me know what you prefer.

Helge

> grep(1) says:
>     Normally the exit status is 0 if a line is selected, 1 if no lines
>     were selected, and 2 if an error occurred. However, if the -q or
>     --quiet or --silent is used and a line is selected, the exit status
>     is 0 even if an error occurred.
>
> When the given object has no symbol, grep returns 1, while the true nm
> returns 0. Hence, build rules using ${NM} fail on ARCH=3Dparisc even if
> the given object is valid.
>
> This commit corrects the exit status of the script.
>
>  - A pipeline returns the exit status of the last command (here, grep).
>    The exit status of ${CROSS_COMPILE}nm is just ignored. Use bash's
>    pipefail flag to catch errors of ${CROSS_COMPILE}nm.
>
>  - If grep returns 1, this script should return 0 in order to mimic
>    true nm. If grep returns 2, it is a real and fatal error. Return
>    it as is.
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git=
/commit/?id=3D36eaa6e4c0e0b6950136b956b72fd08155b92ca3
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
> Changes in v7:
>   - New patch
>
>  arch/parisc/Makefile |  2 +-
>  arch/parisc/nm       | 12 ++++++++++--
>  2 files changed, 11 insertions(+), 3 deletions(-)
>  mode change 100644 =3D> 100755 arch/parisc/nm
>
> diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
> index aca1710fd658..e7139955367d 100644
> --- a/arch/parisc/Makefile
> +++ b/arch/parisc/Makefile
> @@ -18,7 +18,7 @@
>  boot :=3D arch/parisc/boot
>  KBUILD_IMAGE :=3D $(boot)/bzImage
>
> -NM		=3D sh $(srctree)/arch/parisc/nm
> +NM		=3D $(srctree)/arch/parisc/nm
>  CHECKFLAGS	+=3D -D__hppa__=3D1
>
>  ifdef CONFIG_64BIT
> diff --git a/arch/parisc/nm b/arch/parisc/nm
> old mode 100644
> new mode 100755
> index c788308de33f..3e72238a91f3
> --- a/arch/parisc/nm
> +++ b/arch/parisc/nm
> @@ -1,6 +1,14 @@
> -#!/bin/sh
> +#!/bin/bash
>  ##
>  # Hack to have an nm which removes the local symbols.  We also rely
>  # on this nm being hidden out of the ordinarily executable path
>  ##
> -${CROSS_COMPILE}nm $* | grep -v '.LC*[0-9]*$'
> +
> +# use pipefail to catch error of ${CROSS_COMPILE}nm
> +set -o pipefail
> +
> +# grep exits with 1 if no lines were selected.
> +# If the given object has no symbol, grep returns 1, but it is not an e=
rror.
> +
> +${CROSS_COMPILE}nm "$@" |
> +{ grep -v '.LC*[0-9]*$' || { exit_code=3D$?; test $exit_code -eq 1 || e=
xit $exit_code; } }

