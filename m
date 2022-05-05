Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B1D51CC8C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 01:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386626AbiEEXSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 19:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237968AbiEEXSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 19:18:36 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D225DD1E
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 16:14:55 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x52so4826086pfu.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 16:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0kSQb2icz9EuOBfEIavY1Q/aWHO2riUJJut5MHkXzYQ=;
        b=S0Sy52a0le6z4xwOpfZmcEWeenlEQ8Ny5+NOsiV9S4WMz7U3/f+JzITvJnQltHt/fh
         W/ORtfNYaxnBYg5XBurxElcnewtdnmEM2batwjzyFoBv1i9xCVFhXsoUL764CUpEBAbh
         hAGapFLJLcwOGD1ZWZVT1v0J/duqNja6LRVUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0kSQb2icz9EuOBfEIavY1Q/aWHO2riUJJut5MHkXzYQ=;
        b=HUxreGzCYBk9y8YB+VlrpjsHf+0BBqhWvHKpf+8xgHixnmQQfqTWsYZAW9xp4bB1nm
         2phihsIFvv7zjVUbPQlkmqfu1viXaDAufX5xzd0KrjVlruT72heyHdinMB0jzFOs/1Fc
         wfLjYPZ0dWd5S2t4iFLW1NLtg5kGR+4gP+lPL+jtQqkJijJF8SS/hvp96a9DV7DQN/7r
         /Wnp9t/V9+XhSAPaQV06XeGPQy5pGqJeJqI+r33gNiSYadXG0XCKI0kSI6B6b7uDj+CZ
         wRPoIHagasCwDIVZHaBHQ8xnijMzWp3MpF6gktE5E6cPQ5/LBnmRRb4l6aajtVPWLRI1
         zNJQ==
X-Gm-Message-State: AOAM533sgy8noVp1J8rXzGb3NGb8dKFSOL5pjMarcdwWrmhVOFNl22V0
        1kF70JaPkqBNB5PymzeJR28f6g==
X-Google-Smtp-Source: ABdhPJz1Ia/6Uv5F5lGAd/5I0letqAwHCmGa5BKl/B4Z2msc8l/CSz4cY/+EbZgHTjJmPSiBnaxrlA==
X-Received: by 2002:a63:2317:0:b0:3c1:f437:2e7c with SMTP id j23-20020a632317000000b003c1f4372e7cmr351115pgj.351.1651792494626;
        Thu, 05 May 2022 16:14:54 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:b675:c6dd:f7f3:5454])
        by smtp.gmail.com with ESMTPSA id r20-20020aa79634000000b0050dc7a3e88asm1961946pfg.9.2022.05.05.16.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 16:14:54 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     swboyd@chromium.org, mka@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sc7280: Set SPI flash to 50 MHz for herobrine boards
Date:   Thu,  5 May 2022 16:14:30 -0700
Message-Id: <20220505161425.1.Icf6f3796d2fa122b4c0566d9317b461bfbc24b7f@changeid>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sc7280-herobrine based boards are specced to be able to access their
SPI flash at 50 MHz with the drive strength of the pins set at 8. The
drive strength is already set to 8 in "sc7280-herobrine.dtsi", so
let's bump up the clock. The matching firmware change for this is at:

https://review.coreboot.org/c/coreboot/+/63948

NOTE: the firmware change isn't _required_ to make the kernel work at
50 MHz, it merely shows that the boards are known to work fine at 50
MHz.

ALSO NOTE: this doesn't update the "sc7280-chrome-common.dtsi" file
which is used by both herobrine boards and IDP. At the moment the IDP
boards aren't configuring a drive strength of 8 and it seems safer to
just leave them at the slower speed if they're already working.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
index d58045dd7334..939d9e922834 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
@@ -452,6 +452,10 @@ &sdhc_2 {
 	cd-gpios = <&tlmm 91 GPIO_ACTIVE_LOW>;
 };
 
+&spi_flash {
+	spi-max-frequency = <50000000>;
+};
+
 /* Fingerprint, enabled on a per-board basis */
 ap_spi_fp: &spi9 {
 	pinctrl-0 = <&qup_spi9_data_clk>, <&qup_spi9_cs_gpio_init_high>, <&qup_spi9_cs_gpio>;
-- 
2.36.0.512.ge40c2bad7a-goog

