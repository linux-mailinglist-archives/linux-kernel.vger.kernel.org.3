Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338634ABE52
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 13:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391598AbiBGMCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 07:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388522AbiBGLnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 06:43:53 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C73C043188
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 03:43:52 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id p5so38883897ybd.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 03:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=DqWgmzwxtL264zlQQi/aWGo5dgkPVyz0CHwO9F0ARvI=;
        b=ZAikxu6W0Tse6pSUT3PJpXsbcq5ghw55uIWE0umxyXZEov02vMAXWebaGqeBOBgn56
         1Ha7T/JXuYFUlO62olgXb4gI02cv2zI720VybXH7rTrhWTBUAWHZ0eqruQ/fT3laLs2m
         8xgr98g8CCxRpqF6yQM70NsJIvRyh0tiu4PzuAhMG1fQ5TnCE+K2YpSjIv0HSRPbvolC
         dSL5QjqZ7/EKycgejQkK04Ol4o2V9r0x1MBrSnexX4x/L5LxY2olpuQHEfhCNnPBek5c
         gnOQ/9kW1rge0Fii1i9jjtMDIhLyhKfNm83PewOARZF4Q4wlL7RCg02SEhj8UL1HBC/S
         e25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=DqWgmzwxtL264zlQQi/aWGo5dgkPVyz0CHwO9F0ARvI=;
        b=hMqJ+7Ln3szNB8sma17G1RSgD6MkVbF/l3K2T8KtvDEZiIH5MUnZVq8305v1t1Kr83
         eX/N7HqXITkvczN70FQcAWQKBnOLDOBohknoYCxQTBjidgWx3786iWoUJVbthfXtrqoK
         oBQ8PtnOLfr83uJ7n529c5sZUOYhqLZvzll84mijEaG5JCOBNBGKNyabd+MIlR1k8uRG
         n1u3ZRGceJwc4J/XTUV3VA4q1SQKtTmiOShHuPzS9xic8ZjPCH6y6TGMO98ZqPOUPH8V
         6U6Wn0/aLPRKtjHKuKfQGRVbNMh2wntBgR2IOgA0nmdG0/PeQWnAgVyJzZtaHUPoW097
         /G0A==
X-Gm-Message-State: AOAM530h0KNtmqctgy+Yagf5uSzewe4zMsM+Mujdcu2fa/ezPvMyG0IT
        iRP67WYcBKk8/tsMCFGSxTPuDfPAnJcsHX7b6NFDwf0Ol6Y=
X-Google-Smtp-Source: ABdhPJw/wYJhy6Xitu0IqzKj85on6zJBb6VfDZyyxSheyccof0ONf81+HJUrXnY2Ll7yMc9fC0rcJahUmQTUQMqcTTA=
X-Received: by 2002:a81:b662:: with SMTP id h34mr10605194ywk.366.1644234230804;
 Mon, 07 Feb 2022 03:43:50 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 7 Feb 2022 17:13:39 +0530
Message-ID: <CA+G9fYsZuC=36zJoj2UPNhF3hQTf-osgs-m59Zey3TB_E0wZUg@mail.gmail.com>
Subject: [next] fs/proc/task_mmu.c:1444:14: warning: unused variable 'migration'
To:     open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     Yang Shi <shy828301@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>,
        Matthew Wilcox <willy@infradead.org>
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

While building Linux next-20220207 for arm architecture the following
error was noticed.

make --silent --keep-going --jobs=8  \
     ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- \
     'CC=sccache arm-linux-gnueabihf-gcc' \
     'HOSTCC=sccache gcc' \
     vexpress_defconfig

fs/proc/task_mmu.c: In function 'pagemap_pmd_range':
fs/proc/task_mmu.c:1444:14: warning: unused variable 'migration'
[-Wunused-variable]
 1444 |         bool migration = false;
      |              ^~~~~~~~~

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
https://builds.tuxbuild.com/24lg0EnsbEf6deWnMXwXiwh8oVi/

metadata:
    git_describe: next-20220207
    git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
    git_short_log: b3c0a155ef77 (\"Add linux-next specific files for 20220207\")
    target_arch: arm
    toolchain: gcc-10


--
Linaro LKFT
https://lkft.linaro.org
