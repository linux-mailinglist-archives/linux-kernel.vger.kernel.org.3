Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F2E53C630
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 09:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242379AbiFCHae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 03:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiFCHa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 03:30:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696C439159
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 00:30:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7C79618CC
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 07:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986D7C385A9;
        Fri,  3 Jun 2022 07:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654241426;
        bh=ZNUUMJuYNPWXlHY4wdf5VcrZ/Zg6v3m1CdXv0Qgm/bI=;
        h=From:To:Cc:Subject:Date:From;
        b=FIQAy2/gEPD6DgEAoqySM1/qPjUI23jEunum+eZQwhqOkYind3I71kFwN+djl3PIn
         TAShqiJgaR9kZJ+iLhfMQaBLinSI42UdKUi0d96xl2neKYamoTPwHyF9LLEx/TcCBK
         K2GW7PEGJF+52mW8/EDK48NJxfS1EmElqoyksX1FCDpej7ARh23i8p/a5y/f/4nLTX
         NBXmmWzrpni00Em+sXn012ZbkSSeBUIqCevqC+Q91d+5982aK3XA4iGw/dfHG1GoXi
         tiSFrWCqNaJJm/r9xrTefAXKPzK6N2DcNrKcQty7+wN6bqjUav3VjGwEsUVo6BfuE+
         vZkY2DvkWP6EA==
From:   Nicolas Saenz Julienne <nsaenz@kernel.org>
To:     nsaenz@kernel.org, f.fainelli@gmail.com
Cc:     stefan.wahren@i2se.com, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Update BCM2711/BCM2835 maintainer
Date:   Fri,  3 Jun 2022 09:30:12 +0200
Message-Id: <20220603073012.30979-1-nsaenz@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't been able to find time to maintain BCM2711/BCM2835 these last
months, so it's only fair to pass the baton to Florian who's been doing
the work.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2316278d9db9..efe7377e7e07 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3775,12 +3775,12 @@ N:	bcmbca
 N:	bcm[9]?47622
 
 BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE
-M:	Nicolas Saenz Julienne <nsaenz@kernel.org>
+M:	Florian Fainelli <f.fainelli@gmail.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-rpi-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git
+T:	git git://github.com/broadcom/stblinux.git
 F:	Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
 F:	drivers/pci/controller/pcie-brcmstb.c
 F:	drivers/staging/vc04_services
-- 
2.36.1

