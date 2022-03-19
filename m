Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB6E4DE770
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 11:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242694AbiCSK3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 06:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbiCSK3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 06:29:35 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2B589CCE
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 03:28:12 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KLHCG2thjz9sSW;
        Sat, 19 Mar 2022 11:28:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mm8j_WRInuZR; Sat, 19 Mar 2022 11:28:10 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KLHCG1bXGz9sSP;
        Sat, 19 Mar 2022 11:28:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 18F288B76C;
        Sat, 19 Mar 2022 11:28:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id a17gy9YEoaHD; Sat, 19 Mar 2022 11:28:09 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.222])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C04188B765;
        Sat, 19 Mar 2022 11:28:09 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 22JARwNd456602
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 19 Mar 2022 11:27:58 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 22JARuTD456594;
        Sat, 19 Mar 2022 11:27:56 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/nouveau/bios: Rename prom_init() and friends functions
Date:   Sat, 19 Mar 2022 11:27:51 +0100
Message-Id: <7e0612b61511ec8030e3b2dcbfaa7751781c8b91.1647684507.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1647685669; l=3722; s=20211009; h=from:subject:message-id; bh=y5DQYDGAWf+okMg9sN/L7lksMPfKpXX0wlcMvN+TCx8=; b=BT0h00TI+fMGlEX6pCDLyjtx88LkgtnMe1L7kFbayDTiEZXd6XQy/COY5UB6n29i40apuruO6pqn hs/Pbx4tCwp2V2DyWFRrCMSLctLldhri/vsSKggV7Xx2XGdvLBsE
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While working at fixing powerpc headers, I ended up with the
following error.

	drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c:48:1: error: conflicting types for 'prom_init'; have 'void *(struct nvkm_bios *, const char *)'
	make[5]: *** [scripts/Makefile.build:288: drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.o] Error 1

powerpc and a few other architectures have a prom_init() global function.
One day or another it will conflict with the one in shadowrom.c

Those being static, they can easily be renamed. Do it.

While at it, also rename the ops structure as 'nvbios_prom' instead of
'nvbios_rom' in order to make it clear that it refers to the
NV_PROM device.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: using nvbios_prom prefix instead of nvbios_rom. Changed structure name to keep things consistant.

 drivers/gpu/drm/nouveau/nvkm/subdev/bios/priv.h    |  2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c  |  2 +-
 .../gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c   | 14 +++++++-------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/priv.h b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/priv.h
index fac1bff1311b..cfa8a0c356dd 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/priv.h
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/priv.h
@@ -19,7 +19,7 @@ struct nvbios_source {
 int nvbios_extend(struct nvkm_bios *, u32 length);
 int nvbios_shadow(struct nvkm_bios *);
 
-extern const struct nvbios_source nvbios_rom;
+extern const struct nvbios_source nvbios_prom;
 extern const struct nvbios_source nvbios_ramin;
 extern const struct nvbios_source nvbios_acpi_fast;
 extern const struct nvbios_source nvbios_acpi_slow;
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c
index 4b571cc6bc70..19188683c8fc 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c
@@ -171,7 +171,7 @@ nvbios_shadow(struct nvkm_bios *bios)
 	struct shadow mthds[] = {
 		{ 0, &nvbios_of },
 		{ 0, &nvbios_ramin },
-		{ 0, &nvbios_rom },
+		{ 0, &nvbios_prom },
 		{ 0, &nvbios_acpi_fast },
 		{ 4, &nvbios_acpi_slow },
 		{ 1, &nvbios_pcirom },
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c
index ffa4b395220a..39144ceb117b 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c
@@ -25,7 +25,7 @@
 #include <subdev/pci.h>
 
 static u32
-prom_read(void *data, u32 offset, u32 length, struct nvkm_bios *bios)
+nvbios_prom_read(void *data, u32 offset, u32 length, struct nvkm_bios *bios)
 {
 	struct nvkm_device *device = data;
 	u32 i;
@@ -38,14 +38,14 @@ prom_read(void *data, u32 offset, u32 length, struct nvkm_bios *bios)
 }
 
 static void
-prom_fini(void *data)
+nvbios_prom_fini(void *data)
 {
 	struct nvkm_device *device = data;
 	nvkm_pci_rom_shadow(device->pci, true);
 }
 
 static void *
-prom_init(struct nvkm_bios *bios, const char *name)
+nvbios_prom_init(struct nvkm_bios *bios, const char *name)
 {
 	struct nvkm_device *device = bios->subdev.device;
 	if (device->card_type == NV_40 && device->chipset >= 0x4c)
@@ -55,10 +55,10 @@ prom_init(struct nvkm_bios *bios, const char *name)
 }
 
 const struct nvbios_source
-nvbios_rom = {
+nvbios_prom = {
 	.name = "PROM",
-	.init = prom_init,
-	.fini = prom_fini,
-	.read = prom_read,
+	.init = nvbios_prom_init,
+	.fini = nvbios_prom_fini,
+	.read = nvbios_prom_read,
 	.rw = false,
 };
-- 
2.35.1

