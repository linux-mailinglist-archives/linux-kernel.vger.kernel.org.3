Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E257564222
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 20:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbiGBSkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 14:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiGBSkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 14:40:49 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DDEDF1A
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 11:40:48 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 481E35C0197;
        Sat,  2 Jul 2022 14:40:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 02 Jul 2022 14:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1656787245; x=1656873645; bh=pfmmVMf+mB8FJ236qCWDsBxR6
        Vdsvx3/s3O7TyTZeSk=; b=OCHejxF056CJYLXpUFdd1YU60NopgVCQy6pHo6Prq
        RwrCocJIXWpxTOjycqrj8Za6qKUE01RyBvSju1010YG/vWe9QVmf8GUgpPEDHd8Z
        LRnBiYmdhD4zJzE60a2V4haE21WNSLhk7FfPtMztABq+c6ysosf2s2PDNypMmtZt
        QEKCv5v8mJxuTyy+ZplGpwlX4ou0FinxOpQL8aIqZnSTdQQh9msLb0M1b4dk4QUD
        B6QqEZASWL/N3t1hofoH6tUlV5tdTGDSxay9yQAp1+t+nObslbIdR6umjUx/fCsi
        xGK2bfpBr39JIseY9oWhRbfgrRb35/Z7T6D9paGnfUjvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1656787245; x=1656873645; bh=pfmmVMf+mB8FJ236qCWDsBxR6Vdsvx3/s3O
        7TyTZeSk=; b=PCUbmRrGYOHBMLSMWi0pQpDOsHlq9cyjr+FXEY1nqA6JXB0dun+
        YIJxo6iCmh4zDYSnHddwvF6ODZ0LMWSdPL8r3nNqxLwlywcW5fmOLbzm0sD/agXI
        L9KZzTDtlyeS5JW9s9MJJke1V0ifD60j4BMjGGqcSmEZpaZL2tsKPklyWV8QM2gF
        J1lsHb51ogzv5NshqMuROLXXRTmgpF+a+DMLl7CRDgGEioLF6hqmW3q3uX3KrkCd
        YCiN8cuCiauniKTYIBIH6KHttjmqDxte7Lo8EoMqAZU2h3zRRiqPJtvei9wZCaFU
        c/ixK9Tc3Fme77NbO1IkK0OQ9KHqVz4CQfA==
X-ME-Sender: <xms:LZHAYnO7pIdI3tbRkDtNJKW1AfMLb5tYrfECVQ0WQYytEsaeMvYKBA>
    <xme:LZHAYh8-h5GVaKG2j5NNsjg3FwXrhPiy-WhFx7frpqzwqBd8pDHnbHb3ErBinjsWR
    otZIshddHoK5-A7dQ>
X-ME-Received: <xmr:LZHAYmSlWZY9mxCPDXAMoAzSquobBA6D8w7h_UOnNx7PwTNXxLUARkgXplYpfiEUUW08EdkzetNKD46nRaFYaldEaQAjA3UCBItkH6V_5nz6k9UT2wDJo212JzrC_ZfejoKYdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehhedguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeekveelhfejueelleetvdejvdeffeetgeelheeujeffhefgffefkeeh
    hffhkeekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:LZHAYruv1gMZ7tUfdpuW2dU8q8I7DtN3b084UMhhHl0u3zVogzuLzA>
    <xmx:LZHAYveY8uop6AspiS5I9g2hy1iU8rtTmR0mcFYhsQARwacddH2T3g>
    <xmx:LZHAYn2nU7Wa4aH2OvdBZRySdrcXxj0VHqBQbZRVlhbezzMSd1He1w>
    <xmx:LZHAYm5XbIMYUlcUgy-uWBRWiB8IArVlaKcOM3aNJLPS77VG5elE3A>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 2 Jul 2022 14:40:44 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-sunxi@lists.linux.dev,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: sun6i-prcm: Update Kconfig description
Date:   Sat,  2 Jul 2022 13:40:43 -0500
Message-Id: <20220702184044.51144-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is used by a specific range of SoCs between when the PRCM
hardware was introduced (A31) and when the PRCM CCU driver was added
(A83T). It is unlikely to be extended to additional hardware. Update
the description to include the full list of applicable SoCs.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/mfd/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 3b59456f5545..9e44a60e2308 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1357,12 +1357,13 @@ config MFD_STA2X11
 	select REGMAP_MMIO
 
 config MFD_SUN6I_PRCM
-	bool "Allwinner A31 PRCM controller"
+	bool "Allwinner A31/A23/A33 PRCM controller"
 	depends on ARCH_SUNXI || COMPILE_TEST
 	select MFD_CORE
 	help
 	  Support for the PRCM (Power/Reset/Clock Management) unit available
-	  in A31 SoC.
+	  in the A31, A23, and A33 SoCs. Other Allwinner SoCs contain similar
+	  hardware, but they do not use this driver.
 
 config MFD_SYSCON
 	bool "System Controller Register R/W Based on Regmap"
-- 
2.35.1

