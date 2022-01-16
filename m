Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211FD48FD99
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 16:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbiAPPXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 10:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbiAPPXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 10:23:01 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9513C061574
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 07:23:00 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id t7so15609317qvj.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 07:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20210112.gappssmtp.com; s=20210112;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition;
        bh=0+19Hzm1LKlWTdEcIqV6bZl7E8816hmTBnOSIqiFrLg=;
        b=PEPDk2JLI3xJtSFNm5KPZ2EluWJrvuNdX+/dhy/+6iyKxChLS9Kkm3R4117b1HKwlP
         ieZGc+ZFsreGjARxlOZCiYOLIbNelcDveykYgep8sJj1+BUsTiFmcJQOdIF+7W/yZepy
         Yed49C9pjp2yF+GxuZjp9fUci3ZTNgTuIXMoys+UOsw7UxgfN34kV3gdKfFRCExZnIbK
         NzokY3wwLQYhzgWxIuJUi8hPa7FOPXR875k8vK0TAatL8qMMFpT0NlXJYsg0aTCuYL3d
         1UGhbHtp6jRejgpaso1oaZH2h0zPU60afXufj/covO5lsdVOaCutyGRriD0grpRshE1X
         pINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=0+19Hzm1LKlWTdEcIqV6bZl7E8816hmTBnOSIqiFrLg=;
        b=f1dY9ufMtDON1EY490VDAwvg1HbOjVXQUnOOJMRqE2KzOiFcZyD/wGOPvJSaTLJCgB
         S5rVfVqqqIwoJs02VHcEcO+rscFqsMzWUjAWQI2frVR+/G4G5CZvgNyZOi/Yxpa1BIIq
         QPaz5Eb5pe+ePoEaRxJjERS3TiCxjiZNln6FWfhiWDZzPUcu+snwAbxNOX7fciqr+QWB
         2tmcT6RR3T38RXOTkBQQUtGe1rkDgyBI9Z1lFaMiYKzNYxogXggIwhcGgMoX1zpBSl/Q
         wcQvlR0q/a5NWuhRjg6iPzDlSyWpnzPWyyLuYM7fhR8wqvFMtijskZZBqPtvi43q4AE6
         np7g==
X-Gm-Message-State: AOAM5339r+mFBZfCq2GKfw2TmLZfuWU80za1nRqMfyxPSzvXTyC9OSxE
        M3xIwDM7JIdsXAUrcVBd+bAwAWQ2HcI2GA==
X-Google-Smtp-Source: ABdhPJwd9SBvkqYcFjI9nCKWj198jCgTTkkJ1C5QhnYt7G/FhVplrAQOtNsZ/yXIbP53e0NzksxNbw==
X-Received: by 2002:a05:6214:ca3:: with SMTP id s3mr12750848qvs.9.1642346580035;
        Sun, 16 Jan 2022 07:23:00 -0800 (PST)
Received: from localhost ([2605:a601:a63c:b500:5f7b:d189:347c:3a5a])
        by smtp.gmail.com with ESMTPSA id bs34sm7198733qkb.57.2022.01.16.07.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 07:22:59 -0800 (PST)
From:   Jon Mason <jdmason@kudzu.us>
X-Google-Original-From: Jon Mason <jdm@n00b.kudzu.us>
Date:   Sun, 16 Jan 2022 10:22:59 -0500
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
Subject: [GIT PULL] NTB bug fixes for vv5.17
Message-ID: <YeQ4Uz9mNkff+ypm@n00b.kudzu.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,
Here are a few NTB bug fixes for v5.17.  Please consider pulling them.

Thanks,
Jon



The following changes since commit df0cc57e057f18e44dac8e6c18aba47ab53202f9:

  Linux 5.16 (2022-01-09 14:55:34 -0800)

are available in the Git repository at:

  git://github.com/jonmason/ntb tags/ntb-5.17

for you to fetch changes up to 8cd778650ae223cd306588042b55d0290ef81037:

  ntb_hw_switchtec: Fix a minor issue in config_req_id_table() (2022-01-11 15:38:59 -0500)

----------------------------------------------------------------
New AMD PCI ID for NTB, and a number of bug fixes for ntb_hw_switchtec
for Linux v5.17

----------------------------------------------------------------
Jeremy Pallotta (2):
      ntb_hw_switchtec: Fix pff ioread to read into mmio_part_cfg_all
      ntb_hw_switchtec: AND with the part_map for a valid tpart_vec

Kelvin Cao (3):
      ntb_hw_switchtec: Update the way of getting VEP instance ID
      ntb_hw_switchtec: Remove code for disabling ID protection
      ntb_hw_switchtec: Fix a minor issue in config_req_id_table()

Randy Dunlap (1):
      ntb_hw_switchtec: fix the spelling of "its"

Sanjay R Mehta (1):
      ntb_hw_amd: Add NTB PCI ID for new gen CPU

Wesley Sheng (1):
      ntb_hw_switchtec: Fix bug with more than 32 partitions

Yang Li (1):
      NTB/msi: Fix ntbm_msi_request_threaded_irq() kernel-doc comment

 drivers/ntb/hw/amd/ntb_hw_amd.c        |  2 ++
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 26 ++++++++++++--------------
 drivers/ntb/msi.c                      |  3 ++-
 include/linux/switchtec.h              |  2 --
 4 files changed, 16 insertions(+), 17 deletions(-)
