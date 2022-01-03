Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EADBC483465
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 16:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbiACPq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 10:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbiACPq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 10:46:58 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A5CC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 07:46:57 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id w7so24588781plp.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 07:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=boundarydevices.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DuinLQ82u9Ll4xBW8hohWni8CpDThAMqaisLf3sqjiw=;
        b=Kkolr/5fSCKwJ4AF6i6ciBiCFTzyg3CmMMSYRrUfD0D0Ih8pTE0FRQaVS8k6LwaWLS
         ePUreY/P0N4LNOx12Kzs9xYlg9X/jEHJYXEjqUC9Jj/dSznmL12TB3wNK3VF85Wn7nId
         OwXbl3OZsd2qiM0LzCd8CKaxFADRZ2ifCQqTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DuinLQ82u9Ll4xBW8hohWni8CpDThAMqaisLf3sqjiw=;
        b=j8P93LlgnXoD+RRZQ654xPnClNJnyuGTnyDBzhfEck2pZQUYLqWZ0hKXo5bKr5iMvF
         tVVhkb+k87IvpqG7P94gnLBL0d4OaTNiUsLs10vi9nhDNNNCETjTe8fRIZRFIDrTsHB6
         WSFhHFrbEye0BqYu11V8pVj22mudpKWwkl0Ha9VEuTx17cugE06IZmLg8KtVXpfLoksy
         7ylAeUKM5eZBuVTMeycjwoJr8p2w93V8d9nwU2T8gRWyJFI52zxQHq3RXfhOdIeUYxmz
         qHx9n9tr6TyEiUyJuKuWiMVrPS1v9noPvDCcSSOj6kyIQcR5Tg/+xhQmBGDdtZN/jfnZ
         22jg==
X-Gm-Message-State: AOAM530ZaYVCePDROnkM2SnegMwEMhyLEAVie4wpfrhCES9beiNhPq7U
        JHIxUipLRlddDwx8Z0sok2vkRQ==
X-Google-Smtp-Source: ABdhPJz2tbfvAdwQ5b5as5ZgbBIZRiJhaS6MhPLzuzfwJHOg6gxQ/AN0OK7D3ctvxBQi1c8X8Fbyug==
X-Received: by 2002:a17:90b:210:: with SMTP id fy16mr37090944pjb.202.1641224817454;
        Mon, 03 Jan 2022 07:46:57 -0800 (PST)
Received: from localhost.localdomain (lfbn-idf1-1-1088-186.w82-125.abo.wanadoo.fr. [82.125.191.186])
        by smtp.gmail.com with ESMTPSA id l2sm41080153pfc.42.2022.01.03.07.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 07:46:57 -0800 (PST)
From:   Gary Bisson <gary.bisson@boundarydevices.com>
To:     linux-amlogic@lists.infradead.org
Cc:     Gary Bisson <gary.bisson@boundarydevices.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: meson-g12-common: add more pwm_f options
Date:   Mon,  3 Jan 2022 16:46:15 +0100
Message-Id: <20220103154616.308376-3-gary.bisson@boundarydevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220103154616.308376-1-gary.bisson@boundarydevices.com>
References: <20220103154616.308376-1-gary.bisson@boundarydevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing PWM_F pin muxing for GPIOA_11 and GPIOZ_12.

Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
---
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 .../arm64/boot/dts/amlogic/meson-g12-common.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 00c6f53290d4..af1357c48bee 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -894,6 +894,22 @@ mux {
 						};
 					};
 
+					pwm_f_z_pins: pwm-f-z {
+						mux {
+							groups = "pwm_f_z";
+							function = "pwm_f";
+							bias-disable;
+						};
+					};
+
+					pwm_f_a_pins: pwm-f-a {
+						mux {
+							groups = "pwm_f_a";
+							function = "pwm_f";
+							bias-disable;
+						};
+					};
+
 					pwm_f_x_pins: pwm-f-x {
 						mux {
 							groups = "pwm_f_x";
-- 
2.34.1

