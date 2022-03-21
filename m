Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254CE4E2E8A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351492AbiCUQyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351475AbiCUQxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:53:51 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755FA174BA1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:52:23 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 8343E3201DA2;
        Mon, 21 Mar 2022 12:52:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 21 Mar 2022 12:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=5nQpEZL6uoaGwo
        qyCOgh7yCZkXCs5xzAO7/dEUKTT+0=; b=CAtQijKbAa1HWvg5Tpk7zi2d5FkuFF
        aLTNGI76WDQ22B00KJKLI34LbvcaU1EIdqWbga6GcEcquNCAtkIuNQnX1gkJ0CfS
        qeynsyLAicgu0w6mh4UFOfN4I+UhwfFJ6fQ/dGF4xV1lCG2CeB8L3oXexxLX3MTu
        cFsXC7a+o3WyWjek76mwkgfXU4lLpPkcRT3U4zEk+V+aYop+0oDBoyXy6oXm5Jx8
        CN75O1hNTC0zvOKD+4Gn/4VmVnzKoa+5X+2lNikK/I/AQutTfItUqs3hTJF6LRo9
        zvrtvBug2La3VEmVJbGH2BYeE0yKN2OvU+augQNt/FhqElCdFoxaAL6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=5nQpEZ
        L6uoaGwoqyCOgh7yCZkXCs5xzAO7/dEUKTT+0=; b=E9MPCUh24viES5QQonaStG
        Emdx3GaIzqVI3u1pDCc4LgmYtxl6uSuFQVewDbo4g96i/1oEtGVwFHToqzhEXq5d
        pB/oaaimaAOP6G80vau2wYTzqllX1aS2GOzf+KvyJJ+MH6EBMAy/WcSLEbgjcQyG
        KQwCWEI9v0vLJAHDRN5Xmt8yjxyttI0VX1ZRMwdKQc5loImHSCA3h3jFsQU8jyt5
        GZXH4ofkItVZUff2bF34rt21WcQheTlId9TDDPKi5GR/Z22LmeiqSEdKErISxFSk
        xmunL5eQz6XaZNcMv+1hhlXEsBa61MwIxsOKhRUfnx5OIL9ekpR6CrEMuFYIfHdQ
        ==
X-ME-Sender: <xms:RK04YiJxzI8qj4NwnBdZ-Y2IHsr8Vdot6DC_JM-rzbnaT7ugDzxC6w>
    <xme:RK04YqLT_vYLuKHsiVURFTfTRGGv7uHXKe63__Voq0yFXYMqIVN7IcNgs5pAfRyzk
    AHlCRdsGC2sjLlVJas>
X-ME-Received: <xmr:RK04YisAXKkNkTXFZe8x2mIXjr2kBGRWWWGd9FgdgGCYWtTVgF_yS_BWpL_cVmzjpAdZCuGIGiV0yl4vR7IJ_GJ5Y4GhDJtCcRnRKdDIZbWlI6oj2nj7BWaSpGPpDJY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegfedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:RK04YnYg2nr1hJNOWlPXTMUks-2H0efnzclxBsnIalOBIBQA_1qTmg>
    <xmx:RK04YpaaFcV7Of1hkB4lnLh9-nBO1iQJgu8Lgs8zvp5rt0OQMZzJ8Q>
    <xmx:RK04YjAyRGr2z10e97ukpIcBxnEyiNVKUE9o1xMWj0j_sAYE78mztg>
    <xmx:Ra04YtpSkRzBiptfuiK9vZ2u97Ex7a9999tVQBOgLCsaivNN49o85g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Mar 2022 12:52:18 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 7/9] nvme-apple: Serialize command issue
Date:   Mon, 21 Mar 2022 17:50:47 +0100
Message-Id: <20220321165049.35985-8-sven@svenpeter.dev>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

This controller shouldn't need serialization of command issue since
the SQ is replaced by a simple array and commands are issued by writing
the array index to a MMIO register.
Without serialization however sometimes commands are still executed
correctly and appear in the CQ but never trigger an interrupt.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
[sven: added our best guess why this needs to be done]
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/nvme/host/apple.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 587d6c7014a0..a4193429564e 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -292,6 +292,7 @@ static void apple_nvmmu_inval(struct apple_nvme_queue *q, unsigned int tag)
 static void apple_nvme_submit_cmd(struct apple_nvme_queue *q,
 				  struct nvme_command *cmd)
 {
+	struct apple_nvme *anv = queue_to_apple_nvme(q);
 	u32 tag = nvme_tag_from_cid(cmd->common.command_id);
 	struct apple_nvmmu_tcb *tcb = &q->tcbs[tag];
 
@@ -308,7 +309,18 @@ static void apple_nvme_submit_cmd(struct apple_nvme_queue *q,
 		tcb->dma_flags |= APPLE_ANS_TCB_DMA_FROM_DEVICE;
 
 	memcpy(&q->sqes[tag], cmd, sizeof(*cmd));
+
+	/*
+	 * This lock here doesn't make much sense at a first glace but
+	 * removing it will result in occasional missed completetion
+	 * interrupts even though the commands still appear on the CQ.
+	 * It's unclear why this happens but our best guess is that
+	 * there is a bug in the firmware triggered when a write to the
+	 * CQ and the SQ happen simultaneously.
+	 */
+	spin_lock_irq(&anv->lock);
 	writel(tag, q->sq_db);
+	spin_unlock_irq(&anv->lock);
 }
 
 /*
-- 
2.25.1

