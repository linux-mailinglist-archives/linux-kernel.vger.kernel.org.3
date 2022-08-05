Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD7258A8C0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 11:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240555AbiHEJXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 05:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237869AbiHEJXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 05:23:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558B778203;
        Fri,  5 Aug 2022 02:23:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05E4CB8285A;
        Fri,  5 Aug 2022 09:23:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99349C43145;
        Fri,  5 Aug 2022 09:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659691399;
        bh=xfjyRRCXzzCzBzpor87xc8JJpDRO1zj71SbBmtHDyb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=miKvhm3Ie669U/JDPfQlzw9s7YQ72rTd9mtTmx0ubWW4i1hyTgsf0iyZ7TyaaqmA7
         nxn4DtmEcBjsVnzfYLELntOeR+T8oYRRAc+dw7yeYTYuyAITKO1of+ips4BwHtY6s2
         OWvoo4O15TX+ki+4FzOrf3G1Loe0wsY5RrXE86g8JB1kEO+nIIAJIqxH/jMEPf2j7J
         sx/xycFYxY6VwfNYIzXHg2bZGG/57p4hPP11Jd2V8xrjxiRR+mnWV6+p7561lCBEhu
         WAdxBVf0bOkgGYByChxezrHkjWwrZ7tosTVj11Y2k4/gU5KlZpZfZ+Y+v6TEBD97/x
         DzzWJLFf+XnRQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oJtYV-0001JI-W9; Fri, 05 Aug 2022 11:23:44 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 4/7] arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13s: disable touchscreen pull-up
Date:   Fri,  5 Aug 2022 11:23:14 +0200
Message-Id: <20220805092317.4985-5-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220805092317.4985-1-johan+linaro@kernel.org>
References: <20220805092317.4985-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The (optional) touchscreen interrupt line has an external pull-up so
disable the internal one as is done for the keyboard and touchpad.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 562b4458e039..85efce641a4e 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -363,7 +363,7 @@ ts0_default: ts0-default-state {
 		int-n {
 			pins = "gpio175";
 			function = "gpio";
-			bias-pull-up;
+			bias-disable;
 		};
 
 		reset-n {
-- 
2.35.1

