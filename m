Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7526A4F6113
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbiDFOED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234178AbiDFODu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:03:50 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49DBA76C5;
        Wed,  6 Apr 2022 02:20:46 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id C78DB5C0148;
        Wed,  6 Apr 2022 05:13:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 06 Apr 2022 05:13:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:date:date:from:from:in-reply-to
        :message-id:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=guME7x
        VTNqIwNjNs7HpvT3KtelTUAeanGasp7WKK014=; b=ZaeefLitPL2BoTp0wjxkM+
        MadtJ9GcgOwuvYMsEy5YsWlrr57OELiAVqRXkeVRwOaB+mDZiROrexMei7Fmmtl9
        Y2p6kntZ2Yw7j76xQ6+4TcPEY2o9BTWFtGJ/unXostYP7OiXCvgatUAGc+hh0RQr
        5Rgj3uuVaLu7NwJe0MCjUQw0pJ9FEzuIxYL+mQr6/uvea96vkc4y9ePIc9F9pQE+
        Jhah8NYOZNWQcLXbUe0FI+xvSe/8PtScbzfH0u8zgZfgkqrZJfiL30LOlaiPhyVN
        kTiAe3cBF4fynl1fJAIr3yMPi0JSAF4qyBw7So9sDn5u72rx/gdpZq+yxj4zuTTg
        ==
X-ME-Sender: <xms:o1lNYnVjFtIu2zPi6qtdCF58hnMyaCd8iM86VzvLsrVp3Vhh7gc3wA>
    <xme:o1lNYvmStf6Z3PgWXhvrSBMijp9uC73TtgR_d3rHTRrzHI6pz8xs8bWGVTvt_e8wE
    Pifu2vdGQHntWXppIk>
X-ME-Received: <xmr:o1lNYjaiR_g_GDSF1YbUNhvFuJ_uQDR5Q3OyoL5jGviXDDUbFHRsLkcYCmuXFyvouYxTtcRsf_uJZRhxkxL1zFPretsEtJMhmGc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudejiedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepvffkhffuffestddtredttddttdenucfhrhhomhephfhinhhnucfvhhgrihhn
    uceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvghrnh
    eptdelteekleekkedvueejheekgfdvtdehhefhteeitefhteefgefhudehveevleelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhthhgrih
    hnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:o1lNYiUB6LQI3oNFrXm5eALEv4qYMKzaqHYbv84algSA7OkKEi9EsQ>
    <xmx:o1lNYhl_L9im-2MLBYR_qpZhaHQj9-6m_GJ6ZYG-AHf0cN1kDtafjA>
    <xmx:o1lNYvcvXBLeWddf3DIyLFmBm71VyZotiNxeOpJWFjHfqadaZYrTjQ>
    <xmx:o1lNYnj9B90TAaHvLQ7PKoOSnbJ7GXOYNauujN9V5dqpHDyKWSQN6g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Apr 2022 05:13:05 -0400 (EDT)
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "Bart Van Assche" <bvanassche@acm.org>,
        "Christoph Hellwig" <hch@lst.de>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <accf71e293ba3aed6d18c8baeb405de8dfe7c935.1649235939.git.fthain@linux-m68k.org>
From:   Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2] scsi: sym53c500_cs: Stop using struct scsi_pointer
Date:   Wed, 06 Apr 2022 19:05:39 +1000
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver doesn't use SCp.ptr to save a SCSI command data pointer which
means "scsi pointer" is a complete misnomer here. Only a few members of
struct scsi_pointer are needed so move those to private command data.

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
The sym53c500_cs driver somehow missed out on complete scsi_pointer
removal in Bart's recently queued patch series, unlike nsp32 for example.
So this patch finishes the job. Compile-tested only.

Changed since v1:
 - Removed SYM53c500_priv() helper function as suggested by Christoph.
---
 drivers/scsi/pcmcia/sym53c500_cs.c | 52 ++++++++++++++----------------
 1 file changed, 25 insertions(+), 27 deletions(-)

diff --git a/drivers/scsi/pcmcia/sym53c500_cs.c b/drivers/scsi/pcmcia/sym53c500_cs.c
index c4a838635893..5d7dfefd6f6c 100644
--- a/drivers/scsi/pcmcia/sym53c500_cs.c
+++ b/drivers/scsi/pcmcia/sym53c500_cs.c
@@ -192,10 +192,11 @@ struct sym53c500_data {
 	int fast_pio;
 };
 
-static struct scsi_pointer *sym53c500_scsi_pointer(struct scsi_cmnd *cmd)
-{
-	return scsi_cmd_priv(cmd);
-}
+struct sym53c500_cmd_priv {
+	int status;
+	int message;
+	int phase;
+};
 
 enum Phase {
     idle,
@@ -356,7 +357,7 @@ SYM53C500_intr(int irq, void *dev_id)
 	struct sym53c500_data *data =
 	    (struct sym53c500_data *)dev->hostdata;
 	struct scsi_cmnd *curSC = data->current_SC;
-	struct scsi_pointer *scsi_pointer = sym53c500_scsi_pointer(curSC);
+	struct sym53c500_cmd_priv *scp = scsi_cmd_priv(curSC);
 	int fast_pio = data->fast_pio;
 
 	spin_lock_irqsave(dev->host_lock, flags);
@@ -403,12 +404,11 @@ SYM53C500_intr(int irq, void *dev_id)
 
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
@@ -419,7 +419,7 @@ SYM53C500_intr(int irq, void *dev_id)
 			struct scatterlist *sg;
 			int i;
 
-			scsi_pointer->phase = data_out;
+			scp->phase = data_out;
 			VDEB(printk("SYM53C500: Data-Out phase\n"));
 			outb(FLUSH_FIFO, port_base + CMD_REG);
 			LOAD_DMA_COUNT(port_base, scsi_bufflen(curSC));	/* Max transfer size */
@@ -438,7 +438,7 @@ SYM53C500_intr(int irq, void *dev_id)
 			struct scatterlist *sg;
 			int i;
 
-			scsi_pointer->phase = data_in;
+			scp->phase = data_in;
 			VDEB(printk("SYM53C500: Data-In phase\n"));
 			outb(FLUSH_FIFO, port_base + CMD_REG);
 			LOAD_DMA_COUNT(port_base, scsi_bufflen(curSC));	/* Max transfer size */
@@ -453,12 +453,12 @@ SYM53C500_intr(int irq, void *dev_id)
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
@@ -471,24 +471,22 @@ SYM53C500_intr(int irq, void *dev_id)
 
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
@@ -500,7 +498,7 @@ SYM53C500_intr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 
 idle_out:
-	scsi_pointer->phase = idle;
+	scp->phase = idle;
 	scsi_done(curSC);
 	goto out;
 }
@@ -548,7 +546,7 @@ SYM53C500_info(struct Scsi_Host *SChost)
 
 static int SYM53C500_queue_lck(struct scsi_cmnd *SCpnt)
 {
-	struct scsi_pointer *scsi_pointer = sym53c500_scsi_pointer(SCpnt);
+	struct sym53c500_cmd_priv *scp = scsi_cmd_priv(SCpnt);
 	int i;
 	int port_base = SCpnt->device->host->io_port;
 	struct sym53c500_data *data =
@@ -565,9 +563,9 @@ static int SYM53C500_queue_lck(struct scsi_cmnd *SCpnt)
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
@@ -682,7 +680,7 @@ static struct scsi_host_template sym53c500_driver_template = {
      .this_id			= 7,
      .sg_tablesize		= 32,
      .shost_groups		= SYM53C500_shost_groups,
-     .cmd_size			= sizeof(struct scsi_pointer),
+     .cmd_size			= sizeof(struct sym53c500_cmd_priv),
 };
 
 static int SYM53C500_config_check(struct pcmcia_device *p_dev, void *priv_data)
-- 
2.32.0

