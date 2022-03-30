Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C554EC96A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 18:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348670AbiC3QQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 12:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiC3QQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:16:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7529B267
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:14:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10AED617A0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 16:14:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E702C340EC;
        Wed, 30 Mar 2022 16:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648656869;
        bh=nrkwyuHffvEkewp/YKY7ara7bj5VARxGOfqBcvRldCQ=;
        h=Date:From:To:Cc:Subject:From;
        b=VziI9c1B6ftsLCiV5ik/xvnv217QgXaJAs3eM1zy6whIeG9BhbPou8g6CliVrjw1E
         kc9Bd5E5DhmGY1w+YrhdmsEXJNnydBj3SkikOwliPBpJ4YVis5+Zz4g5knG+XPl1d9
         6tEUTLoedazC7Z40fSVola7So7Uh950+Z/GaaMMatipIbtjzwMhOs6yS45rlZqDHX/
         4g/nktJ7HWvOt2s1dY1adikqvKaTSNnd41uzxPOBZ+itdiqZBlMNOciFC7kL55PZFv
         u4q8l0zmILFp8Lx6ewXT2w96kffxIHfOEcWAYrxFaaE0VQd06b6ru8RgfwPrUga+gZ
         NOyjyTGCAwsaA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C086140407; Wed, 30 Mar 2022 13:14:25 -0300 (-03)
Date:   Wed, 30 Mar 2022 13:14:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH FYI] tools kvm headers arm64: Update KVM headers from the
 kernel sources
Message-ID: <YkSB4Q7kWmnaqeZU@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

---

To pick the changes from:

  34739fd95fab3a5e ("KVM: arm64: Indicate SYSTEM_RESET2 in kvm_run::system_event flags field")
  583cda1b0e7d5d49 ("KVM: arm64: Refuse to run VCPU if the PMU doesn't match the physical CPU")

That don't causes any changes in tooling (when built on x86), only
addresses this perf build warning:

  Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/kvm.h' differs from latest version at 'arch/arm64/include/uapi/asm/kvm.h'
  diff -u tools/arch/arm64/include/uapi/asm/kvm.h arch/arm64/include/uapi/asm/kvm.h

Cc: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/arm64/include/uapi/asm/kvm.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/arch/arm64/include/uapi/asm/kvm.h b/tools/arch/arm64/include/uapi/asm/kvm.h
index 490d489d0ee84518..c1b6ddc02d2ff96e 100644
--- a/tools/arch/arm64/include/uapi/asm/kvm.h
+++ b/tools/arch/arm64/include/uapi/asm/kvm.h
@@ -419,6 +419,16 @@ struct kvm_arm_copy_mte_tags {
 #define KVM_PSCI_RET_INVAL		PSCI_RET_INVALID_PARAMS
 #define KVM_PSCI_RET_DENIED		PSCI_RET_DENIED
 
+/* arm64-specific kvm_run::system_event flags */
+/*
+ * Reset caused by a PSCI v1.1 SYSTEM_RESET2 call.
+ * Valid only when the system event has a type of KVM_SYSTEM_EVENT_RESET.
+ */
+#define KVM_SYSTEM_EVENT_RESET_FLAG_PSCI_RESET2	(1ULL << 0)
+
+/* run->fail_entry.hardware_entry_failure_reason codes. */
+#define KVM_EXIT_FAIL_ENTRY_CPU_UNSUPPORTED	(1ULL << 0)
+
 #endif
 
 #endif /* __ARM_KVM_H__ */
-- 
2.35.1

