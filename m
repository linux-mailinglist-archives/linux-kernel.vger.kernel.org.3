Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7A650AED8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 06:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443886AbiDVESd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 00:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiDVESb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 00:18:31 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFE54EA30;
        Thu, 21 Apr 2022 21:15:39 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id t13so6375788pgn.8;
        Thu, 21 Apr 2022 21:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=5YJXRXKYyui83xwMrCC37m5Rl3T1JJQZ+KXGrBA8Vtc=;
        b=ZlP9pMqZq1Mvui/C0vp/IAbEynvnrfeyx6/seFgc/jk815XaWNqNoReFUWFMfSMFdV
         eQy+7nUvuq/sb96nuT4AKtojdZZylm4281EsVRv5CWH/VUt67kYhSfqKQ0rPPw+YnezU
         LDXLViFOor/8hua9eCH4Xwg9KETh94Fgtn95064hfd4D1zPs/cAw7jqGLKkB4h1t3tS5
         +LJmNAeEqFFbFy2qiY/uoUQSyEaAPFkMEU1CL0z+F0MLLdBoGvWOEyHxPUHT1EM+ImZ7
         8w0BThi4z0seLDa424CyOpKs8cs7oDKSn/Lv5rvUNRgQcn7cufSd527ScsfRkmPkkD13
         deNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5YJXRXKYyui83xwMrCC37m5Rl3T1JJQZ+KXGrBA8Vtc=;
        b=0KFVEF/RNgRXVhnkolxVrp30kb9LcXb/n0bu8b6BV+Kd1umW3oH1h0tUbFj22p94yw
         Z/gjirydJt430I4Pu6MH44uSedp57+cmWHkL3sPPuqWuh0AjHw/M9E/FsfVGoPmoekrT
         Xw5l7658hv0Yq9t5defjikoe9L/rIVOoNxP1AWOmJTG/fwSMcN2bhL/zCvoqpA+MDGvI
         9V+ElzS4V4quOiCBzwLvF6QxhySO+q/Y63nksodvXBhDGfqHhhljnkhIY7IRNT5rGT2M
         IRZOw/Pwrv05boAEBL+h7eX2dFSD3rQac19rQNP9ga2L+Ud7Gr0LGWghHnQ78WTuvaTP
         JA5Q==
X-Gm-Message-State: AOAM533wSWflz6cGwXhhyklDBZSR45xMkj34UPiuIxth/Bj2Tr2puP8/
        V2T7i0e1kg+EVoyj0xKLznjk5/s+TuYHbQ==
X-Google-Smtp-Source: ABdhPJyS3Cg+dEknuTLni4hDLcz+iQOgtwXxn4TsnOQeLPcTd+7RVDLEHGAKyY8L6o2hzsANZGetAw==
X-Received: by 2002:a63:e307:0:b0:39c:ce49:f1ae with SMTP id f7-20020a63e307000000b0039cce49f1aemr2395200pgh.174.1650600938751;
        Thu, 21 Apr 2022 21:15:38 -0700 (PDT)
Received: from Negi ([68.181.16.40])
        by smtp.gmail.com with ESMTPSA id qa16-20020a17090b4fd000b001d25dfb9d39sm4103256pjb.14.2022.04.21.21.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 21:15:38 -0700 (PDT)
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Soumya Negi <soumya.negi97@gmail.com>, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: thermal: Include ReST markup standard definition file
Date:   Thu, 21 Apr 2022 21:14:27 -0700
Message-Id: <20220422041427.32585-1-soumya.negi97@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the documentation compile error given below:

ERROR: Undefined substitution referenced: "copy".

Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
---
 Documentation/driver-api/thermal/intel_dptf.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/driver-api/thermal/intel_dptf.rst b/Documentation/driver-api/thermal/intel_dptf.rst
index 96668dca753a..e3c41d96d63a 100644
--- a/Documentation/driver-api/thermal/intel_dptf.rst
+++ b/Documentation/driver-api/thermal/intel_dptf.rst
@@ -1,4 +1,5 @@
 .. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
 
 ===============================================================
 Intel(R) Dynamic Platform and Thermal Framework Sysfs Interface
-- 
2.17.1

