Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2DC53CB3E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 16:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245032AbiFCOCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 10:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245023AbiFCOCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 10:02:07 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592E711A0F
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 07:02:05 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 47D9E5C0102;
        Fri,  3 Jun 2022 10:02:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 03 Jun 2022 10:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        tom-fitzhenry.me.uk; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1654264925; x=1654351325; bh=W+
        eqGuBXNTJREah5NjPEs8MO/LOIrmZ4w8DTz9PEUKM=; b=qa++gpww3sM7jROf29
        Msxeiz9MXxdD9M/sKlJTFOvUkRUpZo0RMEBKZGqq86WSrvoB1kaKfjtogUd58FDh
        jrKrYHeR+EoKBZX/buSMyw9wuSXsVSkp8hWUkvxnhxhpQKpC6l/1U3dwsDJ//AvB
        U95vA1p9vxPip/dTBuugHoaOVEVaep1/hps1LMHDxNGMohAQmmHFi9JS89wBI5Wb
        9dL4izCJPHJh3kN2cuFtfJLRKv9b1QxM88toqq5pgmkDvwrY/t+vR2nIRaV6CH/i
        1EK7AL7qHpXrNkNEYwktqQX9ccbBUdskLU1JFa7+IGs4QjEi1Zshh3I4i2vfqe2d
        Auaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1654264925; x=1654351325; bh=W+eqGuBXNTJREah5NjPEs8MO/LOIrmZ4w8D
        Tz9PEUKM=; b=EZ+Ehd1s/kimSqtsf0NZ+ENsR5b6CQRNc2hpgNAktVZvKgNSp4y
        aQBDOnnE8LAgsy/mMoWY1N2HTCMpSwrptNmgXB4cyJjpSG6VnUz/sBbBtYdZxrfE
        N0r3AGLUaY5yXsCWvr4zQI0xig9I21AaXXQbcU+BA+aOkYM7Za5kwcLPb95uKs7T
        pw2rJHvJ6lFX9NrlxyDMU0nfmGKwxRPmrrQmO2auyNPsF7PPWdtjAZCp7QW+prS5
        PNsUp60unu5vi1PdImV7Uj5WUtf6vgJLcn6ESAE13mI1X5o++WsUZb00cTuuHT+F
        QLMKOTVYaBSLjrivaQ5vDaCHOhcl8lC/Vbw==
X-ME-Sender: <xms:WxSaYvqvWGqiT4Jpz7Ll5tcxOqbu1E-AdzxjGghbB2jkky_7y0WQtw>
    <xme:WxSaYpqlS0Q8Z64LW7rQm_-gIrM55N9D9vkDsRS1noMvxL-5z14ipS8y-6PVXFgkM
    mYbdnchOZc4mcU_Pg>
X-ME-Received: <xmr:WxSaYsM2VjhlM3c9KH19oRS10e-EVoJuXNK0PUANjmivKeSaZPrGd60K6ht2I6mju54FOtVEwxyhCN_Oy-Vv-Gg0P03HMA1jidc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrleeigdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefvohhmucfhihht
    iihhvghnrhihuceothhomhesthhomhdqfhhithiihhgvnhhrhidrmhgvrdhukheqnecugg
    ftrfgrthhtvghrnhepvddtkeejgeegieetgfeggefggfejgfefudeufffhieeilefggfdu
    gfejvdetuedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpphhinhgvieegrdhorh
    hgpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehtohhmsehtohhmqdhfihhtiihhvghnrhihrdhmvgdruhhk
X-ME-Proxy: <xmx:WxSaYi7vj0yx5aeUkiERZHbWtmtws26t_qv_50uDsJ3Uz_WUFtSmfw>
    <xmx:WxSaYu7u14gjKroRlnofacK25yMWhhfvigRy5PNEW77re2j1DtXP2A>
    <xmx:WxSaYqgr6WyzPiXjIWBK3k3C0JWxFIQGxDT4hdbbyKUNzLo9kqGy1Q>
    <xmx:XRSaYmh4QYAN5Q3gdYBVfByp33VGAbXPkPHud1VkOCxcCbkfWU_ohw>
Feedback-ID: iefc945ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jun 2022 10:02:00 -0400 (EDT)
From:   Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH] mtd: spi-nor: siliconkaiser: add support for sk25lp128
Date:   Fri,  3 Jun 2022 23:59:34 +1000
Message-Id: <20220603135933.143372-1-tom@tom-fitzhenry.me.uk>
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

https://lore.kernel.org/all/20220510140232.3519184-1-michael@walle.cc/

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
2. "mtd: spi-nor: introduce SNOR_ID3()" https://lore.kernel.org/all/20220510140232.3519184-1-michael@walle.cc/

Link: https://lore.kernel.org/all/20220510140232.3519184-1-michael@walle.cc/
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
index 000000000000..82bb6094caa9
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
+  { "sk25lp128", SNOR_ID3(0x257018) },
+};
+
+const struct spi_nor_manufacturer spi_nor_siliconkaiser = {
+	.name = "siliconkaiser",
+	.parts = siliconkaiser_nor_parts,
+	.nparts = ARRAY_SIZE(siliconkaiser_nor_parts),
+};
-- 
2.36.0

