Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16E14D6F38
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 14:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbiCLNeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 08:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiCLNeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 08:34:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F54BE4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 05:32:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1021BB8013A
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 13:32:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E53C340EB;
        Sat, 12 Mar 2022 13:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647091972;
        bh=z6eDtSo9u9x6ePaflNE4F8fwVoYsvAC3AWPaIS6jwm8=;
        h=Date:From:To:Cc:Subject:From;
        b=TLVDmCE6ObD1HazvAL/1gYYpMv3se7eZBH3SZ9SngPcFkXsbphlIDhqkym8iTcnin
         O4ZgyavmtQeKNsTNMbdbJpMW+4dlxHJ14BuMuVvwKRx6+G61OZsF7/0mCm7Pl74sgj
         lQ3bYttiNPMSEA24vsoKPqccycfG7gHxrVg6JPWRrICXj062hoXEscls9cb5HSTrEF
         kIOWq3ylE4rL8uyusFsBO6ESpGI3/cMRxMOsoPFbaGvVXpJOcDhGM89E+iNGiLwMv6
         WOf3e+aWfHp9SZ0zS51/2Q6GXgBe7SM/1Pa6Ilnd1BAf2+TvSV+zZ7vEJ7bp8g5j9T
         gCBMhNodGUebQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E3F80403C8; Sat, 12 Mar 2022 10:32:48 -0300 (-03)
Date:   Sat, 12 Mar 2022 10:32:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Morse <james.morse@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] tools kvm headers arm64: Update KVM headers from the
 kernel sources
Message-ID: <YiyhAK6sVPc83FaI@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


FYI, I'm carrying this on my perf tools tree,

Regards,

- Arnaldo

----

To pick the changes from:

  a5905d6af492ee6a ("KVM: arm64: Allow SMCCC_ARCH_WORKAROUND_3 to be discovered and migrated")

That don't causes any changes in tooling (when built on x86), only
addresses this perf build warning:

  Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/kvm.h' differs from latest version at 'arch/arm64/include/uapi/asm/kvm.h'
  diff -u tools/arch/arm64/include/uapi/asm/kvm.h arch/arm64/include/uapi/asm/kvm.h

Cc: James Morse <james.morse@arm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/arm64/include/uapi/asm/kvm.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/arch/arm64/include/uapi/asm/kvm.h b/tools/arch/arm64/include/uapi/asm/kvm.h
index b3edde68bc3e013c..323e251ed37bc0f6 100644
--- a/tools/arch/arm64/include/uapi/asm/kvm.h
+++ b/tools/arch/arm64/include/uapi/asm/kvm.h
@@ -281,6 +281,11 @@ struct kvm_arm_copy_mte_tags {
 #define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_REQUIRED	3
 #define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_ENABLED     	(1U << 4)
 
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_3	KVM_REG_ARM_FW_REG(3)
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_3_NOT_AVAIL		0
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_3_AVAIL		1
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_3_NOT_REQUIRED	2
+
 /* SVE registers */
 #define KVM_REG_ARM64_SVE		(0x15 << KVM_REG_ARM_COPROC_SHIFT)
 
-- 
2.35.1

