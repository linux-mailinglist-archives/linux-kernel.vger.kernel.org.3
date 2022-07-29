Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96FA5854D5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 19:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238463AbiG2R7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 13:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238433AbiG2R7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 13:59:44 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D7D89AA0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 10:59:44 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id a7-20020a17090a008700b001f325db8b90so4525069pja.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 10:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc;
        bh=/ENQqPLRoJRbMVkX1wmQ6qae0JX0xPSFKgibdKp4RAs=;
        b=SH/B04hsFCmdpKcsyBYcqXgZl2Wr0HD0iKMyOb2J4hz+YsNfHUJzoLG0qMeLQ0PD3N
         xFs+37LTkgg5PqBWZ4UkrLp7+WcYkLvHaHZ7aesOSxw1o6SZZ2JNXxhFnanPry1o0AUF
         KncJTaJH2hC74Pzxmnb+9+gMDE6j2dNnfTNo4qLW4AA4if/KRWVLIyFnsW1P30Vo9JNS
         pPutWi1E7ULqZ5BLpJjmc93M0nctsbqjPW7qKTe3FmMcT3DGSwxlPjuNa19NQADkvS/N
         bII1whd1DQf/PQClvxbWRndA5ORfFBjb3BPJHiOGNthAKRouCWLjOA9QtGWXbYIGYJvB
         NtUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc;
        bh=/ENQqPLRoJRbMVkX1wmQ6qae0JX0xPSFKgibdKp4RAs=;
        b=HoSiTk4GUftj7h2Ug1dksDrgzIBdM/Xy3bb5z8JsXmnIj/D6OKfjlTGjdi/JxYkbD+
         /2O/z/2CY/4jvuJR0s03jglU6PqXcM5VnzQImEgiitc5RkPp14lW5k3RbtkQRUdi3oTB
         VfDDiELKM8vLp6+rqaRqM/S8dnz5yMquo+juzo/Eega0Pmg/N3nxkOtwYVrU12nDaeSV
         +0iCzIEBpoOyqu8fRnJWcMJRI7tqtxiSwfi6Fis4o1MsmygPEsatQNxKWLjCc5wsWHLs
         FmA7voWJUjG1jYVXg6oGXZvmxkhS0ZQWvzbVV+81H7OwW9M/e1aYSQjRYW5WknB7wesg
         VoTg==
X-Gm-Message-State: ACgBeo07tZGoYGwteounFWp6L2EHc/MCZZjW8KGfs/zk6KuAhDwHxrl1
        SjP0PwEJLyuyiETK08G14vk=
X-Google-Smtp-Source: AA6agR4ZNrj5L0AXfPUftArB5o85fgtf6hImcDDlQ0fqoOLa1eqD6dBIoD3j3roEGVP0erQrkzkpyg==
X-Received: by 2002:a17:902:bd86:b0:16d:b0eb:974b with SMTP id q6-20020a170902bd8600b0016db0eb974bmr4988732pls.84.1659117583424;
        Fri, 29 Jul 2022 10:59:43 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:df80])
        by smtp.gmail.com with ESMTPSA id q17-20020aa78431000000b0052badc0f3d7sm3214490pfn.50.2022.07.29.10.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 10:59:42 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 29 Jul 2022 07:59:40 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [GIT PULL] workqueue fixes for 5.19-rc8
Message-ID: <YuQgDORbY8eFIJU1@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 8bee9dd953b69c634d1c9a3241a8b357469ad4aa:

  workqueue: Switch to new kerneldoc syntax for named variable macro argument (2022-06-11 14:16:42 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-5.19-rc8-fixes

for you to fetch changes up to 46a4d679ef88285ea17c3e1e4fed330be2044f21:

  workqueue: Avoid a false warning in unbind_workers() (2022-07-29 07:49:02 -1000)

----------------------------------------------------------------
wq fixes for v5.19-rc8

Just one commit to suppress a spurious warning added during the 5.19 cycle.

----------------------------------------------------------------
Lai Jiangshan (1):
      workqueue: Avoid a false warning in unbind_workers()

 kernel/workqueue.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
tejun
