Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75D948FD1B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 14:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbiAPM7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 07:59:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46336 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235281AbiAPM7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 07:59:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642337988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DNYqjS3KFZ8+i72HB477mvELEUPUlmZhwi7en5ySxHM=;
        b=PDB6vdzKgFBrJxKNiNeVQTRa+wjWuH3yXayE2jUpwCkfNV8pBTDT+OzGknoWBCJQWDIEwp
        KI5fEY/z6Vw9Mj/K+Umperc8r77O474FT74e8Ciw+a5yI0iuX4ca5RG4V6x9x3ituH6OpU
        Z8j7azPL73lp8HnwHUuaorgPji16bj0=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-314-0EGiU0_rME6OE0qEMv8LdA-1; Sun, 16 Jan 2022 07:59:45 -0500
X-MC-Unique: 0EGiU0_rME6OE0qEMv8LdA-1
Received: by mail-ot1-f71.google.com with SMTP id 39-20020a9d0eaa000000b0058f56d89582so4232808otj.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 04:59:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DNYqjS3KFZ8+i72HB477mvELEUPUlmZhwi7en5ySxHM=;
        b=o2m/Y0+thOcHi5izOezh8yh/0nhQbSWoWPBU0px6yEInmGvY4YEz5G+obDOrKeNW0f
         xLk0F08if/dT01LaxbeD+B+2CMg2BCaXSgL5d2SCiV4BDN4D54oZKPdwVltSreA5Pma3
         GimGi1msfhpqB118ng0eF4Nau7B2L+sZiB34RWXPqA25aB0tGo9BYcXy3E3fC7Hp0FnU
         46oRn5ayWuvfHgLra+VAO4SMiGYMQG7qMtl7aBKBZ1RGdSWS1eiPXkldGL4hFY9iorfC
         39jdPFkjjzTcdB3JNCYkyAuryQDbMXLae30AgKCbgwizB5eET9msfr1LTkGRvbwqquy7
         CWIQ==
X-Gm-Message-State: AOAM5326NScUPkuuuskxQ2jrmcH8WFEzsFPOvGoCme8gJ/q0j2T1WTUN
        0ZWszNMr1srHwOY5C2toKKdrMerIbBsQotF46NTr829UHmPIKp8hQRAgz5KCq5TiISbYFRBw0x7
        8A7I/BCEYuQexHUwwqykJz6t0
X-Received: by 2002:a9d:730c:: with SMTP id e12mr7152946otk.169.1642337984014;
        Sun, 16 Jan 2022 04:59:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyrfpxyWsulP1/h6vkbFQ4Qxe0Ta5JWTP2oWkUQEO76XbZQsGOdY13EWOhJiDhQ6zPtsr8a4w==
X-Received: by 2002:a9d:730c:: with SMTP id e12mr7152923otk.169.1642337983480;
        Sun, 16 Jan 2022 04:59:43 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id e69sm4347369ote.1.2022.01.16.04.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 04:59:43 -0800 (PST)
From:   trix@redhat.com
To:     jack@suse.com
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] quota: cleanup double word in comment
Date:   Sun, 16 Jan 2022 04:59:36 -0800
Message-Id: <20220116125936.389767-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Remove the second 'handle'.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 include/linux/quota.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/quota.h b/include/linux/quota.h
index 18ebd39c94871..fd692b4a41d5f 100644
--- a/include/linux/quota.h
+++ b/include/linux/quota.h
@@ -91,7 +91,7 @@ extern bool qid_valid(struct kqid qid);
  *
  *	When there is no mapping defined for the user-namespace, type,
  *	qid tuple an invalid kqid is returned.  Callers are expected to
- *	test for and handle handle invalid kqids being returned.
+ *	test for and handle invalid kqids being returned.
  *	Invalid kqids may be tested for using qid_valid().
  */
 static inline struct kqid make_kqid(struct user_namespace *from,
-- 
2.26.3

