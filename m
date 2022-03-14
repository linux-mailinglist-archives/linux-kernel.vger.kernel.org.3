Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744B14D89E5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236139AbiCNQkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243216AbiCNQgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:36:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3AD2CCA3;
        Mon, 14 Mar 2022 09:35:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A23BC61481;
        Mon, 14 Mar 2022 16:35:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70248C36B16;
        Mon, 14 Mar 2022 16:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647275709;
        bh=VjwJOKOs8oHPyYCWSWn1u0Ow97//hnvsn2xXS8eZAP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tiFFmvxz8PEDznKO6aU6n8vZpRdZfe23nA/DXG83Q+AN6LI8jKepHAnRrZ/6p95vp
         TjMxJ+dlAaKunAyAwBdNaSmrsawP/jWa2VnH6oYf1ulZW/mRsQFOiDB3h4I+N/jP+M
         YdmA59WAiEa7Jdn4vj/25kmWb6raMBbOR2JtbQDZMBNL6V7vGOlePINXFd33WgBXqv
         IH2hIY7mIdZ6iGpaMvsb2S8KjRXT6LHwPZa1CZnwuddnX/k6oamrTek5chco6CYJ/9
         J56swggJoRH9AZcF/xfrDl4/x63NGb821hz3KOFTM+4mmxyFmXwM2LOOqnriA8SlfD
         sa6kMlvkStJSQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTnf1-001x08-7q; Mon, 14 Mar 2022 17:35:07 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        Dmitriy Ulitin <ulitin@ispras.ru>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ming Qian <ming.qian@nxp.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 55/67] media: platform: rename stm32/ to stm/stm32/
Date:   Mon, 14 Mar 2022 17:34:50 +0100
Message-Id: <16d08dbabfaec4986a551efcb0dd0f07da256507.1647274407.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647274406.git.mchehab@kernel.org>
References: <cover.1647274406.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the end goal is to have platform drivers split by vendor,
rename stm32/ to stm/stm32/.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/67] at: https://lore.kernel.org/all/cover.1647274406.git.mchehab@kernel.org/

 MAINTAINERS                                               | 2 +-
 drivers/media/platform/Kconfig                            | 2 +-
 drivers/media/platform/Makefile                           | 2 +-
 drivers/media/platform/{ => stm}/stm32/Kconfig            | 0
 drivers/media/platform/{ => stm}/stm32/Makefile           | 0
 drivers/media/platform/{ => stm}/stm32/dma2d/dma2d-hw.c   | 0
 drivers/media/platform/{ => stm}/stm32/dma2d/dma2d-regs.h | 0
 drivers/media/platform/{ => stm}/stm32/dma2d/dma2d.c      | 0
 drivers/media/platform/{ => stm}/stm32/dma2d/dma2d.h      | 0
 drivers/media/platform/{ => stm}/stm32/stm32-dcmi.c       | 0
 10 files changed, 3 insertions(+), 3 deletions(-)
 rename drivers/media/platform/{ => stm}/stm32/Kconfig (100%)
 rename drivers/media/platform/{ => stm}/stm32/Makefile (100%)
 rename drivers/media/platform/{ => stm}/stm32/dma2d/dma2d-hw.c (100%)
 rename drivers/media/platform/{ => stm}/stm32/dma2d/dma2d-regs.h (100%)
 rename drivers/media/platform/{ => stm}/stm32/dma2d/dma2d.c (100%)
 rename drivers/media/platform/{ => stm}/stm32/dma2d/dma2d.h (100%)
 rename drivers/media/platform/{ => stm}/stm32/stm32-dcmi.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index a0cfe84b8192..4cf03d253bc8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12046,7 +12046,7 @@ L:	linux-media@vger.kernel.org
 S:	Supported
 T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/st,stm32-dcmi.yaml
-F:	drivers/media/platform/stm32/stm32-dcmi.c
+F:	drivers/media/platform/stm/stm32/stm32-dcmi.c
 
 MEDIA INPUT INFRASTRUCTURE (V4L/DVB)
 M:	Mauro Carvalho Chehab <mchehab@kernel.org>
diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 6b05afa218b3..c308de1a42a4 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -95,7 +95,7 @@ source "drivers/media/platform/samsung/s5p-g2d/Kconfig"
 source "drivers/media/platform/samsung/s5p-jpeg/Kconfig"
 source "drivers/media/platform/samsung/s5p-mfc/Kconfig"
 source "drivers/media/platform/sti/Kconfig"
-source "drivers/media/platform/stm32/Kconfig"
+source "drivers/media/platform/stm/stm32/Kconfig"
 source "drivers/media/platform/ti-vpe/Kconfig"
 source "drivers/media/platform/via/Kconfig"
 source "drivers/media/platform/xilinx/Kconfig"
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index 97aa99d8fac8..7f077c9a416d 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -40,7 +40,7 @@ obj-y += sti/bdisp/
 obj-y += sti/c8sectpfe/
 obj-y += sti/delta/
 obj-y += sti/hva/
-obj-y += stm32/
+obj-y += stm/stm32/
 obj-y += ti-vpe/
 obj-y += via/
 obj-y += xilinx/
diff --git a/drivers/media/platform/stm32/Kconfig b/drivers/media/platform/stm/stm32/Kconfig
similarity index 100%
rename from drivers/media/platform/stm32/Kconfig
rename to drivers/media/platform/stm/stm32/Kconfig
diff --git a/drivers/media/platform/stm32/Makefile b/drivers/media/platform/stm/stm32/Makefile
similarity index 100%
rename from drivers/media/platform/stm32/Makefile
rename to drivers/media/platform/stm/stm32/Makefile
diff --git a/drivers/media/platform/stm32/dma2d/dma2d-hw.c b/drivers/media/platform/stm/stm32/dma2d/dma2d-hw.c
similarity index 100%
rename from drivers/media/platform/stm32/dma2d/dma2d-hw.c
rename to drivers/media/platform/stm/stm32/dma2d/dma2d-hw.c
diff --git a/drivers/media/platform/stm32/dma2d/dma2d-regs.h b/drivers/media/platform/stm/stm32/dma2d/dma2d-regs.h
similarity index 100%
rename from drivers/media/platform/stm32/dma2d/dma2d-regs.h
rename to drivers/media/platform/stm/stm32/dma2d/dma2d-regs.h
diff --git a/drivers/media/platform/stm32/dma2d/dma2d.c b/drivers/media/platform/stm/stm32/dma2d/dma2d.c
similarity index 100%
rename from drivers/media/platform/stm32/dma2d/dma2d.c
rename to drivers/media/platform/stm/stm32/dma2d/dma2d.c
diff --git a/drivers/media/platform/stm32/dma2d/dma2d.h b/drivers/media/platform/stm/stm32/dma2d/dma2d.h
similarity index 100%
rename from drivers/media/platform/stm32/dma2d/dma2d.h
rename to drivers/media/platform/stm/stm32/dma2d/dma2d.h
diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm/stm32/stm32-dcmi.c
similarity index 100%
rename from drivers/media/platform/stm32/stm32-dcmi.c
rename to drivers/media/platform/stm/stm32/stm32-dcmi.c
-- 
2.35.1

