Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6623651ED53
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 14:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbiEHMJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 08:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbiEHMJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 08:09:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3F5E0E9
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 05:05:24 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652011523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=4wx6xv0sFNTiLpGrDyb/cw/fwOHu+BVufy2XNxOdHAk=;
        b=46HOO6yMrFHuEPMawYLxgoW142lNrBshqvtTUHrRRweciR6EfLOBS+JtjiDXWpqotZwNgk
        nK3kREqGCwSw7lRIZ8ZV0GIDOTkItML5CKwJ2xA6AyAqrz4LdrQeb2n1rCDss0JwXL9Psl
        UD7AGYrdx0RVvKa/RIhAaF06X28o3ySJDJQNXSnFvqUtUmk6udRDSC8nixv4yvP8Kah8qz
        tIzZC9OguXst+9I83YEdlT6Y5QquD+6PYgEPNIEmZ1kTUwP1OxV1nKmzkQOqog66RR+TwQ
        RW/516iE14Mk+F7cjbhSBELKmH5XgmDRYkanACS8n4tVmlrnWpOKKG1DSgnwqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652011523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=4wx6xv0sFNTiLpGrDyb/cw/fwOHu+BVufy2XNxOdHAk=;
        b=BbRvKnk5F6dsNG56HzwkNAznE7tKieu5NlX6EsBVP70giitjf8FW0yFAha9iZWCvkTrHa9
        7KVHGVHnHAFRnEAg==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] locking/urgent for v5.18-rc6
References: <165201148069.536527.1960632033331546251.tglx@xen13>
Message-ID: <165201148366.536527.18041857851988281678.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun,  8 May 2022 14:05:22 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest locking/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2=
022-05-08

up to:  60cc5468daae: futex: MAINTAINERS, .mailmap: Update Andr=C3=A9's email=
 address


Just a email address update for MAINTAINERS and mailmap.

Thanks,

	tglx

------------------>
Andr=C3=A9 Almeida (1):
      futex: MAINTAINERS, .mailmap: Update Andr=C3=A9's email address


 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 93458154ce7d..ea1ba4a9a77e 100644
--- a/.mailmap
+++ b/.mailmap
@@ -45,6 +45,7 @@ Andrey Konovalov <andreyknvl@gmail.com> <andreyknvl@google.=
com>
 Andrey Ryabinin <ryabinin.a.a@gmail.com> <a.ryabinin@samsung.com>
 Andrey Ryabinin <ryabinin.a.a@gmail.com> <aryabinin@virtuozzo.com>
 Andrzej Hajda <andrzej.hajda@intel.com> <a.hajda@samsung.com>
+Andr=C3=A9 Almeida <andrealmeid@igalia.com> <andrealmeid@collabora.com>
 Andy Adamson <andros@citi.umich.edu>
 Antoine Tenart <atenart@kernel.org> <antoine.tenart@bootlin.com>
 Antoine Tenart <atenart@kernel.org> <antoine.tenart@free-electrons.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 40fa1955ca3f..35dea3d12981 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8109,7 +8109,7 @@ M:	Ingo Molnar <mingo@redhat.com>
 R:	Peter Zijlstra <peterz@infradead.org>
 R:	Darren Hart <dvhart@infradead.org>
 R:	Davidlohr Bueso <dave@stgolabs.net>
-R:	Andr=C3=A9 Almeida <andrealmeid@collabora.com>
+R:	Andr=C3=A9 Almeida <andrealmeid@igalia.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core

