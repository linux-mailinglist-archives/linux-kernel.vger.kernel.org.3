Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED3A9481B76
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 11:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238645AbhL3Kns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 05:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbhL3Knr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 05:43:47 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56971C061574;
        Thu, 30 Dec 2021 02:43:47 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id h7so9044502lfu.4;
        Thu, 30 Dec 2021 02:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yg7RYwQR6VzpeYXfKgQCnzyp5pnZmL7af7luHvu61fc=;
        b=lNa/u+Ek5xQPIlUHU834NDKAfYUkbUPHHZifKo+AfSMUOXXltiU2wSjnbSmqGwNQzi
         lbmeQBwPjmgxwQmDg8ofdBazoDgb07z/cVG9Il9VLi6m4mAPzFI/boNNeL+UO52wqfsY
         agEdMEsefBBMh+SaMKdedflZJ9tNbU8FmxmOrqNQ8wcsYrA2EYc7cNHGscR3+G8WGGfT
         U/rM/japyp5ETxUeOMArNklQEagt+U3p2cjejB/bg6Ap+NNQQkcvdKUJK0Mk7bis3zwx
         023QBY7ZTVYp9noFR4IKlZAvP2rwvXHXTTUL7MQEQ5G+4e4LHWn4IGw2aIAEtNLlkuOF
         ScKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yg7RYwQR6VzpeYXfKgQCnzyp5pnZmL7af7luHvu61fc=;
        b=twX0aJjnB4oa/bbFJnciqF1DodTCXAdepPrGpGKwGyulYLHquMPqQF6A5ZeBgmONew
         elw2qd5zgiwmE6IpvJUF7mYLV4aqskw/DMtyJMG/eDEOSpzCe/bTqA3OA0JgkManQUdH
         cuNim4VEMaViijrMZ55P9rdDYzkFoRi6El+kmKHmh0htjSQ+z8U8nBFEaGYX5JWKPzJ9
         a/XxTJejkjNbU37AVp8paSlLZ0j4pN3dyxld2hYUlaM3z2ZXtNmr0DJPkDh5pU2JaSlg
         7uG0AYySbA04aRXjxFUxJ4CQ38JIxqMCAkTRpWYonE6XRQEhDfx5mFAiaB2TLjvAsWqi
         HLjA==
X-Gm-Message-State: AOAM53132Ekq9t01ZZbx/fu80XlPIPC8SRBrLNxZMd6cAlfzf/W/QYMN
        rmvTF1Frc4H88/9ODR9BGEo=
X-Google-Smtp-Source: ABdhPJzf2njYku29J1mLh79MjFff32ygDd5sAK2tIEx+v+Us0NJh3+fxkWemvyzuBDMPfMQpUSPprw==
X-Received: by 2002:a05:6512:1504:: with SMTP id bq4mr27433290lfb.27.1640861025294;
        Thu, 30 Dec 2021 02:43:45 -0800 (PST)
Received: from localhost.localdomain ([185.6.236.169])
        by smtp.googlemail.com with ESMTPSA id u19sm1522644lje.56.2021.12.30.02.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 02:43:44 -0800 (PST)
From:   Maxim Kiselev <bigunclemax@gmail.com>
Cc:     fido_max@inbox.ru, Maxim Kiselev <bigunclemax@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: dts: t1040rdb: fix ports names for Seville Ethernet switch
Date:   Thu, 30 Dec 2021 13:43:28 +0300
Message-Id: <20211230104329.677138-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix network interface names for the switch ports according to labels
that are written on the front panel of the board. They start from ETH3
and end at ETH10.

Fixes: e69eb0824d8c ("powerpc: dts: t1040rdb: add ports for Seville
Ethernet switch")
Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>
Reviewed-by: Maxim Kochetkov <fido_max@inbox.ru>
---
 arch/powerpc/boot/dts/fsl/t1040rdb.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/t1040rdb.dts b/arch/powerpc/boot/dts/fsl/t1040rdb.dts
index af0c8a6f56138..b6733e7e65805 100644
--- a/arch/powerpc/boot/dts/fsl/t1040rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t1040rdb.dts
@@ -119,7 +119,7 @@ &seville_port0 {
 	managed = "in-band-status";
 	phy-handle = <&phy_qsgmii_0>;
 	phy-mode = "qsgmii";
-	label = "ETH5";
+	label = "ETH3";
 	status = "okay";
 };
 
@@ -135,7 +135,7 @@ &seville_port2 {
 	managed = "in-band-status";
 	phy-handle = <&phy_qsgmii_2>;
 	phy-mode = "qsgmii";
-	label = "ETH7";
+	label = "ETH5";
 	status = "okay";
 };
 
@@ -151,7 +151,7 @@ &seville_port4 {
 	managed = "in-band-status";
 	phy-handle = <&phy_qsgmii_4>;
 	phy-mode = "qsgmii";
-	label = "ETH9";
+	label = "ETH7";
 	status = "okay";
 };
 
@@ -167,7 +167,7 @@ &seville_port6 {
 	managed = "in-band-status";
 	phy-handle = <&phy_qsgmii_6>;
 	phy-mode = "qsgmii";
-	label = "ETH11";
+	label = "ETH9";
 	status = "okay";
 };
 
-- 
2.32.0

