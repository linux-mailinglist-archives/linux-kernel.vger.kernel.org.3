Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CBF5B0282
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiIGLIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiIGLH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:07:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E927A4048;
        Wed,  7 Sep 2022 04:07:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A13AB81C50;
        Wed,  7 Sep 2022 11:07:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EED2C4FEBA;
        Wed,  7 Sep 2022 11:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662548869;
        bh=R/PhWywYtgEKJuMR5zOLfk52NFVBKuOa/xjsqShlLAk=;
        h=From:To:Cc:Subject:Date:From;
        b=kjlhADsS4zS55Ga17a5df6axQz+lgRtS1Ei1laYjWSxZs5seXLUxZTTwAwasXiP9b
         Mdo+fbMeFwY0hpQGPsZs0dSnOeCQbijejuZ0BKWbMLdJWItEn9XtX5HBFLaZZPGwAJ
         GRzCUBJALrgRTwva/6wAASBY4VCzclbLZSrDO1DT6MnNC7JifgZUAw+D454OprWqcw
         CUQotlV0Y2uRtbOISrFjtfekIPrfvUaH+ztDf4FET/C1nPinGmRCjf/cjYpVcqV5z3
         q1jstqU4mDRN+hVIVH9EEaO34I23yOHfxL6VbAKDYrLdBml4OOkdzN9rFSYkwBwaN0
         YECHUDRqGXJsw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oVsuO-0004yk-0J; Wed, 07 Sep 2022 13:07:52 +0200
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
Subject: [PATCH 00/16] phy: qcom-qmp: further clean ups
Date:   Wed,  7 Sep 2022 13:07:12 +0200
Message-Id: <20220907110728.19092-1-johan+linaro@kernel.org>
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

This series clean up the QMP PHY drivers somewhat after the recent
driver split.

Included are also some fixes for runtime PM not being disabled on driver
unbind.

Note that these apply on top of the qmp-pcie series posted yesterday:

	https://lore.kernel.org/all/20220906074550.4383-1-johan+linaro@kernel.org/

Johan


Johan Hovold (16):
  phy: qcom-qmp-combo: disable runtime PM on unbind
  phy: qcom-qmp-combo: drop unused defines
  phy: qcom-qmp-pcie: drop unused runtime PM implementation
  phy: qcom-qmp-pcie: drop unused defines
  phy: qcom-qmp-pcie-msm8996: drop unused runtime PM implementation
  phy: qcom-qmp-pcie-msm8996: drop unused defines
  phy: qcom-qmp-ufs: drop unused runtime PM implementation
  phy: qcom-qmp-ufs: drop unused defines
  phy: qcom-qmp-usb: disable runtime PM on unbind
  phy: qcom-qmp-usb: drop unused defines
  phy: qcom-qmp: silence noisy probe
  phy: qcom-qmp-combo: shorten function prefixes
  phy: qcom-qmp-pcie-msm8996: drop unused secondary init tables
  phy: qcom-qmp-pcie-msm8996: shorten function prefixes
  phy: qcom-qmp-ufs: shorten function prefixes
  phy: qcom-qmp-usb: shorten function prefixes

 drivers/phy/qualcomm/phy-qcom-qmp-combo.c     | 189 ++++++++---------
 .../phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c  | 191 +++++-------------
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      |  64 ------
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c       | 163 ++++-----------
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c       | 143 ++++++-------
 5 files changed, 238 insertions(+), 512 deletions(-)

-- 
2.35.1

