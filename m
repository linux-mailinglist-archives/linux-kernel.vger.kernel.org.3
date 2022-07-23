Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B20F57EEB1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 12:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239638AbiGWK0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 06:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239599AbiGWKZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 06:25:49 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305442A1;
        Sat, 23 Jul 2022 03:15:21 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id i205-20020a1c3bd6000000b003a2fa488efdso743982wma.4;
        Sat, 23 Jul 2022 03:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yWKfk3fyZFUhwYXIKiDlJRJt8cdrzV7TjZ764g5ZLus=;
        b=i6GCekbw2j022RmloO5kDxwzmjpVn6Wc6DWAesFlU67xjyXB3ah5t7OKYfq52FwFty
         yhVkvdV3FDza0dbXzkr1tpyLNDkndQ48FkMR7LQeH6X0IRkCunS6viSJEFNPRdCZJAXg
         XntlIVm4DMhE6//CMMVmYYJSEIFFdJeHxjhtDJzQrO1wQkDfHgWdCBUlO8yq9I9ddUkA
         /Ktcv7rbDzu/a2Mvgb+AerLZjiEilniJnZ53SA/OwHUw0O4XwkTspVgB/Py9rRGr02Hh
         4pj21DKc15LKjxM/dEGZmmyVddY5xz0qLsPTEgy8lRc5H4XHqjc1AWpWV74vydWoZpuQ
         3zMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yWKfk3fyZFUhwYXIKiDlJRJt8cdrzV7TjZ764g5ZLus=;
        b=MTpgJygsJ0kjFrbSZtrVeQYIGB2+obZtZ8X6/5/R2MsfI3y/pKLt7BjzLGat1N4NHR
         JJuzYPUGDIxDveOlkRN6DM9PQwp9YMA4pZmVdKywvFrmahPrRoxmDodULo18kCd/F4p9
         TIskUKrId0S3JZxePHl7f2tA0+NRVsNeMnHAlr2/32Ou1hpzA3p93fVMNuxxDOoAfUsS
         wMskksoznrbeKxOBmnjpfOwJaURqLrOF+xGd9b5qyzTDggBPYOAjcVrPSSdOaQwQcyeM
         lWEdIGnjY5eWmHSg/2JaXpxsa3zc/X+esOQTTe6Hcx35wERJvg7F7ra2aGyqdv8i74wE
         7wkA==
X-Gm-Message-State: AJIora+sq4KKYepG2lPViiRvuVFNNJOSI6dNJzOstSQF1t70mWJZLDzc
        KP9NwTzegokqRMi6WOi8mexWEtK9yrFfmw==
X-Google-Smtp-Source: AGRyM1vtKhZFr+pMihYZSzTnRXziui9Lx5TdmZLzgHFu3W8Byvo8WbKRFGgw+381ZjQr9OQpOUBWcQ==
X-Received: by 2002:a1c:e902:0:b0:3a0:2d95:49d4 with SMTP id q2-20020a1ce902000000b003a02d9549d4mr2564994wmc.189.1658571319156;
        Sat, 23 Jul 2022 03:15:19 -0700 (PDT)
Received: from localhost.localdomain (62-44-238.netrun.cytanet.com.cy. [62.228.44.238])
        by smtp.gmail.com with ESMTPSA id ay36-20020a05600c1e2400b003a2d6c623f3sm11661496wmb.19.2022.07.23.03.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 03:15:18 -0700 (PDT)
From:   Maxim Devaev <mdevaev@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     linux-next@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, mdevaev@gmail.com,
        gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        sfr@canb.auug.org.au
Subject: [PATCH v3] docs: fixed table margin in configfs-usb-gadget-mass-storage
Date:   Sat, 23 Jul 2022 13:14:32 +0300
Message-Id: <20220723101432.72178-1-mdevaev@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After merging forced_eject patch, there was a broken margin
in the configfs parameters table in the ABI documentation.
This patch fixes it.

Fixes: 421c8d9a20da ("usb: gadget: f_mass_storage: forced_eject attribute")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Maxim Devaev <mdevaev@gmail.com>
---

 v2 -> v3: Added commit description and Reported-by
 v1 -> v2: Added Greg KH to CC so that he can accept this into his branch
 Documentation/ABI/testing/configfs-usb-gadget-mass-storage | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/configfs-usb-gadget-mass-storage b/Documentation/ABI/testing/configfs-usb-gadget-mass-storage
index d899adb57e81..fc0328069267 100644
--- a/Documentation/ABI/testing/configfs-usb-gadget-mass-storage
+++ b/Documentation/ABI/testing/configfs-usb-gadget-mass-storage
@@ -19,7 +19,7 @@ KernelVersion:	3.13
 Description:
 		The attributes:
 
-		===========	==============================================
+		============	==============================================
 		file		The path to the backing file for the LUN.
 				Required if LUN is not marked as removable.
 		ro		Flag specifying access to the LUN shall be
@@ -38,4 +38,4 @@ Description:
 				regardless of whether the host has allowed it.
 				Any non-zero number of bytes written will
 				result in ejection.
-		===========	==============================================
+		============	==============================================
-- 
2.37.1

