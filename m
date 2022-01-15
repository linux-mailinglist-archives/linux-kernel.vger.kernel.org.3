Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED71648F8A2
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 19:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbiAOSIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 13:08:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53647 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231278AbiAOSId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 13:08:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642270113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JyQfKnGPAvPAfBFOiNiSn6b94cEh37W6h0P28jZ0IfY=;
        b=d33HeuHzSmYW5cOVYz5GRL2Ira+mxvP7SJQugWrQSdSrTIGMn+XZ1FlTA3nAUXFp7bhPCN
        H+Tg/WfOEj6oQUzy1mgN3GQmNO4HwJnD1fVOwceyRX1filZtlbfclDjC8Hqs94BtzSoz8S
        ypns6lPUMzc+uqH32OLJkifQfNbpxtE=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-dlVz6wCDMKeqoi5YX3dOlA-1; Sat, 15 Jan 2022 13:08:32 -0500
X-MC-Unique: dlVz6wCDMKeqoi5YX3dOlA-1
Received: by mail-oi1-f197.google.com with SMTP id v72-20020acaac4b000000b002c8dd559f44so8580755oie.8
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 10:08:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JyQfKnGPAvPAfBFOiNiSn6b94cEh37W6h0P28jZ0IfY=;
        b=noGxwCjwFRfConG4tXWSEVjNyyt5GO5795Ne3ah9K3U60T243/aLnSItVK89yeCJsn
         vL+6qMgb8Mj2WvmPp1gZ5ddfbNuNC5qFXJLOj0Zn0nd5l4dmgkT6I1Nre0gnINq7RoG1
         2QaRsPgot8TH4kD8XT0BO8YS/+sSZIoYlSc/0YwtPuPiXpD2xBOJIqndfd0Z6kK2QjH5
         ORv5KXmcJjVKtVbnTZg58fOO3CzIb7WWebAm4Syks3bFaOJcxcNadWJj1PN4Zdy/3DnS
         dplcuC/0kSHGeSAT2gyfqkoufwlZFM1WWh3DHi5H9m2R5gJNIMxo7g2Hv8y9TiAMdWoW
         DEDw==
X-Gm-Message-State: AOAM531rw1I5mh9p5m9bp5RuFmhlXqlMPPI2NyEa3uEXJim3QGTPr7Vx
        +GYQPx874QVDruxw3n9lY8MmSierH4IBjK6plyTtOmKBTCLveCiLfKBhK0jNbcCAyzQCJ/T4kNM
        hJCgt9C7ASTL5RpF0C4vcF0Gb9hLjmSf7jo70YolZQB+z+gFqiKZQWwadGXhRs8fJ4ZR1lhw=
X-Received: by 2002:a05:6808:6d1:: with SMTP id m17mr15682069oih.139.1642270111234;
        Sat, 15 Jan 2022 10:08:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy8UHfpbAEw/DgpZ4065a673gWeLyT611t101R+gnyCobU06v3ZXI9EFNERAOYmadzAH0FkwA==
X-Received: by 2002:a05:6808:6d1:: with SMTP id m17mr15682062oih.139.1642270111078;
        Sat, 15 Jan 2022 10:08:31 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id r25sm2345856ota.59.2022.01.15.10.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jan 2022 10:08:30 -0800 (PST)
From:   trix@redhat.com
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] platform/x86: cleanup double word in comment
Date:   Sat, 15 Jan 2022 10:08:22 -0800
Message-Id: <20220115180822.298982-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
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

