Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6580C470943
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245557AbhLJSuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239005AbhLJSuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:50:40 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC57C061746;
        Fri, 10 Dec 2021 10:47:04 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id de30so8657917qkb.0;
        Fri, 10 Dec 2021 10:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ju9sIZBRyEsHZQ7xPVmI/d5eXqoqem5zt4WkakOQBZY=;
        b=Gfcii0qEAnukZtC8p1YyLcw7dsquwLGZQMYLztMBeGWd14eHW2F2QommN9kCAin4e9
         O6ACLrKNuVYsDjj+PVK+iHx/OpKQBXs+p0gnK9yZvYRg+grMC6SOAxova/lVj0JKV/hC
         X0PlhFmwwD53E84csTixZlo89knwklPwxVSiMQO1aiNSeFM2zxOmjeDbNtYCksku+2FN
         pWbDHZghj4QoVQFs0XUAL3ZgEYFbGZjFYwCOwO9AoKCW2qAz0+Zf+diwqOg0lxo3mQUL
         F7qhUTgBPuRLsf6q1s+1qgUckre30PXmILOoxNADRavhRwVU+M4pIGM4NqwI8yW+gujK
         7/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Ju9sIZBRyEsHZQ7xPVmI/d5eXqoqem5zt4WkakOQBZY=;
        b=ZTNKc2KPJA5AfYip4KRO1LYeg74EyArtXUL/CDKnZPLcAAXb7Aru6Uh2JOuYKyWKab
         E3/j2C2U1gD3eDX2EVHno1O3dNpIJDht4u22YrCCwujLmbzWHF4IbHJekCREPSCi9Cn0
         mrFzoGdWJJS0P3y2LT1yGDuNFnBcqkNBApEAaJQZ1u3NYA5KIe5Dh/oeTcTs+485ZFuh
         E73NM/gLp8o1QBjVtiTHL6CmqwAnYnM8l+Ij1MIJBukF7YjitCStBL8mUgN4uA52cU5X
         K8EAGLVmt3CNyyb7W8xVoc/ftSD50mLnIAGELEmxqju0OsYt0lMpkn0COlJaUytSkdD/
         p31w==
X-Gm-Message-State: AOAM5302q9Jc7fHVx5K2CbbbXxcGitXAMMviCRxI5f7KQlaFcB6EIX4h
        qFhzMr/7F4dRqrGN2AWmXAn5WlvgXetZjw==
X-Google-Smtp-Source: ABdhPJw+VaMxLVSg0ejMpWbBarmLK2CuChA7OzKaJYUzRzkFgv8yaezyEQlMaPp3fqPXNkiaMIW2BA==
X-Received: by 2002:ae9:e8c5:: with SMTP id a188mr20495137qkg.713.1639162023787;
        Fri, 10 Dec 2021 10:47:03 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-11-174-88-121-95.dsl.bell.ca. [174.88.121.95])
        by smtp.gmail.com with ESMTPSA id c25sm1724641qkp.31.2021.12.10.10.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 10:47:03 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [ANNOUNCE] rt-tests-2.3
Date:   Fri, 10 Dec 2021 13:46:49 -0500
Message-Id: <20211210184649.11084-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm pleased to announce v2.3 of rt-tests

A few things included in this release:

- fixes in cyclicdeadline and deadline_test to prevent double mounting
  of cgroups
- significant clean-ups and fixes to hwlatdetect 
- aarch64 support for oslat
- The addition of the --default-system option in cyclictest
  This runs cyclictest without attempting any tuning. Power management
  is not suppressed so cyclictest measures the system as it is configured.
  This may result in worse realtime behaviour, but is sometimes what you
  are trying to measure.

Thank you to everyone who contributed.

Bug reports, testing, and patches are always appreciated.

You can get this version via git or tarballs as explained below.

Enjoy!

Clone
git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://kernel.googlesource.com/pub/scm/utils/rt-tests/rt-tests.git

Branch: main

Tag: v2.3

Tarballs are available here:
https://kernel.org/pub/linux/utils/rt-tests

Older version tarballs are available here:
https://kernel.org/pub/linux/utils/rt-tests/older


John Kacur (23):
  rt-tests: pi_stress: Fix "id" in help
  rt-tests: Add *.dat to .gitignore
  rt-tests: Update the help and man page for --latency
  rt-tests: cyclictest: Add --default-system option
  rt-tests: cyclictest: Remove unused 'C' and 'E' options
  rt-tests:hwlatdetect: Remove useless object in class declaration
  rt-tests:hwlatdetect.py: Remove multiple statements on one line
  rt-tests:hwlatdetect.py: Remove unnecessary 'not'
  rt-tests: deadline_tests: Null check to prevent floating point
    exception
  rt-tests: cyclictest: Check user supplies an value to histogram
  rt-tests: get_cyclictest_snapshot: print_warning should be a
    classmethod
  rt-tests: hwlatdetect: Remove unnessary parens after return
  rt-tests: hwlatdetect: Use "with" for opening files
  rt-tests: hwlatdetect: Use python3 style super()
  rt-tests: hwlatdetect: Keep consistent name from abstract method
  rt-tests: hwlatdetect: Remove class Hwlat
  rt-tests: hwlatdetect: Use abstractmethod decorator
  rt-tests: hwlatdetect: Remove unused class Kmod
  rt-tests: hwlatdetect: Don't use built-in name str as a variable
  rt-tests: deadline_test: Fix double mount of cgroups
  rt-tests: cyclicdeadline: Fix double mount of cgroups
  rt-tests: deadline_test: Fix typo "highes"
  rt-tests: Change to version 2.3

Leah Leshchinsky (1):
  rt-tests: Add missing option F to optstring

Nicolas Saenz Julienne (4):
  oslat: Rename cpu_mhz/cpu_hz to counter_mhz/counter_hz
  oslat: Add aarch64 support
  oslat: Allow for arch specific counter frequency measurements
  oslat: Avoid out-of-order memory accesses to precede counter read

Oscar Shiang (1):
  rt-tests: cyclictest.8: Remove reference to -n in --system in manpage

Punit Agrawal (4):
  rt-tests: hwlatdetect: Gracefully handle lack of /dev/cpu_dma_latency
  rt-tests: cyclictest: Drop unused defines
  rt-tests: cyclictest: Simplify duplicate initialization of "stop"
  rt-tests: cyclictest: Drop unnecessary variable "bufsize"

 .gitignore                                |   1 +
 Makefile                                  |   2 +-
 src/cyclictest/cyclictest.8               |  17 +-
 src/cyclictest/cyclictest.c               |  40 ++-
 src/cyclictest/get_cyclictest_snapshot.py |   7 +-
 src/hwlatdetect/hwlatdetect.py            | 388 ++++++++--------------
 src/oslat/oslat.c                         |  52 ++-
 src/pi_tests/pi_stress.c                  |   2 +-
 src/sched_deadline/cyclicdeadline.c       |  39 ++-
 src/sched_deadline/deadline_test.c        |  47 ++-
 10 files changed, 288 insertions(+), 307 deletions(-)

-- 
2.31.1

