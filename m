Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341594E2E8F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351478AbiCUQxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351444AbiCUQxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:53:49 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03166181150
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:52:13 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 32FD33201E3E;
        Mon, 21 Mar 2022 12:52:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 21 Mar 2022 12:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=p5Ys4eQa7puvj9
        /ziOqLgg1MYgYcW6qkq+qG6HyFH5A=; b=AcAewwuTPkjuL+5CPltcc21ol3cyyt
        gIcuIiOPD+N6XgIEB6gzN2m+gb2CWt+L9SNS8p/Es8zFs2i6eQ9gKdpJJVYtbo61
        /uZ2wy0/ScHfm9NcfFNgLpAnozV83upJLE5LIIb+4zAx2lsKNmqzw6FGFSMh0zMl
        nyfCxeEKMsfLsKwSvHDUJ13C7psnRi9obANt1fJy1LsXb5xefCOOUBpGqf7YOvuS
        Wfqom1O/FLT2fZATDsmyneIgEEnWFzr886inQIr66NpaZwJWjl7XFW3CSv/n+0FG
        81F2JQ584/YX9TNofI0xgGkm+ZXClyEI6XtUgDGx0iIHDpRDtzxtCZFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=p5Ys4e
        Qa7puvj9/ziOqLgg1MYgYcW6qkq+qG6HyFH5A=; b=Wcxn2xBqFZ/GbPV40m9Shv
        BW2rQs+rrqV/3f5ChxCYAeWi5EO1PFsFCNGCqE38UjVtHOx4DUObDRc4jG9peDov
        rfb0yEfcnfolcMYLf2CMP4tdX8GKVh75t/ybntTsp+IISFR+L3Y6C5ATDYo8SecD
        RVeF9u3igtlHTWGaeE8+us+jzLKt//nfiuPe+v3fa4kl5m5wgaxoxWbc4GDbYSJb
        aDhU8TRB9EnM9uWEjdPOZ6wqYFCGDbtBV6qhZVF9M8R6mdjj3zs1mS6+zr98+Jm9
        HVPgds+Bdj+4AHKv3WHBm3hzMWkg9ukZezQJIEN7x+6E2Nxp29glaJADC2D6ueAg
        ==
X-ME-Sender: <xms:O604YrxkDOk2TJK-pwko-Iqo76Lq0yKo5PRMU0nKXDSaLmQgOnSEAQ>
    <xme:O604YjToDYrBLMDwVVX-Pi2wBS8ngsYYISMbHmXPKF9xiZ_ZAQMgwhsTkUXQRF_4K
    TIRT2ICH4mE87lC7KE>
X-ME-Received: <xmr:O604YlXu2mUB-HAryk4vZkha6xv2I4iLqYkrEflbVoB3LMd7BBd7cDe6_oSkVlJDQGmUcIY-VLJNvpIbSJeTulBBiNpCUuWDLLTW8oKPJ7R6nki4CFPg_AkMrTfhEl4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegfedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    hmihhsshhinhhgucfvqfcufhhivghlugculdeftddmnegoteeftdduqddtudculdduhedm
    necujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnh
    curfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthht
    vghrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfe
    ejnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepshhv
    vghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:O604YlhEl8FZ2wpNu0iDwNXBAmebYzkoPTOMAT9PyZoVhXMkRI9wOg>
    <xmx:O604YtDtMuL2O61RPG7On954gGLc50GC0hQuwpnPLydYSPxD24DT1A>
    <xmx:O604YuK9_i3qeuSbeQvp6Sw_Ap69D_bj5avzanzPOuXZ2sYZcsCa2g>
    <xmx:O604Yh6n_DC2l0XxsZqTTYhBl0R03vxHtIWEocK6c4gwlWfQb7pGNQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Mar 2022 12:52:09 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
Cc:     Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH 5/9] soc: apple: Add RTKit IPC library
Date:   Mon, 21 Mar 2022 17:50:45 +0100
Message-Id: <20220321165049.35985-6-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220321165049.35985-1-sven@svenpeter.dev>
References: <20220321165049.35985-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apple SoCs such as the M1 come with multiple embedded co-processors
running proprietary firmware. Communication with those is established
over a simple mailbox using the RTKit IPC protocol.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/soc/apple/Kconfig          |  13 +
 drivers/soc/apple/Makefile         |   3 +
 drivers/soc/apple/rtkit-crashlog.c | 147 +++++
 drivers/soc/apple/rtkit-internal.h |  76 +++
 drivers/soc/apple/rtkit.c          | 842 +++++++++++++++++++++++++++++
 include/linux/soc/apple/rtkit.h    | 203 +++++++
 6 files changed, 1284 insertions(+)
 create mode 100644 drivers/soc/apple/rtkit-crashlog.c
 create mode 100644 drivers/soc/apple/rtkit-internal.h
 create mode 100644 drivers/soc/apple/rtkit.c
 create mode 100644 include/linux/soc/apple/rtkit.h

diff --git a/drivers/soc/apple/Kconfig b/drivers/soc/apple/Kconfig
index 8c37ffd53fbd..feb56419ac3c 100644
--- a/drivers/soc/apple/Kconfig
+++ b/drivers/soc/apple/Kconfig
@@ -17,6 +17,19 @@ config APPLE_PMGR_PWRSTATE
 	  controls for SoC devices. This driver manages them through the
 	  generic power domain framework, and also provides reset support.
 
+config APPLE_RTKIT
+	tristate "Apple RTKit co-processor IPC protocol"
+	depends on MAILBOX
+	depends on ARCH_APPLE || (COMPILE_TEST && 64BIT)
+	default ARCH_APPLE
+	help
+	  Apple SoCs such as the M1 come with various co-processors running
+	  their proprietary RTKit operating system. This option enables support
+	  for the protocol library used to communicate with those. It is used
+	  by various client drivers.
+
+	  Say 'y' here if you have an Apple SoC.
+
 config APPLE_SART
 	tristate "Apple SART DMA address filter"
 	depends on ARCH_APPLE || COMPILE_TEST
diff --git a/drivers/soc/apple/Makefile b/drivers/soc/apple/Makefile
index c83c66317098..e293770cf66d 100644
--- a/drivers/soc/apple/Makefile
+++ b/drivers/soc/apple/Makefile
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_APPLE_PMGR_PWRSTATE)	+= apple-pmgr-pwrstate.o
 
+obj-$(CONFIG_APPLE_RTKIT) += apple-rtkit.o
+apple-rtkit-y = rtkit.o rtkit-crashlog.o
+
 obj-$(CONFIG_APPLE_SART) += apple-sart.o
 apple-sart-y = sart.o
diff --git a/drivers/soc/apple/rtkit-crashlog.c b/drivers/soc/apple/rtkit-crashlog.c
new file mode 100644
index 000000000000..4612c8997632
--- /dev/null
+++ b/drivers/soc/apple/rtkit-crashlog.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Apple RTKit IPC library
+ * Copyright (C) The Asahi Linux Contributors
+ */
+#include "rtkit-internal.h"
+
+#define FOURCC(a, b, c, d)                                                     \
+	(((u32)(a) << 24) | ((u32)(b) << 16) | ((u32)(c) << 8) | ((u32)(d)))
+
+#define APPLE_RTKIT_CRASHLOG_HEADER FOURCC('C', 'L', 'H', 'E')
+#define APPLE_RTKIT_CRASHLOG_STR FOURCC('C', 's', 't', 'r')
+#define APPLE_RTKIT_CRASHLOG_VERSION FOURCC('C', 'v', 'e', 'r')
+#define APPLE_RTKIT_CRASHLOG_MBOX FOURCC('C', 'm', 'b', 'x')
+#define APPLE_RTKIT_CRASHLOG_TIME FOURCC('C', 't', 'i', 'm')
+
+struct apple_rtkit_crashlog_header {
+	u32 fourcc;
+	u32 version;
+	u32 size;
+	u32 flags;
+	u8 _unk[16];
+};
+static_assert(sizeof(struct apple_rtkit_crashlog_header) == 0x20);
+
+struct apple_rtkit_crashlog_mbox_entry {
+	u64 msg0;
+	u64 msg1;
+	u32 timestamp;
+	u8 _unk[4];
+};
+static_assert(sizeof(struct apple_rtkit_crashlog_mbox_entry) == 0x18);
+
+static void apple_rtkit_crashlog_dump_str(struct apple_rtkit *rtk, u8 *bfr,
+					  size_t size)
+{
+	u32 idx;
+	u8 *ptr, *end;
+
+	memcpy(&idx, bfr, 4);
+
+	ptr = bfr + 4;
+	end = bfr + size;
+	while (ptr < end) {
+		u8 *newline = memchr(ptr, '\n', end - ptr);
+
+		if (newline) {
+			u8 tmp = *newline;
+			*newline = '\0';
+			rtk_warn("Message (id=%x): %s\n", idx, ptr);
+			*newline = tmp;
+			ptr = newline + 1;
+		} else {
+			rtk_warn("Message (id=%x): %s", idx, ptr);
+			break;
+		}
+	}
+}
+
+static void apple_rtkit_crashlog_dump_version(struct apple_rtkit *rtk, u8 *bfr,
+					      size_t size)
+{
+	rtk_warn("Version: %s", bfr + 16);
+}
+
+static void apple_rtkit_crashlog_dump_time(struct apple_rtkit *rtk, u8 *bfr,
+					   size_t size)
+{
+	u64 crash_time;
+
+	memcpy(&crash_time, bfr, 8);
+	rtk_warn("Crash time: %lld", crash_time);
+}
+
+static void apple_rtkit_crashlog_dump_mailbox(struct apple_rtkit *rtk, u8 *bfr,
+					      size_t size)
+{
+	u32 type, index, i;
+	size_t n_messages;
+	struct apple_rtkit_crashlog_mbox_entry entry;
+
+	memcpy(&type, bfr + 16, 4);
+	memcpy(&index, bfr + 24, 4);
+	n_messages = (size - 28) / sizeof(entry);
+
+	rtk_warn("Mailbox history (type = %d, index = %d)", type, index);
+	for (i = 0; i < n_messages; ++i) {
+		memcpy(&entry, bfr + 28 + i * sizeof(entry), sizeof(entry));
+		rtk_warn(" #%03d@%08x: %016llx %016llx", i, entry.timestamp,
+			 entry.msg0, entry.msg1);
+	}
+}
+
+void apple_rtkit_crashlog_dump(struct apple_rtkit *rtk, u8 *bfr, size_t size)
+{
+	size_t offset;
+	u32 section_fourcc, section_size;
+	struct apple_rtkit_crashlog_header header;
+
+	memcpy(&header, bfr, sizeof(header));
+	if (header.fourcc != APPLE_RTKIT_CRASHLOG_HEADER) {
+		rtk_warn("Expected crashlog header but got %x", header.fourcc);
+		return;
+	}
+
+	if (header.size > size) {
+		rtk_warn("Crashlog size (%x) is too large", header.size);
+		return;
+	}
+
+	size = header.size;
+	offset = sizeof(header);
+
+	while (offset < size) {
+		memcpy(&section_fourcc, bfr + offset, 4);
+		memcpy(&section_size, bfr + offset + 12, 4);
+
+		switch (section_fourcc) {
+		case APPLE_RTKIT_CRASHLOG_HEADER:
+			rtk_dbg("End of crashlog reached");
+			return;
+		case APPLE_RTKIT_CRASHLOG_STR:
+			apple_rtkit_crashlog_dump_str(rtk, bfr + offset + 16,
+						      section_size);
+			break;
+		case APPLE_RTKIT_CRASHLOG_VERSION:
+			apple_rtkit_crashlog_dump_version(
+				rtk, bfr + offset + 16, section_size);
+			break;
+		case APPLE_RTKIT_CRASHLOG_MBOX:
+			apple_rtkit_crashlog_dump_mailbox(
+				rtk, bfr + offset + 16, section_size);
+			break;
+		case APPLE_RTKIT_CRASHLOG_TIME:
+			apple_rtkit_crashlog_dump_time(rtk, bfr + offset + 16,
+						       section_size);
+			break;
+		default:
+			rtk_warn("Unknown crashlog section: %x",
+				 section_fourcc);
+		}
+
+		offset += section_size;
+	}
+
+	rtk_warn("End of crashlog reached but no footer present");
+}
diff --git a/drivers/soc/apple/rtkit-internal.h b/drivers/soc/apple/rtkit-internal.h
new file mode 100644
index 000000000000..6ff8b2cd2532
--- /dev/null
+++ b/drivers/soc/apple/rtkit-internal.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
+/*
+ * Apple RTKit IPC library
+ * Copyright (C) The Asahi Linux Contributors
+ */
+
+#ifndef _APPLE_RTKIT_INTERAL_H
+#define _APPLE_RTKIT_INTERAL_H
+
+#include <linux/apple-mailbox.h>
+#include <linux/bitfield.h>
+#include <linux/bitmap.h>
+#include <linux/completion.h>
+#include <linux/dma-mapping.h>
+#include <linux/io.h>
+#include <linux/kthread.h>
+#include <linux/kfifo.h>
+#include <linux/mailbox_client.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/soc/apple/rtkit.h>
+#include <linux/wait.h>
+
+#define rtk_err(format, arg...) dev_err(rtk->dev, "RTKit: " format, ##arg)
+#define rtk_warn(format, arg...) dev_warn(rtk->dev, "RTKit: " format, ##arg)
+#define rtk_info(format, arg...) dev_info(rtk->dev, "RTKit: " format, ##arg)
+#define rtk_dbg(format, arg...) dev_dbg(rtk->dev, "RTKit: " format, ##arg)
+
+
+#define APPLE_RTKIT_APP_ENDPOINT_START 0x20
+#define APPLE_RTKIT_MAX_ENDPOINTS 0x100
+
+struct apple_rtkit_work {
+	unsigned int type;
+	struct apple_mbox_msg msg;
+};
+
+struct apple_rtkit {
+	void *cookie;
+	const struct apple_rtkit_ops *ops;
+	struct device *dev;
+	struct mbox_client mbox_cl;
+	struct mbox_chan *mbox_chan;
+
+	struct completion epmap_completion;
+	struct completion reinit_completion;
+	struct completion iop_pwr_ack_completion;
+	struct completion ap_pwr_ack_completion;
+
+	int boot_result;
+	int version;
+
+	unsigned int iop_power_state;
+	unsigned int ap_power_state;
+	bool crashed;
+
+	struct task_struct *task;
+
+	struct wait_queue_head wq;
+	DECLARE_KFIFO(work_fifo, struct apple_rtkit_work, 64);
+	spinlock_t work_lock;
+
+	DECLARE_BITMAP(endpoints, APPLE_RTKIT_MAX_ENDPOINTS);
+
+	struct apple_rtkit_shmem ioreport_buffer;
+	struct apple_rtkit_shmem crashlog_buffer;
+
+	struct apple_rtkit_shmem syslog_buffer;
+	char *syslog_msg_buffer;
+	size_t syslog_n_entries;
+	size_t syslog_msg_size;
+};
+
+void apple_rtkit_crashlog_dump(struct apple_rtkit *rtk, u8 *bfr, size_t size);
+
+#endif
diff --git a/drivers/soc/apple/rtkit.c b/drivers/soc/apple/rtkit.c
new file mode 100644
index 000000000000..7a93c6a99ae9
--- /dev/null
+++ b/drivers/soc/apple/rtkit.c
@@ -0,0 +1,842 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Apple RTKit IPC library
+ * Copyright (C) The Asahi Linux Contributors
+ */
+
+//#define DEBUG
+
+#include "rtkit-internal.h"
+
+enum { APPLE_RTKIT_WORK_MSG,
+	APPLE_RTKIT_WORK_REINIT,
+};
+
+enum { APPLE_RTKIT_PWR_STATE_OFF = 0x00,
+	APPLE_RTKIT_PWR_STATE_SLEEP = 0x01,
+	APPLE_RTKIT_PWR_STATE_GATED = 0x02,
+	APPLE_RTKIT_PWR_STATE_QUIESCED = 0x10,
+	APPLE_RTKIT_PWR_STATE_ON = 0x20,
+};
+
+enum { APPLE_RTKIT_EP_MGMT = 0,
+	APPLE_RTKIT_EP_CRASHLOG = 1,
+	APPLE_RTKIT_EP_SYSLOG = 2,
+	APPLE_RTKIT_EP_DEBUG = 3,
+	APPLE_RTKIT_EP_IOREPORT = 4,
+	APPLE_RTKIT_EP_OSLOG = 8,
+};
+
+#define APPLE_RTKIT_MGMT_TYPE GENMASK(59, 52)
+
+enum { APPLE_RTKIT_MGMT_HELLO = 1,
+	APPLE_RTKIT_MGMT_HELLO_REPLY = 2,
+	APPLE_RTKIT_MGMT_STARTEP = 5,
+	APPLE_RTKIT_MGMT_SET_IOP_PWR_STATE = 6,
+	APPLE_RTKIT_MGMT_SET_IOP_PWR_STATE_ACK = 7,
+	APPLE_RTKIT_MGMT_EPMAP = 8,
+	APPLE_RTKIT_MGMT_EPMAP_REPLY = 8,
+	APPLE_RTKIT_MGMT_SET_AP_PWR_STATE = 0xb,
+	APPLE_RTKIT_MGMT_SET_AP_PWR_STATE_ACK = 0xb,
+};
+
+#define APPLE_RTKIT_MGMT_HELLO_MINVER GENMASK(15, 0)
+#define APPLE_RTKIT_MGMT_HELLO_MAXVER GENMASK(31, 16)
+
+#define APPLE_RTKIT_MGMT_EPMAP_LAST   BIT(51)
+#define APPLE_RTKIT_MGMT_EPMAP_BASE   GENMASK(34, 32)
+#define APPLE_RTKIT_MGMT_EPMAP_BITMAP GENMASK(31, 0)
+
+#define APPLE_RTKIT_MGMT_EPMAP_REPLY_MORE BIT(0)
+
+#define APPLE_RTKIT_MGMT_STARTEP_EP   GENMASK(39, 32)
+#define APPLE_RTKIT_MGMT_STARTEP_FLAG BIT(1)
+
+#define APPLE_RTKIT_MGMT_PWR_STATE GENMASK(15, 0)
+
+#define APPLE_RTKIT_CRASHLOG_CRASH 1
+
+#define APPLE_RTKIT_BUFFER_REQUEST	1
+#define APPLE_RTKIT_BUFFER_REQUEST_SIZE GENMASK(51, 44)
+#define APPLE_RTKIT_BUFFER_REQUEST_IOVA GENMASK(41, 0)
+
+#define APPLE_RTKIT_SYSLOG_TYPE GENMASK(59, 52)
+
+#define APPLE_RTKIT_SYSLOG_LOG 5
+
+#define APPLE_RTKIT_SYSLOG_INIT	     8
+#define APPLE_RTKIT_SYSLOG_N_ENTRIES GENMASK(7, 0)
+#define APPLE_RTKIT_SYSLOG_MSG_SIZE  GENMASK(31, 24)
+
+#define APPLE_RTKIT_OSLOG_TYPE GENMASK(63, 56)
+#define APPLE_RTKIT_OSLOG_INIT	1
+#define APPLE_RTKIT_OSLOG_ACK	3
+
+#define APPLE_RTKIT_MIN_SUPPORTED_VERSION 11
+#define APPLE_RTKIT_MAX_SUPPORTED_VERSION 12
+
+bool apple_rtkit_is_running(struct apple_rtkit *rtk)
+{
+	if (rtk->crashed)
+		return false;
+	if ((rtk->iop_power_state & 0xff) != APPLE_RTKIT_PWR_STATE_ON)
+		return false;
+	if ((rtk->ap_power_state & 0xff) != APPLE_RTKIT_PWR_STATE_ON)
+		return false;
+	return true;
+}
+EXPORT_SYMBOL_GPL(apple_rtkit_is_running);
+
+bool apple_rtkit_is_crashed(struct apple_rtkit *rtk)
+{
+	return rtk->crashed;
+}
+EXPORT_SYMBOL_GPL(apple_rtkit_is_crashed);
+
+static void apple_rtkit_management_send(struct apple_rtkit *rtk, u8 type,
+					u64 msg)
+{
+	msg &= ~APPLE_RTKIT_MGMT_TYPE;
+	msg |= FIELD_PREP(APPLE_RTKIT_MGMT_TYPE, type);
+	apple_rtkit_send_message(rtk, APPLE_RTKIT_EP_MGMT, msg);
+}
+
+static void apple_rtkit_management_rx_hello(struct apple_rtkit *rtk, u64 msg)
+{
+	u64 reply;
+
+	int min_ver = FIELD_GET(APPLE_RTKIT_MGMT_HELLO_MINVER, msg);
+	int max_ver = FIELD_GET(APPLE_RTKIT_MGMT_HELLO_MAXVER, msg);
+	int want_ver = min(APPLE_RTKIT_MAX_SUPPORTED_VERSION, max_ver);
+
+	rtk_dbg("Min ver %d, max ver %d\n", min_ver, max_ver);
+
+	if (min_ver > APPLE_RTKIT_MAX_SUPPORTED_VERSION) {
+		rtk_err("Firmware min version %d is too new\n", min_ver);
+		goto abort_boot;
+	}
+
+	if (max_ver < APPLE_RTKIT_MIN_SUPPORTED_VERSION) {
+		rtk_err("Firmware max version %d is too old\n", max_ver);
+		goto abort_boot;
+	}
+
+	rtk_info("Initializing (protocol version %d)\n", want_ver);
+	rtk->version = want_ver;
+
+	reply = FIELD_PREP(APPLE_RTKIT_MGMT_HELLO_MINVER, want_ver);
+	reply |= FIELD_PREP(APPLE_RTKIT_MGMT_HELLO_MAXVER, want_ver);
+	apple_rtkit_management_send(rtk, APPLE_RTKIT_MGMT_HELLO_REPLY, reply);
+
+	return;
+
+abort_boot:
+	rtk->boot_result = -EINVAL;
+	complete_all(&rtk->epmap_completion);
+}
+
+static void apple_rtkit_management_rx_epmap(struct apple_rtkit *rtk, u64 msg)
+{
+	int i, ep;
+	u64 reply;
+	unsigned long bitmap = FIELD_GET(APPLE_RTKIT_MGMT_EPMAP_BITMAP, msg);
+	u32 base = FIELD_GET(APPLE_RTKIT_MGMT_EPMAP_BASE, msg);
+
+	rtk_dbg("received endpoint bitmap 0x%lx with base 0x%x\n", bitmap,
+		base);
+
+	for_each_set_bit(i, &bitmap, 32) {
+		ep = 32 * base + i;
+		rtk_dbg("Discovered endpoint 0x%02x\n", ep);
+		set_bit(ep, rtk->endpoints);
+	}
+
+	reply = FIELD_PREP(APPLE_RTKIT_MGMT_EPMAP_BASE, base);
+	if (msg & APPLE_RTKIT_MGMT_EPMAP_LAST)
+		reply |= APPLE_RTKIT_MGMT_EPMAP_LAST;
+	else
+		reply |= APPLE_RTKIT_MGMT_EPMAP_REPLY_MORE;
+
+	apple_rtkit_management_send(rtk, APPLE_RTKIT_MGMT_EPMAP_REPLY, reply);
+
+	if (!(msg & APPLE_RTKIT_MGMT_EPMAP_LAST))
+		return;
+
+	for_each_set_bit(ep, rtk->endpoints, APPLE_RTKIT_APP_ENDPOINT_START) {
+		switch (ep) {
+		/* the management endpoint is started by default */
+		case APPLE_RTKIT_EP_MGMT:
+			break;
+
+		/* without starting these RTKit refuses to boot */
+		case APPLE_RTKIT_EP_SYSLOG:
+		case APPLE_RTKIT_EP_CRASHLOG:
+		case APPLE_RTKIT_EP_DEBUG:
+		case APPLE_RTKIT_EP_IOREPORT:
+		case APPLE_RTKIT_EP_OSLOG:
+			rtk_dbg("Starting system endpoint 0x%02x\n", ep);
+			apple_rtkit_start_ep(rtk, ep);
+			break;
+
+		default:
+			rtk_warn("Unknown system endpoint: 0x%02x\n", ep);
+		}
+	}
+
+	complete_all(&rtk->epmap_completion);
+}
+
+static void apple_rtkit_management_rx_iop_pwr_ack(struct apple_rtkit *rtk,
+						  u64 msg)
+{
+	unsigned int new_state = FIELD_GET(APPLE_RTKIT_MGMT_PWR_STATE, msg);
+
+	rtk_dbg("IOP power state transition: 0x%x -> 0x%x\n",
+		rtk->iop_power_state, new_state);
+	rtk->iop_power_state = new_state;
+
+	complete_all(&rtk->iop_pwr_ack_completion);
+}
+
+static void apple_rtkit_management_rx_ap_pwr_ack(struct apple_rtkit *rtk,
+						 u64 msg)
+{
+	unsigned int new_state = FIELD_GET(APPLE_RTKIT_MGMT_PWR_STATE, msg);
+
+	rtk_dbg("AP power state transition: 0x%x -> 0x%x\n",
+		rtk->ap_power_state, new_state);
+	rtk->ap_power_state = new_state;
+
+	complete_all(&rtk->ap_pwr_ack_completion);
+}
+
+static void apple_rtkit_management_rx(struct apple_rtkit *rtk, u64 msg)
+{
+	u8 type = FIELD_GET(APPLE_RTKIT_MGMT_TYPE, msg);
+
+	switch (type) {
+	case APPLE_RTKIT_MGMT_HELLO:
+		apple_rtkit_management_rx_hello(rtk, msg);
+		break;
+	case APPLE_RTKIT_MGMT_EPMAP:
+		apple_rtkit_management_rx_epmap(rtk, msg);
+		break;
+	case APPLE_RTKIT_MGMT_SET_IOP_PWR_STATE_ACK:
+		apple_rtkit_management_rx_iop_pwr_ack(rtk, msg);
+		break;
+	case APPLE_RTKIT_MGMT_SET_AP_PWR_STATE_ACK:
+		apple_rtkit_management_rx_ap_pwr_ack(rtk, msg);
+		break;
+	default:
+		rtk_warn("unknown management message: 0x%llx (type: 0x%02x)\n",
+			 msg, type);
+	}
+}
+
+static int apple_rtkit_common_rx_get_buffer(struct apple_rtkit *rtk,
+					    struct apple_rtkit_shmem *buffer,
+					    u8 ep, u64 msg)
+{
+	size_t n_4kpages = FIELD_GET(APPLE_RTKIT_BUFFER_REQUEST_SIZE, msg);
+	size_t size = n_4kpages << 12;
+	dma_addr_t iova = FIELD_GET(APPLE_RTKIT_BUFFER_REQUEST_IOVA, msg);
+	u64 reply;
+	int err;
+
+	rtk_dbg("buffer request for 0x%zx bytes at %pad\n", size, &iova);
+
+	if (iova && (!rtk->ops->shmem_setup || !rtk->ops->shmem_destroy))
+		return -EINVAL;
+
+	if (rtk->ops->shmem_setup) {
+		err = rtk->ops->shmem_setup(rtk->cookie, buffer, iova, size);
+		if (err < 0)
+			return err;
+	} else {
+		buffer->buffer =
+			dma_alloc_coherent(rtk->dev, size, &iova, GFP_KERNEL);
+		if (!buffer->buffer)
+			return -ENOMEM;
+
+		buffer->size = size;
+		buffer->iova = iova;
+	}
+
+	if (!buffer->is_mapped) {
+		reply = FIELD_PREP(APPLE_RTKIT_SYSLOG_TYPE,
+				   APPLE_RTKIT_BUFFER_REQUEST);
+		reply |= FIELD_PREP(APPLE_RTKIT_BUFFER_REQUEST_SIZE, n_4kpages);
+		reply |= FIELD_PREP(APPLE_RTKIT_BUFFER_REQUEST_IOVA,
+				    buffer->iova);
+		apple_rtkit_send_message(rtk, ep, reply);
+	}
+
+	return 0;
+}
+
+static void apple_rtkit_free_buffer(struct apple_rtkit *rtk,
+				    struct apple_rtkit_shmem *bfr)
+{
+	if (bfr->size == 0)
+		return;
+
+	if (rtk->ops->shmem_destroy)
+		rtk->ops->shmem_destroy(rtk->cookie, bfr);
+	else if (bfr->buffer)
+		dma_free_coherent(rtk->dev, bfr->size, bfr->buffer, bfr->iova);
+
+	bfr->buffer = NULL;
+	bfr->iomem = NULL;
+	bfr->iova = 0;
+	bfr->size = 0;
+	bfr->is_mapped = false;
+}
+
+static void apple_rtkit_memcpy(struct apple_rtkit *rtk, void *dst,
+			       struct apple_rtkit_shmem *bfr, size_t offset,
+			       size_t len)
+{
+	if (bfr->iomem)
+		memcpy_fromio(dst, bfr->iomem + offset, len);
+	else
+		memcpy(dst, bfr->buffer + offset, len);
+}
+
+static void apple_rtkit_crashlog_rx(struct apple_rtkit *rtk, u64 msg)
+{
+	u8 type = FIELD_GET(APPLE_RTKIT_SYSLOG_TYPE, msg);
+	u8 *bfr;
+
+	if (type != APPLE_RTKIT_CRASHLOG_CRASH) {
+		rtk_warn("Unknown crashlog message: %llx\n", msg);
+		return;
+	}
+
+	if (!rtk->crashlog_buffer.size) {
+		apple_rtkit_common_rx_get_buffer(rtk, &rtk->crashlog_buffer,
+						 APPLE_RTKIT_EP_CRASHLOG, msg);
+		return;
+	}
+
+	rtk_err("co-processor has crashed.\n");
+
+	/*
+	 * create a shadow copy here to make sure the co-processor isn't able
+	 * to change the log while we're dumping it. this also ensures
+	 * the buffer is in normal memory and not iomem for e.g. the SMC
+	 */
+	bfr = kzalloc(rtk->crashlog_buffer.size, GFP_KERNEL);
+	if (bfr) {
+		apple_rtkit_memcpy(rtk, bfr, &rtk->crashlog_buffer, 0,
+				   rtk->crashlog_buffer.size);
+		apple_rtkit_crashlog_dump(rtk, bfr, rtk->crashlog_buffer.size);
+		kfree(bfr);
+	} else {
+		rtk_err("Couldn't allocate crashlog shadow buffer.");
+	}
+
+	rtk->crashed = true;
+	if (rtk->ops->crashed)
+		rtk->ops->crashed(rtk->cookie);
+}
+
+static void apple_rtkit_ioreport_rx(struct apple_rtkit *rtk, u64 msg)
+{
+	u8 type = FIELD_GET(APPLE_RTKIT_SYSLOG_TYPE, msg);
+
+	switch (type) {
+	case APPLE_RTKIT_BUFFER_REQUEST:
+		apple_rtkit_common_rx_get_buffer(rtk, &rtk->ioreport_buffer,
+						 APPLE_RTKIT_EP_IOREPORT, msg);
+		break;
+	/* unknown, must be ACKed or the co-processor will hang */
+	case 0x8:
+	case 0xc:
+		apple_rtkit_send_message(rtk, APPLE_RTKIT_EP_IOREPORT, msg);
+		break;
+	default:
+		rtk_warn("Unknown ioreport message: %llx\n", msg);
+	}
+}
+
+static void apple_rtkit_syslog_rx_init(struct apple_rtkit *rtk, u64 msg)
+{
+	rtk->syslog_n_entries = FIELD_GET(APPLE_RTKIT_SYSLOG_N_ENTRIES, msg);
+	rtk->syslog_msg_size = FIELD_GET(APPLE_RTKIT_SYSLOG_MSG_SIZE, msg);
+
+	rtk->syslog_msg_buffer = kzalloc(rtk->syslog_msg_size, GFP_KERNEL);
+
+	rtk_dbg("syslog initialized: entries: %zd, msg_size: %zd\n",
+		rtk->syslog_n_entries, rtk->syslog_msg_size);
+}
+
+static void apple_rtkit_syslog_rx_log(struct apple_rtkit *rtk, u64 msg)
+{
+	u8 idx = msg & 0xff;
+	char log_context[24];
+	size_t entry_size = 0x20 + rtk->syslog_msg_size;
+
+	if (!rtk->syslog_buffer.size) {
+		rtk_warn(
+			"received syslog message but syslog_buffer.size is zero");
+		goto done;
+	}
+	if (!rtk->syslog_buffer.buffer && !rtk->syslog_buffer.iomem) {
+		rtk_warn("received syslog message but no syslog_buffer.buffer or syslog_buffer.iomem");
+		goto done;
+	}
+	if (idx > rtk->syslog_n_entries) {
+		rtk_warn("syslog index %d out of range", idx);
+		goto done;
+	}
+
+	apple_rtkit_memcpy(rtk, log_context, &rtk->syslog_buffer,
+			   idx * entry_size + 8, sizeof(log_context));
+	apple_rtkit_memcpy(rtk, rtk->syslog_msg_buffer, &rtk->syslog_buffer,
+			   idx * entry_size + 8 + sizeof(log_context),
+			   rtk->syslog_msg_size);
+
+	log_context[sizeof(log_context) - 1] = 0;
+	rtk->syslog_msg_buffer[rtk->syslog_msg_size - 1] = 0;
+	rtk_info("syslog message: %s: %s", log_context, rtk->syslog_msg_buffer);
+
+done:
+	apple_rtkit_send_message(rtk, APPLE_RTKIT_EP_SYSLOG, msg);
+}
+
+static void apple_rtkit_syslog_rx(struct apple_rtkit *rtk, u64 msg)
+{
+	u8 type = FIELD_GET(APPLE_RTKIT_SYSLOG_TYPE, msg);
+
+	switch (type) {
+	case APPLE_RTKIT_BUFFER_REQUEST:
+		apple_rtkit_common_rx_get_buffer(rtk, &rtk->syslog_buffer,
+						 APPLE_RTKIT_EP_SYSLOG, msg);
+		break;
+	case APPLE_RTKIT_SYSLOG_INIT:
+		apple_rtkit_syslog_rx_init(rtk, msg);
+		break;
+	case APPLE_RTKIT_SYSLOG_LOG:
+		apple_rtkit_syslog_rx_log(rtk, msg);
+		break;
+	default:
+		rtk_warn("Unknown syslog message: %llx\n", msg);
+	}
+}
+
+static void apple_rtkit_oslog_rx_init(struct apple_rtkit *rtk, u64 msg)
+{
+	u64 ack;
+
+	rtk_dbg("oslog init: msg: 0x%llx\n", msg);
+	ack = FIELD_PREP(APPLE_RTKIT_OSLOG_TYPE, APPLE_RTKIT_OSLOG_ACK);
+	apple_rtkit_send_message(rtk, APPLE_RTKIT_EP_OSLOG, ack);
+}
+
+static void apple_rtkit_oslog_rx(struct apple_rtkit *rtk, u64 msg)
+{
+	u8 type = FIELD_GET(APPLE_RTKIT_OSLOG_TYPE, msg);
+
+	switch (type) {
+	case APPLE_RTKIT_OSLOG_INIT:
+		apple_rtkit_oslog_rx_init(rtk, msg);
+		break;
+	default:
+		rtk_warn("Unknown oslog message: %llx\n", msg);
+	}
+}
+
+static void apple_rtkit_rx(struct apple_rtkit *rtk, struct apple_mbox_msg *msg)
+{
+	u8 ep = msg->msg1;
+
+	if (!test_bit(ep, rtk->endpoints))
+		rtk_warn("Message to undiscovered endpoint 0x%02x", ep);
+
+	switch (ep) {
+	case APPLE_RTKIT_EP_MGMT:
+		apple_rtkit_management_rx(rtk, msg->msg0);
+		break;
+	case APPLE_RTKIT_EP_CRASHLOG:
+		apple_rtkit_crashlog_rx(rtk, msg->msg0);
+		break;
+	case APPLE_RTKIT_EP_SYSLOG:
+		apple_rtkit_syslog_rx(rtk, msg->msg0);
+		break;
+	case APPLE_RTKIT_EP_IOREPORT:
+		apple_rtkit_ioreport_rx(rtk, msg->msg0);
+		break;
+	case APPLE_RTKIT_EP_OSLOG:
+		apple_rtkit_oslog_rx(rtk, msg->msg0);
+		break;
+	case APPLE_RTKIT_APP_ENDPOINT_START ... 0xff:
+		rtk->ops->recv_message(rtk->cookie, ep, msg->msg0);
+		break;
+	default:
+		rtk_warn("message to unknown endpoint %02x: %llx\n", ep,
+			 msg->msg0);
+	}
+}
+
+static void apple_rtkit_do_reinit(struct apple_rtkit *rtk)
+{
+	apple_rtkit_free_buffer(rtk, &rtk->ioreport_buffer);
+	apple_rtkit_free_buffer(rtk, &rtk->crashlog_buffer);
+	apple_rtkit_free_buffer(rtk, &rtk->syslog_buffer);
+
+	kfree(rtk->syslog_msg_buffer);
+
+	rtk->syslog_msg_buffer = NULL;
+	rtk->syslog_n_entries = 0;
+	rtk->syslog_msg_size = 0;
+
+	bitmap_zero(rtk->endpoints, APPLE_RTKIT_MAX_ENDPOINTS);
+	set_bit(APPLE_RTKIT_EP_MGMT, rtk->endpoints);
+
+	reinit_completion(&rtk->epmap_completion);
+	reinit_completion(&rtk->iop_pwr_ack_completion);
+	reinit_completion(&rtk->ap_pwr_ack_completion);
+
+	rtk->crashed = false;
+	rtk->iop_power_state = APPLE_RTKIT_PWR_STATE_OFF;
+	rtk->ap_power_state = APPLE_RTKIT_PWR_STATE_OFF;
+
+	complete_all(&rtk->reinit_completion);
+}
+
+static int apple_rtkit_worker(void *data)
+{
+	struct apple_rtkit *rtk = data;
+	struct apple_rtkit_work work;
+
+	while (!kthread_should_stop()) {
+		wait_event_interruptible(rtk->wq,
+					 kfifo_len(&rtk->work_fifo) > 0 ||
+						 kthread_should_stop());
+
+		if (kthread_should_stop())
+			break;
+
+		while (kfifo_out_spinlocked(&rtk->work_fifo, &work, 1,
+					    &rtk->work_lock) == 1) {
+			switch (work.type) {
+			case APPLE_RTKIT_WORK_MSG:
+				apple_rtkit_rx(rtk, &work.msg);
+				break;
+			case APPLE_RTKIT_WORK_REINIT:
+				apple_rtkit_do_reinit(rtk);
+				break;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static void apple_rtkit_rx_callback(struct mbox_client *cl, void *mssg)
+{
+	struct apple_rtkit *rtk = container_of(cl, struct apple_rtkit, mbox_cl);
+	struct apple_mbox_msg *msg = mssg;
+	struct apple_rtkit_work work;
+
+	dma_rmb();
+
+	memcpy(&work.msg, msg, sizeof(*msg));
+	work.type = APPLE_RTKIT_WORK_MSG;
+
+	kfifo_in_spinlocked(&rtk->work_fifo, &work, 1, &rtk->work_lock);
+	wake_up(&rtk->wq);
+}
+
+int apple_rtkit_send_message(struct apple_rtkit *rtk, u8 ep, u64 message)
+{
+	struct apple_mbox_msg msg;
+
+	if (rtk->crashed)
+		return -EINVAL;
+	if (ep >= APPLE_RTKIT_APP_ENDPOINT_START &&
+	    !apple_rtkit_is_running(rtk))
+		return -EINVAL;
+
+	msg.msg0 = (u64)message;
+	msg.msg1 = ep;
+	dma_wmb();
+
+	return mbox_send_message(rtk->mbox_chan, &msg);
+}
+EXPORT_SYMBOL_GPL(apple_rtkit_send_message);
+
+int apple_rtkit_start_ep(struct apple_rtkit *rtk, u8 endpoint)
+{
+	u64 msg;
+
+	if (!test_bit(endpoint, rtk->endpoints))
+		return -EINVAL;
+	if (endpoint >= APPLE_RTKIT_APP_ENDPOINT_START &&
+	    !apple_rtkit_is_running(rtk))
+		return -EINVAL;
+
+	msg = FIELD_PREP(APPLE_RTKIT_MGMT_STARTEP_EP, endpoint);
+	msg |= APPLE_RTKIT_MGMT_STARTEP_FLAG;
+	apple_rtkit_management_send(rtk, APPLE_RTKIT_MGMT_STARTEP, msg);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(apple_rtkit_start_ep);
+
+static int apple_rtkit_start_worker(struct apple_rtkit *rtk)
+{
+	rtk->task = kthread_run(apple_rtkit_worker, rtk, "%s-rtkit-worker",
+				dev_name(rtk->dev));
+	if (IS_ERR(rtk->task))
+		return PTR_ERR(rtk->task);
+	return 0;
+}
+
+struct apple_rtkit *apple_rtkit_init(struct device *dev, void *cookie,
+				     const char *mbox_name, int mbox_idx,
+				     const struct apple_rtkit_ops *ops)
+{
+	struct apple_rtkit *rtk;
+	int ret;
+
+	if (!ops)
+		return ERR_PTR(-EINVAL);
+
+	rtk = kzalloc(sizeof(*rtk), GFP_KERNEL);
+	if (!rtk)
+		return ERR_PTR(-ENOMEM);
+
+	rtk->dev = dev;
+	rtk->cookie = cookie;
+	rtk->ops = ops;
+
+	INIT_KFIFO(rtk->work_fifo);
+	spin_lock_init(&rtk->work_lock);
+	init_waitqueue_head(&rtk->wq);
+	init_completion(&rtk->epmap_completion);
+	init_completion(&rtk->reinit_completion);
+	init_completion(&rtk->iop_pwr_ack_completion);
+	init_completion(&rtk->ap_pwr_ack_completion);
+
+	bitmap_zero(rtk->endpoints, APPLE_RTKIT_MAX_ENDPOINTS);
+	set_bit(APPLE_RTKIT_EP_MGMT, rtk->endpoints);
+
+	ret = apple_rtkit_start_worker(rtk);
+	if (ret)
+		return ERR_PTR(ret);
+
+	rtk->mbox_cl.dev = dev;
+	rtk->mbox_cl.tx_block = true;
+	rtk->mbox_cl.knows_txdone = false;
+	rtk->mbox_cl.rx_callback = &apple_rtkit_rx_callback;
+
+	if (mbox_name)
+		rtk->mbox_chan =
+			mbox_request_channel_byname(&rtk->mbox_cl, mbox_name);
+	else
+		rtk->mbox_chan = mbox_request_channel(&rtk->mbox_cl, mbox_idx);
+
+	if (IS_ERR(rtk->mbox_chan))
+		return (struct apple_rtkit *)rtk->mbox_chan;
+
+	return rtk;
+}
+EXPORT_SYMBOL_GPL(apple_rtkit_init);
+
+static int apple_rtkit_wait_for_completion(struct completion *c)
+{
+	long t;
+
+	t = wait_for_completion_interruptible_timeout(c,
+						      msecs_to_jiffies(1000));
+	if (t == -ERESTARTSYS)
+		return t;
+	else if (t == 0)
+		return -ETIME;
+	else
+		return 0;
+}
+
+int apple_rtkit_reinit(struct apple_rtkit *rtk)
+{
+	struct apple_rtkit_work work;
+
+	reinit_completion(&rtk->reinit_completion);
+
+	work.type = APPLE_RTKIT_WORK_REINIT;
+	kfifo_in_spinlocked(&rtk->work_fifo, &work, 1, &rtk->work_lock);
+	wake_up(&rtk->wq);
+
+	return apple_rtkit_wait_for_completion(&rtk->reinit_completion);
+}
+EXPORT_SYMBOL_GPL(apple_rtkit_reinit);
+
+static int apple_rtkit_set_ap_power_state(struct apple_rtkit *rtk,
+					  unsigned int state)
+{
+	u64 msg;
+	int ret;
+
+	reinit_completion(&rtk->ap_pwr_ack_completion);
+
+	msg = FIELD_PREP(APPLE_RTKIT_MGMT_PWR_STATE, state);
+	apple_rtkit_management_send(rtk, APPLE_RTKIT_MGMT_SET_AP_PWR_STATE,
+				    msg);
+
+	ret = apple_rtkit_wait_for_completion(&rtk->ap_pwr_ack_completion);
+	if (ret)
+		return ret;
+
+	if (rtk->ap_power_state != state)
+		return -EINVAL;
+	return 0;
+}
+
+static int apple_rtkit_set_iop_power_state(struct apple_rtkit *rtk,
+					   unsigned int state)
+{
+	u64 msg;
+	int ret;
+
+	reinit_completion(&rtk->iop_pwr_ack_completion);
+
+	msg = FIELD_PREP(APPLE_RTKIT_MGMT_PWR_STATE, state);
+	apple_rtkit_management_send(rtk, APPLE_RTKIT_MGMT_SET_IOP_PWR_STATE,
+				    msg);
+
+	ret = apple_rtkit_wait_for_completion(&rtk->iop_pwr_ack_completion);
+	if (ret)
+		return ret;
+
+	if (rtk->iop_power_state != state)
+		return -EINVAL;
+	return 0;
+}
+
+int apple_rtkit_boot(struct apple_rtkit *rtk)
+{
+	int ret;
+
+	if (apple_rtkit_is_running(rtk))
+		return 0;
+	if (rtk->crashed)
+		return -EINVAL;
+
+	rtk_dbg("waiting for boot to finish\n");
+	ret = apple_rtkit_wait_for_completion(&rtk->epmap_completion);
+	if (ret)
+		return ret;
+	if (rtk->boot_result)
+		return rtk->boot_result;
+
+	rtk_dbg("waiting for IOP power state ACK\n");
+	ret = apple_rtkit_wait_for_completion(&rtk->iop_pwr_ack_completion);
+	if (ret)
+		return ret;
+
+	return apple_rtkit_set_ap_power_state(rtk, APPLE_RTKIT_PWR_STATE_ON);
+}
+EXPORT_SYMBOL_GPL(apple_rtkit_boot);
+
+int apple_rtkit_shutdown(struct apple_rtkit *rtk)
+{
+	int ret;
+
+	/* if OFF is used here the co-processor will not wake up again */
+	ret = apple_rtkit_set_ap_power_state(rtk,
+					     APPLE_RTKIT_PWR_STATE_QUIESCED);
+	if (ret)
+		return ret;
+
+	ret = apple_rtkit_set_iop_power_state(rtk, APPLE_RTKIT_PWR_STATE_SLEEP);
+	if (ret)
+		return ret;
+
+	return apple_rtkit_reinit(rtk);
+}
+EXPORT_SYMBOL_GPL(apple_rtkit_shutdown);
+
+int apple_rtkit_hibernate(struct apple_rtkit *rtk)
+{
+	int ret;
+
+	ret = apple_rtkit_set_ap_power_state(rtk,
+					     APPLE_RTKIT_PWR_STATE_QUIESCED);
+	if (ret)
+		return ret;
+
+	ret = apple_rtkit_set_iop_power_state(rtk,
+					      APPLE_RTKIT_PWR_STATE_QUIESCED);
+	if (ret)
+		return ret;
+
+	ret = apple_rtkit_reinit(rtk);
+	if (ret)
+		return ret;
+
+	// TODO: apple_rtkit_reinit resets these so we have to restore them here :/
+	rtk->iop_power_state = APPLE_RTKIT_PWR_STATE_QUIESCED;
+	rtk->ap_power_state = APPLE_RTKIT_PWR_STATE_QUIESCED;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(apple_rtkit_hibernate);
+
+int apple_rtkit_wake(struct apple_rtkit *rtk)
+{
+	u64 msg;
+
+	if (apple_rtkit_is_running(rtk))
+		return -EINVAL;
+
+	reinit_completion(&rtk->iop_pwr_ack_completion);
+
+	/*
+	 * Use open-coded apple_rtkit_set_iop_power_state since apple_rtkit_boot
+	 * will wait for the completion anyway.
+	 */
+	msg = FIELD_PREP(APPLE_RTKIT_MGMT_PWR_STATE, APPLE_RTKIT_PWR_STATE_ON);
+	apple_rtkit_management_send(rtk, APPLE_RTKIT_MGMT_SET_IOP_PWR_STATE,
+				    msg);
+
+	return apple_rtkit_boot(rtk);
+}
+EXPORT_SYMBOL_GPL(apple_rtkit_wake);
+
+void apple_rtkit_free(struct apple_rtkit *rtk)
+{
+	kthread_stop(rtk->task);
+	mbox_free_channel(rtk->mbox_chan);
+
+	apple_rtkit_free_buffer(rtk, &rtk->ioreport_buffer);
+	apple_rtkit_free_buffer(rtk, &rtk->crashlog_buffer);
+	apple_rtkit_free_buffer(rtk, &rtk->syslog_buffer);
+
+	kfree(rtk->syslog_msg_buffer);
+	kfree(rtk);
+}
+EXPORT_SYMBOL_GPL(apple_rtkit_free);
+
+struct apple_rtkit *devm_apple_rtkit_init(struct device *dev, void *cookie,
+					  const char *mbox_name, int mbox_idx,
+					  const struct apple_rtkit_ops *ops)
+{
+	struct apple_rtkit *rtk;
+	int ret;
+
+	rtk = apple_rtkit_init(dev, cookie, mbox_name, mbox_idx, ops);
+	if (IS_ERR(rtk))
+		return rtk;
+
+	ret = devm_add_action_or_reset(dev, (void (*)(void *))apple_rtkit_free,
+				       rtk);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return rtk;
+}
+EXPORT_SYMBOL_GPL(devm_apple_rtkit_init);
+
+MODULE_LICENSE("Dual MIT/GPL");
+MODULE_AUTHOR("Sven Peter <sven@svenpeter.dev>");
+MODULE_DESCRIPTION("Apple RTKit driver");
diff --git a/include/linux/soc/apple/rtkit.h b/include/linux/soc/apple/rtkit.h
new file mode 100644
index 000000000000..a1beb514fff6
--- /dev/null
+++ b/include/linux/soc/apple/rtkit.h
@@ -0,0 +1,203 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
+/*
+ * Apple RTKit IPC Library
+ * Copyright (C) The Asahi Linux Contributors
+ *
+ * Apple's SoCs come with various co-processors running their RTKit operating
+ * system. This protocol library is used by client drivers to use the
+ * features provided by them.
+ */
+#ifndef _LINUX_APPLE_RTKIT_H_
+#define _LINUX_APPLE_RTKIT_H_
+
+#include <linux/device.h>
+#include <linux/ioport.h>
+#include <linux/types.h>
+#include <linux/mailbox_client.h>
+
+/*
+ * Struct to represent implementation-specific RTKit operations.
+ *
+ * @buffer:    Shared memory buffer allocated inside normal RAM.
+ * @iomem:     Shared memory buffer controlled by the co-processors.
+ * @size:      Size of the shared memory buffer.
+ * @iova:      Device VA of shared memory buffer.
+ * @is_mapped: Shared memory buffer is managed by the co-processor.
+ */
+
+struct apple_rtkit_shmem {
+	void *buffer;
+	void __iomem *iomem;
+	size_t size;
+	dma_addr_t iova;
+	bool is_mapped;
+};
+
+/*
+ * Struct to represent implementation-specific RTKit operations.
+ *
+ * @crashed:       Called when the co-processor has crashed.
+ * @recv_message:  Function called when a message from RTKit is received
+ *                 on a non-system endpoint. Called from a worker thread.
+ * @shmem_setup:   Setup shared memory buffer. If bfr.is_iomem is true the
+ *                 buffer is managed by the co-processor and needs to be mapped.
+ *                 Otherwise the buffer is managed by Linux and needs to be
+ *                 allocated. If not specified dma_alloc_coherent is used.
+ * @shmem_destroy: Undo the shared memory buffer setup in shmem_setup. If not
+ *                 specified dma_free_coherent is used.
+ */
+struct apple_rtkit_ops {
+	void (*crashed)(void *cookie);
+	void (*recv_message)(void *cookie, u8 endpoint, u64 message);
+	int (*shmem_setup)(void *cookie, struct apple_rtkit_shmem *bfr,
+			   dma_addr_t addr, size_t len);
+	void (*shmem_destroy)(void *cookie, struct apple_rtkit_shmem *bfr);
+};
+
+struct apple_rtkit;
+
+#if IS_ENABLED(CONFIG_APPLE_RTKIT)
+
+/*
+ * Initializes the internal state required to handle RTKit. This
+ * should usually be called within _probe.
+ *
+ * @dev: Pointer to the device node this coprocessor is assocated with
+ * @cookie: opaque cookie passed to all functions defined in rtkit_ops
+ * @mbox_name: mailbox name used to communicate with the co-processor
+ * @mbox_idx: mailbox index to be used if mbox_name is NULL
+ * @ops: pointer to rtkit_ops to be used for this co-processor
+ */
+struct apple_rtkit *apple_rtkit_init(struct device *dev, void *cookie,
+				     const char *mbox_name, int mbox_idx,
+				     const struct apple_rtkit_ops *ops);
+
+/*
+ * Dev-res managed version of apple_rtkit_init.
+ */
+struct apple_rtkit *devm_apple_rtkit_init(struct device *dev, void *cookie,
+					  const char *mbox_name, int mbox_idx,
+					  const struct apple_rtkit_ops *ops);
+
+/*
+ * Free internal structures.
+ */
+void apple_rtkit_free(struct apple_rtkit *rtk);
+
+/*
+ * Reinitialize internal structures. Must only be called with the co-processor
+ * is held in reset.
+ */
+int apple_rtkit_reinit(struct apple_rtkit *rtk);
+
+/*
+ * Handle RTKit's boot process. Should be called after the CPU of the
+ * co-processor has been started.
+ */
+int apple_rtkit_boot(struct apple_rtkit *rtk);
+
+/*
+ * Hibernate the co-processor.
+ */
+int apple_rtkit_hibernate(struct apple_rtkit *rtk);
+
+/*
+ * Wake the co-processor up from hibernation mode.
+ */
+int apple_rtkit_wake(struct apple_rtkit *rtk);
+
+/*
+ * Shutdown the co-processor
+ */
+int apple_rtkit_shutdown(struct apple_rtkit *rtk);
+
+/*
+ * Checks if RTKit is running and ready to handle messages.
+ */
+bool apple_rtkit_is_running(struct apple_rtkit *rtk);
+
+/*
+ * Checks if RTKit has crashed.
+ */
+bool apple_rtkit_is_crashed(struct apple_rtkit *rtk);
+
+/*
+ * Starts an endpoint. Must be called after boot but before any messages can be
+ * sent or received from that endpoint.
+ */
+int apple_rtkit_start_ep(struct apple_rtkit *rtk, u8 endpoint);
+
+/*
+ * Send a message to the given endpoint.
+ */
+int apple_rtkit_send_message(struct apple_rtkit *rtk, u8 ep, u64 message);
+
+#else
+
+static inline struct apple_rtkit *
+apple_rtkit_init(struct device *dev, void *cookie, const char *mbox_name,
+		 int mbox_idx, const struct apple_rtkit_ops *ops)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline struct apple_rtkit *
+devm_apple_rtkit_init(struct device *dev, void *cookie, const char *mbox_name,
+		      int mbox_idx, const struct apple_rtkit_ops *ops)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline void apple_rtkit_free(struct apple_rtkit *rtk)
+{
+}
+
+static inline int apple_rtkit_reinit(struct apple_rtkit *rtk)
+{
+	return -ENODEV;
+}
+
+static inline int apple_rtkit_boot(struct apple_rtkit *rtk)
+{
+	return -ENODEV;
+}
+
+static inline int apple_rtkit_hibernate(struct apple_rtkit *rtk)
+{
+	return -ENODEV;
+}
+
+static inline int apple_rtkit_wake(struct apple_rtkit *rtk)
+{
+	return -ENODEV;
+}
+
+static inline int apple_rtkit_shutdown(struct apple_rtkit *rtk)
+{
+	return -ENODEV;
+}
+
+static inline bool apple_rtkit_is_running(struct apple_rtkit *rtk)
+{
+	return false;
+}
+
+static inline bool apple_rtkit_is_crashed(struct apple_rtkit *rtk)
+{
+	return false;
+}
+
+static inline int apple_rtkit_start_ep(struct apple_rtkit *rtk, u8 endpoint)
+{
+	return -ENODEV;
+}
+
+static inline int apple_rtkit_send_message(struct apple_rtkit *rtk, u8 ep,
+					   u64 message)
+{
+	return -ENODEV;
+}
+
+#endif /* IS_ENABLED(CONFIG_APPLE_RTKIT) */
+
+#endif /* _LINUX_APPLE_RTKIT_H_ */
-- 
2.25.1

