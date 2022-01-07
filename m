Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62CBB487C33
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348736AbiAGS2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241093AbiAGS2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:28:17 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC719C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 10:28:16 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id q141-20020a1ca793000000b00347b48dfb53so1303754wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 10:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=urda7dukOjrduEUTaGt81lKPi62bFg/eZfAHEnqnCIg=;
        b=gloVyOKLDM2n1melDN1jmsJswfStK3ckg1+saVhwtTmTctR15QrSoAldJg3BvggjMu
         EMSAhEHWrUUJIcmNO8eUXXpPdhcs2Q9TEDoV9A8QUCZaJ06i71G2ecpm9sgzwZJOeaao
         +cFOXqdTWRSJHR9nRxw5VwK3WDU3tj2LyVZEmRtE2jcEukXEp2wFW4qex3Ghd1AC9V36
         20Oh2t76aZKkViz0LnwkcYHrAMnZ8P0jozlv/QPJfjPRkk3fS92i9S4IH9SFY/JQeP/r
         eC3dmHvrUmsm9ZCqGjhaWR9T1y6WOan8BCKr5WM5KrlBcMFOi4CDtmTYy9mk6WZFRF8Y
         Tx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=urda7dukOjrduEUTaGt81lKPi62bFg/eZfAHEnqnCIg=;
        b=0/GD+FtCmySjisAhjF1p13SLdTqF349roFK9AOTwZhTz5vHPudnuadosCQGoy6wlSf
         HDW8HJC0tnMGdxLzTMzQ9UMhhPyMCNB4tD+rrQnSwMoG1p6MxM5o2BJTW+AE6anX8RJt
         +V0yd+Ps61cQzySiCKSj7f4ZGU32kEA6/VDRmBQNVDkBRe0t2lPwUCBYj5VFlf2Xucpj
         q0OkifDeyqornXEgrbrDgd8Te+5R+HWVJhqmkBIHJeMpY7OJq3MvDm0t4+YmH5tTUVn1
         ZpeRPcJwttbO/28y/IXySJ9tRw17xfip8B/g2o1fsuR3m8M0Roy90Nm5wb0MBifoHcRX
         NEQQ==
X-Gm-Message-State: AOAM532sLcx61XzAvjJfIldGsTuH2LKT9I9aADXrJh+KmqjMFE79sp0u
        nXT7Ai+82y2YZ9tsy5maJdMI9ASO9rRszg==
X-Google-Smtp-Source: ABdhPJwabAvd1EH2SexXZ080BbdJeepu7hHYBJaMGKOUOUGw2xitoVaOt2tkFDvBpxPtS8ZgYEQ3Qg==
X-Received: by 2002:a05:600c:3d8f:: with SMTP id bi15mr12037071wmb.172.1641580095018;
        Fri, 07 Jan 2022 10:28:15 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id p62sm4913499wmp.10.2022.01.07.10.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 10:28:14 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     melissa.srw@gmail.com
Cc:     mwen@igalia.com, rodrigosiqueiramelo@gmail.com,
        hamohammed.sa@gmail.com, daniel@ffwll.ch, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH RESEND v2 3/3] drm/vkms: drop "Multiple overlay planes" TODO
Date:   Fri,  7 Jan 2022 19:28:09 +0100
Message-Id: <20220107182809.141003-3-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107182809.141003-1-jose.exposito89@gmail.com>
References: <20220107182809.141003-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the task from the TODO list.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 941f0e7e5eef..9c873c3912cc 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -124,8 +124,6 @@ Add Plane Features
 
 There's lots of plane features we could add support for:
 
-- Multiple overlay planes. [Good to get started]
-
 - Clearing primary plane: clear primary plane before plane composition (at the
   start) for correctness of pixel blend ops. It also guarantees alpha channel
   is cleared in the target buffer for stable crc. [Good to get started]
-- 
2.25.1

