Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A37547D79
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 03:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbiFMBqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 21:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiFMBqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 21:46:42 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF3346142
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 18:46:41 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id e24so4372999pjt.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 18:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d982/aSW19dbRHulNAiy7axeXdDcRD3fsM+YQicazi0=;
        b=Q5RmprYS1EtFAA2aqzCN4Up/BjqC8aghUf5a/+9PtgDia2/+oZVXBG0FRdDPiz2hec
         pKrsvKWse+NTUDazwWFd9hkbnVn3u2NCpYAJifakMdA0aPqJO+CM3OtN6Zdd4pgHBUAd
         75lliXEdi6cb1Q66T7BWcPxcTOWbUBsEbQ3PNx/ou0QgMjwmsn1ZBQFakVGmB3F4LFM8
         HeM4CKsV+CnH6H1wFSZbv+K4g2tVEGTLE36Q9UbXYT6OduMDxhN4G9pUqzXTbEMN38TO
         /a7p5fnBXmk2xnZIRi9dLe1el+Eatk0V6DADbbvEN0s0F9StJVqBFjl5mhDEBxTJpXgo
         lyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d982/aSW19dbRHulNAiy7axeXdDcRD3fsM+YQicazi0=;
        b=txJCmhwid+lhacWXXpqoiGezfkhdbbi+VQ41wcyQ49NUXEeiEZD9ZzajLjLyg5E7N5
         SMjQ3/fDbrrIEvuYOi0a5GxXqvq1jZYsTEhhRM1/vDigIKBryUIryPT79AoThYBK3IIz
         L5wnmEz8Y65M+tLx7VyPw4rc5kgCAkfpnqrxLniIK85+I43HOrok6cwLdFDkna13U0q3
         8wMGTq+ktow/6X2shh5K4iFk/JaBMInZDpIM1sat9w9/rsgr6X5ImU9so3r0J/H9lBYz
         5flAgC4pLea2HgC4TxnySgbY6GzvZ/JNQfNG5/8W/u0m9MOznqPEkaG+rTTlVKGptKjN
         CeXw==
X-Gm-Message-State: AOAM530JEUtHuB/hVJJhRY2gX2oJczEqbpkisipuGTYMsX8ZYkPBIu0X
        ga6qWakKmMigjMvEka99GC/N6cxlcNSgUZGy
X-Google-Smtp-Source: ABdhPJxKL1TNlq6Q9kqIabLqA+p3CT+97NvRAN/yh00ehPixbw04TXoNAI7LZXxBMY6hm2ITEVywLQ==
X-Received: by 2002:a17:90a:a605:b0:1ea:6b4f:915e with SMTP id c5-20020a17090aa60500b001ea6b4f915emr12938046pjq.60.1655084801035;
        Sun, 12 Jun 2022 18:46:41 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id f13-20020a170902f38d00b0016413dbbf92sm3675466ple.234.2022.06.12.18.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 18:46:40 -0700 (PDT)
From:   luoxueqin <luoxueqin66@gmail.com>
X-Google-Original-From: luoxueqin <937225041@qq.com>
To:     jk@ozlabs.org, joel@jms.id.au
Cc:     alistair@popple.id.au, eajames@linux.ibm.com,
        linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Luo Xueqin <luoxueqin@kylinos.cn>, k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH v2] fsi: Fix typo in comment
Date:   Mon, 13 Jun 2022 09:46:24 +0800
Message-Id: <20220613014624.175285-1-937225041@qq.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luo Xueqin <luoxueqin@kylinos.cn>

Spelling mistake in comment.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Luo Xueqin <luoxueqin@kylinos.cn>
---

v2: add discoverers

 drivers/fsi/fsi-master.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-master.h b/drivers/fsi/fsi-master.h
index cd6bee5e12a7..4762315a46ba 100644
--- a/drivers/fsi/fsi-master.h
+++ b/drivers/fsi/fsi-master.h
@@ -51,7 +51,7 @@
 #define FSI_MMODE_CRS1SHFT	8		/* Clk rate selection 1 shift */
 #define FSI_MMODE_CRS1MASK	0x3ff		/* Clk rate selection 1 mask */
 
-/* MRESB: Reset brindge */
+/* MRESB: Reset bridge */
 #define FSI_MRESB_RST_GEN	0x80000000	/* General reset */
 #define FSI_MRESB_RST_ERR	0x40000000	/* Error Reset */
 
-- 
2.25.1

