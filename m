Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C784E48DF76
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 22:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235004AbiAMVS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 16:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiAMVSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 16:18:25 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4043C061574;
        Thu, 13 Jan 2022 13:18:24 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id w188so9551536oiw.13;
        Thu, 13 Jan 2022 13:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3U7xOer6sVly35j98UB0sJ9y2HM48yZDB/QDh60PHbU=;
        b=JH3d15RUin0nTH8Ayj5BEWgODrPOPrwVEkCsrskOBAC/QKzwqaQuFcT1pW58RiAnb4
         YJ6Ppu9RVisSHpFYPHyJePiRczvMd2SxJJy0z2Shaa40tbb+VVzu0HuK6C8cZ6tnKJdb
         xpF/OrgLjm1kIS5FItD8q/x++1jaJTFzqUn36znrghK3hIDGc/6HPlThESC4pUs9Bq21
         PbDaFbUTmQ0HurqF4vwNltxzOBpJjdApT7vX1IT4s3naZ0DvV9Jw410H5swUQO+WCxRs
         1uutuhK9pwVmlQRN7vkG2URo5gMHWYuTvdDbLer7ScWwxo3R9vnZXRTQfMq9DWPKy7Z1
         GVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3U7xOer6sVly35j98UB0sJ9y2HM48yZDB/QDh60PHbU=;
        b=Qnh0CpoCcD1SOso3gMqVG/r3nHmteGRJAm6uSea1hBl0UabFJhfk/uosX/gjJA17i6
         e/AE0n1NjieNSGja18/1saFs25eHmQDkKgrUWnXbZBRZHxKntOmy99oFthlzThjCz+kY
         bwZNtWvKZczVodzQIGte5eyEZoMDqnQxWIL4Nds2aFeidYwaLwWhbwAf0YOEGGcNH9mq
         Z6Zn+e0h6iqSWafxAvttuCJHEY8+tCLzAtjUoRaBwA6vw3asPyfxhwEPaZlo/XQiBMsR
         gvW+jzyWB7KVpUFfhmCnDW4RMvuiJTxXqGGKyZj691f7CO4Vlff6L5t/iNcuRhFB+uvN
         RkOA==
X-Gm-Message-State: AOAM530IDMu5Zx4alItXWBAPdhh4Ks11Wn1ZlT5gyddPYFG6TJudewwP
        vYM/WoKwXPv7oHFBOyW3b5M=
X-Google-Smtp-Source: ABdhPJzXE/1It7WKP+/LtUmegsDmnTpvyMx15/3Iav2IhHGUrEnkgWndiF4moTtfVpUJnGCy8umDlQ==
X-Received: by 2002:a05:6808:190f:: with SMTP id bf15mr4742157oib.23.1642108704077;
        Thu, 13 Jan 2022 13:18:24 -0800 (PST)
Received: from Andrews-MBP-2.attlocal.com ([2600:1700:19e0:3310:f8ba:b1e:54e1:cdfc])
        by smtp.gmail.com with ESMTPSA id z188sm932015ooa.8.2022.01.13.13.18.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jan 2022 13:18:23 -0800 (PST)
From:   Andrew Geissler <geissonator@gmail.com>
X-Google-Original-From: Andrew Geissler <geissonator@yahoo.com>
To:     joel@jms.id.au, andrew@aj.id.au, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Andrew Geissler <geissonator@yahoo.com>,
        linux-gpio@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH 1/2] ARM: dts: aspeed: rainier: add reset-cause-pinhole
Date:   Thu, 13 Jan 2022 15:17:34 -0600
Message-Id: <20220113211735.37861-1-geissonator@yahoo.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This GPIO is used on the rainier system to indicate the BMC was reset
due to a physical pinhole reset.

See the following doc for more information:
https://github.com/openbmc/docs/blob/master/designs/device-tree-gpio-naming.md

Signed-off-by: Andrew Geissler <geissonator@yahoo.com>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
index cfaa606666e2..7ea70c7d698f 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
@@ -247,7 +247,8 @@ &gpio0 {
 	/*C0-C7*/	"","","","","","","","",
 	/*D0-D7*/	"","","","","","","","",
 	/*E0-E7*/	"","","","","","","","",
-	/*F0-F7*/	"","","battery-voltage-read-enable","","","","factory-reset-toggle","",
+	/*F0-F7*/	"","","battery-voltage-read-enable","reset-cause-pinhole","","",
+				"factory-reset-toggle","",
 	/*G0-G7*/	"","","","","","","","",
 	/*H0-H7*/	"","bmc-ingraham0","rear-enc-id0","rear-enc-fault0","","","","",
 	/*I0-I7*/	"","","","","","","bmc-secure-boot","",
-- 
2.25.1

