Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A8A4C51AB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 23:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238740AbiBYWlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 17:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbiBYWlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 17:41:15 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8946204281
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 14:40:39 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id h17so392909plc.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 14:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=LN5HwDIZ+3LUm5kG7dgd32Ez9v++QZy+tfNeqMDGJv8=;
        b=eUAu0Se28SlrSFg8qZHvkx8k91SRUHyCzorXCuOcUwlJhshPRxT864BLWtJCwINnbK
         xsJjzGaaUPmcqAHW3XD2cMIfFrBQfhyr2vyLdl/7uq+JGLm3YklMnF2qhBcrqdPgmfUt
         asChdmTuOxil5utgpZl/n7V5q5v9hZO4srpXJccXi6hox8k6uz7agqihCu5AnFuZNBid
         hPsQpxNiz4gOP6TlG3UpQeEMUEV66rjoytIE0Hky4FeovnHdKII5Fph+5TMJuqy+6Hzo
         MjeA4pvLN41CR4hZjJZj6LJlMrepZgvkIkCtDfxiQNPYVMRsW2L5/UVYpE7MzATLSvbs
         dPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=LN5HwDIZ+3LUm5kG7dgd32Ez9v++QZy+tfNeqMDGJv8=;
        b=J0xqEhC7B4bLf5YyApigtmhPXO4vIQoCJLrv0s20P0WAgAmBpm/CZcVsfPELjYxAuD
         flAeA55A5FtGFT7lRdYjl5LjWaDwS03xDAFN0hKgzTbbUlfESdZbHwTIvIlLEnfQmLp1
         3JgApFG7CARooymWNKL8ujE6fVstBLGQ4mQ+Bcn4sps4K3vWupPCMlWvyx7fqTXadwfo
         KIbSuLM44MuKi84eMBxJKQxCCaekqRopRBel0NeyurXZ5DDD3W3IXF1IzJEIzXw9VHm9
         ya9vm3QveCF07JgX1xpOXmNvAMfSpZBUY622T3Yio5e08vc8StY61eDNO0VakCiBQJ5h
         R0Ow==
X-Gm-Message-State: AOAM532nSiobwfFyxXRX+aRIJ5K/tOl40UtWzfxNtIsWVdEoTiNNg4wr
        lOOtjx9RHaq/DoH1c9SRTOM=
X-Google-Smtp-Source: ABdhPJw5Y9CFyi/4pWhgSzyLVP+DPz23Hd14KRbb8GxfQZziRCkmSIljFjCInHsFxQ3G/jaqcK+cxw==
X-Received: by 2002:a17:902:7002:b0:14d:76b9:2303 with SMTP id y2-20020a170902700200b0014d76b92303mr9727691plk.155.1645828839252;
        Fri, 25 Feb 2022 14:40:39 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id t5-20020a654b85000000b00373cbfbf965sm3684551pgq.46.2022.02.25.14.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 14:40:38 -0800 (PST)
Date:   Sat, 26 Feb 2022 11:40:33 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com,
        realwakka@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: pi433: remove rf69_get_flag function resolving enum
 conflict
Message-ID: <Yhla4a1Clpguoo2h@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reason why rf69_get_flag() existed was to provide a high-level way
to obtain values out of 1 (of 2) flags registers using bit masking. The
idea was to map the possible flag values found in the data sheet like
shown in page 70 of the RFM69HCW datasheet.

However, due to the fact that enums values in C must be unique, there
was a naming conflict on 'fifo_not_empty' which is used by the
tx_start_condition enum. So the author decided to create a 'fifo_empty'
one which would negate the value that comes from the flag register as
the solution to that conflict (which is very confusing).

this patch removes rf69_get_flag function which subsequently solves the
enum redeclaration problem so kernel developers can follow the data
sheet more easily.

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
 drivers/staging/pi433/pi433_if.c  |  8 +++---
 drivers/staging/pi433/rf69.c      | 44 -------------------------------
 drivers/staging/pi433/rf69.h      |  1 -
 drivers/staging/pi433/rf69_enum.h | 20 --------------
 4 files changed, 4 insertions(+), 69 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 069255f023c8..3f3e863e6cc8 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -434,7 +434,7 @@ static int pi433_receive(void *data)
 		return retval;
 
 	/* now check RSSI, if low wait for getting high (RSSI interrupt) */
-	while (!rf69_get_flag(dev->spi, rssi_exceeded_threshold)) {
+	while (!(rf69_read_reg(spi, REG_IRQFLAGS1) & MASK_IRQFLAGS1_RSSI)) {
 		/* allow tx to interrupt us while waiting for high RSSI */
 		dev->interrupt_rx_allowed = true;
 		wake_up_interruptible(&dev->tx_wait_queue);
@@ -442,8 +442,8 @@ static int pi433_receive(void *data)
 		/* wait for RSSI level to become high */
 		dev_dbg(dev->dev, "rx: going to wait for high RSSI level\n");
 		retval = wait_event_interruptible(dev->rx_wait_queue,
-						  rf69_get_flag(dev->spi,
-								rssi_exceeded_threshold));
+						  rf69_read_reg(spi, REG_IRQFLAGS1)
+						  & MASK_IRQFLAGS1_RSSI);
 		if (retval) /* wait was interrupted */
 			goto abort;
 		dev->interrupt_rx_allowed = false;
@@ -510,7 +510,7 @@ static int pi433_receive(void *data)
 
 	/* get payload */
 	while (dev->rx_position < bytes_total) {
-		if (!rf69_get_flag(dev->spi, payload_ready)) {
+		if (!(rf69_read_reg(spi, REG_IRQFLAGS2) & MASK_IRQFLAGS2_PAYLOAD_READY)) {
 			retval = wait_event_interruptible(dev->fifo_wait_queue,
 							  dev->free_in_fifo < FIFO_SIZE);
 			if (retval) /* wait was interrupted */
diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index 1a0081ebf63c..e5b23ab39c69 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -578,50 +578,6 @@ int rf69_set_dio_mapping(struct spi_device *spi, u8 dio_number, u8 value)
 	return rf69_write_reg(spi, dio_addr, dio_value);
 }
 
-bool rf69_get_flag(struct spi_device *spi, enum flag flag)
-{
-	switch (flag) {
-	case mode_switch_completed:
-		return (rf69_read_reg(spi, REG_IRQFLAGS1) & MASK_IRQFLAGS1_MODE_READY);
-	case ready_to_receive:
-		return (rf69_read_reg(spi, REG_IRQFLAGS1) & MASK_IRQFLAGS1_RX_READY);
-	case ready_to_send:
-		return (rf69_read_reg(spi, REG_IRQFLAGS1) & MASK_IRQFLAGS1_TX_READY);
-	case pll_locked:
-		return (rf69_read_reg(spi, REG_IRQFLAGS1) & MASK_IRQFLAGS1_PLL_LOCK);
-	case rssi_exceeded_threshold:
-		return (rf69_read_reg(spi, REG_IRQFLAGS1) & MASK_IRQFLAGS1_RSSI);
-	case timeout:
-		return (rf69_read_reg(spi, REG_IRQFLAGS1) & MASK_IRQFLAGS1_TIMEOUT);
-	case automode:
-		return (rf69_read_reg(spi, REG_IRQFLAGS1) & MASK_IRQFLAGS1_AUTOMODE);
-	case sync_address_match:
-		return (rf69_read_reg(spi, REG_IRQFLAGS1) & MASK_IRQFLAGS1_SYNC_ADDRESS_MATCH);
-	case fifo_full:
-		return (rf69_read_reg(spi, REG_IRQFLAGS2) & MASK_IRQFLAGS2_FIFO_FULL);
-/*
- *	case fifo_not_empty:
- *		return (rf69_read_reg(spi, REG_IRQFLAGS2) & MASK_IRQFLAGS2_FIFO_NOT_EMPTY);
- */
-	case fifo_empty:
-		return !(rf69_read_reg(spi, REG_IRQFLAGS2) & MASK_IRQFLAGS2_FIFO_NOT_EMPTY);
-	case fifo_level_below_threshold:
-		return (rf69_read_reg(spi, REG_IRQFLAGS2) & MASK_IRQFLAGS2_FIFO_LEVEL);
-	case fifo_overrun:
-		return (rf69_read_reg(spi, REG_IRQFLAGS2) & MASK_IRQFLAGS2_FIFO_OVERRUN);
-	case packet_sent:
-		return (rf69_read_reg(spi, REG_IRQFLAGS2) & MASK_IRQFLAGS2_PACKET_SENT);
-	case payload_ready:
-		return (rf69_read_reg(spi, REG_IRQFLAGS2) & MASK_IRQFLAGS2_PAYLOAD_READY);
-	case crc_ok:
-		return (rf69_read_reg(spi, REG_IRQFLAGS2) & MASK_IRQFLAGS2_CRC_OK);
-	case battery_low:
-		return (rf69_read_reg(spi, REG_IRQFLAGS2) & MASK_IRQFLAGS2_LOW_BAT);
-	default:
-		return false;
-	}
-}
-
 int rf69_set_rssi_threshold(struct spi_device *spi, u8 threshold)
 {
 	/* no value check needed - u8 exactly matches register size */
diff --git a/drivers/staging/pi433/rf69.h b/drivers/staging/pi433/rf69.h
index 3ff5609ecf2e..78fa0b8bab8b 100644
--- a/drivers/staging/pi433/rf69.h
+++ b/drivers/staging/pi433/rf69.h
@@ -42,7 +42,6 @@ int rf69_set_bandwidth_during_afc(struct spi_device *spi,
 int rf69_set_ook_threshold_dec(struct spi_device *spi,
 			       enum threshold_decrement threshold_decrement);
 int rf69_set_dio_mapping(struct spi_device *spi, u8 dio_number, u8 value);
-bool rf69_get_flag(struct spi_device *spi, enum flag flag);
 int rf69_set_rssi_threshold(struct spi_device *spi, u8 threshold);
 int rf69_set_preamble_length(struct spi_device *spi, u16 preamble_length);
 int rf69_enable_sync(struct spi_device *spi);
diff --git a/drivers/staging/pi433/rf69_enum.h b/drivers/staging/pi433/rf69_enum.h
index b33a33a85d3b..9dc906124e98 100644
--- a/drivers/staging/pi433/rf69_enum.h
+++ b/drivers/staging/pi433/rf69_enum.h
@@ -84,26 +84,6 @@ enum threshold_decrement {
 	dec_16times
 };
 
-enum flag {
-	mode_switch_completed,
-	ready_to_receive,
-	ready_to_send,
-	pll_locked,
-	rssi_exceeded_threshold,
-	timeout,
-	automode,
-	sync_address_match,
-	fifo_full,
-//	fifo_not_empty, collision with next enum; replaced by following enum...
-	fifo_empty,
-	fifo_level_below_threshold,
-	fifo_overrun,
-	packet_sent,
-	payload_ready,
-	crc_ok,
-	battery_low
-};
-
 enum fifo_fill_condition {
 	after_sync_interrupt,
 	always
-- 
2.34.1

