Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB4B46E490
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 09:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbhLIIwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 03:52:32 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:35576 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhLIIwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 03:52:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BB835CE24D8;
        Thu,  9 Dec 2021 08:48:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DDAC004DD;
        Thu,  9 Dec 2021 08:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639039734;
        bh=lG4lqZaEnao5a4aBqePd2BJGog2W1dG/HtW0GYw9qPM=;
        h=From:To:Cc:Subject:Date:From;
        b=mjvVPPZ/uZc6q2DVux4ErdyvoWUsC2onQZZoLOpSLScQE5gZ0A7jjC5vDllGo81YA
         mmYzhVyXFBd7Oe6/ZtLunI7vNsX5TvoM0he9t4nC71rA2pgOFfrfkEHkE39A3PCwhC
         o6d6LVvZC3XPOxR5V6YS3Wt0cuXfUxRq9ulnu1VYnz9CjHU6xQthIxWD074FFTPxbU
         IE75dCI6ER3aREtCqHYwbWHfkrde9+z+sDk1k4qhddrfK3Mnt+QJbLwaee4Oo9Q5VQ
         dgZHqQQWUc+ub0KaBKiseToOzaW4fMLQktVUPlXDU2Ia1t6Q+3Los1758W6ndKDmgl
         jlTejXzaH35Bg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Georgi Djakov <djakov@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>, viveka@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Add interconnect support for SM8450
Date:   Thu,  9 Dec 2021 14:18:40 +0530
Message-Id: <20211209084842.189627-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This add device tree binding and driver for interconnect providers found in
SM8450 SoC.

Changes in v3:
 - send the correct patches, few changes were in patch 2 instead of patch 1

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

