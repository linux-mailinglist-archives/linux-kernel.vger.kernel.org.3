Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4FC4DB0CC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 14:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356176AbiCPNPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 09:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356136AbiCPNP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:15:26 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF06D30F52
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 06:14:10 -0700 (PDT)
Received: from mail-wm1-f52.google.com ([209.85.128.52]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MvazO-1oMiUZ0sWk-00seZp for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022
 14:14:09 +0100
Received: by mail-wm1-f52.google.com with SMTP id v130-20020a1cac88000000b00389d0a5c511so3181121wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 06:14:09 -0700 (PDT)
X-Gm-Message-State: AOAM532c4z/sPaRw+bNuRoFs13GwvSY6HqtH8UybKXUQ324oQW2nc3+n
        PThJeCzA7Md+QYwLAp+dT0BR55LBizP/+iQQEoc=
X-Google-Smtp-Source: ABdhPJxEnkA/Nn0IyFI++AMacSlhiDIjNrDSRC4kOGkurMRhJnTDMR7N0eZ3eHMJoU8LtONwhThErlqPCXlWVxyAUzs=
X-Received: by 2002:a1c:4e15:0:b0:387:3661:e857 with SMTP id
 g21-20020a1c4e15000000b003873661e857mr7226031wmh.94.1647436448736; Wed, 16
 Mar 2022 06:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <202203162054.pQFA2Y1M-lkp@intel.com>
In-Reply-To: <202203162054.pQFA2Y1M-lkp@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 16 Mar 2022 14:13:52 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2C0Mek0LMBoAWJLeo1t48VDyNWy1UjHLHh2UVoJ1crwQ@mail.gmail.com>
Message-ID: <CAK8P3a2C0Mek0LMBoAWJLeo1t48VDyNWy1UjHLHh2UVoJ1crwQ@mail.gmail.com>
Subject: Re: [csky-linux:riscv_compat_v8 6/20] arch/arm64/include/asm/compat.h:69:8:
 error: redefinition of 'struct compat_statfs'
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:x3lZU5oMLbqICoOeTwO6Jyq+SFeyr4l0/O6sjT8ZGG7PCCH0F/h
 SWwN573wMYDQi7rxHh4bIo19mm0mVy7bfkWWY4xROlSCn7OAosfZfnzZmETR7caWAI1Oz2/
 iqQHMRp10hrje3DhG46pt51KB/llj3esDhEgHmgDJDj82nnArjSRpFWYRIHImHFxwpNRhun
 aSEwpLLMUykNHan2XZujQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ts630HqonGg=:AS51JgYIK+51y40ifCo54R
 8yOJKf+Jq6D34+OvErdkfpRB2hmQyNe+J+oYZdwknDQed5Tvrv0/6SKqDycqGcYbkKxQ4Jaif
 rN9+wWHHArmuazfkJJ0cXv2bcr3xx7xzWqzKUUczgty1ALtqEBjKrHVBs5g+X84A+AkYumHlm
 Wm1Khrl3Qyy4NtkBLkkA5cFVLCCrC6l9oJuadkjWhN+Dw+5WNT/tfAqy3OzPS5wINEiZKyxPV
 whHed00H1nKn68p+8nuc3jJxtkEtP743p4Mtz7by6XmBWsRpo1TdAojvhZ58hjHUeTbZ8UazJ
 foD2DXmJCZncMuXhrC5erGx3T1FXPnZgWDFEY7eMaBI31Sado+xQcy53x1V9dgTmOE3V60eN4
 MRJbrIAy2WHE73VWLTKQn2hCY1M5i3mkOPDm8GOE+m544ah6b4wBBVGGHGLDZZrS6TbnkbVWq
 LWiQ+Vvpr1IiGrDKaR+UJQwFgNmiyOsQHKmFnf2dQY4CiKqGEEhG90LQvCTOF57wgPH/GqGOJ
 PocWYBl/6/xmKGBiuc2OcKeRXW0YVXuhVJGPpFX2GzWG1hpfk3maDZcsadZJf99CombbtWUIS
 RY0xOPAwfMKYCSH5GKJG4FClZMYW3uEcPM1WxorPNT0V6s8oaNEPF3bnIxVbJQJJs4f3vzxgD
 5ML2GeJAEnG1vIwj4/JVBsxs5d4xxenzH6Hkobwo6x8adX3piPYi/dv03aBt7GxulsRuFGPGm
 V8yoMNYLMZcY836QpIIln/qhHwEl6Rb5eILKqaxMfyJSfxAAL098hVBN1axyPIeGTkjfThB6e
 YVKfHtpKPSF/5CxmjvA8DO7GPtQfVgibIqmi5TQQUiAQmDoXq4=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 1:55 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://github.com/c-sky/csky-linux riscv_compat_v8
> head:   5e16532e9a75c08518ff196285fe079ee12188ae
> commit: 257ecf6f5f6391f6a88aa6fa19e33d09d686e704 [6/20] asm-generic: compat: Cleanup duplicate definitions
> config: arm64-defconfig (https://download.01.org/0day-ci/archive/20220316/202203162054.pQFA2Y1M-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/c-sky/csky-linux/commit/257ecf6f5f6391f6a88aa6fa19e33d09d686e704
>         git remote add csky-linux https://github.com/c-sky/csky-linux
>         git fetch --no-tags csky-linux riscv_compat_v8
>         git checkout 257ecf6f5f6391f6a88aa6fa19e33d09d686e704
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 prepare
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    In file included from arch/arm64/include/asm/stat.h:13,
>                     from include/linux/stat.h:6,
>                     from include/linux/sysfs.h:22,
>                     from include/linux/kobject.h:20,
>                     from include/linux/of.h:17,
>                     from include/linux/irqdomain.h:35,
>                     from include/linux/acpi.h:13,
>                     from include/acpi/apei.h:9,
>                     from include/acpi/ghes.h:5,
>                     from include/linux/arm_sdei.h:8,
>                     from arch/arm64/kernel/asm-offsets.c:10:
> >> arch/arm64/include/asm/compat.h:69:8: error: redefinition of 'struct compat_statfs'
>       69 | struct compat_statfs {
>          |        ^~~~~~~~~~~~~
>    In file included from arch/arm64/include/asm/compat.h:18,
>                     from arch/arm64/include/asm/stat.h:13,
>                     from include/linux/stat.h:6,
>                     from include/linux/sysfs.h:22,
>                     from include/linux/kobject.h:20,
>                     from include/linux/of.h:17,
>                     from include/linux/irqdomain.h:35,
>                     from include/linux/acpi.h:13,
>                     from include/acpi/apei.h:9,
>                     from include/acpi/ghes.h:5,
>                     from include/linux/arm_sdei.h:8,
>                     from arch/arm64/kernel/asm-offsets.c:10:
>    include/asm-generic/compat.h:80:8: note: originally defined here
>       80 | struct compat_statfs {

The arch/arm64/include/asm/compat.h header defines its own
compat_statfs structure, but is missing a #define for it ahead of
the #include <asm-generic/compat.h> to prevent the second
definition.

     Arnd
