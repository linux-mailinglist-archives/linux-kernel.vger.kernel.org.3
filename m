Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB5150A775
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390948AbiDURyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390937AbiDURx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:53:56 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528F24A3E6;
        Thu, 21 Apr 2022 10:51:06 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id h25so1699470wrc.13;
        Thu, 21 Apr 2022 10:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f92MKRrT0L1P4tPjgNwMxIl4Ha1qwGqzWtpfrFCwgyM=;
        b=peEQlIDQSf7XxoSaP590zUrldJ/7GeAEaQd4MUJsvP+D8zqxdae/crnwtEz4tgbDBR
         RIG7gzVZBj/Re256H6eLkFxDST0kJXGer+/LbxYU0QoY7q9OdnbQsePXnbnmazgiSZLy
         XFz+4KkNTkErt8c/1PjvtZQbBhHIz4PfAA2f+KnNUxDV6L8CicIIo7u6nDv4/D41IcGI
         M/2HkOqDYMi2e0zo5GHDDll+wn9vWmxqZp7pqPrXqIM0qRqPNp0WMfdlWhUioOJ3Vn3/
         XkZzlUCo/ETreuh+KFLjkHAMVBPPu4MH0fofWZyaJBJ3Gix5IjRGV/j1XUESr5QeU039
         nvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f92MKRrT0L1P4tPjgNwMxIl4Ha1qwGqzWtpfrFCwgyM=;
        b=phVcO0fSRbNt5tCVhpg2qEtCtwNP1/y87MuGTXROUXcUPySKa11LpwKpyrSjFn3pjw
         vlHQZzYYYQ7Si2G0mrTcsbKyLvZZaMm6YBRORAURnfy99WWeISI8MHH+99aLE+72SypJ
         kpoYgMd0jOixM2m3KAKCeQMm08IzCohB040qJ5T4VAcRT2a2szyyiTUoyISTJANOs3Lm
         4E1xLemfHYkQzIKw8cezU0HfIHyUqpAw3jcXgemC6c66ab/N+YX3C59CqcUCacGkja8T
         l9OVA1Cn4ndZM2UyDzh+Em1FXHqWsgFdHPfMQj36QHMq79wyEZrkWUTV3hZeakXA3kOw
         chQA==
X-Gm-Message-State: AOAM533Fgz+yuuO29m8kVjHfCdv4T3ukkTxZu6glD5HnMVNGu3cHxVcB
        KINCNMc5S+XiKdzEIrsC3hI=
X-Google-Smtp-Source: ABdhPJwgp5JJZxP5dhvcjxtD7Q4ChmeukcW5sOLr/Hc1cZIGMXlFv/ADkgz6vxvtkK8z0/K/JPO/JA==
X-Received: by 2002:a05:6000:156a:b0:20a:9c1b:6b1b with SMTP id 10-20020a056000156a00b0020a9c1b6b1bmr620255wrz.683.1650563464855;
        Thu, 21 Apr 2022 10:51:04 -0700 (PDT)
Received: from localhost.localdomain ([94.73.37.128])
        by smtp.gmail.com with ESMTPSA id l28-20020a05600c1d1c00b0038ece66f1b0sm2685634wms.8.2022.04.21.10.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 10:51:04 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH for-5.19/uclogic 1/5] HID: uclogic: Clarify params desc_size description
Date:   Thu, 21 Apr 2022 19:50:48 +0200
Message-Id: <20220421175052.911446-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220421175052.911446-1-jose.exposito89@gmail.com>
References: <20220421175052.911446-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikolai Kondrashov <spbnick@gmail.com>

Documentation improvements.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-params.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-uclogic-params.h b/drivers/hid/hid-uclogic-params.h
index e5ccc558abc3..a489c92cee43 100644
--- a/drivers/hid/hid-uclogic-params.h
+++ b/drivers/hid/hid-uclogic-params.h
@@ -189,7 +189,7 @@ struct uclogic_params {
 	__u8 *desc_ptr;
 	/*
 	 * Size of the common part of the replacement report descriptor.
-	 * Only valid, if "desc_ptr" is not NULL.
+	 * Only valid, if "desc_ptr" is valid and not NULL.
 	 */
 	unsigned int desc_size;
 	/*
-- 
2.25.1

