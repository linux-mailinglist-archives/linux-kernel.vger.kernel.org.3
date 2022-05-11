Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD8C5237E1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbiEKP5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242624AbiEKP47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:56:59 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F7C2E6BB
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 08:56:57 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2f7d621d1caso26019787b3.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 08:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=tMbUWE6GUv1nmWn5jY/d3TbzjqfiRal7mnHyl6mSSAY=;
        b=KaGFtloNmAoNwJfWR5TNS23GuxmZdqJRVen/7BY9wcaeCroaDVyBsrIpdbO9uKT+ac
         XWYRXQ8edgM5QIiVJ4UGKY00foAZTP1Pq8C50boOAvll3mKwxqJarpcfvi3N5v9fci6I
         SPS14F+aRRHEwYEI+K0QNKkypvWJ8GiUPZzS8qPrZUtolninNqTBdJ0Swbo5p8IVyb7P
         TCZmiQmARQkeyYYY5rwXrYaj4LExgxbY70aGIT6PSfMEG+w8u3b277fAayMrHLcBMa3B
         YZMh8vVKLrvqL1tkejKXZEycIX6WxkIFEUCr9TrQXoP+t6AFk1IJUnXo2TcDLLxo09pq
         44Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=tMbUWE6GUv1nmWn5jY/d3TbzjqfiRal7mnHyl6mSSAY=;
        b=5EnoWcRCorODeDWHtlD9e8ycC/Q2XsrknH/nuvYGp6oPQ148IANc8YjVzKBHL+2V8x
         btpOJnHu3dhux9orxY3HEOlkQE/oCwX1F4zGr3wjmrTNzEfwPTUtPSOF2PiPMc/uLDWO
         Fm83SAA308I5NZofjI0EEeWffPmk7IhD2P06SrZo718/iv2vdQ34OZaVV5Cw1/YzQj8J
         bnZH9mHg+2V62FExEhVaniszth99lCKCXzo/qthWXLeBmo3HDlSxjx/Jrwt28C8DjaU2
         iieG9O2HYEjcJsBNdKixDbbJAUhLxq9FN3YeZCgbFpmlKXQ9SM4XHJ6R6XLUevWym0oc
         Lf/A==
X-Gm-Message-State: AOAM530sjlB/laiAPnAPpPcsWPzlzz6BqJb8JhNZ+Uhn2YCFXP5IAP+p
        ofSdPidJEnWFsKaP9lkpi5eKNvrOSoe6oNfdC4ldtA==
X-Google-Smtp-Source: ABdhPJwfiCk+4rp6a194iwdP+jNLBhayr3fsevneoNtL9o8x2f3f80taDnfHY+cFI2s/+XLcOt34GlbnTgv+Bez/bYc=
X-Received: by 2002:a0d:d88c:0:b0:2f7:bb41:1bd0 with SMTP id
 a134-20020a0dd88c000000b002f7bb411bd0mr25320456ywe.199.1652284616800; Wed, 11
 May 2022 08:56:56 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 11 May 2022 21:26:45 +0530
Message-ID: <CA+G9fYtS5fXzbODO3+Rz7VE4VvjY_1c99Da5UhruXi16jcVGbw@mail.gmail.com>
Subject: [next] sh: hugetlb.h:27:1: error: no return statement in function
 returning non-void [-Werror=return-type]
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, lkft-triage@lists.linaro.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following build regressions were noticed on sh builds on linux next-20220511
with gcc-11, gcc-10, gcc-9 and gcc-8.

Regressions found on sh:

   - gcc-11-microdev_defconfig
   - gcc-11-shx3_defconfig
   - gcc-8-defconfig
   - gcc-9-shx3_defconfig
   - gcc-8-dreamcast_defconfig
   - gcc-10-defconfig
   - gcc-10-microdev_defconfig
   - gcc-8-shx3_defconfig
   - gcc-8-microdev_defconfig
   - gcc-11-dreamcast_defconfig
   - gcc-9-microdev_defconfig
   - gcc-10-dreamcast_defconfig
   - gcc-11-defconfig
   - gcc-10-shx3_defconfig
   - gcc-9-defconfig
   - gcc-9-dreamcast_defconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

In file included from include/linux/hugetlb.h:757,
                 from mm/filemap.c:36:
arch/sh/include/asm/hugetlb.h: In function 'huge_ptep_clear_flush':
arch/sh/include/asm/hugetlb.h:27:1: error: no return statement in
function returning non-void [-Werror=return-type]
   27 | }
      | ^
cc1: some warnings being treated as errors
make[2]: *** [scripts/Makefile.build:295: mm/filemap.o] Error 1


Build url: https://builds.tuxbuild.com/291BWxg5eELaKSwUXNLIqh5w1k3/


--
Linaro LKFT
https://lkft.linaro.org
