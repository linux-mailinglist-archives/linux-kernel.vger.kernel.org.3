Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6226647817F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhLQAia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:38:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:39538 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231239AbhLQAiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:38:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639701496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L9Kdv1BnC84e2FlVjxnWyfJZeNCXcvPbc+pBmSsvwjo=;
        b=ckY4LF6IsPG1eU/Jd3Y5naykvd0J4HJluEB1Lj9qsBUIuKv33L1dkgGSto8IkwfbR9HaGr
        1riRmpbwx0gRHvoYybz3sPps3ljRYN6n0JBhIk39AeZzZeWYnnbKdHwQz3ca8CocIAHFTe
        Y6deKctDF4he31AN66UjQO935dW9ejw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-331--giJVrr_OvCD5oa9g6BSQQ-1; Thu, 16 Dec 2021 19:38:15 -0500
X-MC-Unique: -giJVrr_OvCD5oa9g6BSQQ-1
Received: by mail-wm1-f70.google.com with SMTP id 205-20020a1c00d6000000b003335d1384f1so2086091wma.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:38:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L9Kdv1BnC84e2FlVjxnWyfJZeNCXcvPbc+pBmSsvwjo=;
        b=B9zkqWO9OlVjdr4/74RM/HJrG9vYz2VErFxc8aXApSYZiRb5YEqyjPE4xCBARqqkdS
         vomsYcYvPpEo4fyb+FBIBFcxtAXPC+gSFsc5VahDRh3TqJFKf6ypFf31TGqf+YNLvMUN
         oJTOUV9i7UbLkxBL2JvP8WilT7cCS3g1+e8+EItUoQeFrYHchxAlPqDGnIkje0ERQBiL
         wTtaZJZXyqpRhNTyyo+gtnM1bi8ay81iTszpLbyt9gIPMHseZVy3GD0KYWANsi3A3etc
         fgeWxRAuArpJG38RYlQRiGA8O47gVdL3TqEHssKOSp1iIV1PqXVjhNh4d3Ty8gqH8PEl
         Q69w==
X-Gm-Message-State: AOAM532EEVU9XaMjKsvTIzKRHFxdabDrbLB3+VQdsk/wkhrscN9fVsKG
        8yMIExEaQDYH9VTMnk8/wWK4xZjIrRzIDZNU4cHiV1AvnPA4UrTfz+LLx2qYq3oBFyHGaWbpF9n
        Sibe0vo/z+kNf/XaxaDPleImd15aFlpRrK+10ABwDGPO79uV23/NAY6o9GQYFVFSiXmvXXX+pQ5
        Y=
X-Received: by 2002:a7b:c0c4:: with SMTP id s4mr380968wmh.26.1639701494676;
        Thu, 16 Dec 2021 16:38:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw0aQVRZeEw66cSjF08xLNomjEmR4MO0MznUe6JE7kwn91N5Yo6B9M66D/DXIcmCuZ5gFpJ6g==
X-Received: by 2002:a7b:c0c4:: with SMTP id s4mr380950wmh.26.1639701494362;
        Thu, 16 Dec 2021 16:38:14 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg12sm7368433wmb.5.2021.12.16.16.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:38:14 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v2 16/37] drm/sun4i: Use drm_module_platform_driver() to register the driver
Date:   Fri, 17 Dec 2021 01:37:31 +0100
Message-Id: <20211217003752.3946210-17-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211217003752.3946210-1-javierm@redhat.com>
References: <20211217003752.3946210-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro calls to a DRM specific platform driver init handler that checks
whether the driver is allowed to be registered or not.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 drivers/gpu/drm/sun4i/sun4i_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index b630614b3d72..4a2555509e7d 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -441,7 +441,7 @@ static struct platform_driver sun4i_drv_platform_driver = {
 		.pm = &sun4i_drv_drm_pm_ops,
 	},
 };
-module_platform_driver(sun4i_drv_platform_driver);
+drm_module_platform_driver(sun4i_drv_platform_driver);
 
 MODULE_AUTHOR("Boris Brezillon <boris.brezillon@free-electrons.com>");
 MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com>");
-- 
2.33.1

