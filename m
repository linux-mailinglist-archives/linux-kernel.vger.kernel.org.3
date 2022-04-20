Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BE3508C15
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380209AbiDTP25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379306AbiDTP2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:28:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D9445784;
        Wed, 20 Apr 2022 08:25:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E2F4B81F91;
        Wed, 20 Apr 2022 15:25:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9552C385AE;
        Wed, 20 Apr 2022 15:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650468346;
        bh=ZxzLUWHxnezX1TGZ93jFGJL3H82CW3GKO5E/VGDJcxY=;
        h=From:To:Cc:Subject:Date:From;
        b=cbYZnUcsGb2X/YnDkiMwESY3AF9ooLeHzdEah6Xw+l6uM2FdFXI1s4KrUFKkK8bDA
         VYkw8BQUSfSxmLyuq34N1qIS94en+vprtvi+mctoVdvatBula8fQsoeDM01NctWWR5
         C9rYqeOef0+3CR8oFhCRlPYyl/TH5XB+mPqUThDLs8ziQUmvJvhnize0o4u6a0T6T7
         KQjfHs+IdlOF8LZuFIN+shwkjUmHx9rCfTXAs7sjOSfMrplYstJ834/mg3+fjoLWUH
         uhqcUdx/a7htMe607cVK37VV15uQoAGui08zSEAr2ziwYKHVgyDzyForr1+NTFoCOv
         dPRE0jSfZwtiw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1nhCD5-0001SY-5T; Wed, 20 Apr 2022 17:25:39 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/2] phy: qcom-qmp: pipe clock fixes
Date:   Wed, 20 Apr 2022 17:23:29 +0200
Message-Id: <20220420152331.5527-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes a kernel doc typo and pipe clock imbalance on PHY
power on failures.

Johan


Johan Hovold (2):
  phy: qcom-qmp: fix phy-descriptor kernel-doc typo
  phy: qcom-qmp: fix pipe-clock imbalance on power-on failure

 drivers/phy/qualcomm/phy-qcom-qmp.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

-- 
2.35.1

