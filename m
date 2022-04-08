Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5218B4F9607
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 14:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235861AbiDHMrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 08:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235881AbiDHMri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:47:38 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6D7EEA40
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 05:45:33 -0700 (PDT)
Received: from mail-wm1-f43.google.com ([209.85.128.43]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MtObA-1nyRfu0DN8-00urKi for <linux-kernel@vger.kernel.org>; Fri, 08 Apr
 2022 14:45:32 +0200
Received: by mail-wm1-f43.google.com with SMTP id 6-20020a1c0206000000b0038ccb70e239so781168wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 05:45:32 -0700 (PDT)
X-Gm-Message-State: AOAM5325HcmGVDKjtFbptWfwQqdJw+/87i3tQvvVwU6HDyze5PkjQlbi
        JVxHbJVxUpQbS/PY1FItBllRtMbqFlbSQVTOeYQ=
X-Google-Smtp-Source: ABdhPJxps0BbqmqQapLlX3jbuXr3VTji/74gKNC23l150Hopu0GL33hA46x2VnYvSJ01+W8ylqjUTYUcGdzoO1ES9lI=
X-Received: by 2002:a05:600c:4ecc:b0:38e:354d:909 with SMTP id
 g12-20020a05600c4ecc00b0038e354d0909mr17232206wmq.33.1649421931666; Fri, 08
 Apr 2022 05:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <202204081729.f4cgbHob-lkp@intel.com>
In-Reply-To: <202204081729.f4cgbHob-lkp@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 8 Apr 2022 14:45:15 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2EDu20VNze0r4F6VQ6uxqCYQGo-Dcta6THFqPuyJ81uw@mail.gmail.com>
Message-ID: <CAK8P3a2EDu20VNze0r4F6VQ6uxqCYQGo-Dcta6THFqPuyJ81uw@mail.gmail.com>
Subject: Re: drivers/pinctrl/cirrus/pinctrl-lochnagar.c:200:1: error: implicit
 declaration of function 'LOCHNAGAR1_' is invalid in C99
To:     kernel test robot <lkp@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alex Shi <alexs@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:M+oB5SBw1RjFlPJKC2gsuHtyBb5HK4l7iiCDYIisBzKolUOykHd
 10qB7jS27PvUd+iRIWLyYGAJtSGUVmEKGolle3dubGVa/oPR8yRvdNjk4x8U3aFb27Stzn6
 CpQspcc4G8q7H1u529FcMLjDIkZqB9kXUTT9S/vmAmRSKzO+C9Fp7bkWdPEDZXydaTh3Ks1
 cXvaXBh7LiSbF17CQLF/Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:20rhF2aNv5E=:ONO3x+ZSWHIUUO3E7kxyEL
 RoCLLSijzNiSF1mXJdDb8ntVKRgyZkM6fyybJaIKjFeJA+fk9p1y5dS4iRR4jMuB1FBbRTLuj
 8D/+YYRQPyrmcQfI33d4oEu7P2JKb0wKFfqT97dnmk43/amyWF5p94WlcumojF7SZN5R/84cD
 TmYOHB6AgKOR9QASHwX8nQRxpO95wEG5fxEF5Y3KLokCyvcpFZj7ZT4gjqpSRg6kOOFCWNh76
 OX5kYvyF5A09AjPexA+hBp9NyXwHgAhQYQXiGqNLwuJskC/NINCyglx084B8Ygmp/xZ2WUsrE
 A1Z2c4CeqN01paTqtPRT95QiKe0OvtCdrQrOmg03VJPwDEPz9kOCzAWmya6P61SbTVc58wDb6
 /+ysjMM7LY9RlDbPXUt7IqSRDUixOh1TKEAxUV6RbxJbB1bSPmCk5gL/OEFoqkELPEqp1qgoa
 WYTSWom+FMA2s5utukORvJ9XooBcxqtscxwgCqPO1c+fsGquff7C10b8JLB777aCA80Lvmvdj
 SLccTwMXIm57hgx5oJ3nKJlA02k+z15E+3Ph9TrlkKU2lJhZnI6bhUyRNygB1aoEHAi81bBeI
 XtFasLBf/vVtdo+4nFgAmw7vutIdEs7X/SEeA++bY5YRjgUuqV7C7CHDam9nha7ZqC/WEnLEt
 sQ4bCZE2gi/nis0vDkr8c+S10m+xfo/D99ppu9tubaaSspzxhSdMEQsApE4NETyw3f+c=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 8, 2022 at 12:02 PM kernel test robot <lkp@intel.com> wrote:
> All errors (new ones prefixed by >>):
>
>    drivers/pinctrl/cirrus/pinctrl-lochnagar.c:200:1: error: pasting formed 'LOCHNAGAR1_(', an invalid preprocessing token
>    LN1_PIN_GPIO(CDC_RESET,    "codec-reset",    RST,      CDC_RESET,    1);
>    ^
>    drivers/pinctrl/cirrus/pinctrl-lochnagar.c:67:2: note: expanded from macro 'LN1_PIN_GPIO'
>            LN_PIN_GPIO(1, ID, NAME, REG, SHIFT, INVERT)
>            ^
>    drivers/pinctrl/cirrus/pinctrl-lochnagar.c:52:63: note: expanded from macro 'LN_PIN_GPIO'
>            .name = NAME, .type = LN_PTYPE_GPIO, .reg = LOCHNAGAR##REV##_##REG, \
>                                                                         ^
> >> drivers/pinctrl/cirrus/pinctrl-lochnagar.c:200:1: error: implicit declaration of function 'LOCHNAGAR1_' is invalid in C99 [-Werror,-Wimplicit-function-declaration]

I have checked this one, and it looks like this is not a regression.
lkp flags it because the error
message changed: with --std=gnu89, the output was

rivers/pinctrl/cirrus/pinctrl-lochnagar.c:200:1: error: implicit
declaration of function 'LOCHNAGAR1_' is invalid in C99
[-Werror,-Wimplicit-function-declaration]

The problem is unrelated to my patch, apparently the global macro named 'RES'
on this platform gets in the way, and removing it fixes the build:

--- a/arch/mips/include/asm/mach-rc32434/rb.h
+++ b/arch/mips/include/asm/mach-rc32434/rb.h
@@ -10,7 +10,6 @@
 #define REGBASE                0x18000000
 #define IDT434_REG_BASE ((volatile void *) KSEG1ADDR(REGBASE))
 #define UART0BASE      0x58000
-#define RST            (1 << 15)
 #define DEV0BASE       0x010000
 #define DEV0MASK       0x010004
 #define DEV0C          0x010008

        Arnd
