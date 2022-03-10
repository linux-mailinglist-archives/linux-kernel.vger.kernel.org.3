Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD224D45D8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 12:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239326AbiCJLiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 06:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237497AbiCJLiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 06:38:50 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25AF396BF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 03:37:48 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id g1so10287451ybe.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 03:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=1ziSuPMzYNAw8eT+iBfN5WM2hFNCKf7IS7RFWaVxPlg=;
        b=ba8/6TOQ+hGmIeTYsQ6ojj2JBVlxNbrThk3McB+mMlo48TRziTO1ei4nh8wKenWuZ/
         lt7Dpyww+cpYm4aeKTTnJpxvpUXKaTEXJ08x4JkUKrFFZqSEhPRiGKmgzZ3BI65+uW2k
         thDlndn1Qt70mJ1l63wW/vWAenB67L2+FyXfLTARv7lmWrYxJQ+uXfa+v9Qztlm1p0bX
         9jKSqFinWTLMVDCTMCiKjgdUZU2x6DI5VBynij+OtCxAwMYMHr61JDseNwpJjIlmjMJh
         eSo1sQSn3cNYI7UbJsS6J7+oOlukXH/vGxTTSCEdTvZqvZo1VWkbLOeQW5wg29GppWnG
         3M0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=1ziSuPMzYNAw8eT+iBfN5WM2hFNCKf7IS7RFWaVxPlg=;
        b=1KH+3z40XibKsOevc3PECkdvmKlk0o1Yqdgt+Hgbm+euvDH/s++M1Y1M8fYRxuykYt
         3ZEJBgN+B2yQbJy8upFN61fxJJfr8S44qjDTS/2G3JnJDg4sPl7Z6ZxooMCg4Cq/2alq
         6xJF+Lhf599Yrg+5t8kNwyfCy7E3l3CvrKSbm4/lvLCXGfw1JioCqzlSlleNP8i8iybt
         K2hXkAc2Cw++YR+mSexk5B4UgpSWv1ndB3JBDAgwRXMaN+7UiIAeQqFyNrp2JZgElrVT
         pa6vgquKmQuCGFid24TVKNBOsMLg4emhsmxj+o+hIt8a6AR1ii2rNCrnry2lMZq4TBrU
         foCw==
X-Gm-Message-State: AOAM5315LFqPGlyKQeGLlJGX/YWvoFBjRceepaivJ3oBbVE2I2kI9zJt
        DpVmgyvsE2gJ7OgNYkS37XnHSxQ1JaavPS0F8RZsCw==
X-Google-Smtp-Source: ABdhPJxjhA4KF95Phht4rOAHa4GEkQ+TbVYtbU348Hj9PBYLNJOVYP54qb9DxrOcA9Y52tkAu1hFeD+l7r+aAwisBmw=
X-Received: by 2002:a25:9909:0:b0:624:57e:d919 with SMTP id
 z9-20020a259909000000b00624057ed919mr3599420ybn.494.1646912267954; Thu, 10
 Mar 2022 03:37:47 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 10 Mar 2022 17:07:36 +0530
Message-ID: <CA+G9fYsz7+Ooc8L-Dpfjp6mMDdw43=SjqiE0ryABy3t6qEzRoQ@mail.gmail.com>
Subject: [next] ld.lld: error: ./arch/arm/kernel/vmlinux.lds:34: AT expected,
 but got NOCROSSREFS
To:     clang-built-linux <clang-built-linux@googlegroups.com>,
        llvm@lists.linux.dev,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux next-20220310 arm clang builds failed due to following errors/warning=
s.

metadata:
    git_describe: next-20220310
    git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
    git_sha: 71941773e143369a73c9c4a3b62fbb60736a1182
    git_short_log: 71941773e143 (\Add linux-next specific files for 2022031=
0\)
    target_arch: arm
    toolchain: clang-14
    Kconfig: https://builds.tuxbuild.com/26BmBgHzW9MFZ3R0kIwL0Ce2r09/config

make --silent --keep-going --jobs=3D8
O=3D/home/tuxbuild/.cache/tuxmake/builds/1/build LLVM=3D1 LLVM_IAS=3D1
ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabihf- 'HOSTCC=3Dsccache clang'
'CC=3Dsccache clang'
clang: warning: argument unused during compilation: '-march=3Darmv7-a'
[-Wunused-command-line-argument]
clang: warning: argument unused during compilation: '-march=3Darmv7-a'
[-Wunused-command-line-argument]
clang: warning: argument unused during compilation: '-march=3Darmv7-a'
[-Wunused-command-line-argument]
clang: warning: argument unused during compilation: '-march=3Darmv7-a'
[-Wunused-command-line-argument]
clang: warning: argument unused during compilation: '-march=3Darmv7-a'
[-Wunused-command-line-argument]
clang: warning: argument unused during compilation: '-march=3Darmv7-a'
[-Wunused-command-line-argument]
clang: warning: argument unused during compilation: '-march=3Darmv7-a'
[-Wunused-command-line-argument]
clang: warning: argument unused during compilation: '-march=3Darmv7-a'
[-Wunused-command-line-argument]
clang: warning: argument unused during compilation: '-march=3Darmv7-a'
[-Wunused-command-line-argument]
ld.lld: error: ./arch/arm/kernel/vmlinux.lds:34: AT expected, but got
NOCROSSREFS
>>>  __vectors_lma =3D .; OVERLAY 0xffff0000 : NOCROSSREFS AT(__vectors_lma=
) { .vectors { *(.vectors) } .vectors.bhb.loop8 { *(.vectors.bhb.loop8) } .=
vectors.bhb.bpiall { *(.vectors.bhb.bpiall) } } __vectors_start =3D LOADADD=
R(.vectors); __vectors_end =3D LOADADDR(.vectors) + SIZEOF(.vectors); __vec=
tors_bhb_loop8_start =3D LOADADDR(.vectors.bhb.loop8); __vectors_bhb_loop8_=
end =3D LOADADDR(.vectors.bhb.loop8) + SIZEOF(.vectors.bhb.loop8); __vector=
s_bhb_bpiall_start =3D LOADADDR(.vectors.bhb.bpiall); __vectors_bhb_bpiall_=
end =3D LOADADDR(.vectors.bhb.bpiall) + SIZEOF(.vectors.bhb.bpiall); . =3D =
__vectors_lma + SIZEOF(.vectors) + SIZEOF(.vectors.bhb.loop8) + SIZEOF(.vec=
tors.bhb.bpiall); __stubs_lma =3D .; .stubs ADDR(.vectors) + 0x1000 : AT(__=
stubs_lma) { *(.stubs) } __stubs_start =3D LOADADDR(.stubs); __stubs_end =
=3D LOADADDR(.stubs) + SIZEOF(.stubs); . =3D __stubs_lma + SIZEOF(.stubs); =
PROVIDE(vector_fiq_offset =3D vector_fiq - ADDR(.vectors));
>>>                                          ^
make[1]: *** [/builds/linux/Makefile:1225: vmlinux] Error 1

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

build link [1]

--
Linaro LKFT
https://lkft.linaro.org

[1] https://builds.tuxbuild.com/26BmBgHzW9MFZ3R0kIwL0Ce2r09/
