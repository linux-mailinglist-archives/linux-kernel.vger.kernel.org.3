Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB7A46CA35
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 02:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243062AbhLHBwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 20:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242904AbhLHBwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 20:52:01 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C26C061746
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 17:48:30 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id k64so1052193pfd.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 17:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aljXQrfp/nk+XodhSs669E3VvH0uoHB2cwz4E+feFs0=;
        b=fiDcvQk0WrAprIYApbU9yo9ksEjH49kQkrHRxO8VYFqjKLsmHFrxp57bYYCtGVdJPu
         wMZRXPE7jLmsMFFQj/CoL5dLu3WQngIU/D/7h0Fm97a56bz5+jGms0xnnTgcKN1y53uJ
         PFk75HQabTZJjEXA8vSNbc3Pmz9cDfuBfaFgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aljXQrfp/nk+XodhSs669E3VvH0uoHB2cwz4E+feFs0=;
        b=Y5dptVxMvON548JOCuyrBD7twBgjWIzuqNFcdU0J/Da0c8NA5e2n7QLjawhXMK76vv
         masm7YDTv+HpdINDqXXO5AC+llLXTvzEPiTpuOpvONmJBucgrcatymoakvWYcP+hltzp
         AzGM5Gh0QFnUf72kgtBM/3x6AplDCBe2AO0EyNdP6V1QC7MpB07Em3H8C83P3QXkVI6S
         usiYJTSbSoKHcxaIU3bwPNmeH9e75IYaAhvRX9gteP7jZbc0E3sZRLlOMgtwqfhC7N/s
         5ZO1dWccr+dJtHPHpnVTo0ZS+LIpFZM3h+mZWf407zP4N+DzD9qjQN+vkskIpXV9tWd/
         TGeg==
X-Gm-Message-State: AOAM531j9NytkJcCqCkJ7wZ4LdWKorAFggr1eQ6p1MCsRo/cNwvbVPtL
        eut63TstuRgspOoyIOUCkboxepsv6dHWag==
X-Google-Smtp-Source: ABdhPJzq8zPem4Gf5ADs/xOZ7wd9Z00KjDeEcd/30o7dSRnnLPv1CAdeUkobknzxFUIM8jqsHdkgyQ==
X-Received: by 2002:a63:187:: with SMTP id 129mr27057651pgb.333.1638928109422;
        Tue, 07 Dec 2021 17:48:29 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:3bcc:3d23:303f:533b])
        by smtp.gmail.com with ESMTPSA id p17sm1080565pfh.86.2021.12.07.17.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 17:48:29 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH] arm64: dts: mt8183: kukui: Add Type C node
Date:   Tue,  7 Dec 2021 17:47:58 -0800
Message-Id: <20211208014800.10058-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node describing the USB Type C connector, in order to utilize the
Chromium OS USB Type-C driver that enumerates Type-C ports and connected
cables/peripherals and makes them visible to userspace.

Cc: Alexandru M Stan <amstan@chromium.org>
Cc: Benson Leung <bleung@chromium.org>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index 94c13c459194..d2796d17b856 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -886,6 +886,20 @@ usbc_extcon: extcon0 {
 		cbas {
 			compatible = "google,cros-cbas";
 		};
+
+		typec {
+			compatible = "google,cros-ec-typec";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			usb_c0: connector@0 {
+				compatible = "usb-c-connector";
+				reg = <0>;
+				power-role = "dual";
+				data-role = "host";
+				try-power-role = "source";
+			};
+		};
 	};
 };
 
-- 
2.34.1.400.ga245620fadb-goog

