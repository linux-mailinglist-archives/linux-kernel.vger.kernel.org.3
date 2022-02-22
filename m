Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAA34BF1BD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 06:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiBVF4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 00:56:05 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiBVF4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 00:56:03 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2A61EEFA;
        Mon, 21 Feb 2022 21:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645509338; x=1677045338;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=NV8rZHzLSOto6tRaqGUmGrRNZg1oOffyFmck+5z8iUY=;
  b=HPhO+riWaJKSYXJGBm4JxkkbJ8CXhr4uUfwWVEXPucfdLE/5dC4rU2Sw
   jz2fBkA3aQ7Iezr+fEgFBw8oVScDeM/QeJeHR+NNha7q+5ipHH3dOmUl1
   a3+kGFl5qn/53jSDJ2/80kY2bowntus9mOUz5UMXaqBhJWuWwF+JwgebI
   U=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 21 Feb 2022 21:55:38 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 21:55:38 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 21 Feb 2022 21:55:37 -0800
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 21 Feb 2022 21:55:33 -0800
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>
CC:     Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "Doug Anderson" <dianders@chromium.org>,
        Satya Priya <quic_c_skakit@quicinc.com>
Subject: [PATCH V4 0/4] Add PM8350C PMIC PWM support for backlight
Date:   Tue, 22 Feb 2022 11:25:05 +0530
Message-ID: <1645509309-16142-1-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series depends on [1], which adds driver for Qualcomm LPG.

[1] https://patchwork.kernel.org/project/linux-arm-msm/list/?series=615848

Satya Priya (4):
  dt-bindings: leds: Add pm8350c pmic support
  leds: Add pm8350c support to Qualcomm LPG driver
  arm64: dts: qcom: pm8350c: Add pwm support
  arm64: dts: qcom: Enable pm8350c pwm for sc7280-idp2

 Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml |  1 +
 arch/arm64/boot/dts/qcom/pm8350c.dtsi                     |  7 +++++++
 arch/arm64/boot/dts/qcom/sc7280-idp2.dts                  |  4 ++++
 drivers/leds/rgb/leds-qcom-lpg.c                          | 13 +++++++++++++
 4 files changed, 25 insertions(+)

-- 
2.7.4

