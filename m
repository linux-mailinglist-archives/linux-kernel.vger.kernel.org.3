Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBBB57B6D0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 14:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241079AbiGTMup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 08:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240972AbiGTMud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:50:33 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D120B1CFF6;
        Wed, 20 Jul 2022 05:50:30 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id t3so23665937edd.0;
        Wed, 20 Jul 2022 05:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qRl4q9lhPIc+egRL8GF1tytRpCK/RtxDVBSeVzDUofc=;
        b=TzmqSiOWexUMUGe7zHn8xjdzAEOoDhXbWwr8qJImv7tghUupljCPgQbZfV/4+Womlz
         RaowNhOxXjKYHi/OScJw4KLoEb2AmXPITajTOSM5ryhZnheTktwIPX79O5AnuFSwK48Q
         +hmVVmhSUxTzqARRaj4AlN9ro81OBhWlxtW2MjFc4q5to6Ip8h/XosRKCOQz1Odx23/p
         VH7xJCk4O8EY419N9pzMnlxCwb4A4VCsjZ1tIOItVIHvxaPqHZfxywTg76RgFrRwLh6K
         XIp0nzTxCBxfKBZcH2fFc1c+wbPQXW/PwkiPyusJSFeoAXPk+p6zl2dpnYDl/TZQp3jE
         lcig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qRl4q9lhPIc+egRL8GF1tytRpCK/RtxDVBSeVzDUofc=;
        b=BC1cqtkuzGGViPpvZy/X1cWKckDsDm2YTfopy/1I177N5H+ffVwiCQT7emIjKyTJkW
         48XCs+aPYH8TJHwIW0hfkFjpB1jCZhsZ0Afrr5Ine17t/UW/ZsTvCCCqF/E6MchzgOUU
         V4rCJ77I1jtv3rFCeMe4xBtam4PydcTu4vUB9XPwRv49xMAHV9HXa4a3+M/vch2mWkri
         jp2XoTbrP2RADow5E879qC7u7JJRmBiPPz2wzYXDIx22PrqHoipHnea5+CiloJzl14eu
         ydBgPF/ikzB37KP+lP8SEJpi1kTn97c9Ptp8mJ6hGE5dqBVP5/f/cUeSIoNEVm6ZJLXG
         vqvQ==
X-Gm-Message-State: AJIora+X4oCzwQFqIQrKmTaTF5Ogj4lvQMuer4YSlmBk7WCUtCgdBaBe
        pltyhRVJj3K/5oHJ3eNFIyPAtzDAIbiSfQ==
X-Google-Smtp-Source: AGRyM1t5UKIbibQ/Ef58nHHk3Pqc21B3D12JkDi4/a+yHiY4pDALEeELqL2dXv7X65oNsZyjeYXHGA==
X-Received: by 2002:a05:6402:847:b0:437:62bd:bbc0 with SMTP id b7-20020a056402084700b0043762bdbbc0mr50157087edz.285.1658321429128;
        Wed, 20 Jul 2022 05:50:29 -0700 (PDT)
Received: from localhost.localdomain (62-44-238.netrun.cytanet.com.cy. [62.228.44.238])
        by smtp.gmail.com with ESMTPSA id rk13-20020a170907214d00b006ff0b457cdasm7836754ejb.53.2022.07.20.05.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 05:50:28 -0700 (PDT)
From:   Maxim Devaev <mdevaev@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdevaev@gmail.com, stern@rowland.harvard.edu, sfr@canb.auug.org.au
Subject: [PATCH] docs: fixed table margin in configfs-usb-gadget-mass-storage
Date:   Wed, 20 Jul 2022 15:50:22 +0300
Message-Id: <20220720125022.91561-1-mdevaev@gmail.com>
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
2.37.0

