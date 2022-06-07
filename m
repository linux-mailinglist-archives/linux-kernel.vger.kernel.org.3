Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA57553FC71
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242269AbiFGKyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242348AbiFGKuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:50:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F00F689E;
        Tue,  7 Jun 2022 03:49:57 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2911B1F956;
        Tue,  7 Jun 2022 10:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654598996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KJ1L1yUt71KhIKI/OFm/0Ciu3BjY1s3Lj1SSUNSHftw=;
        b=NXYkxL0LF0l7BUxUj2uPu4myCtmGNYgU6rOvGywRHyJsHZ/zPPStto+8r/DYpWJuAKpj44
        0CrJ3ZgYwznpPxPWIeyMBtjFC0TwSOeIkJD7+oSmukqiUEDthbv4zucPakuGD2cFl06+Q9
        iI1wpn8seeO0Wf9+qkGXgcIGwEM/DfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654598996;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KJ1L1yUt71KhIKI/OFm/0Ciu3BjY1s3Lj1SSUNSHftw=;
        b=Q0W8xdtwOSh7Qp3e3Le3TMoqGFE9+atkoc9YOb5tzaj4bSCJ+qU/NqTAnhREnuN5i3E7Cj
        It0oRbADaLaz4VBQ==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0128C2C141;
        Tue,  7 Jun 2022 10:49:55 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 32/36] tty/vt: consolemap: remove superfluous whitespace
Date:   Tue,  7 Jun 2022 12:49:42 +0200
Message-Id: <20220607104946.18710-32-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607104946.18710-1-jslaby@suse.cz>
References: <20220607104946.18710-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are still some remaining tabs/spaces at EOLs or spaces before
tabs. Remove them all now.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/consolemap.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index a9b497ffb346..01b7e49f1f91 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -220,7 +220,7 @@ static void set_inverse_transl(struct vc_data *conp, struct uni_pagedict *p,
 	int j, glyph;
 	unsigned short *t = translations[m];
 	unsigned char *q;
-	
+
 	if (!p)
 		return;
 	q = p->inverse_translations[m];
@@ -236,7 +236,7 @@ static void set_inverse_transl(struct vc_data *conp, struct uni_pagedict *p,
 		glyph = conv_uni_to_pc(conp, t[j]);
 		if (glyph >= 0 && glyph < MAX_GLYPH && q[glyph] < 32) {
 			/* prefer '-' above SHY etc. */
-		  	q[glyph] = j;
+			q[glyph] = j;
 		}
 	}
 }
@@ -320,7 +320,7 @@ static void update_user_maps(void)
 {
 	int i;
 	struct uni_pagedict *p, *q = NULL;
-	
+
 	for (i = 0; i < MAX_NR_CONSOLES; i++) {
 		if (!vc_cons_allocated(i))
 			continue;
@@ -403,7 +403,7 @@ int con_get_trans_new(ushort __user * arg)
 }
 
 /*
- * Unicode -> current font conversion 
+ * Unicode -> current font conversion
  *
  * A font has at most 512 chars, usually 256.
  * But one font position may represent several Unicode chars.
@@ -455,7 +455,7 @@ void con_free_unimap(struct vc_data *vc)
 	con_release_unimap(p);
 	kfree(p);
 }
-  
+
 static int con_unify_unimap(struct vc_data *conp, struct uni_pagedict *dict1)
 {
 	struct uni_pagedict *dict2;
@@ -688,7 +688,7 @@ int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
  *	Loads the unimap for the hardware font, as defined in uni_hash.tbl.
  *	The representation used was the most compact I could come up
  *	with.  This routine is executed at video setup, and when the
- *	PIO_FONTRESET ioctl is called. 
+ *	PIO_FONTRESET ioctl is called.
  *
  *	The caller must hold the console lock
  */
@@ -893,11 +893,11 @@ int conv_uni_to_pc(struct vc_data *conp, long ucs)
  * initialized.  It must be possible to call kmalloc(..., GFP_KERNEL)
  * from this function, hence the call from sys_setup.
  */
-void __init 
+void __init
 console_map_init(void)
 {
 	int i;
-	
+
 	for (i = 0; i < MAX_NR_CONSOLES; i++)
 		if (vc_cons_allocated(i) && !*vc_cons[i].d->vc_uni_pagedir_loc)
 			con_set_default_unimap(vc_cons[i].d);
-- 
2.36.1

