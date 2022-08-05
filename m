Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B1458A8BE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 11:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237022AbiHEJXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 05:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240264AbiHEJXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 05:23:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB61478201;
        Fri,  5 Aug 2022 02:23:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 647FDB8285C;
        Fri,  5 Aug 2022 09:23:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F4DC43151;
        Fri,  5 Aug 2022 09:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659691399;
        bh=2z6kLjTnIFxpkN2jRIF3jLC49t4msD6VHl4Ik60e4Cw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IiwZGeBodikZ+pDjD6x3/vpKAGqQpO3nNSyYsBsl1lP9Y4d2VEgpFqO2zKSY++rrq
         BVCCO0YNXxsFJzhiQbFXLGnRUb/l6frLCOz5UHczuTKw5YrNWYdq/gk3QTDHQqHKNZ
         9+NFpamLH3l1xgjVbpje1u0L92z+Xq+hP1l8H3iuc2aUxJqaMeOa+88fXz5lhyQmjB
         BJHBoi/makEBChT2DoC+oVFAzmNxfKhN7KRhlBw7szKV2uzpEXLdSL1BT4OUpHfgsr
         ptdt7fho4OkSY/g7qQ/sn6JkED4crBim0IU4x3R4OHOiowHPyWa1rO17pV8EFItywn
         5byZ7QAJj/njw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oJtYW-0001JO-61; Fri, 05 Aug 2022 11:23:44 +0200
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
Subject: [PATCH 6/7] arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13s: mark HID wakeup sources
Date:   Fri,  5 Aug 2022 11:23:16 +0200
Message-Id: <20220805092317.4985-7-johan+linaro@kernel.org>
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

The touchpad and keyboard can wake the system from suspend so declare
them as wakeup sources.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 76ba2d5fa17e..1ca72f6ba55a 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -221,6 +221,8 @@ touchpad@2c {
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&tpad_default>;
+
+		wakeup-source;
 	};
 
 	keyboard@68 {
@@ -233,6 +235,8 @@ keyboard@68 {
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&kybd_default>;
+
+		wakeup-source;
 	};
 };
 
-- 
2.35.1

