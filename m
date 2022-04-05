Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332B24F4FE3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1839898AbiDFBGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573147AbiDESCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 14:02:01 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC68EBB9D;
        Tue,  5 Apr 2022 11:00:01 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id w4so20488284wrg.12;
        Tue, 05 Apr 2022 11:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ps9sabn/FLiol/hOAkHVK8/MzrVBlohNvXit/I8IEYc=;
        b=R44RXszOTrCfg9a6xQntX7eXLlcenLZQ79iHWwZfWh9PijVC/UjlQitBO/Yt/Wq/W5
         dTA4dRF74W0DLZK0MUpa6PxqZxtBFxQmoUyDUjy0e4JVi5WXu/xU+Y1Hzb7op13pN/t1
         Vco1rVX5eqUYMewLGvFa+zlth4/k7DCJ+ThdQOvI7x0KHIQ5FaPPk/UWHJC1orymLQX4
         7XSCpRaubPqT0f6R2D/NEp8qzZ0wueIQDW44oLsn/B677uMWwY0PSYg/po63Ac2Z5RkA
         BLP8vayDRRtqY/sys3mO8EU3v1ruGqddsM+LoJibpZoG4yzJujdjCt1+X2uICb0xzSeQ
         swXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ps9sabn/FLiol/hOAkHVK8/MzrVBlohNvXit/I8IEYc=;
        b=1OAgLFHfQ6LCXk2se/Fx8MowrtwgUHu+r+8eR2bLNVxhV+7Px0ZkBgV4mI2BgYS1fv
         fvSgyS/DOxllkVRBNVLsdP8WXXUr7ft9TAP7cdjtXgTrGaVvlm4w/uqFe7T5gMniWA6t
         E/YQpMxKW6zc6ZS2IKk+hWJkh/QgdhSTPjKPPTJPDp1mTXnB36ozXtTf98+b3qPqM/n2
         Aw79UVnTh5pd1SIJLktRXcHTwMNfb4QjC/9r/Hf4w7N/KZ76Z9cBc/CRXO9gCi+Uihb2
         GNJclavOv2Hnq9pQkZTyqYdhiIxVlObnD+54t+giQqode3fLTzlRcIsB5UM2RqpzXN4E
         uKUg==
X-Gm-Message-State: AOAM5309NQ0h/oYmjB2wHLcF0dNCP5wx751JG6Go4dd0zCEnSYTzlfUw
        6dD+nUQeQhhOU1Z4hraB/PQ=
X-Google-Smtp-Source: ABdhPJzPk+TK/I+NTaHUbvTpHCArFr87ss2K8cjZe77v1loJE5zgGUwLw+jFL7OH+UyTRqfqB5ZSBw==
X-Received: by 2002:a5d:5608:0:b0:206:11c2:b65d with SMTP id l8-20020a5d5608000000b0020611c2b65dmr3663036wrv.215.1649181600255;
        Tue, 05 Apr 2022 11:00:00 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id k9-20020adfb349000000b00206101fc58fsm6898756wrd.110.2022.04.05.10.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 10:59:59 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: platform: samsung: remove redundant assignment to variable m
Date:   Tue,  5 Apr 2022 18:59:59 +0100
Message-Id: <20220405175959.223443-1-colin.i.king@gmail.com>
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

The variable m is being assigned a value that is never read, it
is being re-assigned in both paths of the following if-statement.
The assignment is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/media/platform/samsung/s5p-jpeg/jpeg-hw-s5p.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/samsung/s5p-jpeg/jpeg-hw-s5p.c b/drivers/media/platform/samsung/s5p-jpeg/jpeg-hw-s5p.c
index 01b47b3df1e7..33e6e85dfd78 100644
--- a/drivers/media/platform/samsung/s5p-jpeg/jpeg-hw-s5p.c
+++ b/drivers/media/platform/samsung/s5p-jpeg/jpeg-hw-s5p.c
@@ -52,7 +52,6 @@ void s5p_jpeg_proc_mode(void __iomem *regs, unsigned long mode)
 {
 	unsigned long reg, m;
 
-	m = S5P_PROC_MODE_DECOMPR;
 	if (mode == S5P_JPEG_ENCODE)
 		m = S5P_PROC_MODE_COMPR;
 	else
-- 
2.35.1

