Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844DF547803
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 02:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbiFLA3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 20:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbiFLA3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 20:29:10 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2E23D493
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 17:29:08 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d13so2215174plh.13
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 17:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=4Q/sbsBjkomwST4aTZhAsNeJKFvpu+xDtqloVlVfOLg=;
        b=JHT7PZ9ZZD0j0KzlWn1RwU14sBn7aZS7dbhcrlfpPgaw+Pm9i+L53mxyqXA+etcCLo
         bIy5Ka/dkbh/bBSRB9EIDLRS1NXIyo+RCP1WbDZBhnq6YJf+KuQDR3C1xbGN+tNPeq0K
         /JjstYxp/3VPJqyUkQZbGGcj+IzJ8PJ0K+4tTmYIKz+u/oAKQKCWjflwYnOHZ1NJOPSc
         jmbvReTpUJvjKf6m8vqFNCF633miLz3lDshZku1G7CVcjUaaqn8ePPy6Xzxt9U8E+F5w
         rt1+HGoro/T6+lky7PGZ4b8YxIzzhOXwXoxys5li/Bkghr25/BQvQ3CCGVVEDJiDxkVI
         K1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:content-transfer-encoding;
        bh=4Q/sbsBjkomwST4aTZhAsNeJKFvpu+xDtqloVlVfOLg=;
        b=F83j/Xi5oB14O7xkkU1Fcy+12ZnN14ATonpWvl9OvKFd2sOXmm4zu+N03ux8osedHg
         4qJLBnAMM/XUTGsZJwYH9MX+W2gf709sS6VlohINa6sZGeRlhEj1CF8tgHDEiSZ/vFKM
         xyEuyjSjiRufIYQdQK4NGDnNHYvd2rutHQuPuzclOIvM2mG/yeqThBPreVEpTCkANAUS
         cLpfcbQ6vXyD7pTy70a/TWo3mqj4de6Wh+PTKEnRXiZQyTVItKS2Zivmq1j9SNSHhVlt
         K7n/6hiRbC/hkhQZCOkWE6o0K4XZ0Zt9A45e1jtVDkmaD0Elc8uo8koYJlJL2XZTp5Ex
         PU+Q==
X-Gm-Message-State: AOAM531px7tmQkbynbndlVwmtkcNmL6gbGyE3zXqRNtxpOewBQ0l+KF4
        iwH7VUcVUu/rqu7BiXeV49M=
X-Google-Smtp-Source: ABdhPJwG7NR6VywCVCaTxqTVKq3bRlmIc8jAY3iZWjGRRu0bFe8lbX7cLp/VZG43b6PGuNEY5xMFWw==
X-Received: by 2002:a17:90b:3b4c:b0:1e8:5e4d:ed83 with SMTP id ot12-20020a17090b3b4c00b001e85e4ded83mr7492507pjb.19.1654993747443;
        Sat, 11 Jun 2022 17:29:07 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id z10-20020a62d10a000000b0051f2b9f6439sm2255519pfg.14.2022.06.11.17.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 17:29:06 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sat, 11 Jun 2022 14:29:04 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [GIT PULL] wq fixes for v5.19-rc1
Message-ID: <YqUzUBjG4N9pKlsv@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus.

First signed pull. Please let me know if anything doesn't look right.
Thanks.

The following changes since commit e71e60cd74df9386c3f684c54888f2367050b831:

  Merge tag 'dma-mapping-5.19-2022-06-06' of git://git.infradead.org/users/hch/dma-mapping (2022-06-06 17:56:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git tags/wq-for-5.19-rc1-fixes

for you to fetch changes up to 8bee9dd953b69c634d1c9a3241a8b357469ad4aa:

  workqueue: Switch to new kerneldoc syntax for named variable macro argument (2022-06-11 14:16:42 -1000)

----------------------------------------------------------------
Workqueue fixes for v5.19-rc1

Tetsuo's patch to trigger build warnings if system-wide wq's are flushed
along with a TP type update and trivial comment update.

----------------------------------------------------------------
Jonathan Neuschäfer (1):
      workqueue: Switch to new kerneldoc syntax for named variable macro argument

Tetsuo Handa (1):
      workqueue: Wrap flush_workqueue() using a macro

Wonhyuk Yang (1):
      workqueue: Fix type of cpu in trace event

 include/linux/workqueue.h        | 66 ++++++++++++++++++++++++++++++++++------
 include/trace/events/workqueue.h |  8 ++---
 kernel/workqueue.c               | 16 +++++++---
 3 files changed, 73 insertions(+), 17 deletions(-)

--
tejun
