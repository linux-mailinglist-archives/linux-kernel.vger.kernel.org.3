Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC04465157
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 16:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350623AbhLAPXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 10:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243585AbhLAPXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 10:23:16 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F71C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 07:19:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5313DCE1F4E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 15:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44C1C53FAD;
        Wed,  1 Dec 2021 15:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638371992;
        bh=Sp/4MbnOzapqd7bSQ1CRruSSxVAhqFvmXGbFziA9YIs=;
        h=From:To:Cc:Subject:Date:From;
        b=ApWCgjRRzKu1L1tolWUxs3YFxb7viMBH6N18MXE3ftswPpp6CklE5zODupUBl8KAA
         OUDyiQya42CZWphAIEQ5WWBLLpbfRxKOLmBqyEAvRCIN3PZpCnLGUkbZLADeSUFmpv
         BKDCoIIxAoOA5s9OebgKD2uXFFV1zZ64nck+Hu2kddvCM3WM6ZTKX5P2I8wA40UU/W
         z/+s+xTdKp6vuJu8y/gWzkD9KoNr2vjb0t8Fwo5c/eriU9my8mGI6mY/1bHMJOksUT
         tYaZ4mT2W+KM9Sk+E8WAL7+vxDYd43PexA1+KRLSEjjSaTVg3vCbUNCa3GM5XBdJLU
         G01bHv0Ds7xQw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH 0/2] workqueue: Fix hotplug/scheduler races
Date:   Wed,  1 Dec 2021 16:19:43 +0100
Message-Id: <20211201151945.632214-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's a resend of "[RFC PATCH 0/2] workqueue: Fix hotplug races", with
appropriate tags added and scheduler people Cc'ed.

Thanks.


Frederic Weisbecker (2):
  workqueue: Fix unbind_workers() VS wq_worker_running() race
  workqueue: Fix unbind_workers() VS wq_worker_sleeping() race

 kernel/workqueue.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

-- 
2.25.1

