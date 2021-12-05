Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6D4468B00
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 14:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbhLENT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 08:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbhLENTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 08:19:53 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C35DC061714;
        Sun,  5 Dec 2021 05:16:26 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id v23so5738192pjr.5;
        Sun, 05 Dec 2021 05:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aJaxvmvXGKiXPqpxxCMiZCm0X9zd579xR9KMI36RIwQ=;
        b=iuLJP3W4TfiEjUZR+3xIxkR5ThTwxm7qXt9xfdD0KBGxBpc+GwfUPyQs/JK9OenWtA
         udAlxARHpwxVFjRKGHLFsLeW6z+cj0E6GaVxjfyD6Uh5Lh9B+r0+ZfkMLB3tLF73bXHl
         UYAlAPDkjMpVTsLbpH2OD8QQthxq3S3Gw0ZulmSb9EUfVbRMq/Mw66XUQcXCIVrIJTER
         cTKbRkR6Fh52o/adPpd23cS2ttU5ld2ZA9TDsBMkFHDraJaUNWeFVeAX7zxj6Og5bg0+
         AZO7/733XLb37kTo1u4fOuwa/yTtv5Xty1Us0D2AOQisTYJXqCN6ygueCkzOQ1xd/tBe
         bvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aJaxvmvXGKiXPqpxxCMiZCm0X9zd579xR9KMI36RIwQ=;
        b=Hq9+mZk749n/bOUpCf1pbSPl1xHgrx69W8yJpVBZizqLA5KKj/erUajJd//f6WytPK
         mRH9nIUd6nRtbp95MwNkoRw80b7NWv2932273/VWv0Fw4SIgf3TM3XuKZXN20Wo+X7cZ
         QXU1Q8ZqmAAkZRKTgQdde0LEd6qfByZoVhbbvfNkZpk4DwwSoa0CdaZ3sBUBrzBZkSu6
         fPRV/El4D+S1I/3JSYFW5CCWyUxa0AcW8+7oe2iBk/E0RqXDCs5WHytbmHRaNdZP8jH7
         XZXEgKicuzP+oOlhqau+ljhUZf/RnB6qaRy53OG6nlmNh2CNcKcRcCDuSFAJzXUr+hZx
         rOnA==
X-Gm-Message-State: AOAM533frGFUoJhEeTLGpHv6ozEDzeR2bt208G6s96tW0dapSouzxYfu
        uD2GjoDoidtMLvY5iM5saTI=
X-Google-Smtp-Source: ABdhPJysl5qn2SG2Nz6XkxKZK3zS8xVharRxndhN4ceIQEEoDl8I2+sp+Hb6BaBTGss3booQuE431w==
X-Received: by 2002:a17:902:e810:b0:141:d8e9:a8b0 with SMTP id u16-20020a170902e81000b00141d8e9a8b0mr36672113plg.9.1638710185963;
        Sun, 05 Dec 2021 05:16:25 -0800 (PST)
Received: from localhost.localdomain ([8.26.182.175])
        by smtp.gmail.com with ESMTPSA id cv1sm10017134pjb.48.2021.12.05.05.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 05:16:25 -0800 (PST)
From:   Yanteng Si <siyanteng01@gmail.com>
X-Google-Original-From: Yanteng Si <siyanteng@loongson.cn>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net,
        chenhuacai@kernel.org, linux-doc@vger.kernel.org,
        siyanteng01@gmail.com, Yanteng Si <siyanteng@loongson.cn>
Subject: [PATCH] regulato: remove unnecessary indentation from driver.h's comments
Date:   Sun,  5 Dec 2021 21:15:03 +0800
Message-Id: <20211205131503.4122955-1-siyanteng@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix doc build warning as:

linux-next/Documentation/driver-api/regulator:166: ./include/linux/regulator/driver.h:96: WARNING: Unexpected indentation.
linux-next/Documentation/driver-api/regulator:166: ./include/linux/regulator/driver.h:98: WARNING: Block quote ends without a blank line; unexpected unindent.

Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 include/linux/regulator/driver.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 66219b174a8a..f777e259facd 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -92,13 +92,12 @@ enum regulator_detection_severity {
  *	levels of severity.
  *	REGULATOR_SEVERITY_PROT should automatically shut down the regulator(s).
  *	REGULATOR_SEVERITY_ERR should indicate that over-current situation is
- *		caused by an unrecoverable error but HW does not perform
- *		automatic shut down.
- *	REGULATOR_SEVERITY_WARN should indicate situation where hardware is
- *		still believed to not be damaged but that a board sepcific
- *		recovery action is needed. If lim_uA is 0 the limit should not
- *		be changed but the detection should just be enabled/disabled as
- *		is requested.
+ *	caused by an unrecoverable error but HW does not perform automatic shut
+ *	down.
+ *	REGULATOR_SEVERITY_WARN should indicate situation where hardware is still
+ *	believed to not be damaged but that a board sepcific recovery action is needed.
+ *	If lim_uA is 0 the limit should not be changed but the detection should
+ *	just be enabled/disabled as is requested.
  * @set_over_voltage_protection: Support enabling of and setting limits for over
  *	voltage situation detection. Detection can be configured for same
  *	severities as over current protection. Units of uV.
-- 
2.27.0

