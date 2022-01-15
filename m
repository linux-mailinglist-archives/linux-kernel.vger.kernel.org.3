Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8553248F891
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 19:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbiAOSBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 13:01:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49687 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232372AbiAOSBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 13:01:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642269691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JyQfKnGPAvPAfBFOiNiSn6b94cEh37W6h0P28jZ0IfY=;
        b=fBUj3Imt0e0X9MeOjKS+ggu9uTjM91b6PLSAF/dCgTBIXJjXHRYsQGj+l+ploFRnAbWNcD
        2F/XC+GF1MBoocWwyubkT9Ecx1gQCCw+fl/XBGx1P7QbpFCYVbjeBugcRQ7DwckgPeA4PP
        WPngZg3LkBv2sex30vy0sUoEePc3fo8=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-434-y1WkMAoAMpmMKo_tmiiHYw-1; Sat, 15 Jan 2022 13:01:30 -0500
X-MC-Unique: y1WkMAoAMpmMKo_tmiiHYw-1
Received: by mail-ot1-f72.google.com with SMTP id y11-20020a056830070b00b00595da7db813so1188070ots.16
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 10:01:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JyQfKnGPAvPAfBFOiNiSn6b94cEh37W6h0P28jZ0IfY=;
        b=4ge55QYdJKpYPpibLarNFi0wl/odjtgTgALFYTgvvVLnyx15DSOn2euRQ7LR70fs7F
         sPUjXm1EesEsKRBByIdF3YQijuwU3QhXMVgtSg2bPyNOy0EBTeXvrUAfE4emVoUy6mj8
         +pmnOK6mQHr76dv6ZdgLbZiagEuFQ9jXW4OywYRAKW75p05pgDyRpbcXcR8KVrGGZ96u
         OXr+Z6+KNBbEERMrOKzy3c3i5AlN+CUZg7wHXwYO78YQX6rW/FiP2vq+mvxdSaPtch85
         RUk5XWYnx/alDT9R7H7DZbxYBHXEpb82i6ajqUxuuJr0dBrgW3D//sHCzyGU4OpxINb0
         BaDw==
X-Gm-Message-State: AOAM5306IKxL4bnvcI+Vi533WGH26FOBiPy6HXW99ksVgMv44tIZaMFR
        jU5uurIqfit1go9yA8b1ZuIRk2l1o+634/uhB1Upk8SEox7VITAcryjBwoZmN5l6tXDO9fgyhP6
        SwnCqF9RAL9csto9W1C9CyGQwaFU3vQIRdavyqoB2UeC0fouIypBdx5jj9IHc34/WDyKdqsM=
X-Received: by 2002:a9d:43:: with SMTP id 61mr10882517ota.18.1642269689207;
        Sat, 15 Jan 2022 10:01:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyDQLcjQ6ioy73xO4LMv0dpb80iYO16e7r4SPWviOK+YlZ/dsAnGiRL7IwDC2QiSs3tZ0N0aA==
X-Received: by 2002:a9d:43:: with SMTP id 61mr10882499ota.18.1642269688977;
        Sat, 15 Jan 2022 10:01:28 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id k8sm3379615oon.2.2022.01.15.10.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jan 2022 10:01:28 -0800 (PST)
From:   trix@redhat.com
To:     linux-kernel@vger.kernel.org
Cc:     Tom Rix <trix@redhat.com>
Subject: [PATCH] platform/x86: cleanup double word in comment
Date:   Sat, 15 Jan 2022 10:00:22 -0800
Message-Id: <20220115180022.298127-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Remove the second 'of'.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 include/linux/platform_data/x86/pmc_atom.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/platform_data/x86/pmc_atom.h b/include/linux/platform_data/x86/pmc_atom.h
index 022bcea9edec5..d4429fbed0940 100644
--- a/include/linux/platform_data/x86/pmc_atom.h
+++ b/include/linux/platform_data/x86/pmc_atom.h
@@ -47,7 +47,7 @@
 #define	PMC_S0I2_TMR		0x88
 #define	PMC_S0I3_TMR		0x8C
 #define	PMC_S0_TMR		0x90
-/* Sleep state counter is in units of of 32us */
+/* Sleep state counter is in units of 32us */
 #define	PMC_TMR_SHIFT		5
 
 /* Power status of power islands */
-- 
2.26.3

