Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEB34C0F4B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 10:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239316AbiBWJh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 04:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238715AbiBWJhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 04:37:25 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2267488AB;
        Wed, 23 Feb 2022 01:36:58 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id q4so3774381qki.11;
        Wed, 23 Feb 2022 01:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O/nWq54aLnoBPA2OY9+4Ua6OhHSnHjOi//smrDEVze4=;
        b=U/UF2VSng13xh7TYIcdZhyoqxbP214syzfRML65LozwHHn6Pviwu0XPWKn5BC2XiHn
         bZ3/HYqQMWnjUIjNJaislhBbBICkfvfSPnuPEtRpf77VLTQivXJUUyztZifeBu19ajxH
         BdVFj5xUphBufYY+3/Ky6Cjv5BdPLijHEwMlv6jJGnDhQ5otOga7VPcZ+J2NXAUafq0Z
         hW6TqCbXRtna3Vz2g5EU1ThN+riBJMNynbK8Ain2B0xBOicNdDm7HgxdYp4JnUPHuVb/
         tiOU20STT2tf4HBjTxDRKfR4EGWmobrugH/bWppQRkfRpPQcIQQElarSXGAzofM2K1lX
         yaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O/nWq54aLnoBPA2OY9+4Ua6OhHSnHjOi//smrDEVze4=;
        b=Y5T3cbCMXdXuqiiZjjpSY1ngWAQmp83Pd/nH6btTSQmF46MMU+BCFql123SLftPT/T
         j1MFTgnqaLWGl1q2FmYdB8R6Q3xFRoTJP0hEsYgNSjkD/gSSS1yCIPENqfd+HeWRWJny
         lLgeDuNtHccWy3FpzXQ0Ti7Wn/FJn4hMfChF9IEVo4Bzn9mnTxsw2z4w95rZ23qTRB2c
         9S/J2gpFqYfQSz0EzqFKALwsfWMkVsOaWHfYHxcsiiDb8oZJMDTMxBUHcg3Qoxd6W8y2
         GWiBk5Lc5Od/pTp7Qww8yu1m+CEhR0LauTfGg1lW2zx5DUySeXU6eUguRGeJlJQloD8l
         OlwQ==
X-Gm-Message-State: AOAM532t9VzY3O7vrnNLkTq4ZDrBquPE9NBjByT/NyYS0paQmrq2wud2
        Gif7dGCykC+be0IRBTsr0n3kMoHe7HU=
X-Google-Smtp-Source: ABdhPJx2HMuX9P1TTeBc7I21YRWMQpgMTwy1YTU8mhxwTeFQiHXIV6p+G9bSBmBaGKA8283tjrtV3g==
X-Received: by 2002:a37:a0c6:0:b0:60b:54ea:29dc with SMTP id j189-20020a37a0c6000000b0060b54ea29dcmr17779660qke.354.1645609017897;
        Wed, 23 Feb 2022 01:36:57 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id z19sm1481805qts.18.2022.02.23.01.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 01:36:57 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     srinivas.pandruvada@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] tools/power/x86/intel-speed-select: Remove unneeded semicolon
Date:   Wed, 23 Feb 2022 09:36:33 +0000
Message-Id: <20220223093633.1934362-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Fix the following coccicheck review:
tools/power/x86/intel-speed-select/hfi-events.c: 147: Unneeded semicolon

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 tools/power/x86/intel-speed-select/hfi-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/intel-speed-select/hfi-events.c b/tools/power/x86/intel-speed-select/hfi-events.c
index e85676711372..2f871c108236 100644
--- a/tools/power/x86/intel-speed-select/hfi-events.c
+++ b/tools/power/x86/intel-speed-select/hfi-events.c
@@ -144,7 +144,7 @@ static int family_handler(struct nl_msg *msg, void *arg)
 			continue;
 		res->id = nla_get_u32(tb2[CTRL_ATTR_MCAST_GRP_ID]);
 		break;
-	};
+	}
 
 	return 0;
 }
-- 
2.25.1

