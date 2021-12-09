Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F1546E325
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 08:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbhLIH0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 02:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbhLIH0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 02:26:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068A3C0617A1;
        Wed,  8 Dec 2021 23:23:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C43C2B823C2;
        Thu,  9 Dec 2021 07:23:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C254C341C8;
        Thu,  9 Dec 2021 07:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639034581;
        bh=rSW675GEEHzgpyGcUELORk6fFIYbBlwxF84ODxVvsZY=;
        h=From:To:Cc:Subject:Date:From;
        b=rcXf27U3U4J8SlR1UurnnqzenR8fOOyPTVoFFK0swifEF1THOqt3QJyy+UeOheaaO
         HtH4fPQ628DAm+sXT8pSNI6/hsqp6ED6eYvLeHGNTEdd1WF7m4cNkoc/gR+HEVXr62
         Oq88dUmz1fP1/3K3lwsHHdHS5P7L60jW5i1Qgu0N/w4xCuNUmpAJcioCocsDrg4wuC
         4x2rG8LDBtkM8DoahG8xGQqLPkqNjUmvceoACfenFfDlOqHUmqOJCICim2E1YzFAC1
         AdQQ/U/mcQdHfWigjHecV8Rm4oah5a0FCYt2WaF6YBE795nuKuKs6PsKYD3yhlCSG6
         tr2NfItXqXyvg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Georgi Djakov <djakov@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>, viveka@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Add interconnect support for SM8450
Date:   Thu,  9 Dec 2021 12:52:49 +0530
Message-Id: <20211209072251.185634-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This add device tree binding and driver for interconnect providers found in
SM8450 SoC.

Changes in v2:
 - remove sync state call
 - Make dt binding dual license
 - Fix the indexes to start from 0

Vinod Koul (2):
  dt-bindings: interconnect: Add Qualcomm SM8450 DT bindings
  interconnect: qcom: Add SM8450 interconnect provider driver

 .../bindings/interconnect/qcom,rpmh.yaml      |   11 +
 drivers/interconnect/qcom/Kconfig             |    9 +
 drivers/interconnect/qcom/Makefile            |    2 +
 drivers/interconnect/qcom/sm8450.c            | 1987 +++++++++++++++++
 drivers/interconnect/qcom/sm8450.h            |  169 ++
 .../dt-bindings/interconnect/qcom,sm8450.h    |  171 ++
 6 files changed, 2349 insertions(+)
 create mode 100644 drivers/interconnect/qcom/sm8450.c
 create mode 100644 drivers/interconnect/qcom/sm8450.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sm8450.h

-- 
2.31.1

