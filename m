Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA11953E344
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiFFGu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 02:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiFFGuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 02:50:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB58A63C4;
        Sun,  5 Jun 2022 23:50:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64E0F610F4;
        Mon,  6 Jun 2022 06:50:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4269EC34119;
        Mon,  6 Jun 2022 06:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654498243;
        bh=cF0Jahiln0ierEzNlgR2FvgNfh9i11FkD6kpcLiYiZ0=;
        h=From:To:Cc:Subject:Date:From;
        b=YuRJA/Z+uJoUaytU5DPV377z8Y+IhZwtcrjNgryn3vW4cDfoTKhKyiodsKSpAvO5H
         7jYbDZYSO6cpSoPaQYCQXgCPL8rtyVIOC6yK8x3t/e7PZUhwyeTMHGhb/LC4QnL7as
         x3QFEU/xPxImrRuwKRqYssEQEpgtjClHUHGv++zYzA7D1u5sg/iXL5R1g4qs6zbQ5j
         G3oE2uR5XcpwcA7QbFVlZ0Mgua71XWPvhKBJhOGmzC7anc8w9suwb2G9tluFexvcoI
         8M7HnjRJ1smFTiqzqIs5kihQQtMVEhnlb6TMtlv1lUONG0uBhLnkL/HIBABchK6QUK
         jV1Xuju/BhY3Q==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] arm64: dts: qcom: Get rid of some warnings
Date:   Mon,  6 Jun 2022 12:20:32 +0530
Message-Id: <20220606065035.553533-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Changes in v3:
 - rebase on v5.19-rc1

Changes in v2:
 - drop the sound and dsi node changes

*** SUBJECT HERE ***

*** BLURB HERE ***

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

