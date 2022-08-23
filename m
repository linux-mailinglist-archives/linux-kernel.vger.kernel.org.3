Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1004259E5C2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 17:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243463AbiHWPMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 11:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243384AbiHWPLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 11:11:52 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E189147BD1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 03:22:03 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id x10so13072584ljq.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 03:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=rcpUjo+cyhxrF2PUlntwQQeQhblXyhNJQMZ6x8R4WfU=;
        b=fXlMHdh22iAOkp3d197BppcPR8XsI4EebfdCp2ByM+AuZbMtpcWbm8oUBwGpGUFc7k
         6cR4QkyyMUZ2DCwkTQ0hUKYkRxUdkHasMqeKndSQHnqV2oeYLDjuPFiedCijZsoQsc/M
         d321fxsRuympwfr9adDcnLOkaisFvOINQvsYaBD9ROWTX00k4q2lxZT9oJjfbSJlegjS
         5GD+SOcHYTi7TqlE/b3u8E70GYK7T/73PHyyRYRJee2RLY5bGv2FiNs3VTg8kgkiXf8y
         LQEN539+FVp//KzJVqb4O2O7//UbhoYo/Wj7C8tjrbvdptXYl05DA6fsllEAN5sxi2cA
         Fngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=rcpUjo+cyhxrF2PUlntwQQeQhblXyhNJQMZ6x8R4WfU=;
        b=FoWhDGrpddOj0ZCRXUKsrHJvndZimX2mq7PbPdbVCkBsu49IQTsuuBL6nGzUMLGSjc
         KA7vf4wb6Qgb2W5Zx3Pq2gzxyUfsMPOgbH6On+/2tE3tWAvUg5xHGUdK+3dAFnu5zks1
         ei/c+5/D/AcJEqfUof9OTHOYM4SRteIrrdaRBdMa30fQkY4fyVD0OWAVcstODneoCbCU
         hVkOPIH6bwG00NVxur9537eIHyXBqq7Njyyda9ei5S4rxCA+9KuJYiZzIyAurQeneT93
         B3XpD8xsmX0v656nSfDp4A0XC97kEyUCN6NwZXXnq2XWpHYfP2iaw6KYhP6yd11mdpXo
         ApqQ==
X-Gm-Message-State: ACgBeo1iyxU4fJlqTDkavujx6wqClM6PKVNHZc39v+KBGdLOzXnIK7xU
        SaGSrA54UozeHA+DpHf3dWZxrwGqC4LZuPFFNc+VcIM7xs76CA==
X-Google-Smtp-Source: AA6agR6NV/6jojdTjYjTVv3lqUiVn7Xxllsko6ljv3UJddHUctRmt+3eGXXi1SJS8oCEFxsto2JNt1A8K7u5y7RNmb0=
X-Received: by 2002:a17:906:fe46:b0:73d:939a:ec99 with SMTP id
 wz6-20020a170906fe4600b0073d939aec99mr3100308ejb.169.1661249657957; Tue, 23
 Aug 2022 03:14:17 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 23 Aug 2022 15:44:06 +0530
Message-ID: <CA+G9fYsm_2WZncWJbwkJkbnOJFvnC76jQdUWkHhyih4GRKjMGg@mail.gmail.com>
Subject: [next] mm/pagewalk.c:318:12: error: variable 'err' is used
 uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
To:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
        linux-mm <linux-mm@kvack.org>
Cc:     Rolf Eike Beer <eb@emlix.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86_64 defconfig builds failed on Linux next-20220823 tag with clang toolchain.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Regressions found on x86_64:
   - build-clang-13-x86_64_defconfig
   - build-clang-14-lkftconfig-kcsan
   - build-clang-nightly-lkftconfig
   - build-clang-11-x86_64_defconfig
   - build-clang-14-lkftconfig
   - build-clang-nightly-x86_64_defconfig
   - build-clang-14-x86_64_defconfig
   - build-clang-13-lkftconfig
   - build-clang-12-x86_64_defconfig
   - build-clang-12-lkftconfig

Regressions found on i386:
   - build-clang-11-defconfig
   - build-clang-nightly-lkftconfig
   - build-clang-nightly-defconfig
   - build-clang-14-lkftconfig
   - build-clang-14-defconfig
   - build-clang-12-defconfig
   - build-clang-13-lkftconfig
   - build-clang-13-defconfig
   - build-clang-12-lkftconfig

make --silent --keep-going --jobs=8 O=/home/tux   -
build-.cache/tuxmake/builds/1/build LLVM=1 LLVM_IAS=1 ARCH=x86_64
CROSS_COMPILE=x86_64-linux-gnu- 'HOSTCC=sccache clang' 'CC=sccache
clang' olddefconfig
.config:5286:warning: override: UNWINDER_FRAME_POINTER changes choice state
make --silent --keep-going --jobs=8 O=/home/tux   -
build-.cache/tuxmake/builds/1/build LLVM=1 LLVM_IAS=1 ARCH=x86_64
CROSS_COMPILE=x86_64-linux-gnu- 'HOSTCC=sccache clang' 'CC=sccache
clang'

mm/pagewalk.c:318:12: error: variable 'err' is used uninitialized
whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
                else if (ops->pte_hole)
                         ^~~~~~~~~~~~~
mm/pagewalk.c:321:7: note: uninitialized use occurs here
                if (err)
                    ^~~
mm/pagewalk.c:318:8: note: remove the 'if' if its condition is always true
                else if (ops->pte_hole)
                     ^~~~~~~~~~~~~~~~~~
mm/pagewalk.c:311:10: note: initialize the variable 'err' to silence
this warning
                int err;
                       ^
                        = 0
1 error generated.

metadata:
Build: https://builds.tuxbuild.com/2DkF28RfJ2VeMSGwDNhsXXu3dbo/
config: https://builds.tuxbuild.com/2DkF28RfJ2VeMSGwDNhsXXu3dbo/config
git_describe: next-20220823
git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
git_sha: 05477f3653b82d8b3bcf39d2937d9893124976db
git_short_log: 05477f3653b8 ("Add linux-next specific files for 20220823")
toolchain: clang

Steps to reproduce:
------------------------
# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
#
# See https://docs.tuxmake.org/ for complete documentation.
# Original tuxmake command with fragments listed below.

# tuxmake --runtime podman --target-arch x86_64 --toolchain clang-14
--kconfig x86_64_defconfig LLVM=1 LLVM_IAS=1

--
Linaro LKFT
https://lkft.linaro.org
