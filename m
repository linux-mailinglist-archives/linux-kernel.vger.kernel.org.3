Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465154CB865
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 09:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiCCIJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 03:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiCCIJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 03:09:27 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DA45FD2;
        Thu,  3 Mar 2022 00:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646294923; x=1677830923;
  h=from:to:cc:subject:date:message-id;
  bh=+bYsDhgswS3zG/uB6uGZaEGIcMgyRUKoKz7L41FkkoU=;
  b=eBd+JUU/IFx27mV61HRhVB1S1O1NYmYrWWhgP7RZHgaiUanCsPQrf5D+
   qnqjkac1cXfKMEoxnl6vrfGBtVkMgnQwlwDKcO5+7nLW1+OBtgpcoH58Z
   /F48J7OwkOvSahSFVTYQDZs91KSVGUn4jqCZah7lbil+P52GY1SQE46oC
   g=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 03 Mar 2022 00:08:43 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 03 Mar 2022 00:08:41 -0800
X-QCInternal: smtphost
Received: from vpolimer-linux.qualcomm.com ([10.204.67.235])
  by ironmsg02-blr.qualcomm.com with ESMTP; 03 Mar 2022 13:38:29 +0530
Received: by vpolimer-linux.qualcomm.com (Postfix, from userid 463814)
        id 166B64E1B; Thu,  3 Mar 2022 13:38:28 +0530 (IST)
From:   Vinod Polimera <quic_vpolimer@quicinc.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_kalyant@quicinc.com
Subject: [PATCH v3 0/3] Update mdp clk to max supported value to support higher refresh rates
Date:   Thu,  3 Mar 2022 13:38:21 +0530
Message-Id: <1646294904-4753-1-git-send-email-quic_vpolimer@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*** BLURB HERE ***

Vinod Polimera (3):
  arm64/dts/qcom/sc7280: remove assigned-clock-rate property for mdp clk
  arm64/dts/qcom/sc7180: remove assigned-clock-rate property for mdp clk
  arm64/dts/qcom/sdm845: remove assigned-clock-rate property for mdp clk

 arch/arm64/boot/dts/qcom/sc7180.dtsi | 9 ++-------
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 9 ++-------
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 9 ++-------
 3 files changed, 6 insertions(+), 21 deletions(-)

-- 
2.7.4

