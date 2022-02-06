Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD034AAE46
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 08:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiBFHq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 02:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiBFHqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 02:46:24 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC52C06173B
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 23:46:23 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id 192so8968975pfz.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Feb 2022 23:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JfNa77FHoLegWMiGAXFL+Tu9PZ+tk17TjCdFCf2r/90=;
        b=BwlP/N3BSptV3rohiHx1sSRLuPz5PHJAMh5eVkSv++a3F9oJ+qXtJrIoSvBT8NiIql
         /20XuTTkFcVGAahsoKrTd58ABo/Df+QVgvOf30g13kD+31TKg0+HvvNPHgAwAasxcROO
         3TjFrvs+4mGhkecDPn2LJN4m669CclNCQl3U1wbLwRv5pXiHXvv0PlYwApYPw4NUGnbK
         4dik41D46xeC2x4IscupMUni3o9WdEsGpAy7Wqh05oP5Sp0Y8b2d/vyKrTrn8JUQfgI6
         TDj/aDkMy1z6G39vUJHoJsfChh4ARVQHvLbDi7lJWsgq8eps5yrFXmo+u848gNhMf2lh
         uHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JfNa77FHoLegWMiGAXFL+Tu9PZ+tk17TjCdFCf2r/90=;
        b=sQNIJv5RbFzwN4HY1GWU1PlaWnMUZgYC08yX5oWhNNpv2AorxbRshQ/+5VkNCPJhIj
         DJzMyh6HfsgKKaIRa3fMXWjKe9YHqF1hIDApFCgmYQ2Vio6nc1fLj2gVcJQmae45SypJ
         gQ4jqBn//2t7Ri8zePn8BvsGqg1cO2B81inNMigQwdy/3MwJKNT4Lqw+EcpdWWQvmPNq
         mb2lB5hLa0JHVsSs6p776B6EzJAJ64z+8r+feHo3PdFrpGfhFO/+nsgT/40PZuiOP5qr
         U5FLLa2/Wyzd7mtblRmm6OslWCFlLvs0NpfsCqSUYwwQQQCthQODDC/BpqpVchoiLVug
         Wbug==
X-Gm-Message-State: AOAM533Hg9je1johJo3pI5uEJO4ZnPBmFLTaV/KnJ3alo8Uod/Nu145R
        U2DP0z6vUVJMZ5sBlqp57Tg=
X-Google-Smtp-Source: ABdhPJzSbyLpXEwkAp6UoCpEVfFg5g9kYmRiY+WpwOJkwYlLlNlEmJvcC+DG9lF2O/Wkf/CckM+/Ug==
X-Received: by 2002:a63:185c:: with SMTP id 28mr5195709pgy.238.1644133582647;
        Sat, 05 Feb 2022 23:46:22 -0800 (PST)
Received: from mlpln-zenbook.hitronhub.home (123-194-202-33.dynamic.kbronet.com.tw. [123.194.202.33])
        by smtp.gmail.com with ESMTPSA id on14sm1264755pjb.34.2022.02.05.23.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Feb 2022 23:46:22 -0800 (PST)
From:   joelcchangg@gmail.com
To:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.com
Cc:     Joel Camilo Chang Gonzalez <joelcchangg@gmail.com>
Subject: [PATCH] staging: octeon-usb: Fix 'should not end with '(''
Date:   Sun,  6 Feb 2022 15:46:15 +0800
Message-Id: <20220206074615.3527-1-joelcchangg@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joel Camilo Chang Gonzalez <joelcchangg@gmail.com>

This patch fixes the checkpatch.pl check:

CHECK: Line should not end with '('

at lines 1802, 1807 and at some function headers.

Signed-off-by: Joel Camilo Chang Gonzalez <joelcchangg@gmail.com>
---
 drivers/staging/octeon-usb/octeon-hcd.c | 67 +++++++++++--------------
 1 file changed, 29 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
index a1cd81d4a114..60e8354104e6 100644
--- a/drivers/staging/octeon-usb/octeon-hcd.c
+++ b/drivers/staging/octeon-usb/octeon-hcd.c
@@ -1792,23 +1792,18 @@ static void cvmx_usb_start_channel(struct octeon_hcd *usb, int channel,
 	case CVMX_USB_TRANSFER_INTERRUPT:
 		break;
 	case CVMX_USB_TRANSFER_ISOCHRONOUS:
-		if (!cvmx_usb_pipe_needs_split(usb, pipe)) {
+		if (!cvmx_usb_pipe_needs_split(usb, pipe) &&
+		    pipe->transfer_dir == CVMX_USB_DIRECTION_OUT) {
 			/*
 			 * ISO transactions require different PIDs depending on
 			 * direction and how many packets are needed
 			 */
-			if (pipe->transfer_dir == CVMX_USB_DIRECTION_OUT) {
-				if (pipe->multi_count < 2) /* Need DATA0 */
-					USB_SET_FIELD32(
-						CVMX_USBCX_HCTSIZX(channel,
-								   usb->index),
+			if (pipe->multi_count < 2) /* Need DATA0 */
+				USB_SET_FIELD32(CVMX_USBCX_HCTSIZX(channel, usb->index),
 						cvmx_usbcx_hctsizx, pid, 0);
-				else /* Need MDATA */
-					USB_SET_FIELD32(
-						CVMX_USBCX_HCTSIZX(channel,
-								   usb->index),
+			else /* Need MDATA */
+				USB_SET_FIELD32(CVMX_USBCX_HCTSIZX(channel, usb->index),
 						cvmx_usbcx_hctsizx, pid, 3);
-			}
 		}
 		break;
 	}
@@ -2121,17 +2116,17 @@ static void cvmx_usb_complete(struct octeon_hcd *usb,
  *
  * Returns: Transaction or NULL on failure.
  */
-static struct cvmx_usb_transaction *cvmx_usb_submit_transaction(
-				struct octeon_hcd *usb,
-				struct cvmx_usb_pipe *pipe,
-				enum cvmx_usb_transfer type,
-				u64 buffer,
-				int buffer_length,
-				u64 control_header,
-				int iso_start_frame,
-				int iso_number_packets,
-				struct cvmx_usb_iso_packet *iso_packets,
-				struct urb *urb)
+static struct cvmx_usb_transaction *cvmx_usb_submit_transaction(struct octeon_hcd *usb,
+								struct cvmx_usb_pipe *pipe,
+								enum cvmx_usb_transfer type,
+								u64 buffer,
+								int buffer_length,
+								u64 control_header,
+								int iso_start_frame,
+								int iso_number_packets,
+								struct cvmx_usb_iso_packet
+									*iso_packets,
+								struct urb *urb)
 {
 	struct cvmx_usb_transaction *transaction;
 
@@ -2182,10 +2177,9 @@ static struct cvmx_usb_transaction *cvmx_usb_submit_transaction(
  *
  * Returns: A submitted transaction or NULL on failure.
  */
-static struct cvmx_usb_transaction *cvmx_usb_submit_bulk(
-						struct octeon_hcd *usb,
-						struct cvmx_usb_pipe *pipe,
-						struct urb *urb)
+static struct cvmx_usb_transaction *cvmx_usb_submit_bulk(struct octeon_hcd *usb,
+							 struct cvmx_usb_pipe *pipe,
+							 struct urb *urb)
 {
 	return cvmx_usb_submit_transaction(usb, pipe, CVMX_USB_TRANSFER_BULK,
 					   urb->transfer_dma,
@@ -2206,10 +2200,9 @@ static struct cvmx_usb_transaction *cvmx_usb_submit_bulk(
  *
  * Returns: A submitted transaction or NULL on failure.
  */
-static struct cvmx_usb_transaction *cvmx_usb_submit_interrupt(
-						struct octeon_hcd *usb,
-						struct cvmx_usb_pipe *pipe,
-						struct urb *urb)
+static struct cvmx_usb_transaction *cvmx_usb_submit_interrupt(struct octeon_hcd *usb,
+							      struct cvmx_usb_pipe *pipe,
+							      struct urb *urb)
 {
 	return cvmx_usb_submit_transaction(usb, pipe,
 					   CVMX_USB_TRANSFER_INTERRUPT,
@@ -2231,10 +2224,9 @@ static struct cvmx_usb_transaction *cvmx_usb_submit_interrupt(
  *
  * Returns: A submitted transaction or NULL on failure.
  */
-static struct cvmx_usb_transaction *cvmx_usb_submit_control(
-						struct octeon_hcd *usb,
-						struct cvmx_usb_pipe *pipe,
-						struct urb *urb)
+static struct cvmx_usb_transaction *cvmx_usb_submit_control(struct octeon_hcd *usb,
+							    struct cvmx_usb_pipe *pipe,
+							    struct urb *urb)
 {
 	int buffer_length = urb->transfer_buffer_length;
 	u64 control_header = urb->setup_dma;
@@ -2262,10 +2254,9 @@ static struct cvmx_usb_transaction *cvmx_usb_submit_control(
  *
  * Returns: A submitted transaction or NULL on failure.
  */
-static struct cvmx_usb_transaction *cvmx_usb_submit_isochronous(
-						struct octeon_hcd *usb,
-						struct cvmx_usb_pipe *pipe,
-						struct urb *urb)
+static struct cvmx_usb_transaction *cvmx_usb_submit_isochronous(struct octeon_hcd *usb,
+								struct cvmx_usb_pipe *pipe,
+								struct urb *urb)
 {
 	struct cvmx_usb_iso_packet *packets;
 
-- 
2.25.1

