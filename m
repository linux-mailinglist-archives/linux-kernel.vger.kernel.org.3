Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F81A4E5AAD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 22:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344939AbiCWVbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 17:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240867AbiCWVbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 17:31:37 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6154D36B57;
        Wed, 23 Mar 2022 14:30:06 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C3F325C029B;
        Wed, 23 Mar 2022 17:30:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 23 Mar 2022 17:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:date:date:from:from:in-reply-to
        :message-id:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Eg8kCh
        35bVgzNqBT37lXPEWFs7WWvLSoJufdqAzozYM=; b=KjC61Z+8+N3rkj2QhOZM80
        IDj/Y70UJ5x8pQTF+iUZyVBMLRHE0l8774w8w3nsSrMr5hp5NtF5SWt5uyImugYO
        5U7ObGwGxqiOAHIjaIcyi9SYy5vhLEHKRKvNxXfwoH1P73zRXbOJnl3vqEe0uBj5
        ek8vUv7iDqY/x6k7Bv3VKa96YUEwnEeS6z+8AnTLSFHYNTFf2bZMNBIamjZGWAvS
        4u9loPsb18F0LAgWp4TlzKBZmGSP+yHKsD5pd02hrnYTYcabO635Y4CGs9EH+OZ5
        c/QCs3KDM2mdQ8FnoQwIDkN94kQdz+cGerjqliVV8Tk516Z1Ia4xPMUlBf9OHUSw
        ==
X-ME-Sender: <xms:XZE7YvMhV93_qMFRC5-MXzVrCzdqVBueuYBXhI_vtgiIkxhDanQiJg>
    <xme:XZE7Yp_ik9Tcx_Eku3Ft63yqUI1Pjb9D568cMFfQN1gVzkz254LXKKSduWozx6L5P
    aXFL6Z3qJWLbi2GgWk>
X-ME-Received: <xmr:XZE7YuSvhiQnAA5jSSXqNLHFrwOq1E8fHhoHXpeqFbEGgAjBi3wsiXT8tNed0TB7Y8mUjktZ1WujukdDi2YOk_8TBthiwmVoTJE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegjedgudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefvkffhufffsedttdertddttddtnecuhfhrohhmpefhihhnnhcuvfhhrghi
    nhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtthgvrh
    hnpedtleetkeelkeekvdeujeehkefgvddtheehhfetieethfetfeeghfduheevveelleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrg
    hinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:XZE7Yjsoc7KcNHuCUK4qfhB-Qj_iyijkapF4X83BUt7_1tZKWRyuzA>
    <xmx:XZE7Ynfn1O0eQzPPL7gLWk8CWh5HcCLYqUAPjy3GCRZuT9UDNHMEjQ>
    <xmx:XZE7Yv0TNqDowXO1KCM25djZjIi6mknTIbUHlyHb_qWChjtBiDGgww>
    <xmx:XZE7Yj4cnClSO1G0tr6t7RwWYSbUmbinSvIZqyNDNie1_P9FKNlUHw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Mar 2022 17:30:02 -0400 (EDT)
To:     "Juergen E. Fischer" <fischer@norbit.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "Christoph Hellwig" <hch@infradead.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <bdc1264b6dd331150bffb737958cab8c9c068fa1.1648070977.git.fthain@linux-m68k.org>
From:   Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH] aha152x: Stop using struct scsi_pointer
Date:   Thu, 24 Mar 2022 08:29:37 +1100
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove aha152x_cmd_priv.scsi_pointer by moving the necessary members
into aha152x_cmd_priv proper.

Tested with an Adaptec SlimSCSI APA-1460A card.

Cc: Christoph Hellwig <hch@infradead.org>
Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/scsi/aha152x.c | 235 ++++++++++++++++++++---------------------
 1 file changed, 113 insertions(+), 122 deletions(-)

diff --git a/drivers/scsi/aha152x.c b/drivers/scsi/aha152x.c
index 5f554a3a0f62..35cd04f7be5c 100644
--- a/drivers/scsi/aha152x.c
+++ b/drivers/scsi/aha152x.c
@@ -317,14 +317,18 @@ enum {
 };
 
 struct aha152x_cmd_priv {
-	struct scsi_pointer scsi_pointer;
+	char *ptr;
+	int this_residual;
+	struct scatterlist *buffer;
+	int status;
+	int message;
+	int sent_command;
+	int phase;
 };
 
-static struct scsi_pointer *aha152x_scsi_pointer(struct scsi_cmnd *cmd)
+static struct aha152x_cmd_priv *aha152x_priv(struct scsi_cmnd *cmd)
 {
-	struct aha152x_cmd_priv *acmd = scsi_cmd_priv(cmd);
-
-	return &acmd->scsi_pointer;
+	return scsi_cmd_priv(cmd);
 }
 
 MODULE_AUTHOR("Jürgen Fischer");
@@ -890,17 +894,16 @@ void aha152x_release(struct Scsi_Host *shpnt)
 static int setup_expected_interrupts(struct Scsi_Host *shpnt)
 {
 	if(CURRENT_SC) {
-		struct scsi_pointer *scsi_pointer =
-			aha152x_scsi_pointer(CURRENT_SC);
+		struct aha152x_cmd_priv *acp = aha152x_priv(CURRENT_SC);
 
-		scsi_pointer->phase |= 1 << 16;
+		acp->phase |= 1 << 16;
 
-		if (scsi_pointer->phase & selecting) {
+		if (acp->phase & selecting) {
 			SETPORT(SSTAT1, SELTO);
 			SETPORT(SIMODE0, ENSELDO | (DISCONNECTED_SC ? ENSELDI : 0));
 			SETPORT(SIMODE1, ENSELTIMO);
 		} else {
-			SETPORT(SIMODE0, (scsi_pointer->phase & spiordy) ? ENSPIORDY : 0);
+			SETPORT(SIMODE0, (acp->phase & spiordy) ? ENSPIORDY : 0);
 			SETPORT(SIMODE1, ENPHASEMIS | ENSCSIRST | ENSCSIPERR | ENBUSFREE);
 		}
 	} else if(STATE==seldi) {
@@ -924,17 +927,16 @@ static int setup_expected_interrupts(struct Scsi_Host *shpnt)
 static int aha152x_internal_queue(struct scsi_cmnd *SCpnt,
 				  struct completion *complete, int phase)
 {
-	struct scsi_pointer *scsi_pointer = aha152x_scsi_pointer(SCpnt);
+	struct aha152x_cmd_priv *acp = aha152x_priv(SCpnt);
 	struct Scsi_Host *shpnt = SCpnt->device->host;
 	unsigned long flags;
 
-	scsi_pointer->phase	   = not_issued | phase;
-	scsi_pointer->Status	   = 0x1; /* Ilegal status by SCSI standard */
-	scsi_pointer->Message	   = 0;
-	scsi_pointer->have_data_in = 0;
-	scsi_pointer->sent_command = 0;
+	acp->phase        = not_issued | phase;
+	acp->status       = 0x1; /* Ilegal status by SCSI standard */
+	acp->message      = 0;
+	acp->sent_command = 0;
 
-	if (scsi_pointer->phase & (resetting | check_condition)) {
+	if (acp->phase & (resetting | check_condition)) {
 		if (!SCpnt->host_scribble || SCSEM(SCpnt) || SCNEXT(SCpnt)) {
 			scmd_printk(KERN_ERR, SCpnt, "cannot reuse command\n");
 			return FAILED;
@@ -957,15 +959,15 @@ static int aha152x_internal_queue(struct scsi_cmnd *SCpnt,
 	   SCp.phase            : current state of the command */
 
 	if ((phase & resetting) || !scsi_sglist(SCpnt)) {
-		scsi_pointer->ptr           = NULL;
-		scsi_pointer->this_residual = 0;
+		acp->ptr           = NULL;
+		acp->this_residual = 0;
 		scsi_set_resid(SCpnt, 0);
-		scsi_pointer->buffer        = NULL;
+		acp->buffer        = NULL;
 	} else {
 		scsi_set_resid(SCpnt, scsi_bufflen(SCpnt));
-		scsi_pointer->buffer        = scsi_sglist(SCpnt);
-		scsi_pointer->ptr           = SG_ADDRESS(scsi_pointer->buffer);
-		scsi_pointer->this_residual = scsi_pointer->buffer->length;
+		acp->buffer        = scsi_sglist(SCpnt);
+		acp->ptr           = SG_ADDRESS(acp->buffer);
+		acp->this_residual = acp->buffer->length;
 	}
 
 	DO_LOCK(flags);
@@ -1015,7 +1017,7 @@ static void reset_done(struct scsi_cmnd *SCpnt)
 
 static void aha152x_scsi_done(struct scsi_cmnd *SCpnt)
 {
-	if (aha152x_scsi_pointer(SCpnt)->phase & resetting)
+	if (aha152x_priv(SCpnt)->phase & resetting)
 		reset_done(SCpnt);
 	else
 		scsi_done(SCpnt);
@@ -1101,7 +1103,7 @@ static int aha152x_device_reset(struct scsi_cmnd * SCpnt)
 
 	DO_LOCK(flags);
 
-	if (aha152x_scsi_pointer(SCpnt)->phase & resetted) {
+	if (aha152x_priv(SCpnt)->phase & resetted) {
 		HOSTDATA(shpnt)->commands--;
 		if (!HOSTDATA(shpnt)->commands)
 			SETPORT(PORTA, 0);
@@ -1395,31 +1397,30 @@ static void busfree_run(struct Scsi_Host *shpnt)
 	SETPORT(SSTAT1, CLRBUSFREE);
 
 	if(CURRENT_SC) {
-		struct scsi_pointer *scsi_pointer =
-			aha152x_scsi_pointer(CURRENT_SC);
+		struct aha152x_cmd_priv *acp = aha152x_priv(CURRENT_SC);
 
 #if defined(AHA152X_STAT)
 		action++;
 #endif
-		scsi_pointer->phase &= ~syncneg;
+		acp->phase &= ~syncneg;
 
-		if (scsi_pointer->phase & completed) {
+		if (acp->phase & completed) {
 			/* target sent COMMAND COMPLETE */
-			done(shpnt, scsi_pointer->Status, DID_OK);
+			done(shpnt, acp->status, DID_OK);
 
-		} else if (scsi_pointer->phase & aborted) {
-			done(shpnt, scsi_pointer->Status, DID_ABORT);
+		} else if (acp->phase & aborted) {
+			done(shpnt, acp->status, DID_ABORT);
 
-		} else if (scsi_pointer->phase & resetted) {
-			done(shpnt, scsi_pointer->Status, DID_RESET);
+		} else if (acp->phase & resetted) {
+			done(shpnt, acp->status, DID_RESET);
 
-		} else if (scsi_pointer->phase & disconnected) {
+		} else if (acp->phase & disconnected) {
 			/* target sent DISCONNECT */
 #if defined(AHA152X_STAT)
 			HOSTDATA(shpnt)->disconnections++;
 #endif
 			append_SC(&DISCONNECTED_SC, CURRENT_SC);
-			scsi_pointer->phase |= 1 << 16;
+			acp->phase |= 1 << 16;
 			CURRENT_SC = NULL;
 
 		} else {
@@ -1438,24 +1439,23 @@ static void busfree_run(struct Scsi_Host *shpnt)
 		action++;
 #endif
 
-		if (aha152x_scsi_pointer(DONE_SC)->phase & check_condition) {
+		if (aha152x_priv(DONE_SC)->phase & check_condition) {
 			struct scsi_cmnd *cmd = HOSTDATA(shpnt)->done_SC;
 			struct aha152x_scdata *sc = SCDATA(cmd);
 
 			scsi_eh_restore_cmnd(cmd, &sc->ses);
 
-			aha152x_scsi_pointer(cmd)->Status = SAM_STAT_CHECK_CONDITION;
+			aha152x_priv(cmd)->status = SAM_STAT_CHECK_CONDITION;
 
 			HOSTDATA(shpnt)->commands--;
 			if (!HOSTDATA(shpnt)->commands)
 				SETPORT(PORTA, 0);	/* turn led off */
-		} else if (aha152x_scsi_pointer(DONE_SC)->Status ==
-			   SAM_STAT_CHECK_CONDITION) {
+		} else if (aha152x_priv(DONE_SC)->status == SAM_STAT_CHECK_CONDITION) {
 #if defined(AHA152X_STAT)
 			HOSTDATA(shpnt)->busfree_with_check_condition++;
 #endif
 
-			if(!(aha152x_scsi_pointer(DONE_SC)->phase & not_issued)) {
+			if (!(aha152x_priv(DONE_SC)->phase & not_issued)) {
 				struct aha152x_scdata *sc;
 				struct scsi_cmnd *ptr = DONE_SC;
 				DONE_SC=NULL;
@@ -1480,7 +1480,7 @@ static void busfree_run(struct Scsi_Host *shpnt)
 			if (!HOSTDATA(shpnt)->commands)
 				SETPORT(PORTA, 0);	/* turn led off */
 
-			if (!(aha152x_scsi_pointer(ptr)->phase & resetting)) {
+			if (!(aha152x_priv(ptr)->phase & resetting)) {
 				kfree(ptr->host_scribble);
 				ptr->host_scribble=NULL;
 			}
@@ -1503,13 +1503,12 @@ static void busfree_run(struct Scsi_Host *shpnt)
 	DO_UNLOCK(flags);
 
 	if(CURRENT_SC) {
-		struct scsi_pointer *scsi_pointer =
-			aha152x_scsi_pointer(CURRENT_SC);
+		struct aha152x_cmd_priv *acp = aha152x_priv(CURRENT_SC);
 
 #if defined(AHA152X_STAT)
 		action++;
 #endif
-		scsi_pointer->phase |= selecting;
+		acp->phase |= selecting;
 
 		/* clear selection timeout */
 		SETPORT(SSTAT1, SELTO);
@@ -1537,13 +1536,13 @@ static void busfree_run(struct Scsi_Host *shpnt)
  */
 static void seldo_run(struct Scsi_Host *shpnt)
 {
-	struct scsi_pointer *scsi_pointer = aha152x_scsi_pointer(CURRENT_SC);
+	struct aha152x_cmd_priv *acp = aha152x_priv(CURRENT_SC);
 
 	SETPORT(SCSISIG, 0);
 	SETPORT(SSTAT1, CLRBUSFREE);
 	SETPORT(SSTAT1, CLRPHASECHG);
 
-	scsi_pointer->phase &= ~(selecting | not_issued);
+	acp->phase &= ~(selecting | not_issued);
 
 	SETPORT(SCSISEQ, 0);
 
@@ -1558,12 +1557,12 @@ static void seldo_run(struct Scsi_Host *shpnt)
 
 	ADDMSGO(IDENTIFY(RECONNECT, CURRENT_SC->device->lun));
 
-	if (scsi_pointer->phase & aborting) {
+	if (acp->phase & aborting) {
 		ADDMSGO(ABORT);
-	} else if (scsi_pointer->phase & resetting) {
+	} else if (acp->phase & resetting) {
 		ADDMSGO(BUS_DEVICE_RESET);
 	} else if (SYNCNEG==0 && SYNCHRONOUS) {
-		scsi_pointer->phase |= syncneg;
+		acp->phase |= syncneg;
 		MSGOLEN += spi_populate_sync_msg(&MSGO(MSGOLEN), 50, 8);
 		SYNCNEG=1;		/* negotiation in progress */
 	}
@@ -1578,7 +1577,7 @@ static void seldo_run(struct Scsi_Host *shpnt)
  */
 static void selto_run(struct Scsi_Host *shpnt)
 {
-	struct scsi_pointer *scsi_pointer = aha152x_scsi_pointer(CURRENT_SC);
+	struct aha152x_cmd_priv *acp;
 
 	SETPORT(SCSISEQ, 0);
 	SETPORT(SSTAT1, CLRSELTIMO);
@@ -1586,9 +1585,10 @@ static void selto_run(struct Scsi_Host *shpnt)
 	if (!CURRENT_SC)
 		return;
 
-	scsi_pointer->phase &= ~selecting;
+	acp = aha152x_priv(CURRENT_SC);
+	acp->phase &= ~selecting;
 
-	if (scsi_pointer->phase & aborted)
+	if (acp->phase & aborted)
 		done(shpnt, SAM_STAT_GOOD, DID_ABORT);
 	else if (TESTLO(SSTAT0, SELINGO))
 		done(shpnt, SAM_STAT_GOOD, DID_BUS_BUSY);
@@ -1616,10 +1616,9 @@ static void seldi_run(struct Scsi_Host *shpnt)
 	SETPORT(SSTAT1, CLRPHASECHG);
 
 	if(CURRENT_SC) {
-		struct scsi_pointer *scsi_pointer =
-			aha152x_scsi_pointer(CURRENT_SC);
+		struct aha152x_cmd_priv *acp = aha152x_priv(CURRENT_SC);
 
-		if (!(scsi_pointer->phase & not_issued))
+		if (!(acp->phase & not_issued))
 			scmd_printk(KERN_ERR, CURRENT_SC,
 				    "command should not have been issued yet\n");
 
@@ -1676,7 +1675,7 @@ static void seldi_run(struct Scsi_Host *shpnt)
 static void msgi_run(struct Scsi_Host *shpnt)
 {
 	for(;;) {
-		struct scsi_pointer *scsi_pointer;
+		struct aha152x_cmd_priv *acp;
 		int sstat1 = GETPORT(SSTAT1);
 
 		if(sstat1 & (PHASECHG|PHASEMIS|BUSFREE) || !(sstat1 & REQINIT))
@@ -1714,9 +1713,9 @@ static void msgi_run(struct Scsi_Host *shpnt)
 				continue;
 			}
 
-			scsi_pointer = aha152x_scsi_pointer(CURRENT_SC);
-			scsi_pointer->Message = MSGI(0);
-			scsi_pointer->phase &= ~disconnected;
+			acp = aha152x_priv(CURRENT_SC);
+			acp->message = MSGI(0);
+			acp->phase &= ~disconnected;
 
 			MSGILEN=0;
 
@@ -1724,8 +1723,8 @@ static void msgi_run(struct Scsi_Host *shpnt)
 			continue;
 		}
 
-		scsi_pointer = aha152x_scsi_pointer(CURRENT_SC);
-		scsi_pointer->Message = MSGI(0);
+		acp = aha152x_priv(CURRENT_SC);
+		acp->message = MSGI(0);
 
 		switch (MSGI(0)) {
 		case DISCONNECT:
@@ -1733,11 +1732,11 @@ static void msgi_run(struct Scsi_Host *shpnt)
 				scmd_printk(KERN_WARNING, CURRENT_SC,
 					    "target was not allowed to disconnect\n");
 
-			scsi_pointer->phase |= disconnected;
+			acp->phase |= disconnected;
 			break;
 
 		case COMMAND_COMPLETE:
-			scsi_pointer->phase |= completed;
+			acp->phase |= completed;
 			break;
 
 		case MESSAGE_REJECT:
@@ -1867,11 +1866,9 @@ static void msgi_end(struct Scsi_Host *shpnt)
  */
 static void msgo_init(struct Scsi_Host *shpnt)
 {
-	struct scsi_pointer *scsi_pointer = aha152x_scsi_pointer(CURRENT_SC);
-
 	if(MSGOLEN==0) {
-		if ((scsi_pointer->phase & syncneg) && SYNCNEG==2 &&
-		    SYNCRATE==0) {
+		if ((aha152x_priv(CURRENT_SC)->phase & syncneg) &&
+		    SYNCNEG == 2 && SYNCRATE == 0) {
 			ADDMSGO(IDENTIFY(RECONNECT, CURRENT_SC->device->lun));
 		} else {
 			scmd_printk(KERN_INFO, CURRENT_SC,
@@ -1888,7 +1885,7 @@ static void msgo_init(struct Scsi_Host *shpnt)
  */
 static void msgo_run(struct Scsi_Host *shpnt)
 {
-	struct scsi_pointer *scsi_pointer = aha152x_scsi_pointer(CURRENT_SC);
+	struct aha152x_cmd_priv *acp = aha152x_priv(CURRENT_SC);
 
 	while(MSGO_I<MSGOLEN) {
 		if (TESTLO(SSTAT0, SPIORDY))
@@ -1901,13 +1898,13 @@ static void msgo_run(struct Scsi_Host *shpnt)
 
 
 		if (MSGO(MSGO_I) & IDENTIFY_BASE)
-			scsi_pointer->phase |= identified;
+			acp->phase |= identified;
 
 		if (MSGO(MSGO_I)==ABORT)
-			scsi_pointer->phase |= aborted;
+			acp->phase |= aborted;
 
 		if (MSGO(MSGO_I)==BUS_DEVICE_RESET)
-			scsi_pointer->phase |= resetted;
+			acp->phase |= resetted;
 
 		SETPORT(SCSIDAT, MSGO(MSGO_I++));
 	}
@@ -1936,7 +1933,7 @@ static void msgo_end(struct Scsi_Host *shpnt)
  */
 static void cmd_init(struct Scsi_Host *shpnt)
 {
-	if (aha152x_scsi_pointer(CURRENT_SC)->sent_command) {
+	if (aha152x_priv(CURRENT_SC)->sent_command) {
 		scmd_printk(KERN_ERR, CURRENT_SC,
 			    "command already sent\n");
 		done(shpnt, SAM_STAT_GOOD, DID_ERROR);
@@ -1967,7 +1964,7 @@ static void cmd_end(struct Scsi_Host *shpnt)
 			    "command sent incompletely (%d/%d)\n",
 			    CMD_I, CURRENT_SC->cmd_len);
 	else
-		aha152x_scsi_pointer(CURRENT_SC)->sent_command++;
+		aha152x_priv(CURRENT_SC)->sent_command++;
 }
 
 /*
@@ -1979,7 +1976,7 @@ static void status_run(struct Scsi_Host *shpnt)
 	if (TESTLO(SSTAT0, SPIORDY))
 		return;
 
-	aha152x_scsi_pointer(CURRENT_SC)->Status = GETPORT(SCSIDAT);
+	aha152x_priv(CURRENT_SC)->status = GETPORT(SCSIDAT);
 
 }
 
@@ -2003,7 +2000,7 @@ static void datai_init(struct Scsi_Host *shpnt)
 
 static void datai_run(struct Scsi_Host *shpnt)
 {
-	struct scsi_pointer *scsi_pointer;
+	struct aha152x_cmd_priv *acp;
 	unsigned long the_time;
 	int fifodata, data_count;
 
@@ -2041,36 +2038,35 @@ static void datai_run(struct Scsi_Host *shpnt)
 			fifodata = GETPORT(FIFOSTAT);
 		}
 
-		scsi_pointer = aha152x_scsi_pointer(CURRENT_SC);
-		if (scsi_pointer->this_residual > 0) {
-			while (fifodata > 0 && scsi_pointer->this_residual > 0) {
-				data_count = fifodata > scsi_pointer->this_residual ?
-						scsi_pointer->this_residual :
-						fifodata;
+		acp = aha152x_priv(CURRENT_SC);
+		if (acp->this_residual > 0) {
+			while (fifodata > 0 && acp->this_residual > 0) {
+				data_count = fifodata > acp->this_residual ?
+						acp->this_residual : fifodata;
 				fifodata -= data_count;
 
 				if (data_count & 1) {
 					SETPORT(DMACNTRL0, ENDMA|_8BIT);
-					*scsi_pointer->ptr++ = GETPORT(DATAPORT);
-					scsi_pointer->this_residual--;
+					*acp->ptr++ = GETPORT(DATAPORT);
+					acp->this_residual--;
 					DATA_LEN++;
 					SETPORT(DMACNTRL0, ENDMA);
 				}
 
 				if (data_count > 1) {
 					data_count >>= 1;
-					insw(DATAPORT, scsi_pointer->ptr, data_count);
-					scsi_pointer->ptr += 2 * data_count;
-					scsi_pointer->this_residual -= 2 * data_count;
+					insw(DATAPORT, acp->ptr, data_count);
+					acp->ptr += 2 * data_count;
+					acp->this_residual -= 2 * data_count;
 					DATA_LEN += 2 * data_count;
 				}
 
-				if (scsi_pointer->this_residual == 0 &&
-				    !sg_is_last(scsi_pointer->buffer)) {
+				if (acp->this_residual == 0 &&
+				    !sg_is_last(acp->buffer)) {
 					/* advance to next buffer */
-					scsi_pointer->buffer = sg_next(scsi_pointer->buffer);
-					scsi_pointer->ptr           = SG_ADDRESS(scsi_pointer->buffer);
-					scsi_pointer->this_residual = scsi_pointer->buffer->length;
+					acp->buffer = sg_next(acp->buffer);
+					acp->ptr = SG_ADDRESS(acp->buffer);
+					acp->this_residual = acp->buffer->length;
 				}
 			}
 		} else if (fifodata > 0) {
@@ -2138,15 +2134,15 @@ static void datao_init(struct Scsi_Host *shpnt)
 
 static void datao_run(struct Scsi_Host *shpnt)
 {
-	struct scsi_pointer *scsi_pointer = aha152x_scsi_pointer(CURRENT_SC);
+	struct aha152x_cmd_priv *acp = aha152x_priv(CURRENT_SC);
 	unsigned long the_time;
 	int data_count;
 
 	/* until phase changes or all data sent */
-	while (TESTLO(DMASTAT, INTSTAT) && scsi_pointer->this_residual > 0) {
+	while (TESTLO(DMASTAT, INTSTAT) && acp->this_residual > 0) {
 		data_count = 128;
-		if (data_count > scsi_pointer->this_residual)
-			data_count = scsi_pointer->this_residual;
+		if (data_count > acp->this_residual)
+			data_count = acp->this_residual;
 
 		if(TESTLO(DMASTAT, DFIFOEMP)) {
 			scmd_printk(KERN_ERR, CURRENT_SC,
@@ -2157,26 +2153,25 @@ static void datao_run(struct Scsi_Host *shpnt)
 
 		if(data_count & 1) {
 			SETPORT(DMACNTRL0,WRITE_READ|ENDMA|_8BIT);
-			SETPORT(DATAPORT, *scsi_pointer->ptr++);
-			scsi_pointer->this_residual--;
+			SETPORT(DATAPORT, *acp->ptr++);
+			acp->this_residual--;
 			CMD_INC_RESID(CURRENT_SC, -1);
 			SETPORT(DMACNTRL0,WRITE_READ|ENDMA);
 		}
 
 		if(data_count > 1) {
 			data_count >>= 1;
-			outsw(DATAPORT, scsi_pointer->ptr, data_count);
-			scsi_pointer->ptr           += 2 * data_count;
-			scsi_pointer->this_residual -= 2 * data_count;
+			outsw(DATAPORT, acp->ptr, data_count);
+			acp->ptr += 2 * data_count;
+			acp->this_residual -= 2 * data_count;
 			CMD_INC_RESID(CURRENT_SC, -2 * data_count);
 		}
 
-		if (scsi_pointer->this_residual == 0 &&
-		    !sg_is_last(scsi_pointer->buffer)) {
+		if (acp->this_residual == 0 && !sg_is_last(acp->buffer)) {
 			/* advance to next buffer */
-			scsi_pointer->buffer = sg_next(scsi_pointer->buffer);
-			scsi_pointer->ptr           = SG_ADDRESS(scsi_pointer->buffer);
-			scsi_pointer->this_residual = scsi_pointer->buffer->length;
+			acp->buffer = sg_next(acp->buffer);
+			acp->ptr = SG_ADDRESS(acp->buffer);
+			acp->this_residual = acp->buffer->length;
 		}
 
 		the_time=jiffies + 100*HZ;
@@ -2192,7 +2187,7 @@ static void datao_run(struct Scsi_Host *shpnt)
 
 static void datao_end(struct Scsi_Host *shpnt)
 {
-	struct scsi_pointer *scsi_pointer = aha152x_scsi_pointer(CURRENT_SC);
+	struct aha152x_cmd_priv *acp = aha152x_priv(CURRENT_SC);
 
 	if(TESTLO(DMASTAT, DFIFOEMP)) {
 		u32 datao_cnt = GETSTCNT();
@@ -2211,10 +2206,9 @@ static void datao_end(struct Scsi_Host *shpnt)
 			sg = sg_next(sg);
 		}
 
-		scsi_pointer->buffer = sg;
-		scsi_pointer->ptr = SG_ADDRESS(scsi_pointer->buffer) + done;
-		scsi_pointer->this_residual = scsi_pointer->buffer->length -
-			done;
+		acp->buffer = sg;
+		acp->ptr = SG_ADDRESS(acp->buffer) + done;
+		acp->this_residual = acp->buffer->length - done;
 	}
 
 	SETPORT(SXFRCTL0, CH1|CLRCH1|CLRSTCNT);
@@ -2229,7 +2223,6 @@ static void datao_end(struct Scsi_Host *shpnt)
  */
 static int update_state(struct Scsi_Host *shpnt)
 {
-	struct scsi_pointer *scsi_pointer = aha152x_scsi_pointer(CURRENT_SC);
 	int dataphase=0;
 	unsigned int stat0 = GETPORT(SSTAT0);
 	unsigned int stat1 = GETPORT(SSTAT1);
@@ -2244,7 +2237,7 @@ static int update_state(struct Scsi_Host *shpnt)
 	} else if (stat0 & SELDI && PREVSTATE == busfree) {
 		STATE=seldi;
 	} else if (stat0 & SELDO && CURRENT_SC &&
-		   (scsi_pointer->phase & selecting)) {
+		   (aha152x_priv(CURRENT_SC)->phase & selecting)) {
 		STATE=seldo;
 	} else if(stat1 & SELTO) {
 		STATE=selto;
@@ -2376,8 +2369,7 @@ static void is_complete(struct Scsi_Host *shpnt)
 			SETPORT(SXFRCTL0, CH1);
 			SETPORT(DMACNTRL0, 0);
 			if(CURRENT_SC)
-				aha152x_scsi_pointer(CURRENT_SC)->phase &=
-					~spiordy;
+				aha152x_priv(CURRENT_SC)->phase &= ~spiordy;
 		}
 
 		/*
@@ -2399,8 +2391,7 @@ static void is_complete(struct Scsi_Host *shpnt)
 			SETPORT(DMACNTRL0, 0);
 			SETPORT(SXFRCTL0, CH1|SPIOEN);
 			if(CURRENT_SC)
-				aha152x_scsi_pointer(CURRENT_SC)->phase |=
-					spiordy;
+				aha152x_priv(CURRENT_SC)->phase |= spiordy;
 		}
 
 		/*
@@ -2490,7 +2481,7 @@ static void disp_enintr(struct Scsi_Host *shpnt)
  */
 static void show_command(struct scsi_cmnd *ptr)
 {
-	const int phase = aha152x_scsi_pointer(ptr)->phase;
+	const int phase = aha152x_priv(ptr)->phase;
 
 	scsi_print_command(ptr);
 	scmd_printk(KERN_DEBUG, ptr,
@@ -2538,8 +2529,8 @@ static void show_queues(struct Scsi_Host *shpnt)
 
 static void get_command(struct seq_file *m, struct scsi_cmnd * ptr)
 {
-	struct scsi_pointer *scsi_pointer = aha152x_scsi_pointer(ptr);
-	const int phase = scsi_pointer->phase;
+	struct aha152x_cmd_priv *acp = aha152x_priv(ptr);
+	const int phase = acp->phase;
 	int i;
 
 	seq_printf(m, "%p: target=%d; lun=%d; cmnd=( ",
@@ -2549,8 +2540,8 @@ static void get_command(struct seq_file *m, struct scsi_cmnd * ptr)
 		seq_printf(m, "0x%02x ", ptr->cmnd[i]);
 
 	seq_printf(m, "); resid=%d; residual=%d; buffers=%d; phase |",
-		scsi_get_resid(ptr), scsi_pointer->this_residual,
-		sg_nents(scsi_pointer->buffer) - 1);
+		scsi_get_resid(ptr), acp->this_residual,
+		sg_nents(acp->buffer) - 1);
 
 	if (phase & not_issued)
 		seq_puts(m, "not issued|");
-- 
2.32.0

