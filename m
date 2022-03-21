Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67294E3181
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 21:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352981AbiCUUOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 16:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353824AbiCUUNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 16:13:39 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE05195D92
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:11:45 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id jx9so91564pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=GRTJ3z9kr+ZMTi887PQDmXrT042NqksLTniuRsYDq+0=;
        b=dKOkYG1/Q//rVjsAYrTYx6OeMeecCd7pQMxEJNPNmL0I22ozrLsgdPpSQcTBQLriXt
         2RK0XOapLpdhWIy+/0afeI2tS8ES+l2Qo56yKXAljAFwgZMn1DbKa1DBeD04vOdd9a0j
         Mg4Wz7wDWP1LJsqvVFk+wOFV8usuOdpTsgxkxYUF8iopEMeclSki1zAdz47nPILBBpx2
         rRNLkS8HLT3LjN6S9eyyEZubppw4SP6LVoJpINm7amKVzR8VYv4sT/tI1h5cKa9yhImK
         FCH/zVcU6Kg7DQr9hFPJXxfhVSFVx1Y+l1yUSYrIr3rRaELjaaJ3ummFIuhvXvKcQZA0
         4rNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=GRTJ3z9kr+ZMTi887PQDmXrT042NqksLTniuRsYDq+0=;
        b=Ph+MzUINi1o+LZ5FlinCwSBAo73Vo2f1LkGEANzpr3lLjlzP1tbjT8HBYTbWSgY6TD
         TyCq84aVTkr5c4LH8UeEXbGFwaH31z7kRnhiAqZoI5TXxxXPi9PiTFM+N0qvc+MFYXMh
         VTI3xjtnw1F19At5EsM0k4tVZ0qo/d8uYldQLdlZIdnNrwRnkxCBID0qDqsf3/AT71C1
         QGkM48ODix5QDiiYw89vTg7bq3nYDdSjlooOH08SQueoCJoEhB3LqQTVimmE5QEpLw6Q
         pp1XV6/OgKRYsKi4Gtq4ytDd7Zi+5mNX0Ey14twYzfMGcYnImUxroahPK50Ct14Lr//1
         F5lg==
X-Gm-Message-State: AOAM533PJDb5LsJIFO15qZx6Q8QM+BqoTvYCQaefU7DhsKVLvUrdXDfh
        5CCmhR0hzdPfr/CzRPTvl30=
X-Google-Smtp-Source: ABdhPJwgDwHuIFAon5Xv3pvyosEkL2wWYJloZBE528MbfnXHUJXQuhvM0dP+KmOJVsswKlwPhPgpOA==
X-Received: by 2002:a17:90a:f011:b0:1c7:1800:a86d with SMTP id bt17-20020a17090af01100b001c71800a86dmr854630pjb.175.1647893504032;
        Mon, 21 Mar 2022 13:11:44 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id y34-20020a056a00182200b004f71c56a7e8sm20418740pfa.213.2022.03.21.13.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 13:11:43 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 21 Mar 2022 10:11:42 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [GIT PULL] workqueue changes for v5.18-rc1
Message-ID: <Yjjb/qouuLRtV2XW@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Workqueue changes for v5.18-rc1. Nothing major. All follow-up cleanups from
Lai after the earlier synchronization simplification.

Thanks.

The following changes since commit daadb3bd0e8d3e317e36bc2c1542e86c528665e5:

  Merge tag 'locking_core_for_v5.17_rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2022-01-11 17:24:45 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.18

for you to fetch changes up to bc35f7ef96284b8c963991357a9278a6beafca54:

  workqueue: Convert the type of pool->nr_running to int (2022-01-12 07:46:36 -1000)

----------------------------------------------------------------
Lai Jiangshan (4):
      workqueue: Remove the mb() pair between wq_worker_sleeping() and insert_work()
      workqueue: Change the comments of the synchronization about the idle_list
      workqueue: Use wake_up_worker() in wq_worker_sleeping() instead of open code
      workqueue: Convert the type of pool->nr_running to int

 kernel/workqueue.c | 58 +++++++++++++++++++-----------------------------------
 1 file changed, 20 insertions(+), 38 deletions(-)

-- 
tejun
