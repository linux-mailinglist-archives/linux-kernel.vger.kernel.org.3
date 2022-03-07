Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B794B4D03D4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 17:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244083AbiCGQRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 11:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244105AbiCGQQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:16:49 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB4F673CB
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 08:15:52 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id u10so12168730ybd.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 08:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=spwDtQzqov6xdiTHgUF8tLqNnixH1cAZ4fX4lvN00K8=;
        b=YMW8qBaid5dvLq5OwhT4QKS7JaLl4pwVUvKdJuM8oLuDEXzs3Ja8XsVC3LmRUmBA5L
         XixXz1apmC69SdQdg75afaQvgrXvXW64tVEJE5rDIYGcxaOVtrvwz0HQt4nz2ryVBjkf
         MOh+u6+W3QpVSxVH7Fb4G6NuD6XAdUgrVqJVd62a1C08QYUvmofdAEtD5Bw5B03qWrI8
         Of3ezMFve7k3YnARANbLVma/aTo2XxuRycQye7xkXZ4QTGluJ535teRfPWinMlZnqdC4
         cA5Slvdh63OrJGgvgBiOW4qBq+SI96rqP8i1S1ZUI1jiQxPRBPr95ecXkcP0egXFjSlJ
         mdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=spwDtQzqov6xdiTHgUF8tLqNnixH1cAZ4fX4lvN00K8=;
        b=RWKTBZgS/6AIfrIsQQ0jB/KcCqw7/sCZWoenY+Rr92GVyyjHsa8dNfonDRqhKa2KEp
         RKELwYWG5x40YSwp2Jp053lxXepLRJo1Hc1QPcozDUiJUjgoqkjIuDaVxyDsP5HCbqOh
         aRuTXaeMs+lDkWWzr/04H0Rs4G2ezvrp9JTnILG/iyXPGcmCCZxmg7vbp69VQFQStk7f
         jMk6w+wUDxfJzK2MewmYshJ7Ht/dG/QlRFplOMpwXzFxBbR5PADHFUBdp9l3Jae/+Xgv
         JrPwgsygalRx4WNiCI5FY1hSJNmbvRQldJdS0kqEDaAFqnfEvhvX33iW085lnzB22JOv
         NpjA==
X-Gm-Message-State: AOAM5328asHCMTiQkwjnlifJXvS+Rb32AemmNciF80kwv+LVLk+vtybS
        Y0U8CmSdIagJge4fXlXVzl6Uf+scqmAw2+THJimL6W1QUE7puvhq
X-Google-Smtp-Source: ABdhPJyH6OsbVtlkeAFYfqwo3AyM1XU37cjXeL8SCsyz/DMGLrisARoYY0Yp87mAHDLeNTkaC2kjPxReAEeFJoT+7eM=
X-Received: by 2002:a25:5090:0:b0:628:b76b:b9d3 with SMTP id
 e138-20020a255090000000b00628b76bb9d3mr8777009ybb.128.1646669750789; Mon, 07
 Mar 2022 08:15:50 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 7 Mar 2022 21:45:38 +0530
Message-ID: <CA+G9fYvPdufo6c3MgPjAMBrkTqoLDO+2LN1PV3V8rTsqN5XSFg@mail.gmail.com>
Subject: [next] mips: madvise.c:55:7: error: 'MADV_DONTNEED_LOCKED' undeclared
To:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shakeel Butt <shakeelb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>
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

Following build regressions errors/warnings noticed on mips architecture on
linux next-20220307 build.

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/1/build ARCH=mips
CROSS_COMPILE=mips-linux-gnu- 'CC=sccache mips-linux-gnu-gcc'
'HOSTCC=sccache gcc'

mm/madvise.c: In function 'madvise_need_mmap_write':
mm/madvise.c:55:7: error: 'MADV_DONTNEED_LOCKED' undeclared (first use
in this function); did you mean 'MADV_DONTNEED'?
   55 |  case MADV_DONTNEED_LOCKED:
      |       ^~~~~~~~~~~~~~~~~~~~
      |       MADV_DONTNEED
mm/madvise.c:55:7: note: each undeclared identifier is reported only
once for each function it appears in
mm/madvise.c: In function 'madvise_dontneed_free_valid_vma':
mm/madvise.c:789:19: error: 'MADV_DONTNEED_LOCKED' undeclared (first
use in this function); did you mean 'MADV_DONTNEED'?
  789 |   if (behavior != MADV_DONTNEED_LOCKED)
      |                   ^~~~~~~~~~~~~~~~~~~~
      |                   MADV_DONTNEED
mm/madvise.c: In function 'madvise_dontneed_free':
mm/madvise.c:859:47: error: 'MADV_DONTNEED_LOCKED' undeclared (first
use in this function); did you mean 'MADV_DONTNEED'?
  859 |  if (behavior == MADV_DONTNEED || behavior == MADV_DONTNEED_LOCKED)
      |                                               ^~~~~~~~~~~~~~~~~~~~
      |                                               MADV_DONTNEED
mm/madvise.c: In function 'madvise_vma_behavior':
mm/madvise.c:998:7: error: 'MADV_DONTNEED_LOCKED' undeclared (first
use in this function); did you mean 'MADV_DONTNEED'?
  998 |  case MADV_DONTNEED_LOCKED:
      |       ^~~~~~~~~~~~~~~~~~~~
      |       MADV_DONTNEED
mm/madvise.c: In function 'madvise_behavior_valid':
mm/madvise.c:1129:7: error: 'MADV_DONTNEED_LOCKED' undeclared (first
use in this function); did you mean 'MADV_DONTNEED'?
 1129 |  case MADV_DONTNEED_LOCKED:
      |       ^~~~~~~~~~~~~~~~~~~~
      |       MADV_DONTNEED
mm/madvise.c: In function 'madvise_dontneed_free':
mm/madvise.c:865:1: error: control reaches end of non-void function
[-Werror=return-type]
  865 | }
      | ^
cc1: some warnings being treated as errors


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

steps to reproduce:
# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake

tuxmake --runtime podman --target-arch mips --toolchain gcc-10
--kconfig rt305x_defconfig


Build log [1].

--
Linaro LKFT
https://lkft.linaro.org

[1] https://builds.tuxbuild.com/2639g1Qugd13m3pgWwKp4I34Cb1/
