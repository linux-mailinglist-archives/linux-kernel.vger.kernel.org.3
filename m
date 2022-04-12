Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AF14FE861
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 20:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358916AbiDLTAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 15:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358804AbiDLTAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 15:00:22 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9979443E1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 11:58:03 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id t11so12186355eju.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 11:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lAx29rsGmYrRtuHSy3SVZVdgmsTmcr+upgwDNcDWyIo=;
        b=d/LLJuopT/ZXleD5Fypemy5GCidPE/yQ3zRgnu/aZKx5k3Klc9MpAZzhask9BMzhBT
         sCKZoHwr70psALNIRMJvYcTa1SCN/U0W8mR2akyTRHA9nmIQ2XyzdS8PJpRFrilBgWi+
         0gAjsLkDpaSiuFDmDvcUu94KOJpc+cPpWXVimiRWYyC5J7ndkDeDI+rvoKCuyU10g3A/
         tI03ffvzjGfvpaZDRgMGtI/z3e+/1RuyQeoFV3FBPLBsXhxOi3/Qdj3fKkRIoxfkuiUU
         /SgxlzxJhKLCNLGRML1xdqjIgl1Fyb1N9x/X6gSohH1/T/a3WJBi+ROfde2wJgZaVoyI
         93VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lAx29rsGmYrRtuHSy3SVZVdgmsTmcr+upgwDNcDWyIo=;
        b=XisTUyXjuZnqjvkl3FdyJaxGzxdl7S3MYISkqoLsGT6VgYYY7gLk2CYvjlKFu/8FaJ
         vSUsvJ/OCgmNziwgnWLqh1aUGIryKjnQlENKBFocUCsRFrHCsakM7NGxuFFq/cee/DxK
         69XMbwhmvlFdpROvjw4MRWz3VCdlAkENPUgbrJs6THRH6JU+88abQTkGU8bY69XlKHio
         9MqmuqCuTmqwTXAPr6uRwor47COoemWkdGzwJrDbYs8wjI27DDYmEELrRYn/LaoNE4Jh
         QvZ/M7W+Hs0Iur3pFJKKSotEJbqRDJ3tOU3X3yvX/BVTcxlgTM8/PTyTuTlRfMEzbvfr
         Kwzw==
X-Gm-Message-State: AOAM530w9MUqEZ9e9d+RPuKop9H2dorzEw9y4wRt6VlGqyzvGYsBwwxF
        8wcvAaf+v/sYqFVnB93K3bM=
X-Google-Smtp-Source: ABdhPJyl2n5ClHnRWbhDGJ7VenGf6szL1MzoI3o26vEmOqEjj4TfphLwUj6MYAqpfNuQ1Z/YAJ2rpw==
X-Received: by 2002:a17:907:7242:b0:6da:b561:d523 with SMTP id ds2-20020a170907724200b006dab561d523mr34491209ejc.118.1649789882375;
        Tue, 12 Apr 2022 11:58:02 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb6b.dynamic.kabel-deutschland.de. [95.90.187.107])
        by smtp.gmail.com with ESMTPSA id q22-20020a170906771600b006cf8a37ebf5sm13443482ejm.103.2022.04.12.11.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 11:58:01 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/6] staging: r8188eu: correct macro spelling mistake
Date:   Tue, 12 Apr 2022 20:57:49 +0200
Message-Id: <20220412185754.8695-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412185754.8695-1-straube.linux@gmail.com>
References: <20220412185754.8695-1-straube.linux@gmail.com>
MIME-Version: 1.0
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

Correct a macro spelling mistake in rtw_fw.c.

MAX_REG_BOLCK_SIZE -> MAX_REG_BLOCK_SIZE

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_fw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
index 7a0997b9bac5..0905384bafc7 100644
--- a/drivers/staging/r8188eu/core/rtw_fw.c
+++ b/drivers/staging/r8188eu/core/rtw_fw.c
@@ -4,7 +4,7 @@
 #include <linux/firmware.h>
 #include "../include/rtw_fw.h"
 
-#define MAX_REG_BOLCK_SIZE	196
+#define MAX_REG_BLOCK_SIZE	196
 #define FW_8188E_START_ADDRESS	0x1000
 #define MAX_PAGE_SIZE		4096
 
@@ -82,7 +82,7 @@ static int block_write(struct adapter *padapter, void *buffer, u32 buffSize)
 	u8 *bufferPtr	= (u8 *)buffer;
 	u32	i = 0, offset = 0;
 
-	blockSize_p1 = MAX_REG_BOLCK_SIZE;
+	blockSize_p1 = MAX_REG_BLOCK_SIZE;
 
 	/* 3 Phase #1 */
 	blockCount_p1 = buffSize / blockSize_p1;
-- 
2.35.1

