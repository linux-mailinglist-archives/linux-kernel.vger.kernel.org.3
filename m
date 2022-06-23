Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546815578C3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 13:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbiFWLdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 07:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiFWLdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 07:33:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CF318B2F;
        Thu, 23 Jun 2022 04:33:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5A8360E7F;
        Thu, 23 Jun 2022 11:33:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451BBC341C0;
        Thu, 23 Jun 2022 11:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655984019;
        bh=4EDHfLFPyMm+mvSkkeJIautqlPxXEeD7CW/b/RawN68=;
        h=From:To:Cc:Subject:Date:From;
        b=OexC5FuUH9H5meCvL8nxn4EjKfDCkYacvBWDoo2093yLe7Z9RCyZmGKfIgk2FaJj5
         3iGXxxBf3NHtc3UaEJBdHlvDwjgPvm9Fn2ZGP7jvDYpfpp2EY3vQJjLomTN2/NneXO
         JvJoN6WMR/uZkjpHYMGk+Op1aRxVuwNi9/EYsAGtjP2vOUmXxL9qRCKSKA731ul+sE
         d2oA9q0uLDb107GNDvNN4R14QjRZOtmFsJRxHYN9gh6EhPaYABPRbUB0YBhKX992/9
         tfOjDS1HLrzkk6MKM5zs+BvnC9btBQX6ug3CxedrCy+i3HROCU/d+nJIWMGE+PKhBF
         f+GnPZFj6+oag==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o4L5b-0007kJ-RP; Thu, 23 Jun 2022 13:33:36 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/3] phy: qcom-qmp: pipe clock cleanups
Date:   Thu, 23 Jun 2022 13:33:11 +0200
Message-Id: <20220623113314.29761-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some follow-up cleanups after the recent driver split.

Johan

Johan Hovold (3):
  phy: qcom-qmp-pcie: drop obsolete pipe clock type check
  phy: qcom-qmp-pcie-msm8996: drop obsolete pipe clock type check
  phy: qcom-qmp-usb: clean up pipe clock handling

 .../phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c  | 19 ++-----------------
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 19 ++-----------------
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c       | 15 ++-------------
 3 files changed, 6 insertions(+), 47 deletions(-)

-- 
2.35.1

