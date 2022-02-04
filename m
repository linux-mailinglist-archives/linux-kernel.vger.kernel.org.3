Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08144A91B5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 01:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356279AbiBDAlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 19:41:31 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:40458 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbiBDAla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 19:41:30 -0500
Received: by mail-oi1-f172.google.com with SMTP id q8so6703949oiw.7;
        Thu, 03 Feb 2022 16:41:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wnlQbhSLT+4EwhstgLphHjdPL3CXj12i6ppAfBqkb00=;
        b=TuxA7DrMyYGY5HiVeQCdrRs3UagM/4/Ac4j5tOiJZEHLmnQLGImNudTnRbK1u/dsb2
         vKZY6IqgMIky8YSzay8uOHKTgUH+IlgeiDEKrfci2SxTcSApE8o0Z4fuLE6X+ueIXZql
         yUEiHlI5RhcUoG28EilY8oiZW+UJClgYAMngZTyQ7htWQwGJ1O8bApv5mUaF33/TSZ5+
         ukA/2geVu4uJZDIZsskqcYENsQ6rQsOcjqcs4Ttxu3+tVvXyt4vM34eMDJGnd64JFnFd
         iKAaTVtmf1YG/GUHkjMkovl5uXOnzalz9wTcwh05vk4TZFCIL2p5E0mqIu50bSfFmi0m
         Xegw==
X-Gm-Message-State: AOAM530MFz9j8Jemf+nmRmOJ1o2GpLdrEr/HlzcVg/UHwpiZb8EQxAex
        EhDN7DY+IRs5IhEi8eOtdA==
X-Google-Smtp-Source: ABdhPJwUZXdId4Wd3puhdPQHF0a2f6V7XUsKQO2PdEFSWC2bV1KWhm0eTLF7chOjaa6sHpywhu+slg==
X-Received: by 2002:a05:6808:2228:: with SMTP id bd40mr133025oib.335.1643935289747;
        Thu, 03 Feb 2022 16:41:29 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id g34sm153071ooi.48.2022.02.03.16.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 16:41:28 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: spear320: Drop unused and undocumented 'irq-over-gpio' property
Date:   Thu,  3 Feb 2022 18:41:17 -0600
Message-Id: <20220204004117.1232902-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The property 'irq-over-gpio' is both unused and undocumented. It also
happens to collide with standard *-gpio properties. As it is not needed,
drop it.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/boot/dts/spear320-hmi.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/spear320-hmi.dts b/arch/arm/boot/dts/spear320-hmi.dts
index 367ba48aac3e..b587e4ec11e5 100644
--- a/arch/arm/boot/dts/spear320-hmi.dts
+++ b/arch/arm/boot/dts/spear320-hmi.dts
@@ -235,7 +235,6 @@ stmpe811@41 {
 					#address-cells = <1>;
 					#size-cells = <0>;
 					reg = <0x41>;
-					irq-over-gpio;
 					irq-gpios = <&gpiopinctrl 29 0x4>;
 					id = <0>;
 					blocks = <0x5>;
-- 
2.32.0

