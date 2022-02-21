Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915884BEEC8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 02:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237110AbiBUXlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 18:41:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbiBUXlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 18:41:19 -0500
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E5D245A8;
        Mon, 21 Feb 2022 15:40:54 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.west.internal (Postfix) with ESMTP id B42D22B00234;
        Mon, 21 Feb 2022 18:23:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 21 Feb 2022 18:23:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:date:date:from:from:in-reply-to
        :message-id:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=dGwM6z
        CAZezD9UAOkbQM1FyRcimaQ2GZliBAK4GzXRc=; b=K624Q5LtzhKisanNhHxmUl
        4AlQx8iTOn46MbDafdQfuJRNz/chZrzm7JugXOq+bef3SR77slDYEW5jlKoWss3a
        mqoDdVU5o/+UEmScKwnKI5LE1h0PqH49BNz+Dg2RwlgUroKHRtVMrUigP3bLdzir
        9dlpaexcuD2XptsC1jWSM+qCdw/6lmU0gBWy/LRwDsO8tzIpGI2FMgMTuYTZZBOV
        wSwnhxlUZd7k9y+HbQiQNitMNGw4lAYySPeCi06XRO6TqP7Ea7CLMwtcK/sfLSwX
        4c4Nc3omlKdZdC3d5kt2FW5gPzN3A0yxZ0hiJzgyFpBM/CFIi4tgpWXXN9i9Zjgw
        ==
X-ME-Sender: <xms:AR8UYlD0GaPkHt7D9oHky_-MO2OCxg_NwyAWBF-c7gMt14pwTi1Emg>
    <xme:AR8UYjgCQ6XMUj5G30BTXNw492Wxp3VjStVvPU6VqZfXfIzIHc1LGezzsXOpHqrs7
    ByrpcN3jz8erTBM0TE>
X-ME-Received: <xmr:AR8UYgmahiQ_r0xt7dI5IFWD76nfzgCov5tv_ixy6caNFy2Jd5Hrc1YDfXpLOfDdy7m5xUdLakfwiFue4cP47ci85LWOErz64U8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrkeejgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    fhohhrsghiugguvghnjfgurhculdehtddtmdenucfjughrpefvkffhufffsedttdertddt
    tdenucfhrhhomhephfhinhhnucfvhhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmie
    ekkhdrohhrgheqnecuhfhorhgsihguuggvnhfjughrpefvkffhufffsedttdertddttddp
    vffkhffuffestddtredttddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepfhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:AR8UYvwX444dA81EMWJSsQ1H1tCfQJxUbbblLdmjnVfok6YMsYhiOg>
    <xmx:AR8UYqRi0b4ErocgIbZ19LM2epQvjXmw4u41PSP-tCF4fXFQJ3NmHg>
    <xmx:AR8UYib03AWo6dJnUXF7snUplEQdL-Vs2xhA6TUWIqFjn83hs4Hj_g>
    <xmx:Ah8UYlegwH_YYIAi7N9IBATIZxIBiHnl8HM4zrZDBAGSYAiswlRxxQpq6q0>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Feb 2022 18:23:43 -0500 (EST)
To:     "Juergen E. Fischer" <fischer@norbit.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <4e17ff7295a96e31ed21ccb250c65b56c173b530.1645484982.git.fthain@linux-m68k.org>
From:   Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH] aha152x: Clean up struct scsi_pointer usage
Date:   Tue, 22 Feb 2022 10:09:42 +1100
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bring aha152x into line with 10 other drivers which assign
scsi_host_template.cmd_size = sizeof(struct scsi_pointer)
and avoid the "struct foo { struct bar; };" silliness.

Remove a pointless scsi_pointer->have_data_in assignment.

Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/scsi/aha152x.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/aha152x.c b/drivers/scsi/aha152x.c
index 34b2378075fd..70f49fba66be 100644
--- a/drivers/scsi/aha152x.c
+++ b/drivers/scsi/aha152x.c
@@ -316,15 +316,9 @@ enum {
 	check_condition = 0x0800,	/* requesting sense after CHECK CONDITION */
 };
 
-struct aha152x_cmd_priv {
-	struct scsi_pointer scsi_pointer;
-};
-
 static struct scsi_pointer *aha152x_scsi_pointer(struct scsi_cmnd *cmd)
 {
-	struct aha152x_cmd_priv *acmd = scsi_cmd_priv(cmd);
-
-	return &acmd->scsi_pointer;
+	return scsi_cmd_priv(cmd);
 }
 
 MODULE_AUTHOR("Jürgen Fischer");
@@ -931,7 +925,6 @@ static int aha152x_internal_queue(struct scsi_cmnd *SCpnt,
 	scsi_pointer->phase	   = not_issued | phase;
 	scsi_pointer->Status	   = 0x1; /* Ilegal status by SCSI standard */
 	scsi_pointer->Message	   = 0;
-	scsi_pointer->have_data_in = 0;
 	scsi_pointer->sent_command = 0;
 
 	if (scsi_pointer->phase & (resetting | check_condition)) {
@@ -2971,7 +2964,7 @@ static struct scsi_host_template aha152x_driver_template = {
 	.sg_tablesize			= SG_ALL,
 	.dma_boundary			= PAGE_SIZE - 1,
 	.slave_alloc			= aha152x_adjust_queue,
-	.cmd_size			= sizeof(struct aha152x_cmd_priv),
+	.cmd_size			= sizeof(struct scsi_pointer),
 };
 
 #if !defined(AHA152X_PCMCIA)
-- 
2.32.0

