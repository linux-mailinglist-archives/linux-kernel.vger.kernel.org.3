Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 053CC469F0C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391285AbhLFPpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377864AbhLFP26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:28:58 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F0BC0698D6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 07:18:16 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id a9so23096171wrr.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 07:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+qJJaUGGfelfGcEnvCwsVEqDVlMxcACIbGxhhje7zmQ=;
        b=glIoQLOH4iRhQv9GbWfPsc6HlWo9A4bsP9ZXrFxYNcGfJEmfyVTqgKY0Gvtl5N9e6W
         eA3T0r97domCuDiHVzcrvpE0tTo9/ycTpKkH/fC8bG8AlYNlBgajMSPilZsOG2KLxZtd
         4cuWDl6+G11tQYNjl0nnFToYKm6g0Ot2dFvK+1USq7fKWRcprrNwQ0NNR2GGk2Hgtjbt
         WMVhceYUB+oLVsNxH/yo3GcGCSu5srP5nXFjYVq34E6vbsW6Ri+fchcUNfzVrlew2f5t
         H3DFdGdlTjoLB0EtDhS36SaVu2ZVx76jqi4INsdr5GOCH//tPHOlhnFZODpnL0gwIu0W
         9f8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+qJJaUGGfelfGcEnvCwsVEqDVlMxcACIbGxhhje7zmQ=;
        b=RQa2R9oZGD6SmQgXA76+qzacIbmzd4Ks8uN6nMzX2CX4SkqgQXJRBnG+ovOvA6F1jv
         3oVqzWFneJiTlH8TTLq0iUBN/Dcrw/UrO0dxKoJiMX29I9GnIcC/1UhqrGgY/0F+nCIl
         9aXXg+cGsQv+TaorNtHpGE7yefOPiUzqM5Mu0k7d6HhqMI38qbcO8dYcapz4Pj/Ji616
         hmPPATPZINQVRPT2wubSMaonJ4rPLRkc+2xCGUF0YwK2LMGdMFycOqLCCCj8dyrSLCoR
         Mcuh/jquF6M44JPWDlu3GZHgr6PlXnuJT4+xUd9gqRKpsupzCDZKIUepKAs1x/uBJKY2
         +ofg==
X-Gm-Message-State: AOAM5319Tgi01gKLsoldRVDEMOSJ8vWSRlDOU9fhyq1USQBz9GmuVOqd
        n3glUyawlSrSg+jTC2BFeccFMA==
X-Google-Smtp-Source: ABdhPJwa5CV2ZYbn7LsYzVvJ8cAuUtdDsip8eT/OjGDKB5wIglWaTkpPgBb3ctR8lQx7Ah89qZMYOA==
X-Received: by 2002:a05:6000:1862:: with SMTP id d2mr45042094wri.251.1638803894813;
        Mon, 06 Dec 2021 07:18:14 -0800 (PST)
Received: from xps7590.. (freifunk-gw.bsa1-cpe1.syseleven.net. [176.74.57.43])
        by smtp.gmail.com with ESMTPSA id t8sm11784871wrv.30.2021.12.06.07.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 07:18:14 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     robert.foss@linaro.org, todor.too@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, mchehab@kernel.org, robh+dt@kernel.org,
        angelogioacchino.delregno@somainline.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v4 0/2] Remove clock-lanes DT property from CAMSS
Date:   Mon,  6 Dec 2021 16:18:09 +0100
Message-Id: <20211206151811.39271-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v3:
 - Split patches heading for Media and ARM64 tress
   into two seperate series

Changes since v2:
 - Stephan: Rebased on v5.16-rc1
 - Stephan: Fixed 3/4 commit message title

Changes since v1:
 - Rob: Instead of documenting and fixing the use of the clock-lanes
   property, remove it, since it is is not programmable and
   therefore shouldn't be exposed in the DT.

Robert Foss (2):
  media: camss: csiphy: Move to hardcode CSI Clock Lane number
  media: dt-bindings: media: camss: Remove clock-lane property

 .../bindings/media/qcom,msm8916-camss.yaml    | 10 ---------
 .../bindings/media/qcom,msm8996-camss.yaml    | 20 ------------------
 .../bindings/media/qcom,sdm660-camss.yaml     | 20 ------------------
 .../bindings/media/qcom,sdm845-camss.yaml     | 17 ---------------
 .../qcom/camss/camss-csiphy-2ph-1-0.c         | 19 +++++++++++++++--
 .../qcom/camss/camss-csiphy-3ph-1-0.c         | 17 ++++++++++++++-
 .../media/platform/qcom/camss/camss-csiphy.c  | 21 +------------------
 .../media/platform/qcom/camss/camss-csiphy.h  |  7 +++++++
 8 files changed, 41 insertions(+), 90 deletions(-)

-- 
2.32.0

