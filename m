Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0814F22E4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 08:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiDEGKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 02:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiDEGKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 02:10:20 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27C01400B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 23:08:22 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id g22so13656536edz.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 23:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ROXeEvSzaQep2rue/UuQgAQJtln4/qs41ov5tBhK2c=;
        b=IoKqbMUmgOcq6YZ+qyzSLZ1zRJ4ZOpCqXIjOsZeiYJ0/+uSQDxHkpq4eRlwGEk5Nt4
         0QjqSj1tt63etbj+st4KwiFTPbSw0vLmHDD43sSiFEbs7Xxu5igzMIW4bNAhrnwSUj0+
         tbJY75oj22Z0KDNXSnCGyirRJrB23GoyZnuQKMLVeC2W9OuxWi3YljtHxrCrDM3vPe2u
         A6sa3od8nPqiKpuAHMd2wC7LV5qM59qmka5Djqgx1RXhh2hRPyOclGQYqPVmaQJd7+eJ
         yMDR7HPu386E98XkxjqeGn/qehEANyP/5nv5aOB7NqwZc3DpTyUPJjLrS+ZDmH4Spg8p
         0vdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ROXeEvSzaQep2rue/UuQgAQJtln4/qs41ov5tBhK2c=;
        b=RWhEk1sSwaBN9OzXMmUU8TjwR1g6OpykXT5uYuBIowZg/muEhlnSzBGEpBVcwPneLD
         uLRwQWuZ/oyRJjp8Y2RBuum2MweVg8So8LZx31+BxpB56ueL6aPvor2dO7RmHQSrUVMZ
         t1fp1ZBcDk83EQbpjlUsDLuEZLr8JI+jD9rDi5GYBoE6KdywLyKekD45y0Eb8C9Oav9V
         FV/KgdXz8o7Iay8HesYqhw6420W1k+x9S+yw9WOUGicn5JozIK5ARHLl0kPwFBCZzM8V
         NPYhueCK4My1FxkPF8fcLWLsZBIq60R6Q5bkgUP9/Xjsx1Med4DFsvL+A3HipFW2NH2W
         zkMw==
X-Gm-Message-State: AOAM5311+BcRRC9e+hHTerIp8eM7iBqvJHVnNYPOa6oBnEr7IRmE/3NQ
        H+e2h/eZkwQn8GZZuscF4ZY=
X-Google-Smtp-Source: ABdhPJycyQMuNsQT2VEkK5hILonrxPniN2o0a6T3GkmK+k1ebpycGq9Nkackc1KmS2EKNnmXeZwtaw==
X-Received: by 2002:a05:6402:1541:b0:41c:bfb9:d56b with SMTP id p1-20020a056402154100b0041cbfb9d56bmr1860176edx.344.1649138901381;
        Mon, 04 Apr 2022 23:08:21 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id h5-20020a170906718500b006e7edcda732sm2484538ejk.125.2022.04.04.23.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 23:08:21 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 2/2] staging: r8188eu: remove unused macros from ieee80211.h
Date:   Tue,  5 Apr 2022 08:08:13 +0200
Message-Id: <20220405060813.8448-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405060813.8448-1-straube.linux@gmail.com>
References: <20220405060813.8448-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused macros from ieee80211.h.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/ieee80211.h | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/staging/r8188eu/include/ieee80211.h b/drivers/staging/r8188eu/include/ieee80211.h
index 8c20363cdd31..bf4ce3cba46f 100644
--- a/drivers/staging/r8188eu/include/ieee80211.h
+++ b/drivers/staging/r8188eu/include/ieee80211.h
@@ -123,24 +123,6 @@ enum NETWORK_TYPE {
 	WIRELESS_11BG_24N = (WIRELESS_11B | WIRELESS_11G | WIRELESS_11_24N),
 };
 
-#define SUPPORTED_24G_NETTYPE_MSK				\
-	 (WIRELESS_11B | WIRELESS_11G | WIRELESS_11_24N)
-
-#define IsSupported24G(NetType)					\
-	((NetType) & SUPPORTED_24G_NETTYPE_MSK ? true : false)
-
-#define IsEnableHWCCK(NetType)					\
-	IsSupported24G(NetType)
-
-#define IsSupportedRxCCK(NetType) IsEnableHWCCK(NetType)
-
-#define IsSupportedTxCCK(NetType)				\
-	((NetType) & (WIRELESS_11B) ? true : false)
-#define IsSupportedTxOFDM(NetType)				\
-	((NetType) & (WIRELESS_11G) ? true : false)
-#define IsSupportedTxMCS(NetType)				\
-	((NetType) & (WIRELESS_11_24N) ? true : false)
-
 struct ieee_param {
 	u32 cmd;
 	u8 sta_addr[ETH_ALEN];
-- 
2.35.1

