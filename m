Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D004913A6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244332AbiARBil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244247AbiARBiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:38:21 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5F6C06174E;
        Mon, 17 Jan 2022 17:38:20 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id k15so72768909edk.13;
        Mon, 17 Jan 2022 17:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FLS4CFc8OraobP2F69gl9kvDiXrI/Uu58GgwSlFhco8=;
        b=nPgrGFi+fwr4yzLPWf7V8wjTHEzYydNH2oc7GPtPjr8wSgzZHkaronGYrfjAwhMstg
         hlduukDzF7w3DWT8hGAhN2uq4Hod9ne3gpALarYb7IhnU6/zmFH7T5rRJ+iTgefZz0xD
         sa1FiWndYMf5GBQu/9j/IzrAvm2ZcxkMukdFWub66ii5TWwuZTQbPVdniWmOPeQmy8Uu
         QUfzmbMKPR2y/STKaPnts2fJ1EvPzHrohhHaOHrYOyqTZZjUiic2B4WnPx6ANMcEjx22
         wfpAhtmlXsTngHAJIsGMi9Sj5k2Zs5c6xj0EW7yGGu5VglDNHM/TUWnpjsN4Yjjn+NJe
         GbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FLS4CFc8OraobP2F69gl9kvDiXrI/Uu58GgwSlFhco8=;
        b=YO6TaLyIgyl7GmeLxW4RL6FhsKca1mIG46RsgvrCM8E/yFkYEsGZBtRDLx9lu6Aaus
         MDL36MkFaI9tgKXZFluVbn+skC/4HciHgFL/EQC2oN8IKKkxnkE0PkwWoGAE30ND5AEx
         eLICRkueV0j6VsxohLeS1L9AwMS1d6Q9EY2vjjKg8qNg5Noll/N8sOHDp4HfW5ZYWRtK
         1iBFZ2kraIVsy7XtLRo+QrUXSs8vfWSZ1Yud+rCZqhNW/joOlokyV0Kywu8Gn3svJFOU
         iBJbdEXoo7XjX9FMvAwpqjrnZ6xJlt3v/8vbAv53Fn6ZMtb4TSxOl6vDG1CcWPHCgi82
         Mo+A==
X-Gm-Message-State: AOAM532bwgx0sFRsHTGLRLzQXS2BLSD52YZ8obI+/WoKbQpcm1cqQGsW
        2IXzoG1oRG3CnDhh7hyzRY0=
X-Google-Smtp-Source: ABdhPJx4eP7YafMvvOx4R2GUbSwa+vf6KqGoVup/EukwMmVL2LQfoplopdZYohzP9/lFxyd0Rd81ZQ==
X-Received: by 2002:a05:6402:42ce:: with SMTP id i14mr23140657edc.126.1642469898690;
        Mon, 17 Jan 2022 17:38:18 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id kj18sm3990675ejc.139.2022.01.17.17.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 17:38:18 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH 10/17] ARM: dts: qcom: add sic non secure node for ipq8064
Date:   Tue, 18 Jan 2022 02:20:40 +0100
Message-Id: <20220118012051.21691-11-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220118012051.21691-1-ansuelsmth@gmail.com>
References: <20220118012051.21691-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing sic non secure node for ipq8064.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index a45e4c799b27..b82beb297291 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -551,6 +551,11 @@ saw_l2: regulator@02012000 {
 			regulator;
 		};
 
+		sic_non_secure: sic-non-secure@12100000 {
+			compatible = "syscon";
+			reg = <0x12100000 0x10000>;
+		};
+
 		gsbi2: gsbi@12480000 {
 			compatible = "qcom,gsbi-v1.0.0";
 			cell-index = <2>;
-- 
2.33.1

