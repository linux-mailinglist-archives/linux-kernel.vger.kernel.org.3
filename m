Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438964A5D8E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 14:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238830AbiBANlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 08:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233939AbiBANlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 08:41:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D95C061714;
        Tue,  1 Feb 2022 05:41:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B3826158A;
        Tue,  1 Feb 2022 13:41:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00CCFC340EB;
        Tue,  1 Feb 2022 13:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643722878;
        bh=EWjMbz//JlI+XyJn8T2ZFTw89Y1fiVicPMm7V2N+ecA=;
        h=From:To:Cc:Subject:Date:From;
        b=WpRoTzwXfR8CnxzW+jit+x4xjg51kj48fbBtg9iXTU3J1r3pDGw24hUxw/9+OXvUz
         UnR2YsXT9hKeufaNIki239scvtvqZiAlPXvpJMe8pH1IsMk8ctvLcDddagnZmWBbpm
         I5rKxzKnRtIlGnkA5jDX4qjrDUrFIiQD6UR/vMwGs3NfgFWgoRjn3N7QGT55LA9CZb
         w2SHFpICmLMi55rb0beZNGa01k60cA5sT7mBkvXsUkmQQz92crGLrXg9rSnMixI+w9
         oU6Qvvmq/AyqQ9Qo107pCNHUmIT2yle+0R0RRQIDrQTDZpbJvjeMe/otUtApQfjbCd
         6D6WMKucA7W9A==
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        David Collins <quic_collinsd@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        David Dai <daidavid1@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] spmi: pmic-arb: Add support for PMIC v7
Date:   Tue,  1 Feb 2022 19:11:06 +0530
Message-Id: <20220201134108.2677578-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The is version 3 of support for PMIC v7. I have added a new property
qcom,bus-id for supporting v7 and then add driver changes for v7

This depends on yaml conversion patch:
https://lore.kernel.org/linux-arm-msm/20211227170151.73116-1-david@ixit.cz/

Changes since v2:
 - Drop yaml conversion patch
 - Fix author for spmi patch
Changes since v1:
 - Add yaml conversion patch and new binding
 - fix driver bug report by Jonathan

David Collins (1):
  spmi: pmic-arb: Add support for PMIC v7

Vinod Koul (1):
  dt-bindings: spmi: Add qcom,bus-id

 .../bindings/spmi/qcom,spmi-pmic-arb.yaml     |  11 +
 drivers/spmi/spmi-pmic-arb.c                  | 233 ++++++++++++++++--
 2 files changed, 225 insertions(+), 19 deletions(-)

-- 
2.31.1

