Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D4E487940
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 15:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347865AbiAGOwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 09:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239306AbiAGOv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 09:51:56 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01860C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 06:51:56 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id f17so3222186qtf.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 06:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8nl5vAeNGSOns35uL+fkC4uu+J6bk11HauJCQV7waYU=;
        b=C/yvRfk+luoRHRR7kHkAThuRQYp4xm78a5kqIhQ8UpMeNBe0eGmcD1kQ7myXnJWzXD
         Oc42tbOu6W//pMLS0RGc4l/yNqSmsIdk8WcpzutVWaYfhLGVSG/l5x5zu/t+SunX4i0r
         ufP5oiYWU+ohl1aNtMR43P6ArASJUA+rBwf9NRMzzb8w/5h5qDGWEBke1mIjFSBViS9g
         grsrZhMmuMCpotC6ymi092bmB9rl5cpdcymiOxkZyNmY0pPAnVp1GlYke9XK+NXR9xsW
         AQBIkMDX+K5MhSQwkSS5u2nHOIXO6OAmqTKeS+wBLdUN5iEHzL1etCH04z38tIMIEaA2
         xw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8nl5vAeNGSOns35uL+fkC4uu+J6bk11HauJCQV7waYU=;
        b=jFfi0JELUw7nSeIffFBxNnNLjrL6OLwhV4srunKbO3xjAf4mEiCxavoe37vab27jpE
         7qMVV8nfwMrWcUmjhfRjkSbVvDvAm1u7kTLmJ7Pq+mUCyBUnwoUL8yZ1V5CipVUpCS0n
         S/otf1jJJY9GiwfbnogOOWUqyVle/Tr27pv7Pzn+yNiUR011vS7tlYgOZyNtxI5ZXkYs
         nVTQzETNQYYHNEKYdBUdIVXreQ9dwjxGEx1zabYP/KuIyZxMcLtMjs42Xza7Sjz5Arrg
         SfAD3Fr3myUofLRbgBUwz/W6CXfbPdzXwCoXBIDGWuOboBhR8MQM/HzYYvcMGH/QSALf
         lxVA==
X-Gm-Message-State: AOAM531013+Bf+BC800MxPPpHLUYLd9P/pKhTb7/OBm9n9X4cgpDNhai
        e9HoNIWnrLQMpwdvifVkaXCITw==
X-Google-Smtp-Source: ABdhPJw+X70xUw0SSMUFrYRmkB6I8xJ9Ys/8V5scbKprm7qM3U7XyJoaBel6NBHVbSQjcZTvZULcnA==
X-Received: by 2002:a05:622a:1010:: with SMTP id d16mr8179622qte.81.1641567115127;
        Fri, 07 Jan 2022 06:51:55 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id az16sm3776899qkb.124.2022.01.07.06.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 06:51:54 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     bjorn.andersson@linaro.org, daniel.lezcano@linaro.org,
        rafael@kernel.org, herbert@gondor.apana.org.au
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Update email address
Date:   Fri,  7 Jan 2022 09:51:54 -0500
Message-Id: <20220107145154.458779-1-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update my email address in the MAINTAINERS file as  the current
one will stop functioning in a while.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fb18ce7168aa..afcdd7588822 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15751,7 +15751,7 @@ F:	Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
 F:	drivers/cpufreq/qcom-cpufreq-nvmem.c
 
 QUALCOMM CRYPTO DRIVERS
-M:	Thara Gopinath <thara.gopinath@linaro.org>
+M:	Thara Gopinath <thara.gopinath@gmail.com>
 L:	linux-crypto@vger.kernel.org
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
@@ -15868,7 +15868,7 @@ F:	include/linux/if_rmnet.h
 
 QUALCOMM TSENS THERMAL DRIVER
 M:	Amit Kucheria <amitk@kernel.org>
-M:	Thara Gopinath <thara.gopinath@linaro.org>
+M:	Thara Gopinath <thara.gopinath@gmail.com>
 L:	linux-pm@vger.kernel.org
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
-- 
2.25.1

