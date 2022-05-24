Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4135323D6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbiEXHPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbiEXHPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:15:49 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F945AA66
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:15:47 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:4593:272c:6293:e2cc])
        by michel.telenet-ops.be with bizsmtp
        id aXFm270042jQL2A06XFmST; Tue, 24 May 2022 09:15:46 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ntOld-001Rfc-KX; Tue, 24 May 2022 09:15:45 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ntOld-004AiI-9X; Tue, 24 May 2022 09:15:45 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Michael Shych <michaelsh@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] platform/mellanox: Spelling s/platfom/platform/
Date:   Tue, 24 May 2022 09:15:44 +0200
Message-Id: <9c8edde31e271311b7832d7677fe84aba917da8d.1653376503.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a misspelling of the word "platform".

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/platform/mellanox/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/mellanox/Kconfig b/drivers/platform/mellanox/Kconfig
index 72df4b8f4dd8b5a0..09c7829e95c4b037 100644
--- a/drivers/platform/mellanox/Kconfig
+++ b/drivers/platform/mellanox/Kconfig
@@ -85,7 +85,7 @@ config NVSW_SN2201
 	depends on I2C
 	depends on REGMAP_I2C
 	help
-	  This driver provides support for the Nvidia SN2201 platfom.
+	  This driver provides support for the Nvidia SN2201 platform.
 	  The SN2201 is a highly integrated for one rack unit system with
 	  L3 management switches. It has 48 x 1Gbps RJ45 + 4 x 100G QSFP28
 	  ports in a compact 1RU form factor. The system also including a
-- 
2.25.1

