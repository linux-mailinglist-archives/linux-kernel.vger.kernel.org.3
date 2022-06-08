Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1EA85427D6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242637AbiFHHT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243599AbiFHHNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 03:13:11 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40D71D6856
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 23:54:30 -0700 (PDT)
Received: from mail-oi1-f181.google.com ([209.85.167.181]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M3D7V-1o2PQE3x53-003coO for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022
 08:54:28 +0200
Received: by mail-oi1-f181.google.com with SMTP id s124so8816471oia.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 23:54:27 -0700 (PDT)
X-Gm-Message-State: AOAM533vfjW8JN2/4c/GZi6UABWtj1ZDGwWw8VIgfVdybP5LEOVbObnp
        8tDZqnGI+n8wQTTN95MLL4yIooeQFWuaPB9Pfi8=
X-Google-Smtp-Source: ABdhPJxtc+XXcM8lboPd0HxoO4C4pSgZz+o+2cydLY3T5VirSX+BmYIrJ5qFsX5R6uVftrDQIMIjbwfJ9FBTtFXxwBI=
X-Received: by 2002:a05:6808:1a2a:b0:32e:a1bd:368c with SMTP id
 bk42-20020a0568081a2a00b0032ea1bd368cmr1534573oib.155.1654671266622; Tue, 07
 Jun 2022 23:54:26 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYts-KH-R5EkBpz2u6H_Cx6YTXus1JKJS6yBxGhb0O2qQQ@mail.gmail.com>
 <CAK8P3a3QKWxqGore3+_DJnWo7bJgvDhkZjtkyg5EUg4_D=mE2w@mail.gmail.com> <Yp3L0JgLpk+s54Lw@FVFF77S0Q05N>
In-Reply-To: <Yp3L0JgLpk+s54Lw@FVFF77S0Q05N>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 8 Jun 2022 08:54:10 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3X0UwQiVNZqvGmSKi8BX6zg=k07+9Q3rDGqHVkc8Hdsg@mail.gmail.com>
Message-ID: <CAK8P3a3X0UwQiVNZqvGmSKi8BX6zg=k07+9Q3rDGqHVkc8Hdsg@mail.gmail.com>
Subject: Re: gcc-12: build errors: arch/arm64/kernel/setup.c:225:56: warning:
 array subscript -1 is outside array bounds of 'char[]' [-Warray-bounds]
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Donnelly <john.p.donnelly@oracle.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ma4MyCrdhNIkTaOVHzOZgalHTqUzDGyAhYkdorxhWWyYveBAMKb
 g4/nXn//HWbx9XwXoPLenSh/Q3ogpJizXW5soKu1SebWoaj67e5M4vIpC/mY0LGfh4jLibo
 nlSh6Gd2wqbXJQbIk7HpIfy3Psu57RUsDo5kEeS8c+LRG4XSDNYoGIKAE+Rtt3UuYWEDg5W
 oUlk44I7jX4fNB7cOvprA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ig7gyeGTN9M=:xrWCPstBqkJJ1BybuzC5js
 u93zUMRz1yPpSdQswKkghFRx4Db9HZHacA6vGmLCn5gGVIqWb0AtERBwT8+GibaBNlfSIe8aX
 9ZHcOudybs9d1B4dMYffx4+/VTzFqBbmEY7LjBHhjxwqUDdhJAPPs6dtFMQhq04HeYt/wAVcT
 9o8iVuAoEEQnaEznKEjNnt2S3UYSW+mIQ0xHg7hMKufU7Ot5g3EsgqcrVbrJzOZx0P+jbcXwu
 8gDPRRy+ZOMG48CS1M7j5hUeerV9eThaoc5g2iREEeCojHy5XnFxIPq7B9CT8SQg/8lYYhZdQ
 K7UrT517mFcsh/zdB5hzvbvWt7PjK0EZfoNetANbXv4MbMj8Y6O1a56lxACBTC1/qGpc/yPPM
 zjvbz5ftvjDS7kmbpZeapUelsYiEFZwTPS8l7KowwjwaKFEC0K5MEcTQazTyotJrZPN8sLLjT
 K/g6cfdg9923sTEqIctWDuNAW5rgl/m67X0ZA1wb+VZaqlfPcnLkxIHQFz2BR+QraqYBb8HEQ
 Zg/hoH3Uwlqd8fcJlXjoQrDpv0j/0OpN1pXrNebGYm9pelfL/Lb+3q3cLoFko9a5LotgXtFlW
 9BNcBMY+c0QrvRj456s59WamT79GhJ/c+sZQ7FVH9ZQQ+OhJ4SgPZ9SkL9o42c0YJ68a+r8hM
 CNV3g7QYtMDO1VMrd0WxJo8ogKu0sBCJr28dnOYQJxOJnv3dCbaTCDmX3ihNqwcefk+gK9ggl
 frje1z7zLiVwi+2zZM8Spi3WqtCzjVYJleG8gDhZwD46t3x1n5fvGfhJsrjg7yItwhfjvZehr
 2vdcw3MxUzgzIC0w3tZPX8lMVjaHXhfS8nlmZrJNCG0VtQlytcVee+zBgw+dSDCRPuYGQTUyI
 +xheuLq1IBQGStPCr4OQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 6, 2022 at 11:41 AM Mark Rutland <mark.rutland@arm.com> wrote:
> On Fri, Jun 03, 2022 at 09:40:07AM +0200, Arnd Bergmann wrote:
>
>         #define va_init_begin() RELOC_HIDE((unsigned long)__init_begin)
>
> ... which'd be a pain, but at least it'd solve this generally.
>
> > I think the easy fix would be to reword this line to
> >
> >        kernel_code.end     = __pa_symbol(__init_begin) - 1;
> >
>
> I agree that'd work for the __pa_symbol() cases.
>
> For consistency it might be worth using RELOC_HIDE(), e.g.
>
>         kernel_code.end     = __pa_symbol(RELOC_HIDE(__init_begin)) - 1);
>asm-gener
> ... which IIUC should do the trick.
>

I see we have similar logic on each architecture, and they probably
all have the same
issue now, so maybe we can just do a helper function in include/linux/ioport.h
(which has all the struct resource logic) that can be called like

resource_set_pa(&kernel_code, _stext, __init_begin);
resource_set_pa(&kernel_data, _sdata, _end);

      Arnd
