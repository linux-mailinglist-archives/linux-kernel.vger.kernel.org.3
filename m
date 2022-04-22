Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF81350B305
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 10:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbiDVIhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 04:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbiDVIhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 04:37:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800E352E6B;
        Fri, 22 Apr 2022 01:34:29 -0700 (PDT)
Date:   Fri, 22 Apr 2022 08:34:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650616467;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gq1usa6UesRldL8zQcovKqyXols18bVc/b1E/9Ix0UU=;
        b=oFb0/qQdOUQvtBihmftXbLZBnsAchJ81J5KqAEwoupWjza3D5w5eNVgUFSA1EFM0ilEobe
        qhK/ITgu2+8io8KTVhWiC9YAC48iGBvkr6DZCjbGxbNgVvhhQyAfetlUgswje3LGvxi4jx
        KHzZM47kXuBYCM8a+DfROjtabjNn/wubobPlqjASuS59hfUHwsx0fgqfpOsi/aoGtl0ir9
        4TSAncyPKFtYNKXgyOXWnjNqyyfrKoecLcYoqAp7A/Zn8D9QPUmu9TDtdoXkexXLM9rodK
        ZM3ySHxZZuqTV0vjpGfSxAB3QuPjj0PeRDVY16Hcr0S18Hc7rMtByje0mZWWCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650616467;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gq1usa6UesRldL8zQcovKqyXols18bVc/b1E/9Ix0UU=;
        b=LcYfVAepCJCgrD9QDCDE2tOkmoZJl6VqGLTVPwoIRrmSfSY0YJBRhX/eGTvU6QHEGEcMz/
        W5/WtQ8yYhLuVvBQ==
From:   tip-bot2 for =?utf-8?q?Andr=C3=A9?= Almeida 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] futex: MAINTAINERS, .mailmap: Update 
 =?utf-8?q?Andr=C3=A9=27s?= email address
Cc:     andrealmeid@igalia.com, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220421173254.29855-1-andrealmeid@igalia.com>
References: <20220421173254.29855-1-andrealmeid@igalia.com>
MIME-Version: 1.0
Message-ID: <165061646567.4207.5776151541558788983.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     60cc5468daaefc18ffc081dc484bdaa1bd270561
Gitweb:        https://git.kernel.org/tip/60cc5468daaefc18ffc081dc484bdaa1bd2=
70561
Author:        Andr=C3=A9 Almeida <andrealmeid@igalia.com>
AuthorDate:    Thu, 21 Apr 2022 14:32:54 -03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 22 Apr 2022 10:30:20 +02:00

futex: MAINTAINERS, .mailmap: Update Andr=C3=A9's email address

Update futex entry to use my new professional email address.

Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20220421173254.29855-1-andrealmeid@igalia.com

---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 9345815..ea1ba4a 100644
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
index 40fa195..35dea3d 100644
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
