Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABAB53CB72
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 16:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245108AbiFCORF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 10:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245103AbiFCOQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 10:16:48 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5774843ED4
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 07:16:40 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 3A7B45C0191;
        Fri,  3 Jun 2022 10:16:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 03 Jun 2022 10:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        tom-fitzhenry.me.uk; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1654265798; x=1654352198; bh=II
        WE5U6MXchK3j3NJSoRc0MYsk5Fq/1S6HmxMUVoUno=; b=FbkmV9JU9AUbhMtWSb
        WwogkiB7pxrJcdymU0W/iQ8HQhi061Wz63JMRnlzTRse+5PXaWpTYxW8g1rkwfSq
        UR+jbMKb8GSZaJiv4vyvXPKHdfvAuMl8UGnnYTSKhuNx4nmFFrZKrcwYnEPOYTYv
        JJuj/vqORGq+RwHxq7L1mk35gKTdlimF/IpTrD3q5ZgwqSv2N2qBpYgVT09fbfek
        QLZ2W3ZyQUMc4/J5L24Av0n5YlYaLQti+3Iw1jv+BUfByKw5kQ7uEBBJAYKWuxdJ
        Ox7PHBmMV4uRu154WiT5PsSCODB2z3F2thp4fwmaEAwQcw+kxdsvGWJy/lDSGqYl
        5/iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1654265798; x=1654352198; bh=IIWE5U6MXchK3j3NJSoRc0MYsk5Fq/1S6Hm
        xMUVoUno=; b=B6X2uvCWHQ1kybbGOcjJTB+5rjQJTZKuN+Uga6cwY1QysVoamaW
        W9G9GDLCq1/11g1cUdRfbGGiQwOxX88IKkAetxOXd8s4mlkAmSNQSv7RAq3uUvu6
        h0gg7jS22f0uEN+DuiO2XGXP66Xr8ObSPLH9frwnMnV7tlT4DDv64tXBS5kzlBle
        CMTunB3gAEokJBfpZgTYor649acaBiIyX6eP8NnukbhoREdnyAk2C6p8UpUCDIyi
        ZSlRGLx4Rpohu0wZU+QhlXL2bz/BdMV+TcMJTJpWBVGrllG6W4jWCff7+dPYn0II
        DlUu4qEEonWMRABz06Mu06J/rrmh0sMf2Zw==
X-ME-Sender: <xms:xReaYm_8QM6dWWqsKpTDYBnqxSkUy422UwChOBdOhr6S2B3bRR2h9g>
    <xme:xReaYmtRwXS5WVrrfgOfX3NU9ireTtmch7arjiSvHSuJYj7IVBDSYyrMORboEFmr7
    0cMsAKscoDwRN-Eqg>
X-ME-Received: <xmr:xReaYsAkejWFugfeiShPK0jbyAzBhWJfgDbU6PaXQcuc45bINvoJs4XYy5yxRfC8uTBWvh4cX5wR79CBCtvEKgUy8vmxlTXl_jY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrleeigdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefvohhmucfhihht
    iihhvghnrhihuceothhomhesthhomhdqfhhithiihhgvnhhrhidrmhgvrdhukheqnecugg
    ftrfgrthhtvghrnhepffekheegkeehveehveetgfevuefggfeiveevueetheehgeegffeh
    hefhudeilefhnecuffhomhgrihhnpehpihhnvgeigedrohhrghdpghhithhhuhgsrdgtoh
    hmpdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehtohhmsehtohhmqdhfihhtiihhvghnrhihrdhmvgdruhhk
X-ME-Proxy: <xmx:xReaYueR6SdbPPSEDWA8mt6ZCoj9iIRHtJ7txjVJH7lVAym2HYRWgQ>
    <xmx:xReaYrNtwObnG0GAOeeuDqdiem1aaEpOZrjsLDwBtyuL6MYcMxfi1Q>
    <xmx:xReaYokjaP6mhi86YU-3n-6qrbuXK4kh71r-AGQe4PfzXSogP3LiWA>
    <xmx:xheaYokqYiH7yuAkwWuV7tlifNzR5-d2BMEbnvgsLYJEaZ57CbeD_Q>
Feedback-ID: iefc945ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jun 2022 10:16:34 -0400 (EDT)
From:   Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH v2] mtd: spi-nor: siliconkaiser: add support for sk25lp128
Date:   Sat,  4 Jun 2022 00:16:03 +1000
Message-Id: <20220603141603.145777-1-tom@tom-fitzhenry.me.uk>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the siliconkaiser sk25lp128 chip.

This is the flash chip used in the PinePhone Pro[0], found by physical
inspection of the board.[1]

I cannot find a datasheet, but this chip supports SFDP.

This patch depends on SNOR_ID3().[2]

Tested done: checked that the Pinephone Pro boots when a ROM is written to
/dev/mtdblock0.

$ xxd -p /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
53464450060101ff00060110300000ff9d05010380000002ffffffffffff
ffffffffffffffffffffffffffffffffffffe520f9ffffffff0744eb086b
083b80bbfeffffffffff00ffffff44eb0c200f5210d800ff234ac90082d8
11c7cccd68467a757a75f7a2d55c4a422cfff030c080ffffffffffffffff
ffffffffffffffff501950169cf9c0648fecffff
$ md5sum /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
de4d6be54e479d60859b0ca8a0ee9216
/sys/bus/spi/devices/spi0.0/spi-nor/sfdp
$ cat /sys/bus/spi/devices/spi0.0/spi-nor/jedec_id
257018
$ cat /sys/bus/spi/devices/spi0.0/spi-nor/partname
sk25lp128
$ cat /sys/bus/spi/devices/spi0.0/spi-nor/manufacturer
siliconkaiser

0. https://wiki.pine64.org/wiki/PinePhone_Pro#Specifications
1. Thanks to https://github.com/Biktorgj for finding that.
2. https://lore.kernel.org/all/20220510140232.3519184-1-michael@walle.cc/

Link: https://lore.kernel.org/all/28d3925a-983a-fcb8-19af-6e6baf892d53@tom-fitzhenry.me.uk/
Signed-off-by: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
---
 drivers/mtd/spi-nor/Makefile        |  1 +
 drivers/mtd/spi-nor/core.c          |  1 +
 drivers/mtd/spi-nor/core.h          |  1 +
 drivers/mtd/spi-nor/siliconkaiser.c | 15 +++++++++++++++
 4 files changed, 18 insertions(+)
 create mode 100644 drivers/mtd/spi-nor/siliconkaiser.c

diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
index e347b435a038..314ac7773369 100644
--- a/drivers/mtd/spi-nor/Makefile
+++ b/drivers/mtd/spi-nor/Makefile
@@ -12,6 +12,7 @@ spi-nor-objs			+= intel.o
 spi-nor-objs			+= issi.o
 spi-nor-objs			+= macronix.o
 spi-nor-objs			+= micron-st.o
+spi-nor-objs			+= siliconkaiser.o
 spi-nor-objs			+= spansion.o
 spi-nor-objs			+= sst.o
 spi-nor-objs			+= winbond.o
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index fdde80d9f388..e542d3009915 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1624,6 +1624,7 @@ static const struct spi_nor_manufacturer *manufacturers[] = {
 	&spi_nor_issi,
 	&spi_nor_macronix,
 	&spi_nor_micron,
+	&spi_nor_siliconkaiser,
 	&spi_nor_st,
 	&spi_nor_spansion,
 	&spi_nor_sst,
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 87183cff3251..8997099f6c5e 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -625,6 +625,7 @@ extern const struct spi_nor_manufacturer spi_nor_intel;
 extern const struct spi_nor_manufacturer spi_nor_issi;
 extern const struct spi_nor_manufacturer spi_nor_macronix;
 extern const struct spi_nor_manufacturer spi_nor_micron;
+extern const struct spi_nor_manufacturer spi_nor_siliconkaiser;
 extern const struct spi_nor_manufacturer spi_nor_st;
 extern const struct spi_nor_manufacturer spi_nor_spansion;
 extern const struct spi_nor_manufacturer spi_nor_sst;
diff --git a/drivers/mtd/spi-nor/siliconkaiser.c b/drivers/mtd/spi-nor/siliconkaiser.c
new file mode 100644
index 000000000000..c3ca157244b8
--- /dev/null
+++ b/drivers/mtd/spi-nor/siliconkaiser.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/mtd/spi-nor.h>
+
+#include "core.h"
+
+static const struct flash_info siliconkaiser_nor_parts[] = {
+	{ "sk25lp128", SNOR_ID3(0x257018) },
+};
+
+const struct spi_nor_manufacturer spi_nor_siliconkaiser = {
+	.name = "siliconkaiser",
+	.parts = siliconkaiser_nor_parts,
+	.nparts = ARRAY_SIZE(siliconkaiser_nor_parts),
+};
-- 
2.36.0

