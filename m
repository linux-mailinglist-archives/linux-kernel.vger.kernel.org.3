Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A355A49D712
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 02:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbiA0BAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 20:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234190AbiA0BAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 20:00:30 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381A8C06173B;
        Wed, 26 Jan 2022 17:00:30 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id e16so1239246qtq.6;
        Wed, 26 Jan 2022 17:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pLFwv7MjOQ+N54vrBm9216io6/o12k65yBVIhwcPg5Y=;
        b=UuXHtZj6naH5Qlpl7yYKAN24yAq91MwRMnrvc6+Msosu5VXeuPePja8bprAmpTnJrw
         T+lqZ5TdlgyRuucCAbFlhxmiq+ZiaoZQlgwdw14R6w0jORWFp1ecrt7ndXhU9uON7qS0
         netZb4cbt0tnQuHr+tfpp5SOj9hycUaRxFVZPjxYVmv8660d1jRsdS+nkyaOyp+0/5dr
         a6bN/RRQHLNwSRcqLkEiP1Bfd+4rN9QvK2qjfoxWRwsu7Vo/Kr/k2F+mGLwHQgokw88H
         9dXJmomYclZd91El57AwX7mHFLyRUyvtlvjjM7x9WQGrBqtiS/FF0Jnvwgo/VrsetF+D
         yyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pLFwv7MjOQ+N54vrBm9216io6/o12k65yBVIhwcPg5Y=;
        b=4Lu78Yuw2pw6mJTYAzuno20AAeHcPE4VV+IxTath8xWL1SuskkdIFyF5x2sX9qzowp
         6kmGSvH//K0ITtu9JQQ9YggW+6tvfiqkG7H/DZeI0Xr6k7FACr9fRPSXd3+rPIlcgtdw
         xcXm9OKNFLDz8k/DRKQObdnN3ADb3yh+OJUtfvBncsvrJ45w8wwgnzCi0GPF6Pg2wj+t
         Vu+IFxhv5kVBzr73RaXJjnSYkaDhRwKpVQA65o1evUr9ikSa6Ki9YmIzvuKEEfgN75iW
         XauJlfBbQQ539biw2sycotY4e3yukTuEjd0kINQfWfDHSCEXK+E8hs3Rk+9kUbyjFkg4
         OYwg==
X-Gm-Message-State: AOAM5325zzHAypFOaSxWl/tztlUTS94GeVBpIwN1dAzBI8ML8dF/ufjA
        18LcGMUEImpWXjGszQ/7xTemmrTrmZUBvQ==
X-Google-Smtp-Source: ABdhPJw4SPn8Gn9OXwDfQ5CSfiB8YgLmJ9SonumxylWB5ioKxx/YkkbJtMLfedEtEg4B15f82eguSQ==
X-Received: by 2002:a05:622a:181a:: with SMTP id t26mr1059867qtc.81.1643245229362;
        Wed, 26 Jan 2022 17:00:29 -0800 (PST)
Received: from master-x64.sparksnet (c-98-233-193-225.hsd1.dc.comcast.net. [98.233.193.225])
        by smtp.gmail.com with ESMTPSA id n2sm483389qti.59.2022.01.26.17.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 17:00:29 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: rockchip: add Quartz64-A pmu_io_domains
Date:   Wed, 26 Jan 2022 20:00:22 -0500
Message-Id: <20220127010023.3169415-3-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220127010023.3169415-1-pgwipeout@gmail.com>
References: <20220127010023.3169415-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several io power domains on the Quartz64-A operate at 1.8v.
Add the pmu_io_domains definition to enable support for this.
This permits the enablement of the following features:
sdio - wifi support
sdhci - mmc-hs200-1_8v

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
index d9eb92d59099..33c2c18caaa9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
@@ -482,6 +482,19 @@ vcc_sd_h: vcc-sd-h {
 	};
 };
 
+&pmu_io_domains {
+	pmuio1-supply = <&vcc3v3_pmu>;
+	pmuio2-supply = <&vcc3v3_pmu>;
+	vccio1-supply = <&vccio_acodec>;
+	vccio2-supply = <&vcc_1v8>;
+	vccio3-supply = <&vccio_sd>;
+	vccio4-supply = <&vcc_1v8>;
+	vccio5-supply = <&vcc_3v3>;
+	vccio6-supply = <&vcc1v8_dvp>;
+	vccio7-supply = <&vcc_3v3>;
+	status = "okay";
+};
+
 &sdhci {
 	bus-width = <8>;
 	mmc-hs200-1_8v;
-- 
2.25.1

