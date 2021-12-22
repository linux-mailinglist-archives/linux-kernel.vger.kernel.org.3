Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82E047D115
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 12:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244706AbhLVLe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 06:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244700AbhLVLe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 06:34:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E296FC061574;
        Wed, 22 Dec 2021 03:34:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6EA2FB81B9C;
        Wed, 22 Dec 2021 11:34:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA0FC36AF2;
        Wed, 22 Dec 2021 11:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640172865;
        bh=Fi3+odhuzWqyoIOsS4HSOvfce+S3ltBSyG1ZwqaAFn4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=foAIuKLE8FYEQkEdzpCYiOLK6T3NsAXvweIXkdoDP0AQlA60YQUvNdKHX73qrQ3+r
         3XligsoacZsbDkGcOGekamcCtPfav66NAXrDCoULGRo82yGsLOHSJYAxjWCLn2SPXA
         OtakQV2IKdorX1Ylu9I8F+GL8ghaCuG628jLZnkh7Ha61yr8t+djNhMQfvp7LUlTQ5
         YwIbePOX9xbXYfhteuHkueGTVY9h0lIwXnA17yNfiUl4As4v1pCY5ttgTt+wgYHXwR
         PaYEYquR3xiuYBaDsuXzYCy8zl1INANPsJ1kJMgaUzu13UzLIie9QccZJyb6hPm6EO
         cN/OhiqistNUQ==
Received: by mail-vk1-f170.google.com with SMTP id g65so1125605vkf.4;
        Wed, 22 Dec 2021 03:34:25 -0800 (PST)
X-Gm-Message-State: AOAM531QTVf+BggOjgPwsZ592gf2XhCNbTK0YJ54EfN5a6gybclWsVY5
        u1NJKtk45rIsZgqLN9O7sQxXOin/78ZxUTCy1xc=
X-Google-Smtp-Source: ABdhPJxWEYRFXCwuHnukSTxHmYrUUDGyLCBZ+l40ti0zYBeaZ5biPhi2e3rHjJN/vnHepBjKUq7jC8D3B0E33xwBH1o=
X-Received: by 2002:a05:6122:a17:: with SMTP id 23mr853099vkn.8.1640172864086;
 Wed, 22 Dec 2021 03:34:24 -0800 (PST)
MIME-Version: 1.0
References: <20211221163532.2636028-1-guoren@kernel.org> <20211221163532.2636028-3-guoren@kernel.org>
 <CAK8P3a3dS=Ne0Pd2qZc8vB2whM7AUcJ1BNbhtf6EEboWAPpSug@mail.gmail.com>
In-Reply-To: <CAK8P3a3dS=Ne0Pd2qZc8vB2whM7AUcJ1BNbhtf6EEboWAPpSug@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 22 Dec 2021 19:34:13 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTN1HZeycK-WOFH0EjmjtBB4T=9de6Qrjs=uhAsLoOFaQ@mail.gmail.com>
Message-ID: <CAJF2gTTN1HZeycK-WOFH0EjmjtBB4T=9de6Qrjs=uhAsLoOFaQ@mail.gmail.com>
Subject: Re: [PATCH 02/13] riscv: Fixup difference with defconfig
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup.patel@wdc.com>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 1:09 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Dec 21, 2021 at 5:35 PM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Let's follow the origin patch's spirit.
> >
> > The only difference between rv32_defconfig and defconfig is that
> > rv32_defconfig has  CONFIG_ARCH_RV32I=y.
> >
> > This is helpful to compare rv64-compat-rv32 v.s. rv32-linux.
> >
>
> If the intention is to keep them in sync, maybe use a fragment for 32-bit
> mode, like powerpc or mips do.
>
>       Arnd

Some people are familiar with "make rv32_defconfig". There has a
32-bit.config fragment config in arch/riscv/configs/.

I've tested with:

make ARCH=riscv CROSS_COMPILE=riscv32-buildroot-linux-gnu-
EXTRA_CFLAGS+=-g O=../build-rv32/ defconfig 32-bit.config

The above is tested Okay, do you mean we should delete rv32_defconfig?
I think it's another topic, I just want them the same in "compat"
patchset.

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
