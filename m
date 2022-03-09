Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FD94D2E13
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 12:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbiCILce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 06:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbiCILca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 06:32:30 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EEF170D48
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 03:31:25 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id j17so2602923wrc.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 03:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GOvMOP28MDGDg8jm0bUDGj4CT9iVJx+FbMwn9im/8gE=;
        b=DYYRrXwBfYdyvZl7nwCI8zi46eWeNWLbjRs9meSQAuyTqNBswColwKkgj1Dp19oVrr
         bNJCGZQQ8jwHp5IOnCQSDFH9LCc+Bcr4qzdPeFS8hwHjstKvNa3coGWkKYmWLF85WVvX
         YZROikc7TuVurBioTrh0ahbB6iKjCB4+x+M/UxL9JRljYaHJ8ba5kaocfc5dOJe37NVB
         5pFUFnTPMgNLtkbQgT1F74VVmramT/+Fg/Q1RUI67+1b39srqC7ffqy0hSKu0TUjKDaO
         M2K5dS/tZyNT5wZ8s4o0gEiZxvGSWcL+k8sGwlLnbkurflNfH/GCisE+3zIc14h9vnrH
         FS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GOvMOP28MDGDg8jm0bUDGj4CT9iVJx+FbMwn9im/8gE=;
        b=SXUPA8ocOf47wD/rbgJfUJBivLXBiiCV1+U0ddUoqB0EhWvk9CekAyz4yI18fHOFMF
         7zmFYbb3/Q2wMfnRxSEA1nM7P66wOR/WhBS1sunpnLsyV7oLdoVQxu17IWPlwvjACmw0
         33tgnh1NssQ5izT29tsUBaKqAzmYJhr+IFHSuLkdNE+tLi21wPMYpkOfoVRDuPH/5uF4
         5XFqxF5oPsF0GH0uHFYdvDfHnipqqnpCJmu7CsUx3Jmg2wHcVGQ+WAVKH/UuSBDoYbY+
         LuQp34ehUE+O+405cuMcu5aqE3gD7vB25KsdyHCdreJnF8I+S3fFkfJ6JJz1Ptsr6Oa6
         ud0g==
X-Gm-Message-State: AOAM53243gPoSZJK4VoApb/Veqi/8IyY9rQwQrr8H+Wro6zSWUF9Qheg
        uTpQketT4RHZxuXv4krsZyZ1Fg==
X-Google-Smtp-Source: ABdhPJwj0qlp2p8qBOZtQ+eZg7IOGgHWUmDKmHLQRaft41pDKWTDT1rJCXMLVFG/egaBSRDOio7xeA==
X-Received: by 2002:adf:a482:0:b0:1e3:3e5f:496c with SMTP id g2-20020adfa482000000b001e33e5f496cmr15266410wrb.606.1646825483932;
        Wed, 09 Mar 2022 03:31:23 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:546d:7d59:1703:bf96])
        by smtp.gmail.com with ESMTPSA id o11-20020adf9d4b000000b001f0077ea337sm1503812wre.22.2022.03.09.03.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 03:31:23 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     liviu.dudau@arm.com, sudeep.holla@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        lorenzo.pieralisi@arm.com
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        robh+dt@kernel.org, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH RESEND 1/1] arm64: dts: arm:  Juno - add CTI entries to device tree
Date:   Wed,  9 Mar 2022 11:31:17 +0000
Message-Id: <20220309113117.1126-2-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220309113117.1126-1-mike.leach@linaro.org>
References: <20220309113117.1126-1-mike.leach@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add in CTI entries for Juno r0, r1 and r2 to device tree entries.

Tested on Linux 5.7-rc1

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 arch/arm64/boot/dts/arm/juno-base.dtsi    | 162 +++++++++++++++++++++-
 arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi |  37 ++++-
 arch/arm64/boot/dts/arm/juno-r1.dts       |  25 ++++
 arch/arm64/boot/dts/arm/juno-r2.dts       |  25 ++++
 arch/arm64/boot/dts/arm/juno.dts          |  25 ++++
 5 files changed, 269 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index 6288e104a089..e022d72c4b0d 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -117,7 +117,7 @@
 	 * The actual size is just 4K though 64K is reserved. Access to the
 	 * unmapped reserved region results in a DECERR response.
 	 */
-	etf@20010000 { /* etf0 */
+	etf_sys0: etf@20010000 { /* etf0 */
 		compatible = "arm,coresight-tmc", "arm,primecell";
 		reg = <0 0x20010000 0 0x1000>;
 
@@ -141,7 +141,7 @@
 		};
 	};
 
-	tpiu@20030000 {
+	tpiu_sys: tpiu@20030000 {
 		compatible = "arm,coresight-tpiu", "arm,primecell";
 		reg = <0 0x20030000 0 0x1000>;
 
@@ -194,7 +194,7 @@
 		};
 	};
 
-	etr@20070000 {
+	etr_sys: etr@20070000 {
 		compatible = "arm,coresight-tmc", "arm,primecell";
 		reg = <0 0x20070000 0 0x1000>;
 		iommus = <&smmu_etr 0>;
@@ -212,7 +212,7 @@
 		};
 	};
 
-	stm@20100000 {
+	stm_sys: stm@20100000 {
 		compatible = "arm,coresight-stm", "arm,primecell";
 		reg = <0 0x20100000 0 0x1000>,
 		      <0 0x28000000 0 0x1000000>;
@@ -289,6 +289,18 @@
 		};
 	};
 
+	cti0: cti@22020000 {
+		compatible = "arm,coresight-cti-v8-arch", "arm,coresight-cti",
+			     "arm,primecell";
+		reg = <0 0x22020000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+
+		arm,cs-dev-assoc = <&etm0>;
+	};
+
 	funnel@220c0000 { /* cluster0 funnel */
 		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 		reg = <0 0x220c0000 0 0x1000>;
@@ -349,6 +361,18 @@
 		};
 	};
 
+	cti1: cti@22120000 {
+		compatible = "arm,coresight-cti-v8-arch", "arm,coresight-cti",
+			     "arm,primecell";
+		reg = <0 0x22120000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+
+		arm,cs-dev-assoc = <&etm1>;
+	};
+
 	cpu_debug2: cpu-debug@23010000 {
 		compatible = "arm,coresight-cpu-debug", "arm,primecell";
 		reg = <0x0 0x23010000 0x0 0x1000>;
@@ -374,6 +398,18 @@
 		};
 	};
 
+	cti2: cti@23020000 {
+		compatible = "arm,coresight-cti-v8-arch", "arm,coresight-cti",
+			     "arm,primecell";
+		reg = <0 0x23020000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+
+		arm,cs-dev-assoc = <&etm2>;
+	};
+
 	funnel@230c0000 { /* cluster1 funnel */
 		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 		reg = <0 0x230c0000 0 0x1000>;
@@ -446,6 +482,18 @@
 		};
 	};
 
+	cti3: cti@23120000 {
+		compatible = "arm,coresight-cti-v8-arch", "arm,coresight-cti",
+			     "arm,primecell";
+		reg = <0 0x23120000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+
+		arm,cs-dev-assoc = <&etm3>;
+	};
+
 	cpu_debug4: cpu-debug@23210000 {
 		compatible = "arm,coresight-cpu-debug", "arm,primecell";
 		reg = <0x0 0x23210000 0x0 0x1000>;
@@ -471,6 +519,18 @@
 		};
 	};
 
+	cti4: cti@23220000 {
+		compatible = "arm,coresight-cti-v8-arch", "arm,coresight-cti",
+			     "arm,primecell";
+		reg = <0 0x23220000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+
+		arm,cs-dev-assoc = <&etm4>;
+	};
+
 	cpu_debug5: cpu-debug@23310000 {
 		compatible = "arm,coresight-cpu-debug", "arm,primecell";
 		reg = <0x0 0x23310000 0x0 0x1000>;
@@ -496,6 +556,100 @@
 		};
 	};
 
+	cti5: cti@23320000 {
+		compatible = "arm,coresight-cti-v8-arch", "arm,coresight-cti",
+			     "arm,primecell";
+		reg = <0 0x23320000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+
+		arm,cs-dev-assoc = <&etm5>;
+	};
+
+	cti@20020000 { /* sys_cti_0 */
+		compatible = "arm,coresight-cti", "arm,primecell";
+		reg = <0 0x20020000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		trig-conns@0 {
+			reg = <0>;
+			arm,trig-in-sigs=<2 3>;
+			arm,trig-in-types=<SNK_FULL SNK_ACQCOMP>;
+			arm,trig-out-sigs=<0 1>;
+			arm,trig-out-types=<SNK_FLUSHIN SNK_TRIGIN>;
+			arm,cs-dev-assoc = <&etr_sys>;
+		};
+
+		trig-conns@1 {
+			reg = <1>;
+			arm,trig-in-sigs=<0 1>;
+			arm,trig-in-types=<SNK_FULL SNK_ACQCOMP>;
+			arm,trig-out-sigs=<7 6>;
+			arm,trig-out-types=<SNK_FLUSHIN SNK_TRIGIN>;
+			arm,cs-dev-assoc = <&etf_sys0>;
+		};
+
+		trig-conns@2 {
+			reg = <2>;
+			arm,trig-in-sigs=<4 5 6 7>;
+			arm,trig-in-types=<STM_TOUT_SPTE STM_TOUT_SW
+					   STM_TOUT_HETE STM_ASYNCOUT>;
+			arm,trig-out-sigs=<4 5>;
+			arm,trig-out-types=<STM_HWEVENT STM_HWEVENT>;
+			arm,cs-dev-assoc = <&stm_sys>;
+		};
+
+		trig-conns@3 {
+			reg = <3>;
+			arm,trig-out-sigs=<2 3>;
+			arm,trig-out-types=<SNK_FLUSHIN SNK_TRIGIN>;
+			arm,cs-dev-assoc = <&tpiu_sys>;
+		};
+	};
+
+	cti@20110000 { /* sys_cti_1 */
+		compatible = "arm,coresight-cti", "arm,primecell";
+		reg = <0 0x20110000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		trig-conns@0 {
+			reg = <0>;
+			arm,trig-in-sigs=<0>;
+			arm,trig-in-types=<GEN_INTREQ>;
+			arm,trig-out-sigs=<0>;
+			arm,trig-out-types=<GEN_HALTREQ>;
+			arm,trig-conn-name = "sys_profiler";
+		};
+
+		trig-conns@1 {
+			reg = <1>;
+			arm,trig-out-sigs=<2 3>;
+			arm,trig-out-types=<GEN_HALTREQ GEN_RESTARTREQ>;
+			arm,trig-conn-name = "watchdog";
+		};
+
+		trig-conns@2 {
+			reg = <2>;
+			arm,trig-out-sigs=<1 6>;
+			arm,trig-out-types=<GEN_HALTREQ GEN_RESTARTREQ>;
+			arm,trig-conn-name = "g_counter";
+		};
+	};
+
 	gpu: gpu@2d000000 {
 		compatible = "arm,juno-mali", "arm,mali-t624";
 		reg = <0 0x2d000000 0 0x10000>;
diff --git a/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi b/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
index eda3d9e18af6..752b05f8bf31 100644
--- a/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
@@ -23,7 +23,7 @@
 		};
 	};
 
-	etf@20140000 { /* etf1 */
+	etf_sys1: etf@20140000 { /* etf1 */
 		compatible = "arm,coresight-tmc", "arm,primecell";
 		reg = <0 0x20140000 0 0x1000>;
 
@@ -82,4 +82,39 @@
 
 		};
 	};
+
+	cti@20160000 { /* sys_cti_2 */
+		compatible = "arm,coresight-cti", "arm,primecell";
+		reg = <0 0x20160000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		trig-conns@0 {
+			reg = <0>;
+			arm,trig-in-sigs=<0 1>;
+			arm,trig-in-types=<SNK_FULL SNK_ACQCOMP>;
+			arm,trig-out-sigs=<0 1>;
+			arm,trig-out-types=<SNK_FLUSHIN SNK_TRIGIN>;
+			arm,cs-dev-assoc = <&etf_sys1>;
+		};
+
+		trig-conns@1 {
+			reg = <1>;
+			arm,trig-in-sigs=<2 3 4>;
+			arm,trig-in-types=<ELA_DBGREQ ELA_TSTART ELA_TSTOP>;
+			arm,trig-conn-name = "ela_clus_0";
+		};
+
+		trig-conns@2 {
+			reg = <2>;
+			arm,trig-in-sigs=<5 6 7>;
+			arm,trig-in-types=<ELA_DBGREQ ELA_TSTART ELA_TSTOP>;
+			arm,trig-conn-name = "ela_clus_1";
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/arm/juno-r1.dts b/arch/arm64/boot/dts/arm/juno-r1.dts
index 0e24e29eb9b1..f099fb611d4e 100644
--- a/arch/arm64/boot/dts/arm/juno-r1.dts
+++ b/arch/arm64/boot/dts/arm/juno-r1.dts
@@ -9,6 +9,7 @@
 /dts-v1/;
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/arm/coresight-cti-dt.h>
 #include "juno-base.dtsi"
 #include "juno-cs-r1r2.dtsi"
 
@@ -313,3 +314,27 @@
 &cpu_debug5 {
 	cpu = <&A53_3>;
 };
+
+&cti0 {
+	cpu = <&A57_0>;
+};
+
+&cti1 {
+	cpu = <&A57_1>;
+};
+
+&cti2 {
+	cpu = <&A53_0>;
+};
+
+&cti3 {
+	cpu = <&A53_1>;
+};
+
+&cti4 {
+	cpu = <&A53_2>;
+};
+
+&cti5 {
+	cpu = <&A53_3>;
+};
diff --git a/arch/arm64/boot/dts/arm/juno-r2.dts b/arch/arm64/boot/dts/arm/juno-r2.dts
index e609420ce3e4..709389582ae3 100644
--- a/arch/arm64/boot/dts/arm/juno-r2.dts
+++ b/arch/arm64/boot/dts/arm/juno-r2.dts
@@ -9,6 +9,7 @@
 /dts-v1/;
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/arm/coresight-cti-dt.h>
 #include "juno-base.dtsi"
 #include "juno-cs-r1r2.dtsi"
 
@@ -319,3 +320,27 @@
 &cpu_debug5 {
 	cpu = <&A53_3>;
 };
+
+&cti0 {
+	cpu = <&A72_0>;
+};
+
+&cti1 {
+	cpu = <&A72_1>;
+};
+
+&cti2 {
+	cpu = <&A53_0>;
+};
+
+&cti3 {
+	cpu = <&A53_1>;
+};
+
+&cti4 {
+	cpu = <&A53_2>;
+};
+
+&cti5 {
+	cpu = <&A53_3>;
+};
diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
index f00cffbd032c..dbc22e70b62c 100644
--- a/arch/arm64/boot/dts/arm/juno.dts
+++ b/arch/arm64/boot/dts/arm/juno.dts
@@ -9,6 +9,7 @@
 /dts-v1/;
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/arm/coresight-cti-dt.h>
 #include "juno-base.dtsi"
 
 / {
@@ -295,3 +296,27 @@
 &cpu_debug5 {
 	cpu = <&A53_3>;
 };
+
+&cti0 {
+	cpu = <&A57_0>;
+};
+
+&cti1 {
+	cpu = <&A57_1>;
+};
+
+&cti2 {
+	cpu = <&A53_0>;
+};
+
+&cti3 {
+	cpu = <&A53_1>;
+};
+
+&cti4 {
+	cpu = <&A53_2>;
+};
+
+&cti5 {
+	cpu = <&A53_3>;
+};
-- 
2.17.1

