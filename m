Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF5D4BEE9B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 02:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237138AbiBUXl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 18:41:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237086AbiBUXlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 18:41:19 -0500
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41AE245A7;
        Mon, 21 Feb 2022 15:40:54 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id EEF502B00256;
        Mon, 21 Feb 2022 18:24:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 21 Feb 2022 18:24:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:date:date:from:from:in-reply-to
        :message-id:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=cPkDhv
        Jgih9UFmPppy8eIU/hh+P57W7zuqiT1Z8t4WI=; b=R08slQjALIM+MBQQQcAFrj
        P1e2QTTPFKdZKmg2PGimTHM3Nw20pUMjEkgAiCkDQnOPH0Qvab85xUTGXwSrF5AO
        jtqB/NZpNANgdwYLFaPX4C6sKPRikUZsWQAh2QXJS938Dwsdd7GwahS/PLqzwq5y
        VKVHdh8CtELZxpq5hvtqrHQ0Q9qBpl8SeTIHQIxU1ZxPhdjqBdmpzGlRwK7iGh6U
        eZO0IwWcuZq4xGy9KBuxKIl0jWaZdCQAbkMw13vMpIc7JW5blHxkZwM+65JL6933
        IRwMF/4pP5XTY0AoNgyHNr7g5vOKuol4qSy2bJHvXtydXMj1YAiEp7b+SNEXBXAg
        ==
X-ME-Sender: <xms:FR8UYukqFxKvH_2GIVWKQjG2-WzR8yQPmCr-aErOcebVHDI0hw3mkg>
    <xme:FR8UYl23LGlRamo3Losg4zVB-gX5Bekhtbew8MKknhyijHX_YxQl97z7Wrwu51gwk
    BYJHjnvsOJ80_P7bxY>
X-ME-Received: <xmr:FR8UYsr445vAyEgEocyNi9koAumKep_76-4ox0ISUIcLbfQfpA8jFNKjNxfeiQnnOAPbjvHejewwQ_svrYIul1YopQHlTNYyoGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrkeejgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    fhohhrsghiugguvghnjfgurhculdehtddtmdenucfjughrpefvkffhufffsedttdertddt
    tdenucfhrhhomhephfhinhhnucfvhhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmie
    ekkhdrohhrgheqnecuhfhorhgsihguuggvnhfjughrpefvkffhufffsedttdertddttddp
    vffkhffuffestddtredttddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepfhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:FR8UYinWsfwfc6n9rnxr62xfaj3tTux6fPLZjgwvIk_0yfqdrDGpaQ>
    <xmx:FR8UYs3JMJY-LKtOmaXKXOWzvKb7HH02m6ugk1l3AU5A6mdZD0LNxg>
    <xmx:FR8UYpu29heQr7lPfa5o-7ADTpgfSjE3U88DYPA9KkRIyAh5nWNkMA>
    <xmx:FR8UYp8dNI0a9zZ340RwvQAoFmuS-mEsT3NXWJiLtZjtKzzk6mQob62WKzs>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Feb 2022 18:24:03 -0500 (EST)
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <3529a59873a7de8455a27af2528341afe5069adc.1645484982.git.fthain@linux-m68k.org>
From:   Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH] mac53c94: Stop using struct scsi_pointer
Date:   Tue, 22 Feb 2022 10:09:42 +1100
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver doesn't use SCp.ptr to save a SCSI command data pointer
which means "scsi pointer" is a complete misnomer here. Only a few
members of struct scsi_pointer are used and the rest waste memory.
Avoid the "struct foo { struct bar; };" silliness.

Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/scsi/mac53c94.c | 21 ++++++++++-----------
 drivers/scsi/mac53c94.h | 10 +++++-----
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/scsi/mac53c94.c b/drivers/scsi/mac53c94.c
index f3005b38931f..070ebe352f9e 100644
--- a/drivers/scsi/mac53c94.c
+++ b/drivers/scsi/mac53c94.c
@@ -194,7 +194,7 @@ static void mac53c94_interrupt(int irq, void *dev_id)
 	struct mac53c94_regs __iomem *regs = state->regs;
 	struct dbdma_regs __iomem *dma = state->dma;
 	struct scsi_cmnd *const cmd = state->current_req;
-	struct scsi_pointer *const scsi_pointer = mac53c94_scsi_pointer(cmd);
+	struct mac53c94_cmd_priv *const mcmd = mac53c94_priv(cmd);
 	int nb, stat, seq, intr;
 	static int mac53c94_errors;
 
@@ -264,10 +264,10 @@ static void mac53c94_interrupt(int irq, void *dev_id)
 		/* set DMA controller going if any data to transfer */
 		if ((stat & (STAT_MSG|STAT_CD)) == 0
 		    && (scsi_sg_count(cmd) > 0 || scsi_bufflen(cmd))) {
-			nb = scsi_pointer->this_residual;
+			nb = mcmd->this_residual;
 			if (nb > 0xfff0)
 				nb = 0xfff0;
-			scsi_pointer->this_residual -= nb;
+			mcmd->this_residual -= nb;
 			writeb(nb, &regs->count_lo);
 			writeb(nb >> 8, &regs->count_mid);
 			writeb(CMD_DMA_MODE + CMD_NOP, &regs->command);
@@ -294,13 +294,13 @@ static void mac53c94_interrupt(int irq, void *dev_id)
 			cmd_done(state, DID_ERROR << 16);
 			return;
 		}
-		if (scsi_pointer->this_residual != 0
+		if (mcmd->this_residual != 0
 		    && (stat & (STAT_MSG|STAT_CD)) == 0) {
 			/* Set up the count regs to transfer more */
-			nb = scsi_pointer->this_residual;
+			nb = mcmd->this_residual;
 			if (nb > 0xfff0)
 				nb = 0xfff0;
-			scsi_pointer->this_residual -= nb;
+			mcmd->this_residual -= nb;
 			writeb(nb, &regs->count_lo);
 			writeb(nb >> 8, &regs->count_mid);
 			writeb(CMD_DMA_MODE + CMD_NOP, &regs->command);
@@ -322,8 +322,8 @@ static void mac53c94_interrupt(int irq, void *dev_id)
 			cmd_done(state, DID_ERROR << 16);
 			return;
 		}
-		scsi_pointer->Status = readb(&regs->fifo);
-		scsi_pointer->Message = readb(&regs->fifo);
+		mcmd->status = readb(&regs->fifo);
+		mcmd->message = readb(&regs->fifo);
 		writeb(CMD_ACCEPT_MSG, &regs->command);
 		state->phase = busfreeing;
 		break;
@@ -331,8 +331,7 @@ static void mac53c94_interrupt(int irq, void *dev_id)
 		if (intr != INTR_DISCONNECT) {
 			printk(KERN_DEBUG "got intr %x when expected disconnect\n", intr);
 		}
-		cmd_done(state, (DID_OK << 16) + (scsi_pointer->Message << 8)
-			 + scsi_pointer->Status);
+		cmd_done(state, (DID_OK << 16) + (mcmd->message << 8) + mcmd->status);
 		break;
 	default:
 		printk(KERN_DEBUG "don't know about phase %d\n", state->phase);
@@ -390,7 +389,7 @@ static void set_dma_cmds(struct fsc_state *state, struct scsi_cmnd *cmd)
 	dma_cmd += OUTPUT_LAST - OUTPUT_MORE;
 	dcmds[-1].command = cpu_to_le16(dma_cmd);
 	dcmds->command = cpu_to_le16(DBDMA_STOP);
-	mac53c94_scsi_pointer(cmd)->this_residual = total;
+	mac53c94_priv(cmd)->this_residual = total;
 }
 
 static struct scsi_host_template mac53c94_template = {
diff --git a/drivers/scsi/mac53c94.h b/drivers/scsi/mac53c94.h
index 37d7d30f42ef..b4093027f9c3 100644
--- a/drivers/scsi/mac53c94.h
+++ b/drivers/scsi/mac53c94.h
@@ -213,14 +213,14 @@ struct mac53c94_regs {
 #define CF4_BBTE	0x01
 
 struct mac53c94_cmd_priv {
-	struct scsi_pointer scsi_pointer;
+	int this_residual;
+	int status;
+	int message;
 };
 
-static inline struct scsi_pointer *mac53c94_scsi_pointer(struct scsi_cmnd *cmd)
+static inline struct mac53c94_cmd_priv *mac53c94_priv(struct scsi_cmnd *cmd)
 {
-	struct mac53c94_cmd_priv *mcmd = scsi_cmd_priv(cmd);
-
-	return &mcmd->scsi_pointer;
+	return scsi_cmd_priv(cmd);
 }
 
 #endif /* _MAC53C94_H */
-- 
2.32.0

