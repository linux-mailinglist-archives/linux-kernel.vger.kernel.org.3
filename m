Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A2B496CEA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 17:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234533AbiAVQcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 11:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234470AbiAVQcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 11:32:47 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F628C061401
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 08:32:46 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id o9so10485390qvy.13
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 08:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xi6Epe+O63qC2bPYwLhP+7XAxexroUTZOcN3RjcdwYc=;
        b=zZiWJkEJj7gkgpFfiL8+Qcq3iYCvUKc4tQa1qAYdIa4FzHEprH5jH3QbvhRB9OV0H3
         NYvDLa3z02FmjRs/pdWWyPtMolo32YfSQztd1ETs7yydgO+HAKRdvPlUM58iRk1VQGjQ
         9H0iiIoGR1EQm2nuOIhswXYyj8FFD90Slnvk5nRbXkOiRlm5gVlzD1phJXKRf0der5WK
         w7TgmoYFlG2etXShrW3MnokTMiCOmIXWUHOmGZmUN1/9KQBzCM6vAJah7MMVTcnLtUDi
         r6IHTISIhhAX8iYe44o8VklWfb3Y0/ILg4mLgu3xo4gSip4E96tPgGgoDuqMHHWITKxr
         tdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xi6Epe+O63qC2bPYwLhP+7XAxexroUTZOcN3RjcdwYc=;
        b=wFldeBm6F2pUQHQgQs1zkFSZA7ZHCR8OX9aNxIn1eT5ILYY5Yd/vTI/BNolQs9FrXn
         Oo/IX/vVcj1LdVX3ex8EH+Aj2atrGWWWFm6mxM4sg31/MtDj1jAwYqc1jgdcx7plRMd+
         fB2S6vBuOY4OLIwjt68PBNafeDilkLV8vST5zP/6enL51p9JbuhJRXvs+HWmjR6ugOFs
         ZvI7gwUoYJ11QH6K40GDJfUl9sEARe0+HLn6qL5e6fVIYK5GF1OqzkkmaxpHOxKFKTz0
         DwSX4Guy5tBfppYujhMlKrWZi4n60jPEkBBGG5FZk/4Zm03feq+eRXlKM5RRS4zPDhed
         mM5A==
X-Gm-Message-State: AOAM532+NUwngyVPCpofTZOE+qPVInGxT6pyzkfwW7H0cn+aTz/XjHJy
        Ss5+KzUSoiMPpKjUi3D12RbuUw==
X-Google-Smtp-Source: ABdhPJwb/Jm99YoLQ3/xxKudwqDLeXqNgcKFveEo5sXqa3tcV0J1phIo5ww72GLZhP9AFEiuthcbKA==
X-Received: by 2002:a05:6214:4008:: with SMTP id kd8mr8123868qvb.5.1642869165665;
        Sat, 22 Jan 2022 08:32:45 -0800 (PST)
Received: from localhost.localdomain (modemcable134.222-177-173.mc.videotron.ca. [173.177.222.134])
        by smtp.gmail.com with ESMTPSA id b140sm4806440qkg.108.2022.01.22.08.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 08:32:45 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] arm64: dts: qcom: sm8450: fix apps_smmu interrupts
Date:   Sat, 22 Jan 2022 11:29:32 -0500
Message-Id: <20220122162932.7686-2-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20220122162932.7686-1-jonathan@marek.ca>
References: <20220122162932.7686-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update interrupts in apps_smmu to match downstream. This is fixes apps_smmu
failing to probe when running at EL2 (expects 96 context interrupts)

Fixes: 892d5395396d ("arm64: dts: qcom: sm8450: add smmu nodes")
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 5a98f2aad7099..aef8b6814cda0 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -1076,7 +1076,7 @@ apps_smmu: iommu@15000000 {
 			compatible = "qcom,sm8450-smmu-500", "arm,mmu-500";
 			reg = <0 0x15000000 0 0x100000>;
 			#iommu-cells = <2>;
-			#global-interrupts = <2>;
+			#global-interrupts = <1>;
 			interrupts =    <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
@@ -1163,6 +1163,7 @@ apps_smmu: iommu@15000000 {
 					<GIC_SPI 412 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 707 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 690 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.26.1

