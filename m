Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75DC4F30F2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 14:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350131AbiDEJzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 05:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238285AbiDEISr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:18:47 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210C7E6;
        Tue,  5 Apr 2022 01:08:29 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 194A75C0199;
        Tue,  5 Apr 2022 04:08:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 05 Apr 2022 04:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:date:date:from:from:in-reply-to
        :message-id:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ULP8rc
        faCHueJJcnGSad4jhUThCttt20904WHbSKF9w=; b=LuWVE8abpnpw4YMexiymBr
        daGPXkPYmeSvVFYEoF4SoLCAG6GDvo4nnfHh93gREsZYeWKHMzYtMYISU/0x2l2p
        Pamif2EuIzolCGUjnFtm6aVq0Pm1FE/+HNOclGrajztaRGxYbKUZm/zZINHfLO1Q
        bqNRg8v5BtNHnbJJ36PyNRgiKNDwoH7gIPFURIbcA0UyoFK3ecUg4EK7kJjyFQwQ
        oo8S/iVae1zeWlVkEVVGGXeyaPvIoOYPvrBnEcqSz7lzG2zlV4c3tK394FaKHZ9Z
        1fhkEXjaLi8yYJAlB5b9L0cKwwanSzOXYEqD7vLjEtApj2kCZuUF5w8E9onV82mw
        ==
X-ME-Sender: <xms:_PhLYiF4hbHPvOc62rpRIabAEl1nWd6AA5Z14OIDCHO0K7Q97RLzsg>
    <xme:_PhLYjXoIyTH1Yi11Qhz01iW61rYBTlFuuxer5W2IUjjtDQ5xrRDSFAxIUD6Qlyk7
    i9eevoiRrYSjpYZsoc>
X-ME-Received: <xmr:_PhLYsLUJaRsq7wCdmI_yYYMBd8rGI3ChesC6idVGyqxsigj1X1EjT7WzLKTqd8Klmhqq6ng4iYqN5xkhLoby8Z69IdT5MJWBJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudejfedguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefvkffhufffsedttdertddttddtnecuhfhrohhmpefhihhnnhcuvfhhrghi
    nhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtthgvrh
    hnpedtleetkeelkeekvdeujeehkefgvddtheehhfetieethfetfeeghfduheevveelleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrg
    hinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:_PhLYsFO_YSMl1FVVgGXuyOz7rT_g2khe_KVwvATIdDL5JRUqil_GQ>
    <xmx:_PhLYoWyy2jGesNZmceT15g44XX4x-dglBu7K1HqGoQLun8ZWFPz4g>
    <xmx:_PhLYvMcoQqRPG7fgJQFRHb321h5zDHIxoEfFZ_QwRogA64I-RBy7w>
    <xmx:_fhLYjcRzdSJJa6mEsswm3NjZpnCCZLCCI76eMCzBJETOHc93hE8lQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Apr 2022 04:08:25 -0400 (EDT)
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <4948f86703d23e5048f4e24e649680259b2610f9.1649146056.git.fthain@linux-m68k.org>
From:   Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH] scsi: sym53c500_cs: Stop using struct scsi_pointer
Date:   Tue, 05 Apr 2022 18:07:36 +1000
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver doesn't use SCp.ptr to save a SCSI command data pointer which
means "scsi pointer" is a complete misnomer here. Only a few members of
struct scsi_pointer are needed so move those to private command data.

Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
The sym53c500_cs driver somehow missed out on complete scsi_pointer
removal in Bart's recently queued patch series, unlike nsp32 for example.
So this patch finishes the job. Compile-tested only.
---
 drivers/scsi/pcmcia/sym53c500_cs.c | 51 ++++++++++++++++--------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/drivers/scsi/pcmcia/sym53c500_cs.c b/drivers/scsi/pcmcia/sym53c500_cs.c
index c4a838635893..4980247f95bc 100644
--- a/drivers/scsi/pcmcia/sym53c500_cs.c
+++ b/drivers/scsi/pcmcia/sym53c500_cs.c
@@ -192,7 +192,13 @@ struct sym53c500_data {
 	int fast_pio;
 };
 
-static struct scsi_pointer *sym53c500_scsi_pointer(struct scsi_cmnd *cmd)
+struct sym53c500_cmd_priv {
+	int status;
+	int message;
+	int phase;
+};
+
+static struct sym53c500_cmd_priv *SYM53c500_priv(struct scsi_cmnd *cmd)
 {
 	return scsi_cmd_priv(cmd);
 }
@@ -356,7 +362,7 @@ SYM53C500_intr(int irq, void *dev_id)
 	struct sym53c500_data *data =
 	    (struct sym53c500_data *)dev->hostdata;
 	struct scsi_cmnd *curSC = data->current_SC;
-	struct scsi_pointer *scsi_pointer = sym53c500_scsi_pointer(curSC);
+	struct sym53c500_cmd_priv *scp = SYM53c500_priv(curSC);
 	int fast_pio = data->fast_pio;
 
 	spin_lock_irqsave(dev->host_lock, flags);
@@ -403,12 +409,11 @@ SYM53C500_intr(int irq, void *dev_id)
 
 	if (int_reg & 0x20) {		/* Disconnect */
 		DEB(printk("SYM53C500: disconnect intr received\n"));
-		if (scsi_pointer->phase != message_in) {	/* Unexpected disconnect */
+		if (scp->phase != message_in) {	/* Unexpected disconnect */
 			curSC->result = DID_NO_CONNECT << 16;
 		} else {	/* Command complete, return status and message */
-			curSC->result = (scsi_pointer->Status & 0xff) |
-				((scsi_pointer->Message & 0xff) << 8) |
-				(DID_OK << 16);
+			curSC->result = (scp->status & 0xff) |
+				((scp->message & 0xff) << 8) | (DID_OK << 16);
 		}
 		goto idle_out;
 	}
@@ -419,7 +424,7 @@ SYM53C500_intr(int irq, void *dev_id)
 			struct scatterlist *sg;
 			int i;
 
-			scsi_pointer->phase = data_out;
+			scp->phase = data_out;
 			VDEB(printk("SYM53C500: Data-Out phase\n"));
 			outb(FLUSH_FIFO, port_base + CMD_REG);
 			LOAD_DMA_COUNT(port_base, scsi_bufflen(curSC));	/* Max transfer size */
@@ -438,7 +443,7 @@ SYM53C500_intr(int irq, void *dev_id)
 			struct scatterlist *sg;
 			int i;
 
-			scsi_pointer->phase = data_in;
+			scp->phase = data_in;
 			VDEB(printk("SYM53C500: Data-In phase\n"));
 			outb(FLUSH_FIFO, port_base + CMD_REG);
 			LOAD_DMA_COUNT(port_base, scsi_bufflen(curSC));	/* Max transfer size */
@@ -453,12 +458,12 @@ SYM53C500_intr(int irq, void *dev_id)
 		break;
 
 	case 0x02:		/* COMMAND */
-		scsi_pointer->phase = command_ph;
+		scp->phase = command_ph;
 		printk("SYM53C500: Warning: Unknown interrupt occurred in command phase!\n");
 		break;
 
 	case 0x03:		/* STATUS */
-		scsi_pointer->phase = status_ph;
+		scp->phase = status_ph;
 		VDEB(printk("SYM53C500: Status phase\n"));
 		outb(FLUSH_FIFO, port_base + CMD_REG);
 		outb(INIT_CMD_COMPLETE, port_base + CMD_REG);
@@ -471,24 +476,22 @@ SYM53C500_intr(int irq, void *dev_id)
 
 	case 0x06:		/* MESSAGE-OUT */
 		DEB(printk("SYM53C500: Message-Out phase\n"));
-		scsi_pointer->phase = message_out;
+		scp->phase = message_out;
 		outb(SET_ATN, port_base + CMD_REG);	/* Reject the message */
 		outb(MSG_ACCEPT, port_base + CMD_REG);
 		break;
 
 	case 0x07:		/* MESSAGE-IN */
 		VDEB(printk("SYM53C500: Message-In phase\n"));
-		scsi_pointer->phase = message_in;
+		scp->phase = message_in;
 
-		scsi_pointer->Status = inb(port_base + SCSI_FIFO);
-		scsi_pointer->Message = inb(port_base + SCSI_FIFO);
+		scp->status = inb(port_base + SCSI_FIFO);
+		scp->message = inb(port_base + SCSI_FIFO);
 
 		VDEB(printk("SCSI FIFO size=%d\n", inb(port_base + FIFO_FLAGS) & 0x1f));
-		DEB(printk("Status = %02x  Message = %02x\n",
-			   scsi_pointer->Status, scsi_pointer->Message));
+		DEB(printk("Status = %02x  Message = %02x\n", scp->status, scp->message));
 
-		if (scsi_pointer->Message == SAVE_POINTERS ||
-		    scsi_pointer->Message == DISCONNECT) {
+		if (scp->message == SAVE_POINTERS || scp->message == DISCONNECT) {
 			outb(SET_ATN, port_base + CMD_REG);	/* Reject message */
 			DEB(printk("Discarding SAVE_POINTERS message\n"));
 		}
@@ -500,7 +503,7 @@ SYM53C500_intr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 
 idle_out:
-	scsi_pointer->phase = idle;
+	scp->phase = idle;
 	scsi_done(curSC);
 	goto out;
 }
@@ -548,7 +551,7 @@ SYM53C500_info(struct Scsi_Host *SChost)
 
 static int SYM53C500_queue_lck(struct scsi_cmnd *SCpnt)
 {
-	struct scsi_pointer *scsi_pointer = sym53c500_scsi_pointer(SCpnt);
+	struct sym53c500_cmd_priv *scp = SYM53c500_priv(SCpnt);
 	int i;
 	int port_base = SCpnt->device->host->io_port;
 	struct sym53c500_data *data =
@@ -565,9 +568,9 @@ static int SYM53C500_queue_lck(struct scsi_cmnd *SCpnt)
 	VDEB(printk("\n"));
 
 	data->current_SC = SCpnt;
-	scsi_pointer->phase = command_ph;
-	scsi_pointer->Status = 0;
-	scsi_pointer->Message = 0;
+	scp->phase = command_ph;
+	scp->status = 0;
+	scp->message = 0;
 
 	/* We are locked here already by the mid layer */
 	REG0(port_base);
@@ -682,7 +685,7 @@ static struct scsi_host_template sym53c500_driver_template = {
      .this_id			= 7,
      .sg_tablesize		= 32,
      .shost_groups		= SYM53C500_shost_groups,
-     .cmd_size			= sizeof(struct scsi_pointer),
+     .cmd_size			= sizeof(struct sym53c500_cmd_priv),
 };
 
 static int SYM53C500_config_check(struct pcmcia_device *p_dev, void *priv_data)
-- 
2.32.0

