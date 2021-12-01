Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F5E464822
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347292AbhLAH3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240532AbhLAH3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:29:30 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE38BC061574;
        Tue, 30 Nov 2021 23:26:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 15A7FCE0AC6;
        Wed,  1 Dec 2021 07:26:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D081C53FAD;
        Wed,  1 Dec 2021 07:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638343566;
        bh=m/JGWPAjw7IIsjt3w+G4W+Sl5P/nIb9gShr168yUxCE=;
        h=From:To:Cc:Subject:Date:From;
        b=cgiRXusJYuJOu6W59HKxj7D4hGTzqxB3s0mY2sjH5UelfnH2K//VzFTjnC7zRdjXd
         ECAMyxVho0x12wWNiYxn/8OqWBeiA+Qm6rHcTRi2L+TCTL3h3HFBGBkROf5niv32Je
         01HfY8AwzZoCck2ssR49XPPg0svXewUC/6E7AfMhVvS4cSirrAIB/mUyGy594T/1y+
         40mOUBFSVwxXQEl55mKhvGKBBNPSNCB6chOfyirnY8vG3yXMLz33y/BSORoJPweTu/
         1c5uWbwHsHVmIWpvTz1SDSukXZYLw6foA4mVCG1p43SSY6tj0v3ZzEZxUXF8+H8NSb
         qIuN3aYoP2AlQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Georgi Djakov <djakov@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add interconnect support for SM8450
Date:   Wed,  1 Dec 2021 12:55:55 +0530
Message-Id: <20211201072557.3968915-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This add device tree binding and driver for interconnect providers found in
SM8450 SoC.

Vinod Koul (2):
  dt-bindings: interconnect: Add Qualcomm SM8450 DT bindings
  interconnect: qcom: Add SM8450 interconnect provider driver

 .../bindings/interconnect/qcom,rpmh.yaml      |   11 +
 drivers/interconnect/qcom/Kconfig             |    9 +
 drivers/interconnect/qcom/Makefile            |    2 +
 drivers/interconnect/qcom/sm8450.c            | 1988 +++++++++++++++++
 drivers/interconnect/qcom/sm8450.h            |  169 ++
 .../dt-bindings/interconnect/qcom,sm8450.h    |  171 ++
 6 files changed, 2350 insertions(+)
 create mode 100644 drivers/interconnect/qcom/sm8450.c
 create mode 100644 drivers/interconnect/qcom/sm8450.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sm8450.h

-- 
2.31.1

