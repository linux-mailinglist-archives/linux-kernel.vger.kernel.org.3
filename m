Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2DF46483E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245536AbhLAHbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:31:32 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:54562 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbhLAHbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:31:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6165FCE1D73;
        Wed,  1 Dec 2021 07:28:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B043C53FCE;
        Wed,  1 Dec 2021 07:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638343688;
        bh=tm9IEPe2XuBzG12BvOfhYEl3fdl+uc1UkpPAUeGcQ/o=;
        h=From:To:Cc:Subject:Date:From;
        b=Htc5sMeQn3cqK7Ph8JfA1oD2DdUcc7VIMeBqlJG8No3GJw2zFhCrVfWtlDZC6JEIF
         CX0TgRwnYuWUosRVyZFn/fYHXHB+H2+h35/CJ5Ahzw9vf6EVt9GjsPtmNl1JsN0jFm
         SPc6Zc0mE1hA0EBbwsfmitX5sZtGWNXFkh5p/aCWgRQNpjBCqeaRtbOh0o1HpgLrpK
         jIZwLb4/TJJPXKxI9n+II1noj2WOpfFx4gxZIkAxcSUsmFVlMKuGR+AXufUueu5E6t
         3JKdpitR9ps/ai5ZhgZHRCtkBmcpce2dM4OK9oqxfOynD+wc726Lg4uwM9745hCj4r
         ILSx0i+c56Wow==
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] soc: qcom: Add support for SM8450
Date:   Wed,  1 Dec 2021 12:57:38 +0530
Message-Id: <20211201072745.3969077-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds CPU, SoC and board compatible followed by rpmpd support
for SM8450 and socinfo ID and update the smem processor count

Dmitry Baryshkov (4):
  soc: qcom: smem: Update max processor count
  dt-bindings: power: rpmpd: Add SM8450 to rpmpd binding
  soc: qcom: rpmhpd: Add SM8450 power domains
  soc: qcom: socinfo: add SM8450 ID

Vinod Koul (3):
  dt-bindings: arm: cpus: Add kryo780 compatible
  dt-bindings: firmware: scm: Add SM8450 compatible
  dt-bindings: arm: qcom: Document SM8450 SoC and boards

 .../devicetree/bindings/arm/cpus.yaml         |  1 +
 .../devicetree/bindings/arm/qcom.yaml         |  6 +++
 .../devicetree/bindings/firmware/qcom,scm.txt |  1 +
 .../devicetree/bindings/power/qcom,rpmpd.yaml |  1 +
 drivers/soc/qcom/rpmhpd.c                     | 52 +++++++++++++++++++
 drivers/soc/qcom/smem.c                       |  2 +-
 drivers/soc/qcom/socinfo.c                    |  1 +
 include/dt-bindings/power/qcom-rpmpd.h        | 15 ++++++
 8 files changed, 78 insertions(+), 1 deletion(-)

-- 
2.31.1

