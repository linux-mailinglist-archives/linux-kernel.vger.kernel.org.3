Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D264FB5CC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 10:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbiDKITl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343657AbiDKITg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:19:36 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071BA3E0FA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 01:17:20 -0700 (PDT)
Received: from mail-wm1-f53.google.com ([209.85.128.53]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MeD1l-1oD9z72Fkt-00bGwg for <linux-kernel@vger.kernel.org>; Mon, 11 Apr
 2022 10:17:18 +0200
Received: by mail-wm1-f53.google.com with SMTP id 123-20020a1c1981000000b0038b3616a71aso9483677wmz.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 01:17:18 -0700 (PDT)
X-Gm-Message-State: AOAM533Zc+Z/UJDUQmYl1gBJgaVCZAT2IcgOwFlJUwqd+bpmDstf6H02
        OE3N702pA4O1OOxx/XgXXxA9/TOuHsgez8uFinQ=
X-Google-Smtp-Source: ABdhPJy8pZ33Oo4WMqzog99X6GEoaGOwT8j6RrqVFPFQMKNLVzUDT5uefzJG9yX4chyyPY6S/2CLyUh5Dj13t8S9ykA=
X-Received: by 2002:a05:600c:4e11:b0:38c:bd19:e72c with SMTP id
 b17-20020a05600c4e1100b0038cbd19e72cmr28194884wmq.174.1649665038229; Mon, 11
 Apr 2022 01:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220410161035.592-1-rdunlap@infradead.org>
In-Reply-To: <20220410161035.592-1-rdunlap@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 Apr 2022 10:17:02 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2FXx8MmqW=gdYVBHWa6yRUATPX442RmGi04tW7-jj_fw@mail.gmail.com>
Message-ID: <CAK8P3a2FXx8MmqW=gdYVBHWa6yRUATPX442RmGi04tW7-jj_fw@mail.gmail.com>
Subject: Re: [PATCH v2] macintosh: via-pmu and via-cuda need RTC_LIB
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Finn Thain <fthain@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:iErLvfQOPsdVvIiMd7XvqdvWo3oV0ogxvNjr0nJDpfp25KEhrgk
 euIL9kCgZV6t3MXobQgA+uFCInQ79Wn85Ynv31RwfXdOno4supiHMXKtzHWW1e1jZj92GYL
 pE6GukqDzQhSxkeyNnUZlPeWbVC5ilmBapVSj7WXwiN4eXKV3/UOKGzeDu8J/ipYVpBoomw
 3HdnDpIl19d7FOq36Un6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EggSCU7wdqE=:RSAyPbVmRZDNrQaNdKFB+9
 4GvSvG9Q8tkMFt937fmA9WiaNjV7ZTz87uWjx2YKdmUAw8EaWXG0MZhKqvA2qvA/DRzp0lUxK
 PtByK+h4Uq7/XLdxZ3IhLydvPdGFLUlxcwJ24WCMmfXbJwylRNg8an0JkI8PL9HvqqzKoNt5G
 NBBFDfqkU4lfbqVZ7IEAX3zZ+AloD7tn+66CE9CeHZRc+MpygxdK1LmDv89nHFfEAofZRz563
 5PJ5TWjmoZ4/fiWgpsGyPUvtaR1Ry0xg0TQ43rtmr/+SFL6973krE/yd675cnyMrz4I5jsCMK
 XhkQxw+KtlE/guc61C1Y3WEA3cSwQZGhmiRbgGhmcz/fU1AFpfsUpRI62S6wFKKdDi2vWPVNl
 i14hjcswxEZK2n2FZ1Kl5z+oHON7FHq31HiOqZgZ7qs7jPhtwWJ9Jgv3Q9N9h4a/YPxdAE1qk
 STU8XI+9mUz3K7w/skRSp1sbinBr9v3/lrXPWbY5DhDb847J2JQfaeID3Sy7fW02ZdHCUsnSc
 Y3lPVts6gyqq+16O28fHsN/eEVx3rmgWhFCQbh81fn4HysWOEjLZfi8YMqxLg/sviQcFTsv2X
 XXCeWDGggvYfwDHZnwl1ZAFobsSZ80qGxEIwS29W2KuT3vHmgK9pjYUyaXbDw3Lz6i+DWRB4b
 4j0Gi8YU8qvnJzUzxxT8sMwSxIRvTwoPmigPClrguoaXVUCE/O30ANdGHCOKmPaItlUk=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2022 at 6:10 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Fix build when RTC_LIB is not set/enabled.
> Eliminates these build errors:
>
> m68k-linux-ld: drivers/macintosh/via-pmu.o: in function `pmu_set_rtc_time':
> drivers/macintosh/via-pmu.c:1769: undefined reference to `rtc_tm_to_time64'
> m68k-linux-ld: drivers/macintosh/via-cuda.o: in function `cuda_set_rtc_time':
> drivers/macintosh/via-cuda.c:797: undefined reference to `rtc_tm_to_time64'
>
> Fixes: 0792a2c8e0bb ("macintosh: Use common code to access RTC")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Finn Thain <fthain@linux-m68k.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
> v2: use RTC_LIB instead of open-coding the call to rtc_tm_to_time64()

This sounds like a step in the right direction. Note that there is
another open-coded rtc_tm_to_time64() in read_persistent_clock64(),
it might be worth changing that one as well and just always including
RTC_LIB, though that's a separate issue.

Acked-by: Arnd Bergmann <arnd@arndb.de>

> --- a/drivers/macintosh/Kconfig
> +++ b/drivers/macintosh/Kconfig
> @@ -44,6 +44,7 @@ config ADB_IOP
>  config ADB_CUDA
>         bool "Support for Cuda/Egret based Macs and PowerMacs"
>         depends on (ADB || PPC_PMAC) && !PPC_PMAC64
> +       select RTC_LIB
>         help
>           This provides support for Cuda/Egret based Macintosh and
>           Power Macintosh systems. This includes most m68k based Macs,
> @@ -57,6 +58,7 @@ config ADB_CUDA
>  config ADB_PMU
>         bool "Support for PMU based PowerMacs and PowerBooks"
>         depends on PPC_PMAC || MAC
> +       select RTC_LIB
>         help
>           On PowerBooks, iBooks, and recent iMacs and Power Macintoshes, the
>           PMU is an embedded microprocessor whose primary function is to

I think ideally these would just become regular RTC drivers, rather than
relying on the roundtrip through CONFIG_RTC_DRV_GENERIC.

        Arnd
