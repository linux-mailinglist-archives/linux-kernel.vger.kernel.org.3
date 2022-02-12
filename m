Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E744D4B32AD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 03:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiBLCbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 21:31:08 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiBLCbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 21:31:03 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DB622529
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 18:30:55 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id B5CDE3201DDC;
        Fri, 11 Feb 2022 21:21:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 11 Feb 2022 21:21:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; bh=CKPMl2YxUJUh2M
        qSztvTrLvGYfWLn3bjixL4oc5KIsM=; b=OuMe0BbOfP9poZT+guPdF3YNbgMbAD
        XFni9CzYDZO2X48OyHVqnxTdCHaPrgF1hlebeubCHqah8fP5bqcDzEaHNYVfHjtG
        nQaNbcvxjgK9BPh7ZiuemIXaDeo17Teyn7pP+ny6ROEAMN+qNKL+HRaL76hX7lmx
        LPF77Wp8UBAyyFWo5v19ttYZ6qEwP42pgf++Wex0ufvfU1ibhBCbk4AwvNGZzjOd
        N+mIti5u/BM48N4Ho7HmAHvn5twBmpmPTfc9SYVXayiGAsc8+ITr+V8i62KyUfwH
        DrWUnOVZ4sFIgqvO7AiXeInqjBiBazAAsW5TkwST0vVQFX797RQr3FcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=CKPMl2
        YxUJUh2MqSztvTrLvGYfWLn3bjixL4oc5KIsM=; b=IA5Mjd75FFWv3zcsM/MRmh
        0CAzN7AHjntOcOZ3rJFSw/92j18ID2pkp7BN2WInWS0pTMkQn85gFMML5q1U8Y39
        IlbN1LA3y7dhhSrpQ9c1A+2C82m0GwTkUKn/HcwADdyLgrspyMMhPyKMy8MfO6Oe
        JLl5jhR7jQFZ1eb5ybNps8usaAg9MvXIhBazY3T5xN/lf0sVHWgPHEAlhU5kLt+z
        Js8SyXoisTLzNFtPOKNbCpnKPNIuORESZqQ5Vl2ByNOE7lrHHsq4ecdSpj8wD8GF
        odE54004y4l33YY1TNltKaU5VCbg5agkBL+GDq3/rLYR4NhAmPRzkqKqNmQslFQA
        ==
X-ME-Sender: <xms:uBkHYhwcdbx049RVM6fAKvbMoLl66-wmljv0TP35jouzjhsvE0hM0A>
    <xme:uBkHYhQ85O4NorpJYwtwoQUombVLRO8MAJfOGSuZ-qM13wjpcF6SaYqGv1caZdoa4
    Aq7OF6e0RNjAr3bcvs>
X-ME-Received: <xmr:uBkHYrXk93ZOdAhDkrCIMpI21ZX05maDJGcNpM_RJYIl11gmgNbPE0qie0zwwVn66uK-hrN-6f9SQefT13rPrUYM9K7GTVDp4KKiSnD-JOSgTclrYIO1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrieeggdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeevfefffeekte
    fgveegfeelheffhfeujedtjeevtefhkeevkedtjeejvddtjefhjeenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrg
    hkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:uBkHYjhrxnCrYHiZjU4pRcIDAlKCmCZFX6P7Arv_A7ceiacG1dApbA>
    <xmx:uBkHYjC7s-zMCk3AUQeNnB1iqXq79MJiDcdDGPJAEdwaBNDo_pe9Sg>
    <xmx:uBkHYsJv2vMd02xkdubRcgXVsRctCoeerIFep8M-WDh5VA_bIXQwxw>
    <xmx:uBkHYqNLRKWCZcKXyLRqFJPxAC1-QOA5saRuY1MU2m_KUouWJEfe5w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Feb 2022 21:21:42 -0500 (EST)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     stefanr@s5r6.in-berlin.de
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, clemens@ladisch.de,
        alsa-devel@alsa-project.org
Subject: [PATCH v2 2/3] firewire: add kernel API to access CYCLE_TIME register
Date:   Sat, 12 Feb 2022 11:21:30 +0900
Message-Id: <20220212022131.199855-3-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220212022131.199855-1-o-takashi@sakamocchi.jp>
References: <20220212022131.199855-1-o-takashi@sakamocchi.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

