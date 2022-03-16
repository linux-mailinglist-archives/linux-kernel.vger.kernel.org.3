Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E744DAFD6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 13:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355710AbiCPMkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 08:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355682AbiCPMkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 08:40:04 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C5E5DA71
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 05:38:49 -0700 (PDT)
Received: from mail-wr1-f47.google.com ([209.85.221.47]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N7zRz-1o89FU2NqF-0155A2 for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022
 13:38:47 +0100
Received: by mail-wr1-f47.google.com with SMTP id t11so2795904wrm.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 05:38:47 -0700 (PDT)
X-Gm-Message-State: AOAM531wIp8qG8Spq8RuPpZ2vzDJ0LhjUegm+j9BAyp8qOQrl69eMgf8
        pmtR/M0sFibYLBNeDWUK/1P2YBwpDyvZ2fr/vgM=
X-Google-Smtp-Source: ABdhPJxIUOCgiM7AIhMu15LEZH0iIvtFFRbEf5sgU8mJSdVsTjvyXuQod13tXy4f2e+DRiEpPlmQX01r6aZ/K9/C+EU=
X-Received: by 2002:adf:f606:0:b0:203:8dff:f4ac with SMTP id
 t6-20020adff606000000b002038dfff4acmr21616253wrp.12.1647434327191; Wed, 16
 Mar 2022 05:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <4c449fab-8135-5057-7d2c-7b948ce130cc@theinnocuous.com>
 <0b31b1d3-852d-6cab-82ae-5eecaec05679@theinnocuous.com> <202203151150.1CDB1D8DA@keescook>
 <bfbd9394-161b-0e70-00c5-79d0dd722e08@theinnocuous.com>
In-Reply-To: <bfbd9394-161b-0e70-00c5-79d0dd722e08@theinnocuous.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 16 Mar 2022 13:38:31 +0100
X-Gmail-Original-Message-ID: <CAK8P3a28dpyEM2+vM+ePZzeFc539b7w_8FDEoRke-j+3AQVZAA@mail.gmail.com>
Message-ID: <CAK8P3a28dpyEM2+vM+ePZzeFc539b7w_8FDEoRke-j+3AQVZAA@mail.gmail.com>
Subject: Re: [PATCH] x86: Remove a.out support
To:     James Jones <linux@theinnocuous.com>,
        Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:pf0qj805fGEiZiabT3YKBUNx+RSWSx5k7Gfoo17W26Yl3VvSdEk
 ScGXbmSRkMCR75OuGeowoXViiHzK+rMqV+vRIyJM+/0gSSKxdigvirblJ2Xjxb+6BWLtJ9U
 1Z+SklEWvdXdfQSNR3haSJcY6rO+eJ+/+TU3jJAPmtcxKtwvdcRlaU8nMpd8LVT3stL9WsN
 igJpv8BumyacuRkIDL0cw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oxcjxeQhLFE=:onE/TAh70/BHTU1XjSTgF3
 4te12pJ0e2Q8my9GzMbX3P3C7Vptjhnh411ubbbPHAdfom6Z0rF9YZI7TSsJpp/FkRieIeBVi
 r9OWojEpJ2HKdJBq6/tl4bdnob1x0wRqIdKHG8bQ8yr35gId5NpHWfIMhqS9XTfeQJ+XN6F0F
 cSS9uy9zRISVMjvUr4Dqppdj2/9OHBUGnVgcd+pOraQ9KJOYCFyq/oQxtk3p5gHquolxFsgPK
 y/ZcFwey4J5gSyQ4LzNqgwEZkGj7BzAbZf7ZOctBig+3l6fD2gh3nC/sf4xUJ/17vYIIQln53
 egCMXjaJOr4tzo/xIwI9o7z45AAObQzHiIxqqN80lws6W20gV+c2t8QOt1PkHwWMZB+VZTolw
 ePM4897540Qu6qbWRdlEkxCRp5iww203QostYFUlz2odqSAX64+4XVfJtLNZ9VHbTN2awu7bc
 S90gCRbXr7fw//eFV12vvXxjpe/fOY9IkCF8gZpV1aJ0B0sIVZjwDXcNYN4C7xbYPWglRdoay
 ci1IVsM8WD6oFxSQCn+5eoaIqi2DCH3kpltgw12hJz+j4rY6QRkj8h0d9AJc8rKTbrwb7HTvW
 iHHZ/b9EjjOPtF4hm+Q+gQx+56bXLEiZKH06s6JY284+bdBeqUcfKB4B7AJdkDc42IcgHWutD
 3hMB+eEINnwTthhvx3hu6L9dhPBVlYHSbr2U/qloAEsLTruuj4N9oxyN4fLRdu7wHo3cUbRDz
 829ubAqm9iep30b8lJb62xWe2IY56qXShYFOJ/vKvguDls5BNwzg32i9zf1yltK0iy+o7VDhS
 xUOomF3phAa5beUTj+XZgHpbwoXtWi3nQg+CgucecH452SY1sE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 James Jones <linux@theinnocuous.com> wrote:
> On 3/15/22 12:51 PM, Kees Cook wrote:
>
> Probably getting a bit off topic, but I did spend a few hours searching
> around for any existing tools to convert a binary from a.out->ELF, and
> trying to come up with something myself by extracting the sections with
> objdump and re-combining them into an ELF using a linker script placing
> the sections at the same locations. I couldn't get it working in an
> evening or two messing with it so I moved on, but I agree something like
> this seems possible in theory. I got 'mac' converted to an ELF that
> would load up and print its input prompt if run without parameters, but
> only if run as root. As a regular user, it segfaults somewhere before it
> even starts executing in the text section AFAICT. Any actual assembling
> segfaults even when running as root. I never got 'aln' to do anything
> but segfault.
>
> I dug the scripts up in the state they were in when I gave up (September
> 2020 according to mtime), and put them on github in case anyone wants to
> have a go at it:
>
> https://github.com/cubanismo/aout-to-elf/
>
> It was an interesting problem in its own right, and I'd be curious to
> know what I missed.

I noticed that qemu-user has code to run the two other native binary
formats (elf and flat) that the kernel supports, in
https://github.com/qemu/qemu/blob/master/linux-user/linuxload.c

The qemu code is fairly close to the kernel version it is derived
from, and the a.out loader in the kernel is the simplest of those.

If performance is not overly important, I think it should be possible
to turn the Linux binfmt_aout.c code into something that works
in qemu, allowing you to run these executables through CPU
emulation on any architecture. No idea how much work this
is in the end, but it's likely easier than a standalone a.out loader
in user space, or a conversion to ELF format.

       Arnd
