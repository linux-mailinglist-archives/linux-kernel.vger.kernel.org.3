Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B80554AB3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356119AbiFVNMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355987AbiFVNMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:12:30 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DA538D8A;
        Wed, 22 Jun 2022 06:12:20 -0700 (PDT)
Received: (Authenticated sender: ash@heyquark.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4A521FF806;
        Wed, 22 Jun 2022 13:12:12 +0000 (UTC)
From:   Ash Logan <ash@heyquark.com>
To:     paulus@samba.org, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        robh+dt@kernel.org, benh@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        j.ne@posteo.net, linkmauve@linkmauve.fr,
        rw-r-r-0644@protonmail.com, devicetree@vger.kernel.org
Subject: [PATCH v2 12/12] powerpc: wiiu: Add minimal default config
Date:   Wed, 22 Jun 2022 23:10:37 +1000
Message-Id: <20220622131037.57604-13-ash@heyquark.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622131037.57604-1-ash@heyquark.com>
References: <20220302044406.63401-1-ash@heyquark.com>
 <20220622131037.57604-1-ash@heyquark.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a bare-minimum config to get a kernel compiled. Will need some more
interesting options once a storage device to boot from is added.

Signed-off-by: Ash Logan <ash@heyquark.com>
---
 arch/powerpc/configs/wiiu_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 arch/powerpc/configs/wiiu_defconfig

diff --git a/arch/powerpc/configs/wiiu_defconfig b/arch/powerpc/configs/wiiu_defconfig
new file mode 100644
index 000000000000..a761ebcdd9f2
--- /dev/null
+++ b/arch/powerpc/configs/wiiu_defconfig
@@ -0,0 +1,7 @@
+# CONFIG_PPC_CHRP is not set
+# CONFIG_PPC_PMAC is not set
+CONFIG_WIIU=y
+# CONFIG_PPC_OF_BOOT_TRAMPOLINE is not set
+CONFIG_HIGHMEM=y
+CONFIG_STRICT_KERNEL_RWX=y
+CONFIG_PPC_EARLY_DEBUG=y
-- 
2.36.1

