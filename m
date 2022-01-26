Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F5949CA91
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238367AbiAZNSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:18:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33893 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238267AbiAZNSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:18:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643203112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tCn89VNP4QPt8s8WQRVWyuC2AryW74LBEzVPDP/rwUc=;
        b=LfOwxr2iwfQLAyBdQ68c21pg/QqHA95vJSNyIMvNQQW8WFU6kPVhE9ada8/ZgfUapGjSeG
        hpUN9ae/OvveFn7/cnjkPs/0rRijpd0+lBEDR1KL9S+McegsuDQsGTM4AeIBAGhk5hj8N9
        4RiNz8V2o5VWZqyAj8iQaf+DWcsvcF8=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-_WcXg0iQMQev7w3YVH9M5A-1; Wed, 26 Jan 2022 08:18:31 -0500
X-MC-Unique: _WcXg0iQMQev7w3YVH9M5A-1
Received: by mail-oo1-f70.google.com with SMTP id s10-20020a4ab54a000000b002ea051bad32so2307633ooo.14
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 05:18:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tCn89VNP4QPt8s8WQRVWyuC2AryW74LBEzVPDP/rwUc=;
        b=oviEO+nEG/VxrnHj4TeUVtxwrD+dj2qWAEW1GGtiIRKLBIPtaTYWmBo+lEMqN/Eirg
         nKBdeWNLSoalI2GboTbF1TrXq0X34icJsBP4xrRJs0+aiYXapRuCWFhJCYx2hQPbcum2
         c+yJgvr0m7mc/jEwpP0x9I5QgmSyeiqSk2wTBo/7Vsz49zkMHidVkHXq9j/dke7G/FdS
         AcKM7NHHfBiBmV4aJDboQ2omkkYYYnZ8sm3/aAlz0pCTCwqGIzFlfhM+FereDy+zmfCh
         H64mutj3M0Aruh8yc4sFgf70K6I6vkiNgjLciRwXRr+cwH+jakyosI46mweh4di+kOto
         Ef6Q==
X-Gm-Message-State: AOAM531KZG3KzLn1Y+x+cCuoHaXUgCWka+1vi1tAbCg6+jzhLRDTG4Yr
        0PgW3fdeKx+H4+HlkvsRQAxGhZ/ot9XAS3iUvC5FediVGNnkIzGZb2M43NkHGYiOYMAy2Sbo+6v
        WW7XGcBs6Hoqcn8a/M6Dq+z10
X-Received: by 2002:a05:6808:bcc:: with SMTP id o12mr3557182oik.66.1643203110750;
        Wed, 26 Jan 2022 05:18:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzqzuvTIeKOL1AFkX6tuoLQmOhK8vCGo5KkDw6PARCkBSCzwu1jaDTH+ZCt1VS+OT/gClKTUw==
X-Received: by 2002:a05:6808:bcc:: with SMTP id o12mr3557169oik.66.1643203110577;
        Wed, 26 Jan 2022 05:18:30 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id z186sm6603449oiz.20.2022.01.26.05.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 05:18:30 -0800 (PST)
From:   trix@redhat.com
To:     agk@redhat.com, snitzer@redhat.com
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] dm: cleanup double word in comment
Date:   Wed, 26 Jan 2022 05:18:26 -0800
Message-Id: <20220126131826.1168355-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Remove the second 'a'.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 include/linux/device-mapper.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index b26fecf6c8e87..4c621e35dd5c0 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -358,7 +358,7 @@ struct dm_target {
 	bool limit_swap_bios:1;
 
 	/*
-	 * Set if this target implements a a zoned device and needs emulation of
+	 * Set if this target implements a zoned device and needs emulation of
 	 * zone append operations using regular writes.
 	 */
 	bool emulate_zone_append:1;
-- 
2.26.3

