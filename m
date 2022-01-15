Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B121A48F88D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 18:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbiAORxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 12:53:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:43832 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232372AbiAORxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 12:53:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642269187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=H6OoxCkI7fG8A16oQRFEumN9Lwt/USiivt1NkSzppcU=;
        b=BMGzPfkGp0/twyWTm9uwIEKOxihc3rYwg4urQ/urrO2QU/JigM1DlH92h3oDlM8THySxHg
        Ezc912gltkj/myld8kpa4dbpDt/qEQYQwIFa59UMDyY6O/tZ9XLFsi++MUWuC7s3tVOAOh
        8ZJDkwFUzrinMOQWAxRguCSt6hdts5U=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-487-K_qAHG-VPaKkJt0WK11-yw-1; Sat, 15 Jan 2022 12:53:06 -0500
X-MC-Unique: K_qAHG-VPaKkJt0WK11-yw-1
Received: by mail-oi1-f199.google.com with SMTP id s127-20020aca5e85000000b002c807e9c48aso8519941oib.10
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 09:53:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H6OoxCkI7fG8A16oQRFEumN9Lwt/USiivt1NkSzppcU=;
        b=SDJi8iRka0Lr3IuJX6az2+3gVcSmGXFvSGHMyEjaxz/NgdmMkq/fbWvY2EqJXOPdqM
         p1dEFodLZCqZwiv/QdrbSo3R1yOQVBEWB0/CyUhTz3uQK8FCM1haNa9XFuKlEHiNsZVB
         CaPkzXOzHr+M95ExrNlnaZ0Ir//wy433JiIbEhqyZiVMqe2+e8nfqbqfXD/FDbq1Y//U
         56Hqc911DmBwIiLNx/YXFEvzZGYqQqmuUO4fF1/uSs01mbl6zFI5LzHliHBXwPKD3Bdd
         uH0qR4ImDVihupvnqE2830zKAhH97T2ox6uSqybb7P55djn65nQuWy75zgqzlOAm8cBo
         sKSQ==
X-Gm-Message-State: AOAM533gqOAZiQUTPrXMhVK0UEJ2prQ2k1RUCQAW0sdSWUNIZV6ntSOz
        VH5cf7960EeVB5l/kD7Xblb79WxCUDli3BUzkQQLtkVDJF7AzAYfiDPJ/ZFzAYEMzhAeoE/jsY0
        PsVV0f8rcDeds1XJSCLgxmWCPVff1cKqjcikHfcBU68qv/AjjoTXrsket5DtagjoOntvsD+A=
X-Received: by 2002:a9d:6452:: with SMTP id m18mr10836767otl.99.1642269185723;
        Sat, 15 Jan 2022 09:53:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx9FEvJu4hwH45VQzjU0SGArx6HF4tcZhBFJpeHe0t/HSRhSFhG4SAO/rliXGInygdXW0hzuA==
X-Received: by 2002:a9d:6452:: with SMTP id m18mr10836753otl.99.1642269185500;
        Sat, 15 Jan 2022 09:53:05 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id n26sm3653046oij.5.2022.01.15.09.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jan 2022 09:53:05 -0800 (PST)
From:   trix@redhat.com
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] memory: emif: cleanup double word in comment
Date:   Sat, 15 Jan 2022 09:52:52 -0800
Message-Id: <20220115175252.297433-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Remove the second 'if'.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 include/linux/platform_data/emif_plat.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/platform_data/emif_plat.h b/include/linux/platform_data/emif_plat.h
index b93feef5d586f..53057713c9fbf 100644
--- a/include/linux/platform_data/emif_plat.h
+++ b/include/linux/platform_data/emif_plat.h
@@ -98,7 +98,7 @@ struct emif_custom_configs {
  *			as type, bus width, density etc
  * @timings:		Timings information from device datasheet passed
  *			as an array of 'struct lpddr2_timings'. Can be NULL
- *			if if default timings are ok
+ *			if default timings are ok
  * @timings_arr_size:	Size of the timings array. Depends on the number
  *			of different frequencies for which timings data
  *			is provided
-- 
2.26.3

