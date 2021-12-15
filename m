Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0048475096
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238945AbhLOBsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbhLOBsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:48:40 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BE0C061574;
        Tue, 14 Dec 2021 17:48:39 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id j17so20352497qtx.2;
        Tue, 14 Dec 2021 17:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G0Tatyf4cSWakgRQn9yIH14VMYHZApGbobtZFOBt3DQ=;
        b=Uhdqosbe+w9V+S4PJYild7ZI9yZCNHaACLyHGIWViiKxidXV7C5BGrEi22c+1Ko/LL
         +4qTjJ/H2Wpie7CjDa6yI5kMCZ38lPqwfNhaNpppbS/aEfdprejUL2fnkH6s8gOAW3kG
         WiFgDd9o31GS/2s1mZsGeYSZ5h3Y+qL3EN1T4e1wawGxhfvGBMNpCo+C9teqGqr5iHwM
         tLhdv9dQliYlxAsJdFmAeWZUmRr114R4WnpLQBje1vOFYTyh3lllPw9WBVcTlLo1bIkD
         9p4qQcO/TruW/zRIY4+63LP2cQxWwC96R+mExaRlNoiAkSDW1Pw7tSkDz0ja+k1xjPh9
         S5rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G0Tatyf4cSWakgRQn9yIH14VMYHZApGbobtZFOBt3DQ=;
        b=DqHa2BJYZdlfJaOx31PvrDDiumDJwsJpMF9IyGQcDJ0YdqGHxMGK/+eVzJucY/5b85
         KZO1+GJBJzq/+VAhcoFkDZiFg/E2TDO4NboeuZYngG7XvRKFZgDO58ssmAhjpF5WWgyV
         K7nXLTS+zdHxaixTbmn36/WgRLKfm6EfH/q0JenDu7SjPfwEuWN+LuVFZ5MlUeZ8dTpo
         QKLrGmncVfXrn1YfgZoKRAZ6sRCO1FKitb/ENXFLTQ6+N/75GgWceZ9E/JbnoDGk7eZF
         KpqajKHaxsQmf58Fl6/BBX0US7/Z6I41sA1tSACnIeUFKJTAN/cjJT7kboDTY8HO7YiY
         o/9g==
X-Gm-Message-State: AOAM533ePgLPWHs6lUw/M+sSk348o6NC9jXH5gFRJMP7a8z7h4soz2J4
        vl/n2J/iPlqT7mjQyMAUDAs=
X-Google-Smtp-Source: ABdhPJy7UTcIii6zQf70KY9+aO3t3263ql2SFL6BfQ0tJp48oDoibEsQpDFQjlWBRujBsQoBUv3LYw==
X-Received: by 2002:ac8:7f8b:: with SMTP id z11mr9852530qtj.513.1639532919065;
        Tue, 14 Dec 2021 17:48:39 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y10sm304150qkp.128.2021.12.14.17.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:48:38 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     balbi@kernel.org
Cc:     maze@google.com, deng.changcheng@zte.com.cn, lorenzo@google.com,
        kuba@kernel.org, manish.narani@xilinx.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] usb: gadget: remove duplicate include
Date:   Wed, 15 Dec 2021 01:47:54 +0000
Message-Id: <20211215014754.441065-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

./drivers/usb/gadget/function/u_ether.c: linux/etherdevice.h is included
more than once.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 drivers/usb/gadget/function/u_ether.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index 6f5d45ef2e39..3b674f99320b 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -17,7 +17,6 @@
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
 #include <linux/if_vlan.h>
-#include <linux/etherdevice.h>
 
 #include "u_ether.h"
 
-- 
2.25.1

