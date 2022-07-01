Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C4D563CBA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 01:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbiGAXSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 19:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiGAXSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 19:18:39 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E813F30C
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 16:18:37 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id o18so3696454plg.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 16:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eSO6jwBuXGzX8X8xT8MBgYJbACunbZORMFa7JlcpBZU=;
        b=F9k7eowRFwZa8+r0If2kIa8jBd/e9P+O8nSbsEIYuS2g8I3tPVWMakUdglXfuqbtP3
         ukhkVh5FDf6QwpPPZUaZG05X0jrBwilRviOrSQv6mdRh2Kz7Bo01GM34QGZ0rNLbG3dV
         LdKJh9qEVsIWfS/j6RBO6pV2+e9YTIU7bBTC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eSO6jwBuXGzX8X8xT8MBgYJbACunbZORMFa7JlcpBZU=;
        b=FmmJ22CNzKPuu03bHR5Y036/5+WYBmHf9DJR4kosV0icmuPyKmaYZGtm/MQWb2yJne
         fhkHoOJsRLU/X/OJwAIuAZHywjUL+Vhp9CJdLpq5BM1rkZ/pdfKMVEFfexb2dmwYzZeZ
         ZhsiSHgaGaMm7P8q53c623N/98Zdcs5/J1gaTIaeUO5fbdtl9vDU8Ky+6j52gn76yAo3
         ylNRav1GWzgOVG3Xgj32wQZnVbzJYtL3oD55mV7bZAWSrZ302pwngg6R2MhHFovpzoeL
         isW8Lvg5rVR2iyRu0rt9O+gJUrY87Li1IDy5ermAVsxGID5TXwTZj+MQGEd9AYnnz6fm
         VLSw==
X-Gm-Message-State: AJIora/a5HQzfwGZKlO5CfzRRAKii3jyfBle+pVnSiipnTOIcB9MVX3X
        k6t8xZ8JHbB71HnMg+UHzRjT9viWb3phTA==
X-Google-Smtp-Source: AGRyM1sZOQLqPv7ysWQc2SVG9iS4JIbdswbg78KK4HE1T1C+R90App7HPdyH5FJ/ar35YbfOf6NKvg==
X-Received: by 2002:a17:90b:380d:b0:1ec:fc87:691b with SMTP id mq13-20020a17090b380d00b001ecfc87691bmr21336225pjb.48.1656717516624;
        Fri, 01 Jul 2022 16:18:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id cp19-20020a056a00349300b005254ea64d4bsm15947839pfb.55.2022.07.01.16.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 16:18:36 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Colin Ian King <colin.king@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] treewide: fix "interruptible" misspellings
Date:   Fri,  1 Jul 2022 16:17:40 -0700
Message-Id: <20220701231737.2474950-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14766; h=from:subject; bh=ZMXIatbkUS5mPdGw/1RN6+Bhx9XPmK56dVZMHLuDNVU=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiv4CRTxYFLCgyKh0J55wlFI2FhwwWNXf7olUukiHP mzBexcWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYr+AkQAKCRCJcvTf3G3AJtZIEA Cbm+dINRq7i9p5adkXX25OZGv4yh/2k2mBlXUhShYWjITXhd006aqyavx6gRvTPFonY40AVRSBPs20 yRzPaE7ejV1tevc0gTSwj/G1rJGIuhEFuA2I0C+kf+q/qfF+raife3/t1d+4PcZfk1nbHZIMFVc4fy niGY0bR95jUl8wNbolA94VuI+Fl8KwPZdZhNHNHMfuPe+wXGV2piJhWhhLzwEkroCEk/1TXci+ezJ+ X/FsWESgoeaj2uygnYE0bVE51oIT+TVrjfk27GGDNLsGJcXlZW5DKIQh34PNqfvgb9odCjqrpRKq/i bn7T94D4hCwyAGiPuSkcd2W0u2eZu85pQxSQKzdve3sUISDJM3CuavGfEfj4f7LegDjFtG+BQs4/OK f8VvYDQzXvWxTXGBZKiwcianxFZBc7icxQzrrmYBS2YheWqMzsxCA0gcwbMjpFjJO6Lfd0TqSoD03s m5RIbwce9Mngrs2Q0ayHukaa3BUK3GG0E3ZITAk2RiUntwDjenQlpoGhacIEIOa4smYwJPfHbvwyUT uwIOGqO8h2b/Yrx1i+jEtJOysfkgpFQSJtEl5rLq3q+eWIOBaqzVhqtwpR9YCZIIf0x8wIxTV+7ioA 3eKJKsTnrw8T2CPqb4nMwcPuQAogkKBkcjmyywrTyYRHVyvEoy1dWAPou7Pw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A common misspelling of "interruptible" is "interruptable". This fixes
them in the tree and adds the most common variation to spelling.txt.
Note that "uninterruptable" was already in spelling.txt.

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Colin Ian King <colin.king@intel.com>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/admin-guide/sysrq.rst                  |  2 +-
 Documentation/hid/hiddev.rst                         |  2 +-
 Documentation/scsi/ChangeLog.lpfc                    |  2 +-
 drivers/firmware/qcom_scm-legacy.c                   |  2 +-
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c       |  2 +-
 drivers/gpu/drm/msm/msm_gem_submit.c                 |  2 +-
 drivers/gpu/drm/radeon/radeon_fence.c                | 12 ++++++------
 drivers/input/serio/hil_mlc.c                        |  2 +-
 drivers/net/ethernet/amd/nmclan_cs.c                 |  4 ++--
 .../ethernet/chelsio/inline_crypto/chtls/chtls_cm.h  |  4 ++--
 drivers/scsi/aacraid/commsup.c                       |  2 +-
 drivers/tee/optee/supp.c                             | 10 +++++-----
 drivers/tty/serial/mux.c                             |  2 +-
 fs/ecryptfs/miscdev.c                                |  2 +-
 scripts/spelling.txt                                 |  1 +
 sound/soc/intel/atom/sst/sst_pvt.c                   |  2 +-
 16 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/Documentation/admin-guide/sysrq.rst b/Documentation/admin-guide/sysrq.rst
index 0a178ef0111d..51906e47327b 100644
--- a/Documentation/admin-guide/sysrq.rst
+++ b/Documentation/admin-guide/sysrq.rst
@@ -138,7 +138,7 @@ Command	    Function
 ``v``	    Forcefully restores framebuffer console
 ``v``	    Causes ETM buffer dump [ARM-specific]
 
-``w``	    Dumps tasks that are in uninterruptable (blocked) state.
+``w``	    Dumps tasks that are in uninterruptible (blocked) state.
 
 ``x``	    Used by xmon interface on ppc/powerpc platforms.
             Show global PMU Registers on sparc64.
diff --git a/Documentation/hid/hiddev.rst b/Documentation/hid/hiddev.rst
index caebc6266603..9b82c7f896aa 100644
--- a/Documentation/hid/hiddev.rst
+++ b/Documentation/hid/hiddev.rst
@@ -8,7 +8,7 @@ Introduction
 In addition to the normal input type HID devices, USB also uses the
 human interface device protocols for things that are not really human
 interfaces, but have similar sorts of communication needs. The two big
-examples for this are power devices (especially uninterruptable power
+examples for this are power devices (especially uninterruptible power
 supplies) and monitor control on higher end monitors.
 
 To support these disparate requirements, the Linux USB system provides
diff --git a/Documentation/scsi/ChangeLog.lpfc b/Documentation/scsi/ChangeLog.lpfc
index 2f6d595f95e1..ca4b3fd40552 100644
--- a/Documentation/scsi/ChangeLog.lpfc
+++ b/Documentation/scsi/ChangeLog.lpfc
@@ -389,7 +389,7 @@ Changes from 20041220 to 20041229
 	  moved to kthread. kthread_stop() is not able to wake up thread
 	  waiting on a semaphore and "modprobe -r lpfc" is not always
 	  (most of the times) able to complete. Fix is in not using
-	  semaphore for the interruptable sleep.
+	  semaphore for the interruptible sleep.
 	* Small Makefile cleanup - Remove remnants of 2.4 vs. 2.6
 	  determination.
 
diff --git a/drivers/firmware/qcom_scm-legacy.c b/drivers/firmware/qcom_scm-legacy.c
index 1829ba220576..ff46b2a8002b 100644
--- a/drivers/firmware/qcom_scm-legacy.c
+++ b/drivers/firmware/qcom_scm-legacy.c
@@ -215,7 +215,7 @@ int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
  * @res:  SCM call return values
  *
  * This shall only be used with commands that are guaranteed to be
- * uninterruptable, atomic and SMP safe.
+ * uninterruptible, atomic and SMP safe.
  */
 int scm_legacy_call_atomic(struct device *unused,
 			   const struct qcom_scm_desc *desc,
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
index c326bd2b444f..e21d9f182b0a 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -2497,7 +2497,7 @@ static int eb_pin_timeline(struct i915_execbuffer *eb, struct intel_context *ce,
 
 			/*
 			 * Error path, cannot use intel_context_timeline_lock as
-			 * that is user interruptable and this clean up step
+			 * that is user interruptible and this clean up step
 			 * must be done.
 			 */
 			mutex_lock(&ce->timeline->mutex);
diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 80975229b4de..84aafa9c0021 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -303,7 +303,7 @@ static int submit_lock_objects(struct msm_gem_submit *submit)
 
 		/* Not expecting -EALREADY here, if the bo was already
 		 * locked, we should have gotten -EALREADY already from
-		 * the dma_resv_lock_interruptable() call.
+		 * the dma_resv_lock_interruptible() call.
 		 */
 		WARN_ON_ONCE(ret == -EALREADY);
 	}
diff --git a/drivers/gpu/drm/radeon/radeon_fence.c b/drivers/gpu/drm/radeon/radeon_fence.c
index 73e3117420bf..9fbfc79cafda 100644
--- a/drivers/gpu/drm/radeon/radeon_fence.c
+++ b/drivers/gpu/drm/radeon/radeon_fence.c
@@ -465,12 +465,12 @@ static bool radeon_fence_any_seq_signaled(struct radeon_device *rdev, u64 *seq)
  *
  * @rdev: radeon device pointer
  * @target_seq: sequence number(s) we want to wait for
- * @intr: use interruptable sleep
+ * @intr: use interruptible sleep
  * @timeout: maximum time to wait, or MAX_SCHEDULE_TIMEOUT for infinite wait
  *
  * Wait for the requested sequence number(s) to be written by any ring
  * (all asics).  Sequnce number array is indexed by ring id.
- * @intr selects whether to use interruptable (true) or non-interruptable
+ * @intr selects whether to use interruptible (true) or non-interruptible
  * (false) sleep when waiting for the sequence number.  Helper function
  * for radeon_fence_wait_*().
  * Returns remaining time if the sequence number has passed, 0 when
@@ -527,7 +527,7 @@ static long radeon_fence_wait_seq_timeout(struct radeon_device *rdev,
  * @intr: use interruptible sleep
  *
  * Wait for the requested fence to signal (all asics).
- * @intr selects whether to use interruptable (true) or non-interruptable
+ * @intr selects whether to use interruptible (true) or non-interruptible
  * (false) sleep when waiting for the fence.
  * @timeout: maximum time to wait, or MAX_SCHEDULE_TIMEOUT for infinite wait
  * Returns remaining time if the sequence number has passed, 0 when
@@ -564,7 +564,7 @@ long radeon_fence_wait_timeout(struct radeon_fence *fence, bool intr, long timeo
  * @intr: use interruptible sleep
  *
  * Wait for the requested fence to signal (all asics).
- * @intr selects whether to use interruptable (true) or non-interruptable
+ * @intr selects whether to use interruptible (true) or non-interruptible
  * (false) sleep when waiting for the fence.
  * Returns 0 if the fence has passed, error for all other cases.
  */
@@ -583,11 +583,11 @@ int radeon_fence_wait(struct radeon_fence *fence, bool intr)
  *
  * @rdev: radeon device pointer
  * @fences: radeon fence object(s)
- * @intr: use interruptable sleep
+ * @intr: use interruptible sleep
  *
  * Wait for any requested fence to signal (all asics).  Fence
  * array is indexed by ring id.  @intr selects whether to use
- * interruptable (true) or non-interruptable (false) sleep when
+ * interruptible (true) or non-interruptible (false) sleep when
  * waiting for the fences. Used by the suballocator.
  * Returns 0 if any fence has passed, error for all other cases.
  */
diff --git a/drivers/input/serio/hil_mlc.c b/drivers/input/serio/hil_mlc.c
index d36e89d6fc54..c76b0da0bdce 100644
--- a/drivers/input/serio/hil_mlc.c
+++ b/drivers/input/serio/hil_mlc.c
@@ -902,7 +902,7 @@ static void hil_mlc_serio_close(struct serio *serio)
 
 	serio_set_drvdata(serio, NULL);
 	serio->drv = NULL;
-	/* TODO wake up interruptable */
+	/* TODO wake up interruptible */
 }
 
 static const struct serio_device_id hil_mlc_serio_id = {
diff --git a/drivers/net/ethernet/amd/nmclan_cs.c b/drivers/net/ethernet/amd/nmclan_cs.c
index 30ee5329bd7c..a3e93bf64537 100644
--- a/drivers/net/ethernet/amd/nmclan_cs.c
+++ b/drivers/net/ethernet/amd/nmclan_cs.c
@@ -475,7 +475,7 @@ static void nmclan_detach(struct pcmcia_device *link)
 /* ----------------------------------------------------------------------------
 mace_read
 	Reads a MACE register.  This is bank independent; however, the
-	caller must ensure that this call is not interruptable.  We are
+	caller must ensure that this call is not interruptible.  We are
 	assuming that during normal operation, the MACE is always in
 	bank 0.
 ---------------------------------------------------------------------------- */
@@ -502,7 +502,7 @@ static int mace_read(mace_private *lp, unsigned int ioaddr, int reg)
 /* ----------------------------------------------------------------------------
 mace_write
 	Writes to a MACE register.  This is bank independent; however,
-	the caller must ensure that this call is not interruptable.  We
+	the caller must ensure that this call is not interruptible.  We
 	are assuming that during normal operation, the MACE is always in
 	bank 0.
 ---------------------------------------------------------------------------- */
diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.h b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.h
index f61ca657601c..1010c91cf3e0 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.h
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.h
@@ -140,14 +140,14 @@ static inline void chtls_reqsk_free(struct request_sock *req)
 #define DECLARE_TASK_FUNC(task, task_param) \
 		static void task(struct work_struct *task_param)
 
-static inline void sk_wakeup_sleepers(struct sock *sk, bool interruptable)
+static inline void sk_wakeup_sleepers(struct sock *sk, bool interruptible)
 {
 	struct socket_wq *wq;
 
 	rcu_read_lock();
 	wq = rcu_dereference(sk->sk_wq);
 	if (skwq_has_sleeper(wq)) {
-		if (interruptable)
+		if (interruptible)
 			wake_up_interruptible(sk_sleep(sk));
 		else
 			wake_up_all(sk_sleep(sk));
diff --git a/drivers/scsi/aacraid/commsup.c b/drivers/scsi/aacraid/commsup.c
index deb32c9f4b3e..fdc0a834cf96 100644
--- a/drivers/scsi/aacraid/commsup.c
+++ b/drivers/scsi/aacraid/commsup.c
@@ -637,7 +637,7 @@ int aac_fib_send(u16 command, struct fib *fibptr, unsigned long size,
 
 	if (wait) {
 		spin_unlock_irqrestore(&fibptr->event_lock, flags);
-		/* Only set for first known interruptable command */
+		/* Only set for first known interruptible command */
 		if (wait < 0) {
 			/*
 			 * *VERY* Dangerous to time out a command, the
diff --git a/drivers/tee/optee/supp.c b/drivers/tee/optee/supp.c
index 322a543b8c27..10b389029bd4 100644
--- a/drivers/tee/optee/supp.c
+++ b/drivers/tee/optee/supp.c
@@ -80,7 +80,7 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
 	struct optee *optee = tee_get_drvdata(ctx->teedev);
 	struct optee_supp *supp = &optee->supp;
 	struct optee_supp_req *req;
-	bool interruptable;
+	bool interruptible;
 	u32 ret;
 
 	/*
@@ -115,8 +115,8 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
 	 */
 	while (wait_for_completion_interruptible(&req->c)) {
 		mutex_lock(&supp->mutex);
-		interruptable = !supp->ctx;
-		if (interruptable) {
+		interruptible = !supp->ctx;
+		if (interruptible) {
 			/*
 			 * There's no supplicant available and since the
 			 * supp->mutex currently is held none can
@@ -137,7 +137,7 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
 		}
 		mutex_unlock(&supp->mutex);
 
-		if (interruptable) {
+		if (interruptible) {
 			req->ret = TEEC_ERROR_COMMUNICATION;
 			break;
 		}
@@ -257,7 +257,7 @@ int optee_supp_recv(struct tee_context *ctx, u32 *func, u32 *num_params,
 		 * wait_for_completion() to avoid needless spinning.
 		 *
 		 * This is where supplicant will be hanging most of
-		 * the time, let's make this interruptable so we
+		 * the time, let's make this interruptible so we
 		 * can easily restart supplicant if needed.
 		 */
 		if (wait_for_completion_interruptible(&supp->reqs_c))
diff --git a/drivers/tty/serial/mux.c b/drivers/tty/serial/mux.c
index 643dfbcc43f9..d9fb14f39962 100644
--- a/drivers/tty/serial/mux.c
+++ b/drivers/tty/serial/mux.c
@@ -483,7 +483,7 @@ static int __init mux_probe(struct parisc_device *dev)
 
 		/* The port->timeout needs to match what is present in
 		 * uart_wait_until_sent in serial_core.c.  Otherwise
-		 * the time spent in msleep_interruptable will be very
+		 * the time spent in msleep_interruptible will be very
 		 * long, causing the appearance of a console hang.
 		 */
 		port->timeout   = HZ / 50;
diff --git a/fs/ecryptfs/miscdev.c b/fs/ecryptfs/miscdev.c
index 4e62c3cef70f..56d73473ff1a 100644
--- a/fs/ecryptfs/miscdev.c
+++ b/fs/ecryptfs/miscdev.c
@@ -248,7 +248,7 @@ ecryptfs_miscdev_read(struct file *file, char __user *buf, size_t count,
 	}
 	if (list_empty(&daemon->msg_ctx_out_queue)) {
 		/* Something else jumped in since the
-		 * wait_event_interruptable() and removed the
+		 * wait_event_interruptible() and removed the
 		 * message from the queue; try again */
 		goto check_list;
 	}
diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index 8435b99452b6..31194d83d5d8 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -841,6 +841,7 @@ interrface||interface
 interrrupt||interrupt
 interrup||interrupt
 interrups||interrupts
+interruptable||interruptible
 interruptted||interrupted
 interupted||interrupted
 intiailized||initialized
diff --git a/sound/soc/intel/atom/sst/sst_pvt.c b/sound/soc/intel/atom/sst/sst_pvt.c
index e6a5c18a7018..03891ce54c68 100644
--- a/sound/soc/intel/atom/sst/sst_pvt.c
+++ b/sound/soc/intel/atom/sst/sst_pvt.c
@@ -75,7 +75,7 @@ void sst_set_fw_state_locked(
  * @sst_drv_ctx: Driver context
  * @block: Driver block to wait on
  *
- * This function waits without a timeout (and is interruptable) for a
+ * This function waits without a timeout (and is interruptible) for a
  * given block event
  */
 int sst_wait_interruptible(struct intel_sst_drv *sst_drv_ctx,
-- 
2.32.0

