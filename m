Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516EF4B32AB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 03:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiBLCbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 21:31:11 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiBLCbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 21:31:03 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B789722528
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 18:30:55 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 6B5353201DBF;
        Fri, 11 Feb 2022 21:21:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 11 Feb 2022 21:21:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; bh=IERouoOAZT+69o
        dSGZES8xOT3FLde6UiHl1oXWy+mRQ=; b=eyyJmmKSjgIH15wxeePanwMPcsB9JE
        UyYy6JS7gpri7o+4dwyS+E+P8itcmD7DF2lIDg3pFIT/JGm4Wi0Thagxsy+QJL9y
        2EAtCTO27wnBpHby3Wa3OAP63KKhuR3K/UcyqJ90YKx2+/9xg1itN+jUK4VGQ4Gk
        zGD5EGxhyWALNrrYYME18Hp9IgyC29JmG4ZT4qGw5Q+B4K3DIe5P8x1U8lZfBTGy
        7aVPuPuctkYusTLBRhwdS+qMN8jIVRA/RUAcNkjCK1zWpIitV7YrSvD1GHDlo/XV
        jeEmvW9HdH3ecG2+QbBTUh52rorLvCThukwb99v0wFWc3A+OuW7LciOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=IERouo
        OAZT+69odSGZES8xOT3FLde6UiHl1oXWy+mRQ=; b=IMWpl2DjkcwCiIiQDfj/8J
        sq9kUaYeSy/4hHZjR/Fsu3DlrIAG+NteM3IzQRzR6QQIaGV0wyL3wDnCuTNY51za
        Y6XL8BPHPu0fBOwT0DScH3+t6kLIpI4IewtBBdinetxIO0KHRML5imQmEXJUPrR4
        H4PULL4vaCE3ptJvsw/4oNmeHvYl1PyR4EvzTn/sEFPsONtkZVaPezTneIl5rxfZ
        Hn+V9E4557T6dmM8tCmzRFYcoM1NZk8R0pnW7xFPd7TqigxX6NQnnHRo2RJ14YQg
        hPBkbDoef3CaLsHhZZ1nBFLYhAYGOJWNCk82XBIAno6ScqStFWDM6lbkTczX7BRQ
        ==
X-ME-Sender: <xms:uhkHYlYE9FpdbJgbz7cJlFCRYn7Z_F7FyoDx7uRtmnygPHs3dw9HEw>
    <xme:uhkHYsY4CdH2hhft8dFU1hLhEGopzqBCS2o2rarznnj0VRkwg6l2DWfLp-k50bHoQ
    Z5ovOdN8OCO8TjkEPo>
X-ME-Received: <xmr:uhkHYn9o10sjS-2UXXDCOrhdk4Cilsn5ZgPqu_7I3q2RskUjNShZr5UHjdQstG0CagpRLCYVgXQ3IFl1ILlM-WVTrugRo2vvyvibW9ExxYutxuFGPhGt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrieeggdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeevfefffeekte
    fgveegfeelheffhfeujedtjeevtefhkeevkedtjeejvddtjefhjeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrg
    hkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:uhkHYjoEkY4C-CQ-95t-rR8yEIIHCimAIpA5Us2gh64J39KYR8MAVQ>
    <xmx:uhkHYgqtRmvuTA1gY006wcF3DhVY4ec2liSDSbU0lxw-9LG-XIzvbQ>
    <xmx:uhkHYpRFrd7t1kP_Do4rxf-ONSaGCaOyy2FjHxtzrWmR9Q--8HIA5Q>
    <xmx:uxkHYrVJmTKaAi7G0XyEWBen6dCaAXDSf9J8D1qZPCLbcy5A1oHArw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Feb 2022 21:21:45 -0500 (EST)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     stefanr@s5r6.in-berlin.de
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, clemens@ladisch.de,
        alsa-devel@alsa-project.org
Subject: [PATCH v2 3/3] firewire: add kernel API to access packet structure in request structure for AR context
Date:   Sat, 12 Feb 2022 11:21:31 +0900
Message-Id: <20220212022131.199855-4-o-takashi@sakamocchi.jp>
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

In 1394 OHCI specification, descriptor of Asynchronous Receive DMA context
has timeStamp field in its trailer quadlet. The field is written by
the host controller for the time to receive asynchronous request
subaction in isochronous cycle time.

In Linux FireWire subsystem, the value of field is stored to fw_packet
structure and copied to fw_request structure as the part. The fw_request
structure is hidden from unit driver and passed as opaque pointer when
calling registered handler. It's inconvenient to the unit driver which
needs timestamp of packet.

This commit adds kernel API to pick up timestamp from opaque pointer to
fw_request structure.
---
 drivers/firewire/core-transaction.c | 18 ++++++++++++++++++
 include/linux/firewire.h            |  1 +
 2 files changed, 19 insertions(+)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index ac487c96bb71..e12a0a4c33f7 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -619,6 +619,7 @@ struct fw_request {
 	struct fw_packet response;
 	u32 request_header[4];
 	int ack;
+	u32 timestamp;
 	u32 length;
 	u32 data[];
 };
@@ -788,6 +789,7 @@ static struct fw_request *allocate_request(struct fw_card *card,
 	request->response.ack = 0;
 	request->response.callback = free_response_callback;
 	request->ack = p->ack;
+	request->timestamp = p->timestamp;
 	request->length = length;
 	if (data)
 		memcpy(request->data, data, length);
@@ -832,6 +834,22 @@ int fw_get_request_speed(struct fw_request *request)
 }
 EXPORT_SYMBOL(fw_get_request_speed);
 
+/**
+ * fw_request_get_timestamp: Get timestamp of the request.
+ * @request: The opaque pointer to request structure.
+ *
+ * Get timestamp when 1394 OHCI controller receives the asynchronous request subaction. The
+ * timestamp consists of the low order 3 bits of second field and the full 13 bits of count
+ * field of isochronous cycle time register.
+ *
+ * Returns: timestamp of the request.
+ */
+u32 fw_request_get_timestamp(const struct fw_request *request)
+{
+	return request->timestamp;
+}
+EXPORT_SYMBOL_GPL(fw_request_get_timestamp);
+
 static void handle_exclusive_region_request(struct fw_card *card,
 					    struct fw_packet *p,
 					    struct fw_request *request,
diff --git a/include/linux/firewire.h b/include/linux/firewire.h
index 2f467c52bdec..980019053e54 100644
--- a/include/linux/firewire.h
+++ b/include/linux/firewire.h
@@ -354,6 +354,7 @@ void fw_core_remove_address_handler(struct fw_address_handler *handler);
 void fw_send_response(struct fw_card *card,
 		      struct fw_request *request, int rcode);
 int fw_get_request_speed(struct fw_request *request);
+u32 fw_request_get_timestamp(const struct fw_request *request);
 void fw_send_request(struct fw_card *card, struct fw_transaction *t,
 		     int tcode, int destination_id, int generation, int speed,
 		     unsigned long long offset, void *payload, size_t length,
-- 
2.32.0

