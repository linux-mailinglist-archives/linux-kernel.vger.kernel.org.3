Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485A04ECFC7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 00:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351677AbiC3Wqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 18:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348450AbiC3Wqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 18:46:38 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A5C3DA4C
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 15:44:51 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 7EC2E1F44B68
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648680290;
        bh=5cSUjc8xF8wGmj2esqIStScsT3zObfel/k2vuS9cLqA=;
        h=From:To:Cc:Subject:Date:From;
        b=SV07FqArz9KuE+Io7634Qa5ZU/LelKxkom+GVSTLmbPLOXPPO6wRPZHxVocnTCiIy
         BI9uoucD1vorU9lkpihhSR8N12BTdy67qI38VFH4fMp2/5cLRz16lSm2WTBcqx2pMF
         d6oZOMVaWZhfzacXj5QQIp/xIHPoUCVRgief9xrGcAWf17dYyThR3lo6sJF1Yuf3NH
         ULUFd7kG9g13huL8EVVvHPAu4wjGcga6Rvd08jUqDnvxtVnk10YUzpe0x/UbIGk0WX
         5X3dXXfSWqBojf2LpWsaYNH6hf9tcSuFbOKw7bSxZEHza7IshcQJKzOdJqTGQJZ3R5
         BD+/oGpugblVg==
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH] =?UTF-8?q?futex:=20MAINTAINERS,=20.mailmap:=20Update=20An?= =?UTF-8?q?dr=C3=A9's=20email=20address?=
Date:   Wed, 30 Mar 2022 19:44:37 -0300
Message-Id: <20220330224437.39005-1-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update futex entry to use my personal email address.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 8fd9b3c7a42b..d5d8789c3c5b 100644
--- a/.mailmap
+++ b/.mailmap
@@ -45,6 +45,7 @@ Andrey Konovalov <andreyknvl@gmail.com> <andreyknvl@google.com>
 Andrey Ryabinin <ryabinin.a.a@gmail.com> <a.ryabinin@samsung.com>
 Andrey Ryabinin <ryabinin.a.a@gmail.com> <aryabinin@virtuozzo.com>
 Andrzej Hajda <andrzej.hajda@intel.com> <a.hajda@samsung.com>
+André Almeida <andrealmeid@riseup.net> <andrealmeid@collabora.com>
 Andy Adamson <andros@citi.umich.edu>
 Antoine Tenart <atenart@kernel.org> <antoine.tenart@bootlin.com>
 Antoine Tenart <atenart@kernel.org> <antoine.tenart@free-electrons.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 53df75660f16..bb26ea0305c2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8087,7 +8087,7 @@ M:	Ingo Molnar <mingo@redhat.com>
 R:	Peter Zijlstra <peterz@infradead.org>
 R:	Darren Hart <dvhart@infradead.org>
 R:	Davidlohr Bueso <dave@stgolabs.net>
-R:	André Almeida <andrealmeid@collabora.com>
+R:	André Almeida <andrealmeid@riseup.net>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
-- 
2.35.1

