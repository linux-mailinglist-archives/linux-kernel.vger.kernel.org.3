Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E2658A75E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 09:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240219AbiHEHpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 03:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235706AbiHEHpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 03:45:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38F663B8;
        Fri,  5 Aug 2022 00:45:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B420B82759;
        Fri,  5 Aug 2022 07:45:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C3CC433D6;
        Fri,  5 Aug 2022 07:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659685502;
        bh=1PTV6BUxFKhS7tDLJA42w4aPezXS3cLAXgtgcOiJYV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BJmBTPj3Vs/7Eof9/Z4kgx3aeS5ndr4rSoJ6CQVsH0rBEUDxL1oZ4JBEYSaS54xpJ
         G7BoT3dkNvxa6K8sI+QrfNtedbBVAV3f4zTh1vIFwIvZWYHkHbjBFcgvZTShaNyKy0
         4toGqZCr+BMhrBPuXgh0YRl+Gv9FGrMdlsPgVLCJZvzag6BoCTspo5ThOskHM5anAc
         7x3eUbJ4JmRJvhBJnKdjK2Pc936Q4/BSLoBIkAwP2V/M2iCiw/VWdUkgEbGz3CbgmL
         zGzHNvoPmS2ATq2Puv/q8XDbooeBAJ4qYYWMyqfkphcCgQaWl6tlo/E+xkk9GTZbax
         yIoeDXFgGdnZQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oJs1O-0005aj-4K; Fri, 05 Aug 2022 09:45:26 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 2/2] usb: dwc3: qcom: clean up icc init
Date:   Fri,  5 Aug 2022 09:45:00 +0200
Message-Id: <20220805074500.21469-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220805074500.21469-1-johan+linaro@kernel.org>
References: <20220805074500.21469-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the interconnect-initialisation helper by increasing
indentation of (or merging) continuation lines and adding brackets
around multi-line blocks in order to improve readability.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/usb/dwc3/dwc3-qcom.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 196efa9f2545..f2ff4fe1490a 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -253,7 +253,7 @@ static int dwc3_qcom_interconnect_init(struct dwc3_qcom *qcom)
 	qcom->icc_path_ddr = of_icc_get(dev, "usb-ddr");
 	if (IS_ERR(qcom->icc_path_ddr)) {
 		dev_err(dev, "failed to get usb-ddr path: %ld\n",
-			PTR_ERR(qcom->icc_path_ddr));
+				PTR_ERR(qcom->icc_path_ddr));
 		return PTR_ERR(qcom->icc_path_ddr);
 	}
 
@@ -265,20 +265,19 @@ static int dwc3_qcom_interconnect_init(struct dwc3_qcom *qcom)
 	}
 
 	max_speed = usb_get_maximum_speed(&qcom->dwc3->dev);
-	if (max_speed >= USB_SPEED_SUPER || max_speed == USB_SPEED_UNKNOWN)
+	if (max_speed >= USB_SPEED_SUPER || max_speed == USB_SPEED_UNKNOWN) {
 		ret = icc_set_bw(qcom->icc_path_ddr,
-			USB_MEMORY_AVG_SS_BW, USB_MEMORY_PEAK_SS_BW);
-	else
+				USB_MEMORY_AVG_SS_BW, USB_MEMORY_PEAK_SS_BW);
+	} else {
 		ret = icc_set_bw(qcom->icc_path_ddr,
-			USB_MEMORY_AVG_HS_BW, USB_MEMORY_PEAK_HS_BW);
-
+				USB_MEMORY_AVG_HS_BW, USB_MEMORY_PEAK_HS_BW);
+	}
 	if (ret) {
 		dev_err(dev, "failed to set bandwidth for usb-ddr path: %d\n", ret);
 		return ret;
 	}
 
-	ret = icc_set_bw(qcom->icc_path_apps,
-		APPS_USB_AVG_BW, APPS_USB_PEAK_BW);
+	ret = icc_set_bw(qcom->icc_path_apps, APPS_USB_AVG_BW, APPS_USB_PEAK_BW);
 	if (ret) {
 		dev_err(dev, "failed to set bandwidth for apps-usb path: %d\n", ret);
 		return ret;
-- 
2.35.1

