Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1785A47B23C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 18:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbhLTRi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 12:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbhLTRiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 12:38:23 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD673C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 09:38:23 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id q17so8652939plr.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 09:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TQtuQ3gg30av/1BnV1Nz1BY8O1mkFDNd4vZX+osFejo=;
        b=JrwmM8/A3dGr/YDqXRzyWFYdA7CTGeznmZE2Bivn7g7l9+EIHPk4yrOD+gJV3WF3d6
         ANImS8Prna+EfaKmftf5e8NIJzwllZ+JGIc4oyhqto1O5tt/PiF2+EzuUdB7gvlTQtz1
         fFaG3G/sEO7hTkZpuDneFOTktvwbV38Hm98IsHINK3HF+dObIbxgFoZz2WC017P2MIpq
         ncgX+VbCaWxWWjyulooEiplTI94u5kHdsjhK70vWvxGVXFym8pPROArT1JqM/8ou2QYl
         K0slwNRlBjNJ6YGQYtRIeoSwpIrKS7gCsHh1nn3+HxACIqmVPYdXWtUYkj+RpSEZYZeb
         smmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TQtuQ3gg30av/1BnV1Nz1BY8O1mkFDNd4vZX+osFejo=;
        b=fVjY5HlXUY8EOWffihJp6A3xh+LbH6DatfEMcRpprJfGxcg0TrDKKdfG8iPonngEzE
         WnlPBh9n9gmvNDJl8J6Mf6DhBAi7W7KZUagmDJk2e3or1O9GFKjNIpuVz1wFDvxhROuI
         WTvaURM84tHwXCxI+AMW6J4gssXS5CtXJws6Dh4KWp3Q8fuLxElndDsajz222H02ZcIT
         r1EhLZh3N/0yAKlcMt+5Xqb3wL/mLPO2m3beWNFP6Mnk4D9qQxVleZ51sTzZ7au3RETP
         NiO8eOeL7wUZaJREryZlJBhljJZli+tvwll1XISErBI1zP0CIsrPHSp7sB7pqZiZ8ZHA
         k3Cw==
X-Gm-Message-State: AOAM532mtdS8oSfYecODD2GkoSb224Yya8mOd8eEH2hweN49jR4JX8V4
        BH+opCTDuBz9eg+r9cFDe7MTrQ==
X-Google-Smtp-Source: ABdhPJxuEVanEQhNMU+1PJ6HmFQxiBaH6JZNwsk/ijF57ZIJVjSwJxDRX/mgZa5ef4NZvfIH9rzsDg==
X-Received: by 2002:a17:90a:d155:: with SMTP id t21mr14628pjw.29.1640021903194;
        Mon, 20 Dec 2021 09:38:23 -0800 (PST)
Received: from p14s.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id u2sm16794pjc.23.2021.12.20.09.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 09:38:22 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Coresight changes for v5.17
Date:   Mon, 20 Dec 2021 10:38:20 -0700
Message-Id: <20211220173820.244995-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/coresight/linux.git tags/coresight-next-v5.17

for you to fetch changes up to efa56eddf5d5c03a90abe708431f16c12c291837:

  coresight: core: Fix typo in a comment (2021-12-13 11:54:07 -0700)

----------------------------------------------------------------
Coresight changes for v5.17

Hi Greg,

I'm sending this a little early due to the holiday schedule.  There might be
another pull request for rc8 in January - let's see when we get there. 
 
This pull request includes:

- A patch that uses devm_bitmap_zalloc() instead of the open-coded
equivalent.

- Work to make coresight complex configuration loadable via modules.

- Some coresight documentation updates.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

----------------------------------------------------------------
Christophe JAILLET (1):
      coresight: Use devm_bitmap_zalloc when applicable

Jason Wang (1):
      coresight: core: Fix typo in a comment

Mike Leach (7):
      Documentation: coresight: Fix documentation issue
      coresight: configuration: Update API to introduce load owner concept
      coresight: configuration: Update API to permit dynamic load/unload
      coresight: syscfg: Update load API for config loadable modules
      coresight: syscfg: Example CoreSight configuration loadable module
      coresight: configfs: Allow configfs to activate configuration
      Documentation: coresight: Update coresight configuration docs

 Documentation/trace/coresight/coresight-config.rst |  78 ++++-
 MAINTAINERS                                        |   1 +
 .../hwtracing/coresight/coresight-cfg-preload.c    |   9 +-
 drivers/hwtracing/coresight/coresight-config.h     |   9 +-
 drivers/hwtracing/coresight/coresight-core.c       |   2 +-
 drivers/hwtracing/coresight/coresight-etm4x-core.c |  11 +-
 drivers/hwtracing/coresight/coresight-stm.c        |  10 +-
 .../coresight/coresight-syscfg-configfs.c          |  87 ++++++
 .../coresight/coresight-syscfg-configfs.h          |   4 +
 drivers/hwtracing/coresight/coresight-syscfg.c     | 315 +++++++++++++++++++--
 drivers/hwtracing/coresight/coresight-syscfg.h     |  39 ++-
 samples/Kconfig                                    |   9 +
 samples/Makefile                                   |   1 +
 samples/coresight/Makefile                         |   4 +
 samples/coresight/coresight-cfg-sample.c           |  73 +++++
 15 files changed, 595 insertions(+), 57 deletions(-)
 create mode 100644 samples/coresight/Makefile
 create mode 100644 samples/coresight/coresight-cfg-sample.c
