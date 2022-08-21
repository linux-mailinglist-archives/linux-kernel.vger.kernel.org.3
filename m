Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2746059B2C5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 10:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiHUI2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 04:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiHUI2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 04:28:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A0F1181A
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 01:28:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1170760D30
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 08:28:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9AF9C433D7
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 08:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661070509;
        bh=MGnmvJUW0ll/R4GUqQFaXoqwxTbM37z68rC/6+H4N7k=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=J6cXC2+85P07rJ4RHhC7x3xfM1vN+D81+2luQwn/iVpAgm778Kp3ciZYfs5gjZi9m
         8P9xVUB2OzvltSsXvJRBLZF3TFCmj0MHc7kUGzmffIAkQGWp13Y3U51yj5SgagCo8c
         09cIV4pQosi0wCI+RDC6CUJV+TgSLP9wKe+p22z52WzxVIiZdN54S7hLB2VbINX8gR
         ZMxHe7gWIndt000kbR67YvT8dRix1NsNsN30HzBabWBoEZEgSXAj607KxFFdAk1XMU
         tQsZHuTE069n84SUm7vaEFAqgSKWfi0El8tvx6+oXjkQBbf/foPea93Sq8P9eOn6IS
         3eYFPZCdzXdFA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] habanalabs: select FW_LOADER in Kconfig
Date:   Sun, 21 Aug 2022 11:28:20 +0300
Message-Id: <20220821082823.62846-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220821082823.62846-1-ogabbay@kernel.org>
References: <20220821082823.62846-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver is loading firmware to the device and we use the firmware
loading functions from the FW_LOADER module.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/habanalabs/Kconfig b/drivers/misc/habanalabs/Kconfig
index 861c81006c6d..bd01d0d940c0 100644
--- a/drivers/misc/habanalabs/Kconfig
+++ b/drivers/misc/habanalabs/Kconfig
@@ -10,6 +10,7 @@ config HABANA_AI
 	select HWMON
 	select DMA_SHARED_BUFFER
 	select CRC32
+	select FW_LOADER
 	help
 	  Enables PCIe card driver for Habana's AI Processors (AIP) that are
 	  designed to accelerate Deep Learning inference and training workloads.
-- 
2.25.1

