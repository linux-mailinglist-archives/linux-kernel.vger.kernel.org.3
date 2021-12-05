Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B88468B4A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 14:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbhLEODC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 09:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbhLEOC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 09:02:58 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A7BC061714
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 05:59:30 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id y12so31768277eda.12
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 05:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HPuzYR8QORZOgJOB4QKAyq9QStxUBqC+STv8VWMkX4c=;
        b=dORf0ZDwVI0bp2YAX6DjjLwYiu6PDTIfH+w4bFIVgNqgeMIgDQOdS/x2boZTsS7QCX
         IJDCJ8sQYXQD7hxVsTKrN1NiIabzVYoTVb3D8XjUCqqpVhWz+XElAYzy1lpPEENnGf//
         dDEhI885bG4uWKacsteRKwrpP1UyejwCNRFopW99QPctEPbjtxdJMMDxZNcg2FBhRfOz
         EMgoIfMkUhi958HXI3QANp2thC5VHJF1hBYNauQV9haZ0IuykxobCXGBOad/6fbnzghV
         5j6Uo9X9xeL2+en1FpFFElSGUF5xnLSpUp8ghrBXa5i1oGkjn/2kqCvgT3Iq40gDTKpY
         5Jyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HPuzYR8QORZOgJOB4QKAyq9QStxUBqC+STv8VWMkX4c=;
        b=mJHfkIT9ubajjn6fbpwh+xB5fSDmQ1e0iptnRKWbA8Ws05l3MksCDJQGSOgpUMe3yU
         S53rn5sxRsb06HbzZaB/gsVFvazvSSMRz5whyUmpzZ4H0ZgmncNOe0emJasQP4p4O6zw
         MaJdYpwHXQDmd8rz+JORQqg7lFBkEnDNP2Tr1ktlWoBAQqhxJ5XG1HpqR485ZXukN+gL
         jeczbN36ubqH5cHFDU97nJsJSZr4pDFxUqfosMRekl7jxgzD3W45RZhxCIkHh7CsQAbx
         lKGVAi+OEjH+W2EKYYLu0c/t2t0kaRit0tucRLdo6U3UKV7Bl9+7RPWQX3qQZAjQiH/N
         P23w==
X-Gm-Message-State: AOAM531CXwHIqj13reRGLXlDy40Zm86wNUWHmYII6Ac2jH9mBSoPzoPD
        WjhCjhM73e1npoqiNz9QwlQ=
X-Google-Smtp-Source: ABdhPJxw+P70SMSYbVsQxn1RJB06jY5o8uI/tEz3sSB/gbN2RIdsO7CwZBVYG5Bw29gZcvdlhyWWuQ==
X-Received: by 2002:a05:6402:1768:: with SMTP id da8mr46181832edb.252.1638712769075;
        Sun, 05 Dec 2021 05:59:29 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::5a05])
        by smtp.gmail.com with ESMTPSA id yd20sm5146451ejb.47.2021.12.05.05.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 05:59:28 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 02/12] staging: r8188eu: struct odm_mac_status_info is not used
Date:   Sun,  5 Dec 2021 14:59:09 +0100
Message-Id: <20211205135919.30460-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205135919.30460-1-straube.linux@gmail.com>
References: <20211205135919.30460-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The structure odm_mac_status_info is not used. Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/odm.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index df232867eac8..f83b94a74b70 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -176,10 +176,6 @@ struct odm_per_pkt_info {
 	bool	bPacketBeacon;
 };
 
-struct odm_mac_status_info {
-	u8	test;
-};
-
 enum odm_ability {
 	/*  BB Team */
 	ODM_DIG			= 0x00000001,
-- 
2.34.1

