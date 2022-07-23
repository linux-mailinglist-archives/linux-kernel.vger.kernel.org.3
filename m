Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7590A57EC7B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 09:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236482AbiGWHmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 03:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiGWHmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 03:42:06 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7836F491ED;
        Sat, 23 Jul 2022 00:42:04 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id r9-20020a1c4409000000b003a34ac64bdfso442186wma.1;
        Sat, 23 Jul 2022 00:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YwmE8iWxtiJIxHdfEka47hXmPR+fBzQvfjsFdeTq40k=;
        b=dIJNifz9/KyE/gCfpdTeA0jWzmSCHwKo5Fgd6aqTzeWnYxm8KSX8JaXU9ccjTtq9Yc
         KsDkE5kACZz0wcGBKWpXx+QaU7mX7mxkAL2hi2JqYtbcQJ5YoLYnM3fJybwAgMjjgGbq
         h04iPNGQvhvvxq+cvpWCaHTZp5iTQP21wGaLsPL2GQ1k9S2DDWYJon/fevd8ZRo8nGp6
         V9I03uWDF4X3FGyVvTw37leIhDeeAh26jTZgf8wfKgcLOSuF5wQBrF0Ro0a29nnym8Qq
         OqKbkJG+eV52bG/MI8krNz+5GJOC3bYqRmMHlOAjeBhf2TUOaa2wuc4Lf2uAbvoDLMQQ
         zrIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YwmE8iWxtiJIxHdfEka47hXmPR+fBzQvfjsFdeTq40k=;
        b=epL8FPaR+Gv/wmfE9+p6x4hvOPKOs17Iy8vr6UKa2PyX2cGU6w10qrvKHcGoLLoPpN
         kViGrcAKGPiVwIxhfuBW4d74ta6bMJMzLwyJD9LFL2k6wUwrmbQ179KCu40AN6og8rFY
         JmOzcOfYyDFxSFlJq39/h+AzKT9OGOHrWowF0XaBfBA0d4M6018ZwEz/fZ8drJHCsjh2
         HaFDwu3pHOVr1PNduShb6XCuJ3yuxmaKR2AUx3Tg1Ezj6Qm2hKd29QN65CDMoSeH0bKs
         CRPjgGBkzjDWswwXL3OQKWG3wQlDoquYSFq/IYnRpz/vnWBvTTJjPwd/OcupOmieWBnv
         q2YA==
X-Gm-Message-State: AJIora/6csqMDPEYhwcid8Bpa2qxBaBBwpaSVOdbvdxuJxLZFnE9suHj
        ChZaO3Gucuy1tAk0fRTuaLGPBVsG0QkyyA==
X-Google-Smtp-Source: AGRyM1tOGdhlSenDO0GdElEkAg8sTjaOGRyHGp/hjm0kiK9Iz8vT2m6yZxFjl0XF/oBxPW7pxT88MA==
X-Received: by 2002:a05:600c:224c:b0:3a3:17b7:a229 with SMTP id a12-20020a05600c224c00b003a317b7a229mr15098728wmm.1.1658562122620;
        Sat, 23 Jul 2022 00:42:02 -0700 (PDT)
Received: from localhost.localdomain (62-44-238.netrun.cytanet.com.cy. [62.228.44.238])
        by smtp.gmail.com with ESMTPSA id n6-20020adfe346000000b0021d7ad6b9fdsm6322786wrj.57.2022.07.23.00.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 00:42:02 -0700 (PDT)
From:   Maxim Devaev <mdevaev@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     linux-next@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, mdevaev@gmail.com,
        gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        sfr@canb.auug.org.au
Subject: [PATCH v2] docs: fixed table margin in configfs-usb-gadget-mass-storage
Date:   Sat, 23 Jul 2022 10:40:54 +0300
Message-Id: <20220723074054.54995-1-mdevaev@gmail.com>
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

Fixes: 421c8d9a20da ("usb: gadget: f_mass_storage: forced_eject attribute")
Signed-off-by: Maxim Devaev <mdevaev@gmail.com>
---
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

