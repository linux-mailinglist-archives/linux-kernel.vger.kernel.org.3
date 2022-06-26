Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EE155B0D9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 11:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbiFZJcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 05:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbiFZJc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 05:32:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E360D11C3F;
        Sun, 26 Jun 2022 02:32:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F301B80D32;
        Sun, 26 Jun 2022 09:32:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D24C341CA;
        Sun, 26 Jun 2022 09:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656235946;
        bh=RCb3BybKgkMjj7wm7bAA/tavxLZ3Xapy1cZ9JMlfXaA=;
        h=From:To:Cc:Subject:Date:From;
        b=dwdTQyGxt2cS/1PQoES6mBFPj/BaFnsMk/gGFj8lg5lBls1fjxTSD3rUow+6bMi++
         LBLYimPeAh/y/tw27ceRgHmhNQDrDoJwKvOwmfIEYdLvETM+c3zKRo8BP2ZFFUwNTv
         a6uwxrWVIgejyO5GCGus3kvd1t/906kb22NV0s1/w0u6pkJxqaw6oXP3qW9OiB8wbv
         PzPL9fwEguqqohuoczP8k1wzsYTkepGsbCPbZRxpfabOce3te2ZLCJYi7B5N2ApHc1
         TseYMzYeM+sZ00jF1YgsXIKaskihk74fBRtnPtxHdYjvnC0aFsqhwvj2sfZMCd5SIo
         8JOnIq/6Mqajg==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o5Ocw-001d5W-Rw;
        Sun, 26 Jun 2022 10:32:22 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kohei Tarumizu <tarumizu.kohei@fujitsu.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Peter Collingbourne <pcc@google.com>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ABI: testing/sysfs-devices-system-cpu: remove duplicated core_id
Date:   Sun, 26 Jun 2022 10:32:21 +0100
Message-Id: <1e92337c1ef74f5eb9e1c1871e20b858b490d269.1656235926.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was already defined at stable/sysfs-devices-system-cpu with
the same description, as pointed by get_abi.pl:

	Warning: /sys/devices/system/cpu/cpuX/topology/core_id is defined 2 times:  Documentation/ABI/stable/sysfs-devices-system-cpu:38  Documentation/ABI/testing/sysfs-devices-system-cpu:69

Remove the duplicated one.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index bcc974d276dc..3135d0c5fc72 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -67,8 +67,7 @@ Description:	Discover NUMA node a CPU belongs to
 		/sys/devices/system/cpu/cpu42/node2 -> ../../node/node2
 
 
-What:		/sys/devices/system/cpu/cpuX/topology/core_id
-		/sys/devices/system/cpu/cpuX/topology/core_siblings
+What:		/sys/devices/system/cpu/cpuX/topology/core_siblings
 		/sys/devices/system/cpu/cpuX/topology/core_siblings_list
 		/sys/devices/system/cpu/cpuX/topology/physical_package_id
 		/sys/devices/system/cpu/cpuX/topology/thread_siblings
@@ -84,10 +83,6 @@ Description:	CPU topology files that describe a logical CPU's relationship
 
 		Briefly, the files above are:
 
-		core_id: the CPU core ID of cpuX. Typically it is the
-		hardware platform's identifier (rather than the kernel's).
-		The actual value is architecture and platform dependent.
-
 		core_siblings: internal kernel map of cpuX's hardware threads
 		within the same physical_package_id.
 
-- 
2.36.1

