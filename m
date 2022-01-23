Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0365497561
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 20:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239895AbiAWTxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 14:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239859AbiAWTxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 14:53:49 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCD4C06173D
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 11:53:49 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id g7-20020a25bdc7000000b00611c616bc76so30719482ybk.5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 11:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=G+EhAKbY6DFw5XB3K4os9OgHDZdCp+FPmNNLsxXLstI=;
        b=CoZz9LsO9Gom2K1s2rB89xuZGmideRn4NGKPkalZ+udaG74U4f9/FG26ldc7audHlk
         DG1tfcg36NfqzDHFcMYPQNg9MA7JFa2uIa+xb21JBOb0ALkKSX/lI4ZDxpRbd4E2jneE
         Bg2WJ4TrATycVwefpWaknARkh4pV1H5rvETR7cqvdXfovukG8xaptAGkxYWi5ARJllLB
         w3BG0h2723ViAq9DAz8y5da6u5bjRguy76t/rwdr0Y94a9MchRdkmo3bLvY3BIFbKl0+
         aMu+cLkMoXOZyJUywVAYnFtPYobwcxN0JaZURsPcfbEHT/48YaCYHVbc8ncp2how9hfw
         K7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=G+EhAKbY6DFw5XB3K4os9OgHDZdCp+FPmNNLsxXLstI=;
        b=h4r74yRgeg05PwP8OSaab6+QHV45ofOzIAR+wLI0SuQL5CJ6tjBCLYBPCh3Et2vptD
         8nBChgXQo6/ZOmhhyQsNtrbkK9T9qLzX4GZmCsiqUtNbT0NW32J3DuBOTPuT/KX6RbTx
         hEISdFMbXr2pwLNkCeMe6TvUi1hoP+5vOEfE5UKKcVDWQo/eRvNZHVIYQ/5NDba2iWc/
         BWMB12N7R5SxuOe+Tb8j7EWuY6B8h2UJAF1IQLUyAlnIb0rcz6AGSCF85/KzdY/JW770
         xdIfSlesyyTkaKx1mas+M+34g8lcc0ZHoOsqTw6wIrvWSCik+aJ5+h/CJiluIpYWcTRu
         l9kQ==
X-Gm-Message-State: AOAM531j58knotDWlYQm52w2RDnq/+xx9NR3hxDE5d9gFsMblFzsjKL5
        GYqpCmZhzX2EOYFHIfAGYPv8UTbPq2DSMxz8RA==
X-Google-Smtp-Source: ABdhPJz6kUr3qCHrhOQvH5B2AKGZs2ICLGLD8hRMqESDxiBYocxqi3sqqTQrff1pHAtmGyfwIDdsjM0KCHWS+Mb09Q==
X-Received: from ayushranjan-desktop0.svl.corp.google.com ([2620:15c:2c4:203:9c4d:cd55:e8a3:9536])
 (user=ayushranjan job=sendgmr) by 2002:a25:23cd:: with SMTP id
 j196mr18236580ybj.476.1642967628910; Sun, 23 Jan 2022 11:53:48 -0800 (PST)
Date:   Sun, 23 Jan 2022 11:53:37 -0800
Message-Id: <20220123195337.509882-1-ayushranjan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH] gvisor: add some missing definitions to vmx.h
From:   Ayush Ranjan <ayushranjan@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ben Gardon <bgardon@google.com>, Jim Mattson <jmattson@google.com>,
        Andrei Vagin <avagin@gmail.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michael Davidson <md@google.com>,
        Ayush Ranjan <ayushranjan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Davidson <md@google.com>

gvisor needs definitions for some additional secondary exec controls.

Tested: builds
Signed-off-by: Ayush Ranjan <ayushranjan@google.com>
Signed-off-by: Michael Davidson <md@google.com>
---
 arch/x86/include/asm/vmx.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index c77ad687cdf7..df40dc568eb9 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -67,6 +67,7 @@
 #define SECONDARY_EXEC_ENCLS_EXITING		VMCS_CONTROL_BIT(ENCLS_EXITING)
 #define SECONDARY_EXEC_RDSEED_EXITING		VMCS_CONTROL_BIT(RDSEED_EXITING)
 #define SECONDARY_EXEC_ENABLE_PML               VMCS_CONTROL_BIT(PAGE_MOD_LOGGING)
+#define SECONDARY_EXEC_EPT_VE			VMCS_CONTROL_BIT(EPT_VIOLATION_VE)
 #define SECONDARY_EXEC_PT_CONCEAL_VMX		VMCS_CONTROL_BIT(PT_CONCEAL_VMX)
 #define SECONDARY_EXEC_XSAVES			VMCS_CONTROL_BIT(XSAVES)
 #define SECONDARY_EXEC_MODE_BASED_EPT_EXEC	VMCS_CONTROL_BIT(MODE_BASED_EPT_EXEC)
-- 
2.35.0.rc0.227.g00780c9af4-goog

