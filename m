Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BFE55D142
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242992AbiF1EzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 00:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbiF1EzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 00:55:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC87460CE;
        Mon, 27 Jun 2022 21:55:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7145AB81C23;
        Tue, 28 Jun 2022 04:55:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE0FC341CB;
        Tue, 28 Jun 2022 04:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656392103;
        bh=fWMoJEv68QCW8726FLOtiruPS0Ls5wXGbOFCtxvsmOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QQ+BP5WQS7dwWcp0OuIIdct6N+Js1SMpWsLePIv1NJyvoBKKKHDBpfvd+mnCiorOF
         N3xHhDG8B1CSJSADhcUEJ1jrbQZ9VAkbjZFuKL3lJoFo36qJDdnCxX9SKPpKks5bWE
         vy+rPK7xpjkyuuriI7GpQ/bdXiiIzo4Xle25F8VxTVCZOWL5i4pLe9SYBT87Kn0/PZ
         NC0uBXugkCcQ8G3fm43rHHqBcvHswuNwNNaRWjvHGJ9wh08hVkLCA3n41N+f0YfWgs
         OAkc197ZAnYk8XEjLUNq5JSpvDGBO61O2y4zDOPR4aWqHFxenE/2A2RzNTvdej86IT
         EXazR6VXQR67A==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] arm64: defconfig: Enable qcom interconnect drivers
Date:   Tue, 28 Jun 2022 10:24:54 +0530
Message-Id: <20220628045454.621175-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220628045454.621175-1-vkoul@kernel.org>
References: <20220628045454.621175-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While enabling QCS404 interconnect driver, I found that other drivers
are missing too, so add all the interconnect driver

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---

Changes in v2:
	- Drop msm8974

 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6d3f4d8d50b8..7bbbdd00c590 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1249,7 +1249,10 @@ CONFIG_INTERCONNECT_IMX8MN=m
 CONFIG_INTERCONNECT_IMX8MQ=m
 CONFIG_INTERCONNECT_QCOM=y
 CONFIG_INTERCONNECT_QCOM_MSM8916=m
+CONFIG_INTERCONNECT_QCOM_MSM8996=m
 CONFIG_INTERCONNECT_QCOM_OSM_L3=m
+CONFIG_INTERCONNECT_QCOM_QCS404=m
+CONFIG_INTERCONNECT_QCOM_SC7180=m
 CONFIG_INTERCONNECT_QCOM_SC7280=y
 CONFIG_INTERCONNECT_QCOM_SDM845=y
 CONFIG_INTERCONNECT_QCOM_SM8150=m
-- 
2.34.1

