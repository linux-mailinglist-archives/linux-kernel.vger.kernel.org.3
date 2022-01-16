Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A912F48FD20
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 14:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbiAPNAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 08:00:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25682 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233197AbiAPNAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 08:00:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642338042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yWRFWWtptnPxIxbi/2gfOhR6DgAD6LDtgNB3RKI6n2M=;
        b=NpFNbVKx6d2VTwFb5qpX1dDBIin0xanzm8H6c5Zx0pKiy/RMmP0jgiHep2tX+KzpPMTHGi
        q5rvZCm7DKXV1lUM6T+NUTuynRjbSTOAUyQgM8sG6zQqFxz9iEjVtTFZe9OZFJEujLQDxF
        KDvlU9UUdIqGqDcsEfDzPE8OLb9zcVc=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-1slSeErYM8CiKLp95p6qFA-1; Sun, 16 Jan 2022 08:00:40 -0500
X-MC-Unique: 1slSeErYM8CiKLp95p6qFA-1
Received: by mail-oi1-f197.google.com with SMTP id bq20-20020a05680823d400b002cac339e9b0so827596oib.4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 05:00:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yWRFWWtptnPxIxbi/2gfOhR6DgAD6LDtgNB3RKI6n2M=;
        b=xEUyD4k+Y9bJbGmLwPhFo/OFsOJTRt9f/We5hhsS/yFs98tUIx/NV9y2dFqc+qlGHR
         3YgTPEP3GNoz5t1Wpr2NF7UDugDCgFp+FG5PI2jgNmbYIZ37JTBFWRwFhpRsX0HmAYjZ
         Ucixa1Zchtii3+rUXTeD9SSEA0GS8pS1WU3AWMisxvDBIB6Srn7FhjWJ3GgEbGfzyAk3
         e6I1LK7zKBVEeG7jGm8FUZtQCegH6Vv9NpMrol0u7oAY9YFCPh0U2YpjgLX/qXf1bOai
         jJ8s93KntRpV6f7Gp0kUJlbh7/kd54oJSzaxfztN7jNt1SBSZqrHzzSfX53h/LrFiztp
         PZDg==
X-Gm-Message-State: AOAM532Vj4f5IMqlQ2zquhb5+2cSFr3X5j+MqEjzBkntNzHsTvp0vfrd
        FWBGmal82LMisoMbOy4uDH2BmFFuJ4xlDro2telX/0JcGv+rXg8OmYdueFvq42dAV37b4eEEn2h
        pWnCbPAuS9rQehV0ThHBPbDo0//9o1/8acAtlxmGl3Gb3lndOinl/jsXgu8TAYPEfBXoih2w=
X-Received: by 2002:a9d:644d:: with SMTP id m13mr12616025otl.131.1642338039609;
        Sun, 16 Jan 2022 05:00:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx0rUedKeEJ61GjeRoQojmafzkXzm3UVGTaMWbmFc/LhGf7BmPXu4PHIVsO4lHRmShXspjC+Q==
X-Received: by 2002:a9d:644d:: with SMTP id m13mr12615998otl.131.1642338038984;
        Sun, 16 Jan 2022 05:00:38 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id w19sm4871545oiw.29.2022.01.16.05.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 05:00:38 -0800 (PST)
From:   trix@redhat.com
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] soc: ti: k3-ringacc: cleanup double word in comment
Date:   Sun, 16 Jan 2022 05:00:30 -0800
Message-Id: <20220116130030.389886-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Remove the second 'struct'.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 include/linux/soc/ti/k3-ringacc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/soc/ti/k3-ringacc.h b/include/linux/soc/ti/k3-ringacc.h
index 39b022b925986..c218f27ba26cc 100644
--- a/include/linux/soc/ti/k3-ringacc.h
+++ b/include/linux/soc/ti/k3-ringacc.h
@@ -256,7 +256,7 @@ u32 k3_ringacc_get_tisci_dev_id(struct k3_ring *ring);
 struct ti_sci_handle;
 
 /**
- * struct struct k3_ringacc_init_data - Initialization data for DMA rings
+ * struct k3_ringacc_init_data - Initialization data for DMA rings
  */
 struct k3_ringacc_init_data {
 	const struct ti_sci_handle *tisci;
-- 
2.26.3

