Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77E057BAB9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240905AbiGTPon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbiGTPom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:44:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7D56393D
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:44:40 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658331878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mR2x4aAysd+uTrhGUBdMovn4YEzfc+ZOF6QaXEqhOsM=;
        b=MmSWgD5J9hglnzb7RQTy+qmMv8ewWG66bm7jdNR4P0UhHV5QPFtDtXnuS4N+DuAOh2okxR
        bk/du7KwouFLYQPrTZCDIfSogVlF4Y83+Wn9oN7snAGqUnZBdnM/YCejok00aRA1Us+fHf
        /HRve4lBaT8JuFV5QGGe0z4y4G7dalovW5jWz0rrDXQcm3ctEaLKF8WygWAKpexXHJgxOU
        /ssv9BO8MdITS/OCqEtXgP7dQKxFJ78vDU0BmKbZdHjlMX8m1GevComY/FPy4i6RMX8gFA
        YCykCeKErFrV1WaumxHlI+joye6EzdM0qRGEI6FjfjBEaRK5jeAR6enjtY9lFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658331878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mR2x4aAysd+uTrhGUBdMovn4YEzfc+ZOF6QaXEqhOsM=;
        b=BPy4xi3QXNnAQKIOApMXCfJSw+SG4lhP+yHna8hO5q/Ph8mY3EsuebJAFRWhvWARzr69KX
        12N6xGTC74TG0gBg==
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 0/2] signal: Last two bits for PREEMPT_RT
Date:   Wed, 20 Jul 2022 17:44:33 +0200
Message-Id: <20220720154435.232749-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This are the last two signal/ptrace related bits to get PREEMPT_RT
working.

Sebastian

