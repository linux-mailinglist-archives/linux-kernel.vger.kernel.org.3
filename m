Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7014F8FA5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiDHHcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 03:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiDHHco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 03:32:44 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CE219E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 00:30:41 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id bu29so13691658lfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 00:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=kBQo90N7sEL0M7e1R27tsRN751KlpZFtkEzziLKe240=;
        b=AZ6HmJwpJmTNX4yORBpvhAQouRMvxLFnmiNg/zoCmTIGMhLnR1ytyvEjbjgusUXY/i
         pN8Z5J53fx9/3r0vJncFHu16J02fatjvE69tn7lpz4acudwTEZm5pmhBkAx4MDYQzpR7
         wtQk6OvkHfD7aSx6nihj2astU1PEzJtmbZHjr/8TOWLZvwFzuBrNrxvcEZCGo+3n6Hlr
         18d9n0qfjJYmLR7oNMRJ2HZWSjaWNkxsUMVQkY2RyNo44Xvn1jIjczL808d2ukkYyH+t
         FJERR3eeE9KP3HwZM61HCWOh12Gkj9kJUjS2ojA9kWeFndNt2mXh4AbWGjr72qwLNQl+
         t65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=kBQo90N7sEL0M7e1R27tsRN751KlpZFtkEzziLKe240=;
        b=bsTN+Fi5iUOZrCuwjYDpSqtm8HWsBOBKh0hoZK7R9OhKsrsP56AHn44SAMxAZWHpV8
         x7OSPh9JNZd79STcica0Svw4qW8Yujn2Z7pAJ+j/S3gTzQqd5+csxO6cnDwYd3IDjbJm
         yPRelgur6p8FPEOFw7sRh26T+sZ/QbfCQSnCXYVwCOwvi3Ch5enL3xveyoV7F/enJalK
         1Tkh924IPXCAR0kxXG60cNsct0yMp0JnByjtC6eyWzVb1xaebkPAGDNZnGR38223qRMf
         0SUUf/Jl+LVMruN/NTGkiwUXzDWSH3G6phHoctpG6BnKwaNQXmTJtwT12YBabD5QH1NF
         bXwg==
X-Gm-Message-State: AOAM530S+U3PpDDq34udttg+7G8qLm2oa25DrtEkUx8hxDE8nWjmliEB
        zqyT8w/XWy8vd9iob+2DPz/UVrYK1/A=
X-Google-Smtp-Source: ABdhPJxUw74C3ij570zJxqVSuzHpsuYvAZ5JxOtwqUnd7Rg+ndi6j71Pb4IXy16o5eYmKrNI11dCAw==
X-Received: by 2002:a05:6512:33d0:b0:44a:72b2:cd36 with SMTP id d16-20020a05651233d000b0044a72b2cd36mr12241852lfg.113.1649403039787;
        Fri, 08 Apr 2022 00:30:39 -0700 (PDT)
Received: from crux (h-98-128-204-26.A444.priv.bahnhof.se. [98.128.204.26])
        by smtp.gmail.com with ESMTPSA id h14-20020a0565123c8e00b0044a2ddb6694sm2382943lfv.124.2022.04.08.00.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 00:30:39 -0700 (PDT)
Date:   Fri, 8 Apr 2022 09:30:37 +0200
From:   Artur Bujdoso <artur.bujdoso@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: octeon-usb: remove unnecessary parentheses
Message-ID: <Yk/knRtaujd/PzK7@crux>
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

Adhere to Linux kernel coding style.

Reported by checkpatch:

CHECK:UNNECESSARY_PARENTHESES: Unnecessary parentheses

Signed-off-by: Artur Bujdoso <artur.bujdoso@gmail.com>
---
 drivers/staging/octeon-usb/octeon-hcd.c | 62 ++++++++++++-------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
index a1cd81d4a114..32bcd6c582f5 100644
--- a/drivers/staging/octeon-usb/octeon-hcd.c
+++ b/drivers/staging/octeon-usb/octeon-hcd.c
@@ -1101,9 +1101,9 @@ static struct cvmx_usb_pipe *cvmx_usb_open_pipe(struct octeon_hcd *usb,
 	pipe = kzalloc(sizeof(*pipe), GFP_ATOMIC);
 	if (!pipe)
 		return NULL;
-	if ((device_speed == CVMX_USB_SPEED_HIGH) &&
-	    (transfer_dir == CVMX_USB_DIRECTION_OUT) &&
-	    (transfer_type == CVMX_USB_TRANSFER_BULK))
+	if (device_speed == CVMX_USB_SPEED_HIGH &&
+	    transfer_dir == CVMX_USB_DIRECTION_OUT &&
+	    transfer_type == CVMX_USB_TRANSFER_BULK)
 		pipe->flags |= CVMX_USB_PIPE_FLAGS_NEED_PING;
 	pipe->device_addr = device_addr;
 	pipe->endpoint_num = endpoint_num;
@@ -1319,8 +1319,8 @@ static void cvmx_usb_fill_tx_fifo(struct octeon_hcd *usb, int channel)
 	if (!usbc_hctsiz.s.xfersize)
 		return;
 
-	if ((hcchar.s.eptype == CVMX_USB_TRANSFER_INTERRUPT) ||
-	    (hcchar.s.eptype == CVMX_USB_TRANSFER_ISOCHRONOUS))
+	if (hcchar.s.eptype == CVMX_USB_TRANSFER_INTERRUPT ||
+	    hcchar.s.eptype == CVMX_USB_TRANSFER_ISOCHRONOUS)
 		fifo = &usb->periodic;
 	else
 		fifo = &usb->nonperiodic;
@@ -1637,9 +1637,9 @@ static void cvmx_usb_start_channel(struct octeon_hcd *usb, int channel,
 			 * begin/middle/end of the data or all
 			 */
 			if (!usbc_hcsplt.s.compsplt &&
-			    (pipe->transfer_dir == CVMX_USB_DIRECTION_OUT) &&
-			    (pipe->transfer_type ==
-			     CVMX_USB_TRANSFER_ISOCHRONOUS)) {
+			    pipe->transfer_dir == CVMX_USB_DIRECTION_OUT &&
+			    pipe->transfer_type ==
+			     CVMX_USB_TRANSFER_ISOCHRONOUS) {
 				/*
 				 * Clear the split complete frame number as
 				 * there isn't going to be a split complete
@@ -1813,7 +1813,7 @@ static void cvmx_usb_start_channel(struct octeon_hcd *usb, int channel,
 		break;
 	}
 	{
-		union cvmx_usbcx_hctsizx usbc_hctsiz = { .u32 =
+			union cvmx_usbcx_hctsizx usbc_hctsiz = { .u32 =
 			cvmx_usb_read_csr32(usb,
 					    CVMX_USBCX_HCTSIZX(channel,
 							       usb->index))
@@ -1849,11 +1849,11 @@ static struct cvmx_usb_pipe *cvmx_usb_find_ready_pipe(struct octeon_hcd *usb,
 			list_first_entry(&pipe->transactions, typeof(*t),
 					 node);
 		if (!(pipe->flags & CVMX_USB_PIPE_FLAGS_SCHEDULED) && t &&
-		    (pipe->next_tx_frame <= current_frame) &&
-		    ((pipe->split_sc_frame == -1) ||
-		     ((((int)current_frame - pipe->split_sc_frame) & 0x7f) <
+		    pipe->next_tx_frame <= current_frame &&
+		    (pipe->split_sc_frame == -1 ||
+		     (((int)current_frame - pipe->split_sc_frame) & 0x7f <
 		      0x40)) &&
-		    (!usb->active_split || (usb->active_split == t))) {
+		    !usb->active_split || (usb->active_split == t)) {
 			prefetch(t);
 			return pipe;
 		}
@@ -2075,8 +2075,8 @@ static void cvmx_usb_complete(struct octeon_hcd *usb,
 		 * If there are more ISOs pending and we succeeded, schedule the
 		 * next one
 		 */
-		if ((transaction->iso_number_packets > 1) &&
-		    (complete_code == CVMX_USB_STATUS_OK)) {
+		if (transaction->iso_number_packets > 1 &&
+		    complete_code == CVMX_USB_STATUS_OK) {
 			/* No bytes transferred for this packet as of yet */
 			transaction->actual_bytes = 0;
 			/* One less ISO waiting to transfer */
@@ -2454,8 +2454,8 @@ static void cvmx_usb_transfer_control(struct octeon_hcd *usb,
 		}
 		break;
 	case CVMX_USB_STAGE_DATA_SPLIT_COMPLETE:
-		if ((buffer_space_left == 0) ||
-		    (bytes_in_last_packet < pipe->max_packet)) {
+		if (buffer_space_left == 0 ||
+		    bytes_in_last_packet < pipe->max_packet) {
 			pipe->pid_toggle = 1;
 			transaction->stage = CVMX_USB_STAGE_STATUS;
 		} else {
@@ -2499,12 +2499,12 @@ static void cvmx_usb_transfer_bulk(struct octeon_hcd *usb,
 			cvmx_usb_complete(usb, pipe, transaction,
 					  CVMX_USB_STATUS_OK);
 	} else {
-		if ((pipe->device_speed == CVMX_USB_SPEED_HIGH) &&
-		    (pipe->transfer_dir == CVMX_USB_DIRECTION_OUT) &&
-		    (usbc_hcint.s.nak))
+		if (pipe->device_speed == CVMX_USB_SPEED_HIGH &&
+		    pipe->transfer_dir == CVMX_USB_DIRECTION_OUT &&
+		    usbc_hcint.s.nak)
 			pipe->flags |= CVMX_USB_PIPE_FLAGS_NEED_PING;
 		if (!buffer_space_left ||
-		    (bytes_in_last_packet < pipe->max_packet))
+		    bytes_in_last_packet < pipe->max_packet)
 			cvmx_usb_complete(usb, pipe, transaction,
 					  CVMX_USB_STATUS_OK);
 	}
@@ -2555,7 +2555,7 @@ static void cvmx_usb_transfer_isoc(struct octeon_hcd *usb,
 			 * then this transfer is complete. Otherwise start it
 			 * again to send the next 188 bytes
 			 */
-			if (!buffer_space_left || (bytes_this_transfer < 188)) {
+			if (!buffer_space_left || bytes_this_transfer < 188) {
 				pipe->next_tx_frame += pipe->interval;
 				cvmx_usb_complete(usb, pipe, transaction,
 						  CVMX_USB_STATUS_OK);
@@ -2568,8 +2568,8 @@ static void cvmx_usb_transfer_isoc(struct octeon_hcd *usb,
 			 * We are in the incoming data phase. Keep getting data
 			 * until we run out of space or get a small packet
 			 */
-			if ((buffer_space_left == 0) ||
-			    (bytes_in_last_packet < pipe->max_packet)) {
+			if (buffer_space_left == 0 ||
+			    bytes_in_last_packet < pipe->max_packet) {
 				pipe->next_tx_frame += pipe->interval;
 				cvmx_usb_complete(usb, pipe, transaction,
 						  CVMX_USB_STATUS_OK);
@@ -2737,8 +2737,8 @@ static int cvmx_usb_poll_channel(struct octeon_hcd *usb, int channel)
 	 * the user's data. For this reason we don't count setup data as bytes
 	 * transferred
 	 */
-	if ((transaction->stage == CVMX_USB_STAGE_SETUP) ||
-	    (transaction->stage == CVMX_USB_STAGE_SETUP_SPLIT_COMPLETE))
+	if (transaction->stage == CVMX_USB_STAGE_SETUP ||
+	    transaction->stage == CVMX_USB_STAGE_SETUP_SPLIT_COMPLETE)
 		bytes_this_transfer = 0;
 
 	/*
@@ -2765,9 +2765,9 @@ static int cvmx_usb_poll_channel(struct octeon_hcd *usb, int channel)
 	 * a ping before proceeding. If this isn't true the ACK processing below
 	 * will clear this flag
 	 */
-	if ((pipe->device_speed == CVMX_USB_SPEED_HIGH) &&
-	    (pipe->transfer_type == CVMX_USB_TRANSFER_BULK) &&
-	    (pipe->transfer_dir == CVMX_USB_DIRECTION_OUT))
+	if (pipe->device_speed == CVMX_USB_SPEED_HIGH &&
+	    pipe->transfer_type == CVMX_USB_TRANSFER_BULK &&
+	    pipe->transfer_dir == CVMX_USB_DIRECTION_OUT)
 		pipe->flags |= CVMX_USB_PIPE_FLAGS_NEED_PING;
 
 	if (WARN_ON_ONCE(bytes_this_transfer < 0)) {
@@ -2820,8 +2820,8 @@ static int cvmx_usb_poll_channel(struct octeon_hcd *usb, int channel)
 			 * If there is more data to go then we need to try
 			 * again. Otherwise this transaction is complete
 			 */
-			if ((buffer_space_left == 0) ||
-			    (bytes_in_last_packet < pipe->max_packet))
+			if (buffer_space_left == 0 ||
+			    bytes_in_last_packet < pipe->max_packet)
 				cvmx_usb_complete(usb, pipe,
 						  transaction,
 						  CVMX_USB_STATUS_OK);
-- 
2.30.2

