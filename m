Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC7E4FDE76
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343715AbiDLLwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 07:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355021AbiDLLtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:49:09 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62FFF67;
        Tue, 12 Apr 2022 03:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649759553; x=1681295553;
  h=from:to:cc:subject:date:message-id;
  bh=MMIUO1AN7gN05AzZCun/kXzznO7BJ9UyKv14hpLUruU=;
  b=p0d/Zx108iEl4D63i2ebDkuQp/QO9gO9orIW5Pay78JrPzuLZoLZxbRB
   KRWBthGIdWJjyTyPohCbej2NNxtIgSlVtr85yt/hdcLWbNNuiwCDOAAYW
   s6SCqstHOge8Em5Mg3BRsoemHX79ctnmokY6qKLtCWwPEMv6g6gaJYvAT
   E=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 12 Apr 2022 03:32:33 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 12 Apr 2022 03:32:30 -0700
X-QCInternal: smtphost
Received: from c-sbhanu-linux.qualcomm.com ([10.242.50.201])
  by ironmsg01-blr.qualcomm.com with ESMTP; 12 Apr 2022 16:02:11 +0530
Received: by c-sbhanu-linux.qualcomm.com (Postfix, from userid 2344807)
        id 934595963; Tue, 12 Apr 2022 16:02:10 +0530 (IST)
From:   Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org
Cc:     quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sartgarg@quicinc.com, quic_nitirawa@quicinc.com,
        quic_sayalil@quicinc.com,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Subject: [PATCH V4 0/2] Add reset entries for SDCC controllers
Date:   Tue, 12 Apr 2022 16:02:06 +0530
Message-Id: <1649759528-15125-1-git-send-email-quic_c_sbhanu@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Changes since V3:
	- Removed reset-names from bindings and DT file as suggested by
	  Stephen Boyd.
	- Removed comments for resets as suggested by Stephen Boyd.

Changes since V2:
	- Updated commit subject and comments in dtsi file.
	- Added resets entry in sdhci-msm dt-bindings.

Changes since V1:
	- Updated commit message, subject and comments in dtsi file as
	  suggested by Krzysztof Kozlowski.

Shaik Sajida Bhanu (2):
  dt-bindings: mmc: sdhci-msm: Add gcc resets strings
  arm64: dts: qcom: sc7280: Add reset entries for SDCC controllers

 Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 5 +++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi                | 4 ++++
 2 files changed, 9 insertions(+)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

