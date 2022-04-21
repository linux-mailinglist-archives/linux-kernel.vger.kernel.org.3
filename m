Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125B050A737
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390801AbiDURg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390780AbiDURgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:36:24 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12F849FAF
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3vnCj58Uy2hBNqDsDkWH/3x4dZv1Du+MQHF275KeKzc=; b=gaGLywGcMptZYY3F4IpQVsnaNR
        liN0WxgX28PqdgaLZL0oPAP+uSRC5JYww8YMe5vbDsyASw3CctGvdITli5gocsVNinboP5JspNthU
        84WYcKwRy7yIsGceCKTBAMoETpeL0s0ttU32yEkWMJ6laE1uQpdo4w4wmaVQAcu8sTQb19fdQPAKF
        F5Wu2+ARCXkHl0XNZUAdjJFDCkR7DsbXsGJqBJaERR8QeEH48yTVPKw8md5NObQBnixBSBsfeIF8t
        jRFdBaAkOHUb5RNP2V3B7rq9+JPNYuibx+v6lk1pyt8bMJ937hjsENRC3KqWFVNRs5ldZ0FTIvY8N
        0vtmD2uQ==;
Received: from [191.19.79.104] (helo=localhost.localdomain)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1nhagA-0004i6-2P; Thu, 21 Apr 2022 19:33:18 +0200
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     kernel-dev@igalia.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH] =?UTF-8?q?futex:=20MAINTAINERS,=20.mailmap:=20Update=20An?= =?UTF-8?q?dr=C3=A9's=20email=20address?=
Date:   Thu, 21 Apr 2022 14:32:54 -0300
Message-Id: <20220421173254.29855-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update futex entry to use my new professional email address.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 93458154ce7d..ea1ba4a9a77e 100644
--- a/.mailmap
+++ b/.mailmap
@@ -45,6 +45,7 @@ Andrey Konovalov <andreyknvl@gmail.com> <andreyknvl@google.com>
 Andrey Ryabinin <ryabinin.a.a@gmail.com> <a.ryabinin@samsung.com>
 Andrey Ryabinin <ryabinin.a.a@gmail.com> <aryabinin@virtuozzo.com>
 Andrzej Hajda <andrzej.hajda@intel.com> <a.hajda@samsung.com>
+André Almeida <andrealmeid@igalia.com> <andrealmeid@collabora.com>
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
-R:	André Almeida <andrealmeid@collabora.com>
+R:	André Almeida <andrealmeid@igalia.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
-- 
2.35.3

