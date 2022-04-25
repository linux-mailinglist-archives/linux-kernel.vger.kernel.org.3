Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A8550E76D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240490AbiDYRns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbiDYRnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:43:47 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011794091C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:40:41 -0700 (PDT)
Received: from mail-wr1-f51.google.com ([209.85.221.51]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MEFnP-1nZRnR0z4v-00ADuV for <linux-kernel@vger.kernel.org>; Mon, 25 Apr
 2022 19:40:40 +0200
Received: by mail-wr1-f51.google.com with SMTP id w4so21883530wrg.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:40:40 -0700 (PDT)
X-Gm-Message-State: AOAM533bwtOd6dHgrL3BRXJWQCUtTAjW9ApJVdgg4kSZ9aT+2W4j4NyC
        hl0adqsDKZrMGtCgg7Vt4uaq8QGhibYUGOhDRdo=
X-Google-Smtp-Source: ABdhPJxEGcTnLg0acH93I4QWcC8rrfHiYkXwGS05uktEcHZuF3rO3OtXZJdPMv9SgKwh/96ig0xApD10o9E5brovf4c=
X-Received: by 2002:a5d:6da5:0:b0:20a:8805:6988 with SMTP id
 u5-20020a5d6da5000000b0020a88056988mr14423462wrs.317.1650908439868; Mon, 25
 Apr 2022 10:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <YmX7z+BirkA3VAfW@zx2c4.com> <CAK8P3a3Af5FBx-OnedHPrf28ikX4DZK1d0ERLsV+oKyBHyCXiw@mail.gmail.com>
 <YmaJUvg6hmekvkXE@zx2c4.com> <CAK8P3a3FZeXzBJKyTEvmvw_DaHGQFf5rQKs=_wBW=GZ2+=rJ_Q@mail.gmail.com>
 <Yma8OQ3zY3PzY87T@zx2c4.com> <CAK8P3a0Y3BFCkg8e-o5i6xPfb9WVQzOQOACXtrH1VmQJkSriDQ@mail.gmail.com>
 <YmbD/oPIUBvJ/YjQ@zx2c4.com> <CAK8P3a1kRXQrmNg4eQw0-P+Fzz_AvFooLg3=nQNQKMRwvL9DWQ@mail.gmail.com>
 <YmbUBZg/nGV7gLyy@zx2c4.com>
In-Reply-To: <YmbUBZg/nGV7gLyy@zx2c4.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 25 Apr 2022 19:40:22 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1YNQG0xvC+tKPfFPSXuGESjwr5zz_Ubt3QwvY3_QjGdw@mail.gmail.com>
Message-ID: <CAK8P3a1YNQG0xvC+tKPfFPSXuGESjwr5zz_Ubt3QwvY3_QjGdw@mail.gmail.com>
Subject: Re: odd endianness toolchains for crosstool
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:l4Xh0gNzB6q4KmQxiX1rB70GO5dHZIuE+bwOWMU9guXAAdAPcaO
 pIxhvf/AO3ooffA8E+tv7MMlW4qZJaP/5Nb3WSWRWjGsk5+avdjV7uADV7jj6ckrsRxu+rz
 l1pF4A3Z9ilMeAuypUm+1M1Qd0qNSQOag6gFXh+v4iAsgebp5SqSKi6Ae0H/2WoxL/5sl/6
 JUmYPICdVYHzkv1xEJ5Qg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bInvcxNRIXY=:oFXG0hZdkX9jSs+xpW+M3A
 BphSH3YwNRMDPz+u+CbtDCQzbaToMA9FSenBAMvDIklmVh8HK+2iB9W4+ZMcRalVVSzwucWjE
 u02r3rmeYRNqL8fQ0+nXl24ZI0IqadAAT6L9ghYGlsZoTRNYmyy4cQ5jw+TlQizbe+f9klqF6
 CdTyLMXzEwaDUyHV5YEnZ9ya2e9eafEQ9NXLtHu6DRC3kxaLF0TzYYuyCV7HSe6E+2Ih1eAT+
 r9NFNBK69BaCkzN1vtds8X4jMfLI5+4wwthWwVl9SeBZAUegsu6KY3x00BVLOLqNP24CEa9st
 vrOAtiVIQ5t6u4h/ZrPSlpXMrPsy3JKW0d/2g+o3z08B8GgmZuWzZ5TaLU7MKcbqAkA/2OwsS
 Uqoqt0KGBBIiCCosT/RcPY3qL7o+Iqoj3MCqms51/d4zsVDU/Kdjqg2HAqcdJEc3+7JPfi1fW
 TvnI9s2tel/LptOPBiZdv+iJ7Ka6qnT7+IiecyOn7w7wOYYwt94wX40TYddJOFSn53fBXjy9q
 OEz4qO/dkYHEL8HWDZvmfoEgOLpZ0aDvyTfRFkAZME/aYEY9ITXFiZBq5maWUdiYB82cnzFEv
 mYJsd008/Lz3O+pMsIwZhh79F0T188Ou3jtfEO0bVmesPvmXkYC4O7WK7rmHfIHJ8wNjyiccm
 UrHEluzHuzlKOOuij6ntOVGQLTWVgAV5m45n4X59ECOW4mwUnLPfApfqIKSR4PSF7JW8=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 7:01 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> On Mon, Apr 25, 2022 at 06:15:07PM +0200, Arnd Bergmann wrote:
> > On Mon, Apr 25, 2022 at 5:53 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > Ok, I see. For all I can tell, the toolchain I built already uses both
> > --with-long-double-64
> > and --enable-secureplt, as those seemt to be the default for Linux.
>
> For ppc32? I'm unable to produce working executables with the toolchain.
> And looking at the target info, -msecure-plt is missing, while
> -mlong-double-64 is there:
>
> $ ./powerpc-linux-gcc -Q --help=target | grep long-double
>   -mlong-double-                        64
> $ ./powerpc-linux-gcc -Q --help=target | grep msecure-plt
>   -msecure-plt                          [disabled]

Ah, my mistake, I looked at the distro provided compiler instead of my own :(

> For ppc64, I see the same. I'll try to look into it more though.
>
> > Regarding the the ELF ABI, I'm not sure how to check, but I think it
> > only does ELFv1, which is the default for big-endian glibc.
>
> Yes, it only is doing ELFv1 right now. musl checks this in
> <https://git.musl-libc.org/cgit/musl/tree/configure#n689> with this:
>
>     trycppif "_CALL_ELF == 2" "$t" || fail "$0: error: unsupported powerpc64 ABI"

Does it work if you pass -mabi=elfv2? This seems to be ignored here as well:

$ powerpc-linux-gcc  -mlittle-endian -mabi=elfv2 -xc -c /dev/null  -o /tmp/a.o
$ file /tmp/a.o
/tmp/a.o: ELF 32-bit LSB relocatable, PowerPC or cisco 4500, version 1
(SYSV), not stripped

        Arnd
