Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C3B48083E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 11:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbhL1KLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 05:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhL1KLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 05:11:46 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02987C061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 02:11:46 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so6096361wmb.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 02:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j1aFnyHFUtPdBZotM5iBED56xT2FvKcAtJi+DzbG5wA=;
        b=ZOTCc8hb63q9418FaiqBdAUzCMOI6zc8pbICndChUVCr4dtLo6I3GJ3QWC+M/y1IvR
         +UuAgaTdIxNxLsfGyhO7L11pxIS3N9mribQQ7Gpk7POSfOi7nXNi510yYOA0g81LKFbC
         ZNGy3sw4hhsX4FWdCvLVCZA2RmgsoV1phDWLw4xHc60UgfB6mXKK3DN1vNa90k6vQbSy
         5XyFizqrlg1FrlD68qmnUzgXvq/2bNIiKo4E6SIDry5jOL7n+VpEJnSiw4XWLH+2WaCR
         h8mBeho8soputU3nud86sKfP8qvaC7bA8r1/ZuNb0xLDLGQYAWTKJ9b5j9w9AXlL0kTN
         Dtjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j1aFnyHFUtPdBZotM5iBED56xT2FvKcAtJi+DzbG5wA=;
        b=2HDOqhf8uUP3ft6fAKnsMQmAOIF0cz1mTwKlerCEHcNXNhmTUdq2Po78lBTRlDBd4D
         bu3tY+mYXe3rgRLH3KfoKwoBgf13C50zu7weYaGS4ULa83Hl/0IpkpQ2IWQ0m8VZv6Ws
         D154RVZHr2aMigWn42IecW2RPvh/x67eIzcIrrWFuaq66VfKlwS4b20yk0Os3D6ufsqK
         vI0dk/drFl1tEyTpW2JnyRFtVEIby/RW/DzknOXH1p8K7LjeoR8/VlJEPVclBuesHSGs
         G9PO+UhblrrkAXLdq7LcNbiWnDVAscSzOvwVpuVRrSII17dSd4l9QyxE0U5Jz20nbTCu
         8A1w==
X-Gm-Message-State: AOAM5314Df+EmLoYw3a0K+VR6+jw+J5YN3JgNbRh3zC2SF6yEAVVPnxb
        np1/EqoQERs0MTmIDD0DRg2FhZl3wGk=
X-Google-Smtp-Source: ABdhPJzWbaHSeTVaieSdzN6jiQhmL/D+iZDpgSpCs7saI+O3cowFz3vUnff9dAQYLqHbvNIAHzbdFg==
X-Received: by 2002:a7b:c249:: with SMTP id b9mr16269975wmj.159.1640686304626;
        Tue, 28 Dec 2021 02:11:44 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id d62sm21160984wmd.3.2021.12.28.02.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 02:11:44 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 02/10] staging: r8188eu: remove GET_CVID_ROM_VERSION
Date:   Tue, 28 Dec 2021 11:11:12 +0100
Message-Id: <20211228101120.9120-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211228101120.9120-1-straube.linux@gmail.com>
References: <20211228101120.9120-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro GET_CVID_ROM_VERSION is not used. Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/HalVerDef.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/HalVerDef.h b/drivers/staging/r8188eu/include/HalVerDef.h
index 1d96657e6a98..62b94c993f0d 100644
--- a/drivers/staging/r8188eu/include/HalVerDef.h
+++ b/drivers/staging/r8188eu/include/HalVerDef.h
@@ -35,7 +35,6 @@ struct HAL_VERSION {
 #define GET_CVID_CHIP_TYPE(version)	(((version).ChipType))
 #define GET_CVID_MANUFACTUER(version)	(((version).VendorType))
 #define GET_CVID_CUT_VERSION(version)	(((version).CUTVersion))
-#define GET_CVID_ROM_VERSION(version)	(((version).ROMVer) & ROM_VERSION_MASK)
 
 /* Common Macro. -- */
 /* HAL_VERSION VersionID */
-- 
2.34.1

