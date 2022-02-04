Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4014A9A4F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 14:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359021AbiBDNvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 08:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbiBDNvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 08:51:14 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE83EC061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 05:51:13 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id y17so5190196plg.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 05:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u5sNLEWltEO9XSUZse3WnvAq31puwDAMnxkYi3RsNzI=;
        b=weU0rv5RqPcTmEvnEL4NAMxTPzCi4f5hR3dPo/wNUnNZMERSPyIYUBJgmq+twoeQa+
         eS1wtQ9JoiWmB6s4IMR2MxZc5dn7iIHVCUuSmZgMl5NuHVRLSSjQB9P6JHC5/TU1BQqJ
         tpZruGka6ANLsfU2SDx/6pKMeX8nAxKgnXx5p/qyOGKVF3uGyOX7H7UEJYiLnqc60zvI
         tJnxyp+E1ErJ9t5xBX5T4PpPEdWeIMZfEVqdbOBAacqq9zXZQb09H8mj4J35zjF1kM+H
         zvTrOLyyoXM8ZptOXa4yGzl/mF2GY/4MD5fci4QnK1qeEpWDe2Bqe6uTfvxvkqPRSKKU
         yBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u5sNLEWltEO9XSUZse3WnvAq31puwDAMnxkYi3RsNzI=;
        b=6DPFYzsgEHthgFIwoPLGJAeoynEXaW2TMKfFGaB9QWDIXqh/c5FezaG2vysft2+WDB
         +UlPCjqDbMnk8pz3jkZSBn+30HdUsCoTLwXIA57wiJTopmY6/C8ks22XSG+qsfREkIkO
         gg+MSze7HK/lkagu7vSAzOlaKtkd1QNaM+5K378VCYUv6rCVZRfuzqxdB2XE9oCGjpKu
         J86uC7IzsP7yUlRG2F9kFmtkAZ1caQIaE7yA+PoLLQBRifkeTGT9E/teOxi3Eo6e1ED0
         2bwfzO3UIPRdMgQexobPJJvULukTkUkTroMkT5J0x+Fxg0iV0Nvz6cIlWjzTsYMQ0Gus
         cEkA==
X-Gm-Message-State: AOAM530m+QYHxAoAcOw/Az3wkZUQKIVNPWaj7JIbpMqz8FDZE6zvVSh0
        h/4NnnrQFzqTILOjXyTFiJTedA==
X-Google-Smtp-Source: ABdhPJxnCHeJhKawk6/bntlj5jOatwwt089k4bZ/GwP2S/068NafWmqyZjaWvIgt5/Xm5Fwjn6drgQ==
X-Received: by 2002:a17:902:7ec1:: with SMTP id p1mr2921036plb.159.1643982670319;
        Fri, 04 Feb 2022 05:51:10 -0800 (PST)
Received: from localhost.localdomain ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id 13sm2668131pfm.161.2022.02.04.05.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 05:51:09 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Balbir Singh <bsingharora@gmail.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, codalist@coda.cs.cmu.edu,
        linux-audit@redhat.com
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 0/5] pid: Use helper task_is_in_root_ns()
Date:   Fri,  4 Feb 2022 21:50:46 +0800
Message-Id: <20220204135051.60639-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The helper task_is_in_root_ns() has been merged into the mainline kernel
(thanks Jakub Kicinski for merging the patches [1]).

On the other hand, there have 5 patches were left out in the patch
series v2 [2], this patch series is to resend these 5 patches so that
sub-module maintainers could pick patches without concerning dependency
issue.

This patch series can be cleanly applied on the mainline kernel with
latest commit dcb85f85fa6f ("gcc-plugins/stackleak: Use noinstr in favor
of notrace").

[1] https://lore.kernel.org/lkml/20220126050427.605628-1-leo.yan@linaro.org/
[2] https://lore.kernel.org/lkml/20211208083320.472503-1-leo.yan@linaro.org/

Changes from v2:
* Added review and ack tags.
* Dropped two merged patches and resend the left 5 patches.

Changes from v1:
* Renamed helper function from task_is_in_root_ns() to
  task_is_in_init_pid_ns(). (Leon Romanovsky)
* Improved patches' commit logs for more neat.


Leo Yan (5):
  coresight: etm3x: Use task_is_in_init_pid_ns()
  coresight: etm4x: Use task_is_in_init_pid_ns()
  coda: Use task_is_in_init_pid_ns()
  audit: Use task_is_in_init_pid_ns()
  taskstats: Use task_is_in_init_pid_ns()

 drivers/hwtracing/coresight/coresight-etm3x-sysfs.c | 8 ++++----
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 8 ++++----
 fs/coda/inode.c                                     | 2 +-
 fs/coda/psdev.c                                     | 2 +-
 kernel/audit.c                                      | 2 +-
 kernel/taskstats.c                                  | 2 +-
 6 files changed, 12 insertions(+), 12 deletions(-)

-- 
2.25.1

