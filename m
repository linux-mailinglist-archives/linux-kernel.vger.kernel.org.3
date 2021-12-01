Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 570AF464818
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347358AbhLAH24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:28:56 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:53376 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347296AbhLAH2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:28:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C12C6CE0AC6;
        Wed,  1 Dec 2021 07:25:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE94C53FAD;
        Wed,  1 Dec 2021 07:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638343525;
        bh=yxpQQ4UFKlKKI9HULM9ODFXQndz4oDaQeszOggpoAHI=;
        h=From:To:Cc:Subject:Date:From;
        b=AVFRRoBrkCMks1T0wCzoq4yF/kvKpMFv/xNUioaJ6/KO0h8sLLTDpw+EL3mSjvOl5
         Q4iXs8zxFMRo+MSUuXve+TR3ljQbTu+ji9bm4eoCJ57pilhaD54p5IbP/KEEc7RsDx
         /XAPPE8nrDKmSK0h9TYcRznmiTFvgaJNwVpADBRJ5vXM65KwyIjVkxwya7stwV9322
         Yxwkjj1o95c3VS8vjnYKr8GxkQ/1965D2Krm3JPKfQkcOihRf1X3ynqEO0Re8y9j9i
         W7527lMNMeGacCR94BphRv9M9s9NDrWKndVRsXvSdR+Nr0KcIIL/DqjGCGEUhox87d
         KcJwtWIPlcieg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 0/2] regulator: qcom,rpmh: Add support for PM8450
Date:   Wed,  1 Dec 2021 12:55:13 +0530
Message-Id: <20211201072515.3968843-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This add the binding and driver update to support the PM8450 which is found
in SM8450 platform

Vinod Koul (2):
  regulator: qcom,rpmh: Add compatible for PM8450
  regulator: qcom-rpmh: Add support for PM8450 regulators

 .../regulator/qcom,rpmh-regulator.yaml         |  2 ++
 drivers/regulator/qcom-rpmh-regulator.c        | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

-- 
2.31.1

