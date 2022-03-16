Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE5E4DB1F3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 14:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356133AbiCPN5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 09:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353279AbiCPN5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:57:09 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A074A4705C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 06:55:52 -0700 (PDT)
Received: from mail-wr1-f47.google.com ([209.85.221.47]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MNbtF-1nk6NJ3xMp-00P7UW for <linux-kernel@vger.kernel.org>; Wed, 16 Mar
 2022 14:55:50 +0100
Received: by mail-wr1-f47.google.com with SMTP id u16so2088791wru.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 06:55:50 -0700 (PDT)
X-Gm-Message-State: AOAM532tiKqdcu4wtlpfC6zOkSFYnKDqGuy1G19xVTP3Yxx59DCQ0mAU
        lYYNYKBp9wRQx/GEYqoMccKiwU5ix1hBKjF/ymA=
X-Google-Smtp-Source: ABdhPJy+lwx53EZnd7w8d/ihKdeWtRvy8fq/hg43IWx4M+zNwmv/HP81T+84POeldU40HhcONYSQPVqVO7LeEIbIOV0=
X-Received: by 2002:adf:edc3:0:b0:1ec:5f11:5415 with SMTP id
 v3-20020adfedc3000000b001ec5f115415mr48812wro.317.1647438950657; Wed, 16 Mar
 2022 06:55:50 -0700 (PDT)
MIME-Version: 1.0
References: <202203162123.Ksr0CtpZ-lkp@intel.com>
In-Reply-To: <202203162123.Ksr0CtpZ-lkp@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 16 Mar 2022 14:55:34 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1atu-azCPCC_1c-MKTungkHVn0Wd1awhZ4=hf1i9MWfA@mail.gmail.com>
Message-ID: <CAK8P3a1atu-azCPCC_1c-MKTungkHVn0Wd1awhZ4=hf1i9MWfA@mail.gmail.com>
Subject: Re: [csky-linux:riscv_compat_v8 20/20] arch/riscv/kernel/compat_signal.c:199:5:
 warning: no previous prototype for function 'compat_setup_rt_frame'
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:XwbXopYYy6njKVpvYhEygwjAaYy64S9/+yDmDpSg4DVFBIRv+wp
 /pcbhAqZcP1Fnaji1qodT6rhpyxADU4muND4OCrqxgd+dIPVwoCpV8nQxF+OlHNeagad/Ev
 wr6zOMDAHgjw9siX1Z+Kk6DBVm+2JkpXndD1Z3tuyxTTgGrswxiSbsFjg3TQCsKMvGQOzra
 EA4Vs/SH/+JmQek4myM/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0eb4o75aLlw=:wibIAZxUy5EIp43Bn50sq/
 X0tYq5EAWfHkwOSJZKXBP7OT0v4gOMVLhl5ncB7SgaEYd2Np7qASvT4RL5nTUy5XJ5d3Ij4qX
 PUVqFwjVavP8syZECEfuPW+507KlVJVYLujfyabitHhDEpsqwaP9XGq9jzr2nlJ3QZj8q0QSb
 U6tmuaoDQU/B0+nco4MEEtUPvtHzH1cZYVffxpBo19G0L7IHK5V/2TboAD/zJsrk1r5G/30pz
 LNwbiHABNHY/zoEEKe40/99KIgSKA0UclwEboL+KkbLuYqt38RsuqF1dNjvwKAITrn2eEFBO0
 i3lMDVypuk2o5SHMR9If5MxdERHIlzpVN4jSp3r7Dir2xfQgsx7da66KFJITMTXod6QqSAez1
 wWyiimExqjH6sgUdnECKYh8bsRPxG7W7nESw4jWVJ1X4+tqhLW1uwy7GmCzcRWgA7lPf/I4ku
 34kx+2Nawxg9KGK9nPjRTFhemOx1d1KE9qx5ozMhlA221ZxQhGbVPKyNEN2tiMNDVQOPrg/PM
 YR8hNeTGLS081Vbz7/6ykyC9FT6dQCcNlsX/+zx27lujJMHkKzOP6db4ytPYX0LdbIZqKSjwq
 ggEnflIVOgCcntDhmWQmbJMBrmxW6Ab4IvJawsmSn6LJ/XqhWZfs4+WK6TecKdEZnw/+yPd2u
 0TotDl/xdPulzZorQCvE1ItXMs/3yUsneAqWooF5sFXePIKdfnlEBXOkSJZCqIBlxiwrenXUv
 bXexulPG4l/CwUnn/j1zO0D8qQf0syX6RGleksrXna0jo6fr2tsifgpXdiq91V4J/IE3kjci7
 WBBjUyoee6Mary0uh5CC7A5kK01ujOrqsRwp3LuPA/QHoNdy6s=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 2:42 PM kernel test robot <lkp@intel.com> wrote:
>
> All warnings (new ones prefixed by >>):
>
> >> arch/riscv/kernel/compat_signal.c:199:5: warning: no previous prototype for function 'compat_setup_rt_frame' [-Wmissing-prototypes]
>    int compat_setup_rt_frame(struct ksignal *ksig, sigset_t *set,
>        ^
>    arch/riscv/kernel/compat_signal.c:199:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    int compat_setup_rt_frame(struct ksignal *ksig, sigset_t *set,
>    ^
>    static
>    1 warning generated.

The problem here is that the compat_setup_rt_frame() declaration got added to
arch/riscv/kernel/signal.c instead of a header file that is included by both
signal.c and compat_signal.c.

Alternatively, the definition could be made static and moved into signal.c.

       Arnd
