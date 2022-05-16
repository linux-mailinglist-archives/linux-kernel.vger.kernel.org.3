Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64833528A4B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 18:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbiEPQ1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 12:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240213AbiEPQ1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 12:27:34 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316203A5EE
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 09:27:33 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id o130so12381899ybc.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 09:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j/co+KAQQo66TS0tPfVyB6C7BokdiYKLrG+0nDqTuLM=;
        b=K+Xf1YJ5C176/UA8XpVoJM6rL6RRtYdtOrWug+UXpe2IXX7M4oi7l1L1aERRAOnF+W
         +XU/tOVk4CDPSpi2B7FfeAWLwNB1o6vyzUm5OtUp4+1pMai6J1fpSc+34SXtOMpMyYoQ
         CqaZtmJvqCuEJF5yB35MRGuPBU1AtVqxCJ7f8OZSUGsnADpOxVnWSFR61CImyysp5OYZ
         6y2QcCdwmtnGiax65AscZAY6cLx5DodPQOlshJNyZwbMeXspjjxgBhExxtdHx0lUbjD2
         uM904s+6+8/9+3X6l1FbFJOls5CDb8GNB+umrhelxfZo0EPagOIMO0uojaaT91plLuaW
         NpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j/co+KAQQo66TS0tPfVyB6C7BokdiYKLrG+0nDqTuLM=;
        b=EKNChqLtcN6OJabM356+6BaeSoO8+VptKeS8ZD1Mnh2bQyzwJVgiGy2vTgahmpdnQy
         OidfhAtmp1CD41RxA/PSyVjcxpq8ZyFI6Toq1Ysty7n6sVKmf4j3oPuO2t8M85fWiiYU
         gOpEVS3ibZ1iTNFxC8xe+wFDTxRsJ/Q9H93+dmzM0o/ks9nHv9cj8QIY+biYmB5ZE6Tu
         s6rbGCKkssusZxpd/fgbBCE7pEj6OaDTKlh14Bdx11KXyb/ZOBtcTX6h7YxWli9DHGhi
         Ah3gCiM8R+xcTcl8P2yZhjYHDJ4QtzeOj5w6JzqPgI4AYGNEiNNt9dKG3vbwSRgGvKTg
         RFQw==
X-Gm-Message-State: AOAM533R+AQ0QYC3Z0TKydzFuXVcHCFpG6yIasNj9vNiMIoy2ZxC7OhQ
        ofFm7hMa6PBKuI76qK6ASyE4K8vQr2mcBjji3l+uCw==
X-Google-Smtp-Source: ABdhPJyGXCAvLQIrn4hSSexwk3ndiIZBTNzLb8dR/Zt7TAyK7N6usOfUGTgJpaSwn+ILodDWufhKuBbVhK7H/bJl3xs=
X-Received: by 2002:a05:6902:704:b0:649:cadc:bcf0 with SMTP id
 k4-20020a056902070400b00649cadcbcf0mr18600397ybt.537.1652718452212; Mon, 16
 May 2022 09:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtU7i356bhfGSVaZUkeqE2gE-GE0NQ1iqxJEH_u4BZjSw@mail.gmail.com>
 <20220516153605.f4cxfa7yx2jnorfm@revolver>
In-Reply-To: <20220516153605.f4cxfa7yx2jnorfm@revolver>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 16 May 2022 21:57:19 +0530
Message-ID: <CA+G9fYvUPmr0_WFRGprOw_N1Jik9TZ5JzgbdbdR_yZLMezZZCQ@mail.gmail.com>
Subject: Re: [next ] kernel BUG at mm/mmap.c:3235! - invalid opcode: 0000 [#1]
 PREEMPT SMP NOPTI
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Song Liu <songliubraving@fb.com>,
        Rik van Riel <riel@surriel.com>,
        Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Song Liu <song@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        SeongJae Park <sj@kernel.org>, Will Deacon <will@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liam,

On Mon, 16 May 2022 at 21:06, Liam Howlett <liam.howlett@oracle.com> wrote:
>
> * Naresh Kamboju <naresh.kamboju@linaro.org> [220516 02:51]:
> > While running LTP mm tests on x86_64 the following kernel BUG was noticed
> > on Linux next-20220513 [1].
> >
> > mmapstress01    1  TPASS  :  Test passed
> > mmapstress02    1  TPASS  :  Test passed
> > mmapstress03    0  TINFO  :  uname.machine=x86_64 kernel is 64bit
> > mmapstress03    1  TPASS  :  Test passed
> > [  666.897222] ------------[ cut here ]------------
> > [  666.897260] kernel BUG at mm/mmap.c:3235!
> > [  666.897285] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> > [  666.899420] CPU: 3 PID: 25230 Comm: mmapstress03 Not tainted
> > 5.18.0-rc6-next-20220513 #1
> > [  666.900552] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > BIOS 1.12.0-1 04/01/2014
> > [  666.901868] RIP: 0010:exit_mmap+0x32c/0x3a0

<trim>

> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> >
> > metadata:
> >   git_ref: master
> >   git_repo: ''
> >   git_sha: 1e1b28b936aed946122b4e0991e7144fdbbfd77e
> >   git_describe: next-20220513
> >   kernel_version: 5.18.0-rc6

Here is the Kconfig file.

> >   kernel-config: https://builds.tuxbuild.com/296PqKcUcCQSykZbASUqmdlP33g/config
> >   build-url: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/pipelines/538244935
> >   artifact-location: https://builds.tuxbuild.com/296PqKcUcCQSykZbASUqmdlP33g
> >   toolchain: clang-12
>
> I'm having an issue reproducing this on my configuration.  May be the
> clang compiler though.  I'll keep digging.

FYI,
tuxmake will set up toolchains for you and build fast.

# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
#
# See https://docs.tuxmake.org/ for complete documentation.
# Original tuxmake command with fragments listed below.

# tuxmake --runtime podman --target-arch x86_64 --toolchain clang-12
--kconfig defconfig --kconfig-add
https://raw.githubusercontent.com/Linaro/meta-lkft/sumo/recipes-kernel/linux/files/lkft.config
--kconfig-add https://raw.githubusercontent.com/Linaro/meta-lkft/sumo/recipes-kernel/linux/files/lkft-crypto.config
--kconfig-add https://raw.githubusercontent.com/Linaro/meta-lkft/sumo/recipes-kernel/linux/files/distro-overrides.config
--kconfig-add https://raw.githubusercontent.com/Linaro/meta-lkft/sumo/recipes-kernel/linux/files/systemd.config
--kconfig-add https://raw.githubusercontent.com/Linaro/meta-lkft/sumo/recipes-kernel/linux/files/virtio.config
--kconfig-add CONFIG_IGB=y --kconfig-add
CONFIG_UNWINDER_FRAME_POINTER=y LLVM=1 LLVM_IAS=1

( OR )
tuxmake --runtime podman --target-arch x86_64 --toolchain clang-12
--kconfig https://builds.tuxbuild.com/296PqKcUcCQSykZbASUqmdlP33g/config
LLVM=1 LLVM_IAS=1


- Naresh
