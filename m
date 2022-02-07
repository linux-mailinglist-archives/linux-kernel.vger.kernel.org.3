Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5A14ACB31
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238364AbiBGVVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbiBGVVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:21:10 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826EAC06173B;
        Mon,  7 Feb 2022 13:21:08 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id j14so21618501lja.3;
        Mon, 07 Feb 2022 13:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hsbJ0GU/AL4AfVkaQvyIQPLApPeRQ458lwWoWMcrsE0=;
        b=ARKbo3PgAPSpYoMfrxm8d04zvvoOB31fGPr+OTTIcORO0I7u4UpKmfAMPnmKxUOGoh
         XwUmSX+I2gTr1ImdjQf/gkKXxyE0kPVPpzYnfLd1RlxzI++L0WsEm3AG/WP6stozQFHU
         jL2cLwg6cagFfPaVffRS/OCHQsv3yEXcvsLPzkQM7PBUAC0yiqW1IO+GkfCGhCVtjNLs
         F2nLlHYIc/ladnA9TLkZlD80JrKHXF+3lx8XPp98q21dEYrK9s5ThvPTZzMgfchSF6vb
         MHsDbSXYKpKL4qhcY6uGDRHRrezcPRebNGjGiQIFre6CfLTJjdSNR1Yp7sR2MJy1IiUK
         67ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hsbJ0GU/AL4AfVkaQvyIQPLApPeRQ458lwWoWMcrsE0=;
        b=mjwDVtJWDu8RnFtA62XghDukfq8bOkVY0oBjXGLzCKfDj4LLDSNZUAXTDBF6or7XQk
         pHM4r+tduFqQ5pYN1ekYV8UWQew+tgRTQmo1WFvx2wGd+gpho9+HbehzSOcQa6LawCwG
         eQ88pqX4IMWk1eihMSoBXIMHGQkm23TXpVovM9zp2QdUu6SNjFXKXiYIu3B2jP5HXg1L
         2AxP2Ghexlzn14baaW3fGPJsww7s82suu9zGGuGh28m+Cqyh5NstAWPbPSCiKynnLn3t
         Wkt7VNZOXALVaj9UAWkYM+cxkzEHOb0qtIG8JYW+IuvSrSe8+2EtQ8d8i6efdHt6726O
         4fNw==
X-Gm-Message-State: AOAM533a6f1OC7CmWkachs4XVJ4kWzm4SgwHvK3e909dUBHqLxl1utpk
        ixbgRbv0pKGNhqvj9E02KzBmeGOFNmY=
X-Google-Smtp-Source: ABdhPJxXyfywQy3vuSKDvHKjzIgrB+cR38Vav6HCtAQrTtagtP+A0l2rmL6kGMfm54ft08CqgpxfPA==
X-Received: by 2002:a2e:a7ce:: with SMTP id x14mr856474ljp.222.1644268866394;
        Mon, 07 Feb 2022 13:21:06 -0800 (PST)
Received: from WBEC678.wbe.local (xt27d8.stansat.pl. [83.243.39.216])
        by smtp.gmail.com with ESMTPSA id br18sm1635004lfb.302.2022.02.07.13.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 13:21:05 -0800 (PST)
From:   Pawel Dembicki <paweldembicki@gmail.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Pawel Dembicki <paweldembicki@gmail.com>
Subject: [PATCH 1/2] dt-bindings: vendor-prefixes: Add Ctera Networks
Date:   Mon,  7 Feb 2022 22:20:13 +0100
Message-Id: <20220207212014.28551-1-paweldembicki@gmail.com>
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

CTERA Networks Intl. is a company based in Israel.
They manufacture NASes, network devices and provide software
products for cloud storage and IT security.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index c48ce3c54951..9e247353b6bc 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -275,6 +275,8 @@ patternProperties:
     description: Hangzhou C-SKY Microsystems Co., Ltd
   "^csq,.*":
     description: Shenzen Chuangsiqi Technology Co.,Ltd.
+  "^ctera,.*":
+    description: CTERA Networks Intl.
   "^cubietech,.*":
     description: Cubietech, Ltd.
   "^cui,.*":
-- 
2.25.1

