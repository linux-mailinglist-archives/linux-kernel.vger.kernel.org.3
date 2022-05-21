Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC57552FBDA
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 13:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355273AbiEUL0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 07:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345604AbiEULOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 07:14:46 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5B213F933;
        Sat, 21 May 2022 04:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=y5bDNelPvC1Af06qeU1zinzPlEpQHukBeO/ewLou8cw=;
  b=g48IdpdKNFc1DU+zmQi98JsJgCIoNUf10IuIZginiE3qDiAKv3jIPQMb
   CXAbsvhG/PxEyi4iPZm6gEvSgepfIm/1Ujx4hv0HEFCMPOOBSXG3OAZsR
   T3sPcJ2DsMDBR6kG00QPzl6otqxr65Fsot6U9zdpd4+91+J6Xkqq9YZ7z
   U=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="14728003"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:12:09 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel-janitors@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tty: fix typos in comments
Date:   Sat, 21 May 2022 13:11:45 +0200
Message-Id: <20220521111145.81697-95-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spelling mistakes (triple letters) in comments.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/tty/mips_ejtag_fdc.c |    2 +-
 drivers/tty/tty_io.c         |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/mips_ejtag_fdc.c b/drivers/tty/mips_ejtag_fdc.c
index 31dceb5039b5..49907427a165 100644
--- a/drivers/tty/mips_ejtag_fdc.c
+++ b/drivers/tty/mips_ejtag_fdc.c
@@ -1222,7 +1222,7 @@ static void kgdbfdc_push_one(void)
 
 	/* Construct a word from any data in buffer */
 	word = mips_ejtag_fdc_encode(bufs, &kgdbfdc_wbuflen, 1);
-	/* Relocate any remaining data to beginnning of buffer */
+	/* Relocate any remaining data to beginning of buffer */
 	kgdbfdc_wbuflen -= word.bytes;
 	for (i = 0; i < kgdbfdc_wbuflen; ++i)
 		kgdbfdc_wbuf[i] = kgdbfdc_wbuf[i + word.bytes];
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 8fec1d8648f5..82a8855981f7 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1663,7 +1663,7 @@ void tty_kclose(struct tty_struct *tty)
 	 */
 	tty_ldisc_release(tty);
 
-	/* Wait for pending work before tty destruction commmences */
+	/* Wait for pending work before tty destruction commences */
 	tty_flush_works(tty);
 
 	tty_debug_hangup(tty, "freeing structure\n");

