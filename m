Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17AC446625B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357336AbhLBLic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:38:32 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:50013 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346342AbhLBLi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:38:29 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id E22373201EDB;
        Thu,  2 Dec 2021 06:35:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 02 Dec 2021 06:35:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=0y8JtbsXVyFw0
        RGJTPJqwQvMuOVwejmh9Kq9P1lRwxQ=; b=eODUng27DWwejB7P9HVvxYeGT0+8j
        ebPEpJqGJx3oVD2ZIEiI9iOK36p41VeUDKV+fnqlpMiQq5eT6BQFu3txEXwC1buU
        Ypkj87PkBoQOGc0tBVxfC0Vak/XsuHFXjuneY7KJ2ZoAXm0AlBjrIgvGYExQv+9T
        FBM2y8lB26UrWuWLpzU43wH5ygOiCLT+2WBACXrSRx65Ot44auATm6a8CH7WAglq
        jjjl4j+WdcnlLNbxsDTr/O/yPXQkf3+TsQcQ7yISDr/KRGDo0GRqNK90adMi58lN
        nMmO5Tx0YN2Yf0+ptP59KZOZQ8Lh9r1BVJ2BskTtjxcwH0bt/F2XPDKcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=0y8JtbsXVyFw0RGJTPJqwQvMuOVwejmh9Kq9P1lRwxQ=; b=QND3Ro8D
        xOJYg+suVQIVpxhWtd3MEI9VN0R3zoKvpBMw+PIwadUh19FV2lH6iNlpX99XqeVy
        xshZSLPbB9Xw9kAvNMLIe0nLqa1jfOCSE23+w+f5C60FtOOaKXsASpK1YSBFNwiZ
        8eAbWHtzbk4MDEyCJrnU368FRfuGOPBcRH6v79BgH3BxAeKva9qu2LwdaeSiJKO+
        M9dBoxSSz44t6PIKeXiQlhNyO8G5LiI5RK31KQB0gqG4/5qeWZwlWntI5+SVpBOp
        jxg7dcTjf443Aa67I2qhqZ9/y/uqQ90kw7acaU5EdkvIHcQh/niNcA7g/q3WrOWh
        IgnZAnjgUMS37Q==
X-ME-Sender: <xms:aa-oYc-B1EhtYKeCd40rnyGseKFXBxRfOyQTiNlmpT6Kgyd4XXuc1Q>
    <xme:aa-oYUtb5WOQLf1Z0kJxcSb7pREPgtTYEpggS4wJIndQa8jbfN6VdkRmQZjiXwdGz
    ZOy6vnqhX0VlT-t0X0>
X-ME-Received: <xmr:aa-oYSCZMcMIxerzGbf2wjSEuX3CUROYLOkYiq71K68npozK2PE8JtS_9gOPcWP3t0xA6gj-JXCZr7XnsRXNTjvhfvvXyaPxLLobrbyN3OJprEo0OSIM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieehgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeevfefffeekte
    fgveegfeelheffhfeujedtjeevtefhkeevkedtjeejvddtjefhjeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrg
    hkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:aa-oYcdeFNoWqDYW4hf33TbPyDxdCJd7oSQwp-rwcG4g_No3lohPbg>
    <xmx:aa-oYRPpilWMjOj17CR8W0HEpoRmT6m7DffMleU1h70rihi5BT1FMQ>
    <xmx:aa-oYWnr9hGXWLFBtYkgi7FSLfdDaLx4rXFXbKrKR8fNPzNFKuLXdg>
    <xmx:aq-oYWq-6v8ItPZqLqn__pzf4hd6LhxKA_VK-O5yt_DKBJYoTIGTxA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Dec 2021 06:35:04 -0500 (EST)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     stefanr@s5r6.in-berlin.de
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, clemens@ladisch.de,
        alsa-devel@alsa-project.org, marcan@marcan.st
Subject: [PATCH 1/3] firewire: Add dummy read_csr/write_csr functions
Date:   Thu,  2 Dec 2021 20:34:55 +0900
Message-Id: <20211202113457.24011-2-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211202113457.24011-1-o-takashi@sakamocchi.jp>
References: <20211202113457.24011-1-o-takashi@sakamocchi.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hector Martin <marcan@marcan.st>

(Hector Martin wrote)
This fixes segfaults when a card gets yanked off of the PCIe bus while
busy, e.g. with a userspace app trying to get the cycle time:

[8638860.994310] Call Trace:
[8638860.994313]  ioctl_get_cycle_timer2+0x4f/0xd0 [firewire_core]
[8638860.994323]  fw_device_op_ioctl+0xae/0x150 [firewire_core]
[8638860.994328]  __x64_sys_ioctl+0x7d/0xb0
[8638860.994332]  do_syscall_64+0x45/0x80
[8638860.994337]  entry_SYSCALL_64_after_hwframe+0x44/0xae

(Takashi Sakamoto wrote)
As long as reading commit 20802224298c ("firewire: core: add forgotten
dummy driver methods, remove unused ones"), three functions are not
implemeted in dummy driver for reason; .read_csr, .write_csr, and
.set_config_rom.

In core of Linux FireWire subsystem, the callback of .set_config_rom is
under acquisition of mutual exclusive for local list of card. The
acquision is also done in process for removal of card, therefore it's
safe for missing implementation of .set_config_rom.

On the other hand, no lock primitive accompanies any call of .read_csr and
.write_csr. For userspace client, check of node shutdown is done in the
beginning of dispatch of ioctl request, while node shifts to shutdown
state in workqueue context enough after card shifts to dummy driver. It's
probable that these two functions are called for the dummy driver by the
code of userspace client. In-kernel unit driver has similar situation.
It's better to add implementation of the two functions for dummy driver.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-card.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/firewire/core-card.c b/drivers/firewire/core-card.c
index 54be88167c60..d994da6cf465 100644
--- a/drivers/firewire/core-card.c
+++ b/drivers/firewire/core-card.c
@@ -616,6 +616,15 @@ static struct fw_iso_context *dummy_allocate_iso_context(struct fw_card *card,
 	return ERR_PTR(-ENODEV);
 }
 
+static u32 dummy_read_csr(struct fw_card *card, int csr_offset)
+{
+	return 0;
+}
+
+static void dummy_write_csr(struct fw_card *card, int csr_offset, u32 value)
+{
+}
+
 static int dummy_start_iso(struct fw_iso_context *ctx,
 			   s32 cycle, u32 sync, u32 tags)
 {
@@ -649,6 +658,8 @@ static const struct fw_card_driver dummy_driver_template = {
 	.send_response		= dummy_send_response,
 	.cancel_packet		= dummy_cancel_packet,
 	.enable_phys_dma	= dummy_enable_phys_dma,
+	.read_csr		= dummy_read_csr,
+	.write_csr		= dummy_write_csr,
 	.allocate_iso_context	= dummy_allocate_iso_context,
 	.start_iso		= dummy_start_iso,
 	.set_iso_channels	= dummy_set_iso_channels,
-- 
2.32.0

