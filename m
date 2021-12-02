Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6124546625C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357359AbhLBLih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:38:37 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:59357 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357349AbhLBLie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:38:34 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id DCB5E3200FA9;
        Thu,  2 Dec 2021 06:35:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 02 Dec 2021 06:35:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=dSfEsYJV8YT9G
        1mY+w+3xNKGP/jLbaYvgOYk7MgI61U=; b=LFxFkEKNZPPy+UrCGmddyYj4Yfucl
        1oH7uT0osUDuvU/E00EgKYNj6kciaOeNHK0sPoQkiGzjyV//d7nz/L6O1K0VYKdR
        emRZFjNvQL4KzUtZfb7prMMX4KVAaRYd4lShb14vg6aCJORHFABKCQ5sy73hcpez
        tYwpYkhrj3qGnipxLtjQ9pUmJRnfalPRlUVoImGefW6fn+QJedL+Nzm1eRr79wff
        C4EXTliiOhtvzbxg7VCvE4unKaSnPo0GkgsUQLMg28CQrjiNKDqH3RGSGz/SX9L/
        DDh7MGQr7ChMmFrLAIcZ6oIqc4hDivRYqRmV3vFYXYp8MAlXCJXsIaauQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=dSfEsYJV8YT9G1mY+w+3xNKGP/jLbaYvgOYk7MgI61U=; b=H2MbYVzw
        irJUbwSjyntpffnMwaKAhWbZLmAJM9P2j1/X8ffK3OFzfVFcqI60Nx/elApANE0F
        KYyABJ10LaVIyfwaF4nr5mym3uo5aqthfg8Qw/04rsUq7I68ysKfFpnlG0eNtTW1
        KGRxcj3eElEjswcHNtVNaTZibrhnC1/g4zOguiIqiVYXY0u2fE2lzCD8KfpUZRJJ
        Khy0U+yroKjaDIRn/VbzTaQ3WNEplHQ6nIoEYgDYU3yIDd/GycoWTC+LP3gujDsb
        tpTpKl0Pr6L9goCN7OANEQGvyHAAo1k+U0nvg3YbRcgjFr3SAJ/EAvIDdzxN2svS
        baPASCXp3ObzJQ==
X-ME-Sender: <xms:ba-oYRak8gf3eXySuD9cs_VPsw-Uqd7Uq52YDfiuXAkH0yFJFcyLLg>
    <xme:ba-oYYa9-QE6Njg288f7ZFU9KI991sqplxWUP-aEgQkrRomxXjAXV5qnmQ55w2DIq
    G37SCkHREI3f6W4c7Q>
X-ME-Received: <xmr:ba-oYT9uhBrxHQI1sZwxZBpnG7iQJhX_7dkse6B6ApFMmpIGYkHH0aUqkV-Ibx509pArNeRDzWK9HXoFQqCuaiX2rHKGrVPWj6rjzIrIX-0B5IXBl1Za>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieehgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeevfefffeekte
    fgveegfeelheffhfeujedtjeevtefhkeevkedtjeejvddtjefhjeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrg
    hkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:ba-oYfr2Zs5YtpPUkhIBk7ZYc8SkZC8TK_LK6d9QY4cTu8v-3Db4_A>
    <xmx:ba-oYcqIdxoG6zr71RvtaSngB9ODpJ_6-QPBxgqASazlyznsJ8ZcCg>
    <xmx:ba-oYVRW6XAwzkY4EDvHZc1Yq2V7uOO4oK6PMf2PPAlrcinPZavezQ>
    <xmx:bq-oYVm5tmqEg5yQkleF8KR29dWlvgSdXyFaMz6NC5f9kYWO_AjJmQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Dec 2021 06:35:08 -0500 (EST)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     stefanr@s5r6.in-berlin.de
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, clemens@ladisch.de,
        alsa-devel@alsa-project.org, marcan@marcan.st
Subject: [PATCH 2/3] firewire: add kernel API to access CYCLE_TIME register
Date:   Thu,  2 Dec 2021 20:34:56 +0900
Message-Id: <20211202113457.24011-3-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211202113457.24011-1-o-takashi@sakamocchi.jp>
References: <20211202113457.24011-1-o-takashi@sakamocchi.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1394 OHCI specification defined Isochronous Cycle Timer Register to get
value of CYCLE_TIME register defined by IEEE 1394 for CSR architecture
defined by ISO/IEC 13213. Unit driver can calculate packet time by
compute with the value of CYCLE_TIME and timeStamp field in descriptor
of each isochronous and asynchronous context. The resolution of CYCLE_TIME
is 49.576 MHz, while the one of timeStamp is 8,000 Hz.

Current implementation of Linux FireWire subsystem allows the driver to
get the value of CYCLE_TIMER CSR register by transaction service. The
transaction service has overhead in regard of access to MMIO register.

This commit adds kernel API for unit driver to access the register
directly.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-card.c | 28 ++++++++++++++++++++++++++++
 drivers/firewire/core-cdev.c |  6 ++++--
 include/linux/firewire.h     |  2 ++
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/firewire/core-card.c b/drivers/firewire/core-card.c
index d994da6cf465..cd09de61bc4f 100644
--- a/drivers/firewire/core-card.c
+++ b/drivers/firewire/core-card.c
@@ -702,3 +702,31 @@ void fw_core_remove_card(struct fw_card *card)
 	WARN_ON(!list_empty(&card->transaction_list));
 }
 EXPORT_SYMBOL(fw_core_remove_card);
+
+/**
+ * fw_card_read_cycle_time: read from Isochronous Cycle Timer Register of 1394 OHCI in MMIO region
+ *			    for controller card.
+ * @card: The instance of card for 1394 OHCI controller.
+ * @cycle_time: The mutual reference to value of cycle time for the read operation.
+ *
+ * Read value from Isochronous Cycle Timer Register of 1394 OHCI in MMIO region for the given
+ * controller card. This function accesses the region without any lock primitives or IRQ mask.
+ * When returning successfully, the content of @value argument has value aligned to host endianness,
+ * formetted by CYCLE_TIME CSR Register of IEEE 1394 std.
+ *
+ * Context: Any context.
+ * Return:
+ * * 0 - Read successfully.
+ * * -ENODEV - The controller is unavailable due to being removed or unbound.
+ */
+int fw_card_read_cycle_time(struct fw_card *card, u32 *cycle_time)
+{
+	if (card->driver->read_csr == dummy_read_csr)
+		return -ENODEV;
+
+	// It's possible to switch to dummy driver between the above and the below. This is the best
+	// effort to return -ENODEV.
+	*cycle_time = card->driver->read_csr(card, CSR_CYCLE_TIME);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fw_card_read_cycle_time);
diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index 9f89c17730b1..8e9670036e5c 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -1216,7 +1216,9 @@ static int ioctl_get_cycle_timer2(struct client *client, union ioctl_arg *arg)
 
 	local_irq_disable();
 
-	cycle_time = card->driver->read_csr(card, CSR_CYCLE_TIME);
+	ret = fw_card_read_cycle_time(card, &cycle_time);
+	if (ret < 0)
+		goto end;
 
 	switch (a->clk_id) {
 	case CLOCK_REALTIME:      ktime_get_real_ts64(&ts);	break;
@@ -1225,7 +1227,7 @@ static int ioctl_get_cycle_timer2(struct client *client, union ioctl_arg *arg)
 	default:
 		ret = -EINVAL;
 	}
-
+end:
 	local_irq_enable();
 
 	a->tv_sec      = ts.tv_sec;
diff --git a/include/linux/firewire.h b/include/linux/firewire.h
index 07967a450eaa..2f467c52bdec 100644
--- a/include/linux/firewire.h
+++ b/include/linux/firewire.h
@@ -150,6 +150,8 @@ static inline void fw_card_put(struct fw_card *card)
 	kref_put(&card->kref, fw_card_release);
 }
 
+int fw_card_read_cycle_time(struct fw_card *card, u32 *cycle_time);
+
 struct fw_attribute_group {
 	struct attribute_group *groups[2];
 	struct attribute_group group;
-- 
2.32.0

