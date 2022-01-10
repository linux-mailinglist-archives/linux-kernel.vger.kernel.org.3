Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 262C0489F9F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242489AbiAJSv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242108AbiAJSv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:51:57 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6061C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 10:51:56 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id e19so6623431plc.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 10:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=JxvQWY6Td55cpPe4ui6U3NsBOSwrIQe2vk8UadngD+0=;
        b=QR7VKX11V4OLM6vq5xVfrvgvBJxUyrq2mC2myhxpancjaOBYKMx5YDudsAmuJXJqZS
         fRNyNDfGLVm/0KQUuC2iOPw+xwWYh3OEbIRQBdnpJTbPOgGzuhw0RZpAA+oixXNYu/Xh
         wODEWbW8SpZVkEHwrO+Rcq6wpqBYp8HyUspS8v1cxhSJntF2wpKAaYaE4KWVEhxnzOwk
         sdh47aZOeykgqkvul/vpEYz0xRw+hv8/YRtC2taqgzE6mYkjNG5VvGkZ1xp0Tu/B0bxG
         I4nsQeAYayd7pxj420Gn7KTUShBBXVjXs08ftnSCX0JqpMsJZs65QjDGNOR8owZIYsxa
         gxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=JxvQWY6Td55cpPe4ui6U3NsBOSwrIQe2vk8UadngD+0=;
        b=zTsKZuk1mX9H3/ThERGZwffBmrSXeGS65CUP1h0hYSmtNSoFFK/q/FpGS7pY4okuZ8
         FCSu9KRTmAl+HL15gs52TifzK2+Ss8GjMpG/dONUdY/rB+7agSg4qlO8UVgL//xWUbvq
         QBrT71FuDGCBI0JmmT5/qKYwgymck34X24dRQOgAY2YfkUca2KhikGPMCKcPMuGjfhA9
         mBJa4spNpg/DVPtJ3GXaDPjcJmzCuGIQiCiPRgjYb8nM2nvUKGmVmMdmWKO/eLyokpSh
         Z/RkCc9fPS3SAJlhIsJ/jWzbLOYDiyE8SeJLNAHWOqylWz+EUZNUrN05ObKI8F3crLhm
         j6ag==
X-Gm-Message-State: AOAM532jsdQTKB4zj0KEM6ssEBzsrrhKBOf6Y5D2RaNtWjedIRQqrJTx
        MFKpt7rblZbquUBG8R+REQk=
X-Google-Smtp-Source: ABdhPJzDn7q9VPu0SYHVrmmLHcibQjNXHWcJqnLK84u1eisJyj761gmmr/ofNyGneLyZR3bjz4FtSg==
X-Received: by 2002:a63:2a82:: with SMTP id q124mr944544pgq.614.1641840716307;
        Mon, 10 Jan 2022 10:51:56 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id x25sm7483185pfu.8.2022.01.10.10.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 10:51:55 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 10 Jan 2022 08:51:54 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [GIT PULL] workqueue changes for v5.17-rc1
Message-ID: <YdyASuKnqWo5TUdE@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus.

* The code around workqueue scheduler hooks got reorganized early 2019 which
  unfortuately introdued a couple subtle and rare race conditions where
  preemption can mangle internal workqueue state triggering a WARN and
  possibly causing a stall or at least delay in execution. Frederic fixed
  both early December and the fixes were sitting in for-5.16-fixes which I
  forgot to push. Merged into this pull request. I'll forward them to stable
  after they land.

* The scheduler hook reorganization has more implicatoins for workqueue code
  in that the hooks are now more strictly synchronized and thus the
  interacting operations can become more straight-forward. Lai is in the
  process of simplifying workqueue code and this pull request contains some
  of the patches.

Thanks.

The following changes since commit c741e49150dbb0c0aebe234389f4aa8b47958fa8:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma (2021-12-09 13:20:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.17

for you to fetch changes up to 2a8ab0fbd110dec25795a98aaa232ede36f6c855:

  Merge branch 'workqueue/for-5.16-fixes' into workqueue/for-5.17 (2022-01-10 07:54:04 -1000)

----------------------------------------------------------------
Frederic Weisbecker (2):
      workqueue: Fix unbind_workers() VS wq_worker_running() race
      workqueue: Fix unbind_workers() VS wq_worker_sleeping() race

Lai Jiangshan (6):
      workqueue: Remove the outdated comment before wq_worker_sleeping()
      workqueue: Remove the advanced kicking of the idle workers in rebind_workers()
      workqueue: Remove outdated comment about exceptional workers in unbind_workers()
      workqueue: Remove schedule() in unbind_workers()
      workqueue: Move the code of waking a worker up in unbind_workers()
      workqueue: Remove the cacheline_aligned for nr_running

Paul E. McKenney (1):
      workqueue: Upgrade queue_work_on() comment

Tejun Heo (1):
      Merge branch 'workqueue/for-5.16-fixes' into workqueue/for-5.17

 kernel/workqueue.c | 101 ++++++++++++++++++++++++-----------------------------
 1 file changed, 45 insertions(+), 56 deletions(-)

-- 
tejun
