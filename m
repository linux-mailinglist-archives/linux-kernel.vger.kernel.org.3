Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA9558AF23
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 19:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238632AbiHERsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 13:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241194AbiHERr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 13:47:58 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1C175395;
        Fri,  5 Aug 2022 10:47:57 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id p10so3999628wru.8;
        Fri, 05 Aug 2022 10:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=CMXqjTqzN3/GMYZY0G1FTjtsQA6rjAka/Y4oyBq7Mkw=;
        b=VqeBfMED4zcd9FXg0bNrgIkFnYYFN4XCIXaVT5uiQBLWJgDzw7cDq91POmkhCOABJS
         fLPMh22Q73afMrkg782GWBerauMz0kFzslkx45V3vPkhZlfyuLIO5yZkS9LRvX7Qrmpp
         Tsu8olhfqFTL8LmSdOf1G2BUYd8dMPB6Kk2t5Sv2Ve/qLFg/DNK3UV5xcreDPTeOBTZi
         RUV9sQUmk8+FdRcGaF5C8ucoZYtoAkyyivGW7WGjvKLMH2N7AnGMGEtwnJ0Lr8elPStk
         PYjSs2tf1nQv3A5qHAqgK05SlKLGguiGKbwDBLDRodvPtNvjS9wb3P8rSh+DedbcEhbb
         Re7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=CMXqjTqzN3/GMYZY0G1FTjtsQA6rjAka/Y4oyBq7Mkw=;
        b=tltsVCD3knqaW3367mKSp8Qpm0hxz2S6dzadugpFfqXi6nJojYjL3MbVTisISp+m7v
         Z2RoVqa4hcu70dY/GJSD145TZvAIdAT6zDf/6cVzWaWZHfHQYHUJXBblfHtBbZMxYGsC
         +gK5WFQSbmVFaB/fcQLyPSLoaHurrtebPJV9y5MoKn9sBj9EbDFPVDvf3Gbk75Vh0Q+E
         jaYD8rVoVLzTkKmMEHz6HI4r00K6ZDUw0ixfo/RBm3W1RA6vC1kMXuTOdCytJfT5vvDm
         ++IOKtgxsf+NNDlOi6SfGwq8Zifo6KbgDPzNeffAm3F2uYFEqxgjjgPGqIoeawasKd9k
         zKbg==
X-Gm-Message-State: ACgBeo0xydYJLEN6gnGpKqW4UjldmezyYmZXbEkJu2gBDiY2FDb+WT/C
        PA33o07nwhXRlN7uWAs3YSBsAIseQqs6BRcE
X-Google-Smtp-Source: AA6agR42LpXhy4N7tKpqgAMUqHC84ORU+3zFZn9bMC2KbiFMp+sFVU6BWy506yaLgY/dkkcZ1ynkdg==
X-Received: by 2002:a05:6000:1541:b0:21d:b298:96be with SMTP id 1-20020a056000154100b0021db29896bemr4764366wry.206.1659721676429;
        Fri, 05 Aug 2022 10:47:56 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id b13-20020adff90d000000b0021e5adb92desm4299636wrr.60.2022.08.05.10.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 10:47:55 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] Input: applespi: Use correct struct names in comment
Date:   Fri,  5 Aug 2022 18:47:54 +0100
Message-Id: <20220805174754.2374473-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
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

The incorrect structure name is being used in the comment for struct
touchpad_info_protocol. Correct it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
[V2]: Fix commit message
---
 drivers/input/keyboard/applespi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
index cbc6c0d4670a..fab5473ae5da 100644
--- a/drivers/input/keyboard/applespi.c
+++ b/drivers/input/keyboard/applespi.c
@@ -202,7 +202,7 @@ struct command_protocol_tp_info {
 };
 
 /**
- * struct touchpad_info - touchpad info response.
+ * struct touchpad_info_protocol - touchpad info response.
  * message.type = 0x1020, message.length = 0x006e
  *
  * @unknown1:		unknown
-- 
2.35.3

