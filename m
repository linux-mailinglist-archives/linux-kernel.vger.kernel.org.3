Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20C7491392
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244146AbiARBi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244052AbiARBiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:38:17 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD080C061574;
        Mon, 17 Jan 2022 17:38:16 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 15so39678607edx.9;
        Mon, 17 Jan 2022 17:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g+sL8MJUVFSLlqzbEi0bJU0Ptqral5tkM/Cwy/Wus0w=;
        b=TqhRWDBXx1AJ0WLjQ2JwHldaVFPN2aV0Fc8CPWq/YoQrnz8dkZbqUuSvUIKhg00EQa
         01/8YOxMwTK+8SqTvGEvxWIbYgrlPk8raumJJg8EiaWkxTUEkIpgXHtdI4i09hz/RtDi
         qJnyg6xoq0QCJCTuDipcieJZCFeyM9uuCUQMUjJLyy3mxIZq/HVjQ1/43NCrIEh6N4Rt
         rkA/fFG/r1a7t0k7r3iQ/yxcbNuiuChrDuVRrzhVl6vmgRfmbwIs+aK+/CWMTdfxrqEw
         jiz3B2usPGxvHaIuYAF6rnToKcOuJqwE41aKM7kvdrMrvpbEiPdeKztDVk5eD6HzADvz
         0SpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g+sL8MJUVFSLlqzbEi0bJU0Ptqral5tkM/Cwy/Wus0w=;
        b=uuPPGDLtK9Fl/LPQRj8a1XWtrywpO1GMNbcdxdxRRh+NRaGcZnF1gtSmxUHCzdykgJ
         ZXeqwfAOVneNfuvAGTlsO64YhKuUEfz+qjUkWwofuKVTjHhC/0OKVtDpPEjvoC2AVdZW
         OtLYu4skPMxcOZRGyIbtwMeBsfk3nLiB6V9kxFsJ9DWDTmNLTTrk+H4qhmMnoG2nhJrH
         pYWnorRxq3/k4890lZnQU1KLoQSf/j/ObcynUGNfMz/m4dONezQc+eHKtndIWVwJC7J5
         D6wrCG+HP8dz/qYJJdE6NyIXtNZCtCEbX0/l//Ou3EcnDAaAo6MJQ9w8Yy01uS4Nfdey
         Gr7Q==
X-Gm-Message-State: AOAM533TAoHMY5avbogQJq0QXWKtE646kOGW5TkxceZ4AzFxN+WPf0Gp
        BcAZLxOXdwJ4/FNO8x/FUgE=
X-Google-Smtp-Source: ABdhPJwVfOeRDyedDBCNhuYt2BfBiKHrYOzTXqbX6s+Vv5LXLMFaRHidceTn+jFhYLS33cXBKXqmPg==
X-Received: by 2002:a17:906:c08c:: with SMTP id f12mr18458734ejz.419.1642469895160;
        Mon, 17 Jan 2022 17:38:15 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id kj18sm3990675ejc.139.2022.01.17.17.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 17:38:14 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH 06/17] ARM: dts: qcom: reduce pci IO size to 64K for ipq8064
Date:   Tue, 18 Jan 2022 02:20:36 +0100
Message-Id: <20220118012051.21691-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220118012051.21691-1-ansuelsmth@gmail.com>
References: <20220118012051.21691-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current value for pci IO is problematic for ath10k wifi card
commonly connected to ipq8064 SoC.
The current value is probably a typo and is actually uncommon to find
1MB IO space even on a x86 arch. Also with recent changes to the pci
driver, pci1 and pci2 now fails to function as any connected device
fails any reg read/write. Reduce this to 64K as it should be more than
enough and 3 * 64K of total IO space doesn't exceed the IO_SPACE_LIMIT
hardcoded for the ARM arch.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 441309bb64c8..c8763997e0f7 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -904,7 +904,7 @@ pcie0: pci@1b500000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x81000000 0 0x0fe00000 0x0fe00000 0 0x00100000   /* downstream I/O */
+			ranges = <0x81000000 0 0x0fe00000 0x0fe00000 0 0x00010000   /* downstream I/O */
 				  0x82000000 0 0x08000000 0x08000000 0 0x07e00000>; /* non-prefetchable memory */
 
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
@@ -955,7 +955,7 @@ pcie1: pci@1b700000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x81000000 0 0x31e00000 0x31e00000 0 0x00100000   /* downstream I/O */
+			ranges = <0x81000000 0 0x31e00000 0x31e00000 0 0x00010000   /* downstream I/O */
 				  0x82000000 0 0x2e000000 0x2e000000 0 0x03e00000>; /* non-prefetchable memory */
 
 			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
@@ -1006,7 +1006,7 @@ pcie2: pci@1b900000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x81000000 0 0x35e00000 0x35e00000 0 0x00100000   /* downstream I/O */
+			ranges = <0x81000000 0 0x35e00000 0x35e00000 0 0x00010000   /* downstream I/O */
 				  0x82000000 0 0x32000000 0x32000000 0 0x03e00000>; /* non-prefetchable memory */
 
 			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.33.1

