Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1309254040F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 18:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345185AbiFGQr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 12:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345174AbiFGQrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 12:47:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718671D0F8;
        Tue,  7 Jun 2022 09:47:54 -0700 (PDT)
Date:   Tue, 7 Jun 2022 18:47:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1654620473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=lSDsywJB6k683pdbQfJxNfS1KPID3mBqEa5Vp/AoDIo=;
        b=gWEdLbsAZVKjwpgZjroM0UejhNMN1fzFdMInH76EPGB31BBw8H88bkzk1NUqwGekEkrGcY
        dY4EKc0DWHVI8W+BBz/lDyyjKcqA6bo61ikjKPdpaaV9CETAv4MWUuoUGiV0wHUpjWOC2P
        ksQs6+CZApMQdGX5boy/psrG8ktcPjqe7jdjIWCLdXI/GvEnUnrs+aRhCWtcR08SeqW3xu
        bLN5DIGJPfHRwJyVYWzF6jYRrF6rpDQpFs59GaoGxJPhxszDdGjMJvMks3WScjlzp9qi+N
        TYF8byAqPqSLVWIhdHFC+ohY1sgV//EatJ3Rqxzn87tFgtMHt/s73n1+QAhv5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1654620473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=lSDsywJB6k683pdbQfJxNfS1KPID3mBqEa5Vp/AoDIo=;
        b=MAH7c61VNSM9hWtcREbn31d1jdc2hKL+ffeAazKqIS4C28xkvGOVkyBgDl5AT6wedS3inS
        oxOa7mIQ17lDriAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.19-rc1-rt1
Message-ID: <Yp+BNyvZjQPMBDXA@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.19-rc1-rt1 patch set. 

Changes since v5.18-rt11:
  - Rebase to v5.19-rc1.

Known issues
     - Valentin Schneider reported a few splats on ARM64, see
          https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.19-rc1-rt1

The RT patch against v5.19-rc1 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.19/older/patch-5.19-rc1-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.19/older/patches-5.19-rc1-rt1.tar.xz

Sebastian
