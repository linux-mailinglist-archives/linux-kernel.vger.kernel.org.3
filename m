Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4A6491398
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244307AbiARBia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244236AbiARBiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:38:21 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6289EC061747;
        Mon, 17 Jan 2022 17:38:18 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id j7so24461118edr.4;
        Mon, 17 Jan 2022 17:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UsIFc41NyVxBMgdnBu1qnW2vSm6Sfxs1oXcb1leBi3Q=;
        b=Z06EZP9zR2KV5pxvjrJS24JD/93CtQ8caQaIjCV6A8MS27S1M5N19G8eaHP6XmT7gF
         Z9nBitbj33e3oVgwcCabDqvqQXWZByQNFHE3l3DCwAnhFepb0y/GVf46rvbmLG/auAmg
         bUw18oz1ZuBBoekedLz8X1GNPtrcnHTjKc9r3PKtNqj0xXxkkm1fv9cbAYMzhuXnIpNv
         6Upizv0BEAEwm7rbRIlmlaiC1PMio3gmFjH9hu7oKdUMk/6oyZ6kEK4aZlGXO8R2U045
         PVD6I6SE5cH/Py6qZJjmsgOxkB5vusVfzspMi5rSWVry8DtU1tqLCp2IgJFh7L2H6Owf
         CdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UsIFc41NyVxBMgdnBu1qnW2vSm6Sfxs1oXcb1leBi3Q=;
        b=zol3vqb8m9/d4JGBoXOnbIVIatrkYwZUY6a8dHtnqm4yAxoiLSA5h8/6fzw/3HhbUk
         +l0mhf8wqp/ZFAa6KaK0kMrLC0x2jGpfcLYzvEC5rTlCmFF/olHM/d3HPJf9IuHT17qH
         NsFDoIOULMXq17HEZPTsJrURxSWZTPjhiOWxe6iBhlg8sbXx9D5IfvgSvbxLe00aNkcg
         XIjbfn+JlY3Wk41/lJP5q7omsPoSw2Pt+fDVttgk8Br+nDVYtsCIi75NL0XqRKphi9MA
         X/jqcTuMop6E30U4R8gy6fzQBLXy9Rzb/Y6f0y0bXZos8bEC4aTZYxnZlhAexgcs2zzp
         SD/g==
X-Gm-Message-State: AOAM530c8KFd32BxIGFOotd7++Mwht4wcP+xh4D5x+q0mEliWOAjLIUz
        1QdN2sELWJ5MfbU1QoPy/tY=
X-Google-Smtp-Source: ABdhPJxg6+CynD7BFXcKFSw4ZXQHSZuV10OL0+lkGZntXpXKv5MybDqePJDXpWz/nSPmGOF7fA/Afw==
X-Received: by 2002:aa7:dd56:: with SMTP id o22mr24160660edw.73.1642469896869;
        Mon, 17 Jan 2022 17:38:16 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id kj18sm3990675ejc.139.2022.01.17.17.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 17:38:16 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH 08/17] ARM: dts: qcom: add smem node for ipq8064
Date:   Tue, 18 Jan 2022 02:20:38 +0100
Message-Id: <20220118012051.21691-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220118012051.21691-1-ansuelsmth@gmail.com>
References: <20220118012051.21691-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing smem node for ipq8064.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 856968a96498..8c2d4dac0ebd 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -892,6 +892,11 @@ lcc: clock-controller@28000000 {
 			#reset-cells = <1>;
 		};
 
+		sfpb_mutex_block: syscon@1200600 {
+			compatible = "syscon";
+			reg = <0x01200600 0x100>;
+		};
+
 		pcie0: pci@1b500000 {
 			compatible = "qcom,pcie-ipq8064";
 			reg = <0x1b500000 0x1000
@@ -1316,4 +1321,17 @@ sdcc3: mmc@12180000 {
 			};
 		};
 	};
+
+	sfpb_mutex: sfpb-mutex {
+		compatible = "qcom,sfpb-mutex";
+		syscon = <&sfpb_mutex_block 4 4>;
+
+		#hwlock-cells = <1>;
+	};
+
+	smem {
+		compatible = "qcom,smem";
+		memory-region = <&smem>;
+		hwlocks = <&sfpb_mutex 3>;
+	};
 };
-- 
2.33.1

