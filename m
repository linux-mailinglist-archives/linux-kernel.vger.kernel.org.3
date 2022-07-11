Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B83557031E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbiGKMoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbiGKMob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:44:31 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7316461D43
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:44:23 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id h16so2935182ila.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=br3tJQEkgsdXZG9sAFREqjWpIgB35zSs0NthrE2bN3k=;
        b=Bi0thlVz28P+BmpNFIxaCbIy7Lv8vL3tS/jJ3BC35kpIlkbgevxH6ZGSjASitkI6ox
         bWek58zuQOiKTTy7OBqFBpYhjQGK4sKtZtfLY43UbeI6KKRTfOZc00HgNenG7TVegw/1
         m/RhpKKG0pHAT7zkBUyRxoCfBltuagXIMfvjsrG/skElxD+5q37FUjgWx/29u5QT1mu4
         NVMIWXLrfzcnm42Ej0qp6VazUED7qx3ApGTngjiHHcpAIqnanKHn34+jIQ0+glWDGP8D
         pm6OTzl4912V/GbwS16+sMoeABXxBvBkS37Nt4HKxK9b4Az0p2Ytrg5Ohut6skha6wN9
         t0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=br3tJQEkgsdXZG9sAFREqjWpIgB35zSs0NthrE2bN3k=;
        b=v87ZRcaM2vFhq5Lcpz64xnluE4zrIoqFn0hqcwDHrpYH/vVABtl4wtShg/YzssvXnK
         GfHQa+ZdrSEWyecDnKyI2oIVK+a2d1rniWiV+McAOmmih4hlW6pGhl/AkVeWu370/s5F
         C/ZeEmI9d5DnZtjk/A/L2slRaAGZcSib9/jm7xcrzZv83QFKWAcrzfQT9M0xhJc4qBy4
         sto3kvZQXRBtDzr/wcpjtEdr8WIj0xNoiUv1vNF9HHDJgUwj1oIWoNmaOq12asGzzOcl
         hvLrp27Acg+0nSdPmPL+PtLYY/Fv9Nfu3IaHwnTlUw+gN1NjMLQwppYTaPrwxZIIPsat
         ctTw==
X-Gm-Message-State: AJIora94kBYyOOlcqLjsUc+uLK6cPlVRakw7E1tINTA+szR66QPDcdLk
        YjWBVA8R0lpu13hNCoEwAQ1Fa8fy8GbZZtsBt729elTU1lf2RQ==
X-Google-Smtp-Source: AGRyM1u0Uy4Mw/UttOQP310bU1YeSnqgNYdZDkVFy5JATHL9JvuOeqeSAvXzJ83qxP5Tp1jTjPgqFfrTcJaG2FaG/ag=
X-Received: by 2002:a05:6e02:1549:b0:2dc:616a:1dd4 with SMTP id
 j9-20020a056e02154900b002dc616a1dd4mr8633961ilu.131.1657543461597; Mon, 11
 Jul 2022 05:44:21 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 11 Jul 2022 18:14:10 +0530
Message-ID: <CA+G9fYtDr=tqPmM6f9aGQOfqkxUo-yP-kHBQG787D0Cj6oO-dg@mail.gmail.com>
Subject: Block: bio.c:1232:6: error: variable 'i' is used uninitialized
 whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
To:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        clang-built-linux <clang-built-linux@googlegroups.com>
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

Following regression found with clang i386 and x86 builds failed on
Linux next-20220711 tag. Please find the build error logs.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

Regressions found on i386:

   - build-clang-12-defconfig
   - build-clang-nightly-lkftconfig
   - build-clang-13-defconfig
   - build-clang-12-lkftconfig
   - build-clang-14-lkftconfig
   - build-clang-nightly-defconfig
   - build-clang-13-lkftconfig

Regressions found on x86_64:

   - build-clang-nightly-x86_64_defconfig
   - build-clang-nightly-lkftconfig
   - build-clang-13-lkftconfig
   - build-clang-12-lkftconfig
   - build-clang-13-lkftconfig-kcsan
   - build-clang-14-lkftconfig
   - build-clang-14-x86_64_defconfig

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/1/build LLVM=1 LLVM_IAS=1
ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu- 'HOSTCC=sccache clang'
'CC=sccache clang'
block/bio.c:1232:6: error: variable 'i' is used uninitialized whenever
'if' condition is true [-Werror,-Wsometimes-uninitialized]
        if (unlikely(!size)) {
            ^~~~~~~~~~~~~~~
include/linux/compiler.h:78:22: note: expanded from macro 'unlikely'
# define unlikely(x)    __builtin_expect(!!(x), 0)
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~
block/bio.c:1254:9: note: uninitialized use occurs here
        while (i < nr_pages)
               ^
block/bio.c:1232:2: note: remove the 'if' if its condition is always false
        if (unlikely(!size)) {
        ^~~~~~~~~~~~~~~~~~~~~~
block/bio.c:1202:17: note: initialize the variable 'i' to silence this warning
        unsigned len, i;
                       ^
                        = 0
1 error generated.

Build details:
---------------
        download_url: https://builds.tuxbuild.com/2BnQO6OXSJejfpLO4fQ3fWa5wVT/,
        git_describe: next-20220711,
        git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next,
        git_sha: 4112a8699ae2eac797415b9be1d7901b3f79e772,
        git_short_log: 4112a8699ae2 (\Add linux-next specific files
for 20220711\),
        kconfig: https://builds.tuxbuild.com/2BnQO6OXSJejfpLO4fQ3fWa5wVT/config
        kernel_version: 5.19.0-rc6,
        make_variables: {
            LLVM: 1,
            LLVM_IAS: 1
        },

Steps to reproduce:
tuxmake --runtime podman --target-arch x86_64 --toolchain clang-14
--kconfig https://builds.tuxbuild.com/2BnQO6OXSJejfpLO4fQ3fWa5wVT/config
LLVM=1 LLVM_IAS=1

Best regards
Naresh Kamboju

--
Linaro LKFT
https://lkft.linaro.org
