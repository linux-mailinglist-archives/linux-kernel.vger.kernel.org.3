Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E6F53C2A7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 04:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240035AbiFCCDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 22:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236046AbiFCCDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 22:03:22 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF85935DD6
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 19:03:20 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-30c1c9b9b6cso69003507b3.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 19:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=A63naTJt6zUwlvsuridWvEjPR850QwDyhCVKh38nSkg=;
        b=BA+nmzQ0FWBRZdwycD89lmG45gs/rZHmmHf4aXaNUBF4rJpKNO6fZv1aKWNIqY7nZF
         woEVBUvPkFGR9N6ZkFJBmMUjvWwIY0hg8x7WUEzTTGWIsqnJ8F2ZnpTuPGQHqhagUX5S
         zsbVo78PCaODionwH7zAabX8oO06A6vqeRZ9CxV78TTuDpJxkGJ+Nqz+Jg9tH/GJEbT8
         iHSSS0ytgervWGnmaghPu99QRU2hSJ+8zAm6vGpuJXAc7bJACp5pPU3eZ+Nbzfxpn6/N
         zTBzTiz5PRZ399D8AePUXfiR9I092HroZPKrXaU6jMI5UCqqBWaEqRD/u15iKhNeufBP
         WQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=A63naTJt6zUwlvsuridWvEjPR850QwDyhCVKh38nSkg=;
        b=CtXDH6iT81GrfPwpL6eIDZAeNiu3LoLu6yixACUUGt/v34f9ZRaYwI64djCDtphBqH
         gaJVerHXOV1n8/noa3d9YyB+ZoXnlTvRtRTig4M+Q1bOgzidAzm0HplmEw51Vbx0NAge
         +t33JJZ7cSyFLjngR0vC7279UNjxC6U0AjlYsLyIMuBYFF0N/uOw/reazooMOG0pYJK2
         AtmigCDHWY/58IjzSIhExLscYlOMmpNrRLVbfY+YAtMnFJiCdZtg285W1K+CxH/lyTjT
         cifgsE9dop1DTL7NUOz6+iWZzHJWzyhiElPONQgZdBvWKdmMfMgc5Ow3GELfkH9diUl9
         jqKw==
X-Gm-Message-State: AOAM533mUp/iUgevy0oegSf2oiPe11bPfs5877DIHSdrHzHCUM7QVLMc
        jt3KvHyo7drn+7u/+mmgJmLkGOP+1s4QWYkkY5Wqaw==
X-Google-Smtp-Source: ABdhPJzJwy/AoL8jAbntm39SvG2wCGLTOiet46mi3kxXZTznFyNhscdIk9C8MGeZg1TG+JxhbHlKdw0wtXgD1cQgbI4=
X-Received: by 2002:a0d:d4d5:0:b0:30c:8231:b950 with SMTP id
 w204-20020a0dd4d5000000b0030c8231b950mr9252585ywd.189.1654221799635; Thu, 02
 Jun 2022 19:03:19 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 3 Jun 2022 07:33:08 +0530
Message-ID: <CA+G9fYts-KH-R5EkBpz2u6H_Cx6YTXus1JKJS6yBxGhb0O2qQQ@mail.gmail.com>
Subject: gcc-12: build errors: arch/arm64/kernel/setup.c:225:56: warning:
 array subscript -1 is outside array bounds of 'char[]' [-Warray-bounds]
To:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Donnelly <john.p.donnelly@oracle.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
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

While building Linux kernel with gcc-12 for arm64 the following warnings/errors
noticed. These are specific to gcc-12 builds.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/2/build
CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- ARCH=arm64
CROSS_COMPILE=aarch64-linux-gnu- 'CC=sccache aarch64-linux-gnu-gcc'
'HOSTCC=sccache gcc'
In file included from arch/arm64/include/asm/thread_info.h:17,
                 from include/linux/thread_info.h:60,
                 from arch/arm64/include/asm/preempt.h:6,
                 from include/linux/preempt.h:78,
                 from include/linux/smp.h:110,
                 from include/linux/lockdep.h:14,
                 from include/linux/mutex.h:17,
                 from include/linux/kernfs.h:11,
                 from include/linux/sysfs.h:16,
                 from include/linux/kobject.h:20,
                 from include/linux/of.h:17,
                 from include/linux/irqdomain.h:35,
                 from include/linux/acpi.h:13,
                 from arch/arm64/kernel/setup.c:9:
In function 'request_standard_resources',
    inlined from 'setup_arch' at arch/arm64/kernel/setup.c:350:2:
arch/arm64/kernel/setup.c:225:56: warning: array subscript -1 is
outside array bounds of 'char[]' [-Warray-bounds]
  225 |         kernel_code.end     = __pa_symbol(__init_begin - 1);

steps to reproduce:
# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake

tuxmake --runtime podman --target-arch arm64 --toolchain gcc-12
--kconfig tinyconfig CROSS_COMPILE_COMPAT=arm-linux-gnueabihf-

Build link:
https://builds.tuxbuild.com/2A2iyFqotDfgkLynaKzmpf8H7Nf/

--
Linaro LKFT
https://lkft.linaro.org
