Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D526746F445
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 20:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhLITyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 14:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhLITyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 14:54:53 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC75C0617A1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 11:51:20 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id w33-20020a17090a6ba400b001a722a06212so6749145pjj.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 11:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1xL00HEz2mIMU5pdZJruClkdf/MyXgTu87e9xQELm18=;
        b=WZq6rypW7k+AzsUveoK3r9SKgtfhYIfGCoOT56YzjLSEpDm2YC/7rj2sgov4HqOfNu
         Q7FLDBsSEjPaCr936M1+JJ5ev1O3fWAoBWVyrzb6hEtrTstcnEUPAbAWgLkGaeUHheuu
         fxIBaBgQXkoFsdolomVW8Dr+F055S6l0K2icA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1xL00HEz2mIMU5pdZJruClkdf/MyXgTu87e9xQELm18=;
        b=PUOhIKU7sFfYtaTGrtfbw+KcKtiFfq6SzWyVvJPBdyxH9JJT5VOLEcSi+0bfhpuoRq
         vSHrvzK+2u+l0bP8Z8uzOIga1DFgSks9zDwdNQ6wxv4wqMdgtQ99bgTvMTB2E9kxypbE
         5LjeTyInrfgBxCJ/M77SCy6603CZ0U8TOxrVexon+Tf9hagVUOB4WH3o8ieZ4LilIZi4
         WXl2/ZcqpxdO7AUA8KoX3yilr6sfnZyNN8cde8JqTPLGFfD6Js2hA7JPBI93hQlXKDJr
         wWG6//+mKoma1n/q41Jt9QdFnAST8/JAPOllYJykha8tjjBEH97ZUS8o8i0ZP0vv5kan
         +02Q==
X-Gm-Message-State: AOAM530gv2v73fRylTCFfDz90CmXl4foELodU7bnDGvgOKg0LSVH1P/I
        tWq0lGVxo+ahEyOgTAV70CHuo6bwxN4vZg==
X-Google-Smtp-Source: ABdhPJzR/2Bd1qC5yCsKlKBvm1I+vCWtXKI31p2KN54Q+o8D9XrSASm2Q4rvj47MDjeVS6Tu+DEFgw==
X-Received: by 2002:a17:90a:7e0d:: with SMTP id i13mr18203822pjl.171.1639079479659;
        Thu, 09 Dec 2021 11:51:19 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:14a7:14ad:d975:ffa4])
        by smtp.gmail.com with ESMTPSA id w142sm506410pfc.115.2021.12.09.11.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 11:51:19 -0800 (PST)
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
Subject: [PATCH v2] arm64: dts: mt8183: kukui: Add Type C node
Date:   Thu,  9 Dec 2021 11:51:12 -0800
Message-Id: <20211209195112.366176-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
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

Changes in v2:
- Alexandru mentioned that HW specs suggest preferred power role for
  devices like kukui to be sink, so changed try-power-role to "sink".

 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index 94c13c459194..0f9480f91261 100644
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
+				try-power-role = "sink";
+			};
+		};
 	};
 };
 
-- 
2.34.1.173.g76aa8bc2d0-goog

