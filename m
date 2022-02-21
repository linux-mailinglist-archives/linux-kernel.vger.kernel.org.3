Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB2F4BE2DB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353309AbiBUKRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 05:17:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354499AbiBUKRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 05:17:15 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA41F59392
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 01:36:04 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id c7so13732943qka.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 01:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=bgsGIrytvR2f8/yVo1S/y5IWwN7H3cmZnEMMfAtdWf0=;
        b=K6uaH/fKmHE34Xe2fb+Lte6tPBKBVeS/To/4ZgLRSzPMdkdxqb4jPM9BjUDO5HwrJS
         /DumexTvnBM+dV67Vs5XwaxtsSM6c4R9t8p2bjGklI1qPIFEgvTvorUqkpl2gxMa/Jgi
         QuAr/2QFIDUHUqyIAIZ5X0LQRLKbCCQxnK00Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=bgsGIrytvR2f8/yVo1S/y5IWwN7H3cmZnEMMfAtdWf0=;
        b=GXTPVc6mGcHVOOvliTYe3ZbaB7UnO0F6U9T17DLkaBZ8F41VIeTO2/6D+3BHLM3shf
         DjxkviiY2kL8oYYKO6c5ZuzVhCVH34RrpN63eEDPNpTExX4ZNzWB6UUp75hX38IILpwm
         wV+/cqFIKnJJkE/dCEL+vDWZTkxzRCPZlMaCTAzyoczYnQR4dQk8Q2d0xFU0O98hxfmB
         Du+1BxfrkesM1RuW6mAqRJesHqmtiS18EaEieGAjjJm62EoDQIh3vfFj4Xf1/m27Y6p0
         Iv0zv4W+4DjoqiCOMXsX1twh43vczKzTW57fn4QrB4zqod8DR2g1KVqPN3FEeReGX8Of
         t3ow==
X-Gm-Message-State: AOAM531LHOf3RvJSbInreIz7wyM+YLBchYXgXUjgTaCgYHFiztXkDRUm
        F8KCkSsUMeydZYIZRStQRiThQ18QpkRcUKBdOWU=
X-Google-Smtp-Source: ABdhPJyy1dLnRvjEJlffIU0RqbkI2F+nYxBLcRKQ3Gr9JkqzUFAZaTI4lV+kbX3d3hD5luDdGpsGNPFCz/XvkPsH4pQ=
X-Received: by 2002:ae9:e841:0:b0:508:1f6e:f020 with SMTP id
 a62-20020ae9e841000000b005081f6ef020mr11313921qkg.243.1645436164087; Mon, 21
 Feb 2022 01:36:04 -0800 (PST)
MIME-Version: 1.0
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 21 Feb 2022 09:35:53 +0000
Message-ID: <CACPK8XeofS1jPtKcFgqmwaXfiH+GPCg7c8LhQx8N9m=xOwy=XA@mail.gmail.com>
Subject: [GIT PULL] fsi: changes for v5.18
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsi@lists.ozlabs.org, Eddie James <eajames@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

Here are some FSI changes that I would like you to pull through the
drivers tree for v5.18.

They have been on the list for some time and all have had review.

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/fsi.git tags/fsi-for-v5.18

for you to fetch changes up to f2af60bb7ce2fa5397f401cbf65725d9c87329a4:

  fsi: Add trace events in initialization path (2022-02-21 19:38:54 +1030)

----------------------------------------------------------------
FSI changes for v5.18

 * Improvements in SCOM and OCC drivers for error handling and retries

 * Addition of tracepoints for initialisation path

 * API for setting long running SBE FIFO operations

----------------------------------------------------------------
Amitay Isaacs (2):
      fsi: sbefifo: Use specified value of start of response timeout
      fsi: sbefifo: Implement FSI_SBEFIFO_READ_TIMEOUT_SECONDS ioctl

Eddie James (2):
      fsi: occ: Improve response status checking
      fsi: Add trace events in initialization path

Joel Stanley (2):
      fsi: scom: Fix error handling
      fsi: scom: Remove retries in indirect scoms

 include/trace/events/fsi.h               | 86 +++++++++++++++++++++++++++++++
 include/trace/events/fsi_master_aspeed.h | 12 +++++
 include/uapi/linux/fsi.h                 | 14 +++++
 drivers/fsi/fsi-core.c                   | 11 ++--
 drivers/fsi/fsi-master-aspeed.c          |  2 +
 drivers/fsi/fsi-occ.c                    | 87 ++++++++++++++++++++------------
 drivers/fsi/fsi-sbefifo.c                | 53 ++++++++++++++++++-
 drivers/fsi/fsi-scom.c                   | 45 +++++++----------
 8 files changed, 247 insertions(+), 63 deletions(-)
