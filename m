Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21984491386
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244251AbiARBiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243964AbiARBiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:38:16 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74978C061746;
        Mon, 17 Jan 2022 17:38:15 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 30so72949879edv.3;
        Mon, 17 Jan 2022 17:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pO6jjMkLEBcCoOmgC9LDz88H2s+NgQ4gFBtGRzesk0g=;
        b=HfOfzqM4ijFhaycW23EX38NybqOxBHFOu9eJu7IYVm4OTvvq7QsHQz90RKOElgPR+m
         7Pte1TYyD/Eblg4g47Eiyaag21+//YpYT4NzNAmvHPN2Z8D09bH5vM6iCRSrYVE7FUad
         ktpvZwD60TO47jZlpM6MJcFaGMShaU9OOh0qYX0rM8JEafg9d1WgMOyFXei8esZndtS3
         V30DRQwzfB4K+2R6/5UDjvFGYSWiXfdVKVTAzZi/u620d1EbrTf4MQbr5RMO2cNKByCY
         6UyRKLckF5UVkyYtxIXUy+/SGjG0yqqykqhOuINRehTHxC3jRhMLY86O+/EQVXCO3bKO
         mU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pO6jjMkLEBcCoOmgC9LDz88H2s+NgQ4gFBtGRzesk0g=;
        b=gZLZxy+DVamlA/apvW06KQyMZAaGljtpSvQmLCE5dafAs2t7xCEhWIGAABXbNI/BRC
         DfKSDQT1vsVauLfWnXWEA2smevLHb7HK+2k8V0pRNxdpU8Hh6/Cd4lsL9bE7ApLDr9lP
         DVmuBG/VSzp9QmyW++nexpKk480jTpdCW8UTyXQjzkUrhRi0WiBZyORbwzWaVfuEO/oJ
         QwhKBFsKIHFaq12e9UDoHWCDKOzPnIOjeFXfjNxf94lJAnHaaVOrjfMfKqPdSMeNKnM9
         8ewQWBr7iOCVKTzLQCUZuLaZSbnX1cmJWEuH6BRDx5Hyh+Csv62dN30I/4pAjQjjaw3o
         +pRQ==
X-Gm-Message-State: AOAM531UGGnDh9cMcMSDXmlofuaIXdnGKx3Cm1JsHbT0CA7qc+5VpoIm
        lOk13Qin2JjbcIaN3g9M3p8=
X-Google-Smtp-Source: ABdhPJyqVE7G77cwvD0P317WQv41iQixMutbq/IlypNgGfU/2jwvdSASRNh1Ms0wtrBVFQtahuc/YA==
X-Received: by 2002:a17:906:6a1a:: with SMTP id qw26mr19020347ejc.46.1642469893964;
        Mon, 17 Jan 2022 17:38:13 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id kj18sm3990675ejc.139.2022.01.17.17.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 17:38:13 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH 05/17] ARM: dts: qcom: enable usb phy by default for ipq8064
Date:   Tue, 18 Jan 2022 02:20:35 +0100
Message-Id: <20220118012051.21691-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220118012051.21691-1-ansuelsmth@gmail.com>
References: <20220118012051.21691-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable usb phy by default. When the usb phy were pushed, half of them
were flagged as disabled by mistake. Fix this to correctly init dwc3
node on any ipq8064 based SoC.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 7cf85b4f6ec8..441309bb64c8 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -1161,8 +1161,6 @@ hs_phy_0: phy@100f8800 {
 			clocks = <&gcc USB30_0_UTMI_CLK>;
 			clock-names = "ref";
 			#phy-cells = <0>;
-
-			status = "disabled";
 		};
 
 		ss_phy_0: phy@100f8830 {
@@ -1171,8 +1169,6 @@ ss_phy_0: phy@100f8830 {
 			clocks = <&gcc USB30_0_MASTER_CLK>;
 			clock-names = "ref";
 			#phy-cells = <0>;
-
-			status = "disabled";
 		};
 
 		usb3_0: usb3@100f8800 {
-- 
2.33.1

