Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4F34DD18E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 01:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiCRACS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 20:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiCRACQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 20:02:16 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6889C17AD92;
        Thu, 17 Mar 2022 17:00:58 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id x15so9578050wru.13;
        Thu, 17 Mar 2022 17:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IIXshEu2SisdlfyC9FOixjGVdzZatqacST7BF1cavuM=;
        b=CvfZ6nWFFRgf4JTHcIc5nt1kAhXSUr0ukL0Z48c8FAOwdK9Ee4fYROqjl6YwfDq91e
         0AHh6SL/gAnETrsJgk2FLZdpTDvF88MQndNafFnUvMLHna5RLFI3fxMr80hTsRuNQwOe
         pw9hRGpx/aGgBaS/hbjoT2M8Cqe1aSl4ND8W5JxpPpy4U+UWf1tyI8R5UeIoIIkciYkL
         rCF13ws+idDApGAgqo5o1aNHRSndWdAfqLdsrtpbVVZGL9SLxOV2gfztQR1bDRDEVR4N
         nGzHfFy9gc+HS+FNpbTiiRkEcw5D0O+/JmHv4q69EljIM4MVimLJxpkCputzm//x5W2Z
         818Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IIXshEu2SisdlfyC9FOixjGVdzZatqacST7BF1cavuM=;
        b=I2cQwqhPq9jRvNrOcp2YJq7vndG2s7NyDbqEWxmvejot53VjukZWVeCF54i0QfOCPl
         FCFiNaBL2acHUBy1r4WPZI5VjJ7IKjXpgZK68IgILXPkO1n4CxOJ7sS0RFoaJiDrDFy7
         2FwjLlDyLcUs4EkCJ6MAzwyPTmACJtRNVkYqYzFRhOEzzCRf0BZvWAbRzDlWyVSmbprw
         B9vxJ56CGFR2g84E1PRmtGMz76oKpbM9vaGyFxcFjXV20mlwWn2DJtVUtryo4krUiCKE
         U2UfTKwu/XDA8MRMYhClfaEAyyOCx053A1q1ysW8QpfJ1bubgSRfsl9uXe5Hd3iL+kWd
         u3Ng==
X-Gm-Message-State: AOAM530Wag1ZvzM780jDrIPozXoTKUsACWoADAKimcLsHF8p2iCGfWfG
        gAlEs+s4UJK1+ETpOeSWTGI=
X-Google-Smtp-Source: ABdhPJwyHsR2ZNVPsAvwcWnVhCNDiDCSshChLqWoCBzEErGVywBumpsRGk2DMjPx57WaR9Bfl2JdtA==
X-Received: by 2002:adf:ebd0:0:b0:1e3:f9b:7b77 with SMTP id v16-20020adfebd0000000b001e30f9b7b77mr5717458wrn.691.1647561657036;
        Thu, 17 Mar 2022 17:00:57 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id w6-20020adfee46000000b001e4bf01bdfbsm4973862wro.46.2022.03.17.17.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 17:00:56 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     David Airlie <airlied@linux.ie>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] amd64-agp: remove redundant assignment to variable i
Date:   Fri, 18 Mar 2022 00:00:55 +0000
Message-Id: <20220318000055.79280-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Variable i is being assigned a value that is never read, it is being
re-assigned later in a for-loop. The assignment is redundant and can
be removed.

Cleans up clang scan build warning:
drivers/char/agp/amd64-agp.c:336:2: warning: Value stored to 'i' is
never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/char/agp/amd64-agp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/agp/amd64-agp.c b/drivers/char/agp/amd64-agp.c
index dc78a4fb879e..5f64991c73bf 100644
--- a/drivers/char/agp/amd64-agp.c
+++ b/drivers/char/agp/amd64-agp.c
@@ -333,7 +333,6 @@ static int cache_nbs(struct pci_dev *pdev, u32 cap_ptr)
 	if (!amd_nb_has_feature(AMD_NB_GART))
 		return -ENODEV;
 
-	i = 0;
 	for (i = 0; i < amd_nb_num(); i++) {
 		struct pci_dev *dev = node_to_amd_nb(i)->misc;
 		if (fix_northbridge(dev, pdev, cap_ptr) < 0) {
-- 
2.35.1

