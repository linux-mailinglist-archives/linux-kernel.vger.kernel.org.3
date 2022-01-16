Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F08348FD15
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 13:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235290AbiAPM6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 07:58:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34420 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232334AbiAPM6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 07:58:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642337880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=joIS1Y76brqpPUe0shDtAaTH/Hsbm75L24ICejcggiQ=;
        b=IvZshcV3AsjU+a7ZOUSX6OF7jfDAv3TogsBVJlpL72wPkN0tv9j3nCTys0A6QkjwxVOH0h
        anu29imOEwpVVJkrLZqR616yOd4DHcZfYty6cFl5UKNdgkpmCjXW9sNtgBBrWkfwHMSMD9
        da1nopc0qTr9wH+0r31E3C3bOMgpjlk=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-459-7b8jW3tlNcayx5uknTiz_Q-1; Sun, 16 Jan 2022 07:57:58 -0500
X-MC-Unique: 7b8jW3tlNcayx5uknTiz_Q-1
Received: by mail-ot1-f69.google.com with SMTP id m23-20020a9d6457000000b0058f6f926cabso4197478otl.6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 04:57:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=joIS1Y76brqpPUe0shDtAaTH/Hsbm75L24ICejcggiQ=;
        b=VW4ubsuS1a0LRgsXIyuw5c7keEAjOlMkwiENTlxWFClvsvYf8sixGrxOrFOCGoLzTw
         dWqzebq5mtBKmPhTVqTW3lGLszJ+whIPsn8bcIBuZLXcWFMwELAGpUi6Ky+g9LrAkNmr
         VruU5f5zh5+v4rDYZRMPxFhBsiL4L+p61wjUFdJ7lC+0sKG+m7Hd3etaISv7piEQSL4T
         pWSmTfcUxhWpR2ElzHuN4/Q+PIHrth+ZnW//pJhc4ciU5YgiaI9W6JdOG5i7D7a92UxO
         8MagSVquh1hovxTokqEuVv3UIGb3/07sVQCDbKBnDQn+ZWUiBzSLLpRhIso9tXvPdY6R
         CiJg==
X-Gm-Message-State: AOAM533y/0RLp2kIoJ/PAPS3t8nW00wDAsrypX9yCf92wl16S3/Qm6tq
        x8M+mNoic1fXhQqwS7Oy63AisQiPj/UKMrvysR098tdxDvCW6gxiwxh2TwNsvXw7bJReG0QnxzI
        vUQYwV9AeherIWLgAzxsAOW13
X-Received: by 2002:a05:6808:23c1:: with SMTP id bq1mr12228072oib.71.1642337877712;
        Sun, 16 Jan 2022 04:57:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyOv7qwSKS17OCZxEadDRyX6BMIpr4NlVzjsy1wvDmdJTVWCUCY2q+tsWzZ2ZFB9E5tYQaaBA==
X-Received: by 2002:a05:6808:23c1:: with SMTP id bq1mr12228065oib.71.1642337877562;
        Sun, 16 Jan 2022 04:57:57 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id f15sm1648370oot.42.2022.01.16.04.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 04:57:57 -0800 (PST)
From:   trix@redhat.com
To:     bleung@chromium.org, groeck@chromium.org,
        enric.balletbo@collabora.com, pmalani@chromium.org,
        Jonathan.Cameron@huawei.com, dnojiri@chromium.org,
        swboyd@chromium.org, yuhsuan@chromium.org
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] platform/chrome: cros_ec: cleanup double word in comment
Date:   Sun, 16 Jan 2022 04:57:02 -0800
Message-Id: <20220116125702.389471-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Remove the second 'using'.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 include/linux/platform_data/cros_ec_commands.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index 271bd87bff0a2..2cdc36184d5c1 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -783,7 +783,7 @@ struct ec_host_response {
  *
  * Packets always start with a request or response header.  They are followed
  * by data_len bytes of data.  If the data_crc_present flag is set, the data
- * bytes are followed by a CRC-8 of that data, using using x^8 + x^2 + x + 1
+ * bytes are followed by a CRC-8 of that data, using x^8 + x^2 + x + 1
  * polynomial.
  *
  * Host algorithm when sending a request q:
-- 
2.26.3

