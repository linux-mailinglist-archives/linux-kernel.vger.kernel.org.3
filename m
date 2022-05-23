Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44ECB530908
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 07:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbiEWF4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 01:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiEWFz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 01:55:56 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F7F1EC4B
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 22:55:54 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 2D4E65C00CB;
        Mon, 23 May 2022 01:55:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 23 May 2022 01:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        tom-fitzhenry.me.uk; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1653285352; x=1653371752; bh=tl
        oN7t7Um1VK0HgY5UzOFHkfXExj5u5VBpRfGhOZ348=; b=hHhgo+IONCuziFq5ob
        vPxaIkjTOuBIWILEBP2ecx5SqxZC7tjPA/HsrTA9TbH7TlouR9KKLH0yoQ0vcHoT
        IvSLXqTIwVuZY6ldqdlB8VpHc3Hign96h0JZUdYyCv/7PTttFDYanmJv7uWnfr+R
        tfEoTWyr9MzQGPcmmZwQsBHPcmLB6BkaRmcWrcZZVs20/uEUrw0aB4mqg6k/tg0t
        rRM+tDcgYqNWAX4lTV7g/z8TxDjjdWLq6/I+FFg7zArT61+we6p1m1vmQABhPuXZ
        hb/bMcK348MysFP8aGpeCFP1DHTqiOGNPvEx8fPPwssfb23DwMt+j+Bs9FWd9t0d
        tyNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1653285352; x=1653371752; bh=tloN7t7Um1VK0HgY5UzOFHkfXExj5u5VBpR
        fGhOZ348=; b=DAs9ltRVIiyqAlrIMpLVyfm7p950SNcoShklX8mrKyOAZsY7HgQ
        ih9uTUt/fh5pdT1MxDA/ZcSQO0peYH0/AHZwxGROYslLuehdohZyb+MBCAH9l1SG
        ZOcJJHQAL6oFAi/ORqtXWrtDW0e6h1ydc075KBaSitNk60yvTWcj2C8AOntYxJS3
        SCn1pftbfGvfInBOegNKfrQ9IoGB1DLFRVtkyltVBLJToDGluRFNPkkuP7ozLXD3
        8q5jCCGkioAWdSAQMJRof7p4mQlCGZvFjY82h0OtWnbu7z5AEUcHmdCW1I/9pnxM
        OGECEHIXaCpiTLxTbSL35RxB6PVAP9JvndQ==
X-ME-Sender: <xms:5yGLYvFYabU4aR4D94t52DS_TBypD7yQfUMV6BLEf90QodWemmJExg>
    <xme:5yGLYsWA5Sc5Wu8P6QKRIxtWL-g54zMMbJAe8hOMlR-JqJdCgqTTX7t03a49xJvYa
    T5B-7YeMA3CPSvtkA>
X-ME-Received: <xmr:5yGLYhIqZbF4K2i9oZQjvMfIQZgfgAMEQ3g187AgItWwLCC1z3oWjBsU9Zwg7tViaQHm83seJq-o8C2v2YrGF1stUNPDtx2LCbs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrieelgddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepvfhomhcuhfhi
    thiihhgvnhhrhicuoehtohhmsehtohhmqdhfihhtiihhvghnrhihrdhmvgdruhhkqeenuc
    ggtffrrghtthgvrhhnpeetieffveegleeiffegleeiffejueeuudejtddvvdehudffueeh
    ueffueelffeuffenucffohhmrghinhepghhighgruggvvhhitggvrdgtohhmpdhpihhnvg
    eigedrohhrghdpghhithhlrggsrdgtohhmpdhgihhthhhusgdrtghomhenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohhmsehtohhmqdhfih
    htiihhvghnrhihrdhmvgdruhhk
X-ME-Proxy: <xmx:5yGLYtGBWhVc2HemBFKKZeorRXEd1iVfZEfWi0818XyZJYaDZHvlTw>
    <xmx:5yGLYlXQGo-8G6DJoD_JNLYYjqB6CfuPK4tEqoOJGEvZULO9NOKISA>
    <xmx:5yGLYoOu2Upd8pOpz7zMI64qeDTZE9nsSaY1O6OLBuf9BXu1SEeOHw>
    <xmx:6CGLYut-MSj4Kipw9j9GxGwLKiMAIA-mv7dTWfjKfCrX4K5crBHFaA>
Feedback-ID: iefc945ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 May 2022 01:55:48 -0400 (EDT)
From:   Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Martijn Braam <martijn@brixit.nl>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: spi-nor: gigadevice: add support for gd25lq128e
Date:   Mon, 23 May 2022 15:55:40 +1000
Message-Id: <20220523055541.724422-1-tom@tom-fitzhenry.me.uk>
X-Mailer: git-send-email 2.36.0
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

The GD25LQ128EWIGR[0] reports an JEDEC id with a different vendor,
otherwise it seems to fit neatly in the gigadevice list.

Tested to work on the Pine64 PinePhone Pro[1].

Attribution: initial version was written by
Martijn Braam <martijn@brixit.nl> for the Pine64 vendor kernel[2].

Also in use in vendor u-boot builds[3].

0. https://www.gigadevice.com/flash-memory/gd25lq128e/
1. https://wiki.pine64.org/wiki/PinePhone_Pro
2. https://gitlab.com/pine64-org/linux/-/merge_requests/29
3. https://github.com/Tow-Boot/Tow-Boot/blob/b94838dfb8971cdeb841d3922051aaa8e108b085/boards/pine64-pinephonePro/0001-mtd-spi-nor-ids-Add-GigaDevice-GD25LQ128E-entry.patch

Signed-off-by: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
---
 drivers/mtd/spi-nor/gigadevice.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/spi-nor/gigadevice.c b/drivers/mtd/spi-nor/gigadevice.c
index 33895002eeea..871c9dee11dc 100644
--- a/drivers/mtd/spi-nor/gigadevice.c
+++ b/drivers/mtd/spi-nor/gigadevice.c
@@ -56,6 +56,10 @@ static const struct flash_info gigadevice_nor_parts[] = {
 		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
 			      SPI_NOR_QUAD_READ) },
+	{ "gd25lq128e", INFO(0x257018, 0, 64 * 1024, 256)
+		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
+			      SPI_NOR_QUAD_READ) },
 	{ "gd25q128", INFO(0xc84018, 0, 64 * 1024, 256)
 		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
-- 
2.36.0

