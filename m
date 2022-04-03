Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589FA4F0BA7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 19:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359709AbiDCRwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 13:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbiDCRwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 13:52:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50701387B1
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 10:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649008242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=C+jrITnSIudozHXJPYMzLwKbiuaVaQ503n/8t/MYpcY=;
        b=MzP2FjW/OjGUAuV/8tzHAU1f/YC8niCaf3AbLyzo7hC9hpeTpZkkaJBHB7JQ4cvOKidwDB
        eWalIgLsdcniH/6Rx8oL/9cmNJYtrbQNRR3IHMS+6RyK29o96YXgljlH2KenU23JzG0YV1
        8bEVfZ5wKmp5AM7l+xKrzPoC1ivHES0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-15-R8kzDPMBPHi-Ldf3ppFFwA-1; Sun, 03 Apr 2022 13:50:41 -0400
X-MC-Unique: R8kzDPMBPHi-Ldf3ppFFwA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B42C7833960;
        Sun,  3 Apr 2022 17:50:40 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.7a2m.lab.eng.bos.redhat.com [10.16.222.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 42E14463E05;
        Sun,  3 Apr 2022 17:50:39 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Prarit Bhargava <prarit@redhat.com>,
        "David E. Box" <david.e.box@linux.intel.com>
Subject: [PATCH] tools/arch/x86: Add .gitignore files
Date:   Sun,  3 Apr 2022 13:50:37 -0400
Message-Id: <20220403175037.3425577-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add .gitignore files for executables.

Cc: "David E. Box" <david.e.box@linux.intel.com>
Signed-off-by: Prarit Bhargava <prarit@redhat.com>
---
 tools/arch/x86/intel_sdsi/.gitignore | 1 +
 tools/arch/x86/kcpuid/.gitignore     | 1 +
 2 files changed, 2 insertions(+)
 create mode 100644 tools/arch/x86/intel_sdsi/.gitignore
 create mode 100644 tools/arch/x86/kcpuid/.gitignore

diff --git a/tools/arch/x86/intel_sdsi/.gitignore b/tools/arch/x86/intel_sdsi/.gitignore
new file mode 100644
index 000000000000..112444185b97
--- /dev/null
+++ b/tools/arch/x86/intel_sdsi/.gitignore
@@ -0,0 +1 @@
+intel_sdsi
diff --git a/tools/arch/x86/kcpuid/.gitignore b/tools/arch/x86/kcpuid/.gitignore
new file mode 100644
index 000000000000..1b8541bc8dd0
--- /dev/null
+++ b/tools/arch/x86/kcpuid/.gitignore
@@ -0,0 +1 @@
+kcpuid
-- 
2.35.1

