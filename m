Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4FE5A910D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbiIAHra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbiIAHq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:46:56 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E21B255AA;
        Thu,  1 Sep 2022 00:45:13 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id x19so14885994pfr.1;
        Thu, 01 Sep 2022 00:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ljVHK94lOLMXeyDYK8rETR5FdziQ3+pJDqhAkr3kihM=;
        b=QzG/aQmaMyWSgnRR/emLiWScS9fOw2EtnaXzFcwYg0RzPzbKHZfbvcbDHQ/ggvF3y/
         /BcjLfAofVEerU8jaurKxj1do1dHnna04rDlprmyNmrdz8Ku6FEJjQj2GwgRbemusQCO
         6ccEddvmacFilvFwc3t0eotYxjdPIvdCPWJY//MrvPKip/Ax6aH+wWvovb7nBaueuG8S
         yjz82jafZHIFby2oXZ6LZt5NxQMmnSYxe0VZMhvBaHIIa56eQ39Tt5kj7iQBOq1SOzX3
         /zNSUwBTu7KoNxuv3E59ue9Bc3BaQcN8Ol1j2Ev51WH6GLelaJ8v0p7NOnHpkJXZLmmH
         uutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ljVHK94lOLMXeyDYK8rETR5FdziQ3+pJDqhAkr3kihM=;
        b=zJmGcx2KxHhVdyht0e/9bFBuaGYNqtZX0AxP3RTX2nZSXeYVUK01hZi8tHv2KPYx5h
         QjM4HE6GwHmHXlMJtsBcZuYrvhOtoE5/KRKbbtFjL3/GROTAT6k5wYQrEPw/ybiA0sBa
         53YpogyjqIiLP+q5ljb4zL24sxb4kdTkw0ASWtM02Um1JefDESJvyY4aYPttCNgmY0Wo
         Fo6in/oIp8CsKVpst0duvEZ8l1sCO3OJzzI0qpNXscT6dnu44V6k/J/NiEa1vsptzzlw
         TtFxXWqB2mu+XwtDN8M0gxmLT04OyZJToE0mnyNGFWO5bTfNitvh3x3xuGbQSNiVuYYT
         vOTg==
X-Gm-Message-State: ACgBeo2s4M0lEmNSFe9HgYluavKQDO1yHu0C+zNHARUvOTfaIAopMgNR
        9SJ6tK/YzelQnWSZZC8OpSYgAwTs5qg=
X-Google-Smtp-Source: AA6agR6i0PW4jcHSbC8f9tljwfT3UA9m7s8uR3aE2lTIXWxk6WvG/iqx/uwP1+R4ziXRRtal6laexA==
X-Received: by 2002:a05:6a00:4393:b0:52f:3603:e62f with SMTP id bt19-20020a056a00439300b0052f3603e62fmr29848577pfb.23.1662018310920;
        Thu, 01 Sep 2022 00:45:10 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id b8-20020a62a108000000b0053ab9c18d3csm2977210pff.14.2022.09.01.00.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 00:45:10 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     mchehab@kernel.org
Cc:     nathan@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>
Subject: [PATCH linux-next] media: radio-si476x: Remove the unneeded result variable
Date:   Thu,  1 Sep 2022 07:45:07 +0000
Message-Id: <20220901074507.313203-1-ye.xingchen@zte.com.cn>
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value v4l2_fh_release() directly instead of storing it in
another redundant variable.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/media/radio/radio-si476x.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/media/radio/radio-si476x.c b/drivers/media/radio/radio-si476x.c
index 0bf99e1cd1d8..171f9cc9ee5e 100644
--- a/drivers/media/radio/radio-si476x.c
+++ b/drivers/media/radio/radio-si476x.c
@@ -1072,7 +1072,6 @@ static int si476x_radio_fops_open(struct file *file)
 
 static int si476x_radio_fops_release(struct file *file)
 {
-	int err;
 	struct si476x_radio *radio = video_drvdata(file);
 
 	if (v4l2_fh_is_singular_file(file) &&
@@ -1080,9 +1079,7 @@ static int si476x_radio_fops_release(struct file *file)
 		si476x_core_set_power_state(radio->core,
 					    SI476X_POWER_DOWN);
 
-	err = v4l2_fh_release(file);
-
-	return err;
+	return v4l2_fh_release(file);
 }
 
 static ssize_t si476x_radio_fops_read(struct file *file, char __user *buf,
-- 
2.25.1
