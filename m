Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51AA44DCA83
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbiCQPvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235062AbiCQPvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:51:06 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28849A990;
        Thu, 17 Mar 2022 08:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647532190; x=1679068190;
  h=from:to:cc:subject:date:message-id;
  bh=dQspgOQe8R6aBy50ayGKKroELAHAvWCjWGvNGhlXm0k=;
  b=QESZiVK7Yl6GRoF4NVzcLffpYlPfLn0Rl2qlTpiWRQUjUeZ3sL6+atKM
   sQS6gs5tMedWdBnxUhDeTgo6WtOgAIE7R129FCiLPkAc4wgowSskKhEsk
   HlfUxkVAoeh4I8nx8pdWGC2yIMJ1W991lomgqTHHBAuQI9Dxoua3qTMYr
   E=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 17 Mar 2022 08:49:49 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 17 Mar 2022 08:49:47 -0700
X-QCInternal: smtphost
Received: from c-sbhanu-linux.qualcomm.com ([10.242.50.201])
  by ironmsg02-blr.qualcomm.com with ESMTP; 17 Mar 2022 21:19:28 +0530
Received: by c-sbhanu-linux.qualcomm.com (Postfix, from userid 2344807)
        id 87B7B4CAF; Thu, 17 Mar 2022 21:19:27 +0530 (IST)
From:   Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org
Cc:     quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sartgarg@quicinc.com, quic_nitirawa@quicinc.com,
        quic_sayalil@quicinc.com,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Subject: [PATCH V3 0/2] Add reset entries for SDCC controllers
Date:   Thu, 17 Mar 2022 21:19:23 +0530
Message-Id: <1647532165-6302-1-git-send-email-quic_c_sbhanu@quicinc.com>
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

Changes since V2:
	- Updated commit subject and comments in dtsi file.
	- Added resets entry in sdhci-msm dt-bindings.

Changes since V1:
	- Updated commit message, subject and comments in dtsi file as
	  suggested by Krzysztof Kozlowski.

Shaik Sajida Bhanu (2):
  dt-bindings: mmc: sdhci-msm: Add gcc resets strings
  arm64: dts: qcom: sc7280: Add reset entries for SDCC controllers

 Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 4 ++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi                | 8 ++++++++
 2 files changed, 12 insertions(+)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

