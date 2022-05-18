Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEAB052C238
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 20:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241325AbiERSRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 14:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240092AbiERSRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 14:17:23 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D503A1790AB
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 11:17:21 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id bg25so1569181wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 11:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Bggmgw2wzDGYlbgho3mMqhZZXKrdqGQ+mvq4lMEbodw=;
        b=DLustaHa7pW17xKBst1EEqrUzitV8UWCB+SNKExjlJJJHNzUCLE4NcVj4lRA9kbuIn
         w/J0VxowTd2mp8mwKRcTTMFbnt1z2y0Owrrohmv3QsnIGj0n6lUi5ys1oZuFv1ageP/8
         0k07vdcrBSpfULe7fNd68Xkjs7qtjJ3hZojaM7QfC557Fu6DODoDqOPFlxLwiH9TCB2d
         wAyGTbtfZuBFWJOsI62qvVNgLfsYusek4K7CT50zi/opMT3WDhnZ5KzSfLpA9pKm5FVo
         7emP4Qfq1paAL++3tcU94RSjYWYdadzrViTtYzcu6QvG5ZecOhCY6W/hra/E/Uqxj1a6
         MPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Bggmgw2wzDGYlbgho3mMqhZZXKrdqGQ+mvq4lMEbodw=;
        b=C+sZ/0SFZjNTmR6MiCyNUwqofBOwHEyhpYmTtWGm8pTJpRuy/FrSjdj+v2dHomjA07
         meauxQxfVSTHKZfb+6TE8T29heXhjVrko8AAqO6htgkSeWN2Sd+h8EgcuW37INK4qrJe
         kJ00hxcQYpPgnePpbbVzDyeFw2p5Xo2W4+vsS3+QNPUW8WRlfkpToB/gzsH2Hk7o5Fbv
         lG+mw7vZ8mpXY65hIHY5sWNZRs559XkqaNcCzY3OeIkZUE1/unSJYJbFis1ry/4nFfIN
         /FpLwHfY3ZYBLFQ2kmJKW2O3Wu1LOEX0a8nNUvCmkxtNf6uqCwqOXyZ8srFnRi/dQXeo
         mMvw==
X-Gm-Message-State: AOAM533yI62L5Dv3SrrPWqO64Hv3644EXiTfSsepnrfp02WqEzY0ChoU
        wBP8clJMkDw4KP7cfrfjAG6OsmqQJhal3Z12PNUN
X-Google-Smtp-Source: ABdhPJx7AfExOVGct88UoZgOe9LuGXqMZwTom/bOCohfOLjhnr5yWt1CBE7KobMYz3ZaJO0HNnFLwBeRmjitt3Z/2XM=
X-Received: by 2002:a05:600c:600d:b0:394:5353:507a with SMTP id
 az13-20020a05600c600d00b003945353507amr562727wmb.96.1652897840331; Wed, 18
 May 2022 11:17:20 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 18 May 2022 14:17:09 -0400
Message-ID: <CAHC9VhT+4RXb_q=OkBQY-p1L9OpGF3n8GG+3T3xm=3gGzHKZFA@mail.gmail.com>
Subject: [GIT PULL] Audit fixes for v5.18 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

A single audit patch to fix a problem where a task's audit_context was
not being properly reset with io_uring.  Please merge for v5.18.

Thanks,
-Paul

--
The following changes since commit 42226c989789d8da4af1de0c31070c96726d990c:

 Linux 5.18-rc7 (2022-05-15 18:08:58 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
   tags/audit-pr-20220518

for you to fetch changes up to 69e9cd66ae1392437234a63a3a1d60b6655f92ef:

 audit,io_uring,io-wq: call __audit_uring_exit for dummy contexts
   (2022-05-17 15:03:36 -0400)

----------------------------------------------------------------
audit/stable-5.18 PR 20220518

----------------------------------------------------------------
Julian Orth (1):
     audit,io_uring,io-wq: call __audit_uring_exit for dummy contexts

include/linux/audit.h | 2 +-
kernel/auditsc.c      | 6 ++++++
2 files changed, 7 insertions(+), 1 deletion(-)

--
paul-moore.com
