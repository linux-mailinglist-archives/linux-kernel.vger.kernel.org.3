Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A5E46692E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 18:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376372AbhLBRe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 12:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376399AbhLBRep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 12:34:45 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A6BC0613F4;
        Thu,  2 Dec 2021 09:31:18 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id x15so1158715edv.1;
        Thu, 02 Dec 2021 09:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EHO5qmCBd3P5VQDnZWNt4xwrgXpq9DvzNEUBVGGXOK4=;
        b=TyuEZZnXZBKB8LSNemecmH1zsPczSRCqfOdM2B9X96qb/bTjZSamRrLxmxCqjMAECc
         lXlJ7Rz055Acnni6ydJcYAszDIifUOD4qJZjVwyLOzCbrbVzJ4OR4Xt/+rubOHmDv7wJ
         IKlwR0rBIS6TxASgfqLB5ksy375CZtKcSH3dnqJO2yk6h2GjLL2kaU5g3uF8x3gdj1vz
         WZk+WGsPFY0bawiQtkGBdkxXvFwlce/4EAW4cAUp0FGfSZc4/zM96BunN2RHTP3S85Ts
         0Ms9JPZBA93WyXielCqknooeRLiIE/OXUh2/l635anqKbvrYY1W6jrv2N6f4UaDxcllH
         3CuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EHO5qmCBd3P5VQDnZWNt4xwrgXpq9DvzNEUBVGGXOK4=;
        b=wCEOkPQGx+wPahG1XCkE7qXMndELsRN2ayArp4qmrO6L4E/+dLAd1OmUtk577MD7eE
         NKddBRaTs6JafatiAybXlbxex+OXFYfaOf4ScCPkgAf2w8OqEWl1LAEfEMO7N0tWYAQv
         MhFOjV8VkOQCKgLomn8OSS95L6+jK0g5pKuWCRQWCXsBJ96crKqL15HoTi5D8x0wTYSy
         Zw3U7E1xiLM4Ck8qKx8cIalmapSgg2mzXD1fipDmBS5v7p9Man6YyEu7oDry+qGYiKIY
         AvgmouwKbYq4j/LWhz9nRpXUKUrinuSDapAAoflcwY3qYnm/i33j2j9WShwf+pC45bp2
         fMdw==
X-Gm-Message-State: AOAM531kOKOu9nM2bblwCGMS/gZeP6Z5ObkC3j2JXDygSHatg1zM6llq
        npV5KnFE81fiEJYbJLmZ5Sr1Zo/zu+o=
X-Google-Smtp-Source: ABdhPJz6sgRoByEwVHd+Sfjtr7gZN60/N9pKnYjfqXIjpIdL6WbWHr+XpIZi7b6VCrgHxMckzmaxmw==
X-Received: by 2002:a17:907:3e9a:: with SMTP id hs26mr16887844ejc.433.1638466277257;
        Thu, 02 Dec 2021 09:31:17 -0800 (PST)
Received: from localhost.localdomain.info (62-178-82-229.cable.dynamic.surfer.at. [62.178.82.229])
        by smtp.gmail.com with ESMTPSA id dy4sm225329edb.92.2021.12.02.09.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 09:31:16 -0800 (PST)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v2] arm64: dts: ti: k3-am64-main: add timesync router node
Date:   Thu,  2 Dec 2021 18:30:18 +0100
Message-Id: <20211202173114.9936-1-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Time Sync Event Router (TIMESYNC_INTRTR0) implements a set of
multiplexers to provide selection of active CPTS time sync events for
routing to CPTS capable modules.

This patch adds DT node TIMESYNC_INTRTR0 using "pinctrl-single" bindings.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
Changes in v2:
  -  Use pinctrl for node name

 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 5ad638b95ffc..e16d2ccdd818 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -564,6 +564,14 @@ cpts@39000000 {
 		ti,cpts-ext-ts-inputs = <8>;
 	};
 
+	timesync_router: pinctrl@a40000 {
+		compatible = "pinctrl-single";
+		reg = <0x0 0xa40000 0x0 0x800>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0x000107ff>;
+	};
+
 	usbss0: cdns-usb@f900000{
 		compatible = "ti,am64-usb";
 		reg = <0x00 0xf900000 0x00 0x100>;
-- 
2.33.1

