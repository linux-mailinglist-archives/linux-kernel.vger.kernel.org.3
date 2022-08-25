Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433285A0E1C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 12:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241047AbiHYKnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 06:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiHYKno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:43:44 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52EC6052D
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 03:43:42 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id w196so22506644oiw.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 03:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=zrIRGklNoO2a5CD9cGT6cGI8Xi9o//UAgqinYGld0u0=;
        b=sQXkC4Y6tu3f7sZSxSUrG3VeU9KAZZEQED4NsZGoqcDMb0WNORpyF+E/iBBHEmsoQB
         xaUOwG0teJvwgQGIVxC2MCKY3XCNvreq3rzEIidHmHgN0diW3nPGiG4dsK4qmlvJKorm
         AwuxpBrrK+ZSi3mkJxnlGYbvFvBbnnZxsHNcYCCYmChDRISJYUaRuI031uZilmkMmHRx
         SgilGYKlkjKa7jSRsAqnxxTpUrVkDiqJMowEKp2izcKK8j5CEUt4eluqcV2JCKZDonHI
         WodWylzgHS3vgt51nLZt2C3ztyR861IMjyPwCckx9X8DtX28n6IBqapxfdwLyfqWOaoM
         D/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=zrIRGklNoO2a5CD9cGT6cGI8Xi9o//UAgqinYGld0u0=;
        b=Oup3AdsJxDoBIKvlb4K8nYSZAPMJp1EWiZteFWjyen9m6tFw3al/xvTy9lhvMRBHqn
         9wFT8YSNZDpl62pDEgYS2//vbA9v3JtLTFUqzpcNADnrm7e+PCC58FgYVL5jztJWUJMc
         wrLG4MRTfcJVxMwD6189GEIzM5g1825e2TyLrttKbI/4uGU9INzOMi/OsjAsGfgDWBVd
         /O6+o0Arpqxmbhvbo+LsS54YmvnChnhxZQuIb+HctNKVu/ZGDTfk/L8GH0tdlW2R68Sj
         wBZFfbZQe8HYSGcsg5PBkAcL0q59MtwwWsk19z0b/Pv0regez2DSxzoYGSCKyq7p405H
         Q1hA==
X-Gm-Message-State: ACgBeo2S+XOxTDUEP+qNk0GAd6pDtDYES/4DZqrCfpvt73TfbPD12N1U
        29YYA+BpZbI92l+P0kgIXBTn82iA+cXAIVBnuT6U7Q==
X-Google-Smtp-Source: AA6agR4l2jLyUhp4ZTjfG4oWL/P06sEpXpvwrFCJNJhC3/NFHdjStcjUwCLe2srqGsAAQCCGJ4TLcWgBznQ+hKT3H7I=
X-Received: by 2002:a05:6808:1242:b0:345:7e6b:961b with SMTP id
 o2-20020a056808124200b003457e6b961bmr1435273oiv.290.1661424222144; Thu, 25
 Aug 2022 03:43:42 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 25 Aug 2022 16:13:30 +0530
Message-ID: <CA+G9fYsHVdu0toduQqk6vsR8Z8mOVzZ9-_p3O5fjQ5mOpSxsDA@mail.gmail.com>
Subject: [next] x86: fs/hugetlbfs/inode.c:673:16: error: variable 'm_index' is
 uninitialized when used here [-Werror,-Wuninitialized]
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        David Hildenbrand <david@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        James Houghton <jthoughton@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Michal Hocko <mhocko@suse.com>,
        Mina Almasry <almasrymina@google.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Peter Xu <peterx@redhat.com>,
        Prakash Sangappa <prakash.sangappa@oracle.com>
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

The x86_64 and i386 clang builds failed due to these warnings / errors
on Linux next-20220825.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

fs/hugetlbfs/inode.c:673:16: error: variable 'm_index' is
uninitialized when used here [-Werror,-Wuninitialized]
                                                m_start, m_index, truncate_op);
                                                         ^~~~~~~
fs/hugetlbfs/inode.c:651:26: note: initialize the variable 'm_index'
to silence this warning
        pgoff_t m_start, m_index;
                                ^
                                 = 0
1 error generated.
make[3]: *** [scripts/Makefile.build:250: fs/hugetlbfs/inode.o] Error 1
make[3]: Target '__build' not remade because of errors.
make[2]: *** [scripts/Makefile.build:525: fs/hugetlbfs] Error 2

Build link: https://builds.tuxbuild.com/2Dpvef6uVvzHMztbfQRmxJfPXZT/

Steps to reproduce:
-------------------
# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake

tuxmake --runtime podman --target-arch x86_64 --toolchain clang-14
--kconfig https://builds.tuxbuild.com/2Dpvef6uVvzHMztbfQRmxJfPXZT/config
LLVM=1 LLVM_IAS=1

--
Linaro LKFT
https://lkft.linaro.org
