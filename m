Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B264DE5EA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 05:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242040AbiCSEYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 00:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239863AbiCSEYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 00:24:33 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951A07EA24
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 21:23:12 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id B33D33200D53;
        Sat, 19 Mar 2022 00:23:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 19 Mar 2022 00:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:date:date:from:from:in-reply-to
        :message-id:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=QrAvON
        OTZWCmMh13WeZL23sVu55xrRfpqIerLSK6XQk=; b=ihv6lRRbOf2WtAhJ2xqH6u
        ZGRcuWNskZAbYkkp+0kwEBrVVFbdtF6ePJsjstBrnQiiJzN0Kq/LwoXa2xw/7Q1Y
        qkEwlVzjY3SoYCWn/6FwhxXc4N4YtiJu2APFcML+6v/MdPmjpO86lulvqE8szxXs
        fcxejzpGRbJ7MRyrt1tNJMkmv+JFVO9EWeTXh743tdutSKy/2d/26ZiL3hmb9B4K
        LoRw3y7YUuo9tyOfnr+Xru1dGYu7RYA3jZzIw1prrZT6XWGBM8i9A3wg9owoahcM
        Fi1gJVc6A5uijKmGS4RZQD8Jz4vHSdKMMwjEKocMowpRJRgOBa1jHl6wIP4m1emQ
        ==
X-ME-Sender: <xms:q1o1Yvf63xOFrmbpUpCq26Udjr041U1w5pPyfgAGx5K0ajv46Xfixw>
    <xme:q1o1YlPhgYdQ6kRJK74vOpLjfnJtD2fZWEPnnIPC-YSUURPgI0v3aPCkRTyxy48cn
    hVAUjg-grQbPXFKSus>
X-ME-Received: <xmr:q1o1YojaoQyDgKlVesDxkUdoyX-jKL0LNcunEZg7tR9GSiBDZ0IdL_BEycRMVcXG7DitqucsPnQO5Rvti0wOxXuRoK_2hArE-4I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudefjedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepvffkhffuffestddtredttddttdenucfhrhhomhephfhinhhnucfvhhgrihhn
    uceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvghrnh
    eptdelteekleekkedvueejheekgfdvtdehhefhteeitefhteefgefhudehveevleelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhthhgrih
    hnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:q1o1Yg-og3VE-hbwSq71tdyzUCSlLj7tEmMXUNeC4ln7d5Lomq0vPw>
    <xmx:q1o1YrvMI37UWAxwIEOJD2oWeT_2Fr2tBvIUqcAFGLMGFjdT_RmE7A>
    <xmx:q1o1YvHJeEb5FUo0PmFiQznjUVxUHJ5TlH8S2Dd6RzK8pO_uHVprJw>
    <xmx:rFo1Yk6Wl_cLD8pvMXnzuxvL0v0qbfFhiJqNqMcRR6_Q1jNSDW9a2A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Mar 2022 00:23:06 -0400 (EDT)
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     "Michael Ellerman" <mpe@ellerman.id.au>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Message-Id: <cb1828050f8c9ef801b2bdf79eccd6c52afed26b.1647663509.git.fthain@linux-m68k.org>
From:   Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH] macintosh/via-pmu: Fix build failure when CONFIG_INPUT is
 disabled
Date:   Sat, 19 Mar 2022 15:18:29 +1100
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/macintosh/via-pmu-event.o: In function `via_pmu_event':
via-pmu-event.c:(.text+0x44): undefined reference to `input_event'
via-pmu-event.c:(.text+0x68): undefined reference to `input_event'
via-pmu-event.c:(.text+0x94): undefined reference to `input_event'
via-pmu-event.c:(.text+0xb8): undefined reference to `input_event'
drivers/macintosh/via-pmu-event.o: In function `via_pmu_event_init':
via-pmu-event.c:(.init.text+0x20): undefined reference to `input_allocate_device'
via-pmu-event.c:(.init.text+0xc4): undefined reference to `input_register_device'
via-pmu-event.c:(.init.text+0xd4): undefined reference to `input_free_device'
make[1]: *** [Makefile:1155: vmlinux] Error 1
make: *** [Makefile:350: __build_one_by_one] Error 2

Don't call into the input subsystem unless CONFIG_INPUT is built-in.

Reported-by: kernel test robot <lkp@intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/macintosh/Makefile  | 5 ++++-
 drivers/macintosh/via-pmu.c | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/macintosh/Makefile b/drivers/macintosh/Makefile
index 49819b1b6f20..eaf28b1c272f 100644
--- a/drivers/macintosh/Makefile
+++ b/drivers/macintosh/Makefile
@@ -12,7 +12,10 @@ obj-$(CONFIG_MAC_EMUMOUSEBTN)	+= mac_hid.o
 obj-$(CONFIG_INPUT_ADBHID)	+= adbhid.o
 obj-$(CONFIG_ANSLCD)		+= ans-lcd.o
 
-obj-$(CONFIG_ADB_PMU)		+= via-pmu.o via-pmu-event.o
+obj-$(CONFIG_ADB_PMU)		+= via-pmu.o
+ifeq ($(CONFIG_INPUT), y)
+obj-$(CONFIG_ADB_PMU)		+= via-pmu-event.o
+endif
 obj-$(CONFIG_ADB_PMU_LED)	+= via-pmu-led.o
 obj-$(CONFIG_PMAC_BACKLIGHT)	+= via-pmu-backlight.o
 obj-$(CONFIG_ADB_CUDA)		+= via-cuda.o
diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 4b98bc26a94b..55afa6dfa263 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -1457,12 +1457,14 @@ pmu_handle_data(unsigned char *data, int len)
 		if (pmu_battery_count)
 			query_battery_state();
 		pmu_pass_intr(data, len);
+#ifdef CONFIG_INPUT
 		/* len == 6 is probably a bad check. But how do I
 		 * know what PMU versions send what events here? */
 		if (len == 6) {
 			via_pmu_event(PMU_EVT_POWER, !!(data[1]&8));
 			via_pmu_event(PMU_EVT_LID, data[1]&1);
 		}
+#endif
 		break;
 
 	default:
-- 
2.32.0

