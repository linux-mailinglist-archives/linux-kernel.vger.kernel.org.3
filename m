Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833AC5AE17C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 09:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238835AbiIFHqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 03:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238185AbiIFHqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:46:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EB312754;
        Tue,  6 Sep 2022 00:46:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38195B815A0;
        Tue,  6 Sep 2022 07:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE923C433B5;
        Tue,  6 Sep 2022 07:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662450375;
        bh=1INHvqeK85ps1g5DBBfkxSa6I7TVe6Yq7FvQSkqeHNE=;
        h=From:To:Cc:Subject:Date:From;
        b=j8ziZAD18HgYhQJDmuhOF9Cu8b0atn5J21dxWYEBSf9uh7Gs1B2KkUmKAcztHqFPO
         cGC1GtLnU4XwoMhwGa0V5hGteXxGUrUzoGl7jAOGYjL5LgplYkMQpZ7sNCT5pkdHZo
         d5JC9Vwt9T246ppqyF5dANCH+XphH1UZNcKV5KiJ8QgVWKwOw2+cArI03+HPlnGCVk
         RL/HbzyJVWsSTozDdUo3ZDnd+a3ytbnhnn8CVdJmVnKRwalAQSCuJ1Zwz0hJN3m9Cs
         VEpengbIBTrO8Oo4WHOWL/ZPM/JMlWMc/CyaOTawyQRO7tZPQVDiQxR6aygRPoObrm
         HcM2EhlxP5cyQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oVTHl-00019E-PA; Tue, 06 Sep 2022 09:46:18 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/3] phy: qcom-qmp-pcie: shorten function prefixes
Date:   Tue,  6 Sep 2022 09:45:47 +0200
Message-Id: <20220906074550.4383-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QMP PHY driver function prefixes have become unnecessarily long
(e.g. after the recent driver split) and hurt readability.

This series shortens the "qcom_qmp_phy_pcie" prefix to "qmp_pcie" (QMP
likely stands for "Qualcomm Multi PHY" or similar anyway) and clean up
the code somewhat.

Once merged I can do the same conversion of the other four QMP drivers.

Johan



Dmitry Baryshkov (1):
  phy: qcom-qmp-pcie: drop if (table) conditions

Johan Hovold (2):
  phy: qcom-qmp-pcie: shorten function prefixes
  phy: qcom-qmp: drop dual-lane comments

 drivers/phy/qualcomm/phy-qcom-qmp-combo.c |   1 -
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c  | 145 ++++++++++------------
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c   |   1 -
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c   |   1 -
 4 files changed, 63 insertions(+), 85 deletions(-)

-- 
2.35.1

