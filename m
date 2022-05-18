Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C19052B5D9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbiERJUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbiERJUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:20:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2881498E8;
        Wed, 18 May 2022 02:20:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A468AB81ED3;
        Wed, 18 May 2022 09:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4BBC385A5;
        Wed, 18 May 2022 09:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652865608;
        bh=0t6SMB1Xktem8MdU6E9KKQszbXEmNS/HpyG/ycWIqUM=;
        h=From:To:Cc:Subject:Date:From;
        b=KM7+9MxTTiClKyDLyWQ7srLpkcdgxvy3/gm2UnLx0uRmAvLIIFULwefXXClIdjlKw
         zMIrk9jXOcXSB5wlcUTqHjAifFK+xPlh59p+KU5/p7geydYj29KJmPIREZFX5zeHVp
         vUwrGBqoWSzKueUx6Lgs+z7XUSs77FLOgw3UqctDILAazV0/ubiJoigwCFLKEesvwI
         l/IhRgn+9yaycnMyEZQQ9xesq3sZ0yt/0Z2tgbeyn4d8/3qCcH5C/OF86efW1k7JIX
         Og5DWT+8Tv2drNtFVVIl/RRF41myy6sBFeTROwEwyrfjSRkrzSWcUVa5O1W+Oe8iiR
         3wQiR1FfDmJTA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] arm64: dts: qcom: Get rid of some warnings
Date:   Wed, 18 May 2022 14:49:58 +0530
Message-Id: <20220518092001.2262024-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This attempts to make W=1 free from warnings for all SM* dts files.

Bunch of these are releated to node not having valid unit address and being
present under soc node. So moving it out fixed that. Interconnect node was
simple rename to remove unit address which was not really valid for these
nodes.

Changes in v2:
 - drop the sound and dsi node changes

Vinod Koul (3):
  arm64: dts: qcom: sm8450: rename interconnect nodes
  arm64: dts: qcom: sm8350: Move qup-opp-tables out of soc node
  arm64: dts: qcom: sm8250: Move qup-opp-table out of soc node

 arch/arm64/boot/dts/qcom/sm8250.dtsi | 38 +++++++-------
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 76 ++++++++++++++--------------
 arch/arm64/boot/dts/qcom/sm8450.dtsi |  4 +-
 3 files changed, 59 insertions(+), 59 deletions(-)

-- 
2.34.1

