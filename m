Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2EFD476EEC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 11:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236099AbhLPKbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 05:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbhLPKbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 05:31:47 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C9EC061574;
        Thu, 16 Dec 2021 02:31:47 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id v11so43255561wrw.10;
        Thu, 16 Dec 2021 02:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=NSLbFKF3l2MC+VZMq4xcql75R+Dywdt7m8WtZkY7/Ow=;
        b=VbQd+fMUAIH0AjTsTLfHDLRX1Ph8gJo18ABbkcYzOj68ScWPmKyieumddIRv1Oi+zL
         Em74AMhNSSYMTZf6YdTaWnp5eAg4hAPb9yamf+akszCO+Ic9+tmh2Bkr7iC8Z0GMeJjS
         jXmdDKdaVaI96k+IH03IM1dbZCMBwqLgUbqn0RvfmYmEKkrY/zn4DeWGd0xTX3iObwQs
         M917qg8zOlYtBSNe0E83zjei9K8qtu8P0xXFnX84Ip6gdL1E73mLIhWd1pwYlc6nnqOJ
         Gycn16b78iSjsgNplZfMFkeTmERS/e0Xl68+ZUJsqFA7U+zGhjTdI5I2m5PC56t/61fj
         lOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NSLbFKF3l2MC+VZMq4xcql75R+Dywdt7m8WtZkY7/Ow=;
        b=aT70rIaFNbPUxVgzo3TZD79Q+oS/IORggBaspNdTJkFsgTjvNE3o3vKoPaSnSuOoPA
         2A3VNGl+hgtQRZVTbPZI8LYLGZFsJ2bFmUzc1PfE2WPlsRURd5Yx6LfOJHJEqNI2mdbx
         x9Ug3hIDCqMSHZesIC9c4cLUrslBLbTBvTFsL94MOs17BNnj25gF75So2OgHCFakXw9R
         tETnhuX3L90tPzxlMI5FKdk/6UL8bUPbfjyMK1KZZ2wv0tlHVpEAvydS5IGxO/pIlpn6
         +kDHmfbfkM+3SXI4Jr2w4RruoL1+y7PcL12iQ4q4x2Ov40fPjhHHIQttRX/26X2ftRkm
         e0gw==
X-Gm-Message-State: AOAM530TvdFT4/7q6LJ80G1JsAfhoFsju5IzDruwOUsgOJYymnlAvN/Z
        QL7ChagaeleSRlb/oTKRnzs=
X-Google-Smtp-Source: ABdhPJxiHI10MvHaHZMLObDjMA+4TuuNNS/pyYG7cirXBSQB8NGEj/8OJy4aYktvN9NIv8Qq1fH/Ag==
X-Received: by 2002:adf:fe4e:: with SMTP id m14mr4136481wrs.713.1639650705820;
        Thu, 16 Dec 2021 02:31:45 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:267b:1200:18af:bb55:aabf:94a8])
        by smtp.gmail.com with ESMTPSA id u12sm4399299wrf.60.2021.12.16.02.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 02:31:45 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Cai Huoqing <caihuoqing@baidu.com>, linux-media@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-spdx@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] media: prefer generic SPDX-License expression to deprecated one
Date:   Thu, 16 Dec 2021 11:31:32 +0100
Message-Id: <20211216103132.8087-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8d395ce6f04b ("media: dvb-core: Convert to SPDX identifier") and
commit e67219b0496b ("media: b2c2: flexcop: Convert to SPDX identifier")
introduce the SPDX-License expression LGPL-2.1-or-later for some files.

The command ./scripts/spdxcheck.py warns:

  drivers/media/dvb-core/dmxdev.c: 1:28 Invalid License ID: LGPL-2.1-or-later
  drivers/media/dvb-core/dvb_demux.c: 1:28 Invalid License ID: LGPL-2.1-or-later
  drivers/media/dvb-core/dvbdev.c: 1:28 Invalid License ID: LGPL-2.1-or-later
  drivers/media/common/b2c2/flexcop.c: 1:28 Invalid License ID: LGPL-2.1-or-later

The preferred SPDX expression for LGPL-2.1 or any later version is with
the more generic "+"-extension for "any later version", so: LGPL-2.1+

This makes spdxcheck happy again.

Fixes: 8d395ce6f04b ("media: dvb-core: Convert to SPDX identifier")
Fixes: e67219b0496b ("media: b2c2: flexcop: Convert to SPDX identifier")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/media/common/b2c2/flexcop.c | 2 +-
 drivers/media/dvb-core/dmxdev.c     | 2 +-
 drivers/media/dvb-core/dvb_demux.c  | 2 +-
 drivers/media/dvb-core/dvbdev.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/common/b2c2/flexcop.c b/drivers/media/common/b2c2/flexcop.c
index e7a88a2d248c..38c300da3fc2 100644
--- a/drivers/media/common/b2c2/flexcop.c
+++ b/drivers/media/common/b2c2/flexcop.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: LGPL-2.1-or-later
+// SPDX-License-Identifier: LGPL-2.1+
 /*
  * Linux driver for digital TV devices equipped with B2C2 FlexcopII(b)/III
  * flexcop.c - main module part
diff --git a/drivers/media/dvb-core/dmxdev.c b/drivers/media/dvb-core/dmxdev.c
index f6ee678107d3..2b4fb2ec1efd 100644
--- a/drivers/media/dvb-core/dmxdev.c
+++ b/drivers/media/dvb-core/dmxdev.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: LGPL-2.1-or-later
+// SPDX-License-Identifier: LGPL-2.1+
 /*
  * dmxdev.c - DVB demultiplexer device
  *
diff --git a/drivers/media/dvb-core/dvb_demux.c b/drivers/media/dvb-core/dvb_demux.c
index 83cc32ad7e12..35bf76b0425c 100644
--- a/drivers/media/dvb-core/dvb_demux.c
+++ b/drivers/media/dvb-core/dvb_demux.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: LGPL-2.1-or-later
+// SPDX-License-Identifier: LGPL-2.1+
 /*
  * dvb_demux.c - DVB kernel demux API
  *
diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index 675d877a67b2..861559e8b4c9 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: LGPL-2.1-or-later
+// SPDX-License-Identifier: LGPL-2.1+
 /*
  * dvbdev.c
  *
-- 
2.17.1

