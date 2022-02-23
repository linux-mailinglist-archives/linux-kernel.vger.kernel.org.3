Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5A84C19C6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 18:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243357AbiBWRTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 12:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbiBWRTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 12:19:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4719A13CE9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 09:18:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E589FB8210A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 17:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C95C340EF;
        Wed, 23 Feb 2022 17:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645636714;
        bh=VNlUgTKldysw6CRwrg/qD0OYzDtM7+mlmKCRaLcy/pc=;
        h=Date:From:To:Cc:Subject:From;
        b=kiEIgKuHNgUXdEGZvt3U2FhpxSn8NoRARVnuCSWaVP7J+SsW1z66hOsg9bBOyOwZN
         wuVZcY9eko7Ix8DIoCcJZ7QIQc2n5fqWfHUIy/kBZKtoDCGV12PZLcSXnfGxVO78Vm
         iX75E4ha6FAA/rlQ8u2Lx8Nk0cCmrL0cTZVzn+H4uayG/9rtStkxvNJ5VCQLahKUS7
         XZYcala2pNCHofFkwMQg4yoRwa7blVJR6dq2GJdgmrXdsA4kpSBLe2G+8LgsjNY5LD
         iD6EnSYyFQhMQOAvif2Z8fyGdrACgk70xd7Kz4WPN1nIXKMRBLHpdNSdWlsqdzZBrb
         tTwHJ1e5uQ7pw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 59561400FE; Wed, 23 Feb 2022 14:18:31 -0300 (-03)
Date:   Wed, 23 Feb 2022 14:18:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] rtla: Fix systme -> system typo on man page
Message-ID: <YhZsZxqk+IaFxorj@kernel.org>
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

Fixes: 496082df01bb08a4 ("rtla: Add rtla osnoise man page")
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 Documentation/tools/rtla/common_osnoise_description.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/tools/rtla/common_osnoise_description.rst b/Documentation/tools/rtla/common_osnoise_description.rst
index 8973c5df888f6360..d5d61615b9670918 100644
--- a/Documentation/tools/rtla/common_osnoise_description.rst
+++ b/Documentation/tools/rtla/common_osnoise_description.rst
@@ -1,7 +1,7 @@
 The **rtla osnoise** tool is an interface for the *osnoise* tracer. The
 *osnoise* tracer dispatches a kernel thread per-cpu. These threads read the
 time in a loop while with preemption, softirq and IRQs enabled, thus
-allowing all the sources of operating systme noise during its execution.
+allowing all the sources of operating system noise during its execution.
 The *osnoise*'s tracer threads take note of the delta between each time
 read, along with an interference counter of all sources of interference.
 At the end of each period, the *osnoise* tracer displays a summary of
-- 
2.34.1

