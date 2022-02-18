Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796D04BAE76
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiBRAar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 19:30:47 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiBRAaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 19:30:39 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CD45F260;
        Thu, 17 Feb 2022 16:30:09 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id k1so11740267wrd.8;
        Thu, 17 Feb 2022 16:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Pkbf/0AvfPHS5Qks1C72P4zaKgvYZBLMpXBGJAMl3s=;
        b=oDhr2gcLCuQDua9ie61E+ZSr11QCPKk9mD3i+7uPo/mLYlgDYV+zaaxRdc0wiI64ml
         tkmNexY9vcWOvZWh5nGyDmLW4ZTAO+ZraOdbLgeZFhOLO8I9S+xzJh+0JJhsGPqQeNU1
         /S4FlyXVSv2zEZlnujq/EJeEyGzCaHdAW2aWxhdwZYiGmn9ffhrGaWJzGtSzb8+zxKZr
         624GvbInhXp9YFD/Dc15J8XQAoastPZ5v/u5dATlGumVx3IDpPErh8hv9DMpaZ4cxSsO
         1sVgSvYGHZx5JTrZP9VT08es9swdU5PkVG2IDp3Hx4y7nQH/g78//Q9GSGQIRwrRSG/f
         qg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Pkbf/0AvfPHS5Qks1C72P4zaKgvYZBLMpXBGJAMl3s=;
        b=F6cmi7ZAKyP8y/osWhor9XhRT3+RY9JukIOwit/8axZnU1bMPE4UNXKkZT/AFvor1F
         gRCNqyhmBgDINhxcaiU8IefXZNllGfJBOOub0suHgi7Ap+cAWdO7dFHBeBeTMC294GcC
         6H3foIRXHVLr4wSKKBkOHbm/j7eGAcnLC5UXL59cMyer+l/pNYXidTrQMxo0SYLpP62l
         2M3j2dhm4K950I5X5pAEqlMrlKBDD+4qpc2yzIF0N6hjqQIbOUN/alFGksW5sgm8RJwa
         8rFT7rOThf3IESJYUKpaflrnsexU+OQ2QZCoesi9tey68h3MawkUfmhasQDkJnRlg2Se
         GCrw==
X-Gm-Message-State: AOAM531gC3S9bLESxiXpXTNl3nZQ6NkEIHLG560b6001sd1J+LDM8elb
        OaR5NjSTfpnQk6eSxz9+lbM=
X-Google-Smtp-Source: ABdhPJx8IkNpLwkoJuv4VugASkNxp2w9xcRIazJ2VDgMq0qN2VX6dxHNc9YVpKXxDMIY5whAtpg5IA==
X-Received: by 2002:a5d:58d9:0:b0:1e5:6b50:24f3 with SMTP id o25-20020a5d58d9000000b001e56b5024f3mr4066376wrf.622.1645144204379;
        Thu, 17 Feb 2022 16:30:04 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id d29sm3640406wra.63.2022.02.17.16.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 16:30:04 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH v2 09/18] ARM: dts: qcom: add smem node for ipq8064
Date:   Fri, 18 Feb 2022 01:29:47 +0100
Message-Id: <20220218002956.6590-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218002956.6590-1-ansuelsmth@gmail.com>
References: <20220218002956.6590-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing smem node for ipq8064.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 6768f7ba0d04..c579fb09e768 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -906,6 +906,11 @@ lcc: clock-controller@28000000 {
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
@@ -1330,4 +1335,17 @@ sdcc3: mmc@12180000 {
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
2.34.1

