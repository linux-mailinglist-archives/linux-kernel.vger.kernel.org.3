Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1F55800D6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 16:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235680AbiGYOgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 10:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235198AbiGYOgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 10:36:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC2013E1D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 07:35:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A5DAB80EC9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:35:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D6EC341C6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658759757;
        bh=8YAdK42qqbqAY64DK1NyJcyaeYoywJhEGa74ocjFyLA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=btmw0M+imuPsrJudphHVgl7R5KvTrbEm28wzpuVk3F0cQIhNNUjN+1JOZ9Yv+67lT
         WVWiBI93japOYL4GqvbJDuXkGYeIg2KHNI3XfaXad/6KO/4HAK36gg8JVV7Fifez/t
         J/fEk/EiOBun08qB8Hj6xhqxUR/YwepMSI11is4AOGsyXDrrwlchLKQZsFH4co43a5
         53cYs59EmilqGnMzfcFuQZ0FWOBeK+9oDe4LjEh/ENb6+eRQJ7m7JBaPJXHy91fQoH
         Vz+94V9jAmIaJg2aBuk6FEN/NY4Dm5h5YHa0VvFjGuz01vU2S+tY3rG64Afl16hqfN
         TRcUHMazQR0aQ==
Received: by mail-ed1-f49.google.com with SMTP id z22so14209181edd.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 07:35:56 -0700 (PDT)
X-Gm-Message-State: AJIora8oAkwerls15vcX3Z6o4rzCz2ahzK3h3PlSgBqpJekwkPYLkHlI
        ksuDAuA3MX5X/3cS/cEOecZeYxxGrdC4EfQmR2k=
X-Google-Smtp-Source: AGRyM1sUthx3LrE7tgfM/0y9QOiYr2frDpjwJn/EPcg19s7vbWCnJqX8iKP+C/w78ap34jT38fFq4Y6IBIu4zH1epFs=
X-Received: by 2002:a05:6402:1003:b0:43a:75d8:a0e with SMTP id
 c3-20020a056402100300b0043a75d80a0emr13537599edu.303.1658759755306; Mon, 25
 Jul 2022 07:35:55 -0700 (PDT)
MIME-Version: 1.0
References: <202207250449.BYMZbIA2-lkp@intel.com> <Yt3KObFVIUI2mFGt@zx2c4.com>
 <CAMj1kXHTf4f+onREnWhYk-vYXkPaQtPpZz+SqFCP+Ey7+bOXkQ@mail.gmail.com>
 <Yt5Y/cIKIDlyFWMQ@kroah.com> <CAMj1kXGPjFAY0y-SPZv64CRhpo9s1+__z4bya86aMcTs9=f8pw@mail.gmail.com>
 <CAK8P3a0g4NT1oDW5gq7YO540Eo0UDoqbK1tmtb8QHteiDNXj5Q@mail.gmail.com>
In-Reply-To: <CAK8P3a0g4NT1oDW5gq7YO540Eo0UDoqbK1tmtb8QHteiDNXj5Q@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 25 Jul 2022 16:35:38 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2ZfEr+4OWWteZHpDYGw8U0dQgMfF_OFwQDEtY=GaTfQA@mail.gmail.com>
Message-ID: <CAK8P3a2ZfEr+4OWWteZHpDYGw8U0dQgMfF_OFwQDEtY=GaTfQA@mail.gmail.com>
Subject: Re: [linux-stable-rc:linux-5.15.y 6874/8723] arch/arm/lib/xor-neon.c:30:2:
 warning: This code requires at least version 4.6 of GCC
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        kernel test robot <lkp@intel.com>,
        "Justin M. Forbes" <jforbes@fedoraproject.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Jason A. Donenfeld" <zx2c4@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 2:55 PM Arnd Bergmann <arnd@kernel.org> wrote:

> The other easy workaround would be to just turn off the xor-neon code
> when building with clang, e.g. using this Makefile hack:
>
> diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> index 6d2ba454f25b..8e4fe6421dd2 100644
> --- a/arch/arm/lib/Makefile
> +++ b/arch/arm/lib/Makefile
> @@ -43,8 +43,10 @@ endif
>  $(obj)/csumpartialcopy.o:      $(obj)/csumpartialcopygeneric.S
>  $(obj)/csumpartialcopyuser.o:  $(obj)/csumpartialcopygeneric.S
>
> +ifdef CONFIG_CC_IS_CLANG
>  ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
>    NEON_FLAGS                   := -march=armv7-a -mfloat-abi=softfp -mfpu=neon
>    CFLAGS_xor-neon.o            += $(NEON_FLAGS)
>    obj-$(CONFIG_XOR_BLOCKS)     += xor-neon.o
>  endif
> +endif

Nevermind, this does not actually work. Just turning off the warning
is probably best then, as actually disabling this code would still
be invasive not do much beyond saving a little bit of kernel .text size.

        Arnd
