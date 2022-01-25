Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC6449B174
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243257AbiAYKUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241215AbiAYKPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:15:55 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D320C0613F0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:15:55 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id n2-20020a255902000000b0060f9d75eafeso40633980ybb.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DaKuIzTI79zUYcyKsPYW3TP3Y5c4qM860aXt8MCFVpA=;
        b=B1z9pW3hP5IkrS9SKJlmIhOiXdn+Sn3m9MTLWw3FMTjoYB4ROZksTJVEhqTJjxurGz
         Ts53c+Xivbcwykk2ZX5Pfm3Y5dya2YEQ8WSs/Uo7d9UOXd92cXdyo5GAR+itUP7j9OIj
         vekEXD5+XSiPOOxIDPIo5lmQEwtfwxnr97qd7dAAPLoNzEAoAwbUhn+EL+5WqyTgn+SO
         dWlswKO+Gm93VP368y+DFmsOVThKIbrGmHQf9rKbCUOzmM1E797gLwj3Nul+rpDSVaRi
         Bdf3eHohE6J9O92e+YU3CgLILCuxGmpUiIaC83z2q7m8ftIctrt3dIOABISOZp2yl9B/
         NSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DaKuIzTI79zUYcyKsPYW3TP3Y5c4qM860aXt8MCFVpA=;
        b=x89mrv0I22T7fV7nbHKuvV6bWSfJZHnqwdsYQd4wBZBJRVeZX2ONFt6mJA2yI1sSwE
         sVoMd5TLvE0LPsE3h8lAk1Gsvu0v5HyC3ss93LIllpMfNzIdpFJD4ZKipLSdIG+4kwP9
         pFYoO/EzXhb3Cxuzqsv0wFGHo842YUexaUWVMx8Dt1UBFfeE+7grB7m88L13FF3wNRNV
         YOlJegNY62l3Vm4Yqzcbzer5i/b+3csc10yeYeVrLEnA+udYSj5Wv6UzTfmGp3WNQOtQ
         4/SDztnLnBlByXeYUBVBvGM7i7Cbug1+EnrKBoiqx5N2u3zJdfuXj/WuL9LpF/QibBU0
         zqDg==
X-Gm-Message-State: AOAM533cUrydjYZ8U921APoOJtrxOSbkMiS8U8RDIXx9FfW1x653zv7O
        Wf5gp4t+RvTIjoKtk/p0I7SHB3M+7dLC
X-Google-Smtp-Source: ABdhPJx9VPCW9B9P6v/6chD1IlB38QClG4/aZWYqKBbntTx7hwJRbYpkOBIBsPa3DDFUJNhoTCVNz6AQYZNl
X-Received: from tzungbi-z840.tpe.corp.google.com ([2401:fa00:1:10:69af:7f25:2010:2c85])
 (user=tzungbi job=sendgmr) by 2002:a25:cb96:: with SMTP id
 b144mr1872368ybg.338.1643105754411; Tue, 25 Jan 2022 02:15:54 -0800 (PST)
Date:   Tue, 25 Jan 2022 18:15:23 +0800
In-Reply-To: <20220125101527.1812887-1-tzungbi@google.com>
Message-Id: <20220125101527.1812887-3-tzungbi@google.com>
Mime-Version: 1.0
References: <20220125101527.1812887-1-tzungbi@google.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH 2/6] platform/chrome: cros_ec: remove unused variable `was_wake_device`
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     bleung@chromium.org
Cc:     groeck@chromium.org, tzungbi@google.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`was_wake_device` is unused.  Removes it.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 drivers/platform/chrome/cros_ec.c           | 1 -
 include/linux/platform_data/cros_ec_proto.h | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index 3aec890edd39..a37448f3e179 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -344,7 +344,6 @@ int cros_ec_suspend(struct cros_ec_device *ec_dev)
 		ec_dev->wake_enabled = !enable_irq_wake(ec_dev->irq);
 
 	disable_irq(ec_dev->irq);
-	ec_dev->was_wake_device = ec_dev->wake_enabled;
 	ec_dev->suspended = true;
 
 	return 0;
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index df3c78c92ca2..c65971ec90ea 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -76,8 +76,6 @@ struct cros_ec_command {
  * struct cros_ec_device - Information about a ChromeOS EC device.
  * @phys_name: Name of physical comms layer (e.g. 'i2c-4').
  * @dev: Device pointer for physical comms device
- * @was_wake_device: True if this device was set to wake the system from
- *                   sleep at the last suspend.
  * @cros_class: The class structure for this device.
  * @cmd_readmem: Direct read of the EC memory-mapped region, if supported.
  *     @offset: Is within EC_LPC_ADDR_MEMMAP region.
@@ -137,7 +135,6 @@ struct cros_ec_device {
 	/* These are used by other drivers that want to talk to the EC */
 	const char *phys_name;
 	struct device *dev;
-	bool was_wake_device;
 	struct class *cros_class;
 	int (*cmd_readmem)(struct cros_ec_device *ec, unsigned int offset,
 			   unsigned int bytes, void *dest);
-- 
2.35.0.rc0.227.g00780c9af4-goog

