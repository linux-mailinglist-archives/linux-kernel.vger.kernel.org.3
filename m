Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E909C48B3A0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242105AbiAKRT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:19:59 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39774 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344150AbiAKRTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:19:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9F9EB81C0F;
        Tue, 11 Jan 2022 17:19:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC30C36AE3;
        Tue, 11 Jan 2022 17:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641921568;
        bh=4WOy8PFtWqhpNOcP0RRCE7km2AQS+xSEKUSjsICm1qY=;
        h=Subject:From:To:Date:From;
        b=G4CCXsyBDanGtXyFJG2vZ2MbhYU0tBmlHwERDaDbfKyXfUM5L/ZncNgexDpQfsC1u
         amkEfJUfrB4P9koGveYluLwfbGZRwxAIJDBOQsxtvDbjs43b1X8fP09uh8M54KGbFt
         89iWr2L+31JYBUmhh1fAfDKn2nzc2/CPG2lbSmp+P+9hzdgYPpxqClolxpu+J1pkqC
         Crs8QVfBTdUeAi85t2TFwiwk3mIpi/Nixz+Oy7PXsT/YZM7F9kN7knrkvkNoGofAQM
         KgoF8Dx4EfhNBkYVjHzcPkNwqKQ2iX6SZhgyuTslJLEhmSJC+UvSpU1bb3stAgK4M2
         IfKohWBtABp5Q==
Message-ID: <82a9c514a3604fca7499d0f9b39baa9e5a8dd3c9.camel@kernel.org>
Subject: [ANNOUNCE] 5.4.170-rt68
From:   Tom Zanussi <zanussi@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>
Date:   Tue, 11 Jan 2022 11:19:26 -0600
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 5.4.170-rt68 stable release.

This release is just an update to the new stable 5.4.170
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.4-rt
  Head SHA1: 4806e14e8b1d4a7196ebd2234afc8feabb6821eb

Or to build 5.4.170-rt68 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.170.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.170-rt68.patch.xz

Enjoy!

   Tom

