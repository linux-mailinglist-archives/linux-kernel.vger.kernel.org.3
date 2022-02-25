Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D3B4C49DB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 16:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242517AbiBYP7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 10:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242502AbiBYP66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 10:58:58 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C12186439;
        Fri, 25 Feb 2022 07:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645804704; x=1677340704;
  h=from:to:cc:subject:date:message-id;
  bh=E4XxBpQBXLuj4MbZ3LD7ymC2c81X3fk/VbDiDUlgP90=;
  b=vhylmUz39F98+rg2AfpkJx/3WWFsy7Gsn58rzShRABI9QaGBdIdrp1q0
   bSeOUViwlhcdXGrcULpBYcddhDCHrpsUtCl9chOEp2aK4l5VaNHZoRuOM
   bjhPbvL9ISf9qCwKaqQyAOXbe5bzPW0NjNrLQelc84OQTXWEMW/aTC7Bp
   Y=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 25 Feb 2022 07:58:24 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 25 Feb 2022 07:58:22 -0800
X-QCInternal: smtphost
Received: from vpolimer-linux.qualcomm.com ([10.204.67.235])
  by ironmsg01-blr.qualcomm.com with ESMTP; 25 Feb 2022 21:28:10 +0530
Received: by vpolimer-linux.qualcomm.com (Postfix, from userid 463814)
        id 3FD9D53E9; Fri, 25 Feb 2022 21:28:09 +0530 (IST)
From:   Vinod Polimera <quic_vpolimer@quicinc.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_kalyant@quicinc.com
Subject: [PATCH v2 0/2] Update mdp clk to max supported value to support higher refresh rates
Date:   Fri, 25 Feb 2022 21:27:48 +0530
Message-Id: <1645804670-21898-1-git-send-email-quic_vpolimer@quicinc.com>
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

Vinod Polimera (2):
  arm64/dts/qcom/sc7280: remove assigned-clock-rate property for mdp clk
  drm/msm/disp/dpu1: set mdp clk to the maximum frequency in opp table

 arch/arm64/boot/dts/qcom/sc7280.dtsi    | 9 ++-------
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 3 +++
 2 files changed, 5 insertions(+), 7 deletions(-)

-- 
2.7.4

