Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1593C464872
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347576AbhLAHdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347544AbhLAHdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:33:02 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EA6C06175E;
        Tue, 30 Nov 2021 23:29:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E401CCE1D7A;
        Wed,  1 Dec 2021 07:29:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64F5C53FCC;
        Wed,  1 Dec 2021 07:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638343778;
        bh=9qt85WhT7cSNlY+anGt2ZH9cEOEi0wyaFiJhYqL/NO8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bkeRd1cSrOEFfoHxay6BDAnNT3Cn2KxM4RaAF+m/DOCUj0Et9r1ylIykSxRnKoB4v
         lKOmH2i9ldlpdzfcOjhUeH6R+y2Fqv/WexIvxGsDsEKkMNIEwHaq8qOAoEbZbwhEIW
         aMSAso0hPQJRJZarCRx543gkjeydZKQtzyx+dfsQ8EY9UMJ4/gWkj/te4ThHFexXo1
         xSi4kM4MyFbLE9PfWVQ+mn3uokA1dqymgGzWTtMcJ98obo8LWGZe6eV/rgDu2cXQyJ
         N7ocfPTEwF6ZC6IHApvt1Bg7tnp/YD4pwxXpA1/4exveMwPskLCoC97YSvf8Bgd8HE
         vkNPd7PYZeBww==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/15] arm64: dts: qcom: sm8450: Add reserved memory nodes
Date:   Wed,  1 Dec 2021 12:59:05 +0530
Message-Id: <20211201072915.3969178-6-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211201072915.3969178-1-vkoul@kernel.org>
References: <20211201072915.3969178-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the reserved memory nodes for SM8450. This is based on the downstream
documentation.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 221 +++++++++++++++++++++++++++
 1 file changed, 221 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index f0b9e80238a2..79aead4cba66 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -310,6 +310,227 @@ CLUSTER_PD: cpu-cluster0 {
 		};
 	};
 
+	reserved_memory: reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		hyp_mem: memory@80000000 {
+			no-map;
+			reg = <0x0 0x80000000 0x0 0x600000>;
+		};
+
+		xbl_dt_log_mem: memory@80600000 {
+			no-map;
+			reg = <0x0 0x80600000 0x0 0x40000>;
+		};
+
+		xbl_ramdump_mem: memory@80640000 {
+			no-map;
+			reg = <0x0 0x80640000 0x0 0x180000>;
+		};
+
+		xbl_sc_mem: memory@807c0000 {
+			no-map;
+			reg = <0x0 0x807c0000 0x0 0x40000>;
+		};
+
+		aop_image_mem: memory@80800000 {
+			no-map;
+			reg = <0x0 0x80800000 0x0 0x60000>;
+		};
+
+		aop_cmd_db_mem: memory@80860000 {
+			compatible = "qcom,cmd-db";
+			no-map;
+			reg = <0x0 0x80860000 0x0 0x20000>;
+		};
+
+		aop_config_mem: memory@80880000 {
+			no-map;
+			reg = <0x0 0x80880000 0x0 0x20000>;
+		};
+
+		tme_crash_dump_mem: memory@808a0000 {
+			no-map;
+			reg = <0x0 0x808a0000 0x0 0x40000>;
+		};
+
+		tme_log_mem: memory@808e0000 {
+			no-map;
+			reg = <0x0 0x808e0000 0x0 0x4000>;
+		};
+
+		uefi_log_mem: memory@808e4000 {
+			no-map;
+			reg = <0x0 0x808e4000 0x0 0x10000>;
+		};
+
+		/* secdata region can be reused by apps */
+		smem: memory@80900000 {
+			compatible = "qcom,smem";
+			no-map;
+			reg = <0x0 0x80900000 0x0 0x200000>;
+			hwlocks = <&tcsr_mutex 3>;
+		};
+
+		cpucp_fw_mem: memory@80b00000 {
+			no-map;
+			reg = <0x0 0x80b00000 0x0 0x100000>;
+		};
+
+		cdsp_secure_heap: memory@80c00000 {
+			no-map;
+			reg = <0x0 0x80c00000 0x0 0x4600000>;
+		};
+
+		camera_mem: memory@85200000 {
+			no-map;
+			reg = <0x0 0x85200000 0x0 0x500000>;
+		};
+
+		video_mem: memory@85700000 {
+			no-map;
+			reg = <0x0 0x85700000 0x0 0x700000>;
+		};
+
+		adsp_mem: memory@85e00000 {
+			no-map;
+			reg = <0x0 0x85e00000 0x0 0x2100000>;
+		};
+
+		slpi_mem: memory@88000000 {
+			no-map;
+			reg = <0x0 0x88000000 0x0 0x1900000>;
+		};
+
+		cdsp_mem: memory@89900000 {
+			no-map;
+			reg = <0x0 0x89900000 0x0 0x2000000>;
+		};
+
+		ipa_fw_mem: memory@8b900000 {
+			no-map;
+			reg = <0x0 0x8b900000 0x0 0x10000>;
+		};
+
+		ipa_gsi_mem: memory@8b910000 {
+			no-map;
+			reg = <0x0 0x8b910000 0x0 0xa000>;
+		};
+
+		gpu_micro_code_mem: memory@8b91a000 {
+			no-map;
+			reg = <0x0 0x8b91a000 0x0 0x2000>;
+		};
+
+		spss_region_mem: memory@8ba00000 {
+			no-map;
+			reg = <0x0 0x8ba00000 0x0 0x180000>;
+		};
+
+		/* First part of the "SPU secure shared memory" region */
+		spu_tz_shared_mem: memory@8bb80000 {
+			no-map;
+			reg = <0x0 0x8bb80000 0x0 0x60000>;
+		};
+
+		/* Second part of the "SPU secure shared memory" region */
+		spu_modem_shared_mem: memory@8bbe0000 {
+			no-map;
+			reg = <0x0 0x8bbe0000 0x0 0x20000>;
+		};
+
+		mpss_mem: memory@8bc00000 {
+			no-map;
+			reg = <0x0 0x8bc00000 0x0 0x13200000>;
+		};
+
+		cvp_mem: memory@9ee00000 {
+			no-map;
+			reg = <0x0 0x9ee00000 0x0 0x700000>;
+		};
+
+		global_sync_mem: memory@a6f00000 {
+			no-map;
+			reg = <0x0 0xa6f00000 0x0 0x100000>;
+		};
+
+		/* uefi region can be reused by apps */
+
+		/* Linux kernel image is loaded at 0xa0000000 */
+
+		oem_vm_mem: memory@bb000000 {
+			no-map;
+			reg = <0x0 0xbb000000 0x0 0x5000000>;
+		};
+
+		mte_mem: memory@c0000000 {
+			no-map;
+			reg = <0x0 0xc0000000 0x0 0x20000000>;
+		};
+
+		qheebsp_reserved_mem: memory@e0000000 {
+			no-map;
+			reg = <0x0 0xe0000000 0x0 0x600000>;
+		};
+
+		cpusys_vm_mem: memory@e0600000 {
+			no-map;
+			reg = <0x0 0xe0600000 0x0 0x400000>;
+		};
+
+		hyp_reserved_mem: memory@e0a00000 {
+			no-map;
+			reg = <0x0 0xe0a00000 0x0 0x100000>;
+		};
+
+		trust_ui_vm_mem: memory@e0b00000 {
+			no-map;
+			reg = <0x0 0xe0b00000 0x0 0x4af3000>;
+		};
+
+		trust_ui_vm_qrtr: memory@e55f3000 {
+			no-map;
+			reg = <0x0 0xe55f3000 0x0 0x9000>;
+		};
+
+		trust_ui_vm_vblk0_ring: memory@e55fc000 {
+			no-map;
+			reg = <0x0 0xe55fc000 0x0 0x4000>;
+		};
+
+		trust_ui_vm_swiotlb: memory@e5600000 {
+			no-map;
+			reg = <0x0 0xe5600000 0x0 0x100000>;
+		};
+
+		tz_stat_mem: memory@e8800000 {
+			no-map;
+			reg = <0x0 0xe8800000 0x0 0x100000>;
+		};
+
+		tags_mem: memory@e8900000 {
+			no-map;
+			reg = <0x0 0xe8900000 0x0 0x1200000>;
+		};
+
+		qtee_mem: memory@e9b00000 {
+			no-map;
+			reg = <0x0 0xe9b00000 0x0 0x500000>;
+		};
+
+		trusted_apps_mem: memory@ea000000 {
+			no-map;
+			reg = <0x0 0xea000000 0x0 0x3900000>;
+		};
+
+		trusted_apps_ext_mem: memory@ed900000 {
+			no-map;
+			reg = <0x0 0xed900000 0x0 0x3b00000>;
+		};
+	};
+
 	soc: soc@0 {
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
2.31.1

