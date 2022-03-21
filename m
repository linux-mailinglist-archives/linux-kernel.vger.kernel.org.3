Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD83B4E1F2F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 03:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344253AbiCUC6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 22:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239666AbiCUC6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 22:58:00 -0400
X-Greylist: delayed 97 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 20 Mar 2022 19:56:34 PDT
Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 0E295E9CB9
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 19:56:33 -0700 (PDT)
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
        by hzbj-icmmx-1 (Coremail) with SMTP id AQAAfwDHAngU6Tdie617Ag--.32513S2;
        Mon, 21 Mar 2022 10:55:16 +0800 (CST)
Received: from centos7.localdomain (unknown [202.43.158.76])
        by mail (Coremail) with SMTP id AQAAfwC3mqNc6TdiliUAAA--.1449S3;
        Mon, 21 Mar 2022 10:56:28 +0800 (CST)
From:   Zhiyuan Dai <daizhiyuan@phytium.com.cn>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     maz@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Zhiyuan Dai <daizhiyuan@phytium.com.cn>
Subject: [PATCH 1/2] arm64: Fix comments in macro __init_el2_gicv3
Date:   Mon, 21 Mar 2022 10:56:27 +0800
Message-Id: <1647831387-3686-1-git-send-email-daizhiyuan@phytium.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AQAAfwC3mqNc6TdiliUAAA--.1449S3
X-CM-SenderInfo: hgdl6xpl1xt0o6sk53xlxphulrpou0/
Authentication-Results: hzbj-icmmx-1; spf=neutral smtp.mail=daizhiyuan
        @phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoW7JFy3ArW3JFW5tryxtFW3Awb_yoWxKrXEkw
        1fJw4rWFyrtr9xAw13t3W3G3yj9w1rJr97uF1FkwnrJw1DWrs8Gws7Zr1Ivr1rCw1UGF4f
        uan5JFW3CwnYgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
        Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
        UUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo in comment.

Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
---
 arch/arm64/include/asm/el2_setup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index 7f3c87f..c31be7e 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -107,7 +107,7 @@
 	isb					// Make sure SRE is now set
 	mrs_s	x0, SYS_ICC_SRE_EL2		// Read SRE back,
 	tbz	x0, #0, .Lskip_gicv3_\@		// and check that it sticks
-	msr_s	SYS_ICH_HCR_EL2, xzr		// Reset ICC_HCR_EL2 to defaults
+	msr_s	SYS_ICH_HCR_EL2, xzr		// Reset ICH_HCR_EL2 to defaults
 .Lskip_gicv3_\@:
 .endm
 
-- 
1.8.3.1

