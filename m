Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40AE50E560
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbiDYQSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242042AbiDYQSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:18:31 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132C4BE3C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:15:25 -0700 (PDT)
Received: from mail-wm1-f43.google.com ([209.85.128.43]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mk0FM-1oBVZL39ho-00kR8g for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022
 18:15:23 +0200
Received: by mail-wm1-f43.google.com with SMTP id r187-20020a1c44c4000000b0038ccb70e239so12824377wma.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:15:23 -0700 (PDT)
X-Gm-Message-State: AOAM533XWoBne8s4BCBQsd/2cfbv25gqglQPbEuoi11Nq+3WnZDi9JMJ
        avA6Jl9WmZumhuIlC4eLymKJcuqiBscYcZIltwE=
X-Google-Smtp-Source: ABdhPJwdlTa0MvWPsNGcsg8QiV/sUm/BsOQgJKOLRyh6CGWuEzd7KB1qoqwyLgjoU1ol65lhNqw/x4271UAWATAZCMg=
X-Received: by 2002:a7b:ce15:0:b0:38e:b7b0:79be with SMTP id
 m21-20020a7bce15000000b0038eb7b079bemr17090174wmc.71.1650903323440; Mon, 25
 Apr 2022 09:15:23 -0700 (PDT)
MIME-Version: 1.0
References: <YmX7z+BirkA3VAfW@zx2c4.com> <CAK8P3a3Af5FBx-OnedHPrf28ikX4DZK1d0ERLsV+oKyBHyCXiw@mail.gmail.com>
 <YmaJUvg6hmekvkXE@zx2c4.com> <CAK8P3a3FZeXzBJKyTEvmvw_DaHGQFf5rQKs=_wBW=GZ2+=rJ_Q@mail.gmail.com>
 <Yma8OQ3zY3PzY87T@zx2c4.com> <CAK8P3a0Y3BFCkg8e-o5i6xPfb9WVQzOQOACXtrH1VmQJkSriDQ@mail.gmail.com>
 <YmbD/oPIUBvJ/YjQ@zx2c4.com>
In-Reply-To: <YmbD/oPIUBvJ/YjQ@zx2c4.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 25 Apr 2022 18:15:07 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1kRXQrmNg4eQw0-P+Fzz_AvFooLg3=nQNQKMRwvL9DWQ@mail.gmail.com>
Message-ID: <CAK8P3a1kRXQrmNg4eQw0-P+Fzz_AvFooLg3=nQNQKMRwvL9DWQ@mail.gmail.com>
Subject: Re: odd endianness toolchains for crosstool
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:O/OUP1vEVjc9+lC7sva0JxhpQNSFaB0qEirHr6aeblsoKOoBWFG
 qJ7pq1hn92j1z64GL3YueZmTqV4KeW3D6gBEuCgjh1/CGchYuiONVOPL7D/1wX3g3G9OYMq
 GXENEZhogJsdLmwpkVBCQhqChJ+1dsp0LAlgDNxlaSF14Cu+2WLMiYJErxIQmpImE5KYih7
 /d4VAj6K+MBr/AVvPhFxw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HRvfMhG95Iw=:EBuV31D5CRsf3eaWDT5mys
 Qs10xNe24GwGIHImN9eBosYZc+UQgbxBsU7JDy6Xq3WIUmfKldjyP1OB6nkdWeU6AjhmF0GtO
 k4Vse7IRuo3haAmypg4T9Xq4/X5BCpiZvA7N5+19Di6FaTCmdi+PSToAczL8WyUGQdmQ/6Kvb
 2nTF5C/U+CAzClKHF78Io2DKbrHlXSDbhAQaHbs/IkPlrRHpzl7MppClZMND2hyD8o+8QVIle
 tnMMHMz6SBLwaw1RygHVnYkzOiASN+jZA1u6G4btq+isfbo5RDGo2hZvgHRomQ7axZjVvpKhX
 leNYX5/eHvCOKA4Bga8zd+/ZFlb8a1PPstUOghyZk41p4U0+RhpqNcXwX7NfbPe1EMrxZO1Q+
 d6pqvoRTzHwHVfAZhdttGdcennJH5uGLeoVCFydm/qD6K1LLfo2qyW4fn98GCcSfzlDWM/+X+
 oiTtOkf/YMDs6pVvYpEU/w/asCmGW82xgdWqilU8kFWJh+eqH5hV8ypOUJOdyZp4dzF1UcCul
 viKmkRQNAoUpJmjbIWoRESH0bgThvsTdmUfPWybUGfSYCetWuGdRqBZxSbB1yU6CbJF4045Ck
 eYtKpSwILPUcvhOHIbtyMqvGlyAUQ8IFbEEQkFRlUjJXhxukFoOl/xpEpWysOHNoQIKF1BRhZ
 AKx8BZVJQB3wI639oTsrQG+O3mwWl4E1fWwQMcM+D0CPpEEnkXJIiM+o/FHwKb/JrOPmHKyhe
 VXoU+i2hBhBsP2yAwKsbbGIz4qugoPNXuXQwi2P3FfwG/eUuo6h9eIF+WvkDQ+cOvgWoAHDox
 zHXiiUKL9pM1eEg94g1zSz9dbBXcuaJLh1wEEFrFy6jIZj9h3g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 5:53 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi Arnd,
>
> On Mon, Apr 25, 2022 at 05:39:34PM +0200, Arnd Bergmann wrote:
> > I can probably do that before migrating to the new machine, but I can't
> > promise how quickly I find time to start.
>
> Oh awesome. Will keep my eye out for it.
>
> > > (And also, build ppc32 with --enable-secureplt --with-long-double-64.)
> >
> > Can you explain what those are about? Is this related to the ELFv1
> > vs ELFv2 difference or something else? Is this needed in both the
> > ppc32 and ppc64 compilers that each come with both targets?
>
> For 32-bit, it is required. From
> <https://wiki.musl-libc.org/supported-platforms.html>:
>
>     powerpc (needs gcc built with --enable-secureplt
>     --with-long-double-64, and -Wl,--secure-plt to link dynamic
>     binaries.)
>
> And from the INSTALL file it says:
>
>     * PowerPC
>         * Compiler toolchain must provide 64-bit long double, not IBM
>           double-double or IEEE quad
>         * For dynamic linking, compiler toolchain must be configured for
>           "secure PLT" variant
>
> For 64-bit, I'm not sure, but I know that at least -mabi=elfv2 is required,
> and I think --with-long-double-64 too, according to documentation:
>
>     * PowerPC64
>         * Both little and big endian variants are supported
>         * Compiler toolchain must provide 64-bit long double, not IBM
>           double-double or IEEE quad
>         * Compiler toolchain must use the new (ELFv2) ABI regardless of
>           whether it is for little or big endian

Ok, I see. For all I can tell, the toolchain I built already uses both
--with-long-double-64
and --enable-secureplt, as those seemt to be the default for Linux.

Regarding the the ELF ABI, I'm not sure how to check, but I think it
only does ELFv1, which is the default for big-endian glibc.

       Arnd
