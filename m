Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD27358EC28
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 14:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbiHJMkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 08:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiHJMkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 08:40:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D8083F1D
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 05:40:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DB2A61333
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 12:40:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83A8C433D7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 12:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660135199;
        bh=70QjW3g9TOpcRpEmrzSvzLB0DQP7KkQN+2ZNk22bd5I=;
        h=From:To:Subject:Date:From;
        b=dgAbIwnB/g5F8ePVEWQYbM+x4TXj5CsnnW/PG6MlwgWpr79yua8iu+hjcVyk3LMm9
         bRzva4X9NWqs381vYYUOo9YkC1Q20H9aAFAvOulZINdq2rUCMcLdZSXc7sAf2rBP5/
         WqZuL4WlVnMnQWb1lY6u9O0Ix2weO9yRW8uwavFAleU0Mis3ErQnzzcgDou1QmvKpe
         SgNR1nI4RrWcXJh3LFOltzvsoHqaV8QkxgW2o3tIvji/RnTNIq7pBqNFpnLPO8x0CY
         jomRsSHln5RsfnhVV3nJt+QB8QgA79pu6TArIzUnEr2jYs1/siQ/rxuM2eae2PDBAV
         HoifHOOyv2zRQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] habanalabs: fix missing info in sysfs documentation
Date:   Wed, 10 Aug 2022 15:39:55 +0300
Message-Id: <20220810123955.1689663-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel version field wasn't updated when a few entries were
upstreamed.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 Documentation/ABI/testing/sysfs-driver-habanalabs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-habanalabs b/Documentation/ABI/testing/sysfs-driver-habanalabs
index 6963640a2615..13b5b2ec3be7 100644
--- a/Documentation/ABI/testing/sysfs-driver-habanalabs
+++ b/Documentation/ABI/testing/sysfs-driver-habanalabs
@@ -16,7 +16,7 @@ Description:    Version of the application running on the device's CPU
 
 What:           /sys/class/habanalabs/hl<n>/clk_max_freq_mhz
 Date:           Jun 2019
-KernelVersion:  not yet upstreamed
+KernelVersion:  5.7
 Contact:        ogabbay@kernel.org
 Description:    Allows the user to set the maximum clock frequency, in MHz.
                 The device clock might be set to lower value than the maximum.
@@ -26,7 +26,7 @@ Description:    Allows the user to set the maximum clock frequency, in MHz.
 
 What:           /sys/class/habanalabs/hl<n>/clk_cur_freq_mhz
 Date:           Jun 2019
-KernelVersion:  not yet upstreamed
+KernelVersion:  5.7
 Contact:        ogabbay@kernel.org
 Description:    Displays the current frequency, in MHz, of the device clock.
                 This property is valid only for the Gaudi ASIC family
@@ -236,6 +236,6 @@ Description:    Version of the u-boot running on the device's CPU
 
 What:           /sys/class/habanalabs/hl<n>/vrm_ver
 Date:           Jan 2022
-KernelVersion:  not yet upstreamed
+KernelVersion:  5.17
 Contact:        ogabbay@kernel.org
 Description:    Version of the Device's Voltage Regulator Monitor F/W code. N/A to GOYA and GAUDI
-- 
2.25.1

