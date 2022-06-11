Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B535473D9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 12:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbiFKKkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 06:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiFKKj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 06:39:59 -0400
Received: from smtp.smtpout.orange.fr (smtp01.smtpout.orange.fr [80.12.242.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EC66D95B
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 03:39:57 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id zyX0nKofCk3ICzyX1nTmto; Sat, 11 Jun 2022 12:39:51 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 11 Jun 2022 12:39:51 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-media@vger.kernel.org
Subject: [PATCH] media: ddbridge: Remove useless license text when SPDX-License-Identifier is already used
Date:   Sat, 11 Jun 2022 12:39:47 +0200
Message-Id: <74368624bc2b3441b7b5de94374eab7d607fbce3.1654943981.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An SPDX-License-Identifier is already in place. There is no need to
duplicate part of the corresponding license.

While at it, a few comments at the end of some .h files have been updated
to reflect the correct include guard name (missing '_' and co.)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/media/pci/ddbridge/ddbridge-ci.c   |  9 ---------
 drivers/media/pci/ddbridge/ddbridge-ci.h   |  9 ---------
 drivers/media/pci/ddbridge/ddbridge-core.c |  9 ---------
 drivers/media/pci/ddbridge/ddbridge-hw.c   |  9 ---------
 drivers/media/pci/ddbridge/ddbridge-hw.h   | 11 +----------
 drivers/media/pci/ddbridge/ddbridge-i2c.c  |  9 ---------
 drivers/media/pci/ddbridge/ddbridge-i2c.h  |  9 ---------
 drivers/media/pci/ddbridge/ddbridge-io.h   |  9 ---------
 drivers/media/pci/ddbridge/ddbridge-main.c |  9 ---------
 drivers/media/pci/ddbridge/ddbridge-max.c  |  9 ---------
 drivers/media/pci/ddbridge/ddbridge-max.h  | 11 +----------
 drivers/media/pci/ddbridge/ddbridge-mci.c  |  9 ---------
 drivers/media/pci/ddbridge/ddbridge-mci.h  |  9 ---------
 drivers/media/pci/ddbridge/ddbridge-regs.h |  9 ---------
 drivers/media/pci/ddbridge/ddbridge-sx8.c  |  9 ---------
 drivers/media/pci/ddbridge/ddbridge.h      | 11 +----------
 16 files changed, 3 insertions(+), 147 deletions(-)

diff --git a/drivers/media/pci/ddbridge/ddbridge-ci.c b/drivers/media/pci/ddbridge/ddbridge-ci.c
index 377991095aba..ee20813c33ff 100644
--- a/drivers/media/pci/ddbridge/ddbridge-ci.c
+++ b/drivers/media/pci/ddbridge/ddbridge-ci.c
@@ -5,15 +5,6 @@
  * Copyright (C) 2010-2017 Digital Devices GmbH
  *                         Marcus Metzler <mocm@metzlerbros.de>
  *                         Ralph Metzler <rjkm@metzlerbros.de>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 only, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include "ddbridge.h"
diff --git a/drivers/media/pci/ddbridge/ddbridge-ci.h b/drivers/media/pci/ddbridge/ddbridge-ci.h
index cc98656af349..41cd97e52aa1 100644
--- a/drivers/media/pci/ddbridge/ddbridge-ci.h
+++ b/drivers/media/pci/ddbridge/ddbridge-ci.h
@@ -5,15 +5,6 @@
  * Copyright (C) 2010-2017 Digital Devices GmbH
  *                         Marcus Metzler <mocm@metzlerbros.de>
  *                         Ralph Metzler <rjkm@metzlerbros.de>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 only, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef __DDBRIDGE_CI_H__
diff --git a/drivers/media/pci/ddbridge/ddbridge-core.c b/drivers/media/pci/ddbridge/ddbridge-core.c
index 92fe051c672f..fe833f39698a 100644
--- a/drivers/media/pci/ddbridge/ddbridge-core.c
+++ b/drivers/media/pci/ddbridge/ddbridge-core.c
@@ -5,15 +5,6 @@
  * Copyright (C) 2010-2017 Digital Devices GmbH
  *                         Marcus Metzler <mocm@metzlerbros.de>
  *                         Ralph Metzler <rjkm@metzlerbros.de>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 only, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/module.h>
diff --git a/drivers/media/pci/ddbridge/ddbridge-hw.c b/drivers/media/pci/ddbridge/ddbridge-hw.c
index f9c91bdbd041..d7d9cd0dad23 100644
--- a/drivers/media/pci/ddbridge/ddbridge-hw.c
+++ b/drivers/media/pci/ddbridge/ddbridge-hw.c
@@ -5,15 +5,6 @@
  * Copyright (C) 2010-2017 Digital Devices GmbH
  *                         Ralph Metzler <rjkm@metzlerbros.de>
  *                         Marcus Metzler <mocm@metzlerbros.de>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 only, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include "ddbridge.h"
diff --git a/drivers/media/pci/ddbridge/ddbridge-hw.h b/drivers/media/pci/ddbridge/ddbridge-hw.h
index e34bd94c266b..934f296f48c0 100644
--- a/drivers/media/pci/ddbridge/ddbridge-hw.h
+++ b/drivers/media/pci/ddbridge/ddbridge-hw.h
@@ -5,15 +5,6 @@
  * Copyright (C) 2010-2017 Digital Devices GmbH
  *                         Ralph Metzler <rjkm@metzlerbros.de>
  *                         Marcus Metzler <mocm@metzlerbros.de>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 only, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef _DDBRIDGE_HW_H_
@@ -40,4 +31,4 @@ struct ddb_device_id {
 const struct ddb_info *get_ddb_info(u16 vendor, u16 device,
 				    u16 subvendor, u16 subdevice);
 
-#endif /* _DDBRIDGE_HW_H */
+#endif /* _DDBRIDGE_HW_H_ */
diff --git a/drivers/media/pci/ddbridge/ddbridge-i2c.c b/drivers/media/pci/ddbridge/ddbridge-i2c.c
index aafa6030c8cc..c894be180446 100644
--- a/drivers/media/pci/ddbridge/ddbridge-i2c.c
+++ b/drivers/media/pci/ddbridge/ddbridge-i2c.c
@@ -5,15 +5,6 @@
  * Copyright (C) 2010-2017 Digital Devices GmbH
  *                         Ralph Metzler <rjkm@metzlerbros.de>
  *                         Marcus Metzler <mocm@metzlerbros.de>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 only, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/module.h>
diff --git a/drivers/media/pci/ddbridge/ddbridge-i2c.h b/drivers/media/pci/ddbridge/ddbridge-i2c.h
index 90830f7b1638..48555d41aa48 100644
--- a/drivers/media/pci/ddbridge/ddbridge-i2c.h
+++ b/drivers/media/pci/ddbridge/ddbridge-i2c.h
@@ -5,15 +5,6 @@
  * Copyright (C) 2010-2017 Digital Devices GmbH
  *                         Ralph Metzler <rjkm@metzlerbros.de>
  *                         Marcus Metzler <mocm@metzlerbros.de>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 only, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef __DDBRIDGE_I2C_H__
diff --git a/drivers/media/pci/ddbridge/ddbridge-io.h b/drivers/media/pci/ddbridge/ddbridge-io.h
index 1a5b31b52494..991246cecee2 100644
--- a/drivers/media/pci/ddbridge/ddbridge-io.h
+++ b/drivers/media/pci/ddbridge/ddbridge-io.h
@@ -5,15 +5,6 @@
  * Copyright (C) 2010-2017 Digital Devices GmbH
  *                         Ralph Metzler <rjkm@metzlerbros.de>
  *                         Marcus Metzler <mocm@metzlerbros.de>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 only, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef __DDBRIDGE_IO_H__
diff --git a/drivers/media/pci/ddbridge/ddbridge-main.c b/drivers/media/pci/ddbridge/ddbridge-main.c
index 25d0d6745b52..91733ab9f58c 100644
--- a/drivers/media/pci/ddbridge/ddbridge-main.c
+++ b/drivers/media/pci/ddbridge/ddbridge-main.c
@@ -5,15 +5,6 @@
  * Copyright (C) 2010-2017 Digital Devices GmbH
  *                         Ralph Metzler <rjkm@metzlerbros.de>
  *                         Marcus Metzler <mocm@metzlerbros.de>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 only, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/media/pci/ddbridge/ddbridge-max.c b/drivers/media/pci/ddbridge/ddbridge-max.c
index 576dd2318e4d..0582b86bb869 100644
--- a/drivers/media/pci/ddbridge/ddbridge-max.c
+++ b/drivers/media/pci/ddbridge/ddbridge-max.c
@@ -5,15 +5,6 @@
  * Copyright (C) 2010-2017 Digital Devices GmbH
  *                         Ralph Metzler <rjkm@metzlerbros.de>
  *                         Marcus Metzler <mocm@metzlerbros.de>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 only, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/module.h>
diff --git a/drivers/media/pci/ddbridge/ddbridge-max.h b/drivers/media/pci/ddbridge/ddbridge-max.h
index 6543dfc77138..da1553fe8695 100644
--- a/drivers/media/pci/ddbridge/ddbridge-max.h
+++ b/drivers/media/pci/ddbridge/ddbridge-max.h
@@ -5,15 +5,6 @@
  * Copyright (C) 2010-2017 Digital Devices GmbH
  *                         Ralph Metzler <rjkm@metzlerbros.de>
  *                         Marcus Metzler <mocm@metzlerbros.de>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 only, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef _DDBRIDGE_MAX_H_
@@ -27,4 +18,4 @@ int ddb_lnb_init_fmode(struct ddb *dev, struct ddb_link *link, u32 fm);
 int ddb_fe_attach_mxl5xx(struct ddb_input *input);
 int ddb_fe_attach_mci(struct ddb_input *input, u32 type);
 
-#endif /* _DDBRIDGE_MAX_H */
+#endif /* _DDBRIDGE_MAX_H_ */
diff --git a/drivers/media/pci/ddbridge/ddbridge-mci.c b/drivers/media/pci/ddbridge/ddbridge-mci.c
index 97384ae9ad27..a006cb0fa199 100644
--- a/drivers/media/pci/ddbridge/ddbridge-mci.c
+++ b/drivers/media/pci/ddbridge/ddbridge-mci.c
@@ -5,15 +5,6 @@
  * Copyright (C) 2017-2018 Digital Devices GmbH
  *                         Ralph Metzler <rjkm@metzlerbros.de>
  *                         Marcus Metzler <mocm@metzlerbros.de>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 only, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
  */
 
 #include "ddbridge.h"
diff --git a/drivers/media/pci/ddbridge/ddbridge-mci.h b/drivers/media/pci/ddbridge/ddbridge-mci.h
index 24241111c634..d9799fbf59d4 100644
--- a/drivers/media/pci/ddbridge/ddbridge-mci.h
+++ b/drivers/media/pci/ddbridge/ddbridge-mci.h
@@ -5,15 +5,6 @@
  * Copyright (C) 2017-2018 Digital Devices GmbH
  *                         Marcus Metzler <mocm@metzlerbros.de>
  *                         Ralph Metzler <rjkm@metzlerbros.de>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 only, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
  */
 
 #ifndef _DDBRIDGE_MCI_H_
diff --git a/drivers/media/pci/ddbridge/ddbridge-regs.h b/drivers/media/pci/ddbridge/ddbridge-regs.h
index 2942a7f35099..42256fc9695d 100644
--- a/drivers/media/pci/ddbridge/ddbridge-regs.h
+++ b/drivers/media/pci/ddbridge/ddbridge-regs.h
@@ -3,15 +3,6 @@
  * ddbridge-regs.h: Digital Devices PCIe bridge driver
  *
  * Copyright (C) 2010-2017 Digital Devices GmbH
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 only, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef __DDBRIDGE_REGS_H__
diff --git a/drivers/media/pci/ddbridge/ddbridge-sx8.c b/drivers/media/pci/ddbridge/ddbridge-sx8.c
index 374fcee94960..c8de8d283f85 100644
--- a/drivers/media/pci/ddbridge/ddbridge-sx8.c
+++ b/drivers/media/pci/ddbridge/ddbridge-sx8.c
@@ -5,15 +5,6 @@
  * Copyright (C) 2018 Digital Devices GmbH
  *                    Marcus Metzler <mocm@metzlerbros.de>
  *                    Ralph Metzler <rjkm@metzlerbros.de>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 only, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
  */
 
 #include "ddbridge.h"
diff --git a/drivers/media/pci/ddbridge/ddbridge.h b/drivers/media/pci/ddbridge/ddbridge.h
index b834449e78f8..f3699dbd193f 100644
--- a/drivers/media/pci/ddbridge/ddbridge.h
+++ b/drivers/media/pci/ddbridge/ddbridge.h
@@ -4,15 +4,6 @@
  *
  * Copyright (C) 2010-2017 Digital Devices GmbH
  *                         Ralph Metzler <rmetzler@digitaldevices.de>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 only, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef _DDBRIDGE_H_
@@ -379,4 +370,4 @@ void ddb_unmap(struct ddb *dev);
 int ddb_exit_ddbridge(int stage, int error);
 int ddb_init_ddbridge(void);
 
-#endif /* DDBRIDGE_H */
+#endif /* _DDBRIDGE_H_ */
-- 
2.34.1

