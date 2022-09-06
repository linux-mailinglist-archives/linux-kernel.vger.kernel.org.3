Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886D45ADEC6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 07:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbiIFFDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 01:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbiIFFDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 01:03:38 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03AD5E560
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 22:03:37 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id x1so5831643plv.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 22:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=EUYRH9NcQn4nCkSQ20dpjSYgIxtxuHVCjjovI/5Idl0=;
        b=L6BzQzuVUaGmHvImE3RLEm5M46q8IssEV123l40OqaQN0JKpvr6b1ESyr9vDrNiwpo
         NzF7Bjs7dWPGc7vfWt5GXRzfT1k4zaTltTcT+itO7Z6YQQzjxdKfcqvyeVcC58QxZxMC
         scPZ1QxqfBcAHP/MYw9dXPEcrrPubn1SY0OaB3dv5yV1Vrcx2+ddvNLn3XcI8YFv+L43
         gsRTwxSYK7uxQJD2fiqTa4dACUIzDCuQFcqkodMSWHOUh0J9bgeKthioh0UHVpWLKl4u
         xFKUCSS88r0hMIOoMo1kn/USp9VO2Qe8rte8GI1mmpeWGfosqK83S8vSibgsrx6af5T5
         nkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=EUYRH9NcQn4nCkSQ20dpjSYgIxtxuHVCjjovI/5Idl0=;
        b=vab9X4TsCeJBP2FtWtRxRECJOEMZ79TvNqg8Q5vo1sv931LvGzORzVuuSGBZQ+wpPg
         UO2OL0dpcgqEz3Jwn47kP2yLHMTJyVEWhZaiUFVgYPa4TBkoOBhOHN1SKC/5dvWV8kNi
         adQM8VKXZfliobD5B9sHyQ9WIDuCbfrJFTSLNIoYozf5N6w4ajK7xIDf+jaQA24do/E3
         J39m/djHLylKkW0uMD8ZEgWwNchrNbzJZqfR4TTREbrQ/A5D/eOjtsI1AFer3yXm+edt
         aqzgDC1cqNmnusrNOnb25+pCwr/fSVltAGs+0WQxX2o8yoc+IL1ZvMBhE5fJxJuK/cXi
         W8AA==
X-Gm-Message-State: ACgBeo3ZDruHuddwW4Gk4KRFaDOl6gO3Dm0i3PvJ7hEHUMUeYfeFj+Ca
        yAEjqoA1dudMRnJ+fZgJzHEgX6zPeAiaJw==
X-Google-Smtp-Source: AA6agR4/qmU5jkUL/hjtzgvPHgfZreB4o4R5rrrAXLUnFPeeGoT1u4z6fznJf0yIhWQ8r77QOGQifQ==
X-Received: by 2002:a17:90a:a90:b0:200:3e3e:71b3 with SMTP id 16-20020a17090a0a9000b002003e3e71b3mr12490360pjw.106.1662440617106;
        Mon, 05 Sep 2022 22:03:37 -0700 (PDT)
Received: from sean-biuld-server.itotolink.net (1-34-200-211.hinet-ip.hinet.net. [1.34.200.211])
        by smtp.gmail.com with ESMTPSA id p15-20020a17090a680f00b002006f8e7688sm2638702pjj.32.2022.09.05.22.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 22:03:36 -0700 (PDT)
From:   Sean Hong <sean.hong@quanta.corp-partner.google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sean Hong <sean.hong@quanta.corp-partner.google.com>
Subject: [PATCH] Test: check open list email
Date:   Tue,  6 Sep 2022 13:03:33 +0800
Message-Id: <20220906050333.30852-1-sean.hong@quanta.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just check email linux-kernel@vger.kernel.org

Signed-off-by: Sean Hong <sean.hong@quanta.corp-partner.google.com>
---
 test_email | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 test_email

diff --git a/test_email b/test_email
new file mode 100644
index 000000000000..e8084e7bc088
--- /dev/null
+++ b/test_email
@@ -0,0 +1 @@
+test the open list email address.
-- 
2.25.1

