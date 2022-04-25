Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AB250DAE4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbiDYINl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbiDYINj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:13:39 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7145032ED5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:10:35 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2f7c57ee6feso45006967b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=7sxESoBMIprVPsske9LbaPlBbuPs3+wrxg6dMd1r+hA=;
        b=H9vTEgnJ6gwdWb9SONb+eVVI1x5Fg1wJbWIU/qEau2sxgvVGeIETFNZTRcom3KBq/z
         f4XJ2WrXBMMgYYtQUWNY2s4OhiRP3Qj6JwNwEhrWEpG5AeZjLEQ0tKPN2z1PGK3z8bHF
         ivFK0HH0pcjyzqWxHvXYIER1yC2C6fukc21VmVJgiGHzwfpWSo08Xnup0kMUzBAKNnTr
         UzvFq5zO+EJ+NsLleTZmhF6HOq7MY6uFb8gPQpwihlyODXXXqY/ER5aTT6hsaM/bU1Wc
         W62z681UIMGU+gnWZuGxEk6j4/l7hRUHVxEXKbL/L0bH4NrrAdLZjXdNykLnMBABUb9/
         /Q8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=7sxESoBMIprVPsske9LbaPlBbuPs3+wrxg6dMd1r+hA=;
        b=m0bp1Rw9Icd9GlRy2R/RuGgd8x0eZeggZIkBINCznt8JqItC4m8nl6YDLkycS11TEm
         8NTGAjwpT+Mf6x5/r6qJ6/kpLtnhE+bhIFV//KycJeHf7NQkyFUIsYAHeIhA0d3y33s7
         7i7l1e9aTrRtWGGdAnnz4aGU/i5ESNkdqqBL/nvpgn7eQM8ARoYNqqYHkV0iWRVu97D9
         vQaWPAAUl6yiydy7nPW5Of9xqxU3LruSonblDsdNcjRij7CGEiH68a79bg4eocB5ecoq
         sVMBVx6v+XBcy3McWDFPUbCI2NYthdc8FhsIyfArW6wuzR6Er0niM16qs4jk/dnp0eIW
         wxYQ==
X-Gm-Message-State: AOAM5305rVyx8SEpGSaxg20EwPW3i+Kk+f0yLxp/lDsMrfizjOzD5hzi
        3uKQCZCXHHH1wRuXNGxJUoxt8YTVBhqsw+ITs89Rpw==
X-Google-Smtp-Source: ABdhPJwSSJnrlAzsV2jt4uCWD6qcDAizD+TNItTwqDfRwCeO5v+KDCnfqAGa4BvUy1vklgAyg43wTmS6E8vlsISO/7Y=
X-Received: by 2002:a81:1b55:0:b0:2f7:cefd:9b51 with SMTP id
 b82-20020a811b55000000b002f7cefd9b51mr7129871ywb.120.1650874234577; Mon, 25
 Apr 2022 01:10:34 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 25 Apr 2022 13:40:23 +0530
Message-ID: <CA+G9fYscb1y4a17Sf5G_Aibt+WuSf-ks_Qjw9tYFy=A4sjCEug@mail.gmail.com>
Subject: page_alloc.c:(.init.text+0xa7c): undefined reference to `vmalloc_huge'
To:     linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Song Liu <song@kernel.org>, Muchun Song <songmuchun@bytedance.com>,
        Christoph Hellwig <hch@lst.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux mainline arm architecture tinyconfig and allnoconfig builds failed.
These builds have config mmu not set.

# CONFIG_MMU is not set


Regressions found on arm:

   - arm-clang-14-tinyconfig
   - arm-clang-nightly-tinyconfig
   - arm-gcc-11-tinyconfig
   - arm-clang-13-tinyconfig
   - arm-gcc-11-allnoconfig
   - arm-clang-14-allnoconfig
   - arm-clang-nightly-allnoconfig
   - arm-gcc-8-allnoconfig
   - arm-clang-11-allnoconfig
   - arm-clang-11-tinyconfig
   - arm-gcc-9-allnoconfig
   - arm-gcc-9-tinyconfig
   - arm-gcc-10-allnoconfig
   - arm-gcc-8-tinyconfig
   - arm-gcc-10-tinyconfig
   - arm-clang-12-allnoconfig
   - arm-clang-12-tinyconfig
   - arm-clang-13-allnoconfig


Build error:
------------
arm-linux-gnueabihf-ld: mm/page_alloc.o: in function `alloc_large_system_hash':
page_alloc.c:(.init.text+0xa7c): undefined reference to `vmalloc_huge'
make[1]: *** [Makefile:1158: vmlinux] Error 1


# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake

tuxmake --runtime podman --target-arch arm --toolchain gcc-11
--kconfig tinyconfig


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


--
Linaro LKFT
https://lkft.linaro.org

[1] https://builds.tuxbuild.com/28GNGapkjXsbIbRSnHoGILqmaFp/
