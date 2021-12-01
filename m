Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF76464462
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 02:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346000AbhLABG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 20:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345918AbhLABF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 20:05:59 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC87C061748
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 17:02:39 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id e12-20020aa7980c000000b0049fa3fc29d0so13913633pfl.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 17:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZTyKNj6u0fTO4ntByHNMDyPGhzA6pKL77aaHBoKsL0M=;
        b=L4JKtse91Ovd638h12WP8Zxy3Ww+ZtW0XySpkP3PCZSDhxGCcUMpLCUSo4LE3TuP5t
         +ezj/pwnOaak5mDxJ7Laj9y64AFPI+BmlAfIq/Ef0tAnv4GDVyzE1uiZJbS69vTM4+LZ
         FAT4OfI1j3kJ8A9jnNoFE6OhudR2/mtzKJckcI/g9QuEkNqlyzMoGQpYcLpcrmWm5b6M
         OPVvV38XPABJPiEMF4bSvaJhQfeoXsReMCzljEGYt3XnUBBR3jl6g7Xb7R5joJBvrYtt
         gzUZzeHK9MKqwtWz9qS3G+al8MUL9/6Rgw8eVg0QjQdG63/sh8lDe82gcisXx//SmWzT
         QqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZTyKNj6u0fTO4ntByHNMDyPGhzA6pKL77aaHBoKsL0M=;
        b=ow7hr5GYfBX+phqKI5BelGThRfc5xcda8q5Uboh6DG/y/nPmUjF5ZKRlzlMXIQRcIu
         U5fsZFwvs2vpJk2lTdQOwzGDnyPYKzRGTmuKxGnPb1T4MihkenpFR6CE0wQwb5w42Jzt
         WVxWyWKoIKvbdHFBWVAQLCDv8U3+4pY5SXX7M3HMebFjBHXKEWIif/hHmEbmx8xEHxAz
         apCESXESABmR8rJmPVIB5ilKVKC7cuDrAptSBv9j3aA1vWD9G6aLISWbvNBrZNaNImGx
         SALQDEQIix4qbDpdhBpFOmF67L6cNKVc7ivJm6ID7yEsdatXW0CeYYPNyV4Pvrtnu+LC
         rUVw==
X-Gm-Message-State: AOAM530d1p3jY00NyGzQ+COg7cxkg5zLGCcEnS/hozfFSXHDHLn2F0Ql
        tvO+YrfT8/h6p8Vwd6SxZOj16IkEVIH5J7Sr8PVyWR+Ds6A2uFRWKO8a9tbV1jzEK16FA3u0sIv
        Lcp6aRap8MIXBUPZD0uFnh7dBcBoufvHRYDm+n6+WsjqvLeIAlbda0ezYAK2BsEhFM8vHKTCd
X-Google-Smtp-Source: ABdhPJxJRCz0N8ibN0ML31do3Xg5xXdgOccj+cWpIUgqCLle/yGAc4/gfMJ6yj4elsNSj7hNz6cKdiT2gUhT
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:8776:d8e0:bb50:a95a])
 (user=eranian job=sendgmr) by 2002:a05:6a00:1a8f:b0:49f:f5ac:b27a with SMTP
 id e15-20020a056a001a8f00b0049ff5acb27amr3003869pfv.38.1638320558841; Tue, 30
 Nov 2021 17:02:38 -0800 (PST)
Date:   Tue, 30 Nov 2021 17:02:12 -0800
In-Reply-To: <20211201010217.886919-1-eranian@google.com>
Message-Id: <20211201010217.886919-9-eranian@google.com>
Mime-Version: 1.0
References: <20211201010217.886919-1-eranian@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v3 08/13] ACPI: add perf low power callback
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com, mpe@ellerman.id.au,
        maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add an optional callback needed by some PMU features, e.g., AMD
BRS, to give a chance to the perf_events code to change its state before
going to low power and after coming back.

The callback is void when the PERF_NEEDS_LOPWR_CB flag is not set.
This flag must be set in arch specific perf_event.h header whenever needed.
When not set, there is no impact of the ACPI code.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 drivers/acpi/acpi_pad.c       | 6 ++++++
 drivers/acpi/processor_idle.c | 5 +++++
 include/linux/perf_event.h    | 6 ++++++
 3 files changed, 17 insertions(+)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index f45979aa2d64..a306a07a60b5 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -164,6 +164,9 @@ static int power_saving_thread(void *data)
 				tsc_marked_unstable = 1;
 			}
 			local_irq_disable();
+
+			perf_lopwr_cb(true);
+
 			tick_broadcast_enable();
 			tick_broadcast_enter();
 			stop_critical_timings();
@@ -172,6 +175,9 @@ static int power_saving_thread(void *data)
 
 			start_critical_timings();
 			tick_broadcast_exit();
+
+			perf_lopwr_cb(false);
+
 			local_irq_enable();
 
 			if (time_before(expire_time, jiffies)) {
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 76ef1bcc8848..7a3a613ae5ed 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -20,6 +20,7 @@
 #include <linux/tick.h>
 #include <linux/cpuidle.h>
 #include <linux/cpu.h>
+#include <linux/perf_event.h>
 #include <acpi/processor.h>
 
 /*
@@ -546,6 +547,8 @@ static void wait_for_freeze(void)
  */
 static void __cpuidle acpi_idle_do_entry(struct acpi_processor_cx *cx)
 {
+	perf_lopwr_cb(true);
+
 	if (cx->entry_method == ACPI_CSTATE_FFH) {
 		/* Call into architectural FFH based C-state */
 		acpi_processor_ffh_cstate_enter(cx);
@@ -556,6 +559,8 @@ static void __cpuidle acpi_idle_do_entry(struct acpi_processor_cx *cx)
 		inb(cx->address);
 		wait_for_freeze();
 	}
+
+	perf_lopwr_cb(false);
 }
 
 /**
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index bbe02c80244b..f9760873e145 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1674,4 +1674,10 @@ typedef int (perf_snapshot_branch_stack_t)(struct perf_branch_entry *entries,
 					   unsigned int cnt);
 DECLARE_STATIC_CALL(perf_snapshot_branch_stack, perf_snapshot_branch_stack_t);
 
+#ifndef PERF_NEEDS_LOPWR_CB
+static inline void perf_lopwr_cb(bool mode)
+{
+}
+#endif
+
 #endif /* _LINUX_PERF_EVENT_H */
-- 
2.34.0.rc2.393.gf8c9666880-goog

