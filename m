Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04119516D10
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 11:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384097AbiEBJLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 05:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352964AbiEBJKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 05:10:33 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EE7101EF;
        Mon,  2 May 2022 02:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651482425; x=1683018425;
  h=from:to:cc:subject:date:message-id;
  bh=HQG74NJRhQ+XyNcexY0rYhzhOkUH/q42PoZmlkKsxG0=;
  b=wEqzgqJfVy/jj7h9IKTGCzPQjeduOUEHkGL16+PT9drMWHHudisZt2Fs
   A/m/yaUUPIoUXwQRtHUbNApafwH2GofK790tnuuP15PAdcwuJENLXP86q
   XEqg+Kk2X/+X9HpLVCHJlCWWjoJsJQRi0jMB0f4jOXlQ+EKXKinLy2j1P
   E=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 02 May 2022 02:07:03 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 02 May 2022 02:07:01 -0700
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg02-blr.qualcomm.com with ESMTP; 02 May 2022 14:36:43 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 40B7E3BE1; Mon,  2 May 2022 14:36:42 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v2 0/4] Devicetree updates for Interconnect, USB3 and PHY support
Date:   Mon,  2 May 2022 14:36:31 +0530
Message-Id: <1651482395-29443-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds the devicetree nodes to support the interconnect, USB3 and PHY support.

Changes from v1:
 - Addressed Krzysztof's comments.
 - Rebased on top of 5.18-rc5.

Thanks,
Rohit.

Rohit Agarwal (4):
  ARM: dts: qcom: sdx65: Add interconnect nodes
  dt-bindings: usb: qcom,dwc3: Add binding for SDX65
  ARM: dts: qcom: sdx65: Add USB3 and PHY support
  ARM: dts: qcom: sdx65-mtp: Enable USB3 and PHY support

 .../devicetree/bindings/usb/qcom,dwc3.yaml         |   1 +
 arch/arm/boot/dts/qcom-sdx65-mtp.dts               |  29 +++++-
 arch/arm/boot/dts/qcom-sdx65.dtsi                  | 108 +++++++++++++++++++++
 3 files changed, 134 insertions(+), 4 deletions(-)

-- 
2.7.4

