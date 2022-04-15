Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BAB502BBB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 16:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354398AbiDOOYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 10:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354522AbiDOOXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 10:23:47 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679B1931AA;
        Fri, 15 Apr 2022 07:21:16 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id C49D75C01E5;
        Fri, 15 Apr 2022 10:21:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 15 Apr 2022 10:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1650032475; x=
        1650118875; bh=fgKh7GTP4oA4+B64BJ7zVX8goBe5QiwaupwyA9fi7Es=; b=a
        eofQ1Z6EqyakGyRh94OxJwmF2SfLg7aBwHIaOJiAnvB9QetVRTVN6CsQ84cyYRD+
        L0+LWyG7sLfj8lQp+v/aFqNSzbwU0XnNgLTfzIBmIGx7PxG0RQfDOiAbSUWptcLS
        HzsNCIWl1XDq2FFBhov2RLsBOUQC4E/XNflXQrqJCOKGAeZVg8vDMOGBraa2gjFg
        /Of3kL7yIs2EffLnV79hkdx9C+BrRrMsGybkKs1sMLjEsnINR6Oo1AuDcKLLtqZ6
        3DGLXUN9zjAIPT9LF/lDYTMkthpk2QinY3vTu+r7chHUsrDmvAN6qYppVedgovqU
        ac2OrkUscAXN3ynCAYP6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1650032475; x=1650118875; bh=fgKh7GTP4oA4+B64BJ7zVX8goBe5Qiwaupw
        yA9fi7Es=; b=dftY2kIVJ3EnqvR0kvKPXZZKEUXYvX5Rj/BCWZyLWoI0vNnEPD0
        zZQs2P3TAoyLjx2OKc/ZTegg1lVtOV1c6ZyqmrliHudX+fIQBZjfXkAtb7WLarCC
        CAIu+a0bG5y9USI6pzehNYpIgy8Dgz99Oncd2i9nIQvne7VboElf/MEloJYMl8Kg
        Xz3RWRgMJR3RuPaYxnmMOnlCiarn5HZnmwVuor8gks3Wl8/joWNCTUfYKCSxeq+K
        ujm1Ncx+eb1qdJZ24N3VgDzEMGnUvTHS9664CPllBjlZbRcbswh6zNR1e1RuWidx
        V3bAaMp0JD9HZuntu2nzcvN/13ZdJhqbL6Q==
X-ME-Sender: <xms:W39ZYhuB7VJH-dYgvu2lllmrl6lXgMdoLkDpqxuwfrc9feW-YNzKuw>
    <xme:W39ZYqdW-GchqBr0VXHaAtCQdWC5NYUcKAxaOYtg2rnC1nckwoW5ubg5UJaKy9M72
    QYYqtsJw23bmyyrWKc>
X-ME-Received: <xmr:W39ZYkxH6w1GwRDNzuV2oZx4jfHrTt3Uen1p5zRL3TLQUxrYxMR9L5zeBvk5GYAKLgllZBXhHIMJOD1fddrVKdGSu9Sz11CYqITiRqYIaf2NV8N1Pi9WOl0JCH5Xebk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudelhedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:W39ZYoMPLzbWOFjoNg-6kDVRLgOLnE7elXzWb1JP9lKG2XjQrrmx3Q>
    <xmx:W39ZYh8RAX3jRa6xhQhfF2pauRTCAl5G9v8ZqVA1cCgDQ4zkR37tPw>
    <xmx:W39ZYoXAUFrkyW1-Xoq5HJwcKx2B_ixRtI-ZFblloCxlP8Qfou5kNg>
    <xmx:W39ZYvd2HfAx5_QYxsSaKMbo5myO2zKkZznQv0C86bMiB2KtuMntjg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Apr 2022 10:21:13 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH v2 5/6] soc: apple: Add RTKit IPC library
Date:   Fri, 15 Apr 2022 16:20:54 +0200
Message-Id: <20220415142055.30873-6-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220415142055.30873-1-sven@svenpeter.dev>
References: <20220415142055.30873-1-sven@svenpeter.dev>
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

Apple SoCs such as the M1 come with multiple embedded co-processors
running proprietary firmware. Communication with those is established
over a simple mailbox using the RTKit IPC protocol.

This cannot be implement inside the mailbox subsystem since on top
of communication over channels we also need support for starting,
hibernating and resetting these co-processors. We also need to
handle shared memory allocations differently depending on the
co-processor and don't want to split that across multiple drivers.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
v1 -> v2:
  - Replaced custom kthread with workqueue (Arnd Bergmann)
  - Fixed indentation issues and un-exported apple_rtkit_init
    (Arnd Bergmann)
  - Added explanation why this can't be easily implemented as a mailbox
    (Krzysztof Kozlowski)
  - Removed redundant shmem_setup arguments (Arnd Bergmann)
  - Removed custom rtk_{err,warn,...} macros (Arnd Bergmann)
  - Disallow using the interface without CONFIG_APPLE_RTKIT and
    make all consumers hard-depend on that (Arnd Bergmann)
  - Documented power states (Alyssa Rosenzweig)
  - Made recv_message optional
  - Added recv_message_early for clients that must handle messages
    inside atomic context
  - Changed send_message to allow calling from atomic context

 drivers/soc/apple/Kconfig          |  13 +
 drivers/soc/apple/Makefile         |   3 +
 drivers/soc/apple/rtkit-crashlog.c | 154 +++++
 drivers/soc/apple/rtkit-internal.h |  62 ++
 drivers/soc/apple/rtkit.c          | 958 +++++++++++++++++++++++++++++
 include/linux/soc/apple/rtkit.h    | 159 +++++
 6 files changed, 1349 insertions(+)
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
index 000000000000..732deed64660
--- /dev/null
+++ b/drivers/soc/apple/rtkit-crashlog.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Apple RTKit IPC library
+ * Copyright (C) The Asahi Linux Contributors
+ */
+#include "rtkit-internal.h"
+
+#define FOURCC(a, b, c, d) \
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
+			dev_warn(rtk->dev, "RTKit: Message (id=%x): %s\n", idx,
+				 ptr);
+			*newline = tmp;
+			ptr = newline + 1;
+		} else {
+			dev_warn(rtk->dev, "RTKit: Message (id=%x): %s", idx,
+				 ptr);
+			break;
+		}
+	}
+}
+
+static void apple_rtkit_crashlog_dump_version(struct apple_rtkit *rtk, u8 *bfr,
+					      size_t size)
+{
+	dev_warn(rtk->dev, "RTKit: Version: %s", bfr + 16);
+}
+
+static void apple_rtkit_crashlog_dump_time(struct apple_rtkit *rtk, u8 *bfr,
+					   size_t size)
+{
+	u64 crash_time;
+
+	memcpy(&crash_time, bfr, 8);
+	dev_warn(rtk->dev, "RTKit: Crash time: %lld", crash_time);
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
+	dev_warn(rtk->dev, "RTKit: Mailbox history (type = %d, index = %d)",
+		 type, index);
+	for (i = 0; i < n_messages; ++i) {
+		memcpy(&entry, bfr + 28 + i * sizeof(entry), sizeof(entry));
+		dev_warn(rtk->dev, "RTKit:  #%03d@%08x: %016llx %016llx", i,
+			 entry.timestamp, entry.msg0, entry.msg1);
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
+		dev_warn(rtk->dev, "RTKit: Expected crashlog header but got %x",
+			 header.fourcc);
+		return;
+	}
+
+	if (header.size > size) {
+		dev_warn(rtk->dev, "RTKit: Crashlog size (%x) is too large",
+			 header.size);
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
+			dev_dbg(rtk->dev, "RTKit: End of crashlog reached");
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
+			dev_warn(rtk->dev,
+				 "RTKit: Unknown crashlog section: %x",
+				 section_fourcc);
+		}
+
+		offset += section_size;
+	}
+
+	dev_warn(rtk->dev,
+		 "RTKit: End of crashlog reached but no footer present");
+}
diff --git a/drivers/soc/apple/rtkit-internal.h b/drivers/soc/apple/rtkit-internal.h
new file mode 100644
index 000000000000..24bd619ec5e4
--- /dev/null
+++ b/drivers/soc/apple/rtkit-internal.h
@@ -0,0 +1,62 @@
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
+#include <linux/kernel.h>
+#include <linux/mailbox_client.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/soc/apple/rtkit.h>
+#include <linux/workqueue.h>
+
+#define APPLE_RTKIT_APP_ENDPOINT_START 0x20
+#define APPLE_RTKIT_MAX_ENDPOINTS 0x100
+
+struct apple_rtkit {
+	void *cookie;
+	const struct apple_rtkit_ops *ops;
+	struct device *dev;
+
+	const char *mbox_name;
+	int mbox_idx;
+	struct mbox_client mbox_cl;
+	struct mbox_chan *mbox_chan;
+
+	struct completion epmap_completion;
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
+	DECLARE_BITMAP(endpoints, APPLE_RTKIT_MAX_ENDPOINTS);
+
+	struct apple_rtkit_shmem ioreport_buffer;
+	struct apple_rtkit_shmem crashlog_buffer;
+
+	struct apple_rtkit_shmem syslog_buffer;
+	char *syslog_msg_buffer;
+	size_t syslog_n_entries;
+	size_t syslog_msg_size;
+
+	struct workqueue_struct *wq;
+};
+
+void apple_rtkit_crashlog_dump(struct apple_rtkit *rtk, u8 *bfr, size_t size);
+
+#endif
diff --git a/drivers/soc/apple/rtkit.c b/drivers/soc/apple/rtkit.c
new file mode 100644
index 000000000000..42a1491eb25a
--- /dev/null
+++ b/drivers/soc/apple/rtkit.c
@@ -0,0 +1,958 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Apple RTKit IPC library
+ * Copyright (C) The Asahi Linux Contributors
+ */
+
+#include "rtkit-internal.h"
+
+enum {
+	APPLE_RTKIT_PWR_STATE_OFF = 0x00, /* power off, cannot be restarted */
+	APPLE_RTKIT_PWR_STATE_SLEEP = 0x01, /* sleeping, can be restarted */
+	APPLE_RTKIT_PWR_STATE_QUIESCED = 0x10, /* running but no communication */
+	APPLE_RTKIT_PWR_STATE_ON = 0x20, /* normal operating state */
+};
+
+enum {
+	APPLE_RTKIT_EP_MGMT = 0,
+	APPLE_RTKIT_EP_CRASHLOG = 1,
+	APPLE_RTKIT_EP_SYSLOG = 2,
+	APPLE_RTKIT_EP_DEBUG = 3,
+	APPLE_RTKIT_EP_IOREPORT = 4,
+	APPLE_RTKIT_EP_OSLOG = 8,
+};
+
+#define APPLE_RTKIT_MGMT_TYPE GENMASK(59, 52)
+
+enum {
+	APPLE_RTKIT_MGMT_HELLO = 1,
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
+struct apple_rtkit_msg {
+	struct completion *completion;
+	struct apple_mbox_msg mbox_msg;
+};
+
+struct apple_rtkit_rx_work {
+	struct apple_rtkit *rtk;
+	u8 ep;
+	u64 msg;
+	struct work_struct work;
+};
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
+	apple_rtkit_send_message(rtk, APPLE_RTKIT_EP_MGMT, msg, NULL, false);
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
+	dev_dbg(rtk->dev, "RTKit: Min ver %d, max ver %d\n", min_ver, max_ver);
+
+	if (min_ver > APPLE_RTKIT_MAX_SUPPORTED_VERSION) {
+		dev_err(rtk->dev, "RTKit: Firmware min version %d is too new\n",
+			min_ver);
+		goto abort_boot;
+	}
+
+	if (max_ver < APPLE_RTKIT_MIN_SUPPORTED_VERSION) {
+		dev_err(rtk->dev, "RTKit: Firmware max version %d is too old\n",
+			max_ver);
+		goto abort_boot;
+	}
+
+	dev_info(rtk->dev, "RTKit: Initializing (protocol version %d)\n",
+		 want_ver);
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
+	dev_dbg(rtk->dev,
+		"RTKit: received endpoint bitmap 0x%lx with base 0x%x\n",
+		bitmap, base);
+
+	for_each_set_bit(i, &bitmap, 32) {
+		ep = 32 * base + i;
+		dev_dbg(rtk->dev, "RTKit: Discovered endpoint 0x%02x\n", ep);
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
+			dev_dbg(rtk->dev,
+				"RTKit: Starting system endpoint 0x%02x\n", ep);
+			apple_rtkit_start_ep(rtk, ep);
+			break;
+
+		default:
+			dev_warn(rtk->dev,
+				 "RTKit: Unknown system endpoint: 0x%02x\n",
+				 ep);
+		}
+	}
+
+	rtk->boot_result = 0;
+	complete_all(&rtk->epmap_completion);
+}
+
+static void apple_rtkit_management_rx_iop_pwr_ack(struct apple_rtkit *rtk,
+						  u64 msg)
+{
+	unsigned int new_state = FIELD_GET(APPLE_RTKIT_MGMT_PWR_STATE, msg);
+
+	dev_dbg(rtk->dev, "RTKit: IOP power state transition: 0x%x -> 0x%x\n",
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
+	dev_dbg(rtk->dev, "RTKit: AP power state transition: 0x%x -> 0x%x\n",
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
+		dev_warn(
+			rtk->dev,
+			"RTKit: unknown management message: 0x%llx (type: 0x%02x)\n",
+			msg, type);
+	}
+}
+
+static int apple_rtkit_common_rx_get_buffer(struct apple_rtkit *rtk,
+					    struct apple_rtkit_shmem *buffer,
+					    u8 ep, u64 msg)
+{
+	size_t n_4kpages = FIELD_GET(APPLE_RTKIT_BUFFER_REQUEST_SIZE, msg);
+	u64 reply;
+	int err;
+
+	buffer->buffer = NULL;
+	buffer->iomem = NULL;
+	buffer->is_mapped = false;
+	buffer->iova = FIELD_GET(APPLE_RTKIT_BUFFER_REQUEST_IOVA, msg);
+	buffer->size = n_4kpages << 12;
+
+	dev_dbg(rtk->dev, "RTKit: buffer request for 0x%zx bytes at %pad\n",
+		buffer->size, &buffer->iova);
+
+	if (buffer->iova &&
+	    (!rtk->ops->shmem_setup || !rtk->ops->shmem_destroy)) {
+		err = -EINVAL;
+		goto error;
+	}
+
+	if (rtk->ops->shmem_setup) {
+		err = rtk->ops->shmem_setup(rtk->cookie, buffer);
+		if (err)
+			goto error;
+	} else {
+		buffer->buffer = dma_alloc_coherent(rtk->dev, buffer->size,
+						    &buffer->iova, GFP_KERNEL);
+		if (!buffer->buffer) {
+			err = -ENOMEM;
+			goto error;
+		}
+	}
+
+	if (!buffer->is_mapped) {
+		reply = FIELD_PREP(APPLE_RTKIT_SYSLOG_TYPE,
+				   APPLE_RTKIT_BUFFER_REQUEST);
+		reply |= FIELD_PREP(APPLE_RTKIT_BUFFER_REQUEST_SIZE, n_4kpages);
+		reply |= FIELD_PREP(APPLE_RTKIT_BUFFER_REQUEST_IOVA,
+				    buffer->iova);
+		apple_rtkit_send_message(rtk, ep, reply, NULL, false);
+	}
+
+	return 0;
+
+error:
+	buffer->buffer = NULL;
+	buffer->iomem = NULL;
+	buffer->iova = 0;
+	buffer->size = 0;
+	buffer->is_mapped = false;
+	return err;
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
+		dev_warn(rtk->dev, "RTKit: Unknown crashlog message: %llx\n",
+			 msg);
+		return;
+	}
+
+	if (!rtk->crashlog_buffer.size) {
+		apple_rtkit_common_rx_get_buffer(rtk, &rtk->crashlog_buffer,
+						 APPLE_RTKIT_EP_CRASHLOG, msg);
+		return;
+	}
+
+	dev_err(rtk->dev, "RTKit: co-processor has crashed\n");
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
+		dev_err(rtk->dev,
+			"RTKit: Couldn't allocate crashlog shadow buffer\n");
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
+		apple_rtkit_send_message(rtk, APPLE_RTKIT_EP_IOREPORT, msg,
+					 NULL, false);
+		break;
+	default:
+		dev_warn(rtk->dev, "RTKit: Unknown ioreport message: %llx\n",
+			 msg);
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
+	dev_dbg(rtk->dev,
+		"RTKit: syslog initialized: entries: %zd, msg_size: %zd\n",
+		rtk->syslog_n_entries, rtk->syslog_msg_size);
+}
+
+static void apple_rtkit_syslog_rx_log(struct apple_rtkit *rtk, u64 msg)
+{
+	u8 idx = msg & 0xff;
+	char log_context[24];
+	size_t entry_size = 0x20 + rtk->syslog_msg_size;
+
+	if (!rtk->syslog_msg_buffer) {
+		dev_warn(
+			rtk->dev,
+			"RTKit: received syslog message but no syslog_msg_buffer\n");
+		goto done;
+	}
+	if (!rtk->syslog_buffer.size) {
+		dev_warn(
+			rtk->dev,
+			"RTKit: received syslog message but syslog_buffer.size is zero\n");
+		goto done;
+	}
+	if (!rtk->syslog_buffer.buffer && !rtk->syslog_buffer.iomem) {
+		dev_warn(
+			rtk->dev,
+			"RTKit: received syslog message but no syslog_buffer.buffer or syslog_buffer.iomem\n");
+		goto done;
+	}
+	if (idx > rtk->syslog_n_entries) {
+		dev_warn(rtk->dev, "RTKit: syslog index %d out of range\n",
+			 idx);
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
+	dev_info(rtk->dev, "RTKit: syslog message: %s: %s\n", log_context,
+		 rtk->syslog_msg_buffer);
+
+done:
+	apple_rtkit_send_message(rtk, APPLE_RTKIT_EP_SYSLOG, msg, NULL, false);
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
+		dev_warn(rtk->dev, "RTKit: Unknown syslog message: %llx\n",
+			 msg);
+	}
+}
+
+static void apple_rtkit_oslog_rx_init(struct apple_rtkit *rtk, u64 msg)
+{
+	u64 ack;
+
+	dev_dbg(rtk->dev, "RTKit: oslog init: msg: 0x%llx\n", msg);
+	ack = FIELD_PREP(APPLE_RTKIT_OSLOG_TYPE, APPLE_RTKIT_OSLOG_ACK);
+	apple_rtkit_send_message(rtk, APPLE_RTKIT_EP_OSLOG, ack, NULL, false);
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
+		dev_warn(rtk->dev, "RTKit: Unknown oslog message: %llx\n", msg);
+	}
+}
+
+static void apple_rtkit_rx_work(struct work_struct *work)
+{
+	struct apple_rtkit_rx_work *rtk_work =
+		container_of(work, struct apple_rtkit_rx_work, work);
+	struct apple_rtkit *rtk = rtk_work->rtk;
+
+	switch (rtk_work->ep) {
+	case APPLE_RTKIT_EP_MGMT:
+		apple_rtkit_management_rx(rtk, rtk_work->msg);
+		break;
+	case APPLE_RTKIT_EP_CRASHLOG:
+		apple_rtkit_crashlog_rx(rtk, rtk_work->msg);
+		break;
+	case APPLE_RTKIT_EP_SYSLOG:
+		apple_rtkit_syslog_rx(rtk, rtk_work->msg);
+		break;
+	case APPLE_RTKIT_EP_IOREPORT:
+		apple_rtkit_ioreport_rx(rtk, rtk_work->msg);
+		break;
+	case APPLE_RTKIT_EP_OSLOG:
+		apple_rtkit_oslog_rx(rtk, rtk_work->msg);
+		break;
+	case APPLE_RTKIT_APP_ENDPOINT_START ... 0xff:
+		if (rtk->ops->recv_message)
+			rtk->ops->recv_message(rtk->cookie, rtk_work->ep,
+					       rtk_work->msg);
+		else
+			dev_warn(
+				rtk->dev,
+				"Received unexpected message to EP%02d: %llx\n",
+				rtk_work->ep, rtk_work->msg);
+		break;
+	default:
+		dev_warn(rtk->dev,
+			 "RTKit: message to unknown endpoint %02x: %llx\n",
+			 rtk_work->ep, rtk_work->msg);
+	}
+
+	kfree(rtk_work);
+}
+
+static void apple_rtkit_rx(struct mbox_client *cl, void *mssg)
+{
+	struct apple_rtkit *rtk = container_of(cl, struct apple_rtkit, mbox_cl);
+	struct apple_mbox_msg *msg = mssg;
+	struct apple_rtkit_rx_work *work;
+	u8 ep = msg->msg1;
+
+	/*
+	 * The message was read from a MMIO FIFO and we have to make
+	 * sure all reads from buffers sent with that message happen
+	 * afterwards.
+	 */
+	dma_rmb();
+
+	if (!test_bit(ep, rtk->endpoints))
+		dev_warn(rtk->dev,
+			 "RTKit: Message to undiscovered endpoint 0x%02x\n",
+			 ep);
+
+	if (ep >= APPLE_RTKIT_APP_ENDPOINT_START &&
+	    rtk->ops->recv_message_early &&
+	    rtk->ops->recv_message_early(rtk->cookie, ep, msg->msg0))
+		return;
+
+	work = kzalloc(sizeof(*work), GFP_ATOMIC);
+	if (!work)
+		return;
+
+	work->rtk = rtk;
+	work->ep = ep;
+	work->msg = msg->msg0;
+	INIT_WORK(&work->work, apple_rtkit_rx_work);
+	queue_work(rtk->wq, &work->work);
+}
+
+static void apple_rtkit_tx_done(struct mbox_client *cl, void *mssg, int r)
+{
+	struct apple_rtkit_msg *msg =
+		container_of(mssg, struct apple_rtkit_msg, mbox_msg);
+
+	if (r == -ETIME)
+		return;
+
+	if (msg->completion)
+		complete(msg->completion);
+	kfree(msg);
+}
+
+int apple_rtkit_send_message(struct apple_rtkit *rtk, u8 ep, u64 message,
+			     struct completion *completion, bool atomic)
+{
+	struct apple_rtkit_msg *msg;
+	int ret;
+	gfp_t flags;
+
+	if (rtk->crashed)
+		return -EINVAL;
+	if (ep >= APPLE_RTKIT_APP_ENDPOINT_START &&
+	    !apple_rtkit_is_running(rtk))
+		return -EINVAL;
+
+	if (atomic)
+		flags = GFP_ATOMIC;
+	else
+		flags = GFP_KERNEL;
+
+	msg = kzalloc(sizeof(*msg), flags);
+	if (!msg)
+		return -ENOMEM;
+
+	msg->mbox_msg.msg0 = message;
+	msg->mbox_msg.msg1 = ep;
+	msg->completion = completion;
+
+	/*
+	 * The message will be sent with a MMIO write. We need the barrier
+	 * here to ensure any previous writes to buffers are visible to the
+	 * device before that MMIO write happens.
+	 */
+	dma_wmb();
+
+	ret = mbox_send_message(rtk->mbox_chan, &msg->mbox_msg);
+	if (ret < 0) {
+		kfree(msg);
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(apple_rtkit_send_message);
+
+int apple_rtkit_send_message_wait(struct apple_rtkit *rtk, u8 ep, u64 message,
+				  unsigned long timeout, bool atomic)
+{
+	DECLARE_COMPLETION_ONSTACK(completion);
+	int ret;
+	long t;
+
+	ret = apple_rtkit_send_message(rtk, ep, message, &completion, atomic);
+	if (ret < 0)
+		return ret;
+
+	if (atomic) {
+		ret = mbox_flush(rtk->mbox_chan, timeout);
+		if (ret < 0)
+			return ret;
+
+		if (try_wait_for_completion(&completion))
+			return 0;
+
+		return -ETIME;
+	} else {
+		t = wait_for_completion_interruptible_timeout(
+			&completion, msecs_to_jiffies(timeout));
+		if (t < 0)
+			return t;
+		else if (t == 0)
+			return -ETIME;
+		return 0;
+	}
+}
+EXPORT_SYMBOL_GPL(apple_rtkit_send_message_wait);
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
+static int apple_rtkit_request_mbox_chan(struct apple_rtkit *rtk)
+{
+	if (rtk->mbox_name)
+		rtk->mbox_chan = mbox_request_channel_byname(&rtk->mbox_cl,
+							     rtk->mbox_name);
+	else
+		rtk->mbox_chan =
+			mbox_request_channel(&rtk->mbox_cl, rtk->mbox_idx);
+
+	if (IS_ERR(rtk->mbox_chan))
+		return PTR_ERR(rtk->mbox_chan);
+	return 0;
+}
+
+static struct apple_rtkit *apple_rtkit_init(struct device *dev, void *cookie,
+					    const char *mbox_name, int mbox_idx,
+					    const struct apple_rtkit_ops *ops)
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
+	init_completion(&rtk->epmap_completion);
+	init_completion(&rtk->iop_pwr_ack_completion);
+	init_completion(&rtk->ap_pwr_ack_completion);
+
+	bitmap_zero(rtk->endpoints, APPLE_RTKIT_MAX_ENDPOINTS);
+	set_bit(APPLE_RTKIT_EP_MGMT, rtk->endpoints);
+
+	rtk->mbox_name = mbox_name;
+	rtk->mbox_idx = mbox_idx;
+	rtk->mbox_cl.dev = dev;
+	rtk->mbox_cl.tx_block = false;
+	rtk->mbox_cl.knows_txdone = false;
+	rtk->mbox_cl.rx_callback = &apple_rtkit_rx;
+	rtk->mbox_cl.tx_done = &apple_rtkit_tx_done;
+
+	rtk->wq = alloc_ordered_workqueue("rtkit-%s", WQ_MEM_RECLAIM,
+					  dev_name(rtk->dev));
+	if (!rtk->wq) {
+		ret = -ENOMEM;
+		goto free_rtk;
+	}
+
+	ret = apple_rtkit_request_mbox_chan(rtk);
+	if (ret)
+		goto destroy_wq;
+
+	return rtk;
+
+destroy_wq:
+	destroy_workqueue(rtk->wq);
+free_rtk:
+	kfree(rtk);
+	return ERR_PTR(ret);
+}
+
+static int apple_rtkit_wait_for_completion(struct completion *c)
+{
+	long t;
+
+	t = wait_for_completion_interruptible_timeout(c,
+						      msecs_to_jiffies(1000));
+	if (t < 0)
+		return t;
+	else if (t == 0)
+		return -ETIME;
+	else
+		return 0;
+}
+
+int apple_rtkit_reinit(struct apple_rtkit *rtk)
+{
+	/* make sure we don't handle any messages while reinitializing */
+	mbox_free_channel(rtk->mbox_chan);
+	flush_workqueue(rtk->wq);
+
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
+	return apple_rtkit_request_mbox_chan(rtk);
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
+	dev_dbg(rtk->dev, "RTKit: waiting for boot to finish\n");
+	ret = apple_rtkit_wait_for_completion(&rtk->epmap_completion);
+	if (ret)
+		return ret;
+	if (rtk->boot_result)
+		return rtk->boot_result;
+
+	dev_dbg(rtk->dev, "RTKit: waiting for IOP power state ACK\n");
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
+int apple_rtkit_quiesce(struct apple_rtkit *rtk)
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
+	rtk->iop_power_state = APPLE_RTKIT_PWR_STATE_QUIESCED;
+	rtk->ap_power_state = APPLE_RTKIT_PWR_STATE_QUIESCED;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(apple_rtkit_quiesce);
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
+static void apple_rtkit_free(struct apple_rtkit *rtk)
+{
+	mbox_free_channel(rtk->mbox_chan);
+	destroy_workqueue(rtk->wq);
+
+	apple_rtkit_free_buffer(rtk, &rtk->ioreport_buffer);
+	apple_rtkit_free_buffer(rtk, &rtk->crashlog_buffer);
+	apple_rtkit_free_buffer(rtk, &rtk->syslog_buffer);
+
+	kfree(rtk->syslog_msg_buffer);
+	kfree(rtk);
+}
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
index 000000000000..17e8c4813f42
--- /dev/null
+++ b/include/linux/soc/apple/rtkit.h
@@ -0,0 +1,159 @@
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
+#include <linux/types.h>
+#include <linux/mailbox_client.h>
+
+#if IS_ENABLED(CONFIG_APPLE_RTKIT)
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
+ * @crashed:       Called when the co-processor has crashed. Runs in process
+ *                 context.
+ * @recv_message:  Function called when a message from RTKit is received
+ *                 on a non-system endpoint. Called from a worker thread.
+ * @recv_message_early:
+ *                 Like recv_message, but called from atomic context. It
+ *                 should return true if it handled the message. If it
+ *                 returns false, the message will be passed on to the
+ *                 worker thread.
+ * @shmem_setup:   Setup shared memory buffer. If bfr.is_iomem is true the
+ *                 buffer is managed by the co-processor and needs to be mapped.
+ *                 Otherwise the buffer is managed by Linux and needs to be
+ *                 allocated. If not specified dma_alloc_coherent is used.
+ *                 Called in process context.
+ * @shmem_destroy: Undo the shared memory buffer setup in shmem_setup. If not
+ *                 specified dma_free_coherent is used. Called in process
+ *                 context.
+ */
+struct apple_rtkit_ops {
+	void (*crashed)(void *cookie);
+	void (*recv_message)(void *cookie, u8 endpoint, u64 message);
+	bool (*recv_message_early)(void *cookie, u8 endpoint, u64 message);
+	int (*shmem_setup)(void *cookie, struct apple_rtkit_shmem *bfr);
+	void (*shmem_destroy)(void *cookie, struct apple_rtkit_shmem *bfr);
+};
+
+struct apple_rtkit;
+
+/*
+ * Initializes the internal state required to handle RTKit. This
+ * should usually be called within _probe.
+ *
+ * @dev:         Pointer to the device node this coprocessor is assocated with
+ * @cookie:      opaque cookie passed to all functions defined in rtkit_ops
+ * @mbox_name:   mailbox name used to communicate with the co-processor
+ * @mbox_idx:    mailbox index to be used if mbox_name is NULL
+ * @ops:         pointer to rtkit_ops to be used for this co-processor
+ */
+struct apple_rtkit *devm_apple_rtkit_init(struct device *dev, void *cookie,
+					  const char *mbox_name, int mbox_idx,
+					  const struct apple_rtkit_ops *ops);
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
+ * Quiesce the co-processor.
+ */
+int apple_rtkit_quiesce(struct apple_rtkit *rtk);
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
+ *
+ * @rtk:            RTKit reference
+ * @ep:             target endpoint
+ * @message:        message to be sent
+ * @completeion:    will be completed once the message has been submitted
+ *                  to the hardware FIFO. Can be NULL.
+ * @atomic:         if set to true this function can be called from atomic
+ *                  context.
+ */
+int apple_rtkit_send_message(struct apple_rtkit *rtk, u8 ep, u64 message,
+			     struct completion *completion, bool atomic);
+
+/*
+ * Send a message to the given endpoint and wait until it has been submitted
+ * to the hardware FIFO.
+ * Will return zero on success and a negative error code on failure
+ * (e.g. -ETIME when the message couldn't be written within the given
+ * timeout)
+ *
+ * @rtk:            RTKit reference
+ * @ep:             target endpoint
+ * @message:        message to be sent
+ * @timeout:        timeout in milliseconds to allow the message transmission
+ *                  to be completed
+ * @atomic:         if set to true this function can be called from atomic
+ *                  context.
+ */
+int apple_rtkit_send_message_wait(struct apple_rtkit *rtk, u8 ep, u64 message,
+				  unsigned long timeout, bool atomic);
+
+#endif /* IS_ENABLED(CONFIG_APPLE_RTKIT) */
+
+#endif /* _LINUX_APPLE_RTKIT_H_ */
-- 
2.25.1

