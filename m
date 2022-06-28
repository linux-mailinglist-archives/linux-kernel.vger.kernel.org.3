Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D0355E4CC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346667AbiF1NeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346664AbiF1NdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:33:23 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E13D1055A;
        Tue, 28 Jun 2022 06:33:22 -0700 (PDT)
Received: (Authenticated sender: ash@heyquark.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E4D5C20000E;
        Tue, 28 Jun 2022 13:33:14 +0000 (UTC)
From:   Ash Logan <ash@heyquark.com>
To:     krzysztof.kozlowski+dt@linaro.org, paulus@samba.org,
        mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        robh+dt@kernel.org, benh@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        j.ne@posteo.net, linkmauve@linkmauve.fr,
        rw-r-r-0644@protonmail.com, devicetree@vger.kernel.org,
        joel@jms.id.au
Subject: [PATCH v3 12/12] powerpc: wiiu: add minimal default config
Date:   Tue, 28 Jun 2022 23:31:44 +1000
Message-Id: <20220628133144.142185-13-ash@heyquark.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628133144.142185-1-ash@heyquark.com>
References: <20220622131037.57604-1-ash@heyquark.com>
 <20220628133144.142185-1-ash@heyquark.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

