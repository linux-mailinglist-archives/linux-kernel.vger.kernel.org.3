Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E50654E938
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 20:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbiFPSTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 14:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiFPSTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 14:19:46 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67EB4F478
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 11:19:45 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id f16so1058763pjj.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 11:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IrXp9e9Px3FAwyoHtBkPdtEiOV152+/d+TzNFXLYICA=;
        b=Ejdklu/YAqWKw/4eung/ONJNMuCJqO6prcyo4aGJhGV3gXnn0mmXEQ1GNCvG2A55xp
         quZyVAcmvZLNHE8/rQqBONnlHxc1t3TaASY7FEmOlcXT8FruydbQL/x14qqVTkKvEWWV
         yCWZ08kzaGqEEQrMV60sQ7iukLm90bCGlc6XjTcbWaICfrjykQJSSFHKub0zrmwQJpD1
         SdMyS536P9sryDKBaNUY/kpkhQ1c4keaKaRFwk4ZieXTRJBFuSldzALWvqjhP0jsKkdM
         642IAJFK099aVsZ1/U1gEHuNwPWm8fj2cyWdR0PCJ74IonCkEFp5QkTlyYq9ky0xLi7y
         na6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IrXp9e9Px3FAwyoHtBkPdtEiOV152+/d+TzNFXLYICA=;
        b=eS3qjS2QAyyijd83yx8yQ1p65Ka0qDBHz2JkvsMZ11XHIyUnEw7EXMIKogZarp+udi
         vDMSLgE0yFbCIc032iaPcrer7Jn2ucwDnrYM95N2qUUrMeANI2VmYbwRdgFihJRTKxmd
         F7Adysv46NNx3skabH66/x8hOR8uwqha4OEcC2lBPa8aSfYQd9efu0sSAqxN4Pet+SFu
         aUmZJgTB4h9jUHvCTnCMHxts78i3Kf4WjaAJyo6QWD1GKAMOf1ndvPubFLtnXa29idFe
         N8oDmjeejEetsZBYfP9qQZswXKg00HKO4vQpMAkmhAqYNYaRHlvZkG6claNeau3UqXT7
         IGAQ==
X-Gm-Message-State: AJIora9QuCW6y2N+ybIgeo2J1/E5CdhwFa7DH0aw13KZjRkVMYN3pq3e
        PxbpIOkg4VApNxqPJPBtKLgao6UA0IVxeXQV
X-Google-Smtp-Source: AGRyM1tV14jUQNEHNvdk13VxEAF/RSgm7tRqJmj5cGE3G6l0/1580Rllx3dbfiv+twk0IjGrJwVZtg==
X-Received: by 2002:a17:902:dcca:b0:168:dfe3:66e4 with SMTP id t10-20020a170902dcca00b00168dfe366e4mr5868327pll.44.1655403585126;
        Thu, 16 Jun 2022 11:19:45 -0700 (PDT)
Received: from biggie.. ([103.230.148.187])
        by smtp.gmail.com with ESMTPSA id y1-20020a63ad41000000b003fae8a7e3e5sm2078325pgo.91.2022.06.16.11.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 11:19:44 -0700 (PDT)
From:   Gautam Menghani <gautammenghani201@gmail.com>
To:     airlied@linux.ie
Cc:     Gautam Menghani <gautammenghani201@gmail.com>,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: [PATCH] drivers/char/agp: Remove unnecessary variable assignment in agp_generic_create_gatt_table()
Date:   Thu, 16 Jun 2022 23:49:39 +0530
Message-Id: <20220616181939.225041-1-gautammenghani201@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Remove unnecessary variable assignment in the function
agp_generic_create_gatt_table(). This fixes the clang scan warnings:

warning: Value stored to 'page_order' is never read [deadcode.DeadStores]
        page_order = num_entries = 0;

warning: Although the value stored to 'num_entries' is used in the
enclosing expression, the value is never actually read from 'num_entries'
[deadcode.DeadStores]

Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
---
 drivers/char/agp/generic.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/agp/generic.c b/drivers/char/agp/generic.c
index 3ffbb1c80c5c..046ef61132f6 100644
--- a/drivers/char/agp/generic.c
+++ b/drivers/char/agp/generic.c
@@ -864,7 +864,6 @@ int agp_generic_create_gatt_table(struct agp_bridge_data *bridge)
 	table = NULL;
 	i = bridge->aperture_size_idx;
 	temp = bridge->current_size;
-	page_order = num_entries = 0;
 
 	if (bridge->driver->size_type != FIXED_APER_SIZE) {
 		do {
-- 
2.34.1

