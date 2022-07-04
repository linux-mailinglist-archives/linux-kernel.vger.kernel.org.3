Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2773565FC8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 01:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiGDXzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 19:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGDXzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 19:55:40 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6842F6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 16:55:39 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id o6so4557625vkl.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 16:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=HXqolatL4SQyTj0ceko5Sk5ywE4eu7yu5fe1t3jCDWo=;
        b=moyHZjjONm0sHNE/3+KuiHTSDbgygmcRVtp3+trbxbNTNGtjKHiFa5jeSx6hoG6J2N
         N8v1cyUIXXdQpL0mi5gceS+HofQgSdc7Jn21OcTKfDakM7gbYgtLrhsO6slaFD4QiiF9
         4cjd1hEeyy16PG4RkOngUNgiVPyVEHwptwVrUJkncxq/n0Egj3nmKnEAnA8PGrU97zLR
         GUL1r9cVhtjQbRsT9HhnUOFgbyil1YaTxvto3qKIIJLJb7it9T54jsd0bBZuoKR3QcN9
         nq76VDGNWUpoduax5Chr0W6IlCulYP5adtUSlf0O5suGUZ9n6Ro09lOr+22XyqHoRMM9
         U/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=HXqolatL4SQyTj0ceko5Sk5ywE4eu7yu5fe1t3jCDWo=;
        b=cy1MZzCghgYMXsC91YFPFIP1ugpTx/EP1KStp2NTBRe7zO6PZgP/fg8j1oxA/XC9uc
         GPZwMzWSFqj0CVEgWAPzNRbXJG2BW+qG1Y6JFO90gfz1wYc/tVOEKzStY1i+3I7mHYKD
         dquWn4Dgw4zB3dTrUpK+G4T3NGNVDTacRCV3lJjy3FePKJmoKSIArI+XejZVuPtqfa7+
         CCbY2gayOo9IvzIziOw0vsZa739V4wfLU4+1RmNMmHGpu/B4OrJJ9F8h0ZhXA+w4tLJH
         ZJgqLD19pm+ODmRGCQh4+ctjDqSxfmBnFucdgSlHzkbUBKSVpCqY3KnFHyae0E46dAIy
         fVGA==
X-Gm-Message-State: AJIora/hcR3PbRnMHpz949YvPoxT4vNCZBJJEybb/a83+8LwYAZw+9kM
        0Nh1ksJIpdOadmOH8zGptZIzuPL9u8bp0MUx
X-Google-Smtp-Source: AGRyM1tSX4aKlsRsBc8BTpf9MeuTfq3Jabrgf+G95rta6HR3FXWVh0tQcPmh2hM+Y31hxnNRD4TErg==
X-Received: by 2002:a1f:abc3:0:b0:370:e9bb:9779 with SMTP id u186-20020a1fabc3000000b00370e9bb9779mr5458676vke.38.1656978938484;
        Mon, 04 Jul 2022 16:55:38 -0700 (PDT)
Received: from debianmain ([190.236.207.56])
        by smtp.gmail.com with ESMTPSA id f185-20020a1f51c2000000b0036c691b1ea8sm5426542vkb.33.2022.07.04.16.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 16:55:38 -0700 (PDT)
Date:   Mon, 4 Jul 2022 18:55:35 -0500
From:   Rommel Rodriguez Perez <alrodperez@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: r8188eu: Block comments use * on subsequent lines
Message-ID: <YsN993FTljv5LYT3@debianmain.debian.pc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch modifies a comment in order for it to comply with Linux
Kernel style guidelines on comments belonging to  net/ or drivers/net/ by
fixing the missing * at the beginning of each comment line and removing
the initial almost-blank initial line from the comment block.

checkpatch output:
WARNING: Block comments use * on subsequent lines

Signed-off-by: Rommel Rodriguez Perez <alrodperez@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ap.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index ac6effbecf6d..5bd9dfa57cc5 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -654,18 +654,17 @@ void update_beacon(struct adapter *padapter, u8 ie_id, u8 *oui, u8 tx)
 		set_tx_beacon_cmd(padapter);
 }
 
-/*
-op_mode
-Set to 0 (HT pure) under the following conditions
-	- all STAs in the BSS are 20/40 MHz HT in 20/40 MHz BSS or
-	- all STAs in the BSS are 20 MHz HT in 20 MHz BSS
-Set to 1 (HT non-member protection) if there may be non-HT STAs
-	in both the primary and the secondary channel
-Set to 2 if only HT STAs are associated in BSS,
-	however and at least one 20 MHz HT STA is associated
-Set to 3 (HT mixed mode) when one or more non-HT STAs are associated
-	(currently non-GF HT station is considered as non-HT STA also)
-*/
+/* op_mode
+ * Set to 0 (HT pure) under the following conditions
+ *	- all STAs in the BSS are 20/40 MHz HT in 20/40 MHz BSS or
+ *	- all STAs in the BSS are 20 MHz HT in 20 MHz BSS
+ * Set to 1 (HT non-member protection) if there may be non-HT STAs
+ *	in both the primary and the secondary channel
+ * Set to 2 if only HT STAs are associated in BSS,
+ *	however and at least one 20 MHz HT STA is associated
+ * Set to 3 (HT mixed mode) when one or more non-HT STAs are associated
+ *	(currently non-GF HT station is considered as non-HT STA also)
+ */
 static int rtw_ht_operation_update(struct adapter *padapter)
 {
 	u16 cur_op_mode, new_op_mode;
-- 
2.30.2

