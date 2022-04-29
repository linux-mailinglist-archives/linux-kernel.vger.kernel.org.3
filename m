Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3A25155DA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376368AbiD2UlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380936AbiD2Uk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:40:57 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA20B3DF9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:37:21 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f7dbceab08so83961917b3.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=at094/n7Bv0uMdAnePTtcmGS9w2uuX44gIiSUGsiiUw=;
        b=aqcIrj9Lso+THq6tWdJjaEjslDJU8f6IStjKgDa3X0g0uDng3QzbCDnmsBrF8AR9hH
         JBJZPxAwynEbDOkhSJ0GsSMILl7U26MJWY1ya16P7nOIzobEUQla2lws7JLGIEsOQ/Nz
         Lp3TPnIv5QnYJHiuBAQ9PnfT3T6HARYsGNd2fNltarfP7WRDBr2cV4mWjsPbsTXHOBxB
         fTrcCZz/aV4dvMJcU0qqGBGYGs2hU/RNEHLMOOpEbIXvYbyBGsjeYcUqYkiQ2VguhMs9
         DXdvpxid28aS+gPIy3QAxOM8bjz9Uyv00LisAAGBa+dMmyqQq4DAcXI6Kc67FzciIaWI
         vMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=at094/n7Bv0uMdAnePTtcmGS9w2uuX44gIiSUGsiiUw=;
        b=yLqGm9zzjef0KgFY++S0ZVElK7eEs/K1KEpr3+xF9PovPKWdUJ1P3oDaNfqpJtLKmO
         qlm8GMLJNuzWLOciXEPHZDhiPggdB2wSNCzZRyBGIlVVPT4o9wxgyTWalQMQLJhg+aTR
         nfBv5RS8HvtwVOvg7/9n8HvPbL8FMmwnb+t2CsZv5QoFmCqQlm8WdxEOTrJjGBei0ehU
         +ugFjUho9okz/u2LuzaM4792fMMQLwDcKCv7HKF9GG1KNE06tPi0PScXuMvYt05rDOc+
         eMc4Tuavl0Uz945Zo2FL0Zywae8jgATpnBE60b4MEYfGh2BMioy+t5m82kjvJqTkjPA8
         pxFg==
X-Gm-Message-State: AOAM533Z9CPAN6PfguqGLn8JPnDRcQXcf8E6ozDJ5KGg4P34qikizENd
        V3h5o6dK1I0VTUZPaW+t7AaWqKFPRHRDu5sTXt6Csfzx17cN3QpMpCUE/21to49rS50xTqSWz+q
        R/8FgcuzWAY+lY02pbw4WMdPgGRgdCvnE0y4yXxC6XZgN0PheWpN3ISu4t65DFObqhLbSVLsiwW
        bsHF5caZWtrg==
X-Google-Smtp-Source: ABdhPJwKd/LLWNg2QG73psSZJdSbzY/4GgMNmrmTD7KhlvYF4iCuR5BDaLXQFtDyn0kCtPHGPJp52QuMU61a4NMwB68=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:351:bea9:f158:1021])
 (user=samitolvanen job=sendgmr) by 2002:a05:6902:1d1:b0:636:fa07:4b9a with
 SMTP id u17-20020a05690201d100b00636fa074b9amr1303121ybh.590.1651264640815;
 Fri, 29 Apr 2022 13:37:20 -0700 (PDT)
Date:   Fri, 29 Apr 2022 13:36:37 -0700
In-Reply-To: <20220429203644.2868448-1-samitolvanen@google.com>
Message-Id: <20220429203644.2868448-15-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220429203644.2868448-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=85495; h=from:subject;
 bh=iiWY4b289kgcrgUapNqeh5S+gRJExbvQtnMsr191Klo=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBibExXT8MTQkfhbZ1IBE3KS7pqiwS1u7YM43iZqTsM
 S3Beb2CJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYmxMVwAKCRBMtfaEi7xW7mzZC/
 9AUba9TTHqxZ3KWbLmEs6qAODGC/XbOnAc+mK/pf10Wo3/pS1nmb1hDawYnoZtevXHqptV5MWrQpUH
 BhwPOCJ8Eacykd6lDcN/70z/FCUF776C60sje6K5xKUjPKskeT59UaviTUosCwhRoWWdx1EblFRwDm
 4srf9M3PBu+sw6/L/XFBqHOC4smOklt+GYBEQaPqpS/DFrktP1qzCAzB+ATrZn7ruHEt3wautVHLE2
 s2Z8EmKgLJcjnb8o6dkTR0VeWG1HJ/RNtWzA7ZfRBDWWVKNkXVz4/yUr1nnjG79I0Y1pw2S40jjTH7
 Nl2ILyuZoVdokm2PEvzeLQ2ajuMVQ/zoYKj/dM61P4Y8EBr+NP5cXy0bLBtpb2ngfrGwJiHw4NBWRY
 yTR83Wu4AkuG4gAU+y0w5wVucOgazknncHQEHmck2P+FDJ4NBMrRC4D9NOGzhf7/i3MJZLu4YVNCkr
 K1Zvyk3zTMnbZRD2EY/6sMpELrIDSSztLE9ZNjqgmb0P4=
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [RFC PATCH 14/21] treewide: static_call: Pass call arguments to the macro
From:   Sami Tolvanen <samitolvanen@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include the function arguments in the static call macro to make it
possible to add a wrapper for the call. This is needed with
CONFIG_CFI_CLANG to disable indirect call checking for static calls
that are patched into direct calls at runtime.

Users of static_call were updated using the following Coccinelle
script and manually adjusted to preserve coding style:

  @@
  expression name;
  expression list args;
  identifier static_call =~ "^static_call(_mod|_cond)?$";
  @@

  - static_call(name)(args)
  + static_call(name, args)

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm/include/asm/paravirt.h           |   2 +-
 arch/arm64/include/asm/paravirt.h         |   2 +-
 arch/x86/crypto/aesni-intel_glue.c        |   7 +-
 arch/x86/events/core.c                    |  40 +--
 arch/x86/include/asm/kvm_host.h           |   6 +-
 arch/x86/include/asm/paravirt.h           |   4 +-
 arch/x86/kvm/cpuid.c                      |   2 +-
 arch/x86/kvm/hyperv.c                     |   4 +-
 arch/x86/kvm/irq.c                        |   2 +-
 arch/x86/kvm/kvm_cache_regs.h             |  10 +-
 arch/x86/kvm/lapic.c                      |  32 +--
 arch/x86/kvm/mmu.h                        |   4 +-
 arch/x86/kvm/mmu/mmu.c                    |   8 +-
 arch/x86/kvm/mmu/spte.c                   |   4 +-
 arch/x86/kvm/pmu.c                        |   4 +-
 arch/x86/kvm/trace.h                      |   4 +-
 arch/x86/kvm/x86.c                        | 326 +++++++++++-----------
 arch/x86/kvm/x86.h                        |   4 +-
 arch/x86/kvm/xen.c                        |   4 +-
 drivers/cpufreq/amd-pstate.c              |   8 +-
 include/linux/entry-common.h              |   2 +-
 include/linux/kernel.h                    |   2 +-
 include/linux/perf_event.h                |   6 +-
 include/linux/sched.h                     |   2 +-
 include/linux/static_call.h               |  16 +-
 include/linux/static_call_types.h         |  10 +-
 include/linux/tracepoint.h                |   2 +-
 kernel/static_call_inline.c               |   2 +-
 kernel/trace/bpf_trace.c                  |   2 +-
 security/keys/trusted-keys/trusted_core.c |  14 +-
 30 files changed, 267 insertions(+), 268 deletions(-)

diff --git a/arch/arm/include/asm/paravirt.h b/arch/arm/include/asm/paravirt.h
index 95d5b0d625cd..43c419eadb9a 100644
--- a/arch/arm/include/asm/paravirt.h
+++ b/arch/arm/include/asm/paravirt.h
@@ -15,7 +15,7 @@ DECLARE_STATIC_CALL(pv_steal_clock, dummy_steal_clock);
 
 static inline u64 paravirt_steal_clock(int cpu)
 {
-	return static_call(pv_steal_clock)(cpu);
+	return static_call(pv_steal_clock, cpu);
 }
 #endif
 
diff --git a/arch/arm64/include/asm/paravirt.h b/arch/arm64/include/asm/paravirt.h
index 9aa193e0e8f2..35a9d649c448 100644
--- a/arch/arm64/include/asm/paravirt.h
+++ b/arch/arm64/include/asm/paravirt.h
@@ -15,7 +15,7 @@ DECLARE_STATIC_CALL(pv_steal_clock, dummy_steal_clock);
 
 static inline u64 paravirt_steal_clock(int cpu)
 {
-	return static_call(pv_steal_clock)(cpu);
+	return static_call(pv_steal_clock, cpu);
 }
 
 int __init pv_time_init(void);
diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index 41901ba9d3a2..06182c068145 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -507,10 +507,9 @@ static int ctr_crypt(struct skcipher_request *req)
 	while ((nbytes = walk.nbytes) > 0) {
 		kernel_fpu_begin();
 		if (nbytes & AES_BLOCK_MASK)
-			static_call(aesni_ctr_enc_tfm)(ctx, walk.dst.virt.addr,
-						       walk.src.virt.addr,
-						       nbytes & AES_BLOCK_MASK,
-						       walk.iv);
+			static_call(aesni_ctr_enc_tfm, ctx,
+				    walk.dst.virt.addr, walk.src.virt.addr,
+				    nbytes & AES_BLOCK_MASK, walk.iv);
 		nbytes &= ~AES_BLOCK_MASK;
 
 		if (walk.nbytes == walk.total && nbytes > 0) {
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index eef816fc216d..74315c87220b 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -695,7 +695,7 @@ void x86_pmu_disable_all(void)
 
 struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr)
 {
-	return static_call(x86_pmu_guest_get_msrs)(nr);
+	return static_call(x86_pmu_guest_get_msrs, nr);
 }
 EXPORT_SYMBOL_GPL(perf_guest_get_msrs);
 
@@ -726,7 +726,7 @@ static void x86_pmu_disable(struct pmu *pmu)
 	cpuc->enabled = 0;
 	barrier();
 
-	static_call(x86_pmu_disable_all)();
+	static_call(x86_pmu_disable_all);
 }
 
 void x86_pmu_enable_all(int added)
@@ -991,7 +991,7 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 	if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
 		n0 -= cpuc->n_txn;
 
-	static_call_cond(x86_pmu_start_scheduling)(cpuc);
+	static_call_cond(x86_pmu_start_scheduling, cpuc);
 
 	for (i = 0, wmin = X86_PMC_IDX_MAX, wmax = 0; i < n; i++) {
 		c = cpuc->event_constraint[i];
@@ -1008,7 +1008,7 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 		 * change due to external factors (sibling state, allow_tfa).
 		 */
 		if (!c || (c->flags & PERF_X86_EVENT_DYNAMIC)) {
-			c = static_call(x86_pmu_get_event_constraints)(cpuc, i, cpuc->event_list[i]);
+			c = static_call(x86_pmu_get_event_constraints, cpuc, i, cpuc->event_list[i]);
 			cpuc->event_constraint[i] = c;
 		}
 
@@ -1090,7 +1090,7 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 	 */
 	if (!unsched && assign) {
 		for (i = 0; i < n; i++)
-			static_call_cond(x86_pmu_commit_scheduling)(cpuc, i, assign[i]);
+			static_call_cond(x86_pmu_commit_scheduling, cpuc, i, assign[i]);
 	} else {
 		for (i = n0; i < n; i++) {
 			e = cpuc->event_list[i];
@@ -1098,13 +1098,13 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 			/*
 			 * release events that failed scheduling
 			 */
-			static_call_cond(x86_pmu_put_event_constraints)(cpuc, e);
+			static_call_cond(x86_pmu_put_event_constraints, cpuc, e);
 
 			cpuc->event_constraint[i] = NULL;
 		}
 	}
 
-	static_call_cond(x86_pmu_stop_scheduling)(cpuc);
+	static_call_cond(x86_pmu_stop_scheduling, cpuc);
 
 	return unsched ? -EINVAL : 0;
 }
@@ -1217,7 +1217,7 @@ static inline void x86_assign_hw_event(struct perf_event *event,
 	hwc->last_cpu = smp_processor_id();
 	hwc->last_tag = ++cpuc->tags[i];
 
-	static_call_cond(x86_pmu_assign)(event, idx);
+	static_call_cond(x86_pmu_assign, event, idx);
 
 	switch (hwc->idx) {
 	case INTEL_PMC_IDX_FIXED_BTS:
@@ -1347,7 +1347,7 @@ static void x86_pmu_enable(struct pmu *pmu)
 	cpuc->enabled = 1;
 	barrier();
 
-	static_call(x86_pmu_enable_all)(added);
+	static_call(x86_pmu_enable_all, added);
 }
 
 static DEFINE_PER_CPU(u64 [X86_PMC_IDX_MAX], pmc_prev_left);
@@ -1472,7 +1472,7 @@ static int x86_pmu_add(struct perf_event *event, int flags)
 	if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
 		goto done_collect;
 
-	ret = static_call(x86_pmu_schedule_events)(cpuc, n, assign);
+	ret = static_call(x86_pmu_schedule_events, cpuc, n, assign);
 	if (ret)
 		goto out;
 	/*
@@ -1494,7 +1494,7 @@ static int x86_pmu_add(struct perf_event *event, int flags)
 	 * This is before x86_pmu_enable() will call x86_pmu_start(),
 	 * so we enable LBRs before an event needs them etc..
 	 */
-	static_call_cond(x86_pmu_add)(event);
+	static_call_cond(x86_pmu_add, event);
 
 	ret = 0;
 out:
@@ -1521,7 +1521,7 @@ static void x86_pmu_start(struct perf_event *event, int flags)
 
 	cpuc->events[idx] = event;
 	__set_bit(idx, cpuc->active_mask);
-	static_call(x86_pmu_enable)(event);
+	static_call(x86_pmu_enable, event);
 	perf_event_update_userpage(event);
 }
 
@@ -1594,7 +1594,7 @@ void x86_pmu_stop(struct perf_event *event, int flags)
 	struct hw_perf_event *hwc = &event->hw;
 
 	if (test_bit(hwc->idx, cpuc->active_mask)) {
-		static_call(x86_pmu_disable)(event);
+		static_call(x86_pmu_disable, event);
 		__clear_bit(hwc->idx, cpuc->active_mask);
 		cpuc->events[hwc->idx] = NULL;
 		WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
@@ -1647,7 +1647,7 @@ static void x86_pmu_del(struct perf_event *event, int flags)
 	if (i >= cpuc->n_events - cpuc->n_added)
 		--cpuc->n_added;
 
-	static_call_cond(x86_pmu_put_event_constraints)(cpuc, event);
+	static_call_cond(x86_pmu_put_event_constraints, cpuc, event);
 
 	/* Delete the array entry. */
 	while (++i < cpuc->n_events) {
@@ -1667,7 +1667,7 @@ static void x86_pmu_del(struct perf_event *event, int flags)
 	 * This is after x86_pmu_stop(); so we disable LBRs after any
 	 * event can need them etc..
 	 */
-	static_call_cond(x86_pmu_del)(event);
+	static_call_cond(x86_pmu_del, event);
 }
 
 int x86_pmu_handle_irq(struct pt_regs *regs)
@@ -1745,7 +1745,7 @@ perf_event_nmi_handler(unsigned int cmd, struct pt_regs *regs)
 		return NMI_DONE;
 
 	start_clock = sched_clock();
-	ret = static_call(x86_pmu_handle_irq)(regs);
+	ret = static_call(x86_pmu_handle_irq, regs);
 	finish_clock = sched_clock();
 
 	perf_sample_event_took(finish_clock - start_clock);
@@ -2217,7 +2217,7 @@ early_initcall(init_hw_perf_events);
 
 static void x86_pmu_read(struct perf_event *event)
 {
-	static_call(x86_pmu_read)(event);
+	static_call(x86_pmu_read, event);
 }
 
 /*
@@ -2298,7 +2298,7 @@ static int x86_pmu_commit_txn(struct pmu *pmu)
 	if (!x86_pmu_initialized())
 		return -EAGAIN;
 
-	ret = static_call(x86_pmu_schedule_events)(cpuc, n, assign);
+	ret = static_call(x86_pmu_schedule_events, cpuc, n, assign);
 	if (ret)
 		return ret;
 
@@ -2638,13 +2638,13 @@ static const struct attribute_group *x86_pmu_attr_groups[] = {
 
 static void x86_pmu_sched_task(struct perf_event_context *ctx, bool sched_in)
 {
-	static_call_cond(x86_pmu_sched_task)(ctx, sched_in);
+	static_call_cond(x86_pmu_sched_task, ctx, sched_in);
 }
 
 static void x86_pmu_swap_task_ctx(struct perf_event_context *prev,
 				  struct perf_event_context *next)
 {
-	static_call_cond(x86_pmu_swap_task_ctx)(prev, next);
+	static_call_cond(x86_pmu_swap_task_ctx, prev, next);
 }
 
 void perf_check_microcode(void)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 4ff36610af6a..0d3869f6efc2 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1576,7 +1576,7 @@ void kvm_arch_free_vm(struct kvm *kvm);
 static inline int kvm_arch_flush_remote_tlb(struct kvm *kvm)
 {
 	if (kvm_x86_ops.tlb_remote_flush &&
-	    !static_call(kvm_x86_tlb_remote_flush)(kvm))
+	    !static_call(kvm_x86_tlb_remote_flush, kvm))
 		return 0;
 	else
 		return -ENOTSUPP;
@@ -1953,12 +1953,12 @@ static inline bool kvm_irq_is_postable(struct kvm_lapic_irq *irq)
 
 static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu)
 {
-	static_call_cond(kvm_x86_vcpu_blocking)(vcpu);
+	static_call_cond(kvm_x86_vcpu_blocking, vcpu);
 }
 
 static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu)
 {
-	static_call_cond(kvm_x86_vcpu_unblocking)(vcpu);
+	static_call_cond(kvm_x86_vcpu_unblocking, vcpu);
 }
 
 static inline int kvm_cpu_get_apicid(int mps_cpu)
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 964442b99245..16aa752f1ccb 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -28,7 +28,7 @@ void paravirt_set_sched_clock(u64 (*func)(void));
 
 static inline u64 paravirt_sched_clock(void)
 {
-	return static_call(pv_sched_clock)();
+	return static_call(pv_sched_clock);
 }
 
 struct static_key;
@@ -42,7 +42,7 @@ bool pv_is_native_vcpu_is_preempted(void);
 
 static inline u64 paravirt_steal_clock(int cpu)
 {
-	return static_call(pv_steal_clock)(cpu);
+	return static_call(pv_steal_clock, cpu);
 }
 
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index b24ca7f4ed7c..e40e9b8b2bd6 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -311,7 +311,7 @@ static void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	kvm_hv_set_cpuid(vcpu);
 
 	/* Invoke the vendor callback only after the above state is updated. */
-	static_call(kvm_x86_vcpu_after_set_cpuid)(vcpu);
+	static_call(kvm_x86_vcpu_after_set_cpuid, vcpu);
 
 	/*
 	 * Except for the MMU, which needs to do its thing any vendor specific
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 46f9dfb60469..b1b8006f9084 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1335,7 +1335,7 @@ static int kvm_hv_set_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 data,
 		}
 
 		/* vmcall/vmmcall */
-		static_call(kvm_x86_patch_hypercall)(vcpu, instructions + i);
+		static_call(kvm_x86_patch_hypercall, vcpu, instructions + i);
 		i += 3;
 
 		/* ret */
@@ -2201,7 +2201,7 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 	 * hypercall generates UD from non zero cpl and real mode
 	 * per HYPER-V spec
 	 */
-	if (static_call(kvm_x86_get_cpl)(vcpu) != 0 || !is_protmode(vcpu)) {
+	if (static_call(kvm_x86_get_cpl, vcpu) != 0 || !is_protmode(vcpu)) {
 		kvm_queue_exception(vcpu, UD_VECTOR);
 		return 1;
 	}
diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index 172b05343cfd..b86cf55afe4d 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -150,7 +150,7 @@ void __kvm_migrate_timers(struct kvm_vcpu *vcpu)
 {
 	__kvm_migrate_apic_timer(vcpu);
 	__kvm_migrate_pit_timer(vcpu);
-	static_call_cond(kvm_x86_migrate_timers)(vcpu);
+	static_call_cond(kvm_x86_migrate_timers, vcpu);
 }
 
 bool kvm_arch_irqfd_allowed(struct kvm *kvm, struct kvm_irqfd *args)
diff --git a/arch/x86/kvm/kvm_cache_regs.h b/arch/x86/kvm/kvm_cache_regs.h
index 3febc342360c..643b4abb2797 100644
--- a/arch/x86/kvm/kvm_cache_regs.h
+++ b/arch/x86/kvm/kvm_cache_regs.h
@@ -86,7 +86,7 @@ static inline unsigned long kvm_register_read_raw(struct kvm_vcpu *vcpu, int reg
 		return 0;
 
 	if (!kvm_register_is_available(vcpu, reg))
-		static_call(kvm_x86_cache_reg)(vcpu, reg);
+		static_call(kvm_x86_cache_reg, vcpu, reg);
 
 	return vcpu->arch.regs[reg];
 }
@@ -126,7 +126,7 @@ static inline u64 kvm_pdptr_read(struct kvm_vcpu *vcpu, int index)
 	might_sleep();  /* on svm */
 
 	if (!kvm_register_is_available(vcpu, VCPU_EXREG_PDPTR))
-		static_call(kvm_x86_cache_reg)(vcpu, VCPU_EXREG_PDPTR);
+		static_call(kvm_x86_cache_reg, vcpu, VCPU_EXREG_PDPTR);
 
 	return vcpu->arch.walk_mmu->pdptrs[index];
 }
@@ -141,7 +141,7 @@ static inline ulong kvm_read_cr0_bits(struct kvm_vcpu *vcpu, ulong mask)
 	ulong tmask = mask & KVM_POSSIBLE_CR0_GUEST_BITS;
 	if ((tmask & vcpu->arch.cr0_guest_owned_bits) &&
 	    !kvm_register_is_available(vcpu, VCPU_EXREG_CR0))
-		static_call(kvm_x86_cache_reg)(vcpu, VCPU_EXREG_CR0);
+		static_call(kvm_x86_cache_reg, vcpu, VCPU_EXREG_CR0);
 	return vcpu->arch.cr0 & mask;
 }
 
@@ -155,14 +155,14 @@ static inline ulong kvm_read_cr4_bits(struct kvm_vcpu *vcpu, ulong mask)
 	ulong tmask = mask & KVM_POSSIBLE_CR4_GUEST_BITS;
 	if ((tmask & vcpu->arch.cr4_guest_owned_bits) &&
 	    !kvm_register_is_available(vcpu, VCPU_EXREG_CR4))
-		static_call(kvm_x86_cache_reg)(vcpu, VCPU_EXREG_CR4);
+		static_call(kvm_x86_cache_reg, vcpu, VCPU_EXREG_CR4);
 	return vcpu->arch.cr4 & mask;
 }
 
 static inline ulong kvm_read_cr3(struct kvm_vcpu *vcpu)
 {
 	if (!kvm_register_is_available(vcpu, VCPU_EXREG_CR3))
-		static_call(kvm_x86_cache_reg)(vcpu, VCPU_EXREG_CR3);
+		static_call(kvm_x86_cache_reg, vcpu, VCPU_EXREG_CR3);
 	return vcpu->arch.cr3;
 }
 
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 66b0eb0bda94..743b99eb43ef 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -525,7 +525,7 @@ static inline void apic_clear_irr(int vec, struct kvm_lapic *apic)
 	if (unlikely(vcpu->arch.apicv_active)) {
 		/* need to update RVI */
 		kvm_lapic_clear_vector(vec, apic->regs + APIC_IRR);
-		static_call_cond(kvm_x86_hwapic_irr_update)(vcpu, apic_find_highest_irr(apic));
+		static_call_cond(kvm_x86_hwapic_irr_update, vcpu, apic_find_highest_irr(apic));
 	} else {
 		apic->irr_pending = false;
 		kvm_lapic_clear_vector(vec, apic->regs + APIC_IRR);
@@ -555,7 +555,7 @@ static inline void apic_set_isr(int vec, struct kvm_lapic *apic)
 	 * just set SVI.
 	 */
 	if (unlikely(vcpu->arch.apicv_active))
-		static_call_cond(kvm_x86_hwapic_isr_update)(vcpu, vec);
+		static_call_cond(kvm_x86_hwapic_isr_update, vcpu, vec);
 	else {
 		++apic->isr_count;
 		BUG_ON(apic->isr_count > MAX_APIC_VECTOR);
@@ -603,7 +603,7 @@ static inline void apic_clear_isr(int vec, struct kvm_lapic *apic)
 	 * and must be left alone.
 	 */
 	if (unlikely(vcpu->arch.apicv_active))
-		static_call_cond(kvm_x86_hwapic_isr_update)(vcpu, apic_find_highest_isr(apic));
+		static_call_cond(kvm_x86_hwapic_isr_update, vcpu, apic_find_highest_isr(apic));
 	else {
 		--apic->isr_count;
 		BUG_ON(apic->isr_count < 0);
@@ -739,7 +739,7 @@ static int apic_has_interrupt_for_ppr(struct kvm_lapic *apic, u32 ppr)
 {
 	int highest_irr;
 	if (kvm_x86_ops.sync_pir_to_irr)
-		highest_irr = static_call(kvm_x86_sync_pir_to_irr)(apic->vcpu);
+		highest_irr = static_call(kvm_x86_sync_pir_to_irr, apic->vcpu);
 	else
 		highest_irr = apic_find_highest_irr(apic);
 	if (highest_irr == -1 || (highest_irr & 0xF0) <= ppr)
@@ -1132,8 +1132,8 @@ static int __apic_accept_irq(struct kvm_lapic *apic, int delivery_mode,
 						       apic->regs + APIC_TMR);
 		}
 
-		static_call(kvm_x86_deliver_interrupt)(apic, delivery_mode,
-						       trig_mode, vector);
+		static_call(kvm_x86_deliver_interrupt, apic, delivery_mode,
+			    trig_mode, vector);
 		break;
 
 	case APIC_DM_REMRD:
@@ -1888,7 +1888,7 @@ static void cancel_hv_timer(struct kvm_lapic *apic)
 {
 	WARN_ON(preemptible());
 	WARN_ON(!apic->lapic_timer.hv_timer_in_use);
-	static_call(kvm_x86_cancel_hv_timer)(apic->vcpu);
+	static_call(kvm_x86_cancel_hv_timer, apic->vcpu);
 	apic->lapic_timer.hv_timer_in_use = false;
 }
 
@@ -1905,7 +1905,7 @@ static bool start_hv_timer(struct kvm_lapic *apic)
 	if (!ktimer->tscdeadline)
 		return false;
 
-	if (static_call(kvm_x86_set_hv_timer)(vcpu, ktimer->tscdeadline, &expired))
+	if (static_call(kvm_x86_set_hv_timer, vcpu, ktimer->tscdeadline, &expired))
 		return false;
 
 	ktimer->hv_timer_in_use = true;
@@ -2329,7 +2329,7 @@ void kvm_lapic_set_base(struct kvm_vcpu *vcpu, u64 value)
 		kvm_apic_set_x2apic_id(apic, vcpu->vcpu_id);
 
 	if ((old_value ^ value) & (MSR_IA32_APICBASE_ENABLE | X2APIC_ENABLE))
-		static_call_cond(kvm_x86_set_virtual_apic_mode)(vcpu);
+		static_call_cond(kvm_x86_set_virtual_apic_mode, vcpu);
 
 	apic->base_address = apic->vcpu->arch.apic_base &
 			     MSR_IA32_APICBASE_BASE;
@@ -2419,9 +2419,9 @@ void kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init_event)
 	vcpu->arch.pv_eoi.msr_val = 0;
 	apic_update_ppr(apic);
 	if (vcpu->arch.apicv_active) {
-		static_call_cond(kvm_x86_apicv_post_state_restore)(vcpu);
-		static_call_cond(kvm_x86_hwapic_irr_update)(vcpu, -1);
-		static_call_cond(kvm_x86_hwapic_isr_update)(vcpu, -1);
+		static_call_cond(kvm_x86_apicv_post_state_restore, vcpu);
+		static_call_cond(kvm_x86_hwapic_irr_update, vcpu, -1);
+		static_call_cond(kvm_x86_hwapic_isr_update, vcpu, -1);
 	}
 
 	vcpu->arch.apic_arb_prio = 0;
@@ -2697,9 +2697,9 @@ int kvm_apic_set_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s)
 	kvm_apic_update_apicv(vcpu);
 	apic->highest_isr_cache = -1;
 	if (vcpu->arch.apicv_active) {
-		static_call_cond(kvm_x86_apicv_post_state_restore)(vcpu);
-		static_call_cond(kvm_x86_hwapic_irr_update)(vcpu, apic_find_highest_irr(apic));
-		static_call_cond(kvm_x86_hwapic_isr_update)(vcpu, apic_find_highest_isr(apic));
+		static_call_cond(kvm_x86_apicv_post_state_restore, vcpu);
+		static_call_cond(kvm_x86_hwapic_irr_update, vcpu, apic_find_highest_irr(apic));
+		static_call_cond(kvm_x86_hwapic_isr_update, vcpu, apic_find_highest_isr(apic));
 	}
 	kvm_make_request(KVM_REQ_EVENT, vcpu);
 	if (ioapic_in_kernel(vcpu->kvm))
@@ -3002,7 +3002,7 @@ int kvm_apic_accept_events(struct kvm_vcpu *vcpu)
 			/* evaluate pending_events before reading the vector */
 			smp_rmb();
 			sipi_vector = apic->sipi_vector;
-			static_call(kvm_x86_vcpu_deliver_sipi_vector)(vcpu, sipi_vector);
+			static_call(kvm_x86_vcpu_deliver_sipi_vector, vcpu, sipi_vector);
 			vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;
 		}
 	}
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index e6cae6f22683..73880aa0b9e2 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -113,7 +113,7 @@ static inline void kvm_mmu_load_pgd(struct kvm_vcpu *vcpu)
 	if (!VALID_PAGE(root_hpa))
 		return;
 
-	static_call(kvm_x86_load_mmu_pgd)(vcpu, root_hpa,
+	static_call(kvm_x86_load_mmu_pgd, vcpu, root_hpa,
 					  vcpu->arch.mmu->shadow_root_level);
 }
 
@@ -218,7 +218,7 @@ static inline u8 permission_fault(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 {
 	/* strip nested paging fault error codes */
 	unsigned int pfec = access;
-	unsigned long rflags = static_call(kvm_x86_get_rflags)(vcpu);
+	unsigned long rflags = static_call(kvm_x86_get_rflags, vcpu);
 
 	/*
 	 * For explicit supervisor accesses, SMAP is disabled if EFLAGS.AC = 1.
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index f9080ee50ffa..0bdf76d94875 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -268,7 +268,7 @@ static void kvm_flush_remote_tlbs_with_range(struct kvm *kvm,
 	int ret = -ENOTSUPP;
 
 	if (range && kvm_x86_ops.tlb_remote_flush_with_range)
-		ret = static_call(kvm_x86_tlb_remote_flush_with_range)(kvm, range);
+		ret = static_call(kvm_x86_tlb_remote_flush_with_range, kvm, range);
 
 	if (ret)
 		kvm_flush_remote_tlbs(kvm);
@@ -5102,7 +5102,7 @@ int kvm_mmu_load(struct kvm_vcpu *vcpu)
 	 * stale entries.  Flushing on alloc also allows KVM to skip the TLB
 	 * flush when freeing a root (see kvm_tdp_mmu_put_root()).
 	 */
-	static_call(kvm_x86_flush_tlb_current)(vcpu);
+	static_call(kvm_x86_flush_tlb_current, vcpu);
 out:
 	return r;
 }
@@ -5408,7 +5408,7 @@ void kvm_mmu_invalidate_gva(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 		if (is_noncanonical_address(gva, vcpu))
 			return;
 
-		static_call(kvm_x86_flush_tlb_gva)(vcpu, gva);
+		static_call(kvm_x86_flush_tlb_gva, vcpu, gva);
 	}
 
 	if (!mmu->invlpg)
@@ -5464,7 +5464,7 @@ void kvm_mmu_invpcid_gva(struct kvm_vcpu *vcpu, gva_t gva, unsigned long pcid)
 	}
 
 	if (tlb_flush)
-		static_call(kvm_x86_flush_tlb_gva)(vcpu, gva);
+		static_call(kvm_x86_flush_tlb_gva, vcpu, gva);
 
 	++vcpu->stat.invlpg;
 
diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index 4739b53c9734..6b7bae4778a4 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -131,8 +131,8 @@ bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 	if (level > PG_LEVEL_4K)
 		spte |= PT_PAGE_SIZE_MASK;
 	if (tdp_enabled)
-		spte |= static_call(kvm_x86_get_mt_mask)(vcpu, gfn,
-			kvm_is_mmio_pfn(pfn));
+		spte |= static_call(kvm_x86_get_mt_mask, vcpu, gfn,
+				    kvm_is_mmio_pfn(pfn));
 
 	if (host_writable)
 		spte |= shadow_host_writable_mask;
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index eca39f56c231..4361f0e247ee 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -371,7 +371,7 @@ int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
 		return 1;
 
 	if (!(kvm_read_cr4(vcpu) & X86_CR4_PCE) &&
-	    (static_call(kvm_x86_get_cpl)(vcpu) != 0) &&
+	    (static_call(kvm_x86_get_cpl, vcpu) != 0) &&
 	    (kvm_read_cr0(vcpu) & X86_CR0_PE))
 		return 1;
 
@@ -523,7 +523,7 @@ static inline bool cpl_is_matched(struct kvm_pmc *pmc)
 		select_user = config & 0x2;
 	}
 
-	return (static_call(kvm_x86_get_cpl)(pmc->vcpu) == 0) ? select_os : select_user;
+	return (static_call(kvm_x86_get_cpl, pmc->vcpu) == 0) ? select_os : select_user;
 }
 
 void kvm_pmu_trigger_event(struct kvm_vcpu *vcpu, u64 perf_hw_id)
diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index e3a24b8f04be..a4845e1b5574 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -308,7 +308,7 @@ TRACE_EVENT(name,							     \
 		__entry->guest_rip	= kvm_rip_read(vcpu);		     \
 		__entry->isa            = isa;				     \
 		__entry->vcpu_id        = vcpu->vcpu_id;		     \
-		static_call(kvm_x86_get_exit_info)(vcpu,		     \
+		static_call(kvm_x86_get_exit_info, vcpu,		     \
 					  &__entry->exit_reason,	     \
 					  &__entry->info1,		     \
 					  &__entry->info2,		     \
@@ -792,7 +792,7 @@ TRACE_EVENT(kvm_emulate_insn,
 		),
 
 	TP_fast_assign(
-		__entry->csbase = static_call(kvm_x86_get_segment_base)(vcpu, VCPU_SREG_CS);
+		__entry->csbase = static_call(kvm_x86_get_segment_base, vcpu, VCPU_SREG_CS);
 		__entry->len = vcpu->arch.emulate_ctxt->fetch.ptr
 			       - vcpu->arch.emulate_ctxt->fetch.data;
 		__entry->rip = vcpu->arch.emulate_ctxt->_eip - __entry->len;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a6ab19afc638..ca400a219241 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -796,7 +796,7 @@ EXPORT_SYMBOL_GPL(kvm_requeue_exception_e);
  */
 bool kvm_require_cpl(struct kvm_vcpu *vcpu, int required_cpl)
 {
-	if (static_call(kvm_x86_get_cpl)(vcpu) <= required_cpl)
+	if (static_call(kvm_x86_get_cpl, vcpu) <= required_cpl)
 		return true;
 	kvm_queue_exception_e(vcpu, GP_VECTOR, 0);
 	return false;
@@ -918,7 +918,7 @@ int kvm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 
 		if (!is_pae(vcpu))
 			return 1;
-		static_call(kvm_x86_get_cs_db_l_bits)(vcpu, &cs_db, &cs_l);
+		static_call(kvm_x86_get_cs_db_l_bits, vcpu, &cs_db, &cs_l);
 		if (cs_l)
 			return 1;
 	}
@@ -932,7 +932,7 @@ int kvm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 	    (is_64_bit_mode(vcpu) || kvm_read_cr4_bits(vcpu, X86_CR4_PCIDE)))
 		return 1;
 
-	static_call(kvm_x86_set_cr0)(vcpu, cr0);
+	static_call(kvm_x86_set_cr0, vcpu, cr0);
 
 	kvm_post_set_cr0(vcpu, old_cr0, cr0);
 
@@ -1054,7 +1054,7 @@ static int __kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr)
 
 int kvm_emulate_xsetbv(struct kvm_vcpu *vcpu)
 {
-	if (static_call(kvm_x86_get_cpl)(vcpu) != 0 ||
+	if (static_call(kvm_x86_get_cpl, vcpu) != 0 ||
 	    __kvm_set_xcr(vcpu, kvm_rcx_read(vcpu), kvm_read_edx_eax(vcpu))) {
 		kvm_inject_gp(vcpu, 0);
 		return 1;
@@ -1072,7 +1072,7 @@ bool kvm_is_valid_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 	if (cr4 & vcpu->arch.cr4_guest_rsvd_bits)
 		return false;
 
-	return static_call(kvm_x86_is_valid_cr4)(vcpu, cr4);
+	return static_call(kvm_x86_is_valid_cr4, vcpu, cr4);
 }
 EXPORT_SYMBOL_GPL(kvm_is_valid_cr4);
 
@@ -1144,7 +1144,7 @@ int kvm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 			return 1;
 	}
 
-	static_call(kvm_x86_set_cr4)(vcpu, cr4);
+	static_call(kvm_x86_set_cr4, vcpu, cr4);
 
 	kvm_post_set_cr4(vcpu, old_cr4, cr4);
 
@@ -1285,7 +1285,7 @@ void kvm_update_dr7(struct kvm_vcpu *vcpu)
 		dr7 = vcpu->arch.guest_debug_dr7;
 	else
 		dr7 = vcpu->arch.dr7;
-	static_call(kvm_x86_set_dr7)(vcpu, dr7);
+	static_call(kvm_x86_set_dr7, vcpu, dr7);
 	vcpu->arch.switch_db_regs &= ~KVM_DEBUGREG_BP_ENABLED;
 	if (dr7 & DR7_BP_EN_MASK)
 		vcpu->arch.switch_db_regs |= KVM_DEBUGREG_BP_ENABLED;
@@ -1600,7 +1600,7 @@ static int kvm_get_msr_feature(struct kvm_msr_entry *msr)
 		rdmsrl_safe(msr->index, &msr->data);
 		break;
 	default:
-		return static_call(kvm_x86_get_msr_feature)(msr);
+		return static_call(kvm_x86_get_msr_feature, msr);
 	}
 	return 0;
 }
@@ -1676,7 +1676,7 @@ static int set_efer(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	efer &= ~EFER_LMA;
 	efer |= vcpu->arch.efer & EFER_LMA;
 
-	r = static_call(kvm_x86_set_efer)(vcpu, efer);
+	r = static_call(kvm_x86_set_efer, vcpu, efer);
 	if (r) {
 		WARN_ON(r > 0);
 		return r;
@@ -1802,7 +1802,7 @@ static int __kvm_set_msr(struct kvm_vcpu *vcpu, u32 index, u64 data,
 	msr.index = index;
 	msr.host_initiated = host_initiated;
 
-	return static_call(kvm_x86_set_msr)(vcpu, &msr);
+	return static_call(kvm_x86_set_msr, vcpu, &msr);
 }
 
 static int kvm_set_msr_ignored_check(struct kvm_vcpu *vcpu,
@@ -1844,7 +1844,7 @@ int __kvm_get_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data,
 	msr.index = index;
 	msr.host_initiated = host_initiated;
 
-	ret = static_call(kvm_x86_get_msr)(vcpu, &msr);
+	ret = static_call(kvm_x86_get_msr, vcpu, &msr);
 	if (!ret)
 		*data = msr.data;
 	return ret;
@@ -1912,7 +1912,7 @@ static int complete_emulated_rdmsr(struct kvm_vcpu *vcpu)
 
 static int complete_fast_msr_access(struct kvm_vcpu *vcpu)
 {
-	return static_call(kvm_x86_complete_emulated_msr)(vcpu, vcpu->run->msr.error);
+	return static_call(kvm_x86_complete_emulated_msr, vcpu, vcpu->run->msr.error);
 }
 
 static int complete_fast_rdmsr(struct kvm_vcpu *vcpu)
@@ -1976,7 +1976,7 @@ int kvm_emulate_rdmsr(struct kvm_vcpu *vcpu)
 		trace_kvm_msr_read_ex(ecx);
 	}
 
-	return static_call(kvm_x86_complete_emulated_msr)(vcpu, r);
+	return static_call(kvm_x86_complete_emulated_msr, vcpu, r);
 }
 EXPORT_SYMBOL_GPL(kvm_emulate_rdmsr);
 
@@ -2001,7 +2001,7 @@ int kvm_emulate_wrmsr(struct kvm_vcpu *vcpu)
 		trace_kvm_msr_write_ex(ecx, data);
 	}
 
-	return static_call(kvm_x86_complete_emulated_msr)(vcpu, r);
+	return static_call(kvm_x86_complete_emulated_msr, vcpu, r);
 }
 EXPORT_SYMBOL_GPL(kvm_emulate_wrmsr);
 
@@ -2507,12 +2507,12 @@ static void kvm_vcpu_write_tsc_offset(struct kvm_vcpu *vcpu, u64 l1_offset)
 	if (is_guest_mode(vcpu))
 		vcpu->arch.tsc_offset = kvm_calc_nested_tsc_offset(
 			l1_offset,
-			static_call(kvm_x86_get_l2_tsc_offset)(vcpu),
-			static_call(kvm_x86_get_l2_tsc_multiplier)(vcpu));
+			static_call(kvm_x86_get_l2_tsc_offset, vcpu),
+			static_call(kvm_x86_get_l2_tsc_multiplier, vcpu));
 	else
 		vcpu->arch.tsc_offset = l1_offset;
 
-	static_call(kvm_x86_write_tsc_offset)(vcpu, vcpu->arch.tsc_offset);
+	static_call(kvm_x86_write_tsc_offset, vcpu, vcpu->arch.tsc_offset);
 }
 
 static void kvm_vcpu_write_tsc_multiplier(struct kvm_vcpu *vcpu, u64 l1_multiplier)
@@ -2523,13 +2523,13 @@ static void kvm_vcpu_write_tsc_multiplier(struct kvm_vcpu *vcpu, u64 l1_multipli
 	if (is_guest_mode(vcpu))
 		vcpu->arch.tsc_scaling_ratio = kvm_calc_nested_tsc_multiplier(
 			l1_multiplier,
-			static_call(kvm_x86_get_l2_tsc_multiplier)(vcpu));
+			static_call(kvm_x86_get_l2_tsc_multiplier, vcpu));
 	else
 		vcpu->arch.tsc_scaling_ratio = l1_multiplier;
 
 	if (kvm_has_tsc_control)
-		static_call(kvm_x86_write_tsc_multiplier)(
-			vcpu, vcpu->arch.tsc_scaling_ratio);
+		static_call(kvm_x86_write_tsc_multiplier, vcpu,
+			    vcpu->arch.tsc_scaling_ratio);
 }
 
 static inline bool kvm_check_tsc_unstable(void)
@@ -3307,7 +3307,7 @@ static void kvmclock_reset(struct kvm_vcpu *vcpu)
 static void kvm_vcpu_flush_tlb_all(struct kvm_vcpu *vcpu)
 {
 	++vcpu->stat.tlb_flush;
-	static_call(kvm_x86_flush_tlb_all)(vcpu);
+	static_call(kvm_x86_flush_tlb_all, vcpu);
 }
 
 static void kvm_vcpu_flush_tlb_guest(struct kvm_vcpu *vcpu)
@@ -3325,14 +3325,14 @@ static void kvm_vcpu_flush_tlb_guest(struct kvm_vcpu *vcpu)
 		kvm_mmu_sync_prev_roots(vcpu);
 	}
 
-	static_call(kvm_x86_flush_tlb_guest)(vcpu);
+	static_call(kvm_x86_flush_tlb_guest, vcpu);
 }
 
 
 static inline void kvm_vcpu_flush_tlb_current(struct kvm_vcpu *vcpu)
 {
 	++vcpu->stat.tlb_flush;
-	static_call(kvm_x86_flush_tlb_current)(vcpu);
+	static_call(kvm_x86_flush_tlb_current, vcpu);
 }
 
 /*
@@ -4310,7 +4310,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		 * fringe case that is not enabled except via specific settings
 		 * of the module parameters.
 		 */
-		r = static_call(kvm_x86_has_emulated_msr)(kvm, MSR_IA32_SMBASE);
+		r = static_call(kvm_x86_has_emulated_msr, kvm, MSR_IA32_SMBASE);
 		break;
 	case KVM_CAP_NR_VCPUS:
 		r = min_t(unsigned int, num_online_cpus(), KVM_MAX_VCPUS);
@@ -4548,14 +4548,14 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	/* Address WBINVD may be executed by guest */
 	if (need_emulate_wbinvd(vcpu)) {
-		if (static_call(kvm_x86_has_wbinvd_exit)())
+		if (static_call(kvm_x86_has_wbinvd_exit))
 			cpumask_set_cpu(cpu, vcpu->arch.wbinvd_dirty_mask);
 		else if (vcpu->cpu != -1 && vcpu->cpu != cpu)
 			smp_call_function_single(vcpu->cpu,
 					wbinvd_ipi, NULL, 1);
 	}
 
-	static_call(kvm_x86_vcpu_load)(vcpu, cpu);
+	static_call(kvm_x86_vcpu_load, vcpu, cpu);
 
 	/* Save host pkru register if supported */
 	vcpu->arch.host_pkru = read_pkru();
@@ -4634,7 +4634,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 	int idx;
 
 	if (vcpu->preempted && !vcpu->arch.guest_state_protected)
-		vcpu->arch.preempted_in_kernel = !static_call(kvm_x86_get_cpl)(vcpu);
+		vcpu->arch.preempted_in_kernel = !static_call(kvm_x86_get_cpl, vcpu);
 
 	/*
 	 * Take the srcu lock as memslots will be accessed to check the gfn
@@ -4647,14 +4647,14 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 		kvm_steal_time_set_preempted(vcpu);
 	srcu_read_unlock(&vcpu->kvm->srcu, idx);
 
-	static_call(kvm_x86_vcpu_put)(vcpu);
+	static_call(kvm_x86_vcpu_put, vcpu);
 	vcpu->arch.last_host_tsc = rdtsc();
 }
 
 static int kvm_vcpu_ioctl_get_lapic(struct kvm_vcpu *vcpu,
 				    struct kvm_lapic_state *s)
 {
-	static_call_cond(kvm_x86_sync_pir_to_irr)(vcpu);
+	static_call_cond(kvm_x86_sync_pir_to_irr, vcpu);
 
 	return kvm_apic_get_state(vcpu, s);
 }
@@ -4773,7 +4773,7 @@ static int kvm_vcpu_ioctl_x86_setup_mce(struct kvm_vcpu *vcpu,
 	for (bank = 0; bank < bank_num; bank++)
 		vcpu->arch.mce_banks[bank*4] = ~(u64)0;
 
-	static_call(kvm_x86_setup_mce)(vcpu);
+	static_call(kvm_x86_setup_mce, vcpu);
 out:
 	return r;
 }
@@ -4880,11 +4880,11 @@ static void kvm_vcpu_ioctl_x86_get_vcpu_events(struct kvm_vcpu *vcpu,
 		vcpu->arch.interrupt.injected && !vcpu->arch.interrupt.soft;
 	events->interrupt.nr = vcpu->arch.interrupt.nr;
 	events->interrupt.soft = 0;
-	events->interrupt.shadow = static_call(kvm_x86_get_interrupt_shadow)(vcpu);
+	events->interrupt.shadow = static_call(kvm_x86_get_interrupt_shadow, vcpu);
 
 	events->nmi.injected = vcpu->arch.nmi_injected;
 	events->nmi.pending = vcpu->arch.nmi_pending != 0;
-	events->nmi.masked = static_call(kvm_x86_get_nmi_mask)(vcpu);
+	events->nmi.masked = static_call(kvm_x86_get_nmi_mask, vcpu);
 	events->nmi.pad = 0;
 
 	events->sipi_vector = 0; /* never valid when reporting to user space */
@@ -4951,13 +4951,13 @@ static int kvm_vcpu_ioctl_x86_set_vcpu_events(struct kvm_vcpu *vcpu,
 	vcpu->arch.interrupt.nr = events->interrupt.nr;
 	vcpu->arch.interrupt.soft = events->interrupt.soft;
 	if (events->flags & KVM_VCPUEVENT_VALID_SHADOW)
-		static_call(kvm_x86_set_interrupt_shadow)(vcpu,
-						events->interrupt.shadow);
+		static_call(kvm_x86_set_interrupt_shadow, vcpu,
+			    events->interrupt.shadow);
 
 	vcpu->arch.nmi_injected = events->nmi.injected;
 	if (events->flags & KVM_VCPUEVENT_VALID_NMI_PENDING)
 		vcpu->arch.nmi_pending = events->nmi.pending;
-	static_call(kvm_x86_set_nmi_mask)(vcpu, events->nmi.masked);
+	static_call(kvm_x86_set_nmi_mask, vcpu, events->nmi.masked);
 
 	if (events->flags & KVM_VCPUEVENT_VALID_SIPI_VECTOR &&
 	    lapic_in_kernel(vcpu))
@@ -5254,7 +5254,7 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 		if (!kvm_x86_ops.enable_direct_tlbflush)
 			return -ENOTTY;
 
-		return static_call(kvm_x86_enable_direct_tlbflush)(vcpu);
+		return static_call(kvm_x86_enable_direct_tlbflush, vcpu);
 
 	case KVM_CAP_HYPERV_ENFORCE_CPUID:
 		return kvm_hv_set_enforce_cpuid(vcpu, cap->args[0]);
@@ -5723,14 +5723,14 @@ static int kvm_vm_ioctl_set_tss_addr(struct kvm *kvm, unsigned long addr)
 
 	if (addr > (unsigned int)(-3 * PAGE_SIZE))
 		return -EINVAL;
-	ret = static_call(kvm_x86_set_tss_addr)(kvm, addr);
+	ret = static_call(kvm_x86_set_tss_addr, kvm, addr);
 	return ret;
 }
 
 static int kvm_vm_ioctl_set_identity_map_addr(struct kvm *kvm,
 					      u64 ident_addr)
 {
-	return static_call(kvm_x86_set_identity_map_addr)(kvm, ident_addr);
+	return static_call(kvm_x86_set_identity_map_addr, kvm, ident_addr);
 }
 
 static int kvm_vm_ioctl_set_nr_mmu_pages(struct kvm *kvm,
@@ -6027,14 +6027,14 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		if (!kvm_x86_ops.vm_copy_enc_context_from)
 			break;
 
-		r = static_call(kvm_x86_vm_copy_enc_context_from)(kvm, cap->args[0]);
+		r = static_call(kvm_x86_vm_copy_enc_context_from, kvm, cap->args[0]);
 		break;
 	case KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM:
 		r = -EINVAL;
 		if (!kvm_x86_ops.vm_move_enc_context_from)
 			break;
 
-		r = static_call(kvm_x86_vm_move_enc_context_from)(kvm, cap->args[0]);
+		r = static_call(kvm_x86_vm_move_enc_context_from, kvm, cap->args[0]);
 		break;
 	case KVM_CAP_EXIT_HYPERCALL:
 		if (cap->args[0] & ~KVM_EXIT_HYPERCALL_VALID_MASK) {
@@ -6525,7 +6525,7 @@ long kvm_arch_vm_ioctl(struct file *filp,
 		if (!kvm_x86_ops.mem_enc_ioctl)
 			goto out;
 
-		r = static_call(kvm_x86_mem_enc_ioctl)(kvm, argp);
+		r = static_call(kvm_x86_mem_enc_ioctl, kvm, argp);
 		break;
 	}
 	case KVM_MEMORY_ENCRYPT_REG_REGION: {
@@ -6539,7 +6539,7 @@ long kvm_arch_vm_ioctl(struct file *filp,
 		if (!kvm_x86_ops.mem_enc_register_region)
 			goto out;
 
-		r = static_call(kvm_x86_mem_enc_register_region)(kvm, &region);
+		r = static_call(kvm_x86_mem_enc_register_region, kvm, &region);
 		break;
 	}
 	case KVM_MEMORY_ENCRYPT_UNREG_REGION: {
@@ -6553,7 +6553,8 @@ long kvm_arch_vm_ioctl(struct file *filp,
 		if (!kvm_x86_ops.mem_enc_unregister_region)
 			goto out;
 
-		r = static_call(kvm_x86_mem_enc_unregister_region)(kvm, &region);
+		r = static_call(kvm_x86_mem_enc_unregister_region, kvm,
+				&region);
 		break;
 	}
 	case KVM_HYPERV_EVENTFD: {
@@ -6661,7 +6662,7 @@ static void kvm_init_msr_list(void)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(emulated_msrs_all); i++) {
-		if (!static_call(kvm_x86_has_emulated_msr)(NULL, emulated_msrs_all[i]))
+		if (!static_call(kvm_x86_has_emulated_msr, NULL, emulated_msrs_all[i]))
 			continue;
 
 		emulated_msrs[num_emulated_msrs++] = emulated_msrs_all[i];
@@ -6724,13 +6725,13 @@ static int vcpu_mmio_read(struct kvm_vcpu *vcpu, gpa_t addr, int len, void *v)
 static void kvm_set_segment(struct kvm_vcpu *vcpu,
 			struct kvm_segment *var, int seg)
 {
-	static_call(kvm_x86_set_segment)(vcpu, var, seg);
+	static_call(kvm_x86_set_segment, vcpu, var, seg);
 }
 
 void kvm_get_segment(struct kvm_vcpu *vcpu,
 		     struct kvm_segment *var, int seg)
 {
-	static_call(kvm_x86_get_segment)(vcpu, var, seg);
+	static_call(kvm_x86_get_segment, vcpu, var, seg);
 }
 
 gpa_t translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa, u64 access,
@@ -6753,7 +6754,7 @@ gpa_t kvm_mmu_gva_to_gpa_read(struct kvm_vcpu *vcpu, gva_t gva,
 {
 	struct kvm_mmu *mmu = vcpu->arch.walk_mmu;
 
-	u64 access = (static_call(kvm_x86_get_cpl)(vcpu) == 3) ? PFERR_USER_MASK : 0;
+	u64 access = (static_call(kvm_x86_get_cpl, vcpu) == 3) ? PFERR_USER_MASK : 0;
 	return mmu->gva_to_gpa(vcpu, mmu, gva, access, exception);
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_gva_to_gpa_read);
@@ -6763,7 +6764,7 @@ EXPORT_SYMBOL_GPL(kvm_mmu_gva_to_gpa_read);
 {
 	struct kvm_mmu *mmu = vcpu->arch.walk_mmu;
 
-	u64 access = (static_call(kvm_x86_get_cpl)(vcpu) == 3) ? PFERR_USER_MASK : 0;
+	u64 access = (static_call(kvm_x86_get_cpl, vcpu) == 3) ? PFERR_USER_MASK : 0;
 	access |= PFERR_FETCH_MASK;
 	return mmu->gva_to_gpa(vcpu, mmu, gva, access, exception);
 }
@@ -6773,7 +6774,7 @@ gpa_t kvm_mmu_gva_to_gpa_write(struct kvm_vcpu *vcpu, gva_t gva,
 {
 	struct kvm_mmu *mmu = vcpu->arch.walk_mmu;
 
-	u64 access = (static_call(kvm_x86_get_cpl)(vcpu) == 3) ? PFERR_USER_MASK : 0;
+	u64 access = (static_call(kvm_x86_get_cpl, vcpu) == 3) ? PFERR_USER_MASK : 0;
 	access |= PFERR_WRITE_MASK;
 	return mmu->gva_to_gpa(vcpu, mmu, gva, access, exception);
 }
@@ -6826,7 +6827,7 @@ static int kvm_fetch_guest_virt(struct x86_emulate_ctxt *ctxt,
 {
 	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
 	struct kvm_mmu *mmu = vcpu->arch.walk_mmu;
-	u64 access = (static_call(kvm_x86_get_cpl)(vcpu) == 3) ? PFERR_USER_MASK : 0;
+	u64 access = (static_call(kvm_x86_get_cpl, vcpu) == 3) ? PFERR_USER_MASK : 0;
 	unsigned offset;
 	int ret;
 
@@ -6851,7 +6852,7 @@ int kvm_read_guest_virt(struct kvm_vcpu *vcpu,
 			       gva_t addr, void *val, unsigned int bytes,
 			       struct x86_exception *exception)
 {
-	u64 access = (static_call(kvm_x86_get_cpl)(vcpu) == 3) ? PFERR_USER_MASK : 0;
+	u64 access = (static_call(kvm_x86_get_cpl, vcpu) == 3) ? PFERR_USER_MASK : 0;
 
 	/*
 	 * FIXME: this should call handle_emulation_failure if X86EMUL_IO_NEEDED
@@ -6874,7 +6875,7 @@ static int emulator_read_std(struct x86_emulate_ctxt *ctxt,
 
 	if (system)
 		access |= PFERR_IMPLICIT_ACCESS;
-	else if (static_call(kvm_x86_get_cpl)(vcpu) == 3)
+	else if (static_call(kvm_x86_get_cpl, vcpu) == 3)
 		access |= PFERR_USER_MASK;
 
 	return kvm_read_guest_virt_helper(addr, val, bytes, vcpu, access, exception);
@@ -6928,7 +6929,7 @@ static int emulator_write_std(struct x86_emulate_ctxt *ctxt, gva_t addr, void *v
 
 	if (system)
 		access |= PFERR_IMPLICIT_ACCESS;
-	else if (static_call(kvm_x86_get_cpl)(vcpu) == 3)
+	else if (static_call(kvm_x86_get_cpl, vcpu) == 3)
 		access |= PFERR_USER_MASK;
 
 	return kvm_write_guest_virt_helper(addr, val, bytes, vcpu,
@@ -6949,8 +6950,8 @@ EXPORT_SYMBOL_GPL(kvm_write_guest_virt_system);
 static int kvm_can_emulate_insn(struct kvm_vcpu *vcpu, int emul_type,
 				void *insn, int insn_len)
 {
-	return static_call(kvm_x86_can_emulate_instruction)(vcpu, emul_type,
-							    insn, insn_len);
+	return static_call(kvm_x86_can_emulate_instruction, vcpu, emul_type,
+			   insn, insn_len);
 }
 
 int handle_ud(struct kvm_vcpu *vcpu)
@@ -6995,7 +6996,7 @@ static int vcpu_mmio_gva_to_gpa(struct kvm_vcpu *vcpu, unsigned long gva,
 				bool write)
 {
 	struct kvm_mmu *mmu = vcpu->arch.walk_mmu;
-	u64 access = ((static_call(kvm_x86_get_cpl)(vcpu) == 3) ? PFERR_USER_MASK : 0)
+	u64 access = ((static_call(kvm_x86_get_cpl, vcpu) == 3) ? PFERR_USER_MASK : 0)
 		| (write ? PFERR_WRITE_MASK : 0);
 
 	/*
@@ -7425,7 +7426,7 @@ static int emulator_pio_out_emulated(struct x86_emulate_ctxt *ctxt,
 
 static unsigned long get_segment_base(struct kvm_vcpu *vcpu, int seg)
 {
-	return static_call(kvm_x86_get_segment_base)(vcpu, seg);
+	return static_call(kvm_x86_get_segment_base, vcpu, seg);
 }
 
 static void emulator_invlpg(struct x86_emulate_ctxt *ctxt, ulong address)
@@ -7438,7 +7439,7 @@ static int kvm_emulate_wbinvd_noskip(struct kvm_vcpu *vcpu)
 	if (!need_emulate_wbinvd(vcpu))
 		return X86EMUL_CONTINUE;
 
-	if (static_call(kvm_x86_has_wbinvd_exit)()) {
+	if (static_call(kvm_x86_has_wbinvd_exit)) {
 		int cpu = get_cpu();
 
 		cpumask_set_cpu(cpu, vcpu->arch.wbinvd_dirty_mask);
@@ -7543,27 +7544,27 @@ static int emulator_set_cr(struct x86_emulate_ctxt *ctxt, int cr, ulong val)
 
 static int emulator_get_cpl(struct x86_emulate_ctxt *ctxt)
 {
-	return static_call(kvm_x86_get_cpl)(emul_to_vcpu(ctxt));
+	return static_call(kvm_x86_get_cpl, emul_to_vcpu(ctxt));
 }
 
 static void emulator_get_gdt(struct x86_emulate_ctxt *ctxt, struct desc_ptr *dt)
 {
-	static_call(kvm_x86_get_gdt)(emul_to_vcpu(ctxt), dt);
+	static_call(kvm_x86_get_gdt, emul_to_vcpu(ctxt), dt);
 }
 
 static void emulator_get_idt(struct x86_emulate_ctxt *ctxt, struct desc_ptr *dt)
 {
-	static_call(kvm_x86_get_idt)(emul_to_vcpu(ctxt), dt);
+	static_call(kvm_x86_get_idt, emul_to_vcpu(ctxt), dt);
 }
 
 static void emulator_set_gdt(struct x86_emulate_ctxt *ctxt, struct desc_ptr *dt)
 {
-	static_call(kvm_x86_set_gdt)(emul_to_vcpu(ctxt), dt);
+	static_call(kvm_x86_set_gdt, emul_to_vcpu(ctxt), dt);
 }
 
 static void emulator_set_idt(struct x86_emulate_ctxt *ctxt, struct desc_ptr *dt)
 {
-	static_call(kvm_x86_set_idt)(emul_to_vcpu(ctxt), dt);
+	static_call(kvm_x86_set_idt, emul_to_vcpu(ctxt), dt);
 }
 
 static unsigned long emulator_get_cached_segment_base(
@@ -7721,8 +7722,8 @@ static int emulator_intercept(struct x86_emulate_ctxt *ctxt,
 			      struct x86_instruction_info *info,
 			      enum x86_intercept_stage stage)
 {
-	return static_call(kvm_x86_check_intercept)(emul_to_vcpu(ctxt), info, stage,
-					    &ctxt->exception);
+	return static_call(kvm_x86_check_intercept, emul_to_vcpu(ctxt), info,
+			   stage, &ctxt->exception);
 }
 
 static bool emulator_get_cpuid(struct x86_emulate_ctxt *ctxt,
@@ -7764,7 +7765,7 @@ static void emulator_write_gpr(struct x86_emulate_ctxt *ctxt, unsigned reg, ulon
 
 static void emulator_set_nmi_mask(struct x86_emulate_ctxt *ctxt, bool masked)
 {
-	static_call(kvm_x86_set_nmi_mask)(emul_to_vcpu(ctxt), masked);
+	static_call(kvm_x86_set_nmi_mask, emul_to_vcpu(ctxt), masked);
 }
 
 static unsigned emulator_get_hflags(struct x86_emulate_ctxt *ctxt)
@@ -7782,7 +7783,7 @@ static void emulator_exiting_smm(struct x86_emulate_ctxt *ctxt)
 static int emulator_leave_smm(struct x86_emulate_ctxt *ctxt,
 				  const char *smstate)
 {
-	return static_call(kvm_x86_leave_smm)(emul_to_vcpu(ctxt), smstate);
+	return static_call(kvm_x86_leave_smm, emul_to_vcpu(ctxt), smstate);
 }
 
 static void emulator_triple_fault(struct x86_emulate_ctxt *ctxt)
@@ -7847,7 +7848,7 @@ static const struct x86_emulate_ops emulate_ops = {
 
 static void toggle_interruptibility(struct kvm_vcpu *vcpu, u32 mask)
 {
-	u32 int_shadow = static_call(kvm_x86_get_interrupt_shadow)(vcpu);
+	u32 int_shadow = static_call(kvm_x86_get_interrupt_shadow, vcpu);
 	/*
 	 * an sti; sti; sequence only disable interrupts for the first
 	 * instruction. So, if the last instruction, be it emulated or
@@ -7858,7 +7859,7 @@ static void toggle_interruptibility(struct kvm_vcpu *vcpu, u32 mask)
 	if (int_shadow & mask)
 		mask = 0;
 	if (unlikely(int_shadow || mask)) {
-		static_call(kvm_x86_set_interrupt_shadow)(vcpu, mask);
+		static_call(kvm_x86_set_interrupt_shadow, vcpu, mask);
 		if (!mask)
 			kvm_make_request(KVM_REQ_EVENT, vcpu);
 	}
@@ -7900,7 +7901,7 @@ static void init_emulate_ctxt(struct kvm_vcpu *vcpu)
 	struct x86_emulate_ctxt *ctxt = vcpu->arch.emulate_ctxt;
 	int cs_db, cs_l;
 
-	static_call(kvm_x86_get_cs_db_l_bits)(vcpu, &cs_db, &cs_l);
+	static_call(kvm_x86_get_cs_db_l_bits, vcpu, &cs_db, &cs_l);
 
 	ctxt->gpa_available = false;
 	ctxt->eflags = kvm_get_rflags(vcpu);
@@ -7960,9 +7961,8 @@ static void prepare_emulation_failure_exit(struct kvm_vcpu *vcpu, u64 *data,
 	 */
 	memset(&info, 0, sizeof(info));
 
-	static_call(kvm_x86_get_exit_info)(vcpu, (u32 *)&info[0], &info[1],
-					   &info[2], (u32 *)&info[3],
-					   (u32 *)&info[4]);
+	static_call(kvm_x86_get_exit_info, vcpu, (u32 *)&info[0], &info[1],
+		    &info[2], (u32 *)&info[3], (u32 *)&info[4]);
 
 	run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
 	run->emulation_failure.suberror = KVM_INTERNAL_ERROR_EMULATION;
@@ -8039,7 +8039,7 @@ static int handle_emulation_failure(struct kvm_vcpu *vcpu, int emulation_type)
 
 	kvm_queue_exception(vcpu, UD_VECTOR);
 
-	if (!is_guest_mode(vcpu) && static_call(kvm_x86_get_cpl)(vcpu) == 0) {
+	if (!is_guest_mode(vcpu) && static_call(kvm_x86_get_cpl, vcpu) == 0) {
 		prepare_emulation_ctxt_failure_exit(vcpu);
 		return 0;
 	}
@@ -8228,10 +8228,10 @@ static int kvm_vcpu_do_singlestep(struct kvm_vcpu *vcpu)
 
 int kvm_skip_emulated_instruction(struct kvm_vcpu *vcpu)
 {
-	unsigned long rflags = static_call(kvm_x86_get_rflags)(vcpu);
+	unsigned long rflags = static_call(kvm_x86_get_rflags, vcpu);
 	int r;
 
-	r = static_call(kvm_x86_skip_emulated_instruction)(vcpu);
+	r = static_call(kvm_x86_skip_emulated_instruction, vcpu);
 	if (unlikely(!r))
 		return 0;
 
@@ -8494,7 +8494,7 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 
 writeback:
 	if (writeback) {
-		unsigned long rflags = static_call(kvm_x86_get_rflags)(vcpu);
+		unsigned long rflags = static_call(kvm_x86_get_rflags, vcpu);
 		toggle_interruptibility(vcpu, ctxt->interruptibility);
 		vcpu->arch.emulate_regs_need_sync_to_vcpu = false;
 		if (!ctxt->have_exception ||
@@ -8505,7 +8505,7 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 			kvm_rip_write(vcpu, ctxt->eip);
 			if (r && (ctxt->tf || (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP)))
 				r = kvm_vcpu_do_singlestep(vcpu);
-			static_call_cond(kvm_x86_update_emulated_instruction)(vcpu);
+			static_call_cond(kvm_x86_update_emulated_instruction, vcpu);
 			__kvm_set_rflags(vcpu, ctxt->eflags);
 		}
 
@@ -9187,7 +9187,7 @@ int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
 		a3 &= 0xFFFFFFFF;
 	}
 
-	if (static_call(kvm_x86_get_cpl)(vcpu) != 0) {
+	if (static_call(kvm_x86_get_cpl, vcpu) != 0) {
 		ret = -KVM_EPERM;
 		goto out;
 	}
@@ -9266,7 +9266,7 @@ static int emulator_fix_hypercall(struct x86_emulate_ctxt *ctxt)
 	char instruction[3];
 	unsigned long rip = kvm_rip_read(vcpu);
 
-	static_call(kvm_x86_patch_hypercall)(vcpu, instruction);
+	static_call(kvm_x86_patch_hypercall, vcpu, instruction);
 
 	return emulator_write_emulated(ctxt, rip, instruction, 3,
 		&ctxt->exception);
@@ -9283,7 +9283,7 @@ static void post_kvm_run_save(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *kvm_run = vcpu->run;
 
-	kvm_run->if_flag = static_call(kvm_x86_get_if_flag)(vcpu);
+	kvm_run->if_flag = static_call(kvm_x86_get_if_flag, vcpu);
 	kvm_run->cr8 = kvm_get_cr8(vcpu);
 	kvm_run->apic_base = kvm_get_apic_base(vcpu);
 
@@ -9318,7 +9318,7 @@ static void update_cr8_intercept(struct kvm_vcpu *vcpu)
 
 	tpr = kvm_lapic_get_cr8(vcpu);
 
-	static_call(kvm_x86_update_cr8_intercept)(vcpu, tpr, max_irr);
+	static_call(kvm_x86_update_cr8_intercept, vcpu, tpr, max_irr);
 }
 
 
@@ -9336,7 +9336,7 @@ static void kvm_inject_exception(struct kvm_vcpu *vcpu)
 {
 	if (vcpu->arch.exception.error_code && !is_protmode(vcpu))
 		vcpu->arch.exception.error_code = false;
-	static_call(kvm_x86_queue_exception)(vcpu);
+	static_call(kvm_x86_queue_exception, vcpu);
 }
 
 static int inject_pending_event(struct kvm_vcpu *vcpu, bool *req_immediate_exit)
@@ -9366,10 +9366,10 @@ static int inject_pending_event(struct kvm_vcpu *vcpu, bool *req_immediate_exit)
 	 */
 	else if (!vcpu->arch.exception.pending) {
 		if (vcpu->arch.nmi_injected) {
-			static_call(kvm_x86_inject_nmi)(vcpu);
+			static_call(kvm_x86_inject_nmi, vcpu);
 			can_inject = false;
 		} else if (vcpu->arch.interrupt.injected) {
-			static_call(kvm_x86_inject_irq)(vcpu);
+			static_call(kvm_x86_inject_irq, vcpu);
 			can_inject = false;
 		}
 	}
@@ -9430,7 +9430,7 @@ static int inject_pending_event(struct kvm_vcpu *vcpu, bool *req_immediate_exit)
 	 * The kvm_x86_ops hooks communicate this by returning -EBUSY.
 	 */
 	if (vcpu->arch.smi_pending) {
-		r = can_inject ? static_call(kvm_x86_smi_allowed)(vcpu, true) : -EBUSY;
+		r = can_inject ? static_call(kvm_x86_smi_allowed, vcpu, true) : -EBUSY;
 		if (r < 0)
 			goto out;
 		if (r) {
@@ -9439,35 +9439,35 @@ static int inject_pending_event(struct kvm_vcpu *vcpu, bool *req_immediate_exit)
 			enter_smm(vcpu);
 			can_inject = false;
 		} else
-			static_call(kvm_x86_enable_smi_window)(vcpu);
+			static_call(kvm_x86_enable_smi_window, vcpu);
 	}
 
 	if (vcpu->arch.nmi_pending) {
-		r = can_inject ? static_call(kvm_x86_nmi_allowed)(vcpu, true) : -EBUSY;
+		r = can_inject ? static_call(kvm_x86_nmi_allowed, vcpu, true) : -EBUSY;
 		if (r < 0)
 			goto out;
 		if (r) {
 			--vcpu->arch.nmi_pending;
 			vcpu->arch.nmi_injected = true;
-			static_call(kvm_x86_inject_nmi)(vcpu);
+			static_call(kvm_x86_inject_nmi, vcpu);
 			can_inject = false;
-			WARN_ON(static_call(kvm_x86_nmi_allowed)(vcpu, true) < 0);
+			WARN_ON(static_call(kvm_x86_nmi_allowed, vcpu, true) < 0);
 		}
 		if (vcpu->arch.nmi_pending)
-			static_call(kvm_x86_enable_nmi_window)(vcpu);
+			static_call(kvm_x86_enable_nmi_window, vcpu);
 	}
 
 	if (kvm_cpu_has_injectable_intr(vcpu)) {
-		r = can_inject ? static_call(kvm_x86_interrupt_allowed)(vcpu, true) : -EBUSY;
+		r = can_inject ? static_call(kvm_x86_interrupt_allowed, vcpu, true) : -EBUSY;
 		if (r < 0)
 			goto out;
 		if (r) {
 			kvm_queue_interrupt(vcpu, kvm_cpu_get_interrupt(vcpu), false);
-			static_call(kvm_x86_inject_irq)(vcpu);
-			WARN_ON(static_call(kvm_x86_interrupt_allowed)(vcpu, true) < 0);
+			static_call(kvm_x86_inject_irq, vcpu);
+			WARN_ON(static_call(kvm_x86_interrupt_allowed, vcpu, true) < 0);
 		}
 		if (kvm_cpu_has_injectable_intr(vcpu))
-			static_call(kvm_x86_enable_irq_window)(vcpu);
+			static_call(kvm_x86_enable_irq_window, vcpu);
 	}
 
 	if (is_guest_mode(vcpu) &&
@@ -9495,7 +9495,7 @@ static void process_nmi(struct kvm_vcpu *vcpu)
 	 * If an NMI is already in progress, limit further NMIs to just one.
 	 * Otherwise, allow two (and we'll inject the first one immediately).
 	 */
-	if (static_call(kvm_x86_get_nmi_mask)(vcpu) || vcpu->arch.nmi_injected)
+	if (static_call(kvm_x86_get_nmi_mask, vcpu) || vcpu->arch.nmi_injected)
 		limit = 1;
 
 	vcpu->arch.nmi_pending += atomic_xchg(&vcpu->arch.nmi_queued, 0);
@@ -9585,11 +9585,11 @@ static void enter_smm_save_state_32(struct kvm_vcpu *vcpu, char *buf)
 	put_smstate(u32, buf, 0x7f7c, seg.limit);
 	put_smstate(u32, buf, 0x7f78, enter_smm_get_segment_flags(&seg));
 
-	static_call(kvm_x86_get_gdt)(vcpu, &dt);
+	static_call(kvm_x86_get_gdt, vcpu, &dt);
 	put_smstate(u32, buf, 0x7f74, dt.address);
 	put_smstate(u32, buf, 0x7f70, dt.size);
 
-	static_call(kvm_x86_get_idt)(vcpu, &dt);
+	static_call(kvm_x86_get_idt, vcpu, &dt);
 	put_smstate(u32, buf, 0x7f58, dt.address);
 	put_smstate(u32, buf, 0x7f54, dt.size);
 
@@ -9639,7 +9639,7 @@ static void enter_smm_save_state_64(struct kvm_vcpu *vcpu, char *buf)
 	put_smstate(u32, buf, 0x7e94, seg.limit);
 	put_smstate(u64, buf, 0x7e98, seg.base);
 
-	static_call(kvm_x86_get_idt)(vcpu, &dt);
+	static_call(kvm_x86_get_idt, vcpu, &dt);
 	put_smstate(u32, buf, 0x7e84, dt.size);
 	put_smstate(u64, buf, 0x7e88, dt.address);
 
@@ -9649,7 +9649,7 @@ static void enter_smm_save_state_64(struct kvm_vcpu *vcpu, char *buf)
 	put_smstate(u32, buf, 0x7e74, seg.limit);
 	put_smstate(u64, buf, 0x7e78, seg.base);
 
-	static_call(kvm_x86_get_gdt)(vcpu, &dt);
+	static_call(kvm_x86_get_gdt, vcpu, &dt);
 	put_smstate(u32, buf, 0x7e64, dt.size);
 	put_smstate(u64, buf, 0x7e68, dt.address);
 
@@ -9678,28 +9678,28 @@ static void enter_smm(struct kvm_vcpu *vcpu)
 	 * state (e.g. leave guest mode) after we've saved the state into the
 	 * SMM state-save area.
 	 */
-	static_call(kvm_x86_enter_smm)(vcpu, buf);
+	static_call(kvm_x86_enter_smm, vcpu, buf);
 
 	kvm_smm_changed(vcpu, true);
 	kvm_vcpu_write_guest(vcpu, vcpu->arch.smbase + 0xfe00, buf, sizeof(buf));
 
-	if (static_call(kvm_x86_get_nmi_mask)(vcpu))
+	if (static_call(kvm_x86_get_nmi_mask, vcpu))
 		vcpu->arch.hflags |= HF_SMM_INSIDE_NMI_MASK;
 	else
-		static_call(kvm_x86_set_nmi_mask)(vcpu, true);
+		static_call(kvm_x86_set_nmi_mask, vcpu, true);
 
 	kvm_set_rflags(vcpu, X86_EFLAGS_FIXED);
 	kvm_rip_write(vcpu, 0x8000);
 
 	cr0 = vcpu->arch.cr0 & ~(X86_CR0_PE | X86_CR0_EM | X86_CR0_TS | X86_CR0_PG);
-	static_call(kvm_x86_set_cr0)(vcpu, cr0);
+	static_call(kvm_x86_set_cr0, vcpu, cr0);
 	vcpu->arch.cr0 = cr0;
 
-	static_call(kvm_x86_set_cr4)(vcpu, 0);
+	static_call(kvm_x86_set_cr4, vcpu, 0);
 
 	/* Undocumented: IDT limit is set to zero on entry to SMM.  */
 	dt.address = dt.size = 0;
-	static_call(kvm_x86_set_idt)(vcpu, &dt);
+	static_call(kvm_x86_set_idt, vcpu, &dt);
 
 	kvm_set_dr(vcpu, 7, DR7_FIXED_1);
 
@@ -9730,7 +9730,7 @@ static void enter_smm(struct kvm_vcpu *vcpu)
 
 #ifdef CONFIG_X86_64
 	if (guest_cpuid_has(vcpu, X86_FEATURE_LM))
-		static_call(kvm_x86_set_efer)(vcpu, 0);
+		static_call(kvm_x86_set_efer, vcpu, 0);
 #endif
 
 	kvm_update_cpuid_runtime(vcpu);
@@ -9769,7 +9769,7 @@ void kvm_vcpu_update_apicv(struct kvm_vcpu *vcpu)
 
 	vcpu->arch.apicv_active = activate;
 	kvm_apic_update_apicv(vcpu);
-	static_call(kvm_x86_refresh_apicv_exec_ctrl)(vcpu);
+	static_call(kvm_x86_refresh_apicv_exec_ctrl, vcpu);
 
 	/*
 	 * When APICv gets disabled, we may still have injected interrupts
@@ -9792,7 +9792,7 @@ void __kvm_set_or_clear_apicv_inhibit(struct kvm *kvm,
 
 	lockdep_assert_held_write(&kvm->arch.apicv_update_lock);
 
-	if (!static_call(kvm_x86_check_apicv_inhibit_reasons)(reason))
+	if (!static_call(kvm_x86_check_apicv_inhibit_reasons, reason))
 		return;
 
 	old = new = kvm->arch.apicv_inhibit_reasons;
@@ -9845,7 +9845,7 @@ static void vcpu_scan_ioapic(struct kvm_vcpu *vcpu)
 	if (irqchip_split(vcpu->kvm))
 		kvm_scan_ioapic_routes(vcpu, vcpu->arch.ioapic_handled_vectors);
 	else {
-		static_call_cond(kvm_x86_sync_pir_to_irr)(vcpu);
+		static_call_cond(kvm_x86_sync_pir_to_irr, vcpu);
 		if (ioapic_in_kernel(vcpu->kvm))
 			kvm_ioapic_scan_entry(vcpu, vcpu->arch.ioapic_handled_vectors);
 	}
@@ -9867,12 +9867,13 @@ static void vcpu_load_eoi_exitmap(struct kvm_vcpu *vcpu)
 		bitmap_or((ulong *)eoi_exit_bitmap,
 			  vcpu->arch.ioapic_handled_vectors,
 			  to_hv_synic(vcpu)->vec_bitmap, 256);
-		static_call_cond(kvm_x86_load_eoi_exitmap)(vcpu, eoi_exit_bitmap);
+		static_call_cond(kvm_x86_load_eoi_exitmap, vcpu,
+				 eoi_exit_bitmap);
 		return;
 	}
 
-	static_call_cond(kvm_x86_load_eoi_exitmap)(
-		vcpu, (u64 *)vcpu->arch.ioapic_handled_vectors);
+	static_call_cond(kvm_x86_load_eoi_exitmap, vcpu,
+		         (u64 *)vcpu->arch.ioapic_handled_vectors);
 }
 
 void kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
@@ -9891,7 +9892,7 @@ void kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
 
 void kvm_arch_guest_memory_reclaimed(struct kvm *kvm)
 {
-	static_call_cond(kvm_x86_guest_memory_reclaimed)(kvm);
+	static_call_cond(kvm_x86_guest_memory_reclaimed, kvm);
 }
 
 static void kvm_vcpu_reload_apic_access_page(struct kvm_vcpu *vcpu)
@@ -9899,7 +9900,7 @@ static void kvm_vcpu_reload_apic_access_page(struct kvm_vcpu *vcpu)
 	if (!lapic_in_kernel(vcpu))
 		return;
 
-	static_call_cond(kvm_x86_set_apic_access_page_addr)(vcpu);
+	static_call_cond(kvm_x86_set_apic_access_page_addr, vcpu);
 }
 
 void __kvm_request_immediate_exit(struct kvm_vcpu *vcpu)
@@ -10050,10 +10051,10 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		if (kvm_check_request(KVM_REQ_APF_READY, vcpu))
 			kvm_check_async_pf_completion(vcpu);
 		if (kvm_check_request(KVM_REQ_MSR_FILTER_CHANGED, vcpu))
-			static_call(kvm_x86_msr_filter_changed)(vcpu);
+			static_call(kvm_x86_msr_filter_changed, vcpu);
 
 		if (kvm_check_request(KVM_REQ_UPDATE_CPU_DIRTY_LOGGING, vcpu))
-			static_call(kvm_x86_update_cpu_dirty_logging)(vcpu);
+			static_call(kvm_x86_update_cpu_dirty_logging, vcpu);
 	}
 
 	if (kvm_check_request(KVM_REQ_EVENT, vcpu) || req_int_win ||
@@ -10075,7 +10076,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 			goto out;
 		}
 		if (req_int_win)
-			static_call(kvm_x86_enable_irq_window)(vcpu);
+			static_call(kvm_x86_enable_irq_window, vcpu);
 
 		if (kvm_lapic_enabled(vcpu)) {
 			update_cr8_intercept(vcpu);
@@ -10090,7 +10091,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 
 	preempt_disable();
 
-	static_call(kvm_x86_prepare_switch_to_guest)(vcpu);
+	static_call(kvm_x86_prepare_switch_to_guest, vcpu);
 
 	/*
 	 * Disable IRQs before setting IN_GUEST_MODE.  Posted interrupt
@@ -10126,7 +10127,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	 * i.e. they can post interrupts even if APICv is temporarily disabled.
 	 */
 	if (kvm_lapic_enabled(vcpu))
-		static_call_cond(kvm_x86_sync_pir_to_irr)(vcpu);
+		static_call_cond(kvm_x86_sync_pir_to_irr, vcpu);
 
 	if (kvm_vcpu_exit_request(vcpu)) {
 		vcpu->mode = OUTSIDE_GUEST_MODE;
@@ -10140,7 +10141,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 
 	if (req_immediate_exit) {
 		kvm_make_request(KVM_REQ_EVENT, vcpu);
-		static_call(kvm_x86_request_immediate_exit)(vcpu);
+		static_call(kvm_x86_request_immediate_exit, vcpu);
 	}
 
 	fpregs_assert_state_consistent();
@@ -10171,12 +10172,12 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		 */
 		WARN_ON_ONCE(kvm_apicv_activated(vcpu->kvm) != kvm_vcpu_apicv_active(vcpu));
 
-		exit_fastpath = static_call(kvm_x86_vcpu_run)(vcpu);
+		exit_fastpath = static_call(kvm_x86_vcpu_run, vcpu);
 		if (likely(exit_fastpath != EXIT_FASTPATH_REENTER_GUEST))
 			break;
 
 		if (kvm_lapic_enabled(vcpu))
-			static_call_cond(kvm_x86_sync_pir_to_irr)(vcpu);
+			static_call_cond(kvm_x86_sync_pir_to_irr, vcpu);
 
 		if (unlikely(kvm_vcpu_exit_request(vcpu))) {
 			exit_fastpath = EXIT_FASTPATH_EXIT_HANDLED;
@@ -10192,7 +10193,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	 */
 	if (unlikely(vcpu->arch.switch_db_regs & KVM_DEBUGREG_WONT_EXIT)) {
 		WARN_ON(vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP);
-		static_call(kvm_x86_sync_dirty_debug_regs)(vcpu);
+		static_call(kvm_x86_sync_dirty_debug_regs, vcpu);
 		kvm_update_dr0123(vcpu);
 		kvm_update_dr7(vcpu);
 	}
@@ -10221,7 +10222,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.xfd_no_write_intercept)
 		fpu_sync_guest_vmexit_xfd_state();
 
-	static_call(kvm_x86_handle_exit_irqoff)(vcpu);
+	static_call(kvm_x86_handle_exit_irqoff, vcpu);
 
 	if (vcpu->arch.guest_fpu.xfd_err)
 		wrmsrl(MSR_IA32_XFD_ERR, 0);
@@ -10275,13 +10276,13 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.apic_attention)
 		kvm_lapic_sync_from_vapic(vcpu);
 
-	r = static_call(kvm_x86_handle_exit)(vcpu, exit_fastpath);
+	r = static_call(kvm_x86_handle_exit, vcpu, exit_fastpath);
 	return r;
 
 cancel_injection:
 	if (req_immediate_exit)
 		kvm_make_request(KVM_REQ_EVENT, vcpu);
-	static_call(kvm_x86_cancel_injection)(vcpu);
+	static_call(kvm_x86_cancel_injection, vcpu);
 	if (unlikely(vcpu->arch.apic_attention))
 		kvm_lapic_sync_from_vapic(vcpu);
 out:
@@ -10554,7 +10555,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		goto out;
 	}
 
-	r = static_call(kvm_x86_vcpu_pre_run)(vcpu);
+	r = static_call(kvm_x86_vcpu_pre_run, vcpu);
 	if (r <= 0)
 		goto out;
 
@@ -10673,10 +10674,10 @@ static void __get_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 	kvm_get_segment(vcpu, &sregs->tr, VCPU_SREG_TR);
 	kvm_get_segment(vcpu, &sregs->ldt, VCPU_SREG_LDTR);
 
-	static_call(kvm_x86_get_idt)(vcpu, &dt);
+	static_call(kvm_x86_get_idt, vcpu, &dt);
 	sregs->idt.limit = dt.size;
 	sregs->idt.base = dt.address;
-	static_call(kvm_x86_get_gdt)(vcpu, &dt);
+	static_call(kvm_x86_get_gdt, vcpu, &dt);
 	sregs->gdt.limit = dt.size;
 	sregs->gdt.base = dt.address;
 
@@ -10857,28 +10858,28 @@ static int __set_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs,
 
 	dt.size = sregs->idt.limit;
 	dt.address = sregs->idt.base;
-	static_call(kvm_x86_set_idt)(vcpu, &dt);
+	static_call(kvm_x86_set_idt, vcpu, &dt);
 	dt.size = sregs->gdt.limit;
 	dt.address = sregs->gdt.base;
-	static_call(kvm_x86_set_gdt)(vcpu, &dt);
+	static_call(kvm_x86_set_gdt, vcpu, &dt);
 
 	vcpu->arch.cr2 = sregs->cr2;
 	*mmu_reset_needed |= kvm_read_cr3(vcpu) != sregs->cr3;
 	vcpu->arch.cr3 = sregs->cr3;
 	kvm_register_mark_dirty(vcpu, VCPU_EXREG_CR3);
-	static_call_cond(kvm_x86_post_set_cr3)(vcpu, sregs->cr3);
+	static_call_cond(kvm_x86_post_set_cr3, vcpu, sregs->cr3);
 
 	kvm_set_cr8(vcpu, sregs->cr8);
 
 	*mmu_reset_needed |= vcpu->arch.efer != sregs->efer;
-	static_call(kvm_x86_set_efer)(vcpu, sregs->efer);
+	static_call(kvm_x86_set_efer, vcpu, sregs->efer);
 
 	*mmu_reset_needed |= kvm_read_cr0(vcpu) != sregs->cr0;
-	static_call(kvm_x86_set_cr0)(vcpu, sregs->cr0);
+	static_call(kvm_x86_set_cr0, vcpu, sregs->cr0);
 	vcpu->arch.cr0 = sregs->cr0;
 
 	*mmu_reset_needed |= kvm_read_cr4(vcpu) != sregs->cr4;
-	static_call(kvm_x86_set_cr4)(vcpu, sregs->cr4);
+	static_call(kvm_x86_set_cr4, vcpu, sregs->cr4);
 
 	if (update_pdptrs) {
 		idx = srcu_read_lock(&vcpu->kvm->srcu);
@@ -11048,7 +11049,7 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 	 */
 	kvm_set_rflags(vcpu, rflags);
 
-	static_call(kvm_x86_update_exception_bitmap)(vcpu);
+	static_call(kvm_x86_update_exception_bitmap, vcpu);
 
 	kvm_arch_vcpu_guestdbg_update_apicv_inhibit(vcpu->kvm);
 
@@ -11255,7 +11256,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	vcpu->arch.hv_root_tdp = INVALID_PAGE;
 #endif
 
-	r = static_call(kvm_x86_vcpu_create)(vcpu);
+	r = static_call(kvm_x86_vcpu_create, vcpu);
 	if (r)
 		goto free_guest_fpu;
 
@@ -11312,7 +11313,7 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 
 	kvmclock_reset(vcpu);
 
-	static_call(kvm_x86_vcpu_free)(vcpu);
+	static_call(kvm_x86_vcpu_free, vcpu);
 
 	kmem_cache_free(x86_emulator_cache, vcpu->arch.emulate_ctxt);
 	free_cpumask_var(vcpu->arch.wbinvd_dirty_mask);
@@ -11419,7 +11420,7 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	cpuid_0x1 = kvm_find_cpuid_entry(vcpu, 1, 0);
 	kvm_rdx_write(vcpu, cpuid_0x1 ? cpuid_0x1->eax : 0x600);
 
-	static_call(kvm_x86_vcpu_reset)(vcpu, init_event);
+	static_call(kvm_x86_vcpu_reset, vcpu, init_event);
 
 	kvm_set_rflags(vcpu, X86_EFLAGS_FIXED);
 	kvm_rip_write(vcpu, 0xfff0);
@@ -11438,10 +11439,10 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	else
 		new_cr0 |= X86_CR0_NW | X86_CR0_CD;
 
-	static_call(kvm_x86_set_cr0)(vcpu, new_cr0);
-	static_call(kvm_x86_set_cr4)(vcpu, 0);
-	static_call(kvm_x86_set_efer)(vcpu, 0);
-	static_call(kvm_x86_update_exception_bitmap)(vcpu);
+	static_call(kvm_x86_set_cr0, vcpu, new_cr0);
+	static_call(kvm_x86_set_cr4, vcpu, 0);
+	static_call(kvm_x86_set_efer, vcpu, 0);
+	static_call(kvm_x86_update_exception_bitmap, vcpu);
 
 	/*
 	 * On the standard CR0/CR4/EFER modification paths, there are several
@@ -11493,7 +11494,7 @@ int kvm_arch_hardware_enable(void)
 	bool stable, backwards_tsc = false;
 
 	kvm_user_return_msr_cpu_online();
-	ret = static_call(kvm_x86_hardware_enable)();
+	ret = static_call(kvm_x86_hardware_enable);
 	if (ret != 0)
 		return ret;
 
@@ -11575,7 +11576,7 @@ int kvm_arch_hardware_enable(void)
 
 void kvm_arch_hardware_disable(void)
 {
-	static_call(kvm_x86_hardware_disable)();
+	static_call(kvm_x86_hardware_disable);
 	drop_user_return_notifiers();
 }
 
@@ -11625,7 +11626,7 @@ void kvm_arch_hardware_unsetup(void)
 {
 	kvm_unregister_perf_callbacks();
 
-	static_call(kvm_x86_hardware_unsetup)();
+	static_call(kvm_x86_hardware_unsetup);
 }
 
 int kvm_arch_check_processor_compat(void *opaque)
@@ -11665,7 +11666,7 @@ void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu)
 		pmu->need_cleanup = true;
 		kvm_make_request(KVM_REQ_PMU, vcpu);
 	}
-	static_call(kvm_x86_sched_in)(vcpu, cpu);
+	static_call(kvm_x86_sched_in, vcpu, cpu);
 }
 
 void kvm_arch_free_vm(struct kvm *kvm)
@@ -11725,7 +11726,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	kvm_hv_init_vm(kvm);
 	kvm_xen_init_vm(kvm);
 
-	return static_call(kvm_x86_vm_init)(kvm);
+	return static_call(kvm_x86_vm_init, kvm);
 
 out_page_track:
 	kvm_page_track_cleanup(kvm);
@@ -11864,7 +11865,7 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 		__x86_set_memory_region(kvm, TSS_PRIVATE_MEMSLOT, 0, 0);
 		mutex_unlock(&kvm->slots_lock);
 	}
-	static_call_cond(kvm_x86_vm_destroy)(kvm);
+	static_call_cond(kvm_x86_vm_destroy, kvm);
 	kvm_free_msr_filter(srcu_dereference_check(kvm->arch.msr_filter, &kvm->srcu, 1));
 	kvm_pic_destroy(kvm);
 	kvm_ioapic_destroy(kvm);
@@ -12147,7 +12148,7 @@ void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
 static inline bool kvm_guest_apic_has_interrupt(struct kvm_vcpu *vcpu)
 {
 	return (is_guest_mode(vcpu) &&
-		static_call(kvm_x86_guest_apic_has_interrupt)(vcpu));
+		static_call(kvm_x86_guest_apic_has_interrupt, vcpu));
 }
 
 static inline bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)
@@ -12166,12 +12167,12 @@ static inline bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)
 
 	if (kvm_test_request(KVM_REQ_NMI, vcpu) ||
 	    (vcpu->arch.nmi_pending &&
-	     static_call(kvm_x86_nmi_allowed)(vcpu, false)))
+	     static_call(kvm_x86_nmi_allowed, vcpu, false)))
 		return true;
 
 	if (kvm_test_request(KVM_REQ_SMI, vcpu) ||
 	    (vcpu->arch.smi_pending &&
-	     static_call(kvm_x86_smi_allowed)(vcpu, false)))
+	     static_call(kvm_x86_smi_allowed, vcpu, false)))
 		return true;
 
 	if (kvm_arch_interrupt_allowed(vcpu) &&
@@ -12197,7 +12198,7 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu)
 
 bool kvm_arch_dy_has_pending_interrupt(struct kvm_vcpu *vcpu)
 {
-	if (vcpu->arch.apicv_active && static_call(kvm_x86_dy_apicv_has_pending_interrupt)(vcpu))
+	if (vcpu->arch.apicv_active && static_call(kvm_x86_dy_apicv_has_pending_interrupt, vcpu))
 		return true;
 
 	return false;
@@ -12236,7 +12237,7 @@ int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
 
 int kvm_arch_interrupt_allowed(struct kvm_vcpu *vcpu)
 {
-	return static_call(kvm_x86_interrupt_allowed)(vcpu, false);
+	return static_call(kvm_x86_interrupt_allowed, vcpu, false);
 }
 
 unsigned long kvm_get_linear_rip(struct kvm_vcpu *vcpu)
@@ -12262,7 +12263,7 @@ unsigned long kvm_get_rflags(struct kvm_vcpu *vcpu)
 {
 	unsigned long rflags;
 
-	rflags = static_call(kvm_x86_get_rflags)(vcpu);
+	rflags = static_call(kvm_x86_get_rflags, vcpu);
 	if (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP)
 		rflags &= ~X86_EFLAGS_TF;
 	return rflags;
@@ -12274,7 +12275,7 @@ static void __kvm_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags)
 	if (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP &&
 	    kvm_is_linear_rip(vcpu, vcpu->arch.singlestep_rip))
 		rflags |= X86_EFLAGS_TF;
-	static_call(kvm_x86_set_rflags)(vcpu, rflags);
+	static_call(kvm_x86_set_rflags, vcpu, rflags);
 }
 
 void kvm_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags)
@@ -12405,7 +12406,7 @@ static bool kvm_can_deliver_async_pf(struct kvm_vcpu *vcpu)
 		return false;
 
 	if (vcpu->arch.apf.send_user_only &&
-	    static_call(kvm_x86_get_cpl)(vcpu) == 0)
+	    static_call(kvm_x86_get_cpl, vcpu) == 0)
 		return false;
 
 	if (is_guest_mode(vcpu)) {
@@ -12516,7 +12517,7 @@ bool kvm_arch_can_dequeue_async_page_present(struct kvm_vcpu *vcpu)
 void kvm_arch_start_assignment(struct kvm *kvm)
 {
 	if (atomic_inc_return(&kvm->arch.assigned_device_count) == 1)
-		static_call_cond(kvm_x86_pi_start_assignment)(kvm);
+		static_call_cond(kvm_x86_pi_start_assignment, kvm);
 }
 EXPORT_SYMBOL_GPL(kvm_arch_start_assignment);
 
@@ -12564,8 +12565,7 @@ int kvm_arch_irq_bypass_add_producer(struct irq_bypass_consumer *cons,
 
 	irqfd->producer = prod;
 	kvm_arch_start_assignment(irqfd->kvm);
-	ret = static_call(kvm_x86_pi_update_irte)(irqfd->kvm,
-					 prod->irq, irqfd->gsi, 1);
+	ret = static_call(kvm_x86_pi_update_irte, irqfd->kvm, prod->irq, irqfd->gsi, 1);
 
 	if (ret)
 		kvm_arch_end_assignment(irqfd->kvm);
@@ -12589,7 +12589,7 @@ void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
 	 * when the irq is masked/disabled or the consumer side (KVM
 	 * int this case doesn't want to receive the interrupts.
 	*/
-	ret = static_call(kvm_x86_pi_update_irte)(irqfd->kvm, prod->irq, irqfd->gsi, 0);
+	ret = static_call(kvm_x86_pi_update_irte, irqfd->kvm, prod->irq, irqfd->gsi, 0);
 	if (ret)
 		printk(KERN_INFO "irq bypass consumer (token %p) unregistration"
 		       " fails: %d\n", irqfd->consumer.token, ret);
@@ -12600,7 +12600,7 @@ void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
 int kvm_arch_update_irqfd_routing(struct kvm *kvm, unsigned int host_irq,
 				   uint32_t guest_irq, bool set)
 {
-	return static_call(kvm_x86_pi_update_irte)(kvm, host_irq, guest_irq, set);
+	return static_call(kvm_x86_pi_update_irte, kvm, host_irq, guest_irq, set);
 }
 
 bool kvm_arch_irqfd_route_changed(struct kvm_kernel_irq_routing_entry *old,
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 588792f00334..4b3b3d9b66b8 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -113,7 +113,7 @@ static inline bool is_64_bit_mode(struct kvm_vcpu *vcpu)
 
 	if (!is_long_mode(vcpu))
 		return false;
-	static_call(kvm_x86_get_cs_db_l_bits)(vcpu, &cs_db, &cs_l);
+	static_call(kvm_x86_get_cs_db_l_bits, vcpu, &cs_db, &cs_l);
 	return cs_l;
 }
 
@@ -248,7 +248,7 @@ static inline bool kvm_check_has_quirk(struct kvm *kvm, u64 quirk)
 
 static inline bool kvm_vcpu_latch_init(struct kvm_vcpu *vcpu)
 {
-	return is_smm(vcpu) || static_call(kvm_x86_apic_init_signal_blocked)(vcpu);
+	return is_smm(vcpu) || static_call(kvm_x86_apic_init_signal_blocked, vcpu);
 }
 
 void kvm_inject_realmode_interrupt(struct kvm_vcpu *vcpu, int irq, int inc_eip);
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index bf6cc25eee76..9c5d966d18e4 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -732,7 +732,7 @@ int kvm_xen_write_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
 		instructions[0] = 0xb8;
 
 		/* vmcall / vmmcall */
-		static_call(kvm_x86_patch_hypercall)(vcpu, instructions + 5);
+		static_call(kvm_x86_patch_hypercall, vcpu, instructions + 5);
 
 		/* ret */
 		instructions[8] = 0xc3;
@@ -867,7 +867,7 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
 	vcpu->run->exit_reason = KVM_EXIT_XEN;
 	vcpu->run->xen.type = KVM_EXIT_XEN_HCALL;
 	vcpu->run->xen.u.hcall.longmode = longmode;
-	vcpu->run->xen.u.hcall.cpl = static_call(kvm_x86_get_cpl)(vcpu);
+	vcpu->run->xen.u.hcall.cpl = static_call(kvm_x86_get_cpl, vcpu);
 	vcpu->run->xen.u.hcall.input = input;
 	vcpu->run->xen.u.hcall.params[0] = params[0];
 	vcpu->run->xen.u.hcall.params[1] = params[1];
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 7be38bc6a673..06c77ca2b3bb 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -146,7 +146,7 @@ DEFINE_STATIC_CALL(amd_pstate_enable, pstate_enable);
 
 static inline int amd_pstate_enable(bool enable)
 {
-	return static_call(amd_pstate_enable)(enable);
+	return static_call(amd_pstate_enable, enable);
 }
 
 static int pstate_init_perf(struct amd_cpudata *cpudata)
@@ -194,7 +194,7 @@ DEFINE_STATIC_CALL(amd_pstate_init_perf, pstate_init_perf);
 
 static inline int amd_pstate_init_perf(struct amd_cpudata *cpudata)
 {
-	return static_call(amd_pstate_init_perf)(cpudata);
+	return static_call(amd_pstate_init_perf, cpudata);
 }
 
 static void pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
@@ -226,8 +226,8 @@ static inline void amd_pstate_update_perf(struct amd_cpudata *cpudata,
 					  u32 min_perf, u32 des_perf,
 					  u32 max_perf, bool fast_switch)
 {
-	static_call(amd_pstate_update_perf)(cpudata, min_perf, des_perf,
-					    max_perf, fast_switch);
+	static_call(amd_pstate_update_perf, cpudata, min_perf, des_perf,
+		    max_perf, fast_switch);
 }
 
 static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index ab78bd4c2eb0..a7d800a5dbd8 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -421,7 +421,7 @@ void raw_irqentry_exit_cond_resched(void);
 #define irqentry_exit_cond_resched_dynamic_enabled	raw_irqentry_exit_cond_resched
 #define irqentry_exit_cond_resched_dynamic_disabled	NULL
 DECLARE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resched);
-#define irqentry_exit_cond_resched()	static_call(irqentry_exit_cond_resched)()
+#define irqentry_exit_cond_resched()	static_call(irqentry_exit_cond_resched)
 #elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
 DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
 void dynamic_irqentry_exit_cond_resched(void);
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index fe6efb24d151..7814129fe0c9 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -107,7 +107,7 @@ DECLARE_STATIC_CALL(might_resched, __cond_resched);
 
 static __always_inline void might_resched(void)
 {
-	static_call_mod(might_resched)();
+	static_call_mod(might_resched);
 }
 
 #elif defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index af97dd427501..2e12811b3730 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1253,15 +1253,15 @@ DECLARE_STATIC_CALL(__perf_guest_handle_intel_pt_intr, *perf_guest_cbs->handle_i
 
 static inline unsigned int perf_guest_state(void)
 {
-	return static_call(__perf_guest_state)();
+	return static_call(__perf_guest_state);
 }
 static inline unsigned long perf_guest_get_ip(void)
 {
-	return static_call(__perf_guest_get_ip)();
+	return static_call(__perf_guest_get_ip);
 }
 static inline unsigned int perf_guest_handle_intel_pt_intr(void)
 {
-	return static_call(__perf_guest_handle_intel_pt_intr)();
+	return static_call(__perf_guest_handle_intel_pt_intr);
 }
 extern void perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *cbs);
 extern void perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *cbs);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index a8911b1f35aa..e8a98ee1442d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2040,7 +2040,7 @@ DECLARE_STATIC_CALL(cond_resched, __cond_resched);
 
 static __always_inline int _cond_resched(void)
 {
-	return static_call_mod(cond_resched)();
+	return static_call_mod(cond_resched);
 }
 
 #elif defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index df53bed9d71f..7f1219fb98cf 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -21,8 +21,8 @@
  *
  *   __static_call_return0;
  *
- *   static_call(name)(args...);
- *   static_call_cond(name)(args...);
+ *   static_call(name, args...);
+ *   static_call_cond(name, args...);
  *   static_call_update(name, func);
  *   static_call_query(name);
  *
@@ -38,13 +38,13 @@
  *   DEFINE_STATIC_CALL(my_name, func_a);
  *
  *   # Call func_a()
- *   static_call(my_name)(arg1, arg2);
+ *   static_call(my_name, arg1, arg2);
  *
  *   # Update 'my_name' to point to func_b()
  *   static_call_update(my_name, &func_b);
  *
  *   # Call func_b()
- *   static_call(my_name)(arg1, arg2);
+ *   static_call(my_name, arg1, arg2);
  *
  *
  * Implementation details:
@@ -94,7 +94,7 @@
  *
  *   When calling a static_call that can be NULL, use:
  *
- *     static_call_cond(name)(arg1);
+ *     static_call_cond(name, arg1);
  *
  *   which will include the required value tests to avoid NULL-pointer
  *   dereferences.
@@ -204,7 +204,7 @@ extern long __static_call_return0(void);
 	};								\
 	ARCH_DEFINE_STATIC_CALL_RET0_TRAMP(name)
 
-#define static_call_cond(name)	(void)__static_call(name)
+#define static_call_cond(name, args...)	(void)__static_call(name)(args)
 
 #define EXPORT_STATIC_CALL(name)					\
 	EXPORT_SYMBOL(STATIC_CALL_KEY(name));				\
@@ -246,7 +246,7 @@ static inline int static_call_init(void) { return 0; }
 	};								\
 	ARCH_DEFINE_STATIC_CALL_RET0_TRAMP(name)
 
-#define static_call_cond(name)	(void)__static_call(name)
+#define static_call_cond(name, args...)	(void)__static_call(name)(args)
 
 static inline
 void __static_call_update(struct static_call_key *key, void *tramp, void *func)
@@ -323,7 +323,7 @@ static inline void __static_call_nop(void) { }
 	(typeof(STATIC_CALL_TRAMP(name))*)func;				\
 })
 
-#define static_call_cond(name)	(void)__static_call_cond(name)
+#define static_call_cond(name, args...)	(void)__static_call_cond(name)(args)
 
 static inline
 void __static_call_update(struct static_call_key *key, void *tramp, void *func)
diff --git a/include/linux/static_call_types.h b/include/linux/static_call_types.h
index 5a00b8b2cf9f..7e1ce240a2cd 100644
--- a/include/linux/static_call_types.h
+++ b/include/linux/static_call_types.h
@@ -81,13 +81,13 @@ struct static_call_key {
 
 #ifdef MODULE
 #define __STATIC_CALL_MOD_ADDRESSABLE(name)
-#define static_call_mod(name)	__raw_static_call(name)
+#define static_call_mod(name, args...)	__raw_static_call(name)(args)
 #else
 #define __STATIC_CALL_MOD_ADDRESSABLE(name) __STATIC_CALL_ADDRESSABLE(name)
-#define static_call_mod(name)	__static_call(name)
+#define static_call_mod(name, args...)	__static_call(name)(args)
 #endif
 
-#define static_call(name)	__static_call(name)
+#define static_call(name, args...)	__static_call(name)(args)
 
 #else
 
@@ -95,8 +95,8 @@ struct static_call_key {
 	void *func;
 };
 
-#define static_call(name)						\
-	((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_KEY(name).func))
+#define static_call(name, args...)					\
+	((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_KEY(name).func))(args)
 
 #endif /* CONFIG_HAVE_STATIC_CALL */
 
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 28031b15f878..1c68fcad48a2 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -170,7 +170,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 			rcu_dereference_raw((&__tracepoint_##name)->funcs); \
 		if (it_func_ptr) {					\
 			__data = (it_func_ptr)->data;			\
-			static_call(tp_func_##name)(__data, args);	\
+			static_call(tp_func_##name, __data, args);	\
 		}							\
 	} while (0)
 #else
diff --git a/kernel/static_call_inline.c b/kernel/static_call_inline.c
index dc5665b62814..9752489fcaab 100644
--- a/kernel/static_call_inline.c
+++ b/kernel/static_call_inline.c
@@ -533,7 +533,7 @@ static int __init test_static_call_init(void)
               if (scd->func)
                       static_call_update(sc_selftest, scd->func);
 
-              WARN_ON(static_call(sc_selftest)(scd->val) != scd->expect);
+              WARN_ON(static_call(sc_selftest, scd->val) != scd->expect);
       }
 
       return 0;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index d8553f46caa2..fa1a0deddda5 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1096,7 +1096,7 @@ BPF_CALL_3(bpf_get_branch_snapshot, void *, buf, u32, size, u64, flags)
 	static const u32 br_entry_size = sizeof(struct perf_branch_entry);
 	u32 entry_cnt = size / br_entry_size;
 
-	entry_cnt = static_call(perf_snapshot_branch_stack)(buf, entry_cnt);
+	entry_cnt = static_call(perf_snapshot_branch_stack, buf, entry_cnt);
 
 	if (unlikely(flags))
 		return -EINVAL;
diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
index 9b9d3ef79cbe..3f48310a4ce3 100644
--- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -170,15 +170,15 @@ static int trusted_instantiate(struct key *key,
 
 	switch (key_cmd) {
 	case Opt_load:
-		ret = static_call(trusted_key_unseal)(payload, datablob);
+		ret = static_call(trusted_key_unseal, payload, datablob);
 		dump_payload(payload);
 		if (ret < 0)
 			pr_info("key_unseal failed (%d)\n", ret);
 		break;
 	case Opt_new:
 		key_len = payload->key_len;
-		ret = static_call(trusted_key_get_random)(payload->key,
-							  key_len);
+		ret = static_call(trusted_key_get_random, payload->key,
+				  key_len);
 		if (ret < 0)
 			goto out;
 
@@ -188,7 +188,7 @@ static int trusted_instantiate(struct key *key,
 			goto out;
 		}
 
-		ret = static_call(trusted_key_seal)(payload, datablob);
+		ret = static_call(trusted_key_seal, payload, datablob);
 		if (ret < 0)
 			pr_info("key_seal failed (%d)\n", ret);
 		break;
@@ -257,7 +257,7 @@ static int trusted_update(struct key *key, struct key_preparsed_payload *prep)
 	dump_payload(p);
 	dump_payload(new_p);
 
-	ret = static_call(trusted_key_seal)(new_p, datablob);
+	ret = static_call(trusted_key_seal, new_p, datablob);
 	if (ret < 0) {
 		pr_info("key_seal failed (%d)\n", ret);
 		kfree_sensitive(new_p);
@@ -334,7 +334,7 @@ static int __init init_trusted(void)
 				   trusted_key_sources[i].ops->exit);
 		migratable = trusted_key_sources[i].ops->migratable;
 
-		ret = static_call(trusted_key_init)();
+		ret = static_call(trusted_key_init);
 		if (!ret)
 			break;
 	}
@@ -351,7 +351,7 @@ static int __init init_trusted(void)
 
 static void __exit cleanup_trusted(void)
 {
-	static_call_cond(trusted_key_exit)();
+	static_call_cond(trusted_key_exit);
 }
 
 late_initcall(init_trusted);
-- 
2.36.0.464.gb9c8b46e94-goog

