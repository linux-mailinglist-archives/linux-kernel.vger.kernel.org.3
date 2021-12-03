Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6182467831
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 14:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380997AbhLCNbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 08:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380983AbhLCNbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 08:31:42 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF74C06173E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 05:28:18 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 4BB371F46E3D
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638538097; bh=Qll3Es3WsFBwZ7LkF+WAP4gSfZJI7YbzAjq3kXJEEFs=;
        h=From:To:Cc:Subject:Date:From;
        b=MK3clkmBYzGc/fvXeePiyiEUTFpm12GNs9nF2TFENkxQGl/jBfuPNVulATen6bT7h
         7tXplYoIFLExBCY6ZmM3TCB1zw8gMflxH7wlbgbSntNBwHwVvTmMP0INHOXmV96TcQ
         nA7bB40mm0WVPAxfLbSxCozrFLofHfherD8kFGcubJjZVKr9GP7T524ebXMBGkSM5A
         8d6rFAUerHFdZdT3gRNJ4xzkWGdXNUDEJilZr+o0q858Q/mqlzjZGtbCsJ+gi0e8Zo
         Gi5nQ2p5J3TcAlLBHQnO0nL6zVLE/AvA4rLCS88wxL9CUBjblF95fr2nWYwutqasM/
         I0JPc4mT0Aojw==
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>
Cc:     =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH RESEND 0/2] selftests: futex: Some improvements
Date:   Fri,  3 Dec 2021 10:28:06 -0300
Message-Id: <20211203132808.16907-1-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small patch series makes a futex_waitv() test more correct and test
the timeout for the new FUTEX_LOCK_PI2 opcode.

André Almeida (2):
  selftests: futex: Make futex_waitv's invalid clockid test more robust
  selftests: futex: Add FUTEX_LOCK_PI2 for timeout test

 .../futex/functional/futex_wait_timeout.c          | 14 +++++++++++++-
 .../selftests/futex/functional/futex_waitv.c       |  7 ++++++-
 tools/testing/selftests/futex/include/futextest.h  | 14 ++++++++++++++
 3 files changed, 33 insertions(+), 2 deletions(-)

-- 
2.34.1

