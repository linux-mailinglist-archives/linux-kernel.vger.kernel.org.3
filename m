Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B13E516959
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 04:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356884AbiEBCSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 22:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352311AbiEBCSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 22:18:08 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CB7393E2
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 19:14:41 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id q76so7655735pgq.10
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 19:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KzC9TjieGOEIqDHJrtejEtLvoFu7JbFpTAUv4Smt2oo=;
        b=KCKaF2Jqt76VNtZ6YuSGQJkKTajhT2ZpXjx1gfmZpx4paSAKTwBdGi36WV4MuGHS91
         puzZIUmQfJUzY0GQ2X0buvL/t506zEQatD9lZ0bK2AbZfFv8dvKfgUkH65vTtLWXx0bs
         1ct+Vi6bdNdXw7fpoKcbs0mMp5WiKf7YlQM2lpRH9jXdgTqcfzNVjQ2c5TldSrnbmjV/
         F13gxfk2kFfAeri+s9SMmkPD9hEY7K8Pi/3t/uRHzExK4N4ODXCfCpLhC2u17GQtRp75
         TIaFAg8vzTZnP3zN8sTASIzq2uCSCa15PZOEN2C+aEsnApkvonYKdz0omXpSByCzTOh5
         /edw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KzC9TjieGOEIqDHJrtejEtLvoFu7JbFpTAUv4Smt2oo=;
        b=gALY3K2/yPbvxhi4egNveJOdOXnrL4kR8veixt6Vj6PDnmVOAG5CIdPBwntlN8M9EM
         r0pRbab+rThQsMyFSjuo/aCLRVErQC/ftKsc2rjY6C/o56cNvLaMW3jYaakubA4L9oRj
         AG4TADv6AVrqyI8xtKJYZ1pAs4gEn7r3l5YrbmdFwZbRwSrcbi4yxb0QPr1EmJEYWcxL
         M1OOYCZM5M9K/Mgt2cb6oGhB/bt4Uy+mQEyxIMnNVni9kkfnWbEhH5qQjqKRnPFPh8yY
         cKhYzxEEMpJcX2LJYHnqr188dEUw1yYgW3AceXhU6kCSlEvKxQUVna44E/RyEyQBTr/l
         Xtyw==
X-Gm-Message-State: AOAM531+NH2fu0Wy6biggv63aj43oxethKNRUL3J5V6zmlq0cZTIuIcp
        1TzLcuPO6v0MJN2isTLI0tdINK3I6O4elQ==
X-Google-Smtp-Source: ABdhPJzgJ0DIV+/dbPMZEAP0luq9hvSS2HN5vkF8U7JE8jpwWI66SnhlsPvBDm6zt7DTjxrOAf0nVg==
X-Received: by 2002:aa7:8757:0:b0:50d:48a9:f021 with SMTP id g23-20020aa78757000000b0050d48a9f021mr9109270pfo.24.1651457680572;
        Sun, 01 May 2022 19:14:40 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1001:7090:c18e:6070:88f2:a04d])
        by smtp.gmail.com with ESMTPSA id j2-20020a17090a734200b001cd4989febcsm18714475pjs.8.2022.05.01.19.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 19:14:40 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>,
        Tony Lindgren <tony@atomide.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Drew Fustini <dfustini@baylibre.com>
Subject: [PATCH 2/3] ARM: dts: am33xx: Add i2c voltage scaling firmware to wkup_m3_ipc
Date:   Sun,  1 May 2022 19:15:08 -0700
Message-Id: <20220502021508.1342869-3-dfustini@baylibre.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220502021508.1342869-1-dfustini@baylibre.com>
References: <20220502021508.1342869-1-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Gerlach <d-gerlach@ti.com>

Add appropriate firmware-name property for all am33xx platforms.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
[dfustini: change property from 'ti,scale-data-fw' to 'firmware-name']
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi | 4 ++++
 arch/arm/boot/dts/am335x-evm.dts          | 4 ++++
 arch/arm/boot/dts/am335x-evmsk.dts        | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index 56ae5095a5b8..02e04a12a270 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -405,3 +405,7 @@ &rtc {
 &pruss_tm {
 	status = "okay";
 };
+
+&wkup_m3_ipc {
+	firmware-name = "am335x-bone-scale-data.bin";
+};
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 659e99eabe66..b9745a2f0e4d 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -782,3 +782,7 @@ &rtc {
 &pruss_tm {
 	status = "okay";
 };
+
+&wkup_m3_ipc {
+	firmware-name = "am335x-evm-scale-data.bin";
+};
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index a2db65538e51..9c458e5a95b7 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -719,3 +719,7 @@ &rtc {
 &pruss_tm {
 	status = "okay";
 };
+
+&wkup_m3_ipc {
+	firmware-name = "am335x-evm-scale-data.bin";
+};
-- 
2.32.0

